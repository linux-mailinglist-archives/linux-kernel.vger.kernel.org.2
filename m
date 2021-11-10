Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3764C44BADE
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Nov 2021 05:38:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230366AbhKJEkt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Nov 2021 23:40:49 -0500
Received: from mout.gmx.net ([212.227.15.19]:51665 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230357AbhKJEks (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Nov 2021 23:40:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1636519069;
        bh=DpxA7OMbSJcqPkO09lUDBIH0m5uZiuKEOS13QI73+d0=;
        h=X-UI-Sender-Class:Subject:From:To:Cc:Date:In-Reply-To:References;
        b=GRjQqXiRAfs1hjOGKf1G/hK5RiQO2q2pbmLPL86H7PQyFRwdVR+YuOYwMvo4MlOYg
         9boKzPCRhMRcF+PAm02qnTdyr1jvpLd7fwoDulx1ckrkfvNcNgp3D7MRlyqtuM05h/
         lvat/sjkeSiP4iXSZKKYmT6SJco1Tiu3yo+D4E18=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from homer.fritz.box ([212.114.172.107]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1N8ob6-1mgvzn1xnq-015oBM; Wed, 10
 Nov 2021 05:37:49 +0100
Message-ID: <beec14cee84de7a4bedd7a63c2acdf150a82bc09.camel@gmx.de>
Subject: Re: [PATCH] sched: Split preemption model selection between DYNAMIC
 & !DYNAMIC
From:   Mike Galbraith <efault@gmx.de>
To:     Frederic Weisbecker <frederic@kernel.org>,
        Valentin Schneider <valentin.schneider@arm.com>
Cc:     linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>
Date:   Wed, 10 Nov 2021 05:37:48 +0100
In-Reply-To: <20211110011738.GD288354@lothringen>
References: <20211109151057.3489223-1-valentin.schneider@arm.com>
         <20211110011738.GD288354@lothringen>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.0 
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:oM3iQXdkOSBVEdUv2AQSd3PPuGcrPh9sE4tn9+iJEQwdjhWdmwv
 GpgsyvW0zCbTzQxkhtyvww9F3o55ERdyquQLQivuOIu+tgPqiyxy0t3iAtkRwRVdyyGgmXp
 4yGnXZvZE0VKfHa2dHPCpNHWuUXVDoE8XcLQ26ZtEIx9EiLgK9oI+StVngMGdrE0VlquGB1
 q7GRkxoyQx/CnHerZ4bdQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:n22W6p+mgNQ=:TIoc8TEmV7hUcRfUFMLjwX
 zxR0u3T8D34dEmgwioRDf7JwLeZJ7r3sXs9UHkExKegZf0CUUKMlumyOXmmtJ4Qy95CtqkXaF
 TTDNPdshhJxHDHTeBKACChM+6ezvRkbvjqo7c369StHC/SHlR6Hlhe29twAuXV7XU72DCn3L0
 vEAAGbuLhS9Z5l8q8TUtZZPJ84eJWQ5ayCWOXoUwvLq8smE3z5TrPusw8r3CEaKE4VRw+4IDl
 uqXhPV9AfzNkWN4nHTU9F4UKBcWalcleDM+8pXlfZERpigu2GyTjlXqPAp7pChg8fhpOvmoHC
 15ASpjkRlUVpQBn5xt3KvKINnzpFtGur61+mCYNUddNwHoczQQ7qke/LlA3CQ8hzPnhK1C/CR
 B2Gobr3eBzGKRJiGgo5R8ZWKd02PxBPQj6wXix9C+sMZLMUsSJKt991J4RgkBeJoK0kJvPgIt
 nX05taaP3FcV7uSk8oZLyd8j3Gg60uGshq8MP0DPkAYX8nhOBCeC5KzmWheVjt+7sEQYOV6ba
 DTx7MLdN7C+64ZwZcmOqKFFaghya/kvxY6O6YW2N/+T8fFHZ5hdA6z6fR9k90B183J4FB6ZMd
 Nd34GC0yjzwOm5auKPvzKdmIZom0LFuUmIPGdpgbbM3lj5enTyI1AkDudV2RAJHnKC+vfwNQW
 fEoT4pH+maH9fIbul4nIu40GBV/D6ldB4rWAK+p0vVW8k4EeWuQiwOhG7jHcox1602NXHoQxF
 ML7Q80iO1w19gNLnBP4Kop/lvwwtETe4sEvI47JvP9Lns4+I9GWMowaUWIc/FhCwy4SyfL67P
 xPQ3u+d/nD3nV4KPDwnrSW0Iyjij7zdfDWsK3MdTgLUAlD6sTTCG7baZEWhPFAvHGCuFXuAt3
 6y49wiMBuk5u1+9ZskDkuZ2Hi4M/3GSNXAJ9N6LdmL0kGTaJo3Xiw4tO/4ZDNGKm4IoqlthoL
 uujfmxAuuSsP0iHspL4Ws4j8hA8EywAILFmgFRKBYZQersmDgurkqYc/HZ1JSo0hWegL+clUl
 xfDJ3Cs6xU6WYkurZQupLEc/x9pt5poVwmjT4mZhQerWvONfkgnrnCvp1Fh8XSeVPWPTvh8oP
 J8VhMnrh1ejUaY=
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2021-11-10 at 02:17 +0100, Frederic Weisbecker wrote:
> On Tue, Nov 09, 2021 at 03:10:57PM +0000, Valentin Schneider wrote:
> > +choice
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0prompt "Default boot-time P=
reemption Model"
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0depends on PREEMPT_DYNAMIC
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0default PREEMPT_NONE_BEHAVI=
OUR
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0help
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 This option defines =
the default preemption model of the kernel
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if it hasn't been sp=
ecified by the "preempt=3D" command line parameter.
> > =C2=A0
> > -config PREEMPT_VOLUNTARY
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0bool
> > +config PREEMPT_NONE_BEHAVIOUR
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0bool "No Forced Preemption =
(Server)"
> > =C2=A0
> > -config PREEMPT
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0bool
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0select PREEMPTION
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0select UNINLINE_SPIN_UNLOCK=
 if !ARCH_INLINE_SPIN_UNLOCK
> > +config PREEMPT_VOLUNTARY_BEHAVIOUR
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0bool "Voluntary Kernel Pree=
mption (Desktop)"
> > +
> > +config PREEMPT_BEHAVIOUR
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0bool "Preemptible Kernel (L=
ow-Latency Desktop)"
> > +endchoice
>
> The problem here is that you're duplicating the existing titles
> for the static entries and you're losing all the help that text that use=
d to come
> along. The point of the BEHAVIOUR thing, further mapping to either
> static or dynamic preemption, was to avoid that duplication and keep the
> same titles and help for the three behaviour, whether static or dynamic.

Adding "depends on !PREEMPT_DYNAMIC" to the first (legacy?) choice made
it appear/disappear at the appropriate time as well, but I have no idea
how duplication of help text can be avoided.

	-Mike
