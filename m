Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C54AB3E4ABF
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Aug 2021 19:23:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234345AbhHIRXd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Aug 2021 13:23:33 -0400
Received: from mail-vk1-f170.google.com ([209.85.221.170]:42499 "EHLO
        mail-vk1-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234145AbhHIRX0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Aug 2021 13:23:26 -0400
Received: by mail-vk1-f170.google.com with SMTP id bb10so2664028vkb.9
        for <linux-kernel@vger.kernel.org>; Mon, 09 Aug 2021 10:23:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cM37UCgiVJ8HlID8BMdakz6VmbI/pJlbCeBQy/RAgpw=;
        b=Cax0jDnftLm9GTSTrJedcTnEOzyGXQFGDt3B1OkIUGQUC0gI4VZ2Q+szhohuYzXhGW
         khAKUOGqszAI4NSywdQvoEY+8DA8hRILE8Dn8/o3m4ZReZS/UgyWN5eY8CegWKVhUiYJ
         ZHzLphWMiBVUZbDV9bFTvJHu7nXXw5alrpWANV/IX6t8Ucsg3Xq80xlRAzn6dGcoF4BI
         5h53bFSctR859ZSZEZ026piRHEuwdD3zcBE+GqDXASdU9ZFjkoNWql4d5WPTD0i5gv9m
         S2cKj3tYZwmGNyfU/6uCrx9vV/lEjY8/gLCtuzd2nMLKFBWVK5Q0qWiFsVY1OczQMXEB
         Q93g==
X-Gm-Message-State: AOAM530CZChx11Q09rWrmz1ip3clkpSrN30Kw3jkrf3HVF0MNXJudkEi
        8NxIrvGPDSrm0k7Pliq3aoxbdrECPD3a7vgZOMHbYXnRHjiZ6g==
X-Google-Smtp-Source: ABdhPJwLoph7n+zJ3FdUxKFRZSpmCiBcxx3Vj8vxKd86aT6QzhHGMtnt1qsqJHKS6vL3cVCUiuh737iH9XHoQT8jE5w=
X-Received: by 2002:a1f:c387:: with SMTP id t129mr15057234vkf.5.1628529785523;
 Mon, 09 Aug 2021 10:23:05 -0700 (PDT)
MIME-Version: 1.0
References: <20210809075016.414276-1-geert@linux-m68k.org> <47e64acf-5537-bf5a-5a49-0a6897de17ff@infradead.org>
In-Reply-To: <47e64acf-5537-bf5a-5a49-0a6897de17ff@infradead.org>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 9 Aug 2021 19:22:52 +0200
Message-ID: <CAMuHMdWNWP-msoHNrodkv5vErMyjANNk2feaFJoecCSLSA-zsQ@mail.gmail.com>
Subject: Re: Build regressions/improvements in v5.14-rc5
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Randy,

On Mon, Aug 9, 2021 at 6:20 PM Randy Dunlap <rdunlap@infradead.org> wrote:
> On 8/9/21 12:50 AM, Geert Uytterhoeven wrote:
> > *** ERRORS ***
> >
> > 13 error regressions:
> >    + /kisskb/src/drivers/dma/ioat/dca.c: error: implicit declaration of function 'boot_cpu_has' [-Werror=implicit-function-declaration]:  => 74:6
> >    + /kisskb/src/drivers/dma/ioat/dca.c: error: implicit declaration of function 'cpuid_eax' [-Werror=implicit-function-declaration]:  => 64:18
> >    + /kisskb/src/drivers/dma/ioat/dca.c: error: implicit declaration of function 'cpuid_ebx' [-Werror=implicit-function-declaration]:  => 17:31
> >    + /kisskb/src/drivers/pci/controller/vmd.c: error: 'X86_MSI_BASE_ADDRESS_HIGH' undeclared (first use in this function):  => 150:20
> >    + /kisskb/src/drivers/pci/controller/vmd.c: error: 'X86_MSI_BASE_ADDRESS_LOW' undeclared (first use in this function):  => 151:35
> >    + /kisskb/src/drivers/pci/controller/vmd.c: error: 'arch_msi_msg_addr_lo_t {aka struct arch_msi_msg_addr_lo}' has no member named 'base_address':  => 151:19
> >    + /kisskb/src/drivers/pci/controller/vmd.c: error: 'arch_msi_msg_addr_lo_t {aka struct arch_msi_msg_addr_lo}' has no member named 'destid_0_7':  => 152:19
> >    + /kisskb/src/drivers/pci/controller/vmd.c: error: control reaches end of non-void function [-Werror=return-type]:  => 127:1
> >    + /kisskb/src/drivers/pci/controller/vmd.c: error: dereferencing pointer to incomplete type 'struct pci_sysdata':  => 700:4
> >    + /kisskb/src/drivers/pci/controller/vmd.c: error: field 'sysdata' has incomplete type:  => 116:21
> >    + /kisskb/src/include/linux/compiler_attributes.h: error: "__GCC4_has_attribute___no_sanitize_coverage__" is not defined [-Werror=undef]:  => 29:29
> >    + /kisskb/src/include/linux/compiler_types.h: error: call to '__compiletime_assert_1857' declared with attribute error: FIELD_PREP: value too large for the field:  => 328:38
> >    + /kisskb/src/include/linux/compiler_types.h: error: call to '__compiletime_assert_1864' declared with attribute error: FIELD_PREP: value too large for the field:  => 328:38
>
> Hi Geert,
> Would you tell me what arch & config these build errors are from?

These were all new in v5.14-rc1, cfr.
https://lore.kernel.org/lkml/CAMuHMdWv8-6fBDLb8cFvvLxsb7RkEVkLNUBeCm-9yN9_iJkg-g@mail.gmail.com/

  + /kisskb/src/drivers/dma/ioat/dca.c: error: implicit declaration of
function 'boot_cpu_has' [-Werror=implicit-function-declaration]:  =>
74:6
  + /kisskb/src/drivers/dma/ioat/dca.c: error: implicit declaration of
function 'cpuid_eax' [-Werror=implicit-function-declaration]:  =>
64:18
  + /kisskb/src/drivers/dma/ioat/dca.c: error: implicit declaration of
function 'cpuid_ebx' [-Werror=implicit-function-declaration]:  =>
17:31
  + /kisskb/src/drivers/pci/controller/vmd.c: error:
'X86_MSI_BASE_ADDRESS_HIGH' undeclared (first use in this function):
=> 150:20
  + /kisskb/src/drivers/pci/controller/vmd.c: error:
'X86_MSI_BASE_ADDRESS_LOW' undeclared (first use in this function):
=> 151:35
  + /kisskb/src/drivers/pci/controller/vmd.c: error:
'arch_msi_msg_addr_lo_t {aka struct arch_msi_msg_addr_lo}' has no
member named 'base_address':  => 151:19
  + /kisskb/src/drivers/pci/controller/vmd.c: error:
'arch_msi_msg_addr_lo_t {aka struct arch_msi_msg_addr_lo}' has no
member named 'destid_0_7':  => 152:19
  + /kisskb/src/drivers/pci/controller/vmd.c: error: control reaches
end of non-void function [-Werror=return-type]:  => 127:1
  + /kisskb/src/drivers/pci/controller/vmd.c: error: dereferencing
pointer to incomplete type 'struct pci_sysdata':  => 700:4
  + /kisskb/src/drivers/pci/controller/vmd.c: error: field 'sysdata'
has incomplete type:  => 116:21

um-x86_64/um-all{mod,yes}config

  + /kisskb/src/include/linux/compiler_attributes.h: error:
"__GCC4_has_attribute___no_sanitize_coverage__" is not defined
[-Werror=undef]:  => 29:29

mips-gcc4.9/mips-allmodconfig

  + /kisskb/src/include/linux/compiler_types.h: error: call to
'__compiletime_assert_1857' declared with attribute error: FIELD_PREP:
value too large for the field:  => 328:38
  + /kisskb/src/include/linux/compiler_types.h: error: call to
'__compiletime_assert_1864' declared with attribute error: FIELD_PREP:
value too large for the field:  => 328:38

arm64-gcc5.4/arm64-allmodconfig
arm64-gcc8/arm64-allmodconfig

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
