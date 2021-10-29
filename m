Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8ACB044046C
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Oct 2021 22:55:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231562AbhJ2U5g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Oct 2021 16:57:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:57188 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230370AbhJ2U5b (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Oct 2021 16:57:31 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 51EAD60F57;
        Fri, 29 Oct 2021 20:54:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1635540901;
        bh=IPg6nSSMi2IfwMSUIGvn+Ln1n/eLa9+lEO9Jbi5n7kw=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=mvPzReQDpfMEeyj5/9ZeCP5gI6VL39O85cIOCc+w6QM9WR2u3mE7tBfy7un0Vw3jE
         5U7M/Xs0p5cbeJwCeCCdXSmbCQEe/8WZlsGGZ3wr4xszNXlTuNBctKAXhXtpRJgJ4j
         52ssX5G/4r+tsLjw6Xhq7zqftx6F25shuge21I3nDd2gAKAec9kPgSEKo4Vx8/uzrc
         B02WxkRgDDMBQOPwNnSbUkHDfbWBLPn3gpfnnuQm1/Am1MB2lV1rk30/NJx5kgrNg1
         s00soI7ra9s7DtQcpibl+qPO9QF+SKXGQLpdbw6Cfj8vcZnKkWrrcWK7qYMFLqkQLu
         wBYHtiWewUc7Q==
From:   Mark Brown <broonie@kernel.org>
To:     alsa-devel@alsa-project.org, Brent Lu <brent.lu@intel.com>
Cc:     Gongjun Song <gongjun.song@intel.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Yong Zhi <yong.zhi@intel.com>, Takashi Iwai <tiwai@suse.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Bard Liao <bard.liao@intel.com>,
        Curtis Malainey <cujomalainey@chromium.org>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>,
        Kai Vehmanen <kai.vehmanen@linux.intel.com>,
        Cezary Rojewski <cezary.rojewski@intel.com>,
        Libin Yang <libin.yang@intel.com>,
        Rander Wang <rander.wang@linux.intel.com>,
        Liam Girdwood <liam.r.girdwood@linux.intel.com>,
        Paul Olaru <paul.olaru@oss.nxp.com>,
        Huajun Li <huajun.li@intel.com>,
        Rander Wang <rander.wang@intel.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Vamshi Krishna Gopal <vamshi.krishna.gopal@intel.com>,
        Jie Yang <yang.jie@linux.intel.com>,
        linux-kernel@vger.kernel.org, Mac Chiang <mac.chiang@intel.com>
In-Reply-To: <20211020155715.2045947-1-brent.lu@intel.com>
References: <20211020155715.2045947-1-brent.lu@intel.com>
Subject: Re: [PATCH v4 0/6] Multiple headphone codec driver support
Message-Id: <163554089709.1997146.9920801603298776810.b4-ty@kernel.org>
Date:   Fri, 29 Oct 2021 21:54:57 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 20 Oct 2021 23:57:09 +0800, Brent Lu wrote:
> Support multiple headphone drivers in same machine driver. In this
> case, both rt5682 and rt5682s are supported and enumerated by different
> ACPI HID "10EC5682" and "RTL5682".
> 
> V2 Changes:
> - remove useless 'NULL', 'false' in if-condition
> - can use 'comp_ids' field alone to enumerate driver
> - add comma to the end of entry in structure initialization
> - keep the table of byt/cht/cml/icl untouched
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/6] ASoC: soc-acpi: add comp_ids field for machine driver matching
      commit: cafa39b650ec3ba8e9efa0825f1c08e029b5a1ed
[2/6] ASoC: Intel: sof_rt5682: detect codec variant in probe function
      commit: 8fe6ec03183ac04fa6529fdf0d4da1328946a9d0
[3/6] ASoC: Intel: sof_rt5682: use comp_ids to enumerate rt5682s
      commit: d4f3fdc2b7e16e8203c5d55bb91d6572647d4b0f
[4/6] ASoC: Intel: soc-acpi-byt: shrink tables using compatible IDs
      commit: dac7cbd55dca4fd9e646e37401079ebfae3935e0
[5/6] ASoC: Intel: soc-acpi-cht: shrink tables using compatible IDs
      commit: 959ae8215a9e8955f45b41e274a1294d7c9aba1b
[6/6] ASoC: Intel: soc-acpi: use const for all uses of snd_soc_acpi_codecs
      commit: 9a5d96add514079660b3f1270a55f8c2dbdbc1b6

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
