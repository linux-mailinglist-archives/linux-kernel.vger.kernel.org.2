Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C8753F45ED
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Aug 2021 09:44:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235140AbhHWHpG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Aug 2021 03:45:06 -0400
Received: from mout.gmx.net ([212.227.15.19]:38733 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234940AbhHWHpD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Aug 2021 03:45:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1629704641;
        bh=vdU4SqHf7ge2RbpNt68iHCwDufd72LRd0wLyAczRbDQ=;
        h=X-UI-Sender-Class:Subject:From:To:Cc:Date:In-Reply-To:References;
        b=HpuRqLSgr4yOerjCm8hW/7ydeCgfoqj2dPW/7WJV3pHnlT3lZR/7R6pA4bnqjb7o5
         0vulaVZ2Y1pTR1nTldYqlaB3/EtdvlZFC5eBbtML1XoRKn8aP4tyKBU7Z0B2pPRmFe
         tX7LqKZRxbCTMq2hu1wzDGF1sUv8YEgrP7gNbiWU=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from homer.fritz.box ([212.114.172.232]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1Mz9Un-1nCUrr3EFH-00wHM0; Mon, 23
 Aug 2021 09:44:00 +0200
Message-ID: <275a0f09654cf5644cbc5731fa031b218eed6d38.camel@gmx.de>
Subject: Re: Re: [PATCH,RESEND] softirq: Introduce SOFTIRQ_FORCED_THREADING
From:   Mike Galbraith <efault@gmx.de>
To:     =?UTF-8?Q?=E7=8E=8B=E6=93=8E?= <wangqing@vivo.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Michal Hocko <mhocko@kernel.org>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Will Deacon <will@kernel.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Dirk Behme <dirk.behme@de.bosch.com>,
        linux-kernel@vger.kernel.org
Date:   Mon, 23 Aug 2021 09:43:58 +0200
In-Reply-To: <AJEACAC1D27qN9TVG8Nujqqw.3.1629700439268.Hmail.wangqing@vivo.com>
References: <AJEACAC1D27qN9TVG8Nujqqw.3.1629700439268.Hmail.wangqing@vivo.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.40.3 
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:q7hWs4qhhqDoSey/6ghUiouWmoWiRLD6tLJi3s1a3JLbRFEGhe7
 X2hnmBYEZ+2FpwugEEbpA3S1gIktQDM1aODpqwuFNmtSbROVKuFbXxaNRUyke++dXSlxBKQ
 y9XPjqo66TCHg1eM7ONFUzNtBbYE0qOnde22jGRYVh1391SkRKvxPJKYrt/9TJVLqxK3aSW
 m4x9BG/zR1j/P/y84hH+A==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:+w53KnWJzrc=:2nVmY3KDPm1fE7n1JneFDN
 JjWAiGDZj/adnm1/gXmek4ACcoCBWaXicjpuFYa4LWCD+z/dBQfEhguzyi2Jhy2Rw2/3M77yt
 Xxq7B8Pm3YJiCGNiDGaHyoFFQo2lpL+3/ybAFEmEXQHjo3R7FuJiQd3G6g5FNNI1z3NCUWIWQ
 D8pCVnmvGKiOvcJNHCtwmdKlRuG79ZmX2gkJUBefBS5A9xsyLfwZ8/aPkcQXZHHMuR6pN30pA
 VzrW86v8X0EZhSCn4nXESdErmHCZI1CPSP1sZWRDgleu8rLzugvlu/2aeiqmeWTuZrVeT9WX5
 vOB4j0APPOi+JYipxgzKRurV5PGBa+vmqT1550Sr5qwtji8PezKj7W+IlccPKNzbJIo0eBAoF
 B50/q6DLX8qMFINbZZJSMpOny9zYw3JjJumnMon3GktoDPsjYCMB8V0eJF3pd2GZqJvVKaosa
 zG3nU5Yet1W5kH3dtOsinCz4th0E5dIYzDDTu9SX0aYizJ+Ip2fK8ntwFVmeDpNjtCiHYAbrQ
 A/6iDshtv3yywym9ldyMYdaxkWC80duddaCbYPmNNIQJH255Zj1u+cXiytvKaoJ6sny76PKm9
 cjU1iaPSnFOV4jGVUybpIn4SoFRjuexmrGu7wsLcXSkR4qdkaFchLVVqdi0MjucLe6Y4NfUOa
 rE+f6yrtrQzgnp+kqbZV9vFfeqct7oZ4MLLxYvnTL96TqMvWn3hxRzbiSgTMh2k2wKctFoUSi
 KyMmzbkaDE3XUpikmHxQE13LVSVXZXeyLPZ5vuTZTsZIfOm14nfBMzl1SC13H7NN4VSVeBNYS
 TSlg1jOsc3xeFEJ30dpdC5iln9ixfIw356MM+dQg+YGM2zCuKZIHYzuiQn12vTOl8KJPYG79V
 xWoglWRjCZrThkPil3jjobJklV/+bKjI1GhgfK9s1CLZx0DcKV0l/+UbAhYLCO5g6X4ncEEki
 dm0Cw/QYn/HEWBOiomIGznO9BuWXd7cbWG8NhbAbTJciUIWNK19Or2YH+Oo0p6PnQiZ4EwH0s
 QkYJA04rXePKSw9mdervOZPa79G5SKhMCISiMCJY2WAkBLfNkVoGA73AZEegS9wiI2/qn9abW
 8ERwaM/St7QXtmQSS7nyxrCDihnkaSSCVlQ
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2021-08-23 at 14:33 +0800, =E7=8E=8B=E6=93=8E wrote:
>
> > On Mon, 2021-08-23 at 11:33 +0800, Wang Qing wrote:
> > > At present, whether the softirq is executed when the interrupt exits
> > > is controlled by IRQ_FORCED_THREADING. This is unreasonable. It shou=
ld
> > > be split and allowed to take effect separately.
> >
> > Decades long practice suddenly became "unreasonable"?=C2=A0 I think no=
t. =C2=A0
>
> "unreasonable" may be my misnomer, but it is really necessary to separat=
e
> softirq from IRQ_FORCED_THREADING, which can be effective separately.

Well, no, it's not necessary, but would be damn convenient to you,
which is of course a perfectly fine motivation to post a patch :)

> >
> > Trying to carve out bits and pieces of RT to merge immediately isn't
> > likely to make the ongoing merge effort go anyfaster or smoother.
>
> I am not trying to carve out bits and pieces of RT, but I encountered ac=
tual
> problems in my project. For example, in Android, we will not enable
> IRQ_FORCED_THREADING, Android is not a high real-time requirements,
> but in some scenariossome, RT processes cannot be scheduled in time
> and the frame is dropped due to the execution time of softirq is too lon=
g,
> also some softirq cannot be executed in time in ksoftirqs, and delays oc=
cur,
> such as IO.

That didn't parse well here.  What you seem to be saying is that you
have a hard constraint that can't be meet, yet are unwilling to use an
existing facility to resolve that issue because the kernel you're using
is not _intended_ to support hard realtime... therefore you want this
other facility to enable it to support your hard realtime requirement.

That can't be right, but it doesn't really matter, because...

> Therefore, why not give the user a choice to balance the execution of so=
ftirq
> while not enable IRQ_FORCED_THREADING, so as to meet the inconsistent
> scenes and needs

...it's not my call, I just found the language rather odd.  It still
looks to me like you're carving out a slice of RT.

	-Mike

