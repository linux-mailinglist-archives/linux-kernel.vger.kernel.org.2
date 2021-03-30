Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D31234E343
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Mar 2021 10:37:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231246AbhC3Ih2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Mar 2021 04:37:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:42406 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230303AbhC3Ig5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Mar 2021 04:36:57 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9A8D76198A;
        Tue, 30 Mar 2021 08:36:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1617093416;
        bh=fAbQBg3czx/TVZmO49bPCVGASEdefgslAHdE0YfPg24=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=e93oO4G2eC0WytP84bFtvQXHvhE+StBjlQZz+DKpILOQgmI+w/unE+LMJEd+60DeL
         O3whgMnmYdyjaQxMNiqHyYXZoKAaDt05bZ5j6MZriuaDnLZq2HNx6obkTJNVZ4jtId
         Km9zIq89+DGxkACSzQnFxUJrTeXCUxBbAcQfCf6ORSqMKYuZtiEZnq7SnuZjUKZ6p9
         /EacPe/A1f9Qxv4tg9KbJ8tl2KScfkHH4ldyl2JOBmfyouTd02tXzw+WJnsXrwomFd
         thAm4NamvLTxt9au4QbpkrH4ab/m9fED22hVbK/GMesYkhsPMgsEhXKCt86iLTMDhR
         MhGTJ/dRHGUpQ==
Date:   Tue, 30 Mar 2021 16:36:50 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Stefan Riedmueller <s.riedmueller@phytec.de>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/3] ARM: dts: imx6: pfla02: Fix USB vbus enable
 pinmuxing
Message-ID: <20210330083650.GP22955@dragon>
References: <20210329130103.65857-1-s.riedmueller@phytec.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210329130103.65857-1-s.riedmueller@phytec.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 29, 2021 at 03:01:01PM +0200, Stefan Riedmueller wrote:
> The pinmuxing for the enable pin of the usbh1 node is wrong. It needs to
> be muxed as GPIO. While at it, move the pinctrl to the vbus regulator
> since it is actually the regulator enable pin.
> 
> Signed-off-by: Stefan Riedmueller <s.riedmueller@phytec.de>

Applied all, thanks.
