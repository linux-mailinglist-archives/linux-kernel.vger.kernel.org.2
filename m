Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 10DBC38CE58
	for <lists+linux-kernel@lfdr.de>; Fri, 21 May 2021 21:46:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239188AbhEUTrf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 May 2021 15:47:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:36786 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229518AbhEUTre (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 May 2021 15:47:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1621626370;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=AXwRBBohTtNMiSH1d9p6GTDN1YY1LoVt6VscAgQqN4A=;
        b=ExZneuu/6kcj/fxH9cv4pyX0dnr1IiEEYhwubgvdYW5Bf25GV9114JHTCZD8L5D9f7gEZC
        F4TMMAgmWlZVV7cwH/CzQOUUUc4jt6VQ4b/+e89i/GhL+qJWy6dsKWS3Q6rs/YqpdjAscH
        6N6nfmvTL90BKYFIwUGtkq8/bSeZxvQ=
Received: from mail-ot1-f69.google.com (mail-ot1-f69.google.com
 [209.85.210.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-557-Cu882EXhOlCN_tiTJhO5VA-1; Fri, 21 May 2021 15:46:08 -0400
X-MC-Unique: Cu882EXhOlCN_tiTJhO5VA-1
Received: by mail-ot1-f69.google.com with SMTP id v16-20020a0568300910b029032e3cb976e3so6443053ott.14
        for <linux-kernel@vger.kernel.org>; Fri, 21 May 2021 12:46:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=AXwRBBohTtNMiSH1d9p6GTDN1YY1LoVt6VscAgQqN4A=;
        b=QzEtwydDl9f5Yb8HAPbhvbw7L0gvGzH0o1oS5Lnr4aaSoAxSkreByCioLFAErSrKah
         13ounsgNK4tcFuXUGEps8MhZBbLD9FOvg3oxyJrSbEkHjCKKCc3AsLhyy+NLniS7g8UH
         Hn4ZE4ZcYUCSQ8YNK6B53bKtVDJad6eC/UuZSVIyY/O6q0PMyPxbbC/s4yYAwlitltch
         +vf26e8gJ/9sYLjOzY+Rka0P2se8KgoBMR5CBArpDVcPI1Pz6rEckF6dUXAt8s2VQLiR
         S92VPAJINrOlF6UJRc3oVauWBb/oPFG88Ft62fFUnu2Vchgj1P0X6UKy4MmYdLTGz4xC
         whFA==
X-Gm-Message-State: AOAM530sXhcvdeylAd7hB7JLr3QcdY1hdaJmwsK+42NRS7gH1ILzETxo
        2BsdaYEXPTjMjZ8+L1MSyto9/HkifWR4lKI6NA+uPegmn59rGvRiUTd4W88Zyumgr0c1drEKaD+
        XNWYEWLNWctQuK9QaOhdaE2aR
X-Received: by 2002:a05:6808:488:: with SMTP id z8mr3404930oid.135.1621626367898;
        Fri, 21 May 2021 12:46:07 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzyDk+Y3YN0rSUTLPNqk+rFU9Nris8z2XeAeY7SxWK4J0Q/XmqBVVYpuz7Xq8mEvp6X6hYXxA==
X-Received: by 2002:a05:6808:488:: with SMTP id z8mr3404920oid.135.1621626367732;
        Fri, 21 May 2021 12:46:07 -0700 (PDT)
Received: from localhost.localdomain.com (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id s17sm1371250oog.31.2021.05.21.12.46.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 May 2021 12:46:07 -0700 (PDT)
From:   trix@redhat.com
To:     perex@perex.cz, tiwai@suse.com, gustavoars@kernel.org
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        Tom Rix <trix@redhat.com>
Subject: [PATCH] ALSA: usb-audio: initialize the cur variable
Date:   Fri, 21 May 2021 12:46:03 -0700
Message-Id: <20210521194603.2077623-1-trix@redhat.com>
X-Mailer: git-send-email 2.26.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tom Rix <trix@redhat.com>

Static analysis reports this problem
clock.c:338:10: warning: The right operand of '=='
  is a garbage value
    if (i == cur)
          ^  ~~~

In __uac_clock_find_source() the goto find_others skips over
setting of the 'cur' variable.  Since the pin loop variable
starts with 1, it is safe to initialize cur to 0.

Signed-off-by: Tom Rix <trix@redhat.com>
---
 sound/usb/clock.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/sound/usb/clock.c b/sound/usb/clock.c
index 772478c725c2e..edc458c50bf2c 100644
--- a/sound/usb/clock.c
+++ b/sound/usb/clock.c
@@ -258,9 +258,10 @@ static int __uac_clock_find_source(struct snd_usb_audio *chip,
 	union uac23_clock_source_desc *source;
 	union uac23_clock_selector_desc *selector;
 	union uac23_clock_multiplier_desc *multiplier;
-	int ret, i, cur, err, pins, clock_id;
+	int ret, i, err, pins, clock_id;
 	const u8 *sources;
 	int proto = fmt->protocol;
+	int cur = 0;
 
 	entity_id &= 0xff;
 
-- 
2.26.3

