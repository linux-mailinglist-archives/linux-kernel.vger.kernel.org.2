Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 29AC144BB5D
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Nov 2021 06:45:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229922AbhKJFrl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Nov 2021 00:47:41 -0500
Received: from mout.gmx.net ([212.227.15.18]:37137 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229572AbhKJFrj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Nov 2021 00:47:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1636523083;
        bh=eQJvjyDXd9/NnjKwFms2Jb3Wg/GnVPYrpBreiYi5at4=;
        h=X-UI-Sender-Class:Subject:From:To:Cc:Date:In-Reply-To:References;
        b=D5pCkv3YQ6Z/is9CV0HJOpaPaoCUs6ddDd+eLTTR7XJIj4eDnX68C3G/EeuPap48J
         lZlSSdWDBrbR9G2tZWP83NAsPpPHnWStYzdXYGeU59Po99QVk35C0WOVe2zkMR/ji7
         0sRRMk4dKHXQXRO8hrNPEUqetYANjZeKkK/rQSxg=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from homer.fritz.box ([212.114.172.107]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1M2wL0-1mjZPr0Z6C-003ObQ; Wed, 10
 Nov 2021 06:44:43 +0100
Message-ID: <b38c31be32d779800edcc49aa93dc45eb28d089c.camel@gmx.de>
Subject: Re: [PATCH] sched: Tweak default dynamic preempt mode selection
From:   Mike Galbraith <efault@gmx.de>
To:     Valentin Schneider <valentin.schneider@arm.com>,
        Frederic Weisbecker <frederic@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>
Date:   Wed, 10 Nov 2021 06:44:42 +0100
In-Reply-To: <87k0hgswpf.mognet@arm.com>
References: <20211105104035.3112162-1-valentin.schneider@arm.com>
         <20211109102502.GA288354@lothringen> <87k0hgswpf.mognet@arm.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.0 
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:VaQOTFhL3R7uxCD4hLqyvBcxePP1UhGUhCWjnB5SseE6Jll3PaB
 om66+vmVV5iIt/RbHZ1jyoB9Z7ieyQS2lf0/S7h2x5Do7CV0CvaK8va8PBzGE+9sPlVlKCt
 jaK3UdcvEU1fWv9crJXcvOyyR3AZDLYNWiFt2WKSJ40muMjNFj+9cCPxcxTIxvhIFm4OyfH
 NlVLlKxR/02MOlQw9jM0A==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:fzV3ocTrGFM=:e1f13SHqPGrYNAi8mDgqDt
 Za9x0C6CWMgWPmMqgO5hEBVUDfkD7Y7WOHjT1vNSNYK8Ac/V8dxNQ5qJx7rRraohWNPgez6Fy
 wEJz9hfcmttO1l9jS0Ki1eE62le+LuxG9XFX9dWPLey3zND7W/Pjw2IehxvMoEWkON3j+fhcS
 O8hULYoN3ATaknQQktcoDccKUAKUj+5WrFXA8bgKTZs0N0fZBxZhjAYNJ+601zd07KUAVLKmr
 jJyU01zWMO5hbTZVogxx1CHFQfuOQblyX5T3T12prQP6rvqr9uVKzX0fjUfTB+G+svy2B2VZ+
 8ANL8CgyO/TSMehM6pt0+ERe0+9Ceomz3pDRc8v+rhpdjDapperiuVm/wtIS9eCj+Bq/r13Ws
 rWLwmUtrUMaJHNT561YMkHcLJmDLgLGDTfo+tbSNBu49lWlvClCnUeoMVnRLPZm+mmnLAPAsT
 wou3kxmhhkyhqpFid0G9VO+2JWFteoBTMitpdBZT78AVU6vym4eQbibKoI0nmhBSCax4Bwp8G
 SfgRJ67Ri83DC/xCYzR4yFRiWu90o8xa5/RBbPk+6UmVnDPpC7XRslAKOZOo3wpDUjstp/hvM
 txPFDBLtrSMTocfdbuT3/3zD/rFSHDeNo5PnE1aowAQniDrNe5sPGV6BHexP8iNVncjJGq8+p
 72sAJqDnKWxA07qp4GxyIRdkixpsblQ7MRPMkq5GZsIkHZOSyZ9X582nKVQHCz8W3cjKW9vjf
 0NL7YOkSDx2DyQlnObYp4SyQ8TbiOILmap0yCv/ljPF5utk2KR9ms3y4FlwXuqDosXgMAteEX
 FldoC6F1z0C88HxUIoUi/Go5d7TPMYOGYzr0CMHZPjSpp05hx2UxlqP7PXCZP9jSHTbmS0bx4
 Kkj5oPI09eKdgc4bUC6ZkaQYt8vMQyHDPuviaKd5xhZpDkfxeVZehIG3Au/FL+mWrviMIgLuH
 jOB+aWiplA99raihLPGF+OM0GiwP8FGeb8vHZL78rdvHQDSqWVdlCoBszc0vPNtif4oJi5CLN
 Q7xoUNzDjDx5OpcS/c0hNcWKsotIj4wB9hAjcAR6NUZFshgbnA+ul3YYRO+YbZzghCd59yKjR
 dZfqi4QYcnVLlc=
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2021-11-10 at 00:03 +0000, Valentin Schneider wrote:
> On 09/11/21 11:25, Frederic Weisbecker wrote:
> > On Fri, Nov 05, 2021 at 10:40:35AM +0000, Valentin Schneider wrote:
> > > @@ -75,17 +86,6 @@ config PREEMPT_RT
> > >
> > > =C2=A0endchoice
> > >
> > > -config PREEMPT_NONE
> > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0bool
> > > -
> > > -config PREEMPT_VOLUNTARY
> > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0bool
> > > -
> > > -config PREEMPT
> > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0bool
> > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0select PREEMPTION
> > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0select UNINLINE_SPIN_UNLO=
CK if !ARCH_INLINE_SPIN_UNLOCK
> > > -
> > > =C2=A0config PREEMPT_COUNT
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bool
> >
> > This must be breaking cond_resched() and might_resched() definitions.
> >
> > Since CONFIG_PREEMPT_NONE, CONFIG_PREEMPT_VOLUNTARY and CONFIG_PREEMPT=
 aren't too widely
> > spread around within ifdefferies, you can:
> >
> > 1) Rename CONFIG_PREEMPT_NONE to CONFIG_PREEMPT_NONE_STATIC
> > =C2=A0=C2=A0 Rename CONFIG_PREEMPT_VOLUNTARY to CONFIG_PREEMPT_VOLUNTA=
RY_STATIC
> > =C2=A0=C2=A0 Rename CONFIG_PREEMPT to CONFIG_PREEMPT_STATIC
> >
> > 2) Keep the old CONFIG_PREEMPT_NONE, CONFIG_PREEMPT_VOLUNTARY,
> > =C2=A0=C2=A0 CONFIG_PREEMPT around for compatibility and make them sel=
ect their
> > =C2=A0=C2=A0 corresponding BEHAVIOUR entries.
> >
>
> Damn, I was too zealous on my inbox clearing and skipped that one, sorry=
!
> (and ofc in the meantime Mike and I went down separate rabbit holes).
>
> The old CONFIG_PREEMPT* would have to remain somewhere in the menu entry
> (e.g. "legacy" preemption mode selection?), but other than that it seems=
 to
> work with this kind of structure:
>
> choice
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 prompt "Preemption Model"
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 default PREEMPT_BEHAVIOUR if =
PREEMPT
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 default PREEMPT_VOLUNTARY_BEH=
AVIOUR if PREEMPT_VOLUNTARY
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 default PREEMPT_NONE_BEHAVIOU=
R
>
> This however doesn't solve Mike's concern wrt deselecting PREEMPT_RT to
> flip PREEMPT_DYNAMIC and vice versa...

OTOH it's not quite here/now relevant, whereas your config woes are...

	-Mike
