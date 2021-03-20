Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A99C1342FD2
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Mar 2021 23:17:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229944AbhCTWQo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 20 Mar 2021 18:16:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229805AbhCTWQe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Mar 2021 18:16:34 -0400
Received: from mail-qk1-x72d.google.com (mail-qk1-x72d.google.com [IPv6:2607:f8b0:4864:20::72d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC36AC061574
        for <linux-kernel@vger.kernel.org>; Sat, 20 Mar 2021 15:16:33 -0700 (PDT)
Received: by mail-qk1-x72d.google.com with SMTP id x14so6810488qki.10
        for <linux-kernel@vger.kernel.org>; Sat, 20 Mar 2021 15:16:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=YgTEn7uxn8Ay3cd4QaCSxvxMq4Z8va37K/vdBDVPpbg=;
        b=hCfMNy7tQlrpXLY4WbP1zHOceFNXn3obMVp4vlT9nt42lSGS2iSaqeutir7ODkzy9k
         ntKzIvdWWEbMGWK+TXi2E9QIyXP/EtCUJvaNFQNJfsSK08OTNRNw4SE40ofdOIlQdtlz
         585X3onVtHwg4CMantv/98LEoqmJx+MOXNivNzRkQVdqOufmfApt5f9/X753cYqx8tb1
         wt9e5YGFFp9DI/3CZ2k1T/Be7PsFdcsCTqmjVQFq/w6ewruzLDpGBvSPJ0LTrAcWAEO9
         FSszqseo62qpRQYaT2ekahkNiBdNQnt0t7yLiCYGb1KqjX+RxK13hieDG+ay+wYjNy6f
         jOhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=YgTEn7uxn8Ay3cd4QaCSxvxMq4Z8va37K/vdBDVPpbg=;
        b=XintwT4tR41Tq7sZ/rjmb9PLepuHjNKCW3c6whJi9cXYChgYfrB4ivViWzXx5OyoZb
         0bh2rYdLi830BPgGvjkdhvSH9GswDkLdtM/UTCjPgWgIjpSCseCewtyyrTQzyPZDw9MT
         I7Ah1jRL2n2TyMl6OoAfE+Q1jKK4DLCOKswERZHBPDa/Ry7NJFUSGFImbjeNhRthNbaH
         inqMYxhmpsvGf7XUgjj0NA+KnoV2Qxn8gzwsuFNW8pfPjJy4g0Z8aPotC27zJfxPLYUf
         sc5GEexcA7PHXvKbWEr95KEjnaikwcP3SY83DDZiHDvLVglOaEOPpVjBIgv2W6PuL44f
         rJZQ==
X-Gm-Message-State: AOAM533qlNKasei02AWyKlOlt3iG9V/ZJDq7y0eNycoq8gEiG3Iy8DBm
        vXC+kB4cplUjU8n0EYDmAhM=
X-Google-Smtp-Source: ABdhPJzrCym9WR3/qtFtSgCH2q7LXMNWXLHSTGEmwqCEqp+3/dzuRHJ6fHrprh/fG0dIUa/PcjB8uw==
X-Received: by 2002:a37:a54f:: with SMTP id o76mr4724164qke.95.1616278592955;
        Sat, 20 Mar 2021 15:16:32 -0700 (PDT)
Received: from tong-desktop.local ([2601:5c0:c200:27c6:f925:bb4b:54d2:533])
        by smtp.googlemail.com with ESMTPSA id x1sm6223973qtr.97.2021.03.20.15.16.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 20 Mar 2021 15:16:32 -0700 (PDT)
From:   Tong Zhang <ztong0001@gmail.com>
To:     Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        Jasmin Fazlic <superfassl@gmail.com>,
        Leon Romanovsky <leon@kernel.org>,
        Tong Zhang <ztong0001@gmail.com>,
        Allen Pais <allen.lkml@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Naoki Hayama <naoki.hayama@lineo.co.jp>,
        Tom Rix <trix@redhat.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Joe Perches <joe@perches.com>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org,
        Romain Perier <romain.perier@gmail.com>
Subject: [PATCH 0/2] ALSA: hdsp and hdspm, don't disable device if not enabled
Date:   Sat, 20 Mar 2021 18:16:18 -0400
Message-Id: <20210320221620.226155-1-ztong0001@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series fixes issues in hdsp and hdspm. The drivers in question want
to disable a device that is not enabled on error path.

Tong Zhang (2):
  ALSA: hdsp: don't disable if not enabled
  ALSA: hdspm: don't disable if not enabled

 sound/pci/rme9652/hdsp.c  | 10 ++++++----
 sound/pci/rme9652/hdspm.c | 10 ++++++----
 2 files changed, 12 insertions(+), 8 deletions(-)

-- 
2.25.1

