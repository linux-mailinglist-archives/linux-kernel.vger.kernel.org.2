Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1206A3E4169
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Aug 2021 10:14:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233854AbhHIIOW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Aug 2021 04:14:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:56398 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233785AbhHIIOS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Aug 2021 04:14:18 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6E65961004;
        Mon,  9 Aug 2021 08:13:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1628496838;
        bh=FqCk1UCJhe8FMzRBx3U7IZnAenxHH4oA5QXPf+ciSFg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ZrVfQWXzxjBwIvtgKvzpHOF2KZWvXd6zYxrG1DILyAqpHKrBD6Q5vEWUuKPYyFsOc
         tbueV4EI2uJ4wITMW/QWsvInR4x2JHoWzTXWM+PXk8pxgI3gedGaNZyGd1xG+Vfake
         A+nXmt5izF7qhvYOxurHJuS25acaiOmXf+c9kDrTBk1mXqB53VAPkPLHPTlBvQ8ryp
         44UDH2RqDmHBlWf3fkNekHlMt8dIx56SI0GCzBj0uOUFLAXzjFV7o7jTa5l0s13ZsI
         kuYdqsaeck2jbtVAjL+Wc8l0R5CZdlWV7aftubFwLFzRoO2ivjdZEnx2pp3CEXk4Nr
         RlEXRFJEZR/Ng==
Date:   Mon, 9 Aug 2021 16:13:51 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Cc:     robh+dt@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, linux-imx@nxp.com, p.zabel@pengutronix.de,
        l.stach@pengutronix.de, krzk@kernel.org, agx@sigxcpu.org,
        marex@denx.de, andrew.smirnov@gmail.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, aisheng.dong@nxp.com,
        Peng Fan <peng.fan@nxp.com>
Subject: Re: [PATCH 0/3] arm64: dts: imx: pmu update
Message-ID: <20210809081350.GS30984@dragon>
References: <20210807094537.20290-1-peng.fan@oss.nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210807094537.20290-1-peng.fan@oss.nxp.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 07, 2021 at 05:45:34PM +0800, Peng Fan (OSS) wrote:
> From: Peng Fan <peng.fan@nxp.com>
> 
> Update pmu compatible
> Drop interrupt affinity
> 
> Peng Fan (3):
>   arm64: dts: imx8mm: update pmu compatible
>   arm64: dts: imx8qxp: update pmu compatible
>   arm64: dts: imx8m: drop interrupt-affinity for pmu

Applied all, thanks!
