Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6764A37A47B
	for <lists+linux-kernel@lfdr.de>; Tue, 11 May 2021 12:22:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231407AbhEKKYC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 May 2021 06:24:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:59034 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231177AbhEKKYB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 May 2021 06:24:01 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 458246192C
        for <linux-kernel@vger.kernel.org>; Tue, 11 May 2021 10:22:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620728575;
        bh=8K5/RKVsB4hbF+2S3xYY+Sls7rLDAQAlNlhNK+wAOxM=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=kfmrEf4UUPFdXmN4bONIkgTnNm+NvLIuA5PwA2CwaYTxb1dDjpb/EJj7jzf3G1lQD
         nIb8iuIIEgctX84nf+w+HM4ez8mJ8I2el3imHgPUbBrVOHBIYCSrUucrRCUYBIl5sR
         oj7JeBjGYixV3xnxSGHcew4MdO2AoktCyJG9i3pn4u1nluL9dFAELEUbHsASk0gW3n
         NYTY2RE4iLWxmPJ9fLRQxFO5luOuFnQa0bVAyXfp9XdxBSCMB/iragnXUtE0mnpeGU
         RnKVF8Y9kKxgCuDKNkB/rFZ2rYHoOR7Bniz1tPOY9GSnS5n+Of6gvZc4a0k4tcauPY
         lK2AvxnMfA6Sg==
Received: by mail-oi1-f179.google.com with SMTP id n184so18532849oia.12
        for <linux-kernel@vger.kernel.org>; Tue, 11 May 2021 03:22:55 -0700 (PDT)
X-Gm-Message-State: AOAM53275VwEGF5YJmDRPXScG44F4fop/rGa7bqJ1Q1v879JZJISX8zX
        ZcbM/7+peAGkwMWPQalgjbM83vwB58txdC8msvA=
X-Google-Smtp-Source: ABdhPJz3X7/zsLxW0acYDilZnZffpfuhhEzj9r12Onr6R0a3ZrPbcEC3CSWgseEdH8CiwuI/0vKICdQkV3hdFyMavwI=
X-Received: by 2002:aca:4056:: with SMTP id n83mr2975600oia.47.1620728574417;
 Tue, 11 May 2021 03:22:54 -0700 (PDT)
MIME-Version: 1.0
References: <20210511100550.28178-1-rppt@kernel.org> <20210511100550.28178-2-rppt@kernel.org>
In-Reply-To: <20210511100550.28178-2-rppt@kernel.org>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Tue, 11 May 2021 12:22:43 +0200
X-Gmail-Original-Message-ID: <CAMj1kXER_hsior1uoy3=7Sca4nD_n1s8PRoN4JMbOjzgL6g+Hg@mail.gmail.com>
Message-ID: <CAMj1kXER_hsior1uoy3=7Sca4nD_n1s8PRoN4JMbOjzgL6g+Hg@mail.gmail.com>
Subject: Re: [PATCH v4 1/4] include/linux/mmzone.h: add documentation for pfn_valid()
To:     Mike Rapoport <rppt@kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        David Hildenbrand <david@redhat.com>,
        Marc Zyngier <maz@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Will Deacon <will@kernel.org>,
        kvmarm <kvmarm@lists.cs.columbia.edu>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 11 May 2021 at 12:06, Mike Rapoport <rppt@kernel.org> wrote:
>
> From: Mike Rapoport <rppt@linux.ibm.com>
>
> Add comment describing the semantics of pfn_valid() that clarifies that
> pfn_valid() only checks for availability of a memory map entry (i.e. struct
> page) for a PFN rather than availability of usable memory backing that PFN.
>
> The most "generic" version of pfn_valid() used by the configurations with
> SPARSEMEM enabled resides in include/linux/mmzone.h so this is the most
> suitable place for documentation about semantics of pfn_valid().
>
> Suggested-by: Anshuman Khandual <anshuman.khandual@arm.com>
> Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>
> Reviewed-by: Anshuman Khandual <anshuman.khandual@arm.com>

Acked-by: Ard Biesheuvel <ardb@kernel.org>

> ---
>  include/linux/mmzone.h | 11 +++++++++++
>  1 file changed, 11 insertions(+)
>
> diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
> index 0d53eba1c383..e5945ca24df7 100644
> --- a/include/linux/mmzone.h
> +++ b/include/linux/mmzone.h
> @@ -1427,6 +1427,17 @@ static inline int pfn_section_valid(struct mem_section *ms, unsigned long pfn)
>  #endif
>
>  #ifndef CONFIG_HAVE_ARCH_PFN_VALID
> +/**
> + * pfn_valid - check if there is a valid memory map entry for a PFN
> + * @pfn: the page frame number to check
> + *
> + * Check if there is a valid memory map entry aka struct page for the @pfn.
> + * Note, that availability of the memory map entry does not imply that
> + * there is actual usable memory at that @pfn. The struct page may
> + * represent a hole or an unusable page frame.
> + *
> + * Return: 1 for PFNs that have memory map entries and 0 otherwise
> + */
>  static inline int pfn_valid(unsigned long pfn)
>  {
>         struct mem_section *ms;
> --
> 2.28.0
>
