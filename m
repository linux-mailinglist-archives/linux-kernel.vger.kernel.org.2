Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9BFDB342FDD
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Mar 2021 23:26:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229884AbhCTWYV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 20 Mar 2021 18:24:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229618AbhCTWXu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Mar 2021 18:23:50 -0400
Received: from mail-qv1-xf2a.google.com (mail-qv1-xf2a.google.com [IPv6:2607:f8b0:4864:20::f2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAF63C061574
        for <linux-kernel@vger.kernel.org>; Sat, 20 Mar 2021 15:23:49 -0700 (PDT)
Received: by mail-qv1-xf2a.google.com with SMTP id dc12so5995786qvb.4
        for <linux-kernel@vger.kernel.org>; Sat, 20 Mar 2021 15:23:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=3IoRiMiCXfHlMDAYVKlK+AcDstpRUpfO/zO8PeDHvaA=;
        b=cyTyFV3HPdUr/17t9zHdbMObKhaJqemNf8iSSO/o7fEQ0gdeBoJWtrPGTNXeevVXrv
         M1oevWp7y+XVSXO+08+EqVUwktTguXR8G8AgHjOmUkW2PShRIcDnbAu5qwmmYZ2pdZ8s
         heBPKidp+XRi1eqbB5Q3vLDtGE33lddjFJEnTMM9jXy3lYqK50PitCKkx7r1eXSl8RdS
         p10SWa7J/5EhqnC7Ow2CUTwwLQ1TNEU8bwShHctfZXla/1juw/37pbOmIL/AX6QtAAA/
         Vb1dO7mzmxw/NPmvyc1NOYNpCkZiWqjYbbLzAxQq+PAWwRGF+hp73ReJ16obMN74FKdi
         RsIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=3IoRiMiCXfHlMDAYVKlK+AcDstpRUpfO/zO8PeDHvaA=;
        b=oTS+mu1OOxEx8HCkAjFJFqUOcIwEOMyHgzgYHfTWEN/JwixgiEoCBgpBt8c1T96U5S
         e4l5eD7uDc0pvJ1n605/pHhs7gzbjKppDl3Evil2F6ZBzvu2j9TxAmhRa57UdLob5BmD
         f5ELHK6xxIGAP7I/Sq6TpBOVE02Dt8MMQF2NKj+6zpoIti4dpYeqkFtB8TgIgJKzbLp6
         gYpRTvG5RXQR+E5NHeKo0TJ1QQQyDGZrB4HCq2KKZ4/WgUPEJGk8I9a8S7uK2Jz2twC8
         xq7CNaMrCa1c1QrkpN/Kar6SYBmz5yu+4yizQyNy/fGQkSjO9gpXob1ONk1C037pvxzu
         WwNg==
X-Gm-Message-State: AOAM533TtTbOES72rQnGnPTq15FcS4QLoQiLplCT4RAw0jROqJsBthA2
        KX62am/63UgGVovI7KUuiteD2ACOyPQKcQ==
X-Google-Smtp-Source: ABdhPJwzW2oFWYnl+cKTtdjNpadmWiznxWn8HpkyNmH/1vwMvPivj7nAQgAWc9LqmaF+dWcHRxDBvA==
X-Received: by 2002:ad4:4ab0:: with SMTP id i16mr15313202qvx.1.1616279029043;
        Sat, 20 Mar 2021 15:23:49 -0700 (PDT)
Received: from tong-desktop.local ([2601:5c0:c200:27c6:f925:bb4b:54d2:533])
        by smtp.googlemail.com with ESMTPSA id i6sm7570213qkk.31.2021.03.20.15.23.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 20 Mar 2021 15:23:48 -0700 (PDT)
From:   Tong Zhang <ztong0001@gmail.com>
To:     Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        Romain Perier <romain.perier@gmail.com>,
        Allen Pais <allen.lkml@gmail.com>,
        Leon Romanovsky <leon@kernel.org>,
        Jasmin Fazlic <superfassl@gmail.com>,
        Tong Zhang <ztong0001@gmail.com>,
        Mark Brown <broonie@kernel.org>, Joe Perches <joe@perches.com>,
        Tom Rix <trix@redhat.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/3] ALSA: hdsp and hdspm, don't disable device if not enabled
Date:   Sat, 20 Mar 2021 18:23:33 -0400
Message-Id: <20210320222337.243368-1-ztong0001@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series fixes issues in hdsp and hdspm. The drivers in question want
to disable a device that is not enabled on error path.

v2: add fix to rme9652

Tong Zhang (3):
  ALSA: hdsp: don't disable if not enabled
  ALSA: hdspm: don't disable if not enabled
  ALSA: rme9652: don't disable if not enabled

 sound/pci/rme9652/hdsp.c    | 10 ++++++----
 sound/pci/rme9652/hdspm.c   | 10 ++++++----
 sound/pci/rme9652/rme9652.c | 10 ++++++----
 3 files changed, 18 insertions(+), 12 deletions(-)

-- 
2.25.1

