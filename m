Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1CBBC3AFB18
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jun 2021 04:34:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231357AbhFVCfC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Jun 2021 22:35:02 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:1242 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S230495AbhFVCfA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jun 2021 22:35:00 -0400
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 15M23fUB001225;
        Mon, 21 Jun 2021 22:32:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=UFayZbd9WlmTDZiFZqDnGH3n+msIlPrhjA53xrOdM8w=;
 b=JovEFKAbphiLlsbT9D40tIKu7u4hincNvvDL0bKlgC8OoJxzDfLPXmOoXC8qVxSNECdO
 vphZQi9/rBNfSJNTslZh7TZicTtpuRA/jlBaRUdt8kLcAXDkrQRL3gV2Ngqy3QyQyrM7
 2nk1TXzcf0PXMbwgBNjlqVwtk/s6JiXyHdCcAQSrX7sHfRi2kpegnfIA7gfS+WaJAiFA
 LIJ4aFOk6xYuLnzaIpb0gwx/y1RknAHDTruYGPJbPINj1lMX4u92IDq1PHxmulh44qoy
 qcdkejdEI0DdGGbUp0alc2wtHxVjfmYxu6LJjFuL0ZdkXTbiuOc2wfcqKtSol58MN/0Z kw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 39b25j6y0w-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 21 Jun 2021 22:32:35 -0400
Received: from m0098420.ppops.net (m0098420.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 15M24j17013000;
        Mon, 21 Jun 2021 22:32:35 -0400
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0b-001b2d01.pphosted.com with ESMTP id 39b25j6y0d-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 21 Jun 2021 22:32:35 -0400
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 15M2HcCn005242;
        Tue, 22 Jun 2021 02:32:33 GMT
Received: from b06cxnps4074.portsmouth.uk.ibm.com (d06relay11.portsmouth.uk.ibm.com [9.149.109.196])
        by ppma03ams.nl.ibm.com with ESMTP id 39987895x3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 22 Jun 2021 02:32:33 +0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 15M2WVwE35586446
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 22 Jun 2021 02:32:31 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 063C94C046;
        Tue, 22 Jun 2021 02:32:31 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 954444C044;
        Tue, 22 Jun 2021 02:32:29 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com (unknown [9.160.3.166])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue, 22 Jun 2021 02:32:29 +0000 (GMT)
Message-ID: <23ba225593be391c384109af527bd0f3cb122a0d.camel@linux.ibm.com>
Subject: Re: [syzbot] possible deadlock in ovl_maybe_copy_up
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Hillf Danton <hdanton@sina.com>
Cc:     Amir Goldstein <amir73il@gmail.com>,
        syzbot <syzbot+c18f2f6a7b08c51e3025@syzkaller.appspotmail.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>
Date:   Mon, 21 Jun 2021 22:32:28 -0400
In-Reply-To: <20210618040135.950-1-hdanton@sina.com>
References: <000000000000c5b77105b4c3546e@google.com>
         <000000000000df47be05bf165394@google.com>
         <20210618040135.950-1-hdanton@sina.com>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-16.el8) 
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: l1mX-gFlBAwI6bueINRDax1gSeUZ7Sr8
X-Proofpoint-ORIG-GUID: 5l9Py41iJhIxh_Zd5SZomjbWYoecmhf-
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-06-21_14:2021-06-21,2021-06-21 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 suspectscore=0
 phishscore=0 mlxlogscore=999 clxscore=1011 bulkscore=0 adultscore=0
 malwarescore=0 mlxscore=0 impostorscore=0 priorityscore=1501
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2106220011
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2021-06-18 at 12:01 +0800, Hillf Danton wrote:
> On Sun, 4 Apr 2021 11:10:48 +0300 Amir Goldstein wrote:
> >On Sat, Apr 3, 2021 at 10:18 PM syzbot wrote:
> >>
> >> syzbot has found a reproducer for the following issue on:
> >>
> >> HEAD commit:    454c576c Add linux-next specific files for 20210401
> >> git tree:       linux-next
> >> console output: https://syzkaller.appspot.com/x/log.txt?x=1616e07ed00000
> >> kernel config:  https://syzkaller.appspot.com/x/.config?x=920cc274cae812a5
> >> dashboard link: https://syzkaller.appspot.com/bug?extid=c18f2f6a7b08c51e3025
> >> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=13da365ed00000
> >> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=13ca9d16d00000
> >>
> >> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> >> Reported-by: syzbot+c18f2f6a7b08c51e3025@syzkaller.appspotmail.com
> >>
> >> ======================================================
> >> WARNING: possible circular locking dependency detected
> >> 5.12.0-rc5-next-20210401-syzkaller #0 Not tainted
> >> ------------------------------------------------------
> >> syz-executor144/9166 is trying to acquire lock:
> >> ffff888144cf0460 (sb_writers#5){.+.+}-{0:0}, at: ovl_maybe_copy_up+0x11f/0x190 fs/overlayfs/copy_up.c:995
> >>
> >> but task is already holding lock:
> >> ffff8880256d42c0 (&iint->mutex){+.+.}-{3:3}, at: process_measurement+0x3a8/0x17e0 security/integrity/ima/ima_main.c:253
> >>
> >> which lock already depends on the new lock.
> >>
> >>
> >> the existing dependency chain (in reverse order) is:
> >>
> >> -> #1 (&iint->mutex){+.+.}-{3:3}:
> >>        __mutex_lock_common kernel/locking/mutex.c:949 [inline]
> >>        __mutex_lock+0x139/0x1120 kernel/locking/mutex.c:1096
> >>        process_measurement+0x3a8/0x17e0 security/integrity/ima/ima_main.c:253
> >>        ima_file_check+0xb9/0x100 security/integrity/ima/ima_main.c:499
> >>        do_open fs/namei.c:3361 [inline]
> >>        path_openat+0x15b5/0x27e0 fs/namei.c:3492
> >>        do_filp_open+0x17e/0x3c0 fs/namei.c:3519
> >>        do_sys_openat2+0x16d/0x420 fs/open.c:1187
> >>        do_sys_open fs/open.c:1203 [inline]
> >>        __do_sys_open fs/open.c:1211 [inline]
> >>        __se_sys_open fs/open.c:1207 [inline]
> >>        __x64_sys_open+0x119/0x1c0 fs/open.c:1207
> >>        do_syscall_64+0x2d/0x70 arch/x86/entry/common.c:46
> >>        entry_SYSCALL_64_after_hwframe+0x44/0xae
> >>
> >> -> #0 (sb_writers#5){.+.+}-{0:0}:
> >>        check_prev_add kernel/locking/lockdep.c:2938 [inline]
> >>        check_prevs_add kernel/locking/lockdep.c:3061 [inline]
> >>        validate_chain kernel/locking/lockdep.c:3676 [inline]
> >>        __lock_acquire+0x2a17/0x5230 kernel/locking/lockdep.c:4902
> >>        lock_acquire kernel/locking/lockdep.c:5512 [inline]
> >>        lock_acquire+0x1ab/0x740 kernel/locking/lockdep.c:5477
> >>        percpu_down_read include/linux/percpu-rwsem.h:51 [inline]
> >>        __sb_start_write include/linux/fs.h:1758 [inline]
> >>        sb_start_write include/linux/fs.h:1828 [inline]
> >>        mnt_want_write+0x6e/0x3e0 fs/namespace.c:375
> >>        ovl_maybe_copy_up+0x11f/0x190 fs/overlayfs/copy_up.c:995
> >>        ovl_open+0xba/0x270 fs/overlayfs/file.c:149
> >>        do_dentry_open+0x4b9/0x11b0 fs/open.c:826
> >>        vfs_open fs/open.c:940 [inline]
> >>        dentry_open+0x132/0x1d0 fs/open.c:956
> >>        ima_calc_file_hash+0x2d2/0x4b0 security/integrity/ima/ima_crypto.c:557
> >>        ima_collect_measurement+0x4ca/0x570 security/integrity/ima/ima_api.c:252
> >>        process_measurement+0xd1c/0x17e0 security/integrity/ima/ima_main.c:330
> >>        ima_file_check+0xb9/0x100 security/integrity/ima/ima_main.c:499
> >>        do_open fs/namei.c:3361 [inline]
> >>        path_openat+0x15b5/0x27e0 fs/namei.c:3492
> >>        do_filp_open+0x17e/0x3c0 fs/namei.c:3519
> >>        do_sys_openat2+0x16d/0x420 fs/open.c:1187
> >>        do_sys_open fs/open.c:1203 [inline]
> >>        __do_sys_open fs/open.c:1211 [inline]
> >>        __se_sys_open fs/open.c:1207 [inline]
> >>        __x64_sys_open+0x119/0x1c0 fs/open.c:1207
> >>        do_syscall_64+0x2d/0x70 arch/x86/entry/common.c:46
> >>        entry_SYSCALL_64_after_hwframe+0x44/0xae
> >>
> >> other info that might help us debug this:
> >>
> >>  Possible unsafe locking scenario:
> >>
> >>        CPU0                    CPU1
> >>        ----                    ----
> >>   lock(&iint->mutex);
> >>                                lock(sb_writers#5);
> >>                                lock(&iint->mutex);
> >>   lock(sb_writers#5);
> >>
> >>  *** DEADLOCK ***
> >>
> >> 1 lock held by syz-executor144/9166:
> >>  #0: ffff8880256d42c0 (&iint->mutex){+.+.}-{3:3}, at: process_measurement+0x3a8/0x17e0 security/integrity/ima/ima_main.c:253
> >>
> 
> It is reported again.
>   https://lore.kernel.org/lkml/00000000000067d24205c4d0e599@google.com/
> >
> >It's a false positive lockdep warning due to missing annotation of
> >stacking layer on iint->mutex in IMA code.
> 
> Add it by copying what's created for ovl, see below.
> >
> >To fix it properly, iint->mutex, which can be taken in any of the
> >stacking fs layers, should be annotated with stacking depth like
> >ovl_lockdep_annotate_inode_mutex_key()
> >
> >I think it's the same root cause as:
> >https://syzkaller.appspot.com/bug?extid=18a1619cceea30ed45af
> >https://syzkaller.appspot.com/bug?extid=ae82084b07d0297e566b
> >
> >I think both of the above were marked "fixed" by a paper over.
> >The latter was marked "fixed" by "ovl: detect overlapping layers"
> >but if you look at the repro, the fact that 'workdir' overlaps with
> >'lowerdir' has nothing to do with the lockdep warning, so said
> >"fix" just papered over the IMA lockdep warning.
> >
> >Thanks,
> >Amir.
> 
> +++ x/security/integrity/iint.c
> @@ -85,6 +85,45 @@ static void iint_free(struct integrity_i
>  	kmem_cache_free(iint_cache, iint);
>  }
>  
> +/*
> + * a copy from ovl_lockdep_annotate_inode_mutex_key() in a bit to fix
> +
> +   Possible unsafe locking scenario:
> +
> +	CPU0                    CPU1
> +       ----                    ----
> +     lock(&iint->mutex);
> +                               lock(sb_writers#5);
> +                               lock(&iint->mutex);
> +     lock(sb_writers#5);
> +
> +     *** DEADLOCK ***
> +
> +It's a false positive lockdep warning due to missing annotation of
> +stacking layer on iint->mutex in IMA code. [1]
> +
> +[1] https://lore.kernel.org/linux-unionfs/CAOQ4uxjk4XYuwz5HCmN-Ge=Ld=tM1f7ZxVrd5U1AC2Wisc9MTA@mail.gmail.com/
> +*/
> +static void iint_annotate_mutex_key(struct integrity_iint_cache *iint,
> +					struct inode *inode)
> +{
> +#ifdef CONFIG_LOCKDEP
> +	static struct lock_class_key
> +		iint_mutex_key[FILESYSTEM_MAX_STACK_DEPTH],
> +		iint_mutex_dir_key[FILESYSTEM_MAX_STACK_DEPTH];
> +
> +	int depth = inode->i_sb->s_stack_depth - 1;
> +
> +	if (WARN_ON_ONCE(depth < 0 || depth >= FILESYSTEM_MAX_STACK_DEPTH))
> +		depth = 0;
> +
> +	if (S_ISDIR(inode->i_mode))
> +		lockdep_set_class(&iint->mutex, &iint_mutex_dir_key[depth]);
> +	else
> +		lockdep_set_class(&iint->mutex, &iint_mutex_key[depth]);
> +#endif
> +}

The iint cache is only for regular files.

> +
>  /**
>   * integrity_inode_get - find or allocate an iint associated with an inode
>   * @inode: pointer to the inode
> @@ -113,6 +152,7 @@ struct integrity_iint_cache *integrity_i
>  	iint = kmem_cache_alloc(iint_cache, GFP_NOFS);
>  	if (!iint)
>  		return NULL;
> +	iint_annotate_mutex_key(iint, inode);
>  
>  	write_lock(&integrity_iint_lock);

Should annotating the iint be limited to files on overlay filesystems?

thanks,

Mimi


