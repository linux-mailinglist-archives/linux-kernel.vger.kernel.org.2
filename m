Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 747CC30A4DA
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Feb 2021 11:03:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233004AbhBAKDd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Feb 2021 05:03:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232893AbhBAKDb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Feb 2021 05:03:31 -0500
Received: from mail-pl1-x64a.google.com (mail-pl1-x64a.google.com [IPv6:2607:f8b0:4864:20::64a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD952C061786
        for <linux-kernel@vger.kernel.org>; Mon,  1 Feb 2021 02:02:16 -0800 (PST)
Received: by mail-pl1-x64a.google.com with SMTP id u14so8234121plf.4
        for <linux-kernel@vger.kernel.org>; Mon, 01 Feb 2021 02:02:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:message-id:mime-version:subject:from:to:cc;
        bh=Og/c9ZLdNwsrZjaKOb5Rw1KYlib1KDQj+P2JjTzCuz0=;
        b=DmWfY39Wj7fxUx8ibl+Z+al1uxv6KEvvJsECeAKzMQwk0gXAQ/qhPSzhoOXv/sXLIK
         8H9oT3lTTOlpfoEpIZOsNxCe2A2HMY4dpzwWeAnk5vF03qnv6cOG+gBUBYsCVanFmNxT
         HdQVFG8EmIEZSo4W4nrOkXpz/36FHTzoDZMMVxoNjuFl3rwmsQ8WwqADYRhD8mOTubIA
         g2NgHZdjmKLO/9O9QHMcQJNl6JjqrDo7tL1N8B0WD2c2csh4VkRlxUxP9EcNlQgcOpJS
         Mm8tkLY6ah6k7mBQoYFbRObRud4wqTyg6N/rhUokphC6LUccEjIAdV/R5Dke5GBgFueu
         iX+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:message-id:mime-version:subject:from
         :to:cc;
        bh=Og/c9ZLdNwsrZjaKOb5Rw1KYlib1KDQj+P2JjTzCuz0=;
        b=jKNXIUhAtCzGF9KwtgFZd4vi4vGOBJZoBBVAkFSvlXXbHjol2DqqQI9voaAAo0ZW0l
         zo8onlX3K027rnmYD7kBPWs8mtQv+QkHG3GuVSI558PCJgP5aCvZen3HhgN0yd5p30IZ
         md+8h5NYw4ooXzmwwvyo+r434OqUaPkNqWCiG8jqdIzzce6LZupRHSImUNB/EWqdEjpV
         Pi2Q20Ahj4tTHfA6G93cMSNO0vH0j9g+qv2fuHGQ6ofZ67wKmP21pj618iH4GgYTxLM3
         fK3Z+iWVcyOf7j7frXeM+C1i4Gcbe/QN9vGGTwAoDTsyL60wX4iwJVaWqohWWQfjv6H2
         +AmA==
X-Gm-Message-State: AOAM5308o17bIznFh0J0k2XISBehI+/CrBu+bUKi07iqe6/Yigd8UIas
        eITqrNeaXgsQEZwAJWQfdkgVBHL04BY=
X-Google-Smtp-Source: ABdhPJwuXWe0OtSSniZkbe8CTK0ILYwh7B9NbHem64lmhhBWV3ivpxgrXlz4jQuYO1v6IShRAlkmrZhhGrk=
Sender: "badhri via sendgmr" <badhri@badhri.mtv.corp.google.com>
X-Received: from badhri.mtv.corp.google.com ([2620:15c:211:201:f292:1cff:fee0:66cf])
 (user=badhri job=sendgmr) by 2002:a17:902:429:b029:de:2bee:150d with SMTP id
 38-20020a1709020429b02900de2bee150dmr11263515ple.18.1612173736228; Mon, 01
 Feb 2021 02:02:16 -0800 (PST)
Date:   Mon,  1 Feb 2021 02:02:12 -0800
Message-Id: <20210201100212.49863-1-badhri@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.30.0.365.g02bc693789-goog
Subject: [PATCH v1] usb: typec: tcpm: Handle vbus shutoff when in source mode
From:   Badhri Jagan Sridharan <badhri@google.com>
To:     Guenter Roeck <linux@roeck-us.net>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kyle Tso <kyletso@google.com>
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Badhri Jagan Sridharan <badhri@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

While in source mode, vbus could be shutoff by protections
circuits. TCPM does not move back to toggling state to
re-initiate connection. Fix this by moving to SRC_UNATTACHED
state when vbus shuts off while in source mode.

Signed-off-by: Badhri Jagan Sridharan <badhri@google.com>
---
 drivers/usb/typec/tcpm/tcpm.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/usb/typec/tcpm/tcpm.c b/drivers/usb/typec/tcpm/tcpm.c
index 0afd8ef692e8..ff0732c12b8a 100644
--- a/drivers/usb/typec/tcpm/tcpm.c
+++ b/drivers/usb/typec/tcpm/tcpm.c
@@ -4897,6 +4897,17 @@ static void _tcpm_pd_vbus_off(struct tcpm_port *port)
 		/* Do nothing, waiting for sink detection */
 		break;
 
+	case SRC_STARTUP:
+	case SRC_SEND_CAPABILITIES:
+	case SRC_SEND_CAPABILITIES_TIMEOUT:
+	case SRC_NEGOTIATE_CAPABILITIES:
+	case SRC_TRANSITION_SUPPLY:
+	case SRC_READY:
+	case SRC_WAIT_NEW_CAPABILITIES:
+		/* Force to unattached state to re-initiate connection */
+		tcpm_set_state(port, SRC_UNATTACHED, 0);
+		break;
+
 	case PORT_RESET:
 		/*
 		 * State set back to default mode once the timer completes.
-- 
2.30.0.365.g02bc693789-goog

