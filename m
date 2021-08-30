Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A35D3FBEF8
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Aug 2021 00:27:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238820AbhH3W2p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Aug 2021 18:28:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230140AbhH3W2n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Aug 2021 18:28:43 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C63D2C061575
        for <linux-kernel@vger.kernel.org>; Mon, 30 Aug 2021 15:27:49 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1630362466;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=46RFpB+AEwBDad5STSwe0R6o1vsD2J5RjQEDRK957+E=;
        b=a334bSPdPohyoCHzy0Tot8XpCrEcTw/9UuR6JAnf5Et7G95KuQyiFe7N/fLuWNN2OBSvlw
        HxGPnkgwkE1YEIvUGDaBOeFC3rui3aCY3Ww5OVQhPUvgLPjfcMCF4pkhaXDmmug0zvB3w8
        VaBRiZnK9F5NT8mwZkLH60UCBsc7r/fSevFhZQgRQmaDaC4CsOCWz3G/5jFkhJMyI+0mM4
        0LWsNEByvLrRiL4nJsKg08I4I+5dujQzTf3OWFO2uIFgS55+c85241rR/6bVI6tH6nXTD+
        ZrwgBLCpoLpl6N4rs3UyInq3BIrlU43TikaOgjKww7997o2dFwijsHU/33PgnA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1630362466;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=46RFpB+AEwBDad5STSwe0R6o1vsD2J5RjQEDRK957+E=;
        b=W5bS4W50YQ/Gdls/3Dtc1LWj77RWrYVtsBSw49FQBBjrerZ1qnfTj62DyofS5u1gM9BBAf
        y0m5FzWNxToSaIBQ==
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        the arch/x86 maintainers <x86@kernel.org>
Subject: Re: [GIT pull] irq/core for v5.15-rc1
In-Reply-To: <CAHk-=wixTU55dA6iz1JYG0eAviYqQY0su_QOQSu52jrQV92r+Q@mail.gmail.com>
References: <163031993120.58256.1250660796395121952.tglx@xen13.tec.linutronix.de>
 <163031993245.58256.17381067625019238476.tglx@xen13.tec.linutronix.de>
 <CAHk-=wixTU55dA6iz1JYG0eAviYqQY0su_QOQSu52jrQV92r+Q@mail.gmail.com>
Date:   Tue, 31 Aug 2021 00:27:45 +0200
Message-ID: <87k0k2ftzy.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 30 2021 at 14:47, Linus Torvalds wrote:
> On Mon, Aug 30, 2021 at 3:44 AM Thomas Gleixner <tglx@linutronix.de> wrote:
>>
>> Core changes:
>>
>>    - The usual set of small fixes and improvements all over the place, but nothing
>>      outstanding
>
> Heh. Welcome to the most confusing language on earth, and the
> completely different meanings of "stands out" and "outstanding".

I'm pretty sure someone told me that before, but that's one of these
English language odditites I can't memorize for whatever reason.

> I would hope that some of the fixes are outstanding (or at least good
> enough), even if none of them stand out.

AFAICT, none of them is outstanding otherwise they wouldn't be part of
that pull request.

Hmm, maybe that's the crib I should try to memorize 'outstanding'
vs. 'stands out'. I'll try :)

Thanks,

        tglx
