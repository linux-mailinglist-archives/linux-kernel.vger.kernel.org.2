Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 80E1F345D35
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Mar 2021 12:44:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229979AbhCWLoO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Mar 2021 07:44:14 -0400
Received: from esa.microchip.iphmx.com ([68.232.154.123]:26299 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229508AbhCWLns (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Mar 2021 07:43:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1616499828; x=1648035828;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=DpYG8Z1gC9+ORcyjTx5xuAVjW/vhEJGniuyQZn/VnPg=;
  b=ExqXlKhE4WnhEbjFwXq5G/kVX5JfLEeetW5LKzGdxn+caBUH7F04YMLA
   2bT5xW8XjOfy6vZP7sAJ/KFlQA+j0S28DUUJwzhmeKJ7wJetz19shtJtu
   DDF1VcOk8xqeJdCjy3LqYnlfKZf4OJYXe5ubpLEQ55JQrQmjLhohe7s9G
   DIql2+nXu0pfsntt0LLPwJrQ9KKucR8IyxFiB+gxxLAQIVq7Po6PrebCA
   7hpgmadwHc/cL2HZPGptLscdFlF53x8z5q5VF6i1Sr1qIUw+NCJxjxgDr
   3YfL8VltMeWozVzYuMzjuwTeawjhZv2Ppts/iUp8KtNk3AxdzALfttNg4
   A==;
IronPort-SDR: TTcKxBHmTU9c96cbX7RU3RZie2F6+C6gWhhLWhI/42QvJ7+h7HepBDZL0Vma74n/fdJIHNP392
 NjIb2U48POIoort/EmDijBsVXi4Y4j1XDw/pRK0KiaLu6vYAqErIe4IdBVLTUFVpKE0Ert4eRJ
 W9r3UgNrlvmBrEUDhytquOATi5hahmN3xhRrdxkVbDmkKAHx1kAUobp3YFIflk5PTA0MP/wvqO
 Ur3AdiCB4t8sM/RuU6OqzxMyDABnjkFn0N2/vE12gUpo0ewogLhyuaof/MlCJH7o3tuMSKQbRy
 QmQ=
X-IronPort-AV: E=Sophos;i="5.81,271,1610434800"; 
   d="scan'208";a="48536203"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 23 Mar 2021 04:43:47 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Tue, 23 Mar 2021 04:43:47 -0700
Received: from rob-ult-m19940.amer.actel.com (10.10.115.15) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.2176.2 via Frontend Transport; Tue, 23 Mar 2021 04:43:44 -0700
From:   Codrin Ciubotariu <codrin.ciubotariu@microchip.com>
To:     <alsa-devel@alsa-project.org>, <linux-kernel@vger.kernel.org>
CC:     <perex@perex.cz>, <tiwai@suse.com>, <lgirdwood@gmail.com>,
        <broonie@kernel.org>, <mirq-linux@rere.qmqm.pl>,
        <gustavoars@kernel.org>,
        Codrin Ciubotariu <codrin.ciubotariu@microchip.com>
Subject: [RFC PATCH 0/3] Separate BE DAI HW constraints from FE ones
Date:   Tue, 23 Mar 2021 13:43:24 +0200
Message-ID: <20210323114327.3969072-1-codrin.ciubotariu@microchip.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

HW constraints are needed to set limitations for HW parameters used to
configure the DAIs. All DAIs on the same link must agree upon the HW
parameters, so the parameters are affected by the DAIs' features and
their limitations. In case of DPCM, the FE DAIs can be used to perform
different kind of conversions, such as format or rate changing, bringing
the audio stream to a configuration supported by all the DAIs of the BE's
link. For this reason, the limitations of the BE DAIs are not always
important for the HW parameters between user-space and FE, only for the
paratemers between FE and BE DAI links. This brings us to this patch-set,
which aims to separate the FE HW constraints from the BE HW constraints.
This way, the FE can be used to perform more efficient HW conversions, on
the initial audio stream parameters, to parameters supported by the BE
DAIs.
To achieve this, the first thing needed is to detect whether a HW
constraint rule is enforced by a FE or a BE DAI. This means that
snd_pcm_hw_rule_add() needs to be able to differentiate between the two
type of DAIs. For this, the runtime pointer to struct snd_pcm_runtime is
replaced with a pointer to struct snd_pcm_substream, to be able to reach
substream->pcm->internal to differentiate between FE and BE DAIs.
This change affects many sound drivers (and one gpu drm driver).
All these changes are included in the first patch, to have a better
overview of the implications created by this change.
The second patch adds a new struct snd_pcm_hw_constraints under struct
snd_soc_dpcm_runtime, which is used to store the HW constraint rules
added by the BE DAIs. This structure is initialized with a subset of the
runtime constraint rules which does not include the rules that affect
the buffer or period size. snd_pcm_hw_rule_add() will add the BE rules
to the new struct snd_pcm_hw_constraints.
The third and last patch will apply the BE rule constraints, after the
fixup callback. If the fixup HW parameters do not respect the BE
constraint rules, the rules will exit with an error. The FE mask and
interval constraints are copied to the BE ones, to satisfy the
dai_link->dpcm_merged_* flags. The dai_link->dpcm_merged_* flags are
used to know if the FE does format or sampling rate conversion.

I tested with ad1934 and wm8731 codecs as BEs, with a not-yet-mainlined
ASRC as FE, that can also do format conversion. I realize that the
change to snd_pcm_hw_rule_add() has a big impact, even though all the
drivers use snd_pcm_hw_rule_add() with substream->runtime, so passing
substream instead of runtime is not that risky.

Codrin Ciubotariu (3):
  pcm: use substream instead of runtime in snd_pcm_hw_rule_add()
  ASoC: soc-pcm: add hw_constraints for BE DAI links
  ASoC: soc-pcm: apply BE HW constraint rules

 drivers/gpu/drm/vc4/vc4_hdmi.c                |  2 +-
 include/sound/ac97_codec.h                    |  2 +-
 include/sound/pcm.h                           | 29 +++++--
 include/sound/pcm_drm_eld.h                   |  2 +-
 include/sound/soc-dpcm.h                      |  1 +
 sound/arm/aaci.c                              |  4 +-
 sound/arm/pxa2xx-pcm-lib.c                    |  4 +-
 sound/core/pcm_drm_eld.c                      |  6 +-
 sound/core/pcm_lib.c                          | 66 ++++++++-------
 sound/core/pcm_native.c                       | 83 +++++++++++--------
 sound/drivers/aloop.c                         |  8 +-
 sound/drivers/vx/vx_pcm.c                     |  8 +-
 sound/firewire/amdtp-am824.c                  |  8 +-
 sound/firewire/amdtp-am824.h                  |  2 +-
 sound/firewire/amdtp-stream.c                 | 12 +--
 sound/firewire/amdtp-stream.h                 |  2 +-
 sound/firewire/bebob/bebob_pcm.c              |  6 +-
 sound/firewire/dice/dice-pcm.c                |  6 +-
 sound/firewire/digi00x/amdtp-dot.c            |  6 +-
 sound/firewire/digi00x/digi00x-pcm.c          |  6 +-
 sound/firewire/digi00x/digi00x.h              |  2 +-
 sound/firewire/fireface/amdtp-ff.c            |  6 +-
 sound/firewire/fireface/ff-pcm.c              |  6 +-
 sound/firewire/fireface/ff.h                  |  2 +-
 sound/firewire/fireworks/fireworks_pcm.c      |  6 +-
 sound/firewire/motu/amdtp-motu.c              |  6 +-
 sound/firewire/motu/motu-pcm.c                |  6 +-
 sound/firewire/motu/motu.h                    |  2 +-
 sound/firewire/oxfw/oxfw-pcm.c                |  6 +-
 sound/firewire/tascam/amdtp-tascam.c          |  6 +-
 sound/firewire/tascam/tascam-pcm.c            |  2 +-
 sound/firewire/tascam/tascam.h                |  2 +-
 sound/pci/ac97/ac97_pcm.c                     |  8 +-
 sound/pci/ali5451/ali5451.c                   |  2 +-
 sound/pci/atiixp.c                            |  2 +-
 sound/pci/atiixp_modem.c                      |  2 +-
 sound/pci/au88x0/au88x0_pcm.c                 |  6 +-
 sound/pci/azt3328.c                           |  2 +-
 sound/pci/bt87x.c                             |  8 +-
 sound/pci/ca0106/ca0106_main.c                |  4 +-
 sound/pci/cmipci.c                            | 14 ++--
 sound/pci/cs4281.c                            |  4 +-
 sound/pci/cs46xx/cs46xx_lib.c                 |  4 +-
 sound/pci/echoaudio/echoaudio.c               | 24 +++---
 sound/pci/emu10k1/emu10k1x.c                  |  4 +-
 sound/pci/emu10k1/emupcm.c                    | 10 +--
 sound/pci/ens1370.c                           | 12 +--
 sound/pci/es1938.c                            |  4 +-
 sound/pci/es1968.c                            |  2 +-
 sound/pci/fm801.c                             |  6 +-
 sound/pci/hda/hda_codec.c                     |  2 +-
 sound/pci/hda/hda_controller.c                |  4 +-
 sound/pci/hda/patch_hdmi.c                    |  8 +-
 sound/pci/hda/patch_si3054.c                  |  2 +-
 sound/pci/ice1712/ice1712.c                   |  8 +-
 sound/pci/ice1712/ice1724.c                   | 30 +++----
 sound/pci/intel8x0.c                          | 10 +--
 sound/pci/intel8x0m.c                         |  2 +-
 sound/pci/lola/lola_pcm.c                     |  4 +-
 sound/pci/mixart/mixart.c                     |  8 +-
 sound/pci/nm256/nm256.c                       |  2 +-
 sound/pci/oxygen/oxygen_pcm.c                 |  8 +-
 sound/pci/pcxhr/pcxhr.c                       |  4 +-
 sound/pci/rme32.c                             | 14 ++--
 sound/pci/rme96.c                             | 17 ++--
 sound/pci/rme9652/hdsp.c                      | 24 +++---
 sound/pci/rme9652/hdspm.c                     | 12 +--
 sound/pci/rme9652/rme9652.c                   | 20 ++---
 sound/pci/sonicvibes.c                        |  4 +-
 sound/pci/via82xx.c                           |  4 +-
 sound/pci/via82xx_modem.c                     |  2 +-
 sound/pci/ymfpci/ymfpci_main.c                |  4 +-
 sound/soc/adi/axi-i2s.c                       |  2 +-
 sound/soc/adi/axi-spdif.c                     |  2 +-
 sound/soc/amd/acp-da7219-max98357a.c          | 40 ++++-----
 sound/soc/atmel/atmel_ssc_dai.c               |  2 +-
 sound/soc/bcm/bcm63xx-pcm-whistler.c          |  4 +-
 sound/soc/bcm/cygnus-pcm.c                    |  5 +-
 sound/soc/bcm/cygnus-ssp.c                    |  2 +-
 sound/soc/codecs/ad193x.c                     |  2 +-
 sound/soc/codecs/adau1372.c                   |  2 +-
 sound/soc/codecs/ak4458.c                     |  2 +-
 sound/soc/codecs/ak4613.c                     |  6 +-
 sound/soc/codecs/ak5558.c                     |  2 +-
 sound/soc/codecs/cs35l33.c                    |  2 +-
 sound/soc/codecs/cs35l34.c                    |  2 +-
 sound/soc/codecs/cs35l35.c                    |  4 +-
 sound/soc/codecs/cs35l36.c                    |  2 +-
 sound/soc/codecs/cs4234.c                     |  4 +-
 sound/soc/codecs/cs42l73.c                    |  2 +-
 sound/soc/codecs/cs43130.c                    |  4 +-
 sound/soc/codecs/cs53l30.c                    |  2 +-
 sound/soc/codecs/es8316.c                     |  2 +-
 sound/soc/codecs/es8328.c                     |  2 +-
 sound/soc/codecs/hdmi-codec.c                 |  2 +-
 sound/soc/codecs/max98090.c                   |  2 +-
 sound/soc/codecs/max9867.c                    |  2 +-
 sound/soc/codecs/pcm512x.c                    |  6 +-
 sound/soc/codecs/sigmadsp.c                   |  2 +-
 sound/soc/codecs/ssm2602.c                    |  2 +-
 sound/soc/codecs/uda1334.c                    |  2 +-
 sound/soc/codecs/wm8523.c                     |  2 +-
 sound/soc/codecs/wm8524.c                     |  2 +-
 sound/soc/codecs/wm8731.c                     |  2 +-
 sound/soc/codecs/wm8741.c                     |  2 +-
 sound/soc/fsl/fsl_asrc.c                      |  4 +-
 sound/soc/fsl/fsl_easrc.c                     |  2 +-
 sound/soc/fsl/fsl_sai.c                       |  4 +-
 sound/soc/fsl/fsl_ssi.c                       |  2 +-
 sound/soc/fsl/fsl_xcvr.c                      |  9 +-
 sound/soc/fsl/imx-audmix.c                    |  2 +-
 sound/soc/kirkwood/kirkwood-dma.c             |  4 +-
 sound/soc/mediatek/common/mtk-afe-fe-dai.c    |  2 +-
 sound/soc/mediatek/mt2701/mt2701-cs42448.c    |  2 +-
 .../mediatek/mt8183/mt8183-da7219-max98357.c  | 12 +--
 .../mt8183/mt8183-mt6358-ts3a227-max98357.c   | 12 +--
 sound/soc/meson/aiu-encoder-i2s.c             |  2 +-
 sound/soc/meson/aiu-fifo.c                    |  4 +-
 sound/soc/meson/axg-fifo.c                    |  4 +-
 sound/soc/sh/rcar/core.c                      |  6 +-
 sound/soc/soc-pcm.c                           | 76 ++++++++++++++++-
 sound/soc/sti/uniperif_player.c               |  4 +-
 sound/soc/sti/uniperif_reader.c               |  4 +-
 sound/soc/sunxi/sun4i-codec.c                 |  2 +-
 sound/soc/sunxi/sun8i-codec.c                 |  2 +-
 sound/soc/tegra/tegra_pcm.c                   |  2 +-
 sound/soc/ti/davinci-mcasp.c                  | 12 +--
 sound/soc/ti/omap-mcbsp.c                     |  4 +-
 sound/soc/uniphier/aio-dma.c                  |  4 +-
 sound/soc/xilinx/xlnx_formatter_pcm.c         |  2 +-
 sound/usb/hiface/pcm.c                        |  2 +-
 sound/usb/line6/capture.c                     |  2 +-
 sound/usb/line6/playback.c                    |  2 +-
 sound/usb/misc/ua101.c                        |  2 +-
 sound/usb/pcm.c                               | 24 +++---
 135 files changed, 535 insertions(+), 429 deletions(-)

-- 
2.27.0

