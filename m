Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2F8E634CD6B
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Mar 2021 11:57:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231620AbhC2J4z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Mar 2021 05:56:55 -0400
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:59109 "EHLO
        out3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231901AbhC2J4f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Mar 2021 05:56:35 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id 893075C008F;
        Mon, 29 Mar 2021 05:56:34 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Mon, 29 Mar 2021 05:56:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; bh=hlmPwDW0xIb+jOtVKY6Nlely5rp4huLJ54bPI4YY1
        7c=; b=lPrMq7DF/wVe7vN+IpzPFVw30uJIRCaBYUvhB/A+k7tg7F2w8k5S4MAJN
        B65s7ZpYrggNic5ZWMH3HApKD/FL7LgvGaia8EdPnBxIuARXjPmOzGzgu+AsNQYr
        uUU39nUjM2rBiZV4pl1RSfrAv1j6JmUL1n1jYg5YkRhjVYd5I1nwgxaFDTE6179x
        oAZT6Qmmv70+ykTKDsBtwj86opiEnfzjbEUhfyXxxsMft1aLEP4MAkJ9vKQR99mG
        P9FkGzH8F4Zo1aUNkyUrL8kevooUvcbqIsH1PSWU5OTggx/R8uH/Zu4879Tko3Z4
        c/N/CvXFGD0pdP9rj0RZIOb1CfDcQ==
X-ME-Sender: <xms:UqRhYPwUMZO0Pu2_gB_aXKpgPDsD5HbNqyhXzIMy-0tmvtizbr8w4A>
    <xme:UqRhYHRzBu1EidtSKZC54AL3IO2B6WFVn-247gtP8Dzil5Fsf1ll-KUJ13-2ZmAfH
    FZUzCydyt0Q_NeMSg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrudehkedgvddvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurheptgfghfggufffkfhfjgfvofesthhqmhdthhdtjeenucfhrhhomhepffgrphhh
    nhgvucfrrhgvshhtohhnqdfmvghnuggrlhcuoeguphhksehnohhntggvfihorhgurdhorh
    hgqeenucggtffrrghtthgvrhhnpeejuedugfdtkeevjeeitdejueefteduvefhgfejffev
    gfeihfdtvedvffetgeeuveenucfkphepkedvrdekvddrvddukedrudegtdenucevlhhush
    htvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpeguphhksehnohhntggv
    fihorhgurdhorhhg
X-ME-Proxy: <xmx:UqRhYJW4ybXMYwCrflmC23VXKJBIv519v-mFAFyNPeniw_hUZd3QmQ>
    <xmx:UqRhYJjh-Ea5l3aPmcLtajFp2gc5TN8rptFpFOSVxdF8MD127b_XPw>
    <xmx:UqRhYBBiCtfktkLOJK30-N74k4utfN5tB2q2aUEGq5n88bb8xzL6wQ>
    <xmx:UqRhYEOhWQSHmUGIIUdhshoJSOGohsHYPOIoMZwiPl3JB89fHFBCBA>
Received: from [192.168.178.60] (dslc-082-082-218-140.pools.arcor-ip.net [82.82.218.140])
        by mail.messagingengine.com (Postfix) with ESMTPA id E722224005A;
        Mon, 29 Mar 2021 05:56:33 -0400 (EDT)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From:   Daphne Preston-Kendal <dpk@nonceword.org>
Mime-Version: 1.0 (1.0)
Subject: Re: [Bug 212265] New: clock_gettime(CLOCK_TAI, ...) should return an error when TAI has not been configured
Date:   Mon, 29 Mar 2021 11:56:31 +0200
Message-Id: <2505F20D-ED84-4B36-9504-8A8C756C992E@nonceword.org>
References: <YGGbAIoCKDbZLQQ0@localhost>
Cc:     Richard Cochran <richardcochran@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>,
        John Stultz <john.stultz@linaro.org>,
        "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com>
In-Reply-To: <YGGbAIoCKDbZLQQ0@localhost>
To:     Miroslav Lichvar <mlichvar@redhat.com>
X-Mailer: iPhone Mail (18D52)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 29 Mar 2021, at 11:16, Miroslav Lichvar <mlichvar@redhat.com> wrote:

> =EF=BB=BFOn Fri, Mar 26, 2021 at 08:28:59PM -0700, Richard Cochran wrote:
>> Using ntpd on Debian, the service will set the offset, but only after
>> synchronization with the upstream server has been established, and
>> this takes about five minutes, IIRC.
>=20
> With the iburst option it shouldn't take more than 10 seconds. There
> might be an issue wrt stepping the clock when the initial offset is
> large. In Fedora and derived distros using chrony by default the
> TAI-UTC offset should be set right on the first update of the clock as
> expected.

Yeah, I personally am not really concerned about the immediate post-boot env=
ironment. As long as it=E2=80=99s ready by the time userland services are st=
arting, I think most applications that need TAI will be satisfied.

>> Getting back to the original point of the kernel returning an error,
>> I don't see a need for this.  Applications that require correct leap
>> seconds can simply call adjtimex() and wait until the initial zero
>> value is changed by ntpd/etc to the correct offset.  That isn't
>> fundamentally harder than calling clock_gettime() and waiting until
>> the error would go away.
>=20
> There are at least two issues with handling a zero offset as a special
> value. One is that zero could potentially be a valid value in distant
> future.

Since even a single negative leap second was, until recently, considered (qu=
ite literally) astronomically unlikely, and even now (where the earth is spi=
nning faster than ever hitherto expected) the most likely scenario by far se=
ems to be that it=E2=80=99ll just be a longer wait than usual for the next p=
ositive leap second, I=E2=80=99d say minus 37 leap seconds is a prospect for=
 the very very distant future indeed. But in theory, yes.

> The other is that the kernel updates the offset when a leap
> second is inserted/deleted even if the original offset is zero, so
> checking for zero (in the kernel or an application) works only until
> the first leap second after boot.

This is a problem and definitely speaks for having a way to tell whether CLO=
CK_TAI has been set up at all.

> The kernel would need to set a flag that the offset was set. Returning
> an error in clock_gettime() until the offset is set sounds reasonable
> to me, but I have no idea how many of the existing applications it
> would break.

Given that CLOCK_TAI doesn=E2=80=99t exist except on Linux, any portable Uni=
x application is likely to have a fallback of some kind, though perhaps only=
 at compile time.

Daphne Preston-Kendal


