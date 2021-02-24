Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D0BF3245AD
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Feb 2021 22:21:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235885AbhBXVUO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Feb 2021 16:20:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235379AbhBXVUI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Feb 2021 16:20:08 -0500
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FFCAC06174A
        for <linux-kernel@vger.kernel.org>; Wed, 24 Feb 2021 13:19:27 -0800 (PST)
Received: by mail-lf1-x133.google.com with SMTP id z11so5222110lfb.9
        for <linux-kernel@vger.kernel.org>; Wed, 24 Feb 2021 13:19:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=MM8lRVTEi67ROhOzPrn24FSX21U5wxP/r4L8+ZdPQ2g=;
        b=BRabxy4aR3qNWGDNKy3hK0gY0gFXnJR0fLQXsES4dfJC3gH+kwao5Y5kiVzz7mRakF
         BL/3QxzgXoz7JFnZq4pNyIFpAk+SWLkbybNf5e3xUGO6SeVwE4iKZ1DztwkrNp2/cwVH
         Gj9NVrmH9r8azQvgenXXcjBuNrgx3BM38VjAh8yB7WtmQ59EXqTC6AxLm62G4LVrNILf
         tpA28ESjBlIyORjEa8kjG0GbpbMBirxhMV4Jgbu396lfDszujOSHPC5IJXhCva4i66fx
         sb8HACSVmFO5AK++R+3h/FcevUKkA0/y+K3tkJwFEJsQTswYmAGA1Ev2bchlhrp5cSrX
         zoxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=MM8lRVTEi67ROhOzPrn24FSX21U5wxP/r4L8+ZdPQ2g=;
        b=svJfAoDXHlLpq0Nq2Jx2adZmbXxQZLyW1bqJggK4U4SEG0nRzoNa/hGpHIRjVK2cY+
         v+kiIilsolLfgANW0tl/ir0Jd7EtxVhxrceQCEX7os7Y/o5jfZv/cmSkEGIS0F52Lzdh
         QH2eIs9Ngvp5ybIOSSR5Uud1XDFiK0j2D1fggRWne/t1kUqwwAI+5RmMb0HmpGKS6nSy
         ugoFs8fs56mQQ1Bi4cidSTvtbRZMQjYdkdunYpiRHRvIFvSuHynktUkvZIQZyJpd5sv9
         RdGHRjHZ6N8YnI0f+GYksDgf/1xBTOzE861eda8w41cAwE8lJVMBATPUBwQyXXXApq9g
         ic1A==
X-Gm-Message-State: AOAM530yUDfATdtvY2Oainy1vMv+3YmEiPm2HE0tlBu84i5K+qDucQnC
        4+32ljmLrNKKPA51sCDdbAk=
X-Google-Smtp-Source: ABdhPJwyFbVVquaVbhPQJW6vmosdTHqeGskZgmaphUjB0Q2E3UAyaegpCAeQfUF4bdAJshkYrdBxxA==
X-Received: by 2002:a19:f60c:: with SMTP id x12mr11290410lfe.156.1614201566034;
        Wed, 24 Feb 2021 13:19:26 -0800 (PST)
Received: from localhost.localdomain (h-98-128-229-129.NA.cust.bahnhof.se. [98.128.229.129])
        by smtp.gmail.com with ESMTPSA id w26sm717116lfr.186.2021.02.24.13.19.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Feb 2021 13:19:25 -0800 (PST)
From:   Rikard Falkeborn <rikard.falkeborn@gmail.com>
To:     Oder Chiou <oder_chiou@realtek.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc:     Liam Girdwood <lgirdwood@gmail.com>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org,
        Rikard Falkeborn <rikard.falkeborn@gmail.com>
Subject: [PATCH 1/4] ASoC: rt*: Constify static struct sdw_slave_ops
Date:   Wed, 24 Feb 2021 22:19:15 +0100
Message-Id: <20210224211918.39109-2-rikard.falkeborn@gmail.com>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <20210224211918.39109-1-rikard.falkeborn@gmail.com>
References: <20210224211918.39109-1-rikard.falkeborn@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The only usage of these is to assign their address to the ops field in
the sdw_driver struct, which is a pointer to const. Make them const to
allow the compiler to put them in read-only memory.

Signed-off-by: Rikard Falkeborn <rikard.falkeborn@gmail.com>
---
 sound/soc/codecs/rt1308-sdw.c | 2 +-
 sound/soc/codecs/rt5682-sdw.c | 2 +-
 sound/soc/codecs/rt700-sdw.c  | 2 +-
 sound/soc/codecs/rt711-sdw.c  | 2 +-
 sound/soc/codecs/rt715-sdw.c  | 2 +-
 5 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/sound/soc/codecs/rt1308-sdw.c b/sound/soc/codecs/rt1308-sdw.c
index afd2c3b687cc..1c226994aebd 100644
--- a/sound/soc/codecs/rt1308-sdw.c
+++ b/sound/soc/codecs/rt1308-sdw.c
@@ -594,7 +594,7 @@ static int rt1308_sdw_pcm_hw_free(struct snd_pcm_substream *substream,
  * slave_ops: callbacks for get_clock_stop_mode, clock_stop and
  * port_prep are not defined for now
  */
-static struct sdw_slave_ops rt1308_slave_ops = {
+static const struct sdw_slave_ops rt1308_slave_ops = {
 	.read_prop = rt1308_read_prop,
 	.interrupt_callback = rt1308_interrupt_callback,
 	.update_status = rt1308_update_status,
diff --git a/sound/soc/codecs/rt5682-sdw.c b/sound/soc/codecs/rt5682-sdw.c
index b49f1e16125d..0b7ac74e671d 100644
--- a/sound/soc/codecs/rt5682-sdw.c
+++ b/sound/soc/codecs/rt5682-sdw.c
@@ -683,7 +683,7 @@ static int rt5682_interrupt_callback(struct sdw_slave *slave,
 	return 0;
 }
 
-static struct sdw_slave_ops rt5682_slave_ops = {
+static const struct sdw_slave_ops rt5682_slave_ops = {
 	.read_prop = rt5682_read_prop,
 	.interrupt_callback = rt5682_interrupt_callback,
 	.update_status = rt5682_update_status,
diff --git a/sound/soc/codecs/rt700-sdw.c b/sound/soc/codecs/rt700-sdw.c
index 4001612dfd73..ff9c081fd52a 100644
--- a/sound/soc/codecs/rt700-sdw.c
+++ b/sound/soc/codecs/rt700-sdw.c
@@ -430,7 +430,7 @@ static int rt700_interrupt_callback(struct sdw_slave *slave,
  * slave_ops: callbacks for get_clock_stop_mode, clock_stop and
  * port_prep are not defined for now
  */
-static struct sdw_slave_ops rt700_slave_ops = {
+static const struct sdw_slave_ops rt700_slave_ops = {
 	.read_prop = rt700_read_prop,
 	.interrupt_callback = rt700_interrupt_callback,
 	.update_status = rt700_update_status,
diff --git a/sound/soc/codecs/rt711-sdw.c b/sound/soc/codecs/rt711-sdw.c
index 2beb4286d997..8f5ebe92d407 100644
--- a/sound/soc/codecs/rt711-sdw.c
+++ b/sound/soc/codecs/rt711-sdw.c
@@ -431,7 +431,7 @@ static int rt711_interrupt_callback(struct sdw_slave *slave,
 	return 0;
 }
 
-static struct sdw_slave_ops rt711_slave_ops = {
+static const struct sdw_slave_ops rt711_slave_ops = {
 	.read_prop = rt711_read_prop,
 	.interrupt_callback = rt711_interrupt_callback,
 	.update_status = rt711_update_status,
diff --git a/sound/soc/codecs/rt715-sdw.c b/sound/soc/codecs/rt715-sdw.c
index 71dd3b97a459..81a1dd77b6f6 100644
--- a/sound/soc/codecs/rt715-sdw.c
+++ b/sound/soc/codecs/rt715-sdw.c
@@ -488,7 +488,7 @@ static int rt715_bus_config(struct sdw_slave *slave,
 	return 0;
 }
 
-static struct sdw_slave_ops rt715_slave_ops = {
+static const struct sdw_slave_ops rt715_slave_ops = {
 	.read_prop = rt715_read_prop,
 	.update_status = rt715_update_status,
 	.bus_config = rt715_bus_config,
-- 
2.30.1

