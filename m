Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A17B42B7BB
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Oct 2021 08:42:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238068AbhJMGoP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Oct 2021 02:44:15 -0400
Received: from mail.skyhub.de ([5.9.137.197]:49050 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231597AbhJMGoN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Oct 2021 02:44:13 -0400
Received: from zn.tnic (p200300ec2f0ce200d6cfbc8b4a6526d3.dip0.t-ipconnect.de [IPv6:2003:ec:2f0c:e200:d6cf:bc8b:4a65:26d3])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 076361EC01A9;
        Wed, 13 Oct 2021 08:42:09 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1634107329;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=RJHwoQ0GRj7G38aIyE/+JmuKk5oLW3/IXloYTjGdLPM=;
        b=VlLM3hqiRjov/ZUPpeKCNRCnjNajATN4ZcYXc7ZzMcDIFNKZhMuLyvbwbTV4hNSh7eWHn8
        fPCgRIXxmKE32JTk43eOePcvO+B1Oj286a3oFYZbzrSJQIMJqxSZjpWKlE/Z9g/IFEvVXX
        VMGzYr69ythLmV1z4a+M8jVC9oRwEZg=
Date:   Wed, 13 Oct 2021 08:42:06 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     "Winiarska, Iwona" <iwona.winiarska@intel.com>
Cc:     "corbet@lwn.net" <corbet@lwn.net>,
        "jae.hyun.yoo@linux.intel.com" <jae.hyun.yoo@linux.intel.com>,
        "pierre-louis.bossart@linux.intel.com" 
        <pierre-louis.bossart@linux.intel.com>,
        "linux-hwmon@vger.kernel.org" <linux-hwmon@vger.kernel.org>,
        "Lutomirski, Andy" <luto@kernel.org>,
        "Luck, Tony" <tony.luck@intel.com>,
        "andrew@aj.id.au" <andrew@aj.id.au>,
        "mchehab@kernel.org" <mchehab@kernel.org>,
        "yazen.ghannam@amd.com" <yazen.ghannam@amd.com>,
        "jdelvare@suse.com" <jdelvare@suse.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "rdunlap@infradead.org" <rdunlap@infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "linux-aspeed@lists.ozlabs.org" <linux-aspeed@lists.ozlabs.org>,
        "olof@lixom.net" <olof@lixom.net>, "arnd@arndb.de" <arnd@arndb.de>,
        "linux@roeck-us.net" <linux@roeck-us.net>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "openbmc@lists.ozlabs.org" <openbmc@lists.ozlabs.org>,
        "zweiss@equinix.com" <zweiss@equinix.com>,
        "d.mueller@elsoft.ch" <d.mueller@elsoft.ch>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "joel@jms.id.au" <joel@jms.id.au>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "andriy.shevchenko@linux.intel.com" 
        <andriy.shevchenko@linux.intel.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "Williams, Dan J" <dan.j.williams@intel.com>
Subject: Re: [PATCH v2 01/15] x86/cpu: Move intel-family to arch-independent
 headers
Message-ID: <YWZ/vqHXibwOWtDu@zn.tnic>
References: <20210803113134.2262882-1-iwona.winiarska@intel.com>
 <20210803113134.2262882-2-iwona.winiarska@intel.com>
 <YVtQG+idmwKn0qLe@zn.tnic>
 <58ef4107e9b2c60a2605aac0d2fb6670a95bc9e0.camel@intel.com>
 <YWSZTq8NWWcCMXtA@zn.tnic>
 <337b6332312ea63862aedd09279417c9e1c7e11f.camel@intel.com>
 <YWStQSrRJQ09KXVY@zn.tnic>
 <15d81463b631e03b00a7031510304d5598fc246c.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <15d81463b631e03b00a7031510304d5598fc246c.camel@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 12, 2021 at 11:15:00PM +0000, Winiarska, Iwona wrote:
> We (OpenBMC) do have PECI HW, so that shouldn't be a problem.

Yeah, don't take it personally, but asking people to test stuff for you
doesn't really work, in practice.

> Both CPUID.EAX=1 decoding and definitions in intel-family are pretty "well-
> defined".

Sure, they are "well-defined" until we change them for whatever reason.
Then they will be "well-defined" again. But different.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
