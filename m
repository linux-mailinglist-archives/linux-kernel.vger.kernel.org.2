Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A98F139CDFF
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Jun 2021 10:15:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230112AbhFFIQu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Jun 2021 04:16:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230003AbhFFIQt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Jun 2021 04:16:49 -0400
Received: from mail-qv1-xf4a.google.com (mail-qv1-xf4a.google.com [IPv6:2607:f8b0:4864:20::f4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 904C5C061767
        for <linux-kernel@vger.kernel.org>; Sun,  6 Jun 2021 01:15:00 -0700 (PDT)
Received: by mail-qv1-xf4a.google.com with SMTP id if5-20020a0562141c45b029021fee105740so6431114qvb.9
        for <linux-kernel@vger.kernel.org>; Sun, 06 Jun 2021 01:15:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=VOkk9SHKODEiIaCjHRVGDFttv1xB96FlGn6EoEewOHo=;
        b=iDi+D4O/64oMalj7NDWxWFAJhNOxmwvywuHRupaZeJVE44Cwq1VIfhbgZbehE8iYQM
         EYid8RlUhLT0xc4twZV6rknQ+Jqky6Egc6Iymtaal5SUi5QaLGCxfGcQe8FhofhJuVwV
         Z/jZisMQwazLdgX/a9pIHpF8g4pHhBu7M8oc5jH497nDTitfifFNNShHolzp2bfnhflN
         r/BTKt+iS6TXUDY/t1sUuqtwlX8+tbR2I+KzrqoKKKvOuwFUnY7ZIqE+vj6ugVlcP7ZT
         oZizGgYnT7j82zX/sjqpmsrl6/za8OJCMJfGxlhDhi/sbGSVQqngUrNhPo38kvTtAhIm
         aHdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=VOkk9SHKODEiIaCjHRVGDFttv1xB96FlGn6EoEewOHo=;
        b=mKcKqG6yKk+6geDvZb0VThJgMieL2/mxNLhk0K8IbHEGu+eXPXFhkf6S3IeA0r2RCN
         qD/2wsGDwQr9eIIXDAMeYqP3Wp1a7TsIoEl+H5x0RKXi76SaQkNtXLQHotWnZl7EHB7C
         BOFgP5Hwb5X1QITqISYg1flVhpOSnKrzjupFibXrrXpYN+S9Nt5YRkj3bdAC13c+zAUE
         AOiLszCNwV5JyluU3DBb8tLbq9LVrakyPfVLgkn1UD9fTGr+evUBgujkqRZ9h/W8k0G5
         c6tQKzepC833ioi04yoyHEgYXz1yiKMlWLabOP2Jyj6rSZMSCISnP0DkRiEhyFgCtdhd
         YwZA==
X-Gm-Message-State: AOAM533rj1BOIgy/La68u3phBOm8aah54SGKjTwi2SoItiaegM9+XctO
        PfbKFim/fpfu5Spdb6JDe2OHe0Jn3Nb4
X-Google-Smtp-Source: ABdhPJy4We1ZBM0a34557fIrttfTWocguftYAyyopbi5pamCZqd3FxN+7xSZFyPhZCzYm5jp40HNHnl8/HpK
X-Received: from kyletso.ntc.corp.google.com ([2401:fa00:fc:202:5235:5c99:43:ac3])
 (user=kyletso job=sendgmr) by 2002:a0c:e942:: with SMTP id
 n2mr12441036qvo.5.1622967299273; Sun, 06 Jun 2021 01:14:59 -0700 (PDT)
Date:   Sun,  6 Jun 2021 16:14:52 +0800
Message-Id: <20210606081452.764032-1-kyletso@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.32.0.rc1.229.g3e70b5a671-goog
Subject: [PATCH] usb: typec: tcpm: Do not finish VDM AMS for retrying Responses
From:   Kyle Tso <kyletso@google.com>
To:     linux@roeck-us.net, heikki.krogerus@linux.intel.com,
        gregkh@linuxfoundation.org
Cc:     badhri@google.com, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, Kyle Tso <kyletso@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If the VDM responses couldn't be sent successfully, it doesn't need to
finish the AMS until the retry count reaches the limit.

Fixes: 0908c5aca31e ("usb: typec: tcpm: AMS and Collision Avoidance")
Signed-off-by: Kyle Tso <kyletso@google.com>
---
 drivers/usb/typec/tcpm/tcpm.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/usb/typec/tcpm/tcpm.c b/drivers/usb/typec/tcpm/tcpm.c
index 0db685d5d9c0..08fabe1fc31d 100644
--- a/drivers/usb/typec/tcpm/tcpm.c
+++ b/drivers/usb/typec/tcpm/tcpm.c
@@ -1965,6 +1965,9 @@ static void vdm_run_state_machine(struct tcpm_port *port)
 			tcpm_log(port, "VDM Tx error, retry");
 			port->vdm_retries++;
 			port->vdm_state = VDM_STATE_READY;
+			if (PD_VDO_SVDM(vdo_hdr) && PD_VDO_CMDT(vdo_hdr) == CMDT_INIT)
+				tcpm_ams_finish(port);
+		} else {
 			tcpm_ams_finish(port);
 		}
 		break;
-- 
2.32.0.rc1.229.g3e70b5a671-goog

