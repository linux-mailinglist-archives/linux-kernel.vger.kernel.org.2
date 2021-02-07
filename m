Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3330431266B
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Feb 2021 18:38:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229684AbhBGRht (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 7 Feb 2021 12:37:49 -0500
Received: from hqnvemgate24.nvidia.com ([216.228.121.143]:3579 "EHLO
        hqnvemgate24.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229491AbhBGRhs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Feb 2021 12:37:48 -0500
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate24.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B602025430001>; Sun, 07 Feb 2021 09:37:07 -0800
Received: from HQMAIL111.nvidia.com (172.20.187.18) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Sun, 7 Feb
 2021 17:37:07 +0000
Received: from audio.nvidia.com (172.20.145.6) by mail.nvidia.com
 (172.20.187.18) with Microsoft SMTP Server id 15.0.1473.3 via Frontend
 Transport; Sun, 7 Feb 2021 17:37:04 +0000
From:   Sameer Pujar <spujar@nvidia.com>
To:     <broonie@kernel.org>
CC:     <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
        <kuninori.morimoto.gx@renesas.com>, <alsa-devel@alsa-project.org>,
        <linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <sharadg@nvidia.com>, Sameer Pujar <spujar@nvidia.com>
Subject: [PATCH v3 0/2] Rename audio graph export functions
Date:   Sun, 7 Feb 2021 23:06:56 +0530
Message-ID: <1612719418-5858-1-git-send-email-spujar@nvidia.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1612719428; bh=deN95pb8Y3cHc6wmhcWRIoGtDMyX/fLvfA0avxA1/b8=;
        h=From:To:CC:Subject:Date:Message-ID:X-Mailer:MIME-Version:
         Content-Type;
        b=E9JcHcTglrcb0zclaZ33P9n9+ZQomA3uoelUZIpVb0YHnWuFcEgiSL33QcDOycrYk
         t5iwQ3cKUWn9Ew355Yl9C4qUd0f7hIcsX574cEwh+YNCfSVQkCq+oZEFpysFWcD9ef
         g+W7ryBpoOPHZe/QATiB6Tkr7xaci/wuTLl9oV5Fsinp8cfHODx8vdyEAcgGDfZdSj
         CJYKKpxvq0xNe1vEnlVUGuQCAcKkO8ElItuymV0ADbV2HqDDBfVoW5V1PaRZ0nJ1RT
         sr3Fw7IAqS9DyM/Z/lWyRZzMrub/pTOW48nHqvcXUxvunRDh2qLSFia50XgT/M5X9V
         1c0Mxsd4xTHAQ==
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series renames exported functions from audio graph for a better
global visibility. In doing so update the references in audio graph
and Tegra audio graph card drivers.


Changelog
=========

v2 -> v3:
---------
 [Patch v3 1/2]:
   - Squashed "patch v2 1/3" and "patch v2 2/3". Updated commit message
     accordingly.
   - Add "Acked-by" tag from Morimoto-san.

 [Patch v3 2/2]:
   - Add "Acked-by" tag from Morimoto-san.

v1 -> v2:
---------
 [Patch v2 1/3]:
   - Rename graph_parse_of() to audio_graph_parse_of() and
     graph_card_probe() to audio_graph_card_probe() as well.

   - Update above references in audio graph driver.

 [Patch v2 2/3]: New patch
   - Update references for audio_graph_parse_of() and
     audio_graph_card_probe() in Tegra graph driver.

   - Add "Depends-on" tag

 [Patch v2 3/3]:
   - Update commit message to add "Depends-on" tag.

Sameer Pujar (2):
  ASoC: audio-graph: Rename functions needed for export
  ASoC: tegra: Add driver remove() callback

 include/sound/graph_card.h               |  6 ++++--
 sound/soc/generic/audio-graph-card.c     | 17 +++++++++--------
 sound/soc/tegra/tegra_audio_graph_card.c |  9 +++++----
 3 files changed, 18 insertions(+), 14 deletions(-)

-- 
2.7.4

