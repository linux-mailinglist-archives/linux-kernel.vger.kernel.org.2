Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1BB59407442
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Sep 2021 02:48:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234998AbhIKAtk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Sep 2021 20:49:40 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:41802 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229735AbhIKAte (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Sep 2021 20:49:34 -0400
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1631321302;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=f0IYNNDoYrQdJehVACszdRvSXw+0VPS/H7Qz0Y3AX3k=;
        b=oQ5MJIAsJSQ3vcpMRXNKp/8YCTT+yNZ5DRThi+EAwg9PeX5nfLeM3WpMnWUkNJCQrkfkiJ
        j8hUWYPHEjQ+umrZb/u7GU735ScWd/ovRmqxWPxvCBexWKSDNjVQwybhv0umjgWrzz3+cq
        WV6AsrCfCpi5F2y5ZqeTd3j/TwNax0FGvfrIuoZA1cA9veoCyatftaWkN8McAaSeL7nNYO
        n4fwunH2mm9FjHxj2/NBYir+utAaSouF7GnbVdTSvHua/ZP+W9L8qp5TbyYQqjItuya57w
        9+U1cKBi4CVe+yZ8t7Ffchioba0JcFN9+Nra0HLyqkelfGbSQHwoLHr5/ucstQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1631321302;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=f0IYNNDoYrQdJehVACszdRvSXw+0VPS/H7Qz0Y3AX3k=;
        b=lQQwT6UPHZqnqL3LGWaMSvEnvi9aiBB5L0o/soOp51X2ue8Hr1rpHmKSrS57H/sMJmTFr6
        dWiU2bHEGbttX2Ag==
To:     OPENSOURCE Lukas Hannen 
        <lukas.hannen@opensource.tttech-industrial.com>,
        John Stultz <john.stultz@linaro.org>,
        "EMC: linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [RESEND PATCH] time: changed timespec64_to_ns to avoid underrun
In-Reply-To: <AM0PR01MB54100B19D6ED5FDE764FA516EED69@AM0PR01MB5410.eurprd01.prod.exchangelabs.com>
References: <AM0PR01MB54100B19D6ED5FDE764FA516EED69@AM0PR01MB5410.eurprd01.prod.exchangelabs.com>
Date:   Sat, 11 Sep 2021 02:48:21 +0200
Message-ID: <87fsucc4yy.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Lukas,

On Fri, Sep 10 2021 at 13:50, OPENSOURCE Lukas Hannen wrote:

> This patch fixes a small oversight in timespec64_to_ns() that has resulted
...

why you are resending this patch?

1) The only change you did is adding a prefix to the subject line

   which in fact disqualifies it from the RESEND tag because RESEND
   means it's unmodified or just forward ported.

   Changed patches even if the change is just in the subject line or the
   changelog want a version number.

   But what's worse:

2) You ignored any other review comment I gave here:

   https://lore.kernel.org/r/87y2876pg0.ffs@tglx

   IOW, you stopped reading at line 12 of my reply

3) Due to that you failed to notice that I said in that reply:

   "I fixed it up for you this time."

4) Of course you also ignored the fact that I actually fixed the
   identified issues and the fact that the fixed up patch is already
   applied to my tree.

   You got notfied about that:

   https://lore.kernel.org/r/163111620295.25758.18154572095175068828.tip-bot2@tip-bot2

So what exactly are you trying to achieve by "resending" a patch which
still does not apply and still has a non-sensical subject line and
changelog?

> CONFIDENTIALITY: The contents of this e-mail are confidential and
> intended only for the above addressee(s). If you are not the intended
> recipient, or the person responsible for delivering it to the intended
> recipient, copying or delivering it to anyone else or using it in any
> unauthorized manner is prohibited and may be unlawful. If you receive
> this e-mail by mistake, please notify the sender and the systems
> administrator at straymail@tttech.com immediately.

Please get rid of this nonsensical disclaimer.

 When posting to public mailing lists the boilerplate confidentiality
 disclaimers are not only meaningless, they are absolutely wrong for
 obvious reasons.

 See https://people.kernel.org/tglx/notes-about-netiquette for further
 information.

Thanks,

        tglx
