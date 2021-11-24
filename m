Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B640345CB22
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Nov 2021 18:37:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236545AbhKXRkI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Nov 2021 12:40:08 -0500
Received: from mail.kernel.org ([198.145.29.99]:38450 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229538AbhKXRkH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Nov 2021 12:40:07 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id A41EE60F5B;
        Wed, 24 Nov 2021 17:36:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1637775417;
        bh=iQUGCs2xLZBCwekrLPkbwhDvG4Zu09rdgjYqdAmOpMY=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=X7IIAHHx3F1gPHP7r9McuIdqwEv643zG+yVvOwHaaROlYgJs37CFBAw/MlEQbdq3X
         vh4RHIDzrm+CcJTsEPSZUfhyjsKV0T7po3JMrqT9gzF8pTl0A1dfFjN5wRWyb1pemg
         AKKpmM+wmGpIIoQ1pZuNcmNN0XTWfSEFIr1YQuazZnmDvyTZKktJPBeCCljp9iShun
         vVkZYqvvpoA1WCYrnvpzKH8h52F3Tl51vHGctbOvFHjuyezO/HMPLyiFNdo4uw/l+H
         ZSUfHK/uHziyDxF6O+CQUxgfO/CgE4UsdowtT72B9BAi2MqwkQDq2mCWAu+kr7jes4
         9Gji5NYxkL7Qg==
From:   Mark Brown <broonie@kernel.org>
To:     Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        Matti Vaittinen <mazziesaccount@gmail.com>
Cc:     Lee Jones <lee.jones@linaro.org>, linux-kernel@vger.kernel.org,
        linux-power@fi.rohmeurope.com
In-Reply-To: <YZ3UXXrk/Efe7Scj@fedora>
References: <YZ3UXXrk/Efe7Scj@fedora>
Subject: Re: [PATCH] regulator: rohm-generic: remove unused dummies
Message-Id: <163777541640.2712255.13531254221451180690.b4-ty@kernel.org>
Date:   Wed, 24 Nov 2021 17:36:56 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 24 Nov 2021 07:57:49 +0200, Matti Vaittinen wrote:
> Function rohm_regulator_set_voltage_sel_restricted() and
> rohm_regulator_set_dvs_levels() had inlined dummy implementations for
> cases when the real implementation was not configured in.
> 
> All of the drivers who issue the call to these functions do SELECT the
> real implementation from the Kconfig. There should be no cases where the
> real implementation was not selected by the drivers using these
> functions - such a situation is likely to be an error which deserves to be
> noticed at compile-time.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git for-next

Thanks!

[1/1] regulator: rohm-generic: remove unused dummies
      commit: 432dd1fc134ef902b049b26839edfd3fdc1f8dc0

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
