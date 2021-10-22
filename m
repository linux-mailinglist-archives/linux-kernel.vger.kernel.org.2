Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A54A6436F20
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Oct 2021 02:53:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232382AbhJVAzO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Oct 2021 20:55:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:41052 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231518AbhJVAzM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Oct 2021 20:55:12 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5E5F06135E;
        Fri, 22 Oct 2021 00:52:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1634863975;
        bh=G2mkaObv/DDOLgcvOrnbpu6yRRC9/tQfjayDG4k4r6s=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Bp+KhjgaJAEpaWGljxELn9EblB0uUvmoIPPOznLYzU6X/rX8Va4xWIZ/GB8mjZ1Fn
         mnj9Hycla1B8/FUUSpHNvK9rrDTvhdQS4btQH+4aiJO6HqpU9Ru79Z8KgRcRO3uWa7
         0BkY8mLadXLo8bcDR6sVOsBgsmWrZdH6NiqqPDMSEpeMg8olZYVyf6r9ANW8+r/Ut7
         Nidj341dEFIh3IVFYhFFz+fGwhnvUvMurUfzrxEGrReUceuCKhwru3cQnoKRAgXYMR
         eCx+wkUTZgeB85XrGph6ixIkgE5pCdoVZVFPRUYy4oiOXRdX0zcOXprKcuhgkpjael
         TDyXKGTsBgeEw==
From:   Mark Brown <broonie@kernel.org>
To:     =?UTF-8?q?Ma=C3=ADra=20Canal?= <maira.canal@usp.br>,
        linux-kernel@vger.kernel.org
Cc:     Mark Brown <broonie@kernel.org>, lgirdwood@gmail.com
Subject: Re: [PATCH] regulator/tps62360: replacing legacy gpio interface for gpiod
Date:   Fri, 22 Oct 2021 01:52:46 +0100
Message-Id: <163486395941.2610269.6097860651019271717.b4-ty@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <YWxmL2baF5AdzyHv@fedora>
References: <YWxmL2baF5AdzyHv@fedora>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 17 Oct 2021 15:06:39 -0300, Maíra Canal wrote:
> Removing all linux/gpio.h and linux/of_gpio.h dependencies and replacing
> them with the gpiod interface.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git for-next

Thanks!

[1/1] regulator/tps62360: replacing legacy gpio interface for gpiod
      commit: 6a8b5bb0f1350fc4cf398435a1119db12b0bd50e

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
