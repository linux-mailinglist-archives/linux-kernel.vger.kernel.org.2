Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E3853376D9F
	for <lists+linux-kernel@lfdr.de>; Sat,  8 May 2021 02:08:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230113AbhEHAHt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 May 2021 20:07:49 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:52620 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229812AbhEHAHs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 May 2021 20:07:48 -0400
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1620432407;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=spikNF5AN5oMuc3pokCorS5IzQrz0h0g6dQ2lapegZE=;
        b=3485Z19GmrDBAPEbtuNTd+bhuanx6ega4yes7gtLvEhgYCVj0LaBE+gbJnMLDaZGF+U3Tf
        uI2v9lh0LWW5Y/ZJD44bvMmCDSHFc3CMGGDUwmktSevdlIPUJPZDQ2MekaPIuMDXL+5Lom
        vt79JI2wK1zzCGm7n6AbdcyE9ZXXNRJe+jYGYXgbgaNYI0k5DR5/NddTbv+n4jhg4AbDR/
        QZ/Z07bq2hUWRrM7a8A9KiL+lZhgdOQphgd/xoweN/zce7FMC6CSHQX6/Z/Nh8BpRv9C7d
        mkiKo6ioeYkp4pmpT15OBJmCdkGTJxCOvn/ltkuh/6Y6f7yfaJl6Qy/PDT0b3A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1620432407;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=spikNF5AN5oMuc3pokCorS5IzQrz0h0g6dQ2lapegZE=;
        b=66nyL19bjORicI/Ebg1vY09r9ZJP8HDVOciif6RZf5QYyV0VvSI9ReizNPI19lXd/y8Pi4
        G9YwtA6WyuRaDJBg==
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     John Stultz <john.stultz@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] alarmtimer: check RTC features instead of ops
In-Reply-To: <87wnsfd7e2.ffs@nanos.tec.linutronix.de>
References: <20210429214902.2612338-1-alexandre.belloni@bootlin.com> <877dkkfdif.ffs@nanos.tec.linutronix.de> <YIu7ZqowGScElHBr@piout.net> <871rasf8qe.ffs@nanos.tec.linutronix.de> <YJAX60DSp/imRstL@piout.net> <87wnsfd7e2.ffs@nanos.tec.linutronix.de>
Date:   Sat, 08 May 2021 02:06:47 +0200
Message-ID: <875yzum6lk.ffs@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 03 2021 at 20:00, Thomas Gleixner wrote:
> On Mon, May 03 2021 at 17:34, Alexandre Belloni wrote:
>> On 30/04/2021 10:59:53+0200, Thomas Gleixner wrote:
>>
>> I hope this is clearer.
>
> Yes, that makes sense now!

Am I expected to rewrite the changelog or is there going to be a V2 of
this?

Thanks,

        tglx
