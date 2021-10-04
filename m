Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 21B0D421708
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Oct 2021 21:08:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238103AbhJDTKN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Oct 2021 15:10:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233226AbhJDTKM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Oct 2021 15:10:12 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35222C061745;
        Mon,  4 Oct 2021 12:08:23 -0700 (PDT)
Received: from zn.tnic (p200300ec2f0fe4009c23c25c98857304.dip0.t-ipconnect.de [IPv6:2003:ec:2f0f:e400:9c23:c25c:9885:7304])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id A06841EC03FE;
        Mon,  4 Oct 2021 21:08:21 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1633374501;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=i6PxikJNA1V7HfDVyLAobLqaSjOebbk6J6n8Zlv5QfE=;
        b=EKdSCXKP0dFy4SUcN7yE1/LTYYr7g50Rq74dwqthJVY7HnSsWQ0haYRQBlHM9qpvT/ZewA
        L/dhM/XkdJucHyEk/QoP7sLQggGOKhbB/la4UEPn7+C8g2QJ/yp32xgC5HZdOGksGMh1OO
        gOfqpItzsrx/A1wmMvUKtArbVnZHUQM=
Date:   Mon, 4 Oct 2021 21:08:22 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Iwona Winiarska <iwona.winiarska@intel.com>
Cc:     linux-kernel@vger.kernel.org, openbmc@lists.ozlabs.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        x86@kernel.org, devicetree@vger.kernel.org,
        linux-aspeed@lists.ozlabs.org,
        linux-arm-kernel@lists.infradead.org, linux-hwmon@vger.kernel.org,
        linux-doc@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>,
        Jonathan Corbet <corbet@lwn.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andy Lutomirski <luto@kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Yazen Ghannam <yazen.ghannam@amd.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Zev Weiss <zweiss@equinix.com>,
        David Muller <d.mueller@elsoft.ch>
Subject: Re: [PATCH v2 02/15] x86/cpu: Extract cpuid helpers to
 arch-independent
Message-ID: <YVtRJiYD9EqGh7TM@zn.tnic>
References: <20210803113134.2262882-1-iwona.winiarska@intel.com>
 <20210803113134.2262882-3-iwona.winiarska@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210803113134.2262882-3-iwona.winiarska@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 03, 2021 at 01:31:21PM +0200, Iwona Winiarska wrote:
> Baseboard management controllers (BMC) often run Linux but are usually
> implemented with non-X86 processors. They can use PECI to access package
> config space (PCS) registers on the host CPU and since some information,
> e.g. figuring out the core count, can be obtained using different
> registers on different CPU generations, they need to decode the family
> and model.
> 
> The format of Package Identifier PCS register that describes CPUID
> information has the same layout as CPUID_1.EAX, so let's allow to reuse
> cpuid helpers by making it available for other architectures as well.
> 
> Signed-off-by: Iwona Winiarska <iwona.winiarska@intel.com>
> Reviewed-by: Tony Luck <tony.luck@intel.com>
> Reviewed-by: Dan Williams <dan.j.williams@intel.com>
> ---
>  MAINTAINERS                      | 1 +
>  arch/x86/Kconfig                 | 1 +
>  arch/x86/include/asm/cpu.h       | 3 ---
>  arch/x86/include/asm/microcode.h | 2 +-
>  arch/x86/kvm/cpuid.h             | 3 ++-
>  arch/x86/lib/Makefile            | 2 +-
>  drivers/edac/mce_amd.c           | 3 +--
>  include/linux/x86/cpu.h          | 9 +++++++++
>  lib/Kconfig                      | 4 ++++
>  lib/Makefile                     | 2 ++
>  lib/x86/Makefile                 | 3 +++
>  {arch/x86/lib => lib/x86}/cpu.c  | 2 +-
>  12 files changed, 26 insertions(+), 9 deletions(-)
>  create mode 100644 include/linux/x86/cpu.h
>  create mode 100644 lib/x86/Makefile
>  rename {arch/x86/lib => lib/x86}/cpu.c (95%)

AFAICT, all that churn is done for x86_family() and x86_model() which
are used *exactly* *once* and which are almost trivial anyway.

What's wrong with simply computing the family and model "by hand", so to
speak, in peci_device_info_init() and do away with that diffstat

 12 files changed, 26 insertions(+), 9 deletions(-)

?

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
