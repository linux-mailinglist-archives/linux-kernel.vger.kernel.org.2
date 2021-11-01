Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 86112441CC3
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Nov 2021 15:40:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231366AbhKAOmx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Nov 2021 10:42:53 -0400
Received: from so254-9.mailgun.net ([198.61.254.9]:47900 "EHLO
        so254-9.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229826AbhKAOmw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Nov 2021 10:42:52 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1635777619; h=Content-Transfer-Encoding: Content-Type:
 In-Reply-To: MIME-Version: Date: Message-ID: From: References: Cc: To:
 Subject: Sender; bh=C/9l0l+bsQ3aOCVRAQc8spGQpD1F6yKurtX4dVqjyJ4=; b=dIJp9q5v/DHEC4gMcrXS6/qy/qvIycbLZHNPSmCR8wj2eIEc69k2rfTWj6iz1Dp4XyFlKgRq
 bzv8EWZ2IoHr/g4ixZaceUm8PutXHwhFkmKiWcR8ekZauouaVV8rwLigPLMWJSys5qms8k7R
 y9VV7He2SsLXTi2S+fD3LHXGX8g=
X-Mailgun-Sending-Ip: 198.61.254.9
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n03.prod.us-west-2.postgun.com with SMTP id
 617ffc51aeb23905564a78a0 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Mon, 01 Nov 2021 14:40:17
 GMT
Sender: charante=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id E5CFAC4361B; Mon,  1 Nov 2021 14:40:16 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        NICE_REPLY_A,SPF_FAIL,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
        version=3.4.0
Received: from [192.168.29.110] (unknown [49.37.159.117])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: charante)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 68AF1C4338F;
        Mon,  1 Nov 2021 14:40:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 smtp.codeaurora.org 68AF1C4338F
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=codeaurora.org
Subject: Re: [PATCH] mm: shmem: implement POSIX_FADV_[WILL|DONT]NEED for shmem
To:     Suren Baghdasaryan <surenb@google.com>
Cc:     hughd@google.com, akpm@linux-foundation.org, vbabka@suse.cz,
        rientjes@google.com, david@redhat.com, mhocko@suse.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        kirill.shutemov@linux.intel.com, rppt@linux.vnet.ibm.com
References: <1633701982-22302-1-git-send-email-charante@codeaurora.org>
 <CAJuCfpEikFP8sifts8-p7zviJSW7A=Tff5ve2Wc6PZEWAP9OXA@mail.gmail.com>
From:   Charan Teja Kalla <charante@codeaurora.org>
Message-ID: <442feb78-a1f0-581a-84de-5d33baa5a7f5@codeaurora.org>
Date:   Mon, 1 Nov 2021 20:10:08 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <CAJuCfpEikFP8sifts8-p7zviJSW7A=Tff5ve2Wc6PZEWAP9OXA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks for your comments Suren.

On 10/29/2021 12:10 AM, Suren Baghdasaryan wrote:
> On Fri, Oct 8, 2021 at 7:07 AM Charan Teja Reddy
> <charante@codeaurora.org> wrote:
>>
>> Currently fadvise(2) is supported only for the files that doesn't
>> associated with noop_backing_dev_info thus for the files, like shmem,
>> fadvise results into NOP. But then there is file_operations->fadvise()
>> that lets the file systems to implement their own fadvise
>> implementation. Use this support to implement some of the POSIX_FADV_XXX
>> functionality for shmem files.
>>
>> This patch aims to implement POSIX_FADV_WILLNEED and POSIX_FADV_DONTNEED
>> advices to shmem files which can be helpful for the drivers who may want
>> to manage the shmem pages of the files that are created through
>> shmem_file_setup[_with_mnt]().  An example usecase may be like, driver
>> can create the shmem file of the size equal to its requirements and
>> map the pages for DMA and then pass the fd to user. The user who knows
>> well about the usage of these pages can now decide when these pages are
>> not required push them to swap through DONTNEED thus free up memory well
>> in advance rather than relying on the reclaim and use WILLNEED when it
>> decide that they are useful in the near future. IOW, it lets the clients
>> to free up/read the memory when it wants to. Another usecase is that GEM
>> objets which are currenlty allocated and managed through shmem files can
>> use vfs_fadvise(DONT|WILLNEED) on shmem fd when the driver comes to
>> know(like through some hints from user space) that GEM objects are not
>> going to use/will need in the near future.
> 
> Sounds useful.
> You should probably add a documentation section for manual pages.

Sure. Will add them.

> 
>>
>> Signed-off-by: Charan Teja Reddy <charante@codeaurora.org>
>> ---
>>  mm/shmem.c | 139 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
>>  1 file changed, 139 insertions(+)
>>
>> diff --git a/mm/shmem.c b/mm/shmem.c
>> index 70d9ce2..ab7ea33 100644
>> --- a/mm/shmem.c
>> +++ b/mm/shmem.c
>> @@ -38,6 +38,8 @@
>>  #include <linux/hugetlb.h>
>>  #include <linux/frontswap.h>
>>  #include <linux/fs_parser.h>
>> +#include <linux/mm_inline.h>
>> +#include <linux/fadvise.h>
>>
>>  #include <asm/tlbflush.h> /* for arch/microblaze update_mmu_cache() */
>>
>> @@ -2792,6 +2794,142 @@ static long shmem_fallocate(struct file *file, int mode, loff_t offset,
>>         return error;
>>  }
>>
>> +static int shmem_fadvise_dontneed(struct address_space *mapping, loff_t start,
>> +                               loff_t end)
>> +{
>> +       int ret;
>> +       struct writeback_control wbc = {
>> +               .sync_mode = WB_SYNC_NONE,
>> +               .nr_to_write = LONG_MAX,
>> +               .range_start = 0,
>> +               .range_end = LLONG_MAX,
>> +               .for_reclaim = 1,
>> +       };
>> +       struct page *page;
>> +
>> +       XA_STATE(xas, &mapping->i_pages, start);
> 
> XA_STATE is a variable definition, so I think the empty line should be
> moved down here.

Done.

> 
>> +       if (!shmem_mapping(mapping))
>> +               return -EINVAL;
>> +
>> +       if (!total_swap_pages)
>> +               return 0;
>> +
>> +       lru_add_drain();
>> +
>> +       rcu_read_lock();
>> +       xas_for_each(&xas, page, end) {
>> +               if (xas_retry(&xas, page))
>> +                       continue;
>> +               if (xa_is_value(page))
>> +                       continue;
>> +               if (isolate_lru_page(page))
>> +                       continue;
> 
> isolate_lru_page comment says that it "Must be called with an elevated
> refcount on the page". Are you ensuring that?

Agree here. Will update it accordingly.

> Also not sure if you need to isolate the page before this writeback.

Isolation may not be required but this is to avoid trying of the reclaim
on the same page in some parallel path as both any way places the page
in the swap. Or you want me to remove the isolation here?
> 
>> +
>> +               inc_node_page_state(page, NR_ISOLATED_ANON +
>> +                                               page_is_file_lru(page));
>> +               lock_page(page);
>> +               ClearPageDirty(page);
> 
> I see that other places use clear_page_dirty_for_io() to clear the
> dirty flag before writepage(), don't you need it here?

I think I need to do it here. Will update it in V2.
> 
>> +               SetPageReclaim(page);
>> +               ret = shmem_writepage(page, &wbc);
>> +               if (!PageWriteback(page))
>> +                       ClearPageReclaim(page);
>> +               if (ret) {
>> +                       unlock_page(page);
>> +                       putback_lru_page(page);
>> +                       dec_node_page_state(page, NR_ISOLATED_ANON +
>> +                                               page_is_file_lru(page));
>> +                       continue;
>> +               }
>> +
>> +               /*
>> +                * shmem_writepage() place the page in the swapcache.
>> +                * Delete the page from the swapcache and release the
>> +                * page.
> 
> Won't deleting the page from swap cache interfere with ongoing
> writeback if it has not yet completed?

I just followed the path of how to reclaim the page:
shrink_page_list()
     pageout()
     ..........
     __remove_mapping()
        __delete_from_swap_cache()

You see some issue here which I can't understand.


> 
>> +                */
>> +               lock_page(page);
> 
> You have the page already locked, the above seems extra.

I think shmem_writepage unlocks the page If the page write is successful.

> 
>> +               delete_from_swap_cache(page);
>> +               unlock_page(page);
>> +               dec_node_page_state(page, NR_ISOLATED_ANON +
>> +                                               page_is_file_lru(page));
>> +               put_page(page);
>> +               if (need_resched()) {
>> +                       xas_pause(&xas);
>> +                       cond_resched_rcu();
>> +               }
>> +       }
>> +       rcu_read_unlock();
>> +
>> +       return 0;
>> +}
>> +
>> +static int shmem_fadvise_willneed(struct address_space *mapping,
>> +                                pgoff_t start, pgoff_t long end)
>> +{
>> +       struct page *page;
>> +
>> +       XA_STATE(xas, &mapping->i_pages, start);
> 
> Empty line should be moved here.

Done.

> 
>> +       rcu_read_lock();
>> +       xas_for_each(&xas, page, end) {
>> +               if (!xa_is_value(page))
>> +                       continue;
>> +               page = shmem_read_mapping_page(mapping, xas.xa_index);
>> +               if (!IS_ERR(page))
>> +                       put_page(page);
>> +
>> +               if (need_resched()) {
>> +                       xas_pause(&xas);
>> +                       cond_resched_rcu();
>> +               }
>> +       }
>> +       rcu_read_unlock();
>> +
>> +       return 0;
>> +}
>> +
>> +static int shmem_fadvise(struct file *file, loff_t offset, loff_t len, int advice)
>> +{
>> +       loff_t endbyte;
>> +       pgoff_t start_index;
>> +       pgoff_t end_index;
>> +       struct address_space *mapping;
>> +       int ret = 0;
>> +
>> +       mapping = file->f_mapping;
>> +       if (!mapping || len < 0)
>> +               return -EINVAL;
>> +
>> +       endbyte = (u64)offset + (u64)len;
> 
> Why are these typecasts needed? All involved vars seem to be of the
> same loff_t type. Are you worried about overflow after addition? If so
> why not just:
> 
> if (offset + len < 0) return -EINVAL;
> 
> 
>> +       if (!len || endbyte < len)
>> +               endbyte = -1;
>> +       else
>> +               endbyte--;
> 
> You already checked that len is not negative. You could simply add:
> 
> if (!len) return 0;

I just followed the logic mentioned in mm/fadvise.c
@https://elixir.bootlin.com/linux/v5.15/source/mm/fadvise.c#L68

	/*
	 * Careful about overflows. Len == 0 means "as much as possible".  Use
	 * unsigned math because signed overflows are undefined and UBSan
	 * complains.
	 */
	endbyte = (u64)offset + (u64)len;
	if (!len || endbyte < len)
		endbyte = -1;
	else
		endbyte--;		/* inclusive */

> 
>> +
>> +
>> +       start_index = offset >> PAGE_SHIFT;
>> +       end_index   = endbyte >> PAGE_SHIFT;
>> +       switch (advice) {
>> +       case POSIX_FADV_DONTNEED:
>> +               ret = shmem_fadvise_dontneed(mapping, start_index, end_index);
>> +               break;
>> +       case POSIX_FADV_WILLNEED:
>> +               ret = shmem_fadvise_willneed(mapping, start_index, end_index);
>> +               break;
>> +       case POSIX_FADV_NORMAL:
>> +       case POSIX_FADV_RANDOM:
>> +       case POSIX_FADV_SEQUENTIAL:
>> +       case POSIX_FADV_NOREUSE:
>> +               /*
>> +                * No bad return value, but ignore advice. May have to
>> +                * implement in future.
>> +                */
> 
> Returning ENOSYS might be better here IMHO. When some of these options
> are implemented, the userspace will be able to detect if the kernel
> supports it by checking for that error code. If you return 0 in both
> cases such detection will be impossible.
> 
>> +               break;

Just followed what is mentioned @
https://elixir.bootlin.com/linux/v5.15/source/mm/fadvise.c#L61.


>> +       default:
>> +               return -EINVAL;
>> +       }
>> +
>> +       return ret;
>> +}
>> +
>>  static int shmem_statfs(struct dentry *dentry, struct kstatfs *buf)
>>  {
>>         struct shmem_sb_info *sbinfo = SHMEM_SB(dentry->d_sb);
>> @@ -3799,6 +3937,7 @@ static const struct file_operations shmem_file_operations = {
>>         .splice_write   = iter_file_splice_write,
>>         .fallocate      = shmem_fallocate,
>>  #endif
>> +       .fadvise        = shmem_fadvise,
>>  };
>>
>>  static const struct inode_operations shmem_inode_operations = {
>> --
>> QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a
>> member of the Code Aurora Forum, hosted by The Linux Foundation
>>
>>

-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora
Forum, a Linux Foundation Collaborative Project
