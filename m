Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4ED1638CE45
	for <lists+linux-kernel@lfdr.de>; Fri, 21 May 2021 21:38:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238977AbhEUTjV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 May 2021 15:39:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:41728 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236093AbhEUTjU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 May 2021 15:39:20 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6FC75613D9;
        Fri, 21 May 2021 19:37:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1621625877;
        bh=Z7AwKY8a9Z/8SOx1OF9wRiTfwdjR8gm/ECjyKI5FeBw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bcLKoN3etXX7BXtvVppBipjLwjZFKixl0Z6aHEJhTIGlc1LWM2fwDK8QmTpTg75LM
         OQ5m7PmDfK1BmsAufPd2JMIpqeEFj66hI9e/RKcL4Xo5sHt1r9+w5e5RAi0Dl2WY5C
         kOwRG3TPiR3IPlbba2Iptfj3OGrzKuU2GGKcsNr9O1pd7Y7qWGn22QGgmsb26KF0IT
         Wb/+4F3q1oB/bAZBCOLoGLYIf9xONBDdokhwr5xsXWCR2igIT0RHLBMe2OTJk6dsdA
         kyIx6kMIDc56fEH1GXgjw8nOg1sGXIsoDLKwXW53sIUQZG2/FIK6ZqsDj7GF6NBTtA
         YEUu6K8w3pr+Q==
From:   Mark Brown <broonie@kernel.org>
To:     Axel Lin <axel.lin@ingics.com>
Cc:     Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org,
        Cristian Marussi <cristian.marussi@arm.com>
Subject: Re: [PATCH] regulator: scmi: Fix off-by-one for linear regulators .n_voltages setting
Date:   Fri, 21 May 2021 20:37:52 +0100
Message-Id: <162162581493.40928.528434927857483440.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210521073020.1944981-1-axel.lin@ingics.com>
References: <20210521073020.1944981-1-axel.lin@ingics.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 21 May 2021 15:30:20 +0800, Axel Lin wrote:
> For linear regulators, the .n_voltages is (max_uv - min_uv) / uv_step + 1.

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git for-next

Thanks!

[1/1] regulator: scmi: Fix off-by-one for linear regulators .n_voltages setting
      commit: 36cb555fae0875d5416e8514a84a427bec6e4cda

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
