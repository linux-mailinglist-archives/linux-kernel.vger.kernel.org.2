Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B67D93632A0
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Apr 2021 01:15:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231261AbhDQXP5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 17 Apr 2021 19:15:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229653AbhDQXP4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Apr 2021 19:15:56 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C510C06174A
        for <linux-kernel@vger.kernel.org>; Sat, 17 Apr 2021 16:15:28 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1618701326;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=YruGhFn9UsfND0XA1k4cwaAjILGWeCrz1gmEI3OkqaQ=;
        b=p7t7Ky+n099Um8xHGTHtSv7EvzVYqzPanahideb3bYXcK6Lcc5GGsQmlQDamLyyfOciSOe
        TbmMDr5OON6UvMQlocuBlH/WYEtvAXQyuI/I94CZtio4ND081Vxzy25oBDXw4w9WOxMFyN
        WqDkEcBe2pCTxLDusiWldznaWEcUKlKv2HTpgNC9A8RIksw6VUgqoXpDnSZ0Gff6Kaa2Ey
        B0PIFcb1NEsnr3tpoAw3TLrkj1At1z7BjzJsnUMxBzItm0yDxkQVOueib+GRm/al40K0I2
        04f7d5/5v5QM3PEJ5PM3O5Yd/Y1wkqLTcEp6H0NWPZJszV3vHcqHgE12WjMxVg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1618701326;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=YruGhFn9UsfND0XA1k4cwaAjILGWeCrz1gmEI3OkqaQ=;
        b=/eHwQx7OjnXhl5tHDleAdOTGerpUyIeHgrIsSXQ0vgLDF4wD6FRxyn2SEvpKseDAqZYlBB
        WAoSURAzPcHc7IBA==
To:     paulmck@kernel.org
Cc:     linux-kernel@vger.kernel.org, john.stultz@linaro.org,
        sboyd@kernel.org, corbet@lwn.net, Mark.Rutland@arm.com,
        maz@kernel.org, kernel-team@fb.com, neeraju@codeaurora.org,
        ak@linux.intel.com, Chris Mason <clm@fb.com>
Subject: Re: [PATCH v8 clocksource 2/5] clocksource: Retry clock read if long delays detected
In-Reply-To: <20210417225409.GA5006@paulmck-ThinkPad-P17-Gen-1>
References: <20210414043435.GA2812539@paulmck-ThinkPad-P17-Gen-1> <20210414043602.2812981-2-paulmck@kernel.org> <87y2dhrte0.ffs@nanos.tec.linutronix.de> <20210417225409.GA5006@paulmck-ThinkPad-P17-Gen-1>
Date:   Sun, 18 Apr 2021 01:15:26 +0200
Message-ID: <87eef8sdtd.ffs@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 17 2021 at 15:54, Paul E. McKenney wrote:
> On Sat, Apr 17, 2021 at 02:24:23PM +0200, Thomas Gleixner wrote:
>> I so wish we could just delete all of this horror instead of making it
>> more horrible.
>
> Revisit deleting it in five years if there are no issues, whatever
> "issue" might mean in this context?  Five years should give time for
> this to propagate to the enterprise distros.

That does not help with the fact that the broken hardware will still be
around in 5 years from now. Which is what prevents me from deleting the
whole watchdog muck ...

Thanks,

        tglx
