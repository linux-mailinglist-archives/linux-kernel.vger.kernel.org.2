Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 87E5E42E55B
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Oct 2021 02:44:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234632AbhJOAq7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Oct 2021 20:46:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:57902 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234622AbhJOAq5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Oct 2021 20:46:57 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 49747610D1;
        Fri, 15 Oct 2021 00:44:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1634258692;
        bh=YFpJ7iKpvybwT0EOJSs+FXxVB2B6kd+iVy4X1DpohAo=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=V5TtEeM8jFsgcGcuBW6Yi1RHRqq5/oODbkcc0S4WZpeDexJoHVu3ALcgDZyVJc1MG
         6CIwbC2ZR/3XLrdymbDNipPSk307O8nLu4ExPCEqf7T6DuC4dGH1UFDDUS1K6ERb2T
         1FU+l30gsJiFr/LU5tlArESe1Zc83JYofkMviOGkSPLROoTuRjzOjCKU8NiJSHrEzM
         WwhRnZzp6kBGQijR6YkXHuo2opcUTWULpQIbqcuso3n/atWh9U44xCkgoGk+LizOe1
         dITQE1VW/HLdoxFCv4xBimgyntfX45zGjTRzA9d5i9nOMflmRAW+pSJCtFPm4hxUED
         bPJ1w67C9pkNg==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20211005065948.10092-1-mark-pk.tsai@mediatek.com>
References: <20211005065948.10092-1-mark-pk.tsai@mediatek.com>
Subject: Re: [PATCH] clk: make clk_core_lookup faster by using clk name hash
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     mark-pk.tsai@mediatek.com, yj.chiang@mediatek.com,
        matthias.bgg@gmail.com, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
To:     Mark-PK Tsai <mark-pk.tsai@mediatek.com>, mturquette@baylibre.com
Date:   Thu, 14 Oct 2021 17:44:51 -0700
Message-ID: <163425869104.1688384.2477307279117424281@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Mark-PK Tsai (2021-10-04 23:59:49)
> Compare hash value before strcmp the full name to make
> clk_core_lookup faster.
>=20
> It make clk driver probe 30 percent faster on the platform
> have 1483 registered clks and average clock name length 20.

Why is clk_core_lookup() a fast path for you?
