Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 44AC43345B6
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Mar 2021 18:52:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233355AbhCJRvu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Mar 2021 12:51:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232846AbhCJRvW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Mar 2021 12:51:22 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29658C061760
        for <linux-kernel@vger.kernel.org>; Wed, 10 Mar 2021 09:51:22 -0800 (PST)
Date:   Wed, 10 Mar 2021 18:51:17 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1615398679;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=aSIb//N8NgxmAAqcYWn+xZg/W7zBbeYa44UtqizpJ7c=;
        b=2iiosQ6F5igJ0wCB+/GF79e+LQqAoSgwmipYn5tKQXihHcGoQ239mFScugg4yF3mif4lCG
        7dHZ9ZLCubpA97z6qXDdkSXX7u8khJuPHtK6OYhBnjdq7WhFdYEgkEr6P4Sz50WtPZd3FB
        FNubnEICl15A8vDMwkNu6A7tXjZ21X2lc5oY5/Q9q/tRtZiqvkz4Mcg0E6RU5V9Q47fxzR
        XxmhktzxYI9LPKXj4/FXUcVh5kzbC3VfR79Jcr8czWr46ll7rEVxBfsM7tlDLCQPBFbO61
        phK5MaLeEg1GM7oqWK5Qzsr4LFJK5pkB8JAzGbg6xwcZ+QC723eh2YAqPCDp7A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1615398679;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=aSIb//N8NgxmAAqcYWn+xZg/W7zBbeYa44UtqizpJ7c=;
        b=Lm+yOufA/9Sr/YaM1pt8UQ0CC/BHSJDG7UkgiDyiYPavZQF9gEx/w3C1NS4EjGTViqIiFi
        R/RhxRrqfaG2ypAg==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Willy Tarreau <w@1wt.eu>
Subject: Re: [PATCH v3] auxdisplay: Remove in_interrupt() usage.
Message-ID: <20210310175117.dqv7uufl7tplmgk5@linutronix.de>
References: <20210208204136.sv4omzms3nadse6e@linutronix.de>
 <CANiq72mw47Qa9M6i23Dp+_3M8juBnv33PJ-6zFk++SV57G2-cQ@mail.gmail.com>
 <20210209090112.lewvvhnc2y7oyr27@linutronix.de>
 <CANiq72mG3zXA7j9KbC74hQ1BMgw713Hm3WDAcQBjKxgg0fLHeg@mail.gmail.com>
 <20210213165040.vzzieegx4aliyosd@linutronix.de>
 <CANiq72mkkSfbnNM_mmXE-TNKO1orsAeyByMKFy1N6hm+EBA40A@mail.gmail.com>
 <20210216102856.dnaycukt3oqxoszp@linutronix.de>
 <CANiq72mge40Uvqf3mb4uof2gi8ktvhjoodfyJY7uLW4guTnvDw@mail.gmail.com>
 <20210216182619.xd7h4uwpqcw5kcup@linutronix.de>
 <CANiq72np-G3whePohyYazx3KpP6A+DsRwq-bjd7E7qKb1JG62w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <CANiq72np-G3whePohyYazx3KpP6A+DsRwq-bjd7E7qKb1JG62w@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021-02-16 21:21:07 [+0100], Miguel Ojeda wrote:
=E2=80=A6
> It is not an order :-) i.e. don't feel pressured that you need to sign
> off on the comment change -- I can submit the comment on my own later
> on.

I assumed you are going to apply it but I don't see it in -next as of
today. Is there anything I need to do?

> Cheers,
> Miguel

Sebastian
