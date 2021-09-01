Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B9D03FE2D9
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Sep 2021 21:19:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230453AbhIATUq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Sep 2021 15:20:46 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:39030 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229962AbhIATUp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Sep 2021 15:20:45 -0400
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1630523986;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=YHG+GcpLmbhrbdZCc5PzV7F+gisGOONPdjGkuvfFd2c=;
        b=hZx8F61R2vzy2hldnuGcKwwCrEiKAieUHqh1kZclLeJijVP+5kki2oGTlJe173awCd+4DN
        p8WpvvGP04pmpfi4fxsWko0fkwX5SA23JhSqhr0WV7HEvp0DJdjJ2viFCNdZu3WHWoUJ22
        GXKcMNzipZQfBLZ021nuxD/jjFEXY+qrdDkg+72aFKl2O5sI1WM5MeKTZck4h4mSlZci1+
        0TL59xJpKs9OX2zPwqCkEkx/lW3Wycgd+0B7dQTGbqWiS3jevlr2DmEhW9mff+zWdZywWf
        vZb7agI9b8s9ZUY98cnjfol8jcQu5gfkM2LsWHFW3g+il6RjOY3bKwdatgDYeA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1630523986;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=YHG+GcpLmbhrbdZCc5PzV7F+gisGOONPdjGkuvfFd2c=;
        b=HERCI1T9LgKLCaNQmjTdrq5mqjy/iPGU+etlDnN/vv10tyzMy12r+IANQsQfSKO+P84wg0
        Wi48bg6Rfj/5ynDA==
To:     =?utf-8?Q?Andr=C3=A9?= Almeida <andrealmeid@collabora.com>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        Ingo Molnar <mingo@kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
        Colin King <colin.king@canonical.com>
Subject: Re: Question on commit dc7109aaa233 ("futex: Validate waiter
 correctly in futex_proxy_trylock_atomic()")
In-Reply-To: <f9689421-a801-fd8d-b0bd-29280bebe78d@collabora.com>
References: <CAKXUXMzqmN1dYpbYSCXWN9VwHn8+MXj3P=G09qD6=atwrcJ8WA@mail.gmail.com>
 <87a6kyfr4r.ffs@tglx> <f9689421-a801-fd8d-b0bd-29280bebe78d@collabora.com>
Date:   Wed, 01 Sep 2021 21:19:46 +0200
Message-ID: <87lf4gcdd9.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Andr=C3=A9!

On Wed, Sep 01 2021 at 15:28, Andr=C3=A9 Almeida wrote:
> =C3=80s 20:29 de 30/08/21, Thomas Gleixner escreveu:
>> Care to send a patch?
>>=20
>
> A patch was already proposed with this fix:
> https://lore.kernel.org/lkml/20210818131840.34262-1-colin.king@canonical.=
com/

Thanks for the pointer. This fell through the cracks for unknown reasons.

