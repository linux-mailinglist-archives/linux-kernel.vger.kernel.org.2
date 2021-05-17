Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 48451383D24
	for <lists+linux-kernel@lfdr.de>; Mon, 17 May 2021 21:21:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232866AbhEQTWf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 May 2021 15:22:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232515AbhEQTWe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 May 2021 15:22:34 -0400
Received: from mail-qv1-xf4a.google.com (mail-qv1-xf4a.google.com [IPv6:2607:f8b0:4864:20::f4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6D66C061756
        for <linux-kernel@vger.kernel.org>; Mon, 17 May 2021 12:21:17 -0700 (PDT)
Received: by mail-qv1-xf4a.google.com with SMTP id z93-20020a0ca5e60000b02901ec19d8ff47so5557437qvz.8
        for <linux-kernel@vger.kernel.org>; Mon, 17 May 2021 12:21:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=WSTZG+Ss5oTMbhW5xlZ+aS48SNwB1nH5u8VKqkHoapw=;
        b=dIq1Cdxw9F3TLvhfUP3VO6aAtoX8bNno3Ceg6ZqRXI+oS1PMIcvl6QXimPr3pf3Zpm
         wIe903i4k0i0qwW2CH0ht67bIqKXnCIGjsFDNnM7yg5gGIc/64vzSzpnJ6uxLsY4e7cG
         TiqlOfssmktWpOg50XlqMqPllu8Yo8O7aMif9Is3vqYHtD2+az3k4DpFMNpq5eLpm5HJ
         4N7En/1GyHgfAPmhL80V8kKY1EdDDZ4HwimLaA27ytKeobh/o1Z5wfFrMywb6jvL9jsH
         83aVg6EhlhA82iiA4QyBZcU6DVAt33b5BjrEsvZxAM/M7cxpTJhQutSkPdjKKcc96WVs
         qGGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=WSTZG+Ss5oTMbhW5xlZ+aS48SNwB1nH5u8VKqkHoapw=;
        b=UcuaLHU4yDxZr6viPBO5om29Dens6WJ4PFRB5RULjU0nFZs/Js1RAqgTLey6IJZdW3
         EipFqzUhx7RblC1SYi8pnvns7jSo0thCizypGn6miV4pWkSJZVEAS7a9CqrrUa/X8Jnf
         IoIrjWO3g8RnXosT9Qgp5LgGnkwCcIhPJw5Z2kC8c4WKzlwvewfCrp75TDlgab1LjjQH
         Mnd+AWS+hw/7Pwc5pAq8aOcT4IWP+HTzhBb0KERdx/hBqhKBfG7ul1ZhZzY0y5IMcczI
         czfRYwyzmzDD/jhlBeWxuU2OJ6hmrQuQ+fJ9S7yfqBGeynzgah/BgANe6VlEE+tD/Tmd
         t8KQ==
X-Gm-Message-State: AOAM530V1/c8IjenfO+kiX+IPg+V3RGWmAUFSP5EKu5dN696FQTDSCOC
        mi2A25R6D9DaFTpocnChsWfPKyrodLs=
X-Google-Smtp-Source: ABdhPJyfE/ZBgfcDNqee9SFDjAnTCk0HdmuLR5pY1uqW0l2x15rI1L//Tl0WhHyhUY/QnnNqNs4jC/zZ8ZY=
X-Received: from badhri.mtv.corp.google.com ([2620:15c:211:201:b562:7011:fe35:1c9e])
 (user=badhri job=sendgmr) by 2002:a0c:ab88:: with SMTP id j8mr1243811qvb.23.1621279276966;
 Mon, 17 May 2021 12:21:16 -0700 (PDT)
Date:   Mon, 17 May 2021 12:21:09 -0700
Message-Id: <20210517192112.40934-1-badhri@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.31.1.751.gd2f1c929bd-goog
Subject: [PATCH v2 1/4] usb: typec: tcpm: Fix up PR_SWAP when vsafe0v is signalled
From:   Badhri Jagan Sridharan <badhri@google.com>
To:     Guenter Roeck <linux@roeck-us.net>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Kyle Tso <kyletso@google.com>, stable@vger.kernel.org,
        Badhri Jagan Sridharan <badhri@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

During PR_SWAP, When TCPM is in PR_SWAP_SNK_SRC_SINK_OFF, vbus is
expected to reach VSAFE0V when source turns off vbus. Do not move
to SNK_UNATTACHED state when this happens.

Fixes: 28b43d3d746b ("usb: typec: tcpm: Introduce vsafe0v for vbus")
Signed-off-by: Badhri Jagan Sridharan <badhri@google.com>
Reviewed-by: Guenter Roeck <linux@roeck-us.net>
---
Changes since V1:
- Fixed type s/of/off in commit message.
- Added Reviewed-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/usb/typec/tcpm/tcpm.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/usb/typec/tcpm/tcpm.c b/drivers/usb/typec/tcpm/tcpm.c
index c4fdc00a3bc8..b93c4c8d7b15 100644
--- a/drivers/usb/typec/tcpm/tcpm.c
+++ b/drivers/usb/typec/tcpm/tcpm.c
@@ -5114,6 +5114,9 @@ static void _tcpm_pd_vbus_vsafe0v(struct tcpm_port *port)
 				tcpm_set_state(port, SNK_UNATTACHED, 0);
 		}
 		break;
+	case PR_SWAP_SNK_SRC_SINK_OFF:
+		/* Do nothing, vsafe0v is expected during transition */
+		break;
 	default:
 		if (port->pwr_role == TYPEC_SINK && port->auto_vbus_discharge_enabled)
 			tcpm_set_state(port, SNK_UNATTACHED, 0);
-- 
2.31.1.751.gd2f1c929bd-goog

