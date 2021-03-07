Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 412DF33011F
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Mar 2021 14:16:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231250AbhCGNGb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 7 Mar 2021 08:06:31 -0500
Received: from mail.kernel.org ([198.145.29.99]:50522 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231221AbhCGNGB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Mar 2021 08:06:01 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4B3A164F2C;
        Sun,  7 Mar 2021 13:05:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1615122361;
        bh=1uJ/bNKQ2W98Szuv5kr0mdGHpVSeo/+r5c2Subkw9PA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=YA3IPe7h888ouO0O50WKGpA54iZ+R99Kx65JeQ8B2wOZCaTnd2qRhkMBFFerjxsNc
         MKp+y5hmuq3ThpXqnzRpkN09lL4c/QJYb8DN2LYtrzO5blyW07F7aBKyXRRKHxN3kk
         biMfRUrZgrULAjWT9Zy4zEioMf674frSYs1nWSKj5eHMZ4X46omksJHlsDfOwZfYAG
         cyko8M3ExRO5juNimb0LYkkWxrBY5DHMmMM3Fy37bmR4634QDQPN/YPgP6erVdrrWq
         2h2j2XRqFqiZO9sog7E9sArFqGh9TE3pYhzebVrGdnxi+z/Gq/ULJeSWaKO9gmaMS2
         l4LjhyUKahTjw==
Date:   Sun, 7 Mar 2021 21:05:55 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Adam Ford <aford173@gmail.com>
Cc:     linux-arm-kernel@lists.infradead.org, aford@beaconembedded.com,
        Rob Herring <robh+dt@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: imx8mn-beacon: Enable SDR104 on WiFi SDIO
 interface
Message-ID: <20210307130554.GC543@dragon>
References: <20210214201742.300344-1-aford173@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210214201742.300344-1-aford173@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 14, 2021 at 02:17:42PM -0600, Adam Ford wrote:
> Enable 100Mhz and 200MHz pinmux and corrsesponding voltage supplies
> to enable SDR104 on usdhc1 connecting the WiFi chip.
> 
> Signed-off-by: Adam Ford <aford173@gmail.com>

Applied, thanks.
