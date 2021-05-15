Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D8852381613
	for <lists+linux-kernel@lfdr.de>; Sat, 15 May 2021 07:26:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234059AbhEOF1f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 15 May 2021 01:27:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233825AbhEOF1a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 May 2021 01:27:30 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E218C061756
        for <linux-kernel@vger.kernel.org>; Fri, 14 May 2021 22:26:18 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id e75-20020a25d34e0000b02904f982184581so1922288ybf.4
        for <linux-kernel@vger.kernel.org>; Fri, 14 May 2021 22:26:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=sNHIuQYVsWA/7a4mAAkQImBcT2qMojEQX5dVrrYWLcM=;
        b=oMGbgtK3hrH/5fPQWLdrW3KsbCwX3axogu6RA7twsgK5yjdE+4mL5hNjbVbEKnkBjT
         mPcgm4zODQ18yFDxmT5Vp3ZE1vdkEetuj1Y+D3itJtG8QwZ5Rufa1kuztrtCRWv57gxz
         C7TfWeSmBTZy9f9weM0S3xUSONdocKJUBwY3tp63YWWAjKipKzovYikfyX3rvzfkCUbs
         GZJh8jStGvIKLqDvCncenDCQfVskSZqvR0kxghS6cWM2++iD+gc633rap5yBDFpuBZJF
         q5QsTI1zSkl5lcoSbhjlAnYGuP4N7yQH5e6/glIh7kt3N11KIjeinMgWFvJ4Fj+ysMhc
         lpZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=sNHIuQYVsWA/7a4mAAkQImBcT2qMojEQX5dVrrYWLcM=;
        b=O3/aoLgVTOWgCHfnB7n0qxQfk0cMAxE76W7UOZWgRbJ7cp+kN2KMbMMXi3XvGd2x+j
         LYsTzdzDJ1q9Vo/BU3TnUTGnbcWJ125f4DHC0dsiAww55ebkctMKcqdQZJPESZJrAX/s
         zpBZcxtufQxwNBGItrj8143llaRJAsxHsLxlB5P7WH2uoboHHnfMoM9cKBI9oSQTOTWF
         tFjFtULWInxsNoQzIN+fxNi5b6T4SJOFFgVobEz5PoYXX1am9euSVJJArVYVn0rWe2ef
         2GQLiLpSVL6er/LV3eWIBDptstsSKAjQx6m7hHRu6tUF/T5Kp/5QnUTH1WJOkq8O09fb
         c3Wg==
X-Gm-Message-State: AOAM533cyyWZI+8rS+mUmSVWNpfzvipb5qXvVmfVfaOJVpuZhiChCjxQ
        MtfrujKRCu9N1Qk2DLBw4s8E+7x6RVQ=
X-Google-Smtp-Source: ABdhPJwk0WyQnMdHJuZpEfbU+WKgE802VKw+8Tif87zivPDmE0aWIgkLjkHBEvy6pZ5/rwWz3eMx86YyjYA=
X-Received: from badhri.mtv.corp.google.com ([2620:15c:211:201:6bd1:251e:e226:7071])
 (user=badhri job=sendgmr) by 2002:a25:9942:: with SMTP id n2mr70156951ybo.230.1621056377552;
 Fri, 14 May 2021 22:26:17 -0700 (PDT)
Date:   Fri, 14 May 2021 22:26:10 -0700
Message-Id: <20210515052613.3261340-1-badhri@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.31.1.751.gd2f1c929bd-goog
Subject: [PATCH v1 1/4] usb: typec: tcpm: Fix up PR_SWAP when vsafe0v is signalled
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
expected to reach VSAFE0V when source turns of vbus. Do not move
to SNK_UNATTACHED state when this happens.

Fixes: 28b43d3d746b ("usb: typec: tcpm: Introduce vsafe0v for vbus")
Signed-off-by: Badhri Jagan Sridharan <badhri@google.com>
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

