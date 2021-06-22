Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4AD1C3B0896
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jun 2021 17:19:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232157AbhFVPVm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Jun 2021 11:21:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231815AbhFVPVh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jun 2021 11:21:37 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5C29C061574
        for <linux-kernel@vger.kernel.org>; Tue, 22 Jun 2021 08:19:21 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1624375160;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Qe8XsamDYYUNw77+KfU2crpQsKFujdSuP/VjqH9RqeA=;
        b=SnR9zoWq/vIFw7+LtUutkp34o0vZnyCozQQxuPH08EqCNfF1hgU8AFvEjlB51e8Qvjq0KM
        Uo8T0A2SxvpkzuxMcK6nwy38FbSkBVI0sNdJ84/lLPTlGcrVImmWnoM2k5VXr3rN3UDHtr
        0uzJSoRkt/mjIjjG1A4QGQhaCpTBkL79KMUddUu3G6kcWig4pOyOxwc/Mm7gSE0kxBPxEC
        yuAgcR3FM92jJOM9iAr+3bQqhMTjj52KrsVm9cz32HqGXGTpDg4OVINmaHaWY2xU6hXj2E
        XFBVyk7qG5ndYya1xlsXrELarWf6gUSlwdJGAcklguerDSJm3Y7w9zXsGY9Pog==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1624375160;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Qe8XsamDYYUNw77+KfU2crpQsKFujdSuP/VjqH9RqeA=;
        b=2WYZsjPT0vOjljk4hbM27D9+AbcCNXZIiM1XCGQMjs2Wl/yXZXJ+zXhbDCmxz7rdgb7za4
        aCuRJol/rLR61JDQ==
To:     Jisheng Zhang <Jisheng.Zhang@synaptics.com>,
        John Stultz <john.stultz@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH] timer: Use static_branch_likely() for timers_nohz_active
In-Reply-To: <20210513143354.096c6baf@xhacker.debian>
References: <20210513143354.096c6baf@xhacker.debian>
Date:   Tue, 22 Jun 2021 17:19:20 +0200
Message-ID: <87o8bydj0n.ffs@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 13 2021 at 14:33, Jisheng Zhang wrote:
> NOHZ is likely to be enabled, so use static_branch_likely() to

Why is it likely to be enabled? Did you make a survey of the wider
distro universe or what?

> reflect this fact. This could improve the finally generated code

could improve? Either it does or it does not.

Thanks,

        tglx
