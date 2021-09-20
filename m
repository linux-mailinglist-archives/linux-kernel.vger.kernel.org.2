Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 240FD4119D5
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Sep 2021 18:33:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230026AbhITQeb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Sep 2021 12:34:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229609AbhITQea (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Sep 2021 12:34:30 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 855AFC061574
        for <linux-kernel@vger.kernel.org>; Mon, 20 Sep 2021 09:33:03 -0700 (PDT)
Received: from zn.tnic (p200300ec2f0a2a00274102d8249bfe43.dip0.t-ipconnect.de [IPv6:2003:ec:2f0a:2a00:2741:2d8:249b:fe43])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id EDF221EC0354;
        Mon, 20 Sep 2021 18:32:57 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1632155578;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=N3MwMwGiM+8XqBfyR16AWCnFJStdTZ2JMrVLHmqVMTc=;
        b=EFrkisV1QZNVA4Ql8rA+dlGp4xd8vrzxJOe8e3Eh8dUNoua1EGS/2ROufJB2jZ/tRrV/1A
        JGKMUNDkIQb6OayF5JXDS5w4VnwEi1HIYkRszZziS+kuNeHsJx/UuAzpVX6UJk5PjnU1SV
        33p8p/EZEdoPUr3hm+oeild4wXRvE4w=
Date:   Mon, 20 Sep 2021 18:32:53 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     "Luck, Tony" <tony.luck@intel.com>
Cc:     Yazen Ghannam <Yazen.Ghannam@amd.com>, X86 ML <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/4] x86/mce: Get rid of machine_check_vector
Message-ID: <YUi3tdWXfo8VeMs/@zn.tnic>
References: <20210917105355.2368-1-bp@alien8.de>
 <20210917105355.2368-3-bp@alien8.de>
 <YUgUpXHciLMn4X20@agluck-desk2.amr.corp.intel.com>
 <YUhCg/dQLEeaYM+T@zn.tnic>
 <d090a19ce8f74b0ea557f180d185df3e@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <d090a19ce8f74b0ea557f180d185df3e@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 20, 2021 at 04:04:35PM +0000, Luck, Tony wrote:
> You want to know how many bit are left for some reason? Is there some
> user API that will break if we overflow and start allocating bits from
> the next 64-bit word?

Well, I'd like for all of the bits to fit in a single u64, naturally.
"Spilling" into the next word is unnecessary, even though it doesn't
matter for solely kernel internal usage - just common sense.

> Or is this just the countdown for when you and I both have a nervous
> breakdown trying to keep track of that many different option paths
> through the machine check code :-)

Nah, this is the moment where I close the MCE tree and no more features
are allowed!

:-P

> Thanks for the tip about Ctrl-x to decrement a number in vim (Google
> tell me Ctrl-a increments). Learned something new today :-)

Yeah, vim is simply great. :-)

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
