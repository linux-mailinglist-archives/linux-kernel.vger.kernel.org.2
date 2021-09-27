Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B162B419D56
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Sep 2021 19:47:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237764AbhI0Rsx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Sep 2021 13:48:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:57432 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238213AbhI0Rsa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Sep 2021 13:48:30 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id D3BA660F9B;
        Mon, 27 Sep 2021 17:46:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1632764812;
        bh=y7MVEonZhyoAS103sBSwF6KBKvSkyh11DLljvMwjBlA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=VaHB85phjyfNSC/aTep5QKSmJCgisA3HoVaGEVR967RXmAxbKNjoXBGmA7Fp6kjRy
         txjHIhJYIIiJApigLTlI5wgGFqdzYSxq6BB9YRtNbf6R6mRwAQrUGK9TaxCpAq6isZ
         9Pu1PrOyLKyJA4DvhPIiCaRQIZ41gaeTeA5mppFd63+WYYkhgSYxabUlI3IS0UAxG/
         AVYIDbIk/ASDTmwiGF00fwI8W2PLrhBC7sM/BcSkA/ba85KW3d8H3XlUrYE/3uTJUx
         GPF+h6a3Cz11mNnKh02/utgO/tB88qy739mtQl2Ug1r4zgn4XmKZPehJmQ07t3ku1+
         vwC13SpnCdZEw==
From:   Mark Brown <broonie@kernel.org>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Anand Moon <linux.amoon@gmail.com>,
        linux-amlogic@lists.infradead.org
Cc:     Mark Brown <broonie@kernel.org>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Liam Girdwood <lgirdwood@gmail.com>
Subject: Re: [PATCHv4] regulator: pwm-regulator: Make use of the helper function dev_err_probe()
Date:   Mon, 27 Sep 2021 18:45:21 +0100
Message-Id: <163276457918.18909.6526280333093875082.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210925173413.1019-1-linux.amoon@gmail.com>
References: <20210925173413.1019-1-linux.amoon@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 25 Sep 2021 17:34:12 +0000, Anand Moon wrote:
> devm_pwm_get() can return -EPROBE_DEFER if the pwm regulator is not
> ready yet. Use dev_err_probe() for pwm regulator resources
> to indicate the deferral reason when waiting for the
> resource to come up.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git for-next

Thanks!

[1/1] regulator: pwm-regulator: Make use of the helper function dev_err_probe()
      commit: e458d3f39d917770cef2ed78891349362ecd3e15

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
