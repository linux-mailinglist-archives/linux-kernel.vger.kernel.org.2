Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1486C328947
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Mar 2021 18:56:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239089AbhCARxM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Mar 2021 12:53:12 -0500
Received: from mailoutvs27.siol.net ([185.57.226.218]:37159 "EHLO
        mail.siol.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S231958AbhCAQbY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Mar 2021 11:31:24 -0500
Received: from localhost (localhost [127.0.0.1])
        by mail.siol.net (Postfix) with ESMTP id C0EB3523279;
        Mon,  1 Mar 2021 17:30:19 +0100 (CET)
X-Virus-Scanned: amavisd-new at psrvmta09.zcs-production.pri
Received: from mail.siol.net ([127.0.0.1])
        by localhost (psrvmta09.zcs-production.pri [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id IJQ__SflOFvg; Mon,  1 Mar 2021 17:30:19 +0100 (CET)
Received: from mail.siol.net (localhost [127.0.0.1])
        by mail.siol.net (Postfix) with ESMTPS id 801E8524751;
        Mon,  1 Mar 2021 17:30:19 +0100 (CET)
Received: from kista.localnet (cpe-86-58-17-133.cable.triera.net [86.58.17.133])
        (Authenticated sender: jernej.skrabec@siol.net)
        by mail.siol.net (Postfix) with ESMTPA id DE7EC523279;
        Mon,  1 Mar 2021 17:30:18 +0100 (CET)
From:   Jernej =?utf-8?B?xaBrcmFiZWM=?= <jernej.skrabec@siol.net>
To:     Maxime Ripard <mripard@kernel.org>, Chen-Yu Tsai <wens@kernel.org>
Cc:     Chen-Yu Tsai <wens@csie.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: allwinner: h6: Switch to macros for RSB clock/reset indices
Date:   Mon, 01 Mar 2021 17:30:18 +0100
Message-ID: <13801193.qezBNLBNKl@kista>
In-Reply-To: <20210301162309.1225-1-wens@kernel.org>
References: <20210301162309.1225-1-wens@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Chen-Yu,

Dne ponedeljek, 01. marec 2021 ob 17:23:09 CET je Chen-Yu Tsai napisal(a):
> From: Chen-Yu Tsai <wens@csie.org>
> 
> The macros for the clock and reset indices for the RSB hardware block
> were replaced with raw numbers when the RSB controller node was added.
> This was done to avoid cross-tree dependencies.
> 
> Now that both the clk and DT changes have been merged, we can switch
> back to using the macros.
> 
> Fixes: aaad900757a6 ("arm64: dts: allwinner: h6: Add RSB controller node")
> Signed-off-by: Chen-Yu Tsai <wens@csie.org>

Reviewed-by: Jernej Skrabec <jernej.skrabec@siol.net>

Best regards,
Jernej


