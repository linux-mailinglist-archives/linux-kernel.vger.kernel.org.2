Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B23F1455ADA
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Nov 2021 12:44:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344330AbhKRLrt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Nov 2021 06:47:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344057AbhKRLpn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Nov 2021 06:45:43 -0500
Received: from mail-qt1-x833.google.com (mail-qt1-x833.google.com [IPv6:2607:f8b0:4864:20::833])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6C9DC06120D
        for <linux-kernel@vger.kernel.org>; Thu, 18 Nov 2021 03:40:05 -0800 (PST)
Received: by mail-qt1-x833.google.com with SMTP id a2so5644987qtx.11
        for <linux-kernel@vger.kernel.org>; Thu, 18 Nov 2021 03:40:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=n8epIJdsPw1dMJHHPreVGZcZALNd0jYhjQiZuAwfZnU=;
        b=EREQsDR3JyljTMhe6Vfrc6YAo4KCDB97sWs5ey2FLoC68zaynOaW1lmu9D42+i99RF
         zjUkXeAeB4C93/SjwkxVVgzuf2XZ+rMkNmeNXZDAsQq9DCIHPNms7xI2kcXdhPxpjS0R
         0edHETeWMND7Iowdk2rJF2RMOqnI4lnkQVGIxbrBQReYX+8ul0IcLwIJSLkjFnsFFGjq
         LpyJidKObeBfw2IUPoDXgU+WKrDLZ1/n3P3usurBlJ7jez8v1EbXIaSzivUpY5O+Bq+B
         kqEsbiI3PLRmmPyQMqRn5dcAse3ew2rgweiBrLKPlV9ytsVVdDYkJu71RDQ9W4MgFgEM
         X9wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=n8epIJdsPw1dMJHHPreVGZcZALNd0jYhjQiZuAwfZnU=;
        b=dBBw7JkkAnJKfFABDveDPidjtc/eQ5zRlBbjLNju/tJeHpguc89WzRHLWnJKdC6G6i
         bQmui6/qpzY6NS9j/kb8LecqaYh5Q9/0NLGk96xBiFsZMGNUlN81xtAzlib5vaUo8RR8
         //X/h0Eb1cGC6hGaGZ6TNwMOH7fZnbdzK1E7rzeI39ydFd89DHaARsJJyDQcs2f+zjN9
         lZv0Ja6pIvMp9Xq+DDxkJaN/9fxkeS7FQOxQkCqPhaYY/30cVzKRAj4YUFf8dlqJPGr0
         Y/9SbBG1OYEhlorYYvHWmLzYm4Zh0IrBJJvLEAOCT1v0FVwnKCvZcc3nuOaWtd5i+389
         kQ4Q==
X-Gm-Message-State: AOAM531K2aS39XgCnCjVpyee/V8tEl1n4UdW/PgysI0EV1y0tF28Ghtv
        noD+h6wOPwWHlnO6ek9Zgbf1YNwNC+po+0kcR+i21lEI
X-Google-Smtp-Source: ABdhPJxLl1+7kA3xQkD2dbJrdZfFK1yly/ve8DZ4pNCJM9vmXUefkK2Z+LMx7QvvdeYQMwjFVhMXGE/I1yM8N86zdKo=
X-Received: by 2002:a05:622a:185:: with SMTP id s5mr24789540qtw.299.1637235605043;
 Thu, 18 Nov 2021 03:40:05 -0800 (PST)
MIME-Version: 1.0
References: <1637223483-2867-1-git-send-email-huangzhaoyang@gmail.com>
In-Reply-To: <1637223483-2867-1-git-send-email-huangzhaoyang@gmail.com>
From:   Zhaoyang Huang <huangzhaoyang@gmail.com>
Date:   Thu, 18 Nov 2021 19:39:43 +0800
Message-ID: <CAGWkznG-M985L6Zg89iv3171PWKscZ2cNwdL0F6A_bqs2zs7Dw@mail.gmail.com>
Subject: Re: [RFC PATCH] arch: arm64: try to use PTE_CONT when change page attr
To:     Ard Biesheuvel <ardb@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Nicholas Piggin <npiggin@gmail.com>,
        Mike Rapoport <rppt@kernel.org>,
        Pavel Tatashin <pasha.tatashin@soleen.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Jonathan Marek <jonathan@marek.ca>,
        Zhaoyang Huang <zhaoyang.huang@unisoc.com>,
        "open list:MEMORY MANAGEMENT" <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

forget the criteria for judging the linear address range, so please
ignore this patch

On Thu, Nov 18, 2021 at 4:18 PM Huangzhaoyang <huangzhaoyang@gmail.com> wrote:
>
> From: Zhaoyang Huang <zhaoyang.huang@unisoc.com>
>
> kernel will use the min granularity when rodata_full enabled which
> make TLB pressure high. Furthermore, there is no PTE_CONT applied.
> Try to improve these a little by apply PTE_CONT when change page's
> attr.
>
> Signed-off-by: Zhaoyang Huang <zhaoyang.huang@unisoc.com>
> ---
>  arch/arm64/mm/pageattr.c | 62 ++++++++++++++++++++++++++++++++++++++++++++----
>  1 file changed, 58 insertions(+), 4 deletions(-)
>
> diff --git a/arch/arm64/mm/pageattr.c b/arch/arm64/mm/pageattr.c
> index a3bacd7..0b6a354 100644
> --- a/arch/arm64/mm/pageattr.c
> +++ b/arch/arm64/mm/pageattr.c
> @@ -61,8 +61,13 @@ static int change_memory_common(unsigned long addr, int numpages,
>         unsigned long start = addr;
>         unsigned long size = PAGE_SIZE * numpages;
>         unsigned long end = start + size;
> +       unsigned long cont_pte_start = 0;
> +       unsigned long cont_pte_end = 0;
> +       unsigned long cont_pmd_start = 0;
> +       unsigned long cont_pmd_end = 0;
> +       pgprot_t orig_set_mask = set_mask;
>         struct vm_struct *area;
> -       int i;
> +       int i = 0;
>
>         if (!PAGE_ALIGNED(addr)) {
>                 start &= PAGE_MASK;
> @@ -98,9 +103,58 @@ static int change_memory_common(unsigned long addr, int numpages,
>          */
>         if (rodata_full && (pgprot_val(set_mask) == PTE_RDONLY ||
>                             pgprot_val(clear_mask) == PTE_RDONLY)) {
> -               for (i = 0; i < area->nr_pages; i++) {
> -                       __change_memory_common((u64)page_address(area->pages[i]),
> -                                              PAGE_SIZE, set_mask, clear_mask);
> +               cont_pmd_start = (start + ~CONT_PMD_MASK + 1) & CONT_PMD_MASK;
> +               cont_pmd_end = cont_pmd_start + ~CONT_PMD_MASK + 1;
> +               cont_pte_start = (start + ~CONT_PTE_MASK + 1) & CONT_PTE_MASK;
> +               cont_pte_end = cont_pte_start + ~CONT_PTE_MASK + 1;
> +
> +               if (addr <= cont_pmd_start && end > cont_pmd_end) {
> +                       do {
> +                               __change_memory_common((u64)page_address(area->pages[i]),
> +                                               PAGE_SIZE, set_mask, clear_mask);
> +                               i++;
> +                               addr++;
> +                       } while(addr < cont_pmd_start);
> +                       do {
> +                               set_mask = __pgprot(pgprot_val(set_mask) | PTE_CONT);
> +                               __change_memory_common((u64)page_address(area->pages[i]),
> +                                               PAGE_SIZE, set_mask, clear_mask);
> +                               i++;
> +                               addr++;
> +                       } while(addr < cont_pmd_end);
> +                       set_mask = orig_set_mask;
> +                       do {
> +                               __change_memory_common((u64)page_address(area->pages[i]),
> +                                               PAGE_SIZE, set_mask, clear_mask);
> +                               i++;
> +                               addr++;
> +                       } while(addr <= end);
> +               } else if (addr <= cont_pte_start && end > cont_pte_end) {
> +                       do {
> +                               __change_memory_common((u64)page_address(area->pages[i]),
> +                                               PAGE_SIZE, set_mask, clear_mask);
> +                               i++;
> +                               addr++;
> +                       } while(addr < cont_pte_start);
> +                       do {
> +                               set_mask = __pgprot(pgprot_val(set_mask) | PTE_CONT);
> +                               __change_memory_common((u64)page_address(area->pages[i]),
> +                                               PAGE_SIZE, set_mask, clear_mask);
> +                               i++;
> +                               addr++;
> +                       } while(addr < cont_pte_end);
> +                       set_mask = orig_set_mask;
> +                       do {
> +                               __change_memory_common((u64)page_address(area->pages[i]),
> +                                               PAGE_SIZE, set_mask, clear_mask);
> +                               i++;
> +                               addr++;
> +                       } while(addr <= end);
> +               } else {
> +                       for (i = 0; i < area->nr_pages; i++) {
> +                               __change_memory_common((u64)page_address(area->pages[i]),
> +                                               PAGE_SIZE, set_mask, clear_mask);
> +                       }
>                 }
>         }
>
> --
> 1.9.1
>
