Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE89942E141
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Oct 2021 20:30:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230121AbhJNScH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Oct 2021 14:32:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229819AbhJNSbp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Oct 2021 14:31:45 -0400
Received: from forward501o.mail.yandex.net (forward501o.mail.yandex.net [IPv6:2a02:6b8:0:1a2d::611])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 507B9C061570
        for <linux-kernel@vger.kernel.org>; Thu, 14 Oct 2021 11:29:28 -0700 (PDT)
Received: from sas1-345d03a7038e.qloud-c.yandex.net (sas1-345d03a7038e.qloud-c.yandex.net [IPv6:2a02:6b8:c08:4cab:0:640:345d:3a7])
        by forward501o.mail.yandex.net (Yandex) with ESMTP id 5FDFF45C4251;
        Thu, 14 Oct 2021 21:29:14 +0300 (MSK)
Received: from sas8-b61c542d7279.qloud-c.yandex.net (2a02:6b8:c1b:2912:0:640:b61c:542d [2a02:6b8:c1b:2912:0:640:b61c:542d])
        by sas1-345d03a7038e.qloud-c.yandex.net (mxback/Yandex) with ESMTP id FdrVEk6NLi-TEDWnOAD;
        Thu, 14 Oct 2021 21:29:14 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=orca.pet; s=mail; t=1634236154;
        bh=bLpX4FDH4KRZlxwWxzd7KgWocTPJ05HkOHZRAyJDeU4=;
        h=In-Reply-To:From:Subject:Cc:References:Date:Message-ID:To;
        b=K3l+M/QrtO0WvodvofOrE6FkQLZK2l2yYu84I00WDLWsIIFnHkwqz6RAgKkzSDSXR
         WQAbFDvvEjDco2Xdp6cghkca1Eg9I5RSjO/N0/xRyNXGo62Z25b9aJTMST1x4rSLAR
         84Ywjf4uQpsu0dpUII5AxYkb6utUqWjIyRyZUNic=
Authentication-Results: sas1-345d03a7038e.qloud-c.yandex.net; dkim=pass header.i=@orca.pet
Received: by sas8-b61c542d7279.qloud-c.yandex.net (smtp/Yandex) with ESMTPS id xSdXf4wTeG-TC4Kskt0;
        Thu, 14 Oct 2021 21:29:13 +0300
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client certificate not present)
X-Yandex-Fwd: 2
Message-ID: <a7e54bfa-a015-2be7-e2c0-7bab47cc2b4a@orca.pet>
Date:   Thu, 14 Oct 2021 18:29:12 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH] x86: add support DM&P devices
To:     Borislav Petkov <bp@alien8.de>
Cc:     x86@kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org
References: <20211008162246.1638801-1-marcos@orca.pet>
 <YWcQDYY9CuWKsayl@zn.tnic>
From:   Marcos Del Sol Vives <marcos@orca.pet>
In-Reply-To: <YWcQDYY9CuWKsayl@zn.tnic>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


El 13/10/2021 a las 16:57, Borislav Petkov escribió:
> On Fri, Oct 08, 2021 at 06:22:46PM +0200, Marcos Del Sol Vives wrote:
>> +config CPU_SUP_DMP_32
>> +	default y
>> +	bool "Support DM&P processors" if PROCESSOR_SELECT
>> +	depends on !64BIT
> 
> You mean
> 
> 	depends on X86_32
> 
> ?
> 
> Wikipedia says those things are 32-bit.
> 

I used here !64BIT because it is what CPU_SUP_TRANSMETA_32 and
CPU_SUP_UMC_32 (the only other two 32-bit-only processors on
Kconfig.cpu) are also using.

Using X86_32 makes total sense, in fact I originally used that, but for
consistency I changed it to !64BIT to match existing flags.

Should I change it then? Should I also change the other two, possibly in
a different patch?

>> +	help
>> +	  This enables detection, tunings and quirks for DM&P processors
>> +
>> +	  You need this enabled if you want your kernel to run on a
>> +	  DM&P CPU. Disabling this option on other types of CPUs
> 
> So I'm not sure about the nomenclature: those CPUs are called Vortex86
> and DM&P is simply the next owner of the IP:
> 
> "Vortex86 previously belonged to SiS, which got the basic design from
> Rise Technology.[1] SiS sold it to DM&P Electronics[2] in Taiwan."
> 
> So I'm thinking we should call everything Vortex, the file vortex.c, the
> vendor define X86_VENDOR_VORTEX and so on.

Makes total sense. Will change it for v2.

>> +	  makes the kernel a tiny bit smaller. Disabling it on a DM&P
>> +	  CPU might render the kernel unbootable.
> 
> Why unbootable? It looks like those are perfect clones: "No special init
> required for DM&P processors." it says in the patch. :)
> 

I used that text because it's what every other x86 processor flag is
also using, even those that also do not do any special initialization.

For example, the CPU_SUP_UMC_32 flag also has the same warning, yet
arch/x86/kernel/cpu/umc.c reads "UMC chips appear to be only either 386
or 486, so no special init takes place". I thus assumed this was
standard text, in case at some point an special init is required.

Do you think it should be then reworded, or should I keep it to mantain
consistency with other existing flag descriptions?

Greetings and thanks for your time,
Marcos
