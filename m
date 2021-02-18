Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 242C331E8C3
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Feb 2021 11:59:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230017AbhBRKjh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Feb 2021 05:39:37 -0500
Received: from relay5.mymailcheap.com ([159.100.241.64]:50686 "EHLO
        relay5.mymailcheap.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231811AbhBRJZk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Feb 2021 04:25:40 -0500
Received: from relay3.mymailcheap.com (relay3.mymailcheap.com [217.182.119.155])
        by relay5.mymailcheap.com (Postfix) with ESMTPS id C0508200FE;
        Thu, 18 Feb 2021 09:23:59 +0000 (UTC)
Received: from filter1.mymailcheap.com (filter1.mymailcheap.com [149.56.130.247])
        by relay3.mymailcheap.com (Postfix) with ESMTPS id 7C4A93ECDF;
        Thu, 18 Feb 2021 10:21:56 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by filter1.mymailcheap.com (Postfix) with ESMTP id A9CCA2A3EF;
        Thu, 18 Feb 2021 04:21:55 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=mymailcheap.com;
        s=default; t=1613640115;
        bh=YGiCkBjBI0LQsVsngiZbqmO9H181CDvzBHWvXsO748Q=;
        h=Date:In-Reply-To:References:Subject:To:CC:From:From;
        b=kemu8WChXJu6q24lPyFsXzFXqPM/V+41gd5mLiSPc2f7r5U6fRBuRraMSFbejlZhx
         8zqbTqaAfN/JaLggej3iXgaMaU7GtZKPYLaxC8Un2qadlAr/wl44ivsg2sc5mzxHfE
         9UXdAq2IdvRBrTR7t3npEwZ5WreKjojiPbEHr130=
X-Virus-Scanned: Debian amavisd-new at filter1.mymailcheap.com
Received: from filter1.mymailcheap.com ([127.0.0.1])
        by localhost (filter1.mymailcheap.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id c5WIih2kyJjW; Thu, 18 Feb 2021 04:21:54 -0500 (EST)
Received: from mail20.mymailcheap.com (mail20.mymailcheap.com [51.83.111.147])
        (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by filter1.mymailcheap.com (Postfix) with ESMTPS;
        Thu, 18 Feb 2021 04:21:54 -0500 (EST)
Received: from [148.251.23.173] (ml.mymailcheap.com [148.251.23.173])
        by mail20.mymailcheap.com (Postfix) with ESMTP id 84CE840C0B;
        Thu, 18 Feb 2021 09:21:53 +0000 (UTC)
Authentication-Results: mail20.mymailcheap.com;
        dkim=pass (1024-bit key; unprotected) header.d=aosc.io header.i=@aosc.io header.b="Wkxnc6WP";
        dkim-atps=neutral
AI-Spam-Status: Not processed
Received: from [10.68.68.85] (unknown [117.136.12.200])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mail20.mymailcheap.com (Postfix) with ESMTPSA id 4953340C0B;
        Thu, 18 Feb 2021 09:21:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=aosc.io; s=default;
        t=1613640102; bh=YGiCkBjBI0LQsVsngiZbqmO9H181CDvzBHWvXsO748Q=;
        h=Date:In-Reply-To:References:Subject:To:CC:From:From;
        b=Wkxnc6WPu5/gWGjLmmfE0yISgx0S2LZ9YkgTFSwEZgndE5+X4up90++RXziin7g/Y
         V6jLUojpsmZrjVoKXGGD4Lc0/9e+ozklQhYyuZRGMCuVlLeCIm5KL2mdFJKqwvYED2
         UJ3sx9qfh+UbL4fJAyZMFclO2pcwwzd11Q+UQtok=
Date:   Thu, 18 Feb 2021 17:21:16 +0800
User-Agent: K-9 Mail for Android
In-Reply-To: <914aeb08-0534-48aa-2c2e-4e87d4360e29@manjaro.org>
References: <20210212135725.283877-1-t.schramm@manjaro.org> <20210218075835.o43tyarpimrcwbvk@gilmour> <C1E55B65-370F-4875-B7D6-7CD7A82A91DD@aosc.io> <914aeb08-0534-48aa-2c2e-4e87d4360e29@manjaro.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH] clk: sunxi-ng: v3s: add support for variable rate audio pll output
To:     Tobias Schramm <t.schramm@manjaro.org>,
        Maxime Ripard <maxime@cerno.tech>
CC:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
From:   Icenowy Zheng <icenowy@aosc.io>
Message-ID: <2BA0A0C7-DA37-486B-B12F-C485F1000F8E@aosc.io>
X-Spamd-Result: default: False [2.90 / 10.00];
         RCVD_VIA_SMTP_AUTH(0.00)[];
         RECEIVED_SPAMHAUS_XBL(3.00)[117.136.12.200:received];
         R_DKIM_ALLOW(0.00)[aosc.io:s=default];
         RECEIVED_SPAMHAUS_PBL(0.00)[117.136.12.200:received];
         FROM_HAS_DN(0.00)[];
         TO_DN_SOME(0.00)[];
         TO_MATCH_ENVRCPT_ALL(0.00)[];
         MIME_GOOD(-0.10)[text/plain];
         DMARC_NA(0.00)[aosc.io];
         ARC_NA(0.00)[];
         R_SPF_SOFTFAIL(0.00)[~all];
         ML_SERVERS(-3.10)[148.251.23.173];
         DKIM_TRACE(0.00)[aosc.io:+];
         RCPT_COUNT_SEVEN(0.00)[9];
         RCVD_NO_TLS_LAST(0.10)[];
         FROM_EQ_ENVFROM(0.00)[];
         MIME_TRACE(0.00)[0:+];
         ASN(0.00)[asn:24940, ipnet:148.251.0.0/16, country:DE];
         RCVD_COUNT_TWO(0.00)[2];
         MID_RHS_MATCH_FROM(0.00)[];
         HFILTER_HELO_BAREIP(3.00)[148.251.23.173,1]
X-Rspamd-Queue-Id: 84CE840C0B
X-Rspamd-Server: mail20.mymailcheap.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



=E4=BA=8E 2021=E5=B9=B42=E6=9C=8818=E6=97=A5 GMT+08:00 =E4=B8=8B=E5=8D=885=
:18:39, Tobias Schramm <t=2Eschramm@manjaro=2Eorg> =E5=86=99=E5=88=B0:
>Hi Icenowy,
>
> > We have introducee SDM-based accurate audio PLL on several
>> other SoCs=2E Some people is quite sensitive about audio-related
>things=2E
> >
>While it is possible to support 24MHz * 128 / 25 / 5 =3D 24=2E576MHz
>without=20
>delta sigma modulation, matching 22=2E5792MHz is indeed not possible=2E I=
=20
>read you'd prefer me to use SDM like the other SoCs though? Shall I
>send=20
>a v2 utilizing SDM?

Yes, I think so=2E

>
>Cheers,
>Tobias
