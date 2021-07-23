Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1BFBC3D3209
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jul 2021 04:46:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233481AbhGWCGV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jul 2021 22:06:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:45838 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233222AbhGWCGS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jul 2021 22:06:18 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5602660EB0;
        Fri, 23 Jul 2021 02:46:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1627008413;
        bh=B/F3gtie7BdyxaNs7POJY4LfkjZLp5Om/vcy69gI+ls=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ZIUaw/7kvSGstlsK8ueaOS7+DHZCodzsi7+DpXTQIMz3o6J/0NL7GFZZerlks1lu9
         wm4Dn5D5WNASXOXjB4VV3/uhcKBdYofgdE1ZB8IU0OYE08Hja0BtaAQAO6BtL0gObB
         RMXqodSp3yspF52EhrtpqRzK4e0wLaDQi/h7l4Sr0orhIZE2zT2atF+lKpx2CcAHqk
         PubOXQmKdF9rPX6PHMrj7n15CS+KRFOMdbJBF2AsHebtAh0w1NGfN4/0Ca+l3UHQ9Z
         FNv2ITCWRRinZ2ZfbgthcyW4SlOfi8Jzw+AwUrxlrPgvOmahtdVoRe1qCIQ6WBbs7S
         H86//YzzFNPqw==
Date:   Fri, 23 Jul 2021 10:46:47 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Alistair Francis <alistair@alistair23.me>
Cc:     robh+dt@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, linux-imx@nxp.com,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, alistair23@gmail.com
Subject: Re: [PATCH v3] ARM: dts: imx7d-remarkable2: Add WiFi support
Message-ID: <20210723024646.GD28658@dragon>
References: <20210706114028.132-1-alistair@alistair23.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210706114028.132-1-alistair@alistair23.me>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 06, 2021 at 09:40:28PM +1000, Alistair Francis wrote:
> Add support for the bcm4329-fmac WiFi in the reMarkable 2, connected via SDHC.
> 
> Signed-off-by: Alistair Francis <alistair@alistair23.me>

Applied, thanks!
