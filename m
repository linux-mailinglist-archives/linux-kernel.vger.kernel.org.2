Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C158392169
	for <lists+linux-kernel@lfdr.de>; Wed, 26 May 2021 22:22:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234959AbhEZUXe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 May 2021 16:23:34 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:47844 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234482AbhEZUXb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 May 2021 16:23:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:
        To:From:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=19yaRlaFGNjhDtqglvEviJJG8Thp3ZyG85IdZCE9Hm4=; b=ndAsmp0L2JpV8x8WdjKnLI8XH3
        lxh+woLXr7p5IhY4XR30TeuSOtbhwTHhvOc+z4Wp21pvPaEvzs4xJIzv+KYp5uqPItE5LwvCP4x1S
        gsEGr4KxJ+U93WJnVch8kW/ISZmeyBH9tNmdlgu69+ritU0lZwgxslaFMOFXnoU5OOa4=;
Received: from 94.196.90.140.threembb.co.uk ([94.196.90.140] helo=fitzroy.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <broonie@sirena.org.uk>)
        id 1lm02J-0067nl-3g; Wed, 26 May 2021 20:21:51 +0000
Received: by fitzroy.sirena.org.uk (Postfix, from userid 1000)
        id 5057FD0E9E7; Wed, 26 May 2021 21:21:48 +0100 (BST)
From:   Mark Brown <broonie@kernel.org>
To:     Axel Lin <axel.lin@ingics.com>
Cc:     Mark@sirena.org.uk, Brown@sirena.org.uk, broonie@kernel.org,
        Chris Zhong <zyw@rock-chips.com>, linux-kernel@vger.kernel.org,
        Liam Girdwood <lgirdwood@gmail.com>,
        Heiko Stuebner <heiko@sntech.de>
Subject: Re: [PATCH v2] regulator: rk808: Convert to use regulator_set_ramp_delay_regmap
Date:   Wed, 26 May 2021 21:21:48 +0100
Message-Id: <162206049393.1916852.1937367199606189975.b4-ty@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210525141203.2562884-1-axel.lin@ingics.com>
References: <20210525141203.2562884-1-axel.lin@ingics.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Mark Brown,,, <broonie@kernel.org>

On Tue, 25 May 2021 22:12:03 +0800, Axel Lin wrote:
> Use regulator_set_ramp_delay_regmap instead of open-coded.

Applied, thanks!

[1/1] regulator: rk808: Convert to use regulator_set_ramp_delay_regmap
      commit: f85ea4945a268be6b0a6373f8ef1b2450d3f394b

Best regards,
-- 
Mark Brown,,, <broonie@kernel.org>
