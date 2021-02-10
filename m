Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 10FAC315F41
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Feb 2021 07:16:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231328AbhBJGIq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Feb 2021 01:08:46 -0500
Received: from mail.kernel.org ([198.145.29.99]:40146 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230179AbhBJGHj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Feb 2021 01:07:39 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8137F64E45
        for <linux-kernel@vger.kernel.org>; Wed, 10 Feb 2021 06:06:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1612937175;
        bh=AYjIrqXzH092pJrb+fpYWCgWxniCzrONOCeX2GjsGQQ=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=lyAOkCTjGENHmvAVf+psM+N+q/UL+SZjgD/6kFekVIFYTLKYXCjHJ1Y67xy4+K5SQ
         hf2TN4Pphv3Z9+tTfnCQHWY5t+WO4uvM8UaeyWEpJqTtUmLjuQSTOjS7uYL6kAvrNO
         k/7JbMhc8hFk7ACYY5Is3U/gO3Zkp5A8+XK2HK//8Udt4bJt7UkANItOGcPE04PT0B
         xJCzKiuiNS7NCy+L7UzD5HgEmHzXff8hLME5/U8w1GBL+rMMAvybckOSIrqd+srpsS
         ra4JQwU1hutkybIF7VGb7svG4Kq8gy4qOhAVUQAiY1NRXdkSxFuMsAqWVnPqDd4CIU
         O6wr/nvLS7qFg==
Received: by mail-ej1-f48.google.com with SMTP id sa23so1912243ejb.0
        for <linux-kernel@vger.kernel.org>; Tue, 09 Feb 2021 22:06:15 -0800 (PST)
X-Gm-Message-State: AOAM531BUmH2nXav4eAnaX9NqVuEsQHzLc9qKEsX8c6vrWs8YPxrC6Z8
        FbDftBujxPNfeM+Q3Kb9Wbmem1f457DVea/qeFnb0w==
X-Google-Smtp-Source: ABdhPJwTiLIv2hR8Rx9uP45u07KHJA7194PTpFCFdPazAHEGcM/mbiaSL40VkfUsoBuNVaygvJGNnr1/p3fAKWdIQAQ=
X-Received: by 2002:a17:906:6bc5:: with SMTP id t5mr1332289ejs.253.1612937174055;
 Tue, 09 Feb 2021 22:06:14 -0800 (PST)
MIME-Version: 1.0
References: <cover.1612924255.git.luto@kernel.org> <8969c688ee663e99901cf4b0383bc6662ce79707.1612924255.git.luto@kernel.org>
In-Reply-To: <8969c688ee663e99901cf4b0383bc6662ce79707.1612924255.git.luto@kernel.org>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Tue, 9 Feb 2021 22:06:02 -0800
X-Gmail-Original-Message-ID: <CALCETrW8m-4AG4aZUYx35p0kc2aWiUq4p-WCs0+BOtb3WWE3aA@mail.gmail.com>
Message-ID: <CALCETrW8m-4AG4aZUYx35p0kc2aWiUq4p-WCs0+BOtb3WWE3aA@mail.gmail.com>
Subject: Re: [PATCH v2 08/14] x86/fault: Skip erratum #93 workaround on new CPUs
To:     Andy Lutomirski <luto@kernel.org>
Cc:     X86 ML <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Yonghong Song <yhs@fb.com>,
        Masami Hiramatsu <mhiramat@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 9, 2021 at 6:33 PM Andy Lutomirski <luto@kernel.org> wrote:
>
> Erratum #93 applies to the first generation of AMD K8 CPUs.  Skip the
> workaround on newer CPUs.

Whoops, this breaks the !CPU_SUP_AMD build.  It needs a fixup like this:

https://git.kernel.org/pub/scm/linux/kernel/git/luto/linux.git/commit/?h=x86/fault&id=06772a3b6918bf6d6d0778946149b7d56ae30d80

Boris, do you want a v3?

>
> Signed-off-by: Andy Lutomirski <luto@kernel.org>
> ---
>  arch/x86/mm/fault.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
>
> diff --git a/arch/x86/mm/fault.c b/arch/x86/mm/fault.c
> index cbb1a9754473..3fe2f4800b69 100644
> --- a/arch/x86/mm/fault.c
> +++ b/arch/x86/mm/fault.c
> @@ -442,9 +442,8 @@ static void dump_pagetable(unsigned long address)
>   */
>  static int is_errata93(struct pt_regs *regs, unsigned long address)
>  {
> -#if defined(CONFIG_X86_64) && defined(CONFIG_CPU_SUP_AMD)
> -       if (boot_cpu_data.x86_vendor != X86_VENDOR_AMD
> -           || boot_cpu_data.x86 != 0xf)
> +#if defined(CONFIG_X86_64)
> +       if (!is_amd_k8_pre_npt())
>                 return 0;
>
>         if (user_mode(regs))
> --
> 2.29.2
>
