Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 48D593F0288
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Aug 2021 13:20:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235483AbhHRLV0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Aug 2021 07:21:26 -0400
Received: from out30-57.freemail.mail.aliyun.com ([115.124.30.57]:45576 "EHLO
        out30-57.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234913AbhHRLVW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Aug 2021 07:21:22 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R121e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04400;MF=joseph.qi@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0UjhxFsf_1629285645;
Received: from B-D1K7ML85-0059.local(mailfrom:joseph.qi@linux.alibaba.com fp:SMTPD_---0UjhxFsf_1629285645)
          by smtp.aliyun-inc.com(127.0.0.1);
          Wed, 18 Aug 2021 19:20:46 +0800
Subject: Re: [PATCH] ocfs2: reflink deadlock when clone file to the same
 directory simultaneously
To:     Gang He <ghe@suse.com>, mark@fasheh.com, jlbec@evilplan.org,
        Wengang Wang <wen.gang.wang@oracle.com>
Cc:     linux-kernel@vger.kernel.org, ocfs2-devel@oss.oracle.com,
        akpm@linux-foundation.org
References: <20210729110230.18983-1-ghe@suse.com>
 <5821fd0f-2018-dc1b-a5c0-f948a7debff4@linux.alibaba.com>
 <c7e1f0a7-e75c-d1e0-870d-dc480d070079@suse.com>
 <71608a14-58f4-dba0-d695-fee65de89192@linux.alibaba.com>
 <801438f5-655a-c708-aa25-343d54a2f11e@suse.com>
From:   Joseph Qi <joseph.qi@linux.alibaba.com>
Message-ID: <86e3d724-3147-ccaa-998f-0f857c575f7e@linux.alibaba.com>
Date:   Wed, 18 Aug 2021 19:20:45 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <801438f5-655a-c708-aa25-343d54a2f11e@suse.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8/18/21 5:20 PM, Gang He wrote:
> 
> 
> On 2021/8/13 17:54, Joseph Qi wrote:
>>
>>
>> On 8/9/21 6:08 PM, Gang He wrote:
>>> Hi Joseph and All,
>>>
>>> The deadlock is caused by self-locking on one node.
>>> There is three node cluster (mounted to /mnt/shared), the user run reflink command to clone the file to the same directory repeatedly,
>>> e.g.
>>>   reflink "/mnt/shared/test" \
>>>   "/mnt/shared/.snapshots/test.`date +%m%d%H%M%S`.`hostname`"
>>>
>>> After a while, the reflink process on each node is hung, the file system cannot be listed.
>>> The problematic reflink command process is blocked by itself, e.g. the reflink process is hung at ghe-sle15sp2-nd2,
>>> kernel: task:reflink         state:D stack:    0 pid:16992 ppid:  4530
>>> kernel: Call Trace:
>>> kernel:  __schedule+0x2fd/0x750
>>> kernel:  ? try_to_wake_up+0x17b/0x4e0
>>> kernel:  schedule+0x2f/0xa0
>>> kernel:  schedule_timeout+0x1cc/0x310
>>> kernel:  ? __wake_up_common+0x74/0x120
>>> kernel:  wait_for_completion+0xba/0x140
>>> kernel:  ? wake_up_q+0xa0/0xa0
>>> kernel:  __ocfs2_cluster_lock.isra.41+0x3b5/0x820 [ocfs2]
>>> kernel:  ? ocfs2_inode_lock_full_nested+0x1fc/0x960 [ocfs2]
>>> kernel:  ocfs2_inode_lock_full_nested+0x1fc/0x960 [ocfs2]
>>> kernel:  ocfs2_init_security_and_acl+0xbe/0x1d0 [ocfs2]
>>> kernel:  ocfs2_reflink+0x436/0x4c0 [ocfs2]
>>> kernel:  ? ocfs2_reflink_ioctl+0x2ca/0x360 [ocfs2]
>>> kernel:  ocfs2_reflink_ioctl+0x2ca/0x360 [ocfs2]
>>> kernel:  ocfs2_ioctl+0x25e/0x670 [ocfs2]
>>> kernel:  do_vfs_ioctl+0xa0/0x680
>>> kernel:  ksys_ioctl+0x70/0x80
>>>
>>> In fact, the destination directory(.snapshots) inode dlm lock was acquired by ghe-sle15sp2-nd2, next there is bast message from other nodes to ask ghe-sle15sp2-nd2 downconvert lock, but the operation failed, the kernel message is printed like,
>>> kernel: (ocfs2dc-AA35DD9,2560,3):ocfs2_downconvert_lock:3660 ERROR: DLM error -16 while calling ocfs2_dlm_lock on resource M0000000000000000046e0200000000
>>> kernel: (ocfs2dc-AA35DD9,2560,3):ocfs2_unblock_lock:3904 ERROR: status = -16
>>> kernel: (ocfs2dc-AA35DD9,2560,3):ocfs2_process_blocked_lock:4303 ERROR: status = -16
>>>
>>> Then, the reflink process tries to acquire this directory inode dlm lock, the process is blocked, the dlm lock resource in memory looks like
>>>
>>>      l_name = "M0000000000000000046e0200000000",
>>>      l_ro_holders = 0,
>>>      l_ex_holders = 0,
>>>      l_level = 5 '\005',
>>>      l_requested = 0 '\000',
>>>      l_blocking = 5 '\005',
>>>      l_type = 0 '\000',
>>>      l_action = 0 '\000',
>>>      l_unlock_action = 0 '\000',
>>>      l_pending_gen = 645948,
>>>
>>>
>>> So far, I do not know what makes dlm lock function failed, it also looks we do not handle this failure case in dlmglue layer, but I always reproduce this hang with my test script, e.g.
>>>
>>>    loop=1
>>>    while ((loop++)) ; do
>>>          for i in `seq 1 100`; do
>>>            reflink "/mnt/shared/test" "/mnt/shared/.snapshots /test.${loop}.${i}.`date +%m%d%H%M%S`.`hostname`"
>>>          done
>>>          usleep 500000
>>>          rm -f /mnt/shared/.snapshots/testnode1.qcow2.*.`hostname`
>>>    done
>>>
>>> My patch changes multiple acquiring dest directory inode dlm lock during in ocfs2_reflink function, it avoids the hang issue happen again.The code change also can improve reflink performance in this case.
>>>
>>> Thanks
>>> Gang
>>
>> 'status = -16' implies DLM_CANCELGRANT.
>> Do you use stack user instead of o2cb? If yes, can you try o2cb with
>> your reproducer?
> 
> I setup o2cb based ocfs2 clusters with sle15sp2 and oracleLinux8u4.
> After two day testing with the same script, I did not encounter dlm_lock downconvert failure, the hang issue did not happen.
> After my patch was applied, there was not any side effect, the reflink performance was doubled in the case.
> 

Do you mean the hang only happens on stack user?
IMO, we'd better directly fix the stack user hang first, and then optimize
reflink performance.

Thanks,
Joseph
