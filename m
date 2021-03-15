Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F082E33ADFA
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Mar 2021 09:54:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229558AbhCOIyZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Mar 2021 04:54:25 -0400
Received: from mout.gmx.net ([212.227.15.15]:36501 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229548AbhCOIxx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Mar 2021 04:53:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1615798423;
        bh=9LPM0fmN+fChJ623QJDgEpzb11FP7MLKIUhX7p5i7Yk=;
        h=X-UI-Sender-Class:Subject:From:To:Cc:Date:In-Reply-To:References;
        b=DMwMUDlY8dLN13Cox3u+QsZ3CT/6W1rux+Q2KS34DIal1kgS1gCFFd4DMU4mKUeA1
         5z/RRveK4qOfIreZjxkmzpJVx0RE+bgrDh4fqw84YLcaj9IrNlp2MdyvDHuM1Xs2Zj
         LCY+flbIhO9OjzbEk80kHPV5MxLG6VT96hOcgnJ4=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from homer.fritz.box ([212.114.172.46]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MxDkw-1lfkrv2Q6C-00xZI9; Mon, 15
 Mar 2021 09:53:43 +0100
Message-ID: <d1d64307bf834d263bd57be84ca701eb2bc34ca2.camel@gmx.de>
Subject: Re: [bisected] Re: nouveau: lockdep cli->mutex vs
 reservation_ww_class_mutex deadlock report
From:   Mike Galbraith <efault@gmx.de>
To:     Christian =?ISO-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
        LKML <linux-kernel@vger.kernel.org>
Cc:     Ben Skeggs <bskeggs@redhat.com>,
        nouveau <nouveau@lists.freedesktop.org>,
        Dave Airlie <airlied@redhat.com>
Date:   Mon, 15 Mar 2021 09:53:42 +0100
In-Reply-To: <9947f244-762d-0937-f77b-9f650f3df4cf@amd.com>
References: <987bd1ca15545ca896c4e1c115e89a1bba0ad306.camel@gmx.de>
         <95c41bb3988882c202a2b7d6802f7528682e26b1.camel@gmx.de>
         <9947f244-762d-0937-f77b-9f650f3df4cf@amd.com>
Content-Type: text/plain; charset="ISO-8859-15"
User-Agent: Evolution 3.34.4 
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:TL6c8Zmu/npCbiychLdOSpkiu2u7a0gVhPIWy0F3Ez5slzFz3Kt
 iOO4uZi31cI6Nwy0crbnLeqfDHj3zuFVfORD8wMQQNnsrEk2AWkcBlKZc+53IOpi8Wf0o+q
 ow+s4qcdYElAgiHKPGCNeaknX0/HQWDZcCo42h0rjuL+Es/T+KdRl/tVHl6yOQkoZBs2EZ8
 e2sFRK6XdDA4S6LdNCb5g==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:WrsebH+Cvxc=:Izfjx++GNYof6uHOUva9wA
 B8Isr+Jf/POs8vbRtRfSxZGl6JJDGgakeYtKSo6wPjcdDd634BHPvRuVkbdVUNlfzhswzGv/J
 +oP6IfD3izSyxk9KP8BScDBbdXkPafujLPGc4ADefFPSPWH8Sg0wF+/h/TAKunpv+Fqcinhme
 /ZTjywgbD4aoOS38s+yvsyX8V54/jyvufIRjpTHbX03j7xMQmoAYsfIEvTymx/Dq9/odTFgmZ
 JXQPnaUKqoe+xNYMgAQoLQCDjtTUzA5BlqfxVSAVIOWsJum6SDd+Reebn076oL2Ro+OJY2z9V
 STlCgZBDlhr0GHPpVdf4c7s+zAcYwYe+6lS02F9s5JmR8ZUQSlWMWyh6UY+BPIZ4cqnX038dR
 JzzVr2jF02rK4CygUVYPZVO8KspQ5ye/fVd11bsILchm6YlDPq4+fFUhcYV92UUpy+e2D0XSW
 c3IVmJe/lfm+IATY5zFwhycgfsReNgVIezKLZRCk+bcJm4XkLM8kS5/oujjPOcSKDh5ZQbttA
 oYIVwCHo5PODWUF0T13/SYTRvIjbOTqY2LorGzQBbcSP9tNyWODh+KpyzQT4W6yi1PLRZsd3q
 6M8igm8dNWty3NKBTqhtV2M2TB+PeQTCF2HgGGPM/jaHyEtRJRQ8B803T2qUxybABR+yTiC8U
 06Vk/W2GA2GHmtO8+xkBDTTWLonApenluamvtpazbTFEAcRR3NhZJYPEbYd3uChfaawVOqlNu
 9zxjgeivtu8lwcVRkWmiZOpW7upr2Jw4Mm4nEHNYtUwnjHyjQgq64Tzl2QHXM1IxH4QWHm7d7
 SvUVluOik248RaQdZNWEicalv5PPnofBuPpljz2uppXu2uHt06/gaN/xuLlTh3+N78HuDQLr6
 F89hHbsXGbHRfOk68buA==
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2021-03-15 at 09:05 +0100, Christian K=F6nig wrote:
> Hi Mike,
>
> I'm pretty sure your bisection is a bit off.

(huh?) Ah crap, yup, the spew from hell you plugged obliterated the
lockdep gripe I was grepping for as go/nogo, and off into lala land we
go.. twice.. whee :)  Oh well, the ordering gripe is clear enough
without a whodoneit.

	-Mike

