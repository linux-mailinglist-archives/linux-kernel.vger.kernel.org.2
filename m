Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 225593F8DF5
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Aug 2021 20:40:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243330AbhHZSkN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Aug 2021 14:40:13 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:41542 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231310AbhHZSkL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Aug 2021 14:40:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:
        To:From:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=I4nxBP5jaafm6BB+agXz3TbfW0EQ6exBVO8JfJK1BFI=; b=nY0l6Yqt4WwxEbZbpVORBQZT/R
        n9Y968HlQWW8J8///jTZSdTRjs+Jf5JojtMc/XYvDRaiTij8ADk7TjBdVpYRgAxR6LvKvsU+drnu9
        kJ9Tt59n3OdoQOixOnGMAWfgokxKC0h9VxB1Hbu3yDc8h+vwXc5tyW1Ct/lBWfr2vj3c=;
Received: from 188.30.109.46.threembb.co.uk ([188.30.109.46] helo=fitzroy.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <broonie@sirena.org.uk>)
        id 1mJKHR-00FYOJ-J1; Thu, 26 Aug 2021 18:39:13 +0000
Received: by fitzroy.sirena.org.uk (Postfix, from userid 1000)
        id 281A3D14302; Thu, 26 Aug 2021 19:30:25 +0100 (BST)
From:   Mark Brown <broonie@kernel.org>
To:     bgoswami@codeaurora.org, perex@perex.cz,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        srinivas.kandagatla@linaro.org, tiwai@suse.com, vkoul@kernel.org,
        lgirdwood@gmail.com
Cc:     Mark@sirena.org.uk, Brown@sirena.org.uk, broonie@kernel.org,
        alsa-devel@alsa-project.org, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/3] ASoC: wcd9335: Firx some resources leak in the probe and remove function
Date:   Thu, 26 Aug 2021 19:30:25 +0100
Message-Id: <163000225499.699341.15649110189101404680.b4-ty@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <cover.1629091028.git.christophe.jaillet@wanadoo.fr>
References: <cover.1629091028.git.christophe.jaillet@wanadoo.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Mark Brown,,, <broonie@kernel.org>

On Mon, 16 Aug 2021 07:25:01 +0200, Christophe JAILLET wrote:
> The first 2 patches are sraightforward and look logical to me.
> 
> However, the 3rd one in purely speculative. It is based on the fact that a
> comment states that we enable some irqs on some slave ports. That said, it writes
> 0xFF in some registers.
> 
> So, I guess that we should disable these irqs when the driver is removed. That
> said, writing 0x00 at the same place looks logical to me.
> 
> [...]

Applied, thanks!

[1/3] ASoC: wcd9335: Fix a double irq free in the remove function
      commit: 7a6a723e98aa45f393e6add18f7309dfffa1b0e2
[2/3] ASoC: wcd9335: Fix a memory leak in the error handling path of the probe function
      commit: fc6fc81caa63900cef9ebb8b2e365c3ed5a9effb
[3/3] ASoC: wcd9335: Disable irq on slave ports in the remove function
      commit: d3efd26af2e044ff2b48d38bb871630282d77e60

Best regards,
-- 
Mark Brown,,, <broonie@kernel.org>
