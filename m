Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4683843B52F
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Oct 2021 17:11:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236251AbhJZPNx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Oct 2021 11:13:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235044AbhJZPNv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Oct 2021 11:13:51 -0400
Received: from xavier.telenet-ops.be (xavier.telenet-ops.be [IPv6:2a02:1800:120:4::f00:14])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58E9DC061348
        for <linux-kernel@vger.kernel.org>; Tue, 26 Oct 2021 08:11:27 -0700 (PDT)
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed20:441:6c1a:bc30:46e])
        by xavier.telenet-ops.be with bizsmtp
        id AfBR260132hfXWm01fBRfN; Tue, 26 Oct 2021 17:11:25 +0200
Received: from rox.of.borg ([192.168.97.57])
        by ramsan.of.borg with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1mfO6n-0084pC-BV; Tue, 26 Oct 2021 17:11:25 +0200
Received: from geert by rox.of.borg with local (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1mfO6m-00DLmj-Ck; Tue, 26 Oct 2021 17:11:24 +0200
From:   Geert Uytterhoeven <geert+renesas@glider.be>
To:     Ajit Kumar Pandey <AjitKumar.Pandey@amd.com>,
        Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH 0/3] ASoC: amd: acp: Dependency cleanup
Date:   Tue, 26 Oct 2021 17:11:20 +0200
Message-Id: <cover.1635260849.git.geert+renesas@glider.be>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

	Hi all,

This patch series cleans up the dependencies of the various
configuration symbols related to AMD Audio-Coprocessor support.

Feel free to squash into a single patch if you prefer that.

Thanks!

Geert Uytterhoeven (3):
  ASoC: amd: acp: Wrap AMD Audio ACP components in
    SND_SOC_AMD_ACP_COMMON
  ASoC: amd: acp: SND_SOC_AMD_{LEGACY_MACH,SOF_MACH} should depend on
    X86 && PCI && I2C
  ASoC: amd: acp: SND_SOC_AMD_ACP_COMMON should depend on X86 && PCI

 sound/soc/amd/acp/Kconfig | 7 +++++++
 1 file changed, 7 insertions(+)

-- 
2.25.1

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
