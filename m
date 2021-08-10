Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A2A43E7CF3
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Aug 2021 18:00:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238982AbhHJQAn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Aug 2021 12:00:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233605AbhHJQAk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Aug 2021 12:00:40 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3ED04C0613C1
        for <linux-kernel@vger.kernel.org>; Tue, 10 Aug 2021 09:00:18 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1628611216;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=XsXuHsnr+eKuIQBNM9hBeaZT5+Zuk2ta+rwPuC01OAw=;
        b=QitrkNrHsFesKFAGk+c8G+Nn4ysnLt6/EkysLk6zf9VKSdbIGDTEUzSES9RNjogWX45QTb
        cwtFDHhdGORiOMJe2RJlpPl2w/855hjiDqEvYqigsDFAl/zrDvEm5KECkksk2mI9oq2UCR
        9J8/4pmnjsftq7tyOyvsOp5B3n4Vs/wf4hTtLR19u2g88QHz5UanyMTlScu5deeK0GsSOm
        LDeIbJzOj1oKMPq3HSqlo11bG+PXEUhXP1dNLljs3b1tDwLfGoe25c+1j7VZHiwOFcSCE8
        kUq3QeYodjuccM61Rv4Vg7rN+MNR685CXDDa1nr2cbEi8BMG2qg7GOt+POijLw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1628611216;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=XsXuHsnr+eKuIQBNM9hBeaZT5+Zuk2ta+rwPuC01OAw=;
        b=k3Nx2Ili89/kmI64z20XoAF1FLI0M2glZzEB2faUSueYxYyw6i+g2YTEvPcd84KGnJLhtV
        tWwIWNlPbq8dGzCg==
To:     Jisheng Zhang <Jisheng.Zhang@synaptics.com>,
        John Stultz <john.stultz@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] timer: Use static_branch_likely() for
 timers_nohz_active
In-Reply-To: <20210624163218.39ae3ec6@xhacker.debian>
References: <20210624163218.39ae3ec6@xhacker.debian>
Date:   Tue, 10 Aug 2021 18:00:16 +0200
Message-ID: <87im0dqohb.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Jisheng,

On Thu, Jun 24 2021 at 16:32, Jisheng Zhang wrote:

> The static key timers_nohz_active is likely to be true, so use
> static_branch_likely() to reflect this fact.

you still lack any justification for your statement that NOHZ active is
likely.

It might be likely for your system, but is this true in general?

Thanks,

        tglx
