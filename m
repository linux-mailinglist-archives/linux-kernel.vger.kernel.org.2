Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F13B344ABF
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Mar 2021 17:12:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230479AbhCVQLk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Mar 2021 12:11:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230048AbhCVQLA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Mar 2021 12:11:00 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8C4EC061574
        for <linux-kernel@vger.kernel.org>; Mon, 22 Mar 2021 09:10:58 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id r12so22215315ejr.5
        for <linux-kernel@vger.kernel.org>; Mon, 22 Mar 2021 09:10:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0RjSQM4DgkK7m/ekOUT02sK+WqopVxraVt2b40+KaBU=;
        b=xlR34CXli2xQbahXQ3WiajunYFVNHrhO61oNhpR4/BYX6TPJtgYJmbdPpdF/A31M4B
         66ycQ1WNrd8yikq99kH9YnVaeub+aRLakcZm8YWnKtJEeLTzvKIu1Q6UP9LpOuwd6Kbf
         8raqj1HQG/Fba/NR16M++LWd4Am3B75WUTIrp9MCif8o7dY04WWvBWkxG19AHnJnnuND
         NkxL6drrSy20vU5G1f5clhkItXup1oA4BMEKFzO5oSK3LHoAIRBcBBW3DvFW70AoTOv9
         i6dx6E1lKit1YwP+2xfk8Q4ThhFXZFhd6KWgJK+7q9iefjxr0QR9WupVABR7Hy0gFNxN
         CUOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0RjSQM4DgkK7m/ekOUT02sK+WqopVxraVt2b40+KaBU=;
        b=EiAUljcoQGxa19GCbrEnewcQlZjxCoju08g2xZp26EwIRvKcUmpmB8VrRDdMTOQ9UQ
         pS72QPum1cNWqQKoIX4my+SjO+HRI6tvQ76VWOC1kgru3tVDfMF+4vZvO/QkxBpp/Dqa
         vXi+jqU6FstRTcNDP4YZB4hjLBzCwth0rLfBt2L5VzHiHe+NGweJW4QHmr7M0qr7D8s7
         yd1zjru7+2i+umEeJKnlLHR737qo9O+9efXO2PHFQ3DX27b8O/YISuEnPimWgzhErUyk
         t0+WLKWYEr0A/MSXmRpk9+8ny8kejP5YYmZ6/IlI7h+ViZG/mYy2TFfYMyaDyPXJPsuw
         USMA==
X-Gm-Message-State: AOAM533RytNTolMIDKOc6oAExJHTGwUz43gQ/9p1LdIgVjCyDPWX+wYD
        1NdceF1sYCKkOde+GYl9aSTHv13i3uGOgxNGx8Y+NA==
X-Google-Smtp-Source: ABdhPJw2cwpwcIFF+4fCD52TNaNhNj6xZuvy8zO0W6QKI4z8VrkzNaMSL98WR0e/SxJx41J9zwBSutz9BqE/L1Bveo0=
X-Received: by 2002:a17:906:2ac1:: with SMTP id m1mr539193eje.472.1616429457645;
 Mon, 22 Mar 2021 09:10:57 -0700 (PDT)
MIME-Version: 1.0
References: <20210322160200.19633-1-david@redhat.com> <20210322160200.19633-2-david@redhat.com>
In-Reply-To: <20210322160200.19633-2-david@redhat.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Mon, 22 Mar 2021 09:10:48 -0700
Message-ID: <CAPcyv4iLJxAdk=AE01LbRFZER2hxmgNh0k6Js5vDVuy33Fqp6w@mail.gmail.com>
Subject: Re: [PATCH v1 1/3] kernel/resource: make walk_system_ram_res() find
 all busy IORESOURCE_SYSTEM_RAM resources
To:     David Hildenbrand <david@redhat.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Dave Young <dyoung@redhat.com>, Baoquan He <bhe@redhat.com>,
        Vivek Goyal <vgoyal@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Keith Busch <keith.busch@intel.com>,
        Michal Hocko <mhocko@suse.com>, Qian Cai <cai@lca.pw>,
        Oscar Salvador <osalvador@suse.de>,
        Eric Biederman <ebiederm@xmission.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Brijesh Singh <brijesh.singh@amd.com>, X86 ML <x86@kernel.org>,
        Kexec Mailing List <kexec@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 22, 2021 at 9:02 AM David Hildenbrand <david@redhat.com> wrote:
>
> It used to be true that we can have busy system RAM only on the first level
> in the resourc tree. However, this is no longer holds for driver-managed
> system RAM (i.e., added via dax/kmem and virtio-mem), which gets added on
> lower levels.
>
> We have two users of walk_system_ram_res(), which currently only
> consideres the first level:
> a) kernel/kexec_file.c:kexec_walk_resources() -- We properly skip
>    IORESOURCE_SYSRAM_DRIVER_MANAGED resources via
>    locate_mem_hole_callback(), so even after this change, we won't be
>    placing kexec images onto dax/kmem and virtio-mem added memory. No
>    change.
> b) arch/x86/kernel/crash.c:fill_up_crash_elf_data() -- we're currently
>    not adding relevant ranges to the crash elf info, resulting in them
>    not getting dumped via kdump.
>
> This change fixes loading a crashkernel via kexec_file_load() and including
> dax/kmem and virtio-mem added System RAM in the crashdump on x86-64. Note
> that e.g,, arm64 relies on memblock data and, therefore, always considers
> all added System RAM already.
>
> Let's find all busy IORESOURCE_SYSTEM_RAM resources, making the function
> behave like walk_system_ram_range().
>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Dan Williams <dan.j.williams@intel.com>
> Cc: Daniel Vetter <daniel.vetter@ffwll.ch>
> Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> Cc: Signed-off-by: David Hildenbrand <david@redhat.com>
> Cc: Dave Young <dyoung@redhat.com>
> Cc: Baoquan He <bhe@redhat.com>
> Cc: Vivek Goyal <vgoyal@redhat.com>
> Cc: Dave Hansen <dave.hansen@linux.intel.com>
> Cc: Keith Busch <keith.busch@intel.com>
> Cc: Michal Hocko <mhocko@suse.com>
> Cc: Qian Cai <cai@lca.pw>
> Cc: Oscar Salvador <osalvador@suse.de>
> Cc: Eric Biederman <ebiederm@xmission.com>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Borislav Petkov <bp@alien8.de>
> Cc: "H. Peter Anvin" <hpa@zytor.com>
> Cc: Tom Lendacky <thomas.lendacky@amd.com>
> Cc: Brijesh Singh <brijesh.singh@amd.com>
> Cc: x86@kernel.org
> Cc: kexec@lists.infradead.org
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>  kernel/resource.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/kernel/resource.c b/kernel/resource.c
> index 627e61b0c124..4efd6e912279 100644
> --- a/kernel/resource.c
> +++ b/kernel/resource.c
> @@ -457,7 +457,7 @@ int walk_system_ram_res(u64 start, u64 end, void *arg,
>  {
>         unsigned long flags = IORESOURCE_SYSTEM_RAM | IORESOURCE_BUSY;
>
> -       return __walk_iomem_res_desc(start, end, flags, IORES_DESC_NONE, true,
> +       return __walk_iomem_res_desc(start, end, flags, IORES_DESC_NONE, false,
>                                      arg, func);

Looks good,

Reviewed-by: Dan Williams <dan.j.williams@intel.com>
