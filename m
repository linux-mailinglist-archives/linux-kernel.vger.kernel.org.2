Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8425E4297EC
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Oct 2021 22:06:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234808AbhJKUIo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Oct 2021 16:08:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231926AbhJKUIn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Oct 2021 16:08:43 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C66CC061570;
        Mon, 11 Oct 2021 13:06:43 -0700 (PDT)
Received: from zn.tnic (p200300ec2f08bb0022234ba9186d35fd.dip0.t-ipconnect.de [IPv6:2003:ec:2f08:bb00:2223:4ba9:186d:35fd])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 63C7A1EC01FC;
        Mon, 11 Oct 2021 22:06:41 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1633982801;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=sHYrqFRbYrEH2ohEyvm54WlvJW+Ifcb/2V9eQlCd/PU=;
        b=mIYzaIydq3WW3gWAjE6T2K1pdYPtVCYlQvaJDfXOzzREBc6lCOfiQmEe6P+MpCD7Gbnp4i
        9X0N4OQCjQChihVgTg6tbJ5oHYmKKsTrwIQ0seEOiQX1ho+iAkWowyBq53F2wrrem02c9f
        Kc09T7ysxEghODkpZO5N02Jn0nUt1rU=
Date:   Mon, 11 Oct 2021 22:06:38 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     "Winiarska, Iwona" <iwona.winiarska@intel.com>
Cc:     "corbet@lwn.net" <corbet@lwn.net>,
        "jae.hyun.yoo@linux.intel.com" <jae.hyun.yoo@linux.intel.com>,
        "d.mueller@elsoft.ch" <d.mueller@elsoft.ch>,
        "linux-hwmon@vger.kernel.org" <linux-hwmon@vger.kernel.org>,
        "andrew@aj.id.au" <andrew@aj.id.au>,
        "Luck, Tony" <tony.luck@intel.com>,
        "Lutomirski, Andy" <luto@kernel.org>,
        "andriy.shevchenko@linux.intel.com" 
        <andriy.shevchenko@linux.intel.com>,
        "mchehab@kernel.org" <mchehab@kernel.org>,
        "jdelvare@suse.com" <jdelvare@suse.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "olof@lixom.net" <olof@lixom.net>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "rdunlap@infradead.org" <rdunlap@infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "linux-aspeed@lists.ozlabs.org" <linux-aspeed@lists.ozlabs.org>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux@roeck-us.net" <linux@roeck-us.net>,
        "zweiss@equinix.com" <zweiss@equinix.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "openbmc@lists.ozlabs.org" <openbmc@lists.ozlabs.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "joel@jms.id.au" <joel@jms.id.au>,
        "yazen.ghannam@amd.com" <yazen.ghannam@amd.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "pierre-louis.bossart@linux.intel.com" 
        <pierre-louis.bossart@linux.intel.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "Williams, Dan J" <dan.j.williams@intel.com>
Subject: Re: [PATCH v2 01/15] x86/cpu: Move intel-family to arch-independent
 headers
Message-ID: <YWSZTq8NWWcCMXtA@zn.tnic>
References: <20210803113134.2262882-1-iwona.winiarska@intel.com>
 <20210803113134.2262882-2-iwona.winiarska@intel.com>
 <YVtQG+idmwKn0qLe@zn.tnic>
 <58ef4107e9b2c60a2605aac0d2fb6670a95bc9e0.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <58ef4107e9b2c60a2605aac0d2fb6670a95bc9e0.camel@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 11, 2021 at 07:21:26PM +0000, Winiarska, Iwona wrote:
> Same reason why PECI can't just include arch/x86 directly (we're building for
> ARM, not x86).

Aha.

So what do you need those INTEL_FAM6* defines for?

I see peci_cpu_device_ids[] which are used to match the CPU so at least
that thing must be loading on x86 hardware... reading your 0th message,
it sounds like that peci-cpu thing is loaded on an x86 CPU and it then
exposes those interfaces which a PECI controller accesses.

And then I see in init_core_mask() the single usage of INTEL_FAM6* and
that drivers/hwmon/peci/cputemp.c is a CPU temp monitoring client so
that thing probably runs on x86 too.

Or?

If it does, then you don't need the code move.

But it looks like I'm missing something...

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
