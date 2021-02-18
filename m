Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AFC8231E851
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Feb 2021 11:01:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230375AbhBRJ4w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Feb 2021 04:56:52 -0500
Received: from mail.manjaro.org ([176.9.38.148]:41358 "EHLO mail.manjaro.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231277AbhBRIxB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Feb 2021 03:53:01 -0500
Received: from localhost (localhost [127.0.0.1])
        by mail.manjaro.org (Postfix) with ESMTP id AD8283E60018;
        Thu, 18 Feb 2021 09:52:00 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at manjaro.org
Received: from mail.manjaro.org ([127.0.0.1])
        by localhost (manjaro.org [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id HKvwoosvfVV0; Thu, 18 Feb 2021 09:51:58 +0100 (CET)
Subject: Re: [PATCH] clk: sunxi-ng: v3s: add support for variable rate audio
 pll output
To:     Maxime Ripard <maxime@cerno.tech>,
        Tobias Schramm <t.schramm@manjaro.org>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Icenowy Zheng <icenowy@aosc.io>, Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <20210212135725.283877-1-t.schramm@manjaro.org>
 <20210218075835.o43tyarpimrcwbvk@gilmour>
From:   Tobias Schramm <t.schramm@manjaro.org>
Message-ID: <7379a9c3-3578-5cf1-53ed-ace8ff68434b@manjaro.org>
Date:   Thu, 18 Feb 2021 09:51:54 +0100
MIME-Version: 1.0
In-Reply-To: <20210218075835.o43tyarpimrcwbvk@gilmour>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US-large
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Maxime,
> 
> It's not really clear to me how that would help.
> 
> The closest frequency we can provide for 24.576MHz would be 24580645 Hz,
> with N = 127, M = 31 and P = 4, so it would work with what we have
> already?
> 

As far as I'm aware the multiplier N ranges from 0 to 128 (offset of 1 
from 0 to 127). Thus 24MHz * 128 / 25 / 5 = 24.576MHz. Since this 
requires the postdiv to be set to 5 it is not supported yet.

Cheers,
Tobias
