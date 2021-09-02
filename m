Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 864ED3FEAAD
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Sep 2021 10:35:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244311AbhIBIgB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Sep 2021 04:36:01 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:42256 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233465AbhIBIgA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Sep 2021 04:36:00 -0400
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1630571701;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=26hkUZMTAIuPsDbRry9NtcujPmWxDHtM97Byjsbf4VU=;
        b=lKjtdRW0u3sYGm4+vSfjAo0OzpkWECp42KzS5n5JY5XvpGsVgWBcf8whbztCmzFCGs3PDu
        nV1gJ9fRKRpE5fi0cGtIR3Uqh0R++WPigxUBn4Xi+WKYs34CoPRfgmRPnjDR7Vfor0r4kS
        6iVa/msdOE7dOTUbit+uHhTUNYSo8ySfSTkaS4E51NAFTKFDZz0t56S7qql/Guam81kDRw
        RkXDX6Q5w0d+kAr09+Tj5XyAp9sIFm7NS5nFjToXSHLalwtEwVKhy8p4ht/zuQVog+rhmu
        MFi3kOex8VMdJ5WN5bThLSHARHElo8uR8sUx5F/6l1IldSvmNkS1SZMvsC4uGA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1630571701;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=26hkUZMTAIuPsDbRry9NtcujPmWxDHtM97Byjsbf4VU=;
        b=EtJOo8CSXZNbsMNbFYn0CfrweVhWqbWvcxgpj/BN2+i+f3Ksk3FEuYJblBUCZaFbKleVcw
        8bCkGKsEKjt1XPDg==
To:     Mark Brown <broonie@kernel.org>
Cc:     Vladimir Oltean <vladimir.oltean@nxp.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Lee Jones <lee.jones@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>, Marc Zyngier <maz@kernel.org>,
        Hou Zhiqiang <Zhiqiang.Hou@nxp.com>,
        Biwen Li <biwen.li@nxp.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] regmap: teach regmap to use raw spinlocks if
 requested in the config
In-Reply-To: <20210901160555.GG5976@sirena.org.uk>
References: <20210825205041.927788-1-vladimir.oltean@nxp.com>
 <20210825205041.927788-2-vladimir.oltean@nxp.com> <875yvr3j5c.ffs@tglx>
 <YSzM5S3VKOBXniRu@sirena.org.uk> <87bl5fggrf.ffs@tglx>
 <20210901160555.GG5976@sirena.org.uk>
Date:   Thu, 02 Sep 2021 10:35:01 +0200
Message-ID: <874kb3cr4a.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 01 2021 at 17:05, Mark Brown wrote:
> On Mon, Aug 30, 2021 at 04:16:04PM +0200, Thomas Gleixner wrote:
>> On Mon, Aug 30 2021 at 13:19, Mark Brown wrote:
>
>> > That probably does make sense, I think we're just using regular
>> > spinlocks for spinlocks mainly because they're the default rather
>> > than because anyone put huge amounts of thought into it.  IIRC
>> > the first users were using spinlocks for their locking when they
>> > were converted.
>
>> So if the actual spinlock protected operations are not doing any other
>> business than accessing preallocated cache memory and a few MMIO
>> operations then converting them to raw spinlocks should have no real
>> impact on RT.
>
> I think Vladimir's point that something might try to use one of the APIs
> that can do multiple register writes atomically to generate a very long
> register write sequence is valid here.  It's far from the common case
> but it'd be hard to audit, it's going to be a lot easier to handle going
> to raw spinlocks in the cases where it's specifically needed than to
> keep on top of ensuring that none of the users are causing issues or
> start causing issues in the future.  This does make me feel it's a bit
> safer to leave the default the way it is since if you get it wrong then
> lockdep will tend to notice very quickly while it's less likely that
> we'd get tooling spotting issues the other way around.

Fair enough.

>> One way to do that is obviously starting with the patch from Vladimir
>> and then convert them one by one, so the assumption that they are not
>> doing anything nasty (in the RT sense) can be validated.
>
> Vladimir's patch is in Linus' tree now so users that can safely do so
> can start using raw spinlocks.

ok
