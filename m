Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F03F93FBA9A
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Aug 2021 19:06:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237951AbhH3RHl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Aug 2021 13:07:41 -0400
Received: from mail.skyhub.de ([5.9.137.197]:47774 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231290AbhH3RHk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Aug 2021 13:07:40 -0400
Received: from zn.tnic (p200300ec2f0b3b00d8cdf5b388faf601.dip0.t-ipconnect.de [IPv6:2003:ec:2f0b:3b00:d8cd:f5b3:88fa:f601])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 179781EC0372;
        Mon, 30 Aug 2021 19:06:42 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1630343202;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=tefVeyuhcaq/hwBMYZN9LE2ldMpnFO7uKtj8b+VcVng=;
        b=VfcRB6VkTFljo96bl5YzmgKAUrJuDrCvlcFQFDIca2cLbutJVbAu8hHZDwHY3ePp6I08SB
        tgvcdGDnPzAfFeQxmmbrM/wQ0rdLXvI3rJEZaDHuW3rd3y9MwRYDgjtpLI+CdaXkfqpxJG
        NEVqFB0AQUb0mJeBeFpMVs9LgMQaftM=
Date:   Mon, 30 Aug 2021 19:07:17 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     "Bae, Chang Seok" <chang.seok.bae@intel.com>
Cc:     "Lutomirski, Andy" <luto@kernel.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@kernel.org" <mingo@kernel.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "Brown, Len" <len.brown@intel.com>,
        "Hansen, Dave" <dave.hansen@intel.com>,
        "Macieira, Thiago" <thiago.macieira@intel.com>,
        "Liu, Jing2" <jing2.liu@intel.com>,
        "Shankar, Ravi V" <ravi.v.shankar@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v9 08/26] x86/fpu/xstate: Introduce helpers to manage the
 XSTATE buffer dynamically
Message-ID: <YS0QRWjuqh9ZzIGE@zn.tnic>
References: <20210730145957.7927-1-chang.seok.bae@intel.com>
 <20210730145957.7927-9-chang.seok.bae@intel.com>
 <YRV6M1I/GMXwuJqW@zn.tnic>
 <2BF12EDA-89F0-40F7-B63E-50ADD0262164@intel.com>
 <YRZDu2Rk+KdRhh1U@zn.tnic>
 <2B279B5F-ACF2-46F2-9259-684419A57BDF@intel.com>
 <YRzSuC25eHEOgj6h@zn.tnic>
 <B0E262FE-21C3-44EE-B058-752ACDECD716@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <B0E262FE-21C3-44EE-B058-752ACDECD716@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 18, 2021 at 07:46:55PM +0000, Bae, Chang Seok wrote:
> No, this non-compacted thing is not for optimization. SDM is not quite clear
> about the logic behind the non-compacted format -- some state’s offset does
> not always match with the 'size + offset' of the previous one, even without
> 64B-alignment. So, the loop is only for the compacted format, not the
> non-compacted one. 
> 
> It was refactored to use in the new helper to find feature_nr’s start point.
> If the size is added up here, it is not ‘i’'s start point anymore.

Let's see, we're still talking about this thing, right:

        nr = fls64(mask) - 1;

        if (!boot_cpu_has(X86_FEATURE_XSAVES))
                return xstate_offsets[nr] + xstate_sizes[nr];

?

That @mask is "which components reserved in the buffer."

Which buffer? The mask being passed is independent from whatever buffer.

So you need to do a lot more explaining here before this goes anywhere.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
