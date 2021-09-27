Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 66FCF419D69
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Sep 2021 19:48:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236105AbhI0RuR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Sep 2021 13:50:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:59186 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236258AbhI0Rto (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Sep 2021 13:49:44 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9411760FD7;
        Mon, 27 Sep 2021 17:48:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1632764886;
        bh=rmEeqBYM9LuHb+thct8OrwB+y0kgIxvtDtMa3Kaq5AI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JSgPG2wIrp+hK1v9Z7r3cRHnWDXms51O/9Aj6qVOnS/tkR8c6GPWyDOA+lWwWwCll
         gYmZMDlWZEjr5wLvSMmCB8RukqstRgNylNB/aMhchhJYOT/1WD2NssiSUYRRWbEJyw
         xR3czgOP+VUAQ0lvplDbaBpbQ+e+nEDMhapColg6M3ymoGnL+hXexLONul9fyqMI32
         WpuFC9OZJ0qsJVA7KmrGIORFmed+z2Ybeu+SxUi2LmN+9B6+/PTNy1rqJ/QRa0wly/
         70WFp+TT098hB8+WIQZ30i6JW7bh3SUvJlGp5VU0MGR/7KaKx7+zfx3TO32K2iPmvd
         y0AaQWQAnNJBg==
From:   Mark Brown <broonie@kernel.org>
To:     Simon Trimmer <simont@opensource.cirrus.com>, lgirdwood@gmail.com
Cc:     Mark Brown <broonie@kernel.org>, patches@opensource.cirrus.com,
        linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org
Subject: Re: [PATCH 00/16] add driver to support firmware loading on Cirrus Logic DSPs
Date:   Mon, 27 Sep 2021 18:45:47 +0100
Message-Id: <163276442023.18200.6494204806311200005.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210913160057.103842-1-simont@opensource.cirrus.com>
References: <20210913160057.103842-1-simont@opensource.cirrus.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 13 Sep 2021 17:00:41 +0100, Simon Trimmer wrote:
> This series of patches gradually separates the ASoC specific wm_adsp
> code from that required to manage firmware in Cirrus Logic DSPs.
> 
> The series starts with renaming, progresses to splitting the
> functionality before finally moving the independent functionality into
> drivers/firmware so that it can be used by both the existing ASoC
> wm_adsp and new non-audio parts.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[01/16] ASoC: wm_adsp: Remove use of snd_ctl_elem_type_t
        commit: d07a6d454ffa310ee306d57f486eb64380bbdfff
[02/16] ASoC: wm_adsp: Move check for control existence
        commit: 6477960755fb2c0ca9b0497bc86abfa4ee173556
[03/16] ASoC: wm_adsp: Switch to using wm_coeff_read_ctrl for compressed buffers
        commit: 04ae08596737c4d3872dfb6e617c918d9ecf073e
[04/16] ASoC: wm_adsp: Cancel ongoing work when removing controls
        commit: df6c505c129a114da783ae82b9f0b4d2d4691c91
[05/16] ASoC: wm_adsp: Rename generic DSP support
        commit: 5beb8eeade2c03b55ae729c05bb9fa245633fe74
[06/16] ASoC: wm_adsp: Introduce cs_dsp logging macros
        commit: 6ab1d0cc8470100cc8e0b478d94ff00b44df1625
[07/16] ASoC: wm_adsp: Separate some ASoC and generic functions
        commit: 25ca837ba6f4dd8f969b41aa202a62facdd2370c
[08/16] ASoC: wm_adsp: Split DSP power operations into helper functions
        commit: 186152df4d431650154c3e3aefc7d3e1004987c8
[09/16] ASoC: wm_adsp: Move sys_config_size to wm_adsp
        commit: 6092be2d93b3b28dfeca4e5944052a1a21f51ca3
[10/16] ASoC: wm_adsp: Separate generic cs_dsp_coeff_ctl handling
        commit: 0700bc2fb94c28459f57a10d2ee2c7ef4cb70862
[11/16] ASoC: wm_adsp: Move check of dsp->running to better place
        commit: edb1d6d7f03913b2b6ca299b1f6fd8dc96d511f5
[12/16] ASoC: wm_adsp: Pass firmware names as parameters when starting DSP core
        commit: 2169f2f15185f9393b1c16eac6e7c7d4adb6279b
[13/16] ASoC: wm_adsp: move firmware loading to client
        commit: a828056fa1fc044beab3cbe32f484fec5f38fe98
[14/16] ASoC: wm_adsp: Split out struct cs_dsp from struct wm_adsp
        commit: e146820215910d889ab16d6c2484fd51a6bb8f1f
[15/16] ASoC: wm_adsp: Separate wm_adsp specifics in cs_dsp_client_ops
        commit: 2dd044641ec3672433b9fe3ec47b236621757aa8
[16/16] firmware: cs_dsp: add driver to support firmware loading on Cirrus Logic DSPs
        commit: f6bc909e7673c30abcbdb329e7d0aa2e83c103d7

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
