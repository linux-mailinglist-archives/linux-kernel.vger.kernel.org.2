Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D43941B3AB
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Sep 2021 18:20:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241769AbhI1QWH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Sep 2021 12:22:07 -0400
Received: from out30-43.freemail.mail.aliyun.com ([115.124.30.43]:59398 "EHLO
        out30-43.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S241755AbhI1QWF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Sep 2021 12:22:05 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R101e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04395;MF=rongwei.wang@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0UpxbQ2i_1632846023;
Received: from 30.30.67.189(mailfrom:rongwei.wang@linux.alibaba.com fp:SMTPD_---0UpxbQ2i_1632846023)
          by smtp.aliyun-inc.com(127.0.0.1);
          Wed, 29 Sep 2021 00:20:24 +0800
Content-Type: multipart/mixed; boundary="------------gsvJybHFweo94iGjbSJjNOSO"
Message-ID: <68737431-01d2-e6e3-5131-7d7c731e49ae@linux.alibaba.com>
Date:   Wed, 29 Sep 2021 00:20:22 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:93.0)
 Gecko/20100101 Thunderbird/93.0
Subject: Re: [PATCH v2 1/2] mm, thp: check page mapping when truncating page
 cache
Content-Language: en-US
To:     Song Liu <song@kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        Linux MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        William Kucharski <william.kucharski@oracle.com>,
        Hugh Dickins <hughd@google.com>
References: <20210906121200.57905-1-rongwei.wang@linux.alibaba.com>
 <20210922070645.47345-2-rongwei.wang@linux.alibaba.com>
 <YUsVcEDcQ2vEzjGg@casper.infradead.org>
 <BC145393-93AC-4DF4-9CF4-2FB1C736B70C@linux.alibaba.com>
 <20210923194343.ca0f29e1c4d361170343a6f2@linux-foundation.org>
 <9e41661d-9919-d556-8c49-610dae157553@linux.alibaba.com>
 <CAPhsuW4cP4qV2c_wXP89-2fa+mALv-uEe+Qdqr_MD3Ptw03Wng@mail.gmail.com>
From:   Rongwei Wang <rongwei.wang@linux.alibaba.com>
In-Reply-To: <CAPhsuW4cP4qV2c_wXP89-2fa+mALv-uEe+Qdqr_MD3Ptw03Wng@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------gsvJybHFweo94iGjbSJjNOSO
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 9/28/21 6:24 AM, Song Liu wrote:
> On Fri, Sep 24, 2021 at 12:12 AM Rongwei Wang
> <rongwei.wang@linux.alibaba.com> wrote:
>>
>>
>>
>> On 9/24/21 10:43 AM, Andrew Morton wrote:
>>> On Thu, 23 Sep 2021 01:04:54 +0800 Rongwei Wang <rongwei.wang@linux.alibaba.com> wrote:
>>>
>>>>
>>>>
>>>>> On Sep 22, 2021, at 7:37 PM, Matthew Wilcox <willy@infradead.org> wrote:
>>>>>
>>>>> On Wed, Sep 22, 2021 at 03:06:44PM +0800, Rongwei Wang wrote:
>>>>>> Transparent huge page has supported read-only non-shmem files. The file-
>>>>>> backed THP is collapsed by khugepaged and truncated when written (for
>>>>>> shared libraries).
>>>>>>
>>>>>> However, there is race in two possible places.
>>>>>>
>>>>>> 1) multiple writers truncate the same page cache concurrently;
>>>>>> 2) collapse_file rolls back when writer truncates the page cache;
>>>>>
>>>>> As I've said before, the bug here is that somehow there is a writable fd
>>>>> to a file with THPs.  That's what we need to track down and fix.
>>>> Hi, Matthew
>>>> I am not sure get your means. We know “mm, thp: relax the VM_DENYWRITE constraint on file-backed THPs"
>>>> Introduced file-backed THPs for DSO. It is possible {very rarely} for DSO to be opened in writeable way.
>>>>
>>>> ...
>>>>
>>>>> https://lore.kernel.org/linux-mm/YUdL3lFLFHzC80Wt@casper.infradead.org/
>>>> All in all, what you mean is that we should solve this race at the source?
>>>
>>> Matthew is being pretty clear here: we shouldn't be permitting
>>> userspace to get a writeable fd for a thp-backed file.
>>>
>>> Why are we permitting the DSO to be opened writeably?  If there's a
>>> legitimate case for doing this then presumably "mm, thp: relax the
>> There is a use case to stress file-backed THP within attachment.
>> I test this case in a system which has enabled CONFIG_READ_ONLY_THP_FOR_FS:
>>
>> $ gcc -Wall -g -o stress_madvise_dso stress_madvise_dso.c
>> $ ulimit -s unlimited
>> $ ./stress_madvise_dso 10000 <libtest.so>
>>
>> the meaning of above parameters:
>> 10000: the max test time;
>> <libtest.so>: the DSO that will been mapped into file-backed THP by
>> madvise. It recommended that the text segment of DSO to be tested is
>> greater than 2M.
>>
>> The crash will been triggered at once in the latest kernel. And this
>> case also can used to trigger the bug that mentioned in our another patch.
> 
> Hmm.. I am not able to use the repro program to crash the system. Not
> sure what I did wrong.
> 
Hi
I have tried to check my test case again. Can you make sure the DSO that 
you test have THP mapping?

If you are willing to try again, I can send my libtest.c which is used 
to test by myself (actually, it shouldn't be target DSO problem).

Thanks very much!
> OTOH, does it make sense to block writes within khugepaged, like:
> 
> diff --git i/mm/khugepaged.c w/mm/khugepaged.c
> index 045cc579f724e..ad7c41ec15027 100644
> --- i/mm/khugepaged.c
> +++ w/mm/khugepaged.c
> @@ -51,6 +51,7 @@ enum scan_result {
>          SCAN_CGROUP_CHARGE_FAIL,
>          SCAN_TRUNCATED,
>          SCAN_PAGE_HAS_PRIVATE,
> +       SCAN_BUSY_WRITE,
>   };
> 
>   #define CREATE_TRACE_POINTS
> @@ -1652,6 +1653,11 @@ static void collapse_file(struct mm_struct *mm,
>          /* Only allocate from the target node */
>          gfp = alloc_hugepage_khugepaged_gfpmask() | __GFP_THISNODE;
> 
> +       if (deny_write_access(file)) {
> +               result = SCAN_BUSY_WRITE;
> +               return;
> +       }
> +
This can indeed avoid some possible races from source.

But, I am thinking about whether this will lead to DDoS attack?
I remember the reason of DSO has ignored MAP_DENYWRITE in kernel
is that DDoS attack. In addition, 'deny_write_access' will change
the behavior, such as user will get 'Text file busy' during 
collapse_file. I am not sure whether the behavior changing is acceptable 
in user space.

If it is acceptable, I am very willing to fix the races like your way.

Thanks!
>          new_page = khugepaged_alloc_page(hpage, gfp, node);
>          if (!new_page) {
>                  result = SCAN_ALLOC_HUGE_PAGE_FAIL;
> @@ -1863,19 +1869,6 @@ static void collapse_file(struct mm_struct *mm,
>          else {
>                  __mod_lruvec_page_state(new_page, NR_FILE_THPS, nr);
>                  filemap_nr_thps_inc(mapping);
> -               /*
> -                * Paired with smp_mb() in do_dentry_open() to ensure
> -                * i_writecount is up to date and the update to nr_thps is
> -                * visible. Ensures the page cache will be truncated if the
> -                * file is opened writable.
> -                */
> -               smp_mb();
> -               if (inode_is_open_for_write(mapping->host)) {
> -                       result = SCAN_FAIL;
> -                       __mod_lruvec_page_state(new_page, NR_FILE_THPS, -nr);
> -                       filemap_nr_thps_dec(mapping);
> -                       goto xa_locked;
> -               }
>          }
> 
>          if (nr_none) {
> @@ -1976,6 +1969,7 @@ static void collapse_file(struct mm_struct *mm,
>          VM_BUG_ON(!list_empty(&pagelist));
>          if (!IS_ERR_OR_NULL(*hpage))
>                  mem_cgroup_uncharge(*hpage);
> +       allow_write_access(file);
>          /* TODO: tracepoints */
>   }
> 
--------------gsvJybHFweo94iGjbSJjNOSO
Content-Type: text/plain; charset=UTF-8; name="libtest.c"
Content-Disposition: attachment; filename="libtest.c"
Content-Transfer-Encoding: base64

I2lmbmRlZiBfREVGQVVMVF9TT1VSQ0UKI2RlZmluZSBfREVGQVVMVF9TT1VSQ0UKI2VuZGlm
CgojaW5jbHVkZSA8ZmNudGwuaD4KI2luY2x1ZGUgPHN0ZGlvLmg+CiNpbmNsdWRlIDxzdGRs
aWIuaD4KI2luY2x1ZGUgPHN0cmluZy5oPgojaW5jbHVkZSA8c3lzL21tYW4uaD4KI2luY2x1
ZGUgPHVuaXN0ZC5oPgoKLyogInZvbGF0aWxlIiB0byBmb3JiaWQgY29tcGlsZXIgb3B0aW1p
emF0aW9uICovCnZvbGF0aWxlIHN0YXRpYyBpbnQgeDsKCiNkZWZpbmUgRE9fMCArK3g7CiNk
ZWZpbmUgRE9fMSB7RE9fMDsgRE9fMDsgRE9fMDsgRE9fMDsgRE9fMDsgRE9fMDsgRE9fMDsg
RE9fMDsgRE9fMH0KI2RlZmluZSBET18yIHtET18xOyBET18xOyBET18xOyBET18xOyBET18x
OyBET18xOyBET18xOyBET18xOyBET18xfQojZGVmaW5lIERPXzMge0RPXzI7IERPXzI7IERP
XzI7IERPXzI7IERPXzI7IERPXzI7IERPXzI7IERPXzI7IERPXzJ9CiNkZWZpbmUgRE9fNCB7
RE9fMzsgRE9fMzsgRE9fMzsgRE9fMzsgRE9fMzsgRE9fMzsgRE9fMzsgRE9fMzsgRE9fM30K
I2RlZmluZSBET181IHtET180OyBET180OyBET180OyBET180OyBET180OyBET180OyBET180
OyBET180OyBET180fQojZGVmaW5lIERPXzYge0RPXzU7IERPXzU7IERPXzU7IERPXzU7IERP
XzU7IERPXzU7IERPXzU7IERPXzU7IERPXzV9CiNkZWZpbmUgRE9fNyB7RE9fNjsgRE9fNjsg
RE9fNjsgRE9fNjsgRE9fNjsgRE9fNjsgRE9fNjsgRE9fNjsgRE9fNn0KCnZvaWQgbGlidGVz
dF93b3JrMSh2b2lkKQp7CglwcmludGYoIndvcmsgMVxuIik7CglET18wOwp9Cgp2b2lkIGxp
YnRlc3Rfd29yazIodm9pZCkKewoJcHJpbnRmKCJ3b3JrIDJcbiIpOwoJRE9fMjsKfQoKdm9p
ZCBsaWJ0ZXN0X3dvcmszKHZvaWQpCnsKCXByaW50Zigid29yayAzXG4iKTsKCURPXzQ7Cn0K
CnZvaWQgbGlidGVzdF93b3JrNCh2b2lkKQp7CglwcmludGYoIndvcmsgNFxuIik7CglET182
Owp9Cg==
--------------gsvJybHFweo94iGjbSJjNOSO--

