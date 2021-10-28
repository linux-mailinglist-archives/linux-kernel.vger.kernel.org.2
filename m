Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BBFCE43E88B
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Oct 2021 20:41:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230505AbhJ1Snb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Oct 2021 14:43:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230380AbhJ1Sn3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Oct 2021 14:43:29 -0400
Received: from mail-yb1-xb2e.google.com (mail-yb1-xb2e.google.com [IPv6:2607:f8b0:4864:20::b2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4984C061570
        for <linux-kernel@vger.kernel.org>; Thu, 28 Oct 2021 11:41:01 -0700 (PDT)
Received: by mail-yb1-xb2e.google.com with SMTP id 131so6139596ybc.7
        for <linux-kernel@vger.kernel.org>; Thu, 28 Oct 2021 11:41:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=U6hI4QUgyE2eFqGR1tRgs9ayNRlgsskzXHlchXAdB2g=;
        b=lZWgvDCv1CJD+W7u2YU/u9zSaI1ddrKl8GY1ChLNEQCV3IT7cYI+bPKS6yz5lJi0De
         R1iH0eAwjKmN99YnNfLK5JF1i51IKFGtdytLKl/ggXr+82O7kUiG0cKdtGXOQpbT57Yj
         skMa2Sli6rTHq0jFfdZO2BXN543N6lOY1fqI+4KxSSuFFuFqg/T16rGiQnFQkXAdZ5mF
         Cd1/D2iVSSoQKT1t9/0TeY+auqQvFFWQd80pT3fAEW1T+C15CE/3N9dPlSecLnp3Lezj
         YLAFaHEEARpBE5dZAGMpxnexQ7jwKTBJz+ZGLIjp5ZihScuBc1/kPzWze+mX3s1RZt6E
         ptBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=U6hI4QUgyE2eFqGR1tRgs9ayNRlgsskzXHlchXAdB2g=;
        b=OX3ISI3E5DNzmc7ZEMq2hVEHoWtWam5I9gCzF4L5Hj7dk+jmLFc3usiTXwdeTosUAB
         9GOceLzMwjHK4WluGMke7ob7KVHPrWdBhccWaS/H/i5cog4eRalana+SXXpL1xQoX5BT
         aM7ipqFwy9sT1YtFl2smnCiy92W5KDhlNstPZd/9drRpuXSpIC38tFOi6wC58imz+cDC
         ZOgo4Vi0kb76nAjKtl53TCLXBUwJteKwYmVucDbkaEQPN0Y+bzfIIe8/xeBlmfbRMem+
         Yoi/XkpVVyXIV0BFVTIzoy+OMcA5WTTRjBIPW++Jsh9GmkK/Wgt8TKg1R/f/5vamEJgU
         Jufw==
X-Gm-Message-State: AOAM532xAk/1Pu/16osQMRr+pvOlhOCCyMNR0hq5lSdSZSUh06Fj89DY
        Za3nxSOjce2keOWvLDRZ4XCZR5h47i98OPH3RGDC+g==
X-Google-Smtp-Source: ABdhPJwhle1+VYAuOAeoY+R8+v8PMmi3ITn2fM/eF7pVouM03UKR4EPnPRSw6t9ZP2APlrrrqpQLi5XUuIHU2uOysoc=
X-Received: by 2002:a25:c5c5:: with SMTP id v188mr6417772ybe.34.1635446460719;
 Thu, 28 Oct 2021 11:41:00 -0700 (PDT)
MIME-Version: 1.0
References: <1633701982-22302-1-git-send-email-charante@codeaurora.org>
In-Reply-To: <1633701982-22302-1-git-send-email-charante@codeaurora.org>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Thu, 28 Oct 2021 11:40:49 -0700
Message-ID: <CAJuCfpEikFP8sifts8-p7zviJSW7A=Tff5ve2Wc6PZEWAP9OXA@mail.gmail.com>
Subject: Re: [PATCH] mm: shmem: implement POSIX_FADV_[WILL|DONT]NEED for shmem
To:     Charan Teja Reddy <charante@codeaurora.org>
Cc:     hughd@google.com, akpm@linux-foundation.org, vbabka@suse.cz,
        rientjes@google.com, david@redhat.com, mhocko@suse.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 8, 2021 at 7:07 AM Charan Teja Reddy
<charante@codeaurora.org> wrote:
>
> Currently fadvise(2) is supported only for the files that doesn't
> associated with noop_backing_dev_info thus for the files, like shmem,
> fadvise results into NOP. But then there is file_operations->fadvise()
> that lets the file systems to implement their own fadvise
> implementation. Use this support to implement some of the POSIX_FADV_XXX
> functionality for shmem files.
>
> This patch aims to implement POSIX_FADV_WILLNEED and POSIX_FADV_DONTNEED
> advices to shmem files which can be helpful for the drivers who may want
> to manage the shmem pages of the files that are created through
> shmem_file_setup[_with_mnt]().  An example usecase may be like, driver
> can create the shmem file of the size equal to its requirements and
> map the pages for DMA and then pass the fd to user. The user who knows
> well about the usage of these pages can now decide when these pages are
> not required push them to swap through DONTNEED thus free up memory well
> in advance rather than relying on the reclaim and use WILLNEED when it
> decide that they are useful in the near future. IOW, it lets the clients
> to free up/read the memory when it wants to. Another usecase is that GEM
> objets which are currenlty allocated and managed through shmem files can
> use vfs_fadvise(DONT|WILLNEED) on shmem fd when the driver comes to
> know(like through some hints from user space) that GEM objects are not
> going to use/will need in the near future.

Sounds useful.
You should probably add a documentation section for manual pages.

>
> Signed-off-by: Charan Teja Reddy <charante@codeaurora.org>
> ---
>  mm/shmem.c | 139 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 139 insertions(+)
>
> diff --git a/mm/shmem.c b/mm/shmem.c
> index 70d9ce2..ab7ea33 100644
> --- a/mm/shmem.c
> +++ b/mm/shmem.c
> @@ -38,6 +38,8 @@
>  #include <linux/hugetlb.h>
>  #include <linux/frontswap.h>
>  #include <linux/fs_parser.h>
> +#include <linux/mm_inline.h>
> +#include <linux/fadvise.h>
>
>  #include <asm/tlbflush.h> /* for arch/microblaze update_mmu_cache() */
>
> @@ -2792,6 +2794,142 @@ static long shmem_fallocate(struct file *file, int mode, loff_t offset,
>         return error;
>  }
>
> +static int shmem_fadvise_dontneed(struct address_space *mapping, loff_t start,
> +                               loff_t end)
> +{
> +       int ret;
> +       struct writeback_control wbc = {
> +               .sync_mode = WB_SYNC_NONE,
> +               .nr_to_write = LONG_MAX,
> +               .range_start = 0,
> +               .range_end = LLONG_MAX,
> +               .for_reclaim = 1,
> +       };
> +       struct page *page;
> +
> +       XA_STATE(xas, &mapping->i_pages, start);

XA_STATE is a variable definition, so I think the empty line should be
moved down here.

> +       if (!shmem_mapping(mapping))
> +               return -EINVAL;
> +
> +       if (!total_swap_pages)
> +               return 0;
> +
> +       lru_add_drain();
> +
> +       rcu_read_lock();
> +       xas_for_each(&xas, page, end) {
> +               if (xas_retry(&xas, page))
> +                       continue;
> +               if (xa_is_value(page))
> +                       continue;
> +               if (isolate_lru_page(page))
> +                       continue;

isolate_lru_page comment says that it "Must be called with an elevated
refcount on the page". Are you ensuring that?
Also not sure if you need to isolate the page before this writeback.

> +
> +               inc_node_page_state(page, NR_ISOLATED_ANON +
> +                                               page_is_file_lru(page));
> +               lock_page(page);
> +               ClearPageDirty(page);

I see that other places use clear_page_dirty_for_io() to clear the
dirty flag before writepage(), don't you need it here?

> +               SetPageReclaim(page);
> +               ret = shmem_writepage(page, &wbc);
> +               if (!PageWriteback(page))
> +                       ClearPageReclaim(page);
> +               if (ret) {
> +                       unlock_page(page);
> +                       putback_lru_page(page);
> +                       dec_node_page_state(page, NR_ISOLATED_ANON +
> +                                               page_is_file_lru(page));
> +                       continue;
> +               }
> +
> +               /*
> +                * shmem_writepage() place the page in the swapcache.
> +                * Delete the page from the swapcache and release the
> +                * page.

Won't deleting the page from swap cache interfere with ongoing
writeback if it has not yet completed?

> +                */
> +               lock_page(page);

You have the page already locked, the above seems extra.

> +               delete_from_swap_cache(page);
> +               unlock_page(page);
> +               dec_node_page_state(page, NR_ISOLATED_ANON +
> +                                               page_is_file_lru(page));
> +               put_page(page);
> +               if (need_resched()) {
> +                       xas_pause(&xas);
> +                       cond_resched_rcu();
> +               }
> +       }
> +       rcu_read_unlock();
> +
> +       return 0;
> +}
> +
> +static int shmem_fadvise_willneed(struct address_space *mapping,
> +                                pgoff_t start, pgoff_t long end)
> +{
> +       struct page *page;
> +
> +       XA_STATE(xas, &mapping->i_pages, start);

Empty line should be moved here.

> +       rcu_read_lock();
> +       xas_for_each(&xas, page, end) {
> +               if (!xa_is_value(page))
> +                       continue;
> +               page = shmem_read_mapping_page(mapping, xas.xa_index);
> +               if (!IS_ERR(page))
> +                       put_page(page);
> +
> +               if (need_resched()) {
> +                       xas_pause(&xas);
> +                       cond_resched_rcu();
> +               }
> +       }
> +       rcu_read_unlock();
> +
> +       return 0;
> +}
> +
> +static int shmem_fadvise(struct file *file, loff_t offset, loff_t len, int advice)
> +{
> +       loff_t endbyte;
> +       pgoff_t start_index;
> +       pgoff_t end_index;
> +       struct address_space *mapping;
> +       int ret = 0;
> +
> +       mapping = file->f_mapping;
> +       if (!mapping || len < 0)
> +               return -EINVAL;
> +
> +       endbyte = (u64)offset + (u64)len;

Why are these typecasts needed? All involved vars seem to be of the
same loff_t type. Are you worried about overflow after addition? If so
why not just:

if (offset + len < 0) return -EINVAL;


> +       if (!len || endbyte < len)
> +               endbyte = -1;
> +       else
> +               endbyte--;

You already checked that len is not negative. You could simply add:

if (!len) return 0;

> +
> +
> +       start_index = offset >> PAGE_SHIFT;
> +       end_index   = endbyte >> PAGE_SHIFT;
> +       switch (advice) {
> +       case POSIX_FADV_DONTNEED:
> +               ret = shmem_fadvise_dontneed(mapping, start_index, end_index);
> +               break;
> +       case POSIX_FADV_WILLNEED:
> +               ret = shmem_fadvise_willneed(mapping, start_index, end_index);
> +               break;
> +       case POSIX_FADV_NORMAL:
> +       case POSIX_FADV_RANDOM:
> +       case POSIX_FADV_SEQUENTIAL:
> +       case POSIX_FADV_NOREUSE:
> +               /*
> +                * No bad return value, but ignore advice. May have to
> +                * implement in future.
> +                */

Returning ENOSYS might be better here IMHO. When some of these options
are implemented, the userspace will be able to detect if the kernel
supports it by checking for that error code. If you return 0 in both
cases such detection will be impossible.

> +               break;
> +       default:
> +               return -EINVAL;
> +       }
> +
> +       return ret;
> +}
> +
>  static int shmem_statfs(struct dentry *dentry, struct kstatfs *buf)
>  {
>         struct shmem_sb_info *sbinfo = SHMEM_SB(dentry->d_sb);
> @@ -3799,6 +3937,7 @@ static const struct file_operations shmem_file_operations = {
>         .splice_write   = iter_file_splice_write,
>         .fallocate      = shmem_fallocate,
>  #endif
> +       .fadvise        = shmem_fadvise,
>  };
>
>  static const struct inode_operations shmem_inode_operations = {
> --
> QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a
> member of the Code Aurora Forum, hosted by The Linux Foundation
>
>
