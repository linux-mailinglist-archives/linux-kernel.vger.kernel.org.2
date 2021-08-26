Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6AAD53F8DF6
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Aug 2021 20:40:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243340AbhHZSkP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Aug 2021 14:40:15 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:41558 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231310AbhHZSkO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Aug 2021 14:40:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:
        To:From:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=LRgjmQ7rfEXS7JLHe9cxJs/oW5qgVFqI0wtw0GAw3LI=; b=iUEaCRNfoda7Yw8eGsnTInFlSK
        zUDJxTXcWDgyW6oG3wvPxwt197Hzn/IfP7lpz1R5NHWcWJacydjQcopyT7Ng8I6BZXmoZFE/O99c6
        F2dqiKFmyvIEc3QHEcei0NEChGXjdL70FZkyNri7HUmhfRurxH76riiey+SF+QpcuRp0=;
Received: from 188.30.109.46.threembb.co.uk ([188.30.109.46] helo=fitzroy.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <broonie@sirena.org.uk>)
        id 1mJKHR-00FYOI-Iu; Thu, 26 Aug 2021 18:39:13 +0000
Received: by fitzroy.sirena.org.uk (Postfix, from userid 1000)
        id 25AD0D14301; Thu, 26 Aug 2021 19:30:25 +0100 (BST)
From:   Mark Brown <broonie@kernel.org>
To:     alsa-devel@alsa-project.org,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc:     Mark@sirena.org.uk, Brown@sirena.org.uk, broonie@kernel.org,
        Takashi Iwai <tiwai@suse.com>,
        open list <linux-kernel@vger.kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        liam.r.girdwood@linux.intel.com, Jaroslav Kysela <perex@perex.cz>,
        vkoul@kernel.org,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        tiwai@suse.de
Subject: Re: [RFC PATCH 1/2] ASoC: soc-pcm: protect BE dailink state changes in trigger
Date:   Thu, 26 Aug 2021 19:30:24 +0100
Message-Id: <163000225499.699341.16303629557242399115.b4-ty@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210817164054.250028-2-pierre-louis.bossart@linux.intel.com>
References: <20210817164054.250028-1-pierre-louis.bossart@linux.intel.com> <20210817164054.250028-2-pierre-louis.bossart@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Mark Brown,,, <broonie@kernel.org>

On Tue, 17 Aug 2021 11:40:53 -0500, Pierre-Louis Bossart wrote:
> When more than one FE is connected to a BE, e.g. in a mixing use case,
> the BE can be triggered multiple times when the FE are opened/started
> concurrently. This race condition is problematic in the case of
> SoundWire BE dailinks, and this is not desirable in a general
> case. The code carefully checks when the BE can be stopped or
> hw_free'ed, but the trigger code does not use any mutual exclusion.
> 
> [...]

Applied, thanks!

[1/2] ASoC: soc-pcm: protect BE dailink state changes in trigger
      commit: 0c75fc7193387776c10f7c7b440d93496e3d5e21
[2/2] ASoC: soc-pcm: test refcount before triggering
      commit: 6479f7588651cbc9c91e61c20ff39119cbc8feba

Best regards,
-- 
Mark Brown,,, <broonie@kernel.org>
