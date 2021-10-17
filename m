Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 99551430878
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Oct 2021 13:45:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245588AbhJQLr0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 17 Oct 2021 07:47:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:60630 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238081AbhJQLrZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Oct 2021 07:47:25 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 011D360FE3;
        Sun, 17 Oct 2021 11:45:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1634471115;
        bh=ohuMuYmmuyqyemJ4Qv+2X0qk6HWlk0oTy0Gz89ptlUo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ba2+hAgqogX5pyL/+cDfcC/L2/wrEGbJ9jKoi7XLGpqxScs6BytFNYjroMCWo/BVH
         V+GJtRe3JCtiIzpaITvLkS+jLIvdiSb32DsLjoQ3NldEKjX1Yr1DFm8qn725IcxcSv
         jeT3TatImQUuV2OsfLKFo+Nm+84zySMQ/ebFVXr/9mLOLZ/9UAQQRUOge9SjHjiOSr
         ZzcA9VZGfmETOOswrvr4h/N1OIO26N6D8Bkr4ffpswJF7NlbOTyIBoNsIwRP9e8+IO
         +X1ZiW59EdhB9dS+GW6CZDTQsdmututWLb5IXDOjZttz+DPhGsDYCvPpsdTHpiDOkn
         aXlduszwQTqEw==
From:   Mark Brown <broonie@kernel.org>
To:     Nicolas Frattaroli <frattaroli.nicolas@gmail.com>
Cc:     Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Jaroslav Kysela <perex@perex.cz>, alsa-devel@alsa-project.org,
        Heiko Stuebner <heiko@sntech.de>, linux-kernel@vger.kernel.org,
        Takashi Iwai <tiwai@suse.com>
Subject: Re: (subset) [PATCH 0/4] Getting rid of the reset controller in i2s-tdm
Date:   Sun, 17 Oct 2021 12:45:06 +0100
Message-Id: <163447061131.1864024.8259786717418291207.b4-ty@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211016105354.116513-1-frattaroli.nicolas@gmail.com>
References: <20211016105354.116513-1-frattaroli.nicolas@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 16 Oct 2021 12:53:49 +0200, Nicolas Frattaroli wrote:
> after some discussion with Heiko on IRC, he has admitted to me
> that the rockchip,cru property, and its corresponding half a reset
> controller in the driver, is weighing heavily on his mind.
> 
> The background is that if the lrck only uses one clock for both rx
> and tx direction, then according to the downstream driver, the rx
> and tx resets should be asserted at roughly the same time to keep
> things in sync.
> 
> [...]

Applied, thanks!

[1/4] ASoC: rockchip: i2s-tdm: Strip out direct CRU use
      commit: d6365d0f0a03c1feb28d86dfd192972ddc647013
[2/4] ASoC: dt-bindings: rockchip: i2s-tdm: Drop rockchip,cru property
      commit: 4e52cb9e2c22c9d860910794c82461064baadd9f

Best regards,
-- 
Mark Brown <broonie@kernel.org>
