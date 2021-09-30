Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 59AEE41DCD6
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Sep 2021 17:00:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352044AbhI3PBi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Sep 2021 11:01:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:46832 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1352026AbhI3PBf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Sep 2021 11:01:35 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2612C61994;
        Thu, 30 Sep 2021 14:59:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1633013992;
        bh=Iv6MpyP4Sf/J3CnoE9Bkqxzq00WpfNqzpddlsxigm5Q=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=FBn4n5x8/fh3FOJBw3Mqryt2w+njH0oEPNutIniAusw5D9H0T8PPR+lkKhVwZ+Fw2
         dtO6BiArq6vcBl0gOcqU2zQMCJoEnzWJ5VnpV0HjP3uFG1Q9Z0zPykKDcepbincDx8
         sTuHgZ1vh3ZMJ/3Hqf5hMNrSOoAoJhuD1AxAGO3FK/wgDFP8Iydp1hwPW0sSIA8c6q
         iQp3EXCOMyjQi/x9f6uWhMrH8DmoA7UNPOf8iLO2j+eLEJf5Mxtnwhob/G7IOq/WSd
         urkLmuxfXv2mwFATn1JyPbMXXdLdWaUeCRTRsqsSLWP7AXlYPyRVf8MDFt178ufVGB
         2v4KQqLv5TqEQ==
From:   Mark Brown <broonie@kernel.org>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH] regulator: Lower priority of logging when setting supply
Date:   Thu, 30 Sep 2021 15:58:50 +0100
Message-Id: <163301264906.44651.13948793974863095270.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210929140717.3769-1-broonie@kernel.org>
References: <20210929140717.3769-1-broonie@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 29 Sep 2021 15:07:17 +0100, Mark Brown wrote:
> We lowered all the other constraint related log messages to debug level so
> lower the logging of what supplies we're configuring to debug level too.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git for-next

Thanks!

[1/1] regulator: Lower priority of logging when setting supply
      commit: 35d114699b90c8b2c568c48f78adeb913d81bcc1

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark
