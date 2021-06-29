Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 07B1D3B71F0
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jun 2021 14:17:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233564AbhF2MUC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Jun 2021 08:20:02 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:32490 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233384AbhF2MT6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jun 2021 08:19:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1624969050;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=lkR0c3+f759b1MBukw4/QJ32vsAA4j16pgDMpxfOoYw=;
        b=LPy98tg5VYNn5Jp4TFZxglNmp1CIX/gvq1Nn42wgbAQ4roCBes4+J92RQkt2NW2BR8cs46
        XfzkPIntZAgWBxL3EVbXeQQ5a+sawz0sbjAi/7MRNO/hYm+ATuri5J3UXFQyP0aiod4hOH
        sqltXPu7330hiCZAn5BngbY55E0K0qo=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-559-lXouSpMCMjm3aj9enhezUw-1; Tue, 29 Jun 2021 08:17:29 -0400
X-MC-Unique: lXouSpMCMjm3aj9enhezUw-1
Received: by mail-wr1-f69.google.com with SMTP id e13-20020a5d530d0000b0290126d989c76eso1234304wrv.18
        for <linux-kernel@vger.kernel.org>; Tue, 29 Jun 2021 05:17:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=lkR0c3+f759b1MBukw4/QJ32vsAA4j16pgDMpxfOoYw=;
        b=Yfm2aHo+w6e3/wQYoa79xK5dwS/EJVp7Yf5Us7K51q6/QmKK/HzU8IbQBPslkIIhza
         TNTzGWqF415uIuc7A3GdDvzFSKhQqUUBd+egAk9ZmiNTTYo/b1qevtapMKTlKJeHkD78
         15MJNSiu1Qw8nxXO03I4r/oc+BihA8dibtid34kbz2svY2jZvL07OZ2xqv3aZisg2l2a
         CO8HmGoB/HS+GSaaCPl/G3nbgc50+0vG1NNiPHUDDTWigD0l0Q4qy+/wvmlggQLYKl1D
         OyT63xWOaV2VWwKha/zXFdumrHBLTDeY1XECXuD/QOFGy3Sb6oZnKxyCZSdfu8uZqlLx
         oOiA==
X-Gm-Message-State: AOAM533CquHYZk0+kNebfVkdkqUQhXkjJoSAJf4L+c3Wy+tWR43c9RzC
        xXzoYfQsJzUjvT1COZgaxnvkQ58KrB+1ZAXLPsAkJMtP3JWc3kmIzBYKixMmV4dFFyPllAdIAmI
        vE4s2msBoTbw3Xm9PfvdkIF/x
X-Received: by 2002:adf:e449:: with SMTP id t9mr34362063wrm.40.1624969048217;
        Tue, 29 Jun 2021 05:17:28 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz2WLVKTxMcFRD6jMJdil31aytKHfmkR8Pg4EuSGDVn0CCstL4X5a+bn1K/4I3JTHdAqKPP6A==
X-Received: by 2002:adf:e449:: with SMTP id t9mr34362048wrm.40.1624969048091;
        Tue, 29 Jun 2021 05:17:28 -0700 (PDT)
Received: from vian.redhat.com ([2a0c:5a80:3d14:2800:933d:abfc:d8e4:637f])
        by smtp.gmail.com with ESMTPSA id t9sm17032631wmq.14.2021.06.29.05.17.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Jun 2021 05:17:27 -0700 (PDT)
From:   Nicolas Saenz Julienne <nsaenzju@redhat.com>
To:     mripard@kernel.org
Cc:     emma@anholt.net, airlied@linux.ie, daniel@ffwll.ch,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        linux-rpi-kernel@lists.infradead.org,
        Nicolas Saenz Julienne <nsaenzju@redhat.com>
Subject: [PATCH] drm/vc4: hdmi: Limit noise when deferring snd card registration
Date:   Tue, 29 Jun 2021 14:17:23 +0200
Message-Id: <20210629121723.11523-1-nsaenzju@redhat.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We don't want to print an error message each time
devm_snd_soc_register_card() returns -EPROBE_DEFER, the function will
most likely succeed some time in the future, once the missing resources
are available. So use dev_err_probe(), which will redirect the messages
to the debug log level in such case.

Signed-off-by: Nicolas Saenz Julienne <nsaenzju@redhat.com>
---
 drivers/gpu/drm/vc4/vc4_hdmi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/vc4/vc4_hdmi.c b/drivers/gpu/drm/vc4/vc4_hdmi.c
index 04936cd6db8c..32da45821d3a 100644
--- a/drivers/gpu/drm/vc4/vc4_hdmi.c
+++ b/drivers/gpu/drm/vc4/vc4_hdmi.c
@@ -1575,7 +1575,7 @@ static int vc4_hdmi_audio_init(struct vc4_hdmi *vc4_hdmi)
 	snd_soc_card_set_drvdata(card, vc4_hdmi);
 	ret = devm_snd_soc_register_card(dev, card);
 	if (ret)
-		dev_err(dev, "Could not register sound card: %d\n", ret);
+		dev_err_probe(dev, ret, "Could not register sound card\n");
 
 	return ret;
 
-- 
2.31.1

