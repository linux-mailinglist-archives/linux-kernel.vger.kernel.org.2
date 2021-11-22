Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C906458791
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Nov 2021 01:57:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233553AbhKVBAc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 21 Nov 2021 20:00:32 -0500
Received: from mail.kernel.org ([198.145.29.99]:49004 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229884AbhKVBAc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Nov 2021 20:00:32 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9C5A060D07;
        Mon, 22 Nov 2021 00:57:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1637542646;
        bh=PI4PdJnfsKlvNvnB3GbdMLr9HHLkdJe0VY+b8Ito5tA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=cUxX/hx096S0akRB+5uewseooiNPAUDp5m8VQC6b3/La+3kIHrcf+zF885mtTP9Vd
         44MR4cMWGB/DTzW5c83GEzxCWmczl1BSm5X0+95DJAxD1nZX+GxTVCM7jAnpTYux55
         iTwVcCt/n1ox31VShGg+JXJ4zX6Aujq1xCDdLWhhyq6uOJ4GpqtnQviF5y3pEjhtd1
         7qNGI9IX0b6sDHr4CSLU0dIfjNQMBmI6PQp91Z/UEL0psRErfsov8rJbiQTxNf6SKd
         a9S3sC0hzmjyCaF/wqr7cO2mLmB/x0gh1Wa1YeYDI5VTPsTVLqvmVgu9M2hFo+UyRy
         l1GTW59F9DPrA==
Date:   Mon, 22 Nov 2021 08:57:21 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Adam Ford <aford173@gmail.com>
Cc:     linux-arm-kernel@lists.infradead.org, aford@beaconembedded.com,
        Rob Herring <robh+dt@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: imx8mm-beacon: Enable USB Controllers
Message-ID: <20211122005720.GS31998@dragon>
References: <20211104123411.397205-1-aford173@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211104123411.397205-1-aford173@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 04, 2021 at 07:34:11AM -0500, Adam Ford wrote:
> The i.MX8M Mini has two available USB controllers.  On the
> imx8mm-beacon board, USB1 is routed to a mini-USB port with
> OTG functionality.  USB2 is routed to a USB hub which has
> three host-only ports connected to it.
> 
> Signed-off-by: Adam Ford <aford173@gmail.com>

Applied, thanks!
