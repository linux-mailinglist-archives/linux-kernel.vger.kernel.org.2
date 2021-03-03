Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 55CC232BE1B
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Mar 2021 23:35:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1453000AbhCCQ6p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Mar 2021 11:58:45 -0500
Received: from mail.kernel.org ([198.145.29.99]:53902 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231510AbhCCMcp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Mar 2021 07:32:45 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4175A64EE7;
        Wed,  3 Mar 2021 09:57:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1614765475;
        bh=mJdUrPvBXGzIpDLQLBgzh53mg/qR4CPh9qbZvMfmU4Q=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=n/tlMuePzVTgcFya7fvbvgtDXVZ1+hJz7UF+ZuMWI3q8yi18DCwTE3OtXaTyYt4Og
         uaPNlEAr9e5VBhFaIV3C54h4hjj2+VwxNoOgbKSk914j2w+y2n3AEHihY+uNxM5gWJ
         /GbJ+OqFoqkqUfg9VJOzp2jpQ7Uhvb/5i6k+5xPuFL8vxettXvZZc86OwbS8GlaISg
         N/UPOhTp5fg5w5LbieerJ1DzVUr6XaHD6sT9+BW4L1tXIwkLoP4x8cEFq/3jubK5mu
         tsyAw5I7V5vSf0w6qwmI5KKSG2AdkKIS3kGWhgCqLf4CEpG1Dc5wf/9BRA/ERNodTo
         G8MAzN7Oo9wsw==
Date:   Wed, 3 Mar 2021 17:57:49 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Sebastian Reichel <sebastian.reichel@collabora.com>
Cc:     Sascha Hauer <s.hauer@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Fabio Estevam <festevam@gmail.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel@collabora.com
Subject: Re: [PATCH 0/2] Add i.MX51/i.MX53 serial number support
Message-ID: <20210303095748.GD15865@dragon>
References: <20210127174024.170408-1-sebastian.reichel@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210127174024.170408-1-sebastian.reichel@collabora.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 27, 2021 at 06:40:22PM +0100, Sebastian Reichel wrote:
> Sebastian Reichel (2):
>   ARM: dts: imx: Mark IIM as syscon on i.MX51/i.MX53
>   soc: imx: add i.MX51/i.MX53 unique id support

Applied both, thanks.
