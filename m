Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 267DC38D832
	for <lists+linux-kernel@lfdr.de>; Sun, 23 May 2021 04:02:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231519AbhEWCD4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 May 2021 22:03:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:40062 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231495AbhEWCDz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 May 2021 22:03:55 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 87CED610CB;
        Sun, 23 May 2021 02:02:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1621735350;
        bh=cczRYZfUGppkbAXuhdRD6zwKWAX9/aP6TkYfeWlDzJU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=JV1CRppCec+UJrtyTqTJm3lty798sjsgBym2QDnAHU0yco/f+1Yq+C7FI5lz47BnC
         zdAVqTfUacwupp/FWSRSYdSjqfbZ55c/jZL8OjotCX3GtnQwliJHvhg/btPUJlx696
         lKXe37Q0Jhx5cMwchHVk0vmRL5VQphjgQ/PJPjQbU891DHYEXlgtFja+HwiNgWfaOp
         f2chkRTLwNVzWj7Ia7AvfxQ5x92/iEWSmTjcLsmfmL6QAmT1TSEyK7nQfgi8FbnvQw
         2dBgW23ZHQPj8Z/Q/q9qgvShaCQ1ad6g38eIvT66W3M3smd/JFjHBpYQG/CvqAiLfY
         0qIjgquL4bMeg==
Date:   Sun, 23 May 2021 10:02:22 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Michal =?utf-8?B?Vm9rw6HEjQ==?= <michal.vokac@ysoft.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Fabio Estevam <festevam@gmail.com>, devicetree@vger.kernel.org,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ARM: dts: imx6dl-yapp4: Use aliases to set custom MMC
 device indexes
Message-ID: <20210523020222.GG8194@dragon>
References: <1619790795-8375-1-git-send-email-michal.vokac@ysoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1619790795-8375-1-git-send-email-michal.vokac@ysoft.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 30, 2021 at 03:53:15PM +0200, Michal Vokáč wrote:
> Until commit fa2d0aa96941 ("mmc: core: Allow setting slot index via
> device tree alias") was introduced, our usdhc3 and usdhc4 devices
> were enumerated as mmc0 and mmc1. The mmc1 device is used to boot/update
> the board and its name must be fixed.
> 
> With the referenced commit, aliases from imx6qdl.dtsi took effect.
> Override the aliases to get back the original device indexes.
> 
> Signed-off-by: Michal Vokáč <michal.vokac@ysoft.com>

Applied, thanks.
