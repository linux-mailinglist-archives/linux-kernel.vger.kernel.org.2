Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C9D2F415274
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Sep 2021 23:11:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237968AbhIVVMl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Sep 2021 17:12:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237965AbhIVVMi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Sep 2021 17:12:38 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6ECA9C061574
        for <linux-kernel@vger.kernel.org>; Wed, 22 Sep 2021 14:11:07 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id m3so17536738lfu.2
        for <linux-kernel@vger.kernel.org>; Wed, 22 Sep 2021 14:11:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=QMQcJBWQUQW5D7xGsPJ08p8WJE5BrDCE3EAWWlVcQfg=;
        b=a+EnzQqfAs0AGlSvqMw25x8nRlzYnbrM/wJtgOQuewXc+Oy7TgwqH4ahUg1ITNS5xA
         pC0plLG4l5jz4sCeROukRX9VqmlUFVvhRPcULIQTBLLOHiOze962KH8TV30JWyfbR7O5
         YrP/qQFnAsrnZnwfyXarMrQMbfM9KbGZaiA5eGxFsPZTnJUXb1BzeU9lfzCNSPS9cArV
         oVWsFgRPnXluWW0gPBNMPBIurpKpRCPmm987TQQAgcGQmxUUGEGVPMdvRz0Br9Z+Vty/
         cLk9hecrNHUBSEEB2GALSsPXEeRZ7yOj0u1GHWdy8Wfxl4ZDWvr05v0+krnAghg2m8ez
         QLuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=QMQcJBWQUQW5D7xGsPJ08p8WJE5BrDCE3EAWWlVcQfg=;
        b=WmxkOxgvP06Ib5he26wOmprVJxnXlPxnEGHPa6/XBFZLeMeSetb5/JlwGBh+1RND6f
         jJwSwY0Ja+nmYpf1XUtV0AB5KrROPykZXk9Cw8Ss8tdyhI/6Me/dqUV1R9ijYUG6Z6Pg
         8nocTKcdR0VTLVf7O3kTXOmt15x6YZxcdTVSrzJlycSB0lKX6HHgCXKAjl4Wmra9T+hZ
         9aa/I11XFtUEov7PcGebBRhQj76TvYZ7hG+H38zwFRPS5PnwArjqMB5FyM6C6opkJOl+
         AS6Yvr/IJGsyR130mQBua7plhzxiB5YZGFoa9rMMDWVNGhyax5fA3nD4Oh+CwgQhTEwd
         n1Tw==
X-Gm-Message-State: AOAM530tttkaq/Mul/sLk0CwMjcKdAQwWdLCkz/r1JU3F4iCKQf54DE4
        2fInc9xY5JmqefM31pdMrBs=
X-Google-Smtp-Source: ABdhPJzKVPkOQKHmjy2XTMpQ/oXmWF7EcfOU6Wl1iAf7HAXDWOH7CZNgD1Xu0JzvCux9mJshqLdSEw==
X-Received: by 2002:a2e:b8c2:: with SMTP id s2mr1438055ljp.171.1632345065876;
        Wed, 22 Sep 2021 14:11:05 -0700 (PDT)
Received: from localhost.localdomain (h-98-128-228-193.NA.cust.bahnhof.se. [98.128.228.193])
        by smtp.gmail.com with ESMTPSA id u28sm267168lfo.47.2021.09.22.14.11.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Sep 2021 14:11:05 -0700 (PDT)
From:   Rikard Falkeborn <rikard.falkeborn@gmail.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, Joe Perches <joe@perches.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Rikard Falkeborn <rikard.falkeborn@gmail.com>
Subject: [PATCH] const_structs.checkpatch: Add a few sound ops structs
Date:   Wed, 22 Sep 2021 23:10:42 +0200
Message-Id: <20210922211042.38017-1-rikard.falkeborn@gmail.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a couple of commonly used (>50 instances) sound ops structs that are
typically const.

Signed-off-by: Rikard Falkeborn <rikard.falkeborn@gmail.com>
---
 scripts/const_structs.checkpatch | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/scripts/const_structs.checkpatch b/scripts/const_structs.checkpatch
index 1aae4f4fdacc..3980985205a0 100644
--- a/scripts/const_structs.checkpatch
+++ b/scripts/const_structs.checkpatch
@@ -54,7 +54,11 @@ sd_desc
 seq_operations
 sirfsoc_padmux
 snd_ac97_build_ops
+snd_pcm_ops
+snd_rawmidi_ops
 snd_soc_component_driver
+snd_soc_dai_ops
+snd_soc_ops
 soc_pcmcia_socket_ops
 stacktrace_ops
 sysfs_ops
-- 
2.33.0

