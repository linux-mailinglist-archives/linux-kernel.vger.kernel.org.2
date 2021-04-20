Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D60436527E
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Apr 2021 08:44:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230149AbhDTGpZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Apr 2021 02:45:25 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:50290 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229577AbhDTGpY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Apr 2021 02:45:24 -0400
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1618901092;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=LC+6IgI9HH++U86icU2VDAlo7EhsD7/YM0UYck7wWbo=;
        b=28Go/CnW7yN4B3YXPBBdEsD8TRHi6BIMu/4AobIiJ4wxU8onIVq2uOzi2n3Fm2uRgTGz0x
        lLAn+JGMV8lhwSzxRVte8UzaFbCJ0kd8vc/nc+JJBay787St0HfVKkWigqo3CrCFLxauEL
        Hdzzirf6tSyPU/5TXgdUy5hCYuXZLvp6wh8HUZA7vuGF4YgQy2HSyrMx4wsnx9SuCNedTM
        iREGHD1i4miFPTXxA8XSoEb7ArUcWhh6PZNCPUZrnJ5V+gkPxf3s80bPYCd6QuyhIbwmfE
        GV0OdrKBGKxPyjWr6eIn3AYj3bonXIEdG6hBo9YtdNadatxbcTP4JnxTq6l3Ow==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1618901092;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=LC+6IgI9HH++U86icU2VDAlo7EhsD7/YM0UYck7wWbo=;
        b=nLNeVLS0jmwS9XdXnbeRnmi5sfnQBNxzu9s/Bd/S0wqSoDe88pUrgSWs/GfJpm4KSUeRSF
        7871JKwJl89IosDg==
To:     Maciej =?utf-8?Q?=C5=BBenczykowski?= <maze@google.com>
Cc:     Lorenzo Colitti <lorenzo@google.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        Ingo Molnar <mingo@kernel.org>,
        Anna-Maria Behnsen <anna-maria@linutronix.de>,
        lkml <linux-kernel@vger.kernel.org>, mikael.beckius@windriver.com
Subject: Re: [PATCH] hrtimer: Update softirq_expires_next correctly after __hrtimer_get_next_event()
In-Reply-To: <CANP3RGcX11RS=rwbem7+5it+Zu072sd15pHHFHjCFkXk11qrgw@mail.gmail.com>
References: <CAHo-OowM2jRNuvyDf-T8rzr6ZgUztXqY7m_JhuFvQ+uB8N3ZrQ@mail.gmail.com> <YHXRWoVIYLL4rYG9@kroah.com> <CAKD1Yr1DnDTELUX2DQtPDtAoDMqCz6dV+TZbBuC1CFm32O8MrA@mail.gmail.com> <87r1jbv6jc.ffs@nanos.tec.linutronix.de> <CANP3RGcX11RS=rwbem7+5it+Zu072sd15pHHFHjCFkXk11qrgw@mail.gmail.com>
Date:   Tue, 20 Apr 2021 08:44:52 +0200
Message-ID: <87im4hqwt7.ffs@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 19 2021 at 20:12, Maciej =C5=BBenczykowski wrote:
> On Thu, Apr 15, 2021 at 9:47 AM Thomas Gleixner <tglx@linutronix.de> wrot=
e:
>> Run the test on a kernels with and without that commit and collect trace
>> data for both.
>>
>> That should give me a pretty clear picture what's going on.
>
> Lorenzo is trying to get the traces you asked for, or rather he=E2=80=99s
> trying to get confirmation he can post them.
>
> Our initial observation of these results seems to suggest that
> updating the timer (hrtimer_start, which seems to also call
> hrtimer_cancel) takes twice as long as it used to.

Which contradicts my measurements. The change in complexity is marginal
and the overhead in cycles/instructions is close to noise. It's
measurable in a microbenchmark, but it's in the < 1% range which is far
away from the 60% you are seing.

> My gut feeling is that softirq_activated is usually false, and the old
> code in such a case calls just __hrtimer_get_next_event(,
> HRTIMER_ACTIVE_ALL).  While the new code will first call
> __hrtimer_get_next_event(, HRTIMER_ACTIVE_SOFT) and then
> __hrtimer_get_next_event(, HRTIMER_ACTIVE_HARD)
>
> Perhaps __hrtimer_get_next_event() should return both soft and hard
> event times in one function call?
> Or perhaps hrtimer_start should not call hrtimer_cancel?

Perhaps we do a proper analysis first :)

Thanks,

        tglx
