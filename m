Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 68F4D31E7DF
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Feb 2021 10:24:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231699AbhBRJUI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Feb 2021 04:20:08 -0500
Received: from relay5.mymailcheap.com ([159.100.241.64]:50619 "EHLO
        relay5.mymailcheap.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230520AbhBRIHz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Feb 2021 03:07:55 -0500
Received: from relay3.mymailcheap.com (relay3.mymailcheap.com [217.182.66.161])
        by relay5.mymailcheap.com (Postfix) with ESMTPS id 48E3E200FE;
        Thu, 18 Feb 2021 08:06:59 +0000 (UTC)
Received: from filter1.mymailcheap.com (filter1.mymailcheap.com [149.56.130.247])
        by relay3.mymailcheap.com (Postfix) with ESMTPS id 8DC353ECDF;
        Thu, 18 Feb 2021 09:05:01 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by filter1.mymailcheap.com (Postfix) with ESMTP id C808B2A17A;
        Thu, 18 Feb 2021 03:05:00 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=mymailcheap.com;
        s=default; t=1613635500;
        bh=vayAPymKDO5arWdIdiTG0Kavs2NltsJBgurWKj2dCH4=;
        h=Date:In-Reply-To:References:Subject:To:CC:From:From;
        b=rueLQUIutrfTxQzTLEcHcbSCYS7tgx5X+7zDo9YtHbUgFqtE1Wt+TX3DJmNiwq9eh
         SBSzDN6WJbsHMMt54wNuiaF5R6mt5bD3WzDPp7M1jGSOzGuFuEkz25wwUvLG+QTfSf
         dVsfuV37Y2Hdv8FFZbVzDVpzjyp3NbGYgxWJaw+8=
X-Virus-Scanned: Debian amavisd-new at filter1.mymailcheap.com
Received: from filter1.mymailcheap.com ([127.0.0.1])
        by localhost (filter1.mymailcheap.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id jOQ1kXehAbxp; Thu, 18 Feb 2021 03:04:58 -0500 (EST)
Received: from mail20.mymailcheap.com (mail20.mymailcheap.com [51.83.111.147])
        (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by filter1.mymailcheap.com (Postfix) with ESMTPS;
        Thu, 18 Feb 2021 03:04:58 -0500 (EST)
Received: from [148.251.23.173] (ml.mymailcheap.com [148.251.23.173])
        by mail20.mymailcheap.com (Postfix) with ESMTP id C9271400B5;
        Thu, 18 Feb 2021 08:04:56 +0000 (UTC)
Authentication-Results: mail20.mymailcheap.com;
        dkim=pass (1024-bit key; unprotected) header.d=aosc.io header.i=@aosc.io header.b="BID+L3Nb";
        dkim-atps=neutral
AI-Spam-Status: Not processed
Received: from [10.68.68.85] (unknown [117.136.12.200])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mail20.mymailcheap.com (Postfix) with ESMTPSA id 6D6E8400B5;
        Thu, 18 Feb 2021 08:04:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=aosc.io; s=default;
        t=1613635485; bh=vayAPymKDO5arWdIdiTG0Kavs2NltsJBgurWKj2dCH4=;
        h=Date:In-Reply-To:References:Subject:To:CC:From:From;
        b=BID+L3Nb93KYVK7HZjyWKopXYnV0IbcWoZAaLFZXXYBUX+bZhW5qxk1L7ioTYrNqr
         8ddH5mi9rsZ/RxMdt3xN7E9L8TU80jZ/AHAxzJQlPe9NJf61tXpgJnHOmbaNcLRBzF
         lNb2EloDoCyyRvR/zmOSXkma+GvEVFXl7u5mVRL8=
Date:   Thu, 18 Feb 2021 16:04:03 +0800
User-Agent: K-9 Mail for Android
In-Reply-To: <20210218075835.o43tyarpimrcwbvk@gilmour>
References: <20210212135725.283877-1-t.schramm@manjaro.org> <20210218075835.o43tyarpimrcwbvk@gilmour>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH] clk: sunxi-ng: v3s: add support for variable rate audio pll output
To:     Maxime Ripard <maxime@cerno.tech>,
        Tobias Schramm <t.schramm@manjaro.org>
CC:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
From:   Icenowy Zheng <icenowy@aosc.io>
Message-ID: <C1E55B65-370F-4875-B7D6-7CD7A82A91DD@aosc.io>
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
X-Rspamd-Queue-Id: C9271400B5
X-Rspamd-Server: mail20.mymailcheap.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



=E4=BA=8E 2021=E5=B9=B42=E6=9C=8818=E6=97=A5 GMT+08:00 =E4=B8=8B=E5=8D=883=
:58:35, Maxime Ripard <maxime@cerno=2Etech> =E5=86=99=E5=88=B0:
>Hi,
>
>On Fri, Feb 12, 2021 at 02:57:25PM +0100, Tobias Schramm wrote:
>> Previously the variable rate audio pll output was fixed to a divider
>of
>> four=2E This is unfortunately incompatible with generating commonly
>used
>> I2S core clock rates like 24=2E576MHz from the 24MHz parent clock=2E
>> This commit adds support for arbitrary audio pll output dividers to
>fix
>> that=2E
>>=20
>> Signed-off-by: Tobias Schramm <t=2Eschramm@manjaro=2Eorg>
>
>It's not really clear to me how that would help=2E

We have introducee SDM-based accurate audio PLL on several
other SoCs=2E Some people is quite sensitive about audio-related things=2E

>
>The closest frequency we can provide for 24=2E576MHz would be 24580645
>Hz,
>with N =3D 127, M =3D 31 and P =3D 4, so it would work with what we have
>already?
>
>Maxime
