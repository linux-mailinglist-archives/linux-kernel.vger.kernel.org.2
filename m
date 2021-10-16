Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D95A6430388
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Oct 2021 17:50:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239556AbhJPPwq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Oct 2021 11:52:46 -0400
Received: from gloria.sntech.de ([185.11.138.130]:45836 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231824AbhJPPwp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Oct 2021 11:52:45 -0400
Received: from p508fce7c.dip0.t-ipconnect.de ([80.143.206.124] helo=phil.localnet)
        by gloria.sntech.de with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <heiko@sntech.de>)
        id 1mblx1-0007WI-5i; Sat, 16 Oct 2021 17:50:23 +0200
From:   Heiko Stuebner <heiko@sntech.de>
To:     Nicolas Frattaroli <frattaroli.nicolas@gmail.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Nicolas Frattaroli <frattaroli.nicolas@gmail.com>
Cc:     linux-rockchip@lists.infradead.org, alsa-devel@alsa-project.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/4] ASoC: rockchip: i2s-tdm: Strip out direct CRU use
Date:   Sat, 16 Oct 2021 17:50:22 +0200
Message-ID: <1782571.1Dz21PRzoM@phil>
In-Reply-To: <20211016105354.116513-2-frattaroli.nicolas@gmail.com>
References: <20211016105354.116513-1-frattaroli.nicolas@gmail.com> <20211016105354.116513-2-frattaroli.nicolas@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Samstag, 16. Oktober 2021, 12:53:50 CEST schrieb Nicolas Frattaroli:
> In cases where both rx and tx lrck are synced to the same source,
> the resets for rx and tx need to be triggered simultaneously,
> according to the downstream driver.
> 
> As there is no reset API to atomically bulk (de)assert two resets
> at once, what the driver did was implement half a reset controller
> specific to Rockchip, which tried to write the registers for the
> resets within one write ideally or several writes within an irqsave
> section.
> 
> This of course violates abstractions quite badly. The driver should
> not write to the CRU's registers directly.
> 
> In practice, for the cases I tested the driver with, which is audio
> playback, replacing the synchronised asserts with just individual
> ones does not seem to make any difference.
> 
> If it turns out that this breaks something in the future, it should
> be fixed through the specification and implementation of an atomic
> bulk reset API, not with a CRU hack.
> 
> Signed-off-by: Nicolas Frattaroli <frattaroli.nicolas@gmail.com>

Reviewed-by: Heiko Stuebner <heiko@sntech.de>


