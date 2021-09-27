Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C3C81419825
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Sep 2021 17:45:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235210AbhI0Pqs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Sep 2021 11:46:48 -0400
Received: from smtp-relay-internal-1.canonical.com ([185.125.188.123]:49146
        "EHLO smtp-relay-internal-1.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234500AbhI0Pqr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Sep 2021 11:46:47 -0400
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 9B99440264
        for <linux-kernel@vger.kernel.org>; Mon, 27 Sep 2021 15:45:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1632757508;
        bh=QblA15uiwZ7l+Ibk9gNFwOO+GmQVJrKRAtlqWocjIZ8=;
        h=From:To:Cc:Subject:Date:Message-Id:MIME-Version;
        b=N92Z5vyx4awUm1LnPpyRFAgETxSD2VepiMB0Va3uvTyDZZX2IzI+9um3kdby4ke+G
         rEr34TsV5y5p2Eu1rusKVk4fPsoJbDAbFgYphNuKT5nVqznO4F8hN6mWvnhhxJdcwo
         +xmL9DW4Xgdz1wa18rRGw3dKKfhV5YPpI5H1i6OYtb71RZwMozb3udL+SPHYlybhSF
         lL+NbKXuJGl5YyFxDUgg7EAyzzJbtoMe4wcC4YVfdPLIV+pv4R3e8xvBWIOQecwphA
         8eS2hsFktIwQ8sW7DoiD7TRqMyxLZ4CBNQeOUkiE5ICJu5LjCJmsuUNayV9aUjzdXs
         f78PkfQwNWmrg==
Received: by mail-pl1-f198.google.com with SMTP id v7-20020a1709029a0700b0013daaeaa33eso6150254plp.5
        for <linux-kernel@vger.kernel.org>; Mon, 27 Sep 2021 08:45:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=QblA15uiwZ7l+Ibk9gNFwOO+GmQVJrKRAtlqWocjIZ8=;
        b=wsYlghnRfn5QOLcVPCRlcjeYbNc8gwoz7kmBJPsK/InPMSvqnRjIvaO9u7tKge7SWf
         nZzbJEqgnrUYfwumjUjCtrZlYwNmzqCf889XbE2bYq+KqiZ5GeTxu2LU8ctaLdA07h9g
         WQ7TkJLhDR/WF0DcQFX7gVsSV1xi0t91zc+apsskJ6oHVZtqZFm66GAiRclRbrTkpghi
         OimacUrp5ceJadwntCQB9W2swxU4QveiGh0nyqAuAkh3eH98r14kBXVwCp5VIJa8l/D2
         xnql/hnhOrppY/ijGaLSF1EIw/F35k4NIkQ+y1S2aXzHcc7GYIUHeEf/IbpzsN6uDBWn
         Hh6w==
X-Gm-Message-State: AOAM532xrfV7tAk6PCG3xMf2AAgAjgohu/V5okrcyYd6tu+hK6z5n6TB
        Nchhj8CnfGSzAOa+qXKp9d2hrmOCc4yF8QjcyccrccueJpfHxTPt2AHfe6vR6fgcwmU5JoIDD1z
        bs2mC2uRFvonuN4N1ohj5yXhZa5OVj+NMFal9K/dcUQ==
X-Received: by 2002:a62:7e55:0:b0:441:c7a6:fcd2 with SMTP id z82-20020a627e55000000b00441c7a6fcd2mr383214pfc.6.1632757507045;
        Mon, 27 Sep 2021 08:45:07 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwIcXtn44DVJ7kkF5B6wBQHYvxY4BnpmGkvMYNq6WMkWLzHV8KuCCeAXC9apx+oB2TD0uA2Gw==
X-Received: by 2002:a62:7e55:0:b0:441:c7a6:fcd2 with SMTP id z82-20020a627e55000000b00441c7a6fcd2mr383191pfc.6.1632757506705;
        Mon, 27 Sep 2021 08:45:06 -0700 (PDT)
Received: from localhost.localdomain ([69.163.84.166])
        by smtp.gmail.com with ESMTPSA id y2sm15987228pjl.6.2021.09.27.08.45.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Sep 2021 08:45:06 -0700 (PDT)
From:   Tim Gardner <tim.gardner@canonical.com>
To:     linux-fbdev@vger.kernel.org
Cc:     tim.gardner@canonical.com, Antonino Daplas <adaplas@gmail.com>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH][next] nvidiafb: Use strscpy() to prevent buffer overflow.
Date:   Mon, 27 Sep 2021 09:45:02 -0600
Message-Id: <20210927154502.21026-1-tim.gardner@canonical.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Coverity complains of a possible buffer overflow. However,
given the 'static' scope of nvidia_setup_i2c_bus() it looks
like that can't happen after examiniing the call sites.

CID 19036 (#1 of 1): Copy into fixed size buffer (STRING_OVERFLOW)
1. fixed_size_dest: You might overrun the 48-character fixed-size string
  chan->adapter.name by copying name without checking the length.
2. parameter_as_source: Note: This defect has an elevated risk because the
  source argument is a parameter of the current function.
 89        strcpy(chan->adapter.name, name);

Fix this warning by using strscpy() which will silence the warning and
prevent any future buffer overflows should the names used to identify the
channel become much longer.

Cc: Antonino Daplas <adaplas@gmail.com>
Cc: linux-fbdev@vger.kernel.org
Cc: dri-devel@lists.freedesktop.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Tim Gardner <tim.gardner@canonical.com>
---
 drivers/video/fbdev/nvidia/nv_i2c.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/video/fbdev/nvidia/nv_i2c.c b/drivers/video/fbdev/nvidia/nv_i2c.c
index d7994a173245..0b48965a6420 100644
--- a/drivers/video/fbdev/nvidia/nv_i2c.c
+++ b/drivers/video/fbdev/nvidia/nv_i2c.c
@@ -86,7 +86,7 @@ static int nvidia_setup_i2c_bus(struct nvidia_i2c_chan *chan, const char *name,
 {
 	int rc;
 
-	strcpy(chan->adapter.name, name);
+	strscpy(chan->adapter.name, name, sizeof(chan->adapter.name));
 	chan->adapter.owner = THIS_MODULE;
 	chan->adapter.class = i2c_class;
 	chan->adapter.algo_data = &chan->algo;
-- 
2.33.0

