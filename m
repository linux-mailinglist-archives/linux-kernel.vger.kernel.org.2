Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C9DA36856B
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Apr 2021 19:02:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238333AbhDVRCr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Apr 2021 13:02:47 -0400
Received: from mail.skyhub.de ([5.9.137.197]:56066 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236058AbhDVRCq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Apr 2021 13:02:46 -0400
Received: from zn.tnic (p200300ec2f0e2900329c23fffea6a903.dip0.t-ipconnect.de [IPv6:2003:ec:2f0e:2900:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id B8D4F1EC04D3;
        Thu, 22 Apr 2021 19:02:10 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1619110930;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=jkVWyLB1deuzzVbbl8oNuJ4nSdV2pted+GJ68GpNC24=;
        b=pUOwOhLD3iKj9nsyiecVOb/1wfzXYagFddJqIjtQL0tCBgypO7g9pzp+5ujpeUSiHqwotm
        YqlU7Tk6MM2ohfF0qgAWZIFPqox/hZ6nntwY/7kjfUUVVPZ5JJ7E7e4k0iS8PW2LYo6i4m
        PtFlDzq89Gf1mwFicoNZi73v/bxcges=
Date:   Thu, 22 Apr 2021 19:02:13 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Naoya Horiguchi <nao.horiguchi@gmail.com>
Cc:     linux-mm@kvack.org, Tony Luck <tony.luck@intel.com>,
        Aili Yao <yaoaili@kingsoft.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Oscar Salvador <osalvador@suse.de>,
        David Hildenbrand <david@redhat.com>,
        Andy Lutomirski <luto@kernel.org>,
        Naoya Horiguchi <naoya.horiguchi@nec.com>,
        Jue Wang <juew@google.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 3/3] mm,hwpoison: add kill_accessing_process() to find
 error virtual address
Message-ID: <20210422170213.GE7021@zn.tnic>
References: <20210421005728.1994268-1-nao.horiguchi@gmail.com>
 <20210421005728.1994268-4-nao.horiguchi@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210421005728.1994268-4-nao.horiguchi@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 21, 2021 at 09:57:28AM +0900, Naoya Horiguchi wrote:
> From: Naoya Horiguchi <naoya.horiguchi@nec.com>
> 
> The previous patch solves the infinite MCE loop issue when multiple

"previous patch" has no meaning when it is in git.

> MCE events races.  The remaining issue is to make sure that all threads

	    "race."

> processing Action Required MCEs send to the current processes the

s/the //

> SIGBUS with the proper virtual address and the error size.
> 
> This patch suggests to do page table walk to find the error virtual

Avoid having "This patch" or "This commit" in the commit message. It is
tautologically useless.

Also, do

$ git grep 'This patch' Documentation/process

for more details.

> address.  If we find multiple virtual addresses in walking, we now can't

Who's "we"?				during the pagetable walk

> determine which one is correct, so we fall back to sending SIGBUS in
> kill_me_maybe() without error info as we do now.  This corner case needs
> to be solved in the future.

Solved how? If you can't map which error comes from which process, you
can't do anything here. You could send SIGBUS to all but you might
injure some innocent bystanders this way.

Just code structuring suggestions below - mm stuff is for someone else
to review properly.

> +static int hwpoison_pte_range(pmd_t *pmdp, unsigned long addr,
> +			      unsigned long end, struct mm_walk *walk)
> +{
> +	struct hwp_walk *hwp = (struct hwp_walk *)walk->private;
> +	int ret = 0;
> +	pte_t *ptep;
> +	spinlock_t *ptl;
> +
> +	ptl = pmd_trans_huge_lock(pmdp, walk->vma);
> +	if (ptl) {

Save yourself an indentation level:

	if (!ptl)
		goto unlock;

> +		pmd_t pmd = *pmdp;
> +
> +		if (pmd_present(pmd)) {

... ditto...

> +			unsigned long pfn = pmd_pfn(pmd);
> +
> +			if (pfn <= hwp->pfn && hwp->pfn < pfn + HPAGE_PMD_NR) {
> +				unsigned long hwpoison_vaddr = addr +
> +					((hwp->pfn - pfn) << PAGE_SHIFT);

... which will allow you to not break those.

> +
> +				ret = set_to_kill(&hwp->tk, hwpoison_vaddr,
> +						  PAGE_SHIFT);
> +			}
> +		}
> +		spin_unlock(ptl);
> +		goto out;
> +	}
> +
> +	if (pmd_trans_unstable(pmdp))
> +		goto out;
> +
> +	ptep = pte_offset_map_lock(walk->vma->vm_mm, pmdp, addr, &ptl);
> +	for (; addr != end; ptep++, addr += PAGE_SIZE) {
> +		ret = check_hwpoisoned_entry(*ptep, addr, PAGE_SHIFT,
> +					     hwp->pfn, &hwp->tk);
> +		if (ret == 1)
> +			break;
> +	}
> +	pte_unmap_unlock(ptep - 1, ptl);
> +out:
> +	cond_resched();
> +	return ret;
> +}


-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
