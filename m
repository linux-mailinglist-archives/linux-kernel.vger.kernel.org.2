Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 440173ADE0F
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Jun 2021 13:12:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229621AbhFTLNW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Jun 2021 07:13:22 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:38144 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229554AbhFTLLU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Jun 2021 07:11:20 -0400
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1624187346;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=SnO37iNElK7J9rAy1ARxKWBQ4+2Hp9J7w4qDXxLcZrI=;
        b=T9JY98kmrT4K44Z3rhRVet/z2z001rKR3fFL3crNsM75St+ha/oBwjtrKWBMpswS0107Hp
        BunmGrPgCTXFcIlK1LiTAWVQhS7RqeNkrCDBnmbCvVJAQsNcIjh+DXz/MOAuqoEt7tB27j
        yHNonEYj9/vWMEiowwYioI7rXTucYMFLXnRanwCHXbX1XR22vyrxv2dbxWeNyxi95RYFLZ
        i48dk+oQYzLTh2vvlVjcllr80F2O0tdkZPVAVKV6cZ+zqFrngLaDqFhj3XXh9CTCqWJwul
        jwHFx7lTNiki/1XoBnccS8JkNRc/SpLcb27Z3obEgO7kSIzmj3BbZ9TTubVQEw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1624187346;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=SnO37iNElK7J9rAy1ARxKWBQ4+2Hp9J7w4qDXxLcZrI=;
        b=X5hY/Y8gqtMIApbGPRcIFawr+WSv+UfghwzmwamEO71wBQJly2inZ8aShZsBYdR6YJCxGB
        +9P18wLtLdEHKZCA==
To:     =?utf-8?B?5L2V6ZGr?= <hexin.op@bytedance.com>
Cc:     Stephen Boyd <swboyd@chromium.org>,
        Kees Cook <keescook@chromium.org>, linux-kernel@vger.kernel.org
Subject: Re: [External] Re: [PATCH] debugobjects: add missing empty function debug_object_active_state()
In-Reply-To: <CACKzwj=ZybyemyAJLcV0GOyPE+dQYz8r+tNvv67AaniJJg7tDA@mail.gmail.com>
References: <20210617071027.60278-1-hexin.op@bytedance.com> <CAE-0n51T9ZGADCk6LaKJdnQwPvMCawSvjwUP+AF0hFohAFom0A@mail.gmail.com> <87wnqpdco2.ffs@nanos.tec.linutronix.de> <CACKzwj=ZybyemyAJLcV0GOyPE+dQYz8r+tNvv67AaniJJg7tDA@mail.gmail.com>
Date:   Sun, 20 Jun 2021 13:09:05 +0200
Message-ID: <87zgvkg5da.ffs@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 20 2021 at 13:52, =E4=BD=95=E9=91=AB wrote:
> Thomas Gleixner <tglx@linutronix.de> =E4=BA=8E2021=E5=B9=B46=E6=9C=8820=
=E6=97=A5=E5=91=A8=E6=97=A5 =E4=B8=8A=E5=8D=8812:47=E5=86=99=E9=81=93=EF=BC=
=9A
>>
>> I have no problem with the patch per se, but it want's a proper use case.
>
> Yes, config options ensure that there will be no problems. But when
> CONFIG_DEBUG_OBJECTS is not set, we should provide all empty
> functions that may be used.

What for? Just that we have them w/o users? If someone needs it w/o
guards then we still can add it.

What's the actual problem you are trying to solve?

Thanks,

        tglx
