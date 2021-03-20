Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A45C3429FD
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Mar 2021 03:24:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229748AbhCTCXs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Mar 2021 22:23:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229512AbhCTCXW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Mar 2021 22:23:22 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61E68C061760
        for <linux-kernel@vger.kernel.org>; Fri, 19 Mar 2021 19:23:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:Content-Type:MIME-Version:
        References:Message-ID:In-Reply-To:Subject:cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=wj/7sjssUgRzClcYqzCH8vi9+9EXBqElQkDuXEG1/54=; b=To7oF426QdWtlGCixGcSEOgMPZ
        1J7edJACcji0TDK7sKMOE6jodVrpAqDUOrrXRnvbuyNQTd/FwuYEUMRfPbR57+gYmBYfc/5KrE2RP
        uPt0KjhLirqHxfKw38kLDalENJVmZLR27d0tTMR+djoikDTpqg4faqc/g14ZlXHSUJJoYge+X9ofB
        803ESoiM533jrmXp9tM85sTDOflRYPGC43DBRXqDalUlXHzM3PazCvaZrSh4vs74eEcgTNLE5CG6H
        XYPS92RhnhxtJV3Cxgx8ZI3teeqCxiQIwSSPV+wWqAjsRLVkX8JIBTMsjjc020SfUlQa4roLTaw38
        HSuAWW3Q==;
Received: from rdunlap (helo=localhost)
        by bombadil.infradead.org with local-esmtp (Exim 4.94 #2 (Red Hat Linux))
        id 1lNRGl-001epL-1Y; Sat, 20 Mar 2021 02:23:16 +0000
Date:   Fri, 19 Mar 2021 19:23:15 -0700 (PDT)
From:   Randy Dunlap <rdunlap@bombadil.infradead.org>
To:     Bhaskar Chowdhury <unixbhaskar@gmail.com>
cc:     akpm@linux-foundation.org, rppt@kernel.org, peterz@infradead.org,
        tsbogend@alpha.franken.de, maobibo@loongson.cn,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH V2] mm: Few spelling fixes
In-Reply-To: <20210318201404.6380-1-unixbhaskar@gmail.com>
Message-ID: <85e47de9-3651-b670-5828-ba863f46574f@bombadil.infradead.org>
References: <20210318201404.6380-1-unixbhaskar@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
Sender: Randy Dunlap <rdunlap@infradead.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210319_192315_110247_E824175E 
X-CRM114-Status: GOOD (  21.66  )
X-Spam-Score: -0.0 (/)
X-Spam-Report: Spam detection software, running on the system "bombadil.infradead.org",
 has NOT identified this incoming email as spam.  The original
 message has been attached to this so you can view it or label
 similar future email.  If you have any questions, see
 the administrator of that system for details.
 Content preview:  On Fri, 19 Mar 2021, Bhaskar Chowdhury wrote: > Few spelling
    fixes throughout the file. > > Signed-off-by: Bhaskar Chowdhury <unixbhaskar@gmail.com>
    Acked-by: Randy Dunlap <rdunlap@infradead.org> 
 Content analysis details:   (-0.0 points, 5.0 required)
  pts rule name              description
 ---- ---------------------- --------------------------------------------------
 -0.0 NO_RELAYS              Informational: message was not relayed via SMTP
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 19 Mar 2021, Bhaskar Chowdhury wrote:

> Few spelling fixes throughout the file.
>
> Signed-off-by: Bhaskar Chowdhury <unixbhaskar@gmail.com>

Acked-by: Randy Dunlap <rdunlap@infradead.org>


> ---
> Changes from V1:
>  Mentioned suggestion incorporated.
>
> include/linux/pgtable.h | 10 +++++-----
> 1 file changed, 5 insertions(+), 5 deletions(-)
>
> diff --git a/include/linux/pgtable.h b/include/linux/pgtable.h
> index 5e772392a379..b58f20226bb9 100644
> --- a/include/linux/pgtable.h
> +++ b/include/linux/pgtable.h
> @@ -426,7 +426,7 @@ static inline void ptep_set_wrprotect(struct mm_struct *mm, unsigned long addres
>
> /*
>  * On some architectures hardware does not set page access bit when accessing
> - * memory page, it is responsibilty of software setting this bit. It brings
> + * memory page, it is responsibility of software setting this bit. It brings
>  * out extra page fault penalty to track page access bit. For optimization page
>  * access bit can be set during all page fault flow on these arches.
>  * To be differentiate with macro pte_mkyoung, this macro is used on platforms
> @@ -519,7 +519,7 @@ extern pgtable_t pgtable_trans_huge_withdraw(struct mm_struct *mm, pmd_t *pmdp);
> /*
>  * This is an implementation of pmdp_establish() that is only suitable for an
>  * architecture that doesn't have hardware dirty/accessed bits. In this case we
> - * can't race with CPU which sets these bits and non-atomic aproach is fine.
> + * can't race with CPU which sets these bits and non-atomic approach is fine.
>  */
> static inline pmd_t generic_pmdp_establish(struct vm_area_struct *vma,
> 		unsigned long address, pmd_t *pmdp, pmd_t pmd)
> @@ -852,7 +852,7 @@ static inline void __ptep_modify_prot_commit(struct vm_area_struct *vma,
>  * updates, but to prevent any updates it may make from being lost.
>  *
>  * This does not protect against other software modifications of the
> - * pte; the appropriate pte lock must be held over the transation.
> + * pte; the appropriate pte lock must be held over the transaction.
>  *
>  * Note that this interface is intended to be batchable, meaning that
>  * ptep_modify_prot_commit may not actually update the pte, but merely
> @@ -1269,13 +1269,13 @@ static inline int pmd_none_or_trans_huge_or_clear_bad(pmd_t *pmd)
> 	 *
> 	 * The complete check uses is_pmd_migration_entry() in linux/swapops.h
> 	 * But using that requires moving current function and pmd_trans_unstable()
> -	 * to linux/swapops.h to resovle dependency, which is too much code move.
> +	 * to linux/swapops.h to resolve dependency, which is too much code move.
> 	 *
> 	 * !pmd_present() is equivalent to is_pmd_migration_entry() currently,
> 	 * because !pmd_present() pages can only be under migration not swapped
> 	 * out.
> 	 *
> -	 * pmd_none() is preseved for future condition checks on pmd migration
> +	 * pmd_none() is preserved for future condition checks on pmd migration
> 	 * entries and not confusing with this function name, although it is
> 	 * redundant with !pmd_present().
> 	 */
> --
> 2.26.2
>
>
