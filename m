Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C046E34199A
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Mar 2021 11:11:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229843AbhCSKLH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Mar 2021 06:11:07 -0400
Received: from mout.gmx.net ([212.227.17.20]:50503 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230145AbhCSKKt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Mar 2021 06:10:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1616148626;
        bh=rL1lZ3nybqpgHhHesEY4O8QpbrA07VJjQ/mlO2z140s=;
        h=X-UI-Sender-Class:Subject:From:To:Cc:Date:In-Reply-To:References;
        b=We85LH8voba2c53P9U/icBCNBh3nkdXeFgfX6l/nIE5+6G5VFXDft5+KXcqzSvmLs
         jcO5JYAxF+VBQ5zb/Txwe66hyASaeTErJMqJNmLms8pOjtj09zpLH1ZJS9o/J50UL3
         /jGULQrLIY9mAY4YPBzPpmcEhsMVyh52O8E+5M+U=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from homer.fritz.box ([185.221.151.223]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MEm27-1lUYsj18fr-00GGhB; Fri, 19
 Mar 2021 11:10:26 +0100
Message-ID: <78175768ecacb0a180c91813bbf752775882c687.camel@gmx.de>
Subject: Re: Re: [PATCH] futex: use wake_up_process() instead of
 wake_up_state()
From:   Mike Galbraith <efault@gmx.de>
To:     =?UTF-8?Q?=E7=8E=8B=E6=93=8E?= <wangqing@vivo.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Darren Hart <dvhart@infradead.org>,
        linux-kernel@vger.kernel.org
Date:   Fri, 19 Mar 2021 11:10:23 +0100
In-Reply-To: <ADIA4QBfDph6an7WJnsk3KrC.3.1616145348005.Hmail.wangqing@vivo.com>
References: <ADIA4QBfDph6an7WJnsk3KrC.3.1616145348005.Hmail.wangqing@vivo.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.4 
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:u55wlKxout2SG9heNow65CgyBvDYXM0YYk5nkYT1wjuRXib59ia
 Lw8jxWtHVODe9UDTgvgkMbOfl5SJDwSr8hyefxDTyHuQh0wxl/Qp87tHLwEiCl5ZxBfX3jn
 kChIl3Xqor1Dj5pjg2vRUwEU2IHW+i+wtCpGpxL//2WWeQhpGAELEhQwcZQhZUHP5U6puhd
 s6sXSBCV7jbwHOt3nAG0Q==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:cYmKCsOE2tk=:HzSlpohHQxQPS9TCk4i39D
 IgZRKHUG0kUOgUns/lBdt6kmoGEBOtEjZGnJrP6ml4z5Z1ccPSh/7isrCx8jqgaer4VeACxzY
 CSc5j6QMnvAPhUx7+VgF4jjt7/gerC3DEq7gtiXRhFC68pxNYgjXaowgwG+WLJ5xvwPHLF3AO
 swlzIg9L6K+RT4FUD4+zbeGnrlPlXMenGcJczAaAxrNjnGqFmdIXijdfqTh71FbqJVut3UwPI
 2yFMNDSvhqpffdGS7O5UiqcjNZfIfoKQNMN60miVBC9nMBAwq448v1tGkvNIBohZK3JV0DFW1
 3hMnJK8irL4QfsUjTNmViuN1BudNyZXj7y6WWXaD0uEZoDDJdkzgIk3KelWO3JzPyknyqDdcm
 2Cxx/3hlJrrnYIJbjYgsDHvesZfDp2lrZnlQcgU6tJNlfcZyUCWfdtZQ+gNwx+98I7spJoJCC
 NCT6dbsHSJ3wv17ikFAmsvzaBy054SEkaObE9FDZCqct1lY4RJdQ36f+NymZ+WGsr2dIM5yrJ
 XxH37tOQcRi0Sf5+AiNjG4jakjmcKNBKlhVwOmSECBFvCkbRdfrosk+cOIq4H0RESMgv+Ntuj
 ssvD+6paQXQYdgUK9WK6RAS5hVVWNRRPZLP/lfEVtpLxIjyBvmRJhortOcN+vDewMl5inEFz9
 dpTkFgKrFIjaVbNzeVP1xatQA87u+2hNH2vUoVclIsl4HXOr/h53GvGRy6Qq2OUqMYy8PsxEb
 OZidK5RDXydBRnI7TLCDSJrvjSHbsQwphdyohuDlduiaM+ajhdXIdbmR8Q3J41YW+Mzw5FDxG
 ZBGQP2Yp8eRnw50pvvk/60zGCRBlQw4BbZXdvQU5llxY2FA/yS8lkOFgO3fVR737dOE2ij+I/
 a073YELP8BK/SWsHH/k/nK/Ohc3QDtE81FDbtJWcFTyNb6kI75pdGjBEpOEy6uau233HZCT0a
 je8ffc0K1B1Y+tC/P8P+x+Oe0ruEn7T+Jbp5Km1PQjojnCXauT12ecTtWlkvplv/1lKfRCXqr
 vEONY9kXjMyNLExzqWde7N3mEB2+SMR9elXr3QuYIpYywSd98eGjgFNEkxQ6OmJyAHqyfI1LF
 xvgMAEY0Umxh8yPWQFLlEVERe3n6Yg414cLRFYNqo/Vrr1UArsk4LvNyhqDOK614i3fl65C+Y
 aV974KUiKBfK7rPyaX9Hne/ke8Nc61ogiVV+JJ0UXg5+uztD1OWBVvaz8ez86MZttFU9o=
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2021-03-19 at 17:15 +0800, =E7=8E=8B=E6=93=8E wrote:
> >> On Fri, 2021-03-19 at 10:59 +0800, Wang Qing wrote:
> >> > Using wake_up_process() is more simpler and friendly,
> >> > and it is more convenient for analysis and statistics
> >>
> >> I likely needn't bother, and don't have a NAK to paste on this thing,
> >> but here's another copy of my NOPE for yet another gratuitous change
> >> with complete BS justification.
> >
> >Let me try a bit softer tone.  I think you're trying to help, but
> >ignoring feedback is not the way to achieve that goal.  My feedback was
> >and remains that your change is not an improvement, it's churn, but
> >more importantly, that changes require technical justification, which
> >you did not provide.  You were subsequently handed the justification
> >you lacked by none other than the maintainer of the code you were
> >modifying.  He told you that your change could become a tiny kernel
> >size optimization by converting like instances all in one patch.. which
> >you promptly ignored, instead submitting multiple patches with zero
> >justification.  That is not the path to success.
>
> Thank you for your reply. There are two reasons for sending patch again.
> One is that I think this is only an improvement in format and has no
> substantial impact, so no verification is required.

No substantial impact is not an argument in favor, quite the contrary.

> The second one is that I want to hear more opinions from the maintainer.

The highly qualified opinion Ingo took the time to hand you on a silver
platter was not good enough?  I'm starting to regret being concerned
about having potentially discouraged a potential contributor.

> Because the entire kernel may have similar problems, I have to figure ou=
t
> whether this is a tacit behavior.

My obviously misguided concerns just appeared in my rear view mirror.

> Also, I don't understand what you mean by "your change could become a
> tiny kernel size optimization by converting like instances all in one pa=
tch".

Go back and read what Ingo wrote.  While at it, read what the other two
maintainers who chimed in had to say before you consider doing any re-
submission.  The low hanging fruit you're trying to pick isn't anywhere
near as juicy as you seem to think it is.

> >>
> >> >
> >> > Signed-off-by: Wang Qing <wangqing@vivo.com>
> >> > ---
> >> >  kernel/futex.c | 2 +-
> >> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >> >
> >> > diff --git a/kernel/futex.c b/kernel/futex.c
> >> > index e68db77..078a1f9
> >> > --- a/kernel/futex.c
> >> > +++ b/kernel/futex.c
> >> > @@ -1820,7 +1820,7 @@ void requeue_pi_wake_futex(struct futex_q *q,=
 union futex_key *key,
> >> >
> >> >  	q->lock_ptr =3D &hb->lock;
> >> >
> >> > -	wake_up_state(q->task, TASK_NORMAL);
> >> > +	wake_up_process(q->task);
> >> >  }
> >> >
> >> >  /**
> >>
> >
>
>

