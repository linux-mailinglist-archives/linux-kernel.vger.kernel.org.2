Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 78D54309D6F
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Jan 2021 16:24:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232733AbhAaPU5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 31 Jan 2021 10:20:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232745AbhAaPUg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 Jan 2021 10:20:36 -0500
Received: from mail-qk1-x749.google.com (mail-qk1-x749.google.com [IPv6:2607:f8b0:4864:20::749])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C3F0C06178B
        for <linux-kernel@vger.kernel.org>; Sun, 31 Jan 2021 07:19:07 -0800 (PST)
Received: by mail-qk1-x749.google.com with SMTP id q7so7474565qkn.7
        for <linux-kernel@vger.kernel.org>; Sun, 31 Jan 2021 07:19:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=FRzaEhvDPo4h4QFnnXdsfoodxN30fydIjOqX0xUgHaA=;
        b=tUGY1emCCr3kTH3BPSrJyXjd0HfNm6m/oZWbXkNxMlSgLYhkmo5Gd0ss84pV2g0Cc+
         bO0sWEXymTVZZ0UC4AYb3BLvWUjpuxGFnuaqq0XpqpxSF1S40UMb+sB9RP9PcU8+G3hT
         BZ3bfhkqscQaHgvvs8h2eDB2jfLE6YgoDiHoPL/v+Sh0tWFMziINtCqUWUWzClGMs2w6
         +9IhcfmeLuKo1/L63JRv+rQHW6y+/fAPEUdl+N71Ehp4OiSR9hf5IhDtalwYnIK/GTiV
         OQa3diqA2Np8ZOp5zQGrGhzH5os9qdIGek9WglCiB2W8WQOh9GlzXTgH+olyDTFZ3PVI
         XgXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=FRzaEhvDPo4h4QFnnXdsfoodxN30fydIjOqX0xUgHaA=;
        b=LlNznlsZrSqBNEdx5SxDtrRrGbMXniRM5QWGHUQUto+wHisiCbxYOQaC6mlW4Ztb4h
         L4s7KNMWyB6JQe3KnS2jP3oGUwu2HthEzi3R/3w/byC1ipiAIc9fIOVfuoN6llgLZ3IM
         KDXQryjYteA180ZiTDbeE+QXM3fWXmBOA8g/O3VGfJf04bhfmPe5rk9vKtXrfnaUspUP
         J/k/iAFZ/qCk8pNloKCIwD33ZZA/44Asphv48rqbmmzmyW0SSDCZ5ut+Klct5tGWWRh+
         9CvH7yhvUDUhgLIlvk4rlRvXNtWjRWZ5EdWDpHTbF746Y0p2wsi6bP7L33bEYLHsv9FA
         5Gbw==
X-Gm-Message-State: AOAM531xW1pO8g/WFhDfObsdd0piTtCyRQ4NmwRoutPKzf/+QWI0D8DG
        jvFIRFmC3DRCITkx2MmuuL5gcQur3qNL
X-Google-Smtp-Source: ABdhPJyB3wtOX9xa281yjX0idXO53Tyh6XK5JoI5qT6Zab+ZrxbjcpWzhxQjvGoXzDrg5s3l92IejlfUQFhd
Sender: "kyletso via sendgmr" <kyletso@kyletso.ntc.corp.google.com>
X-Received: from kyletso.ntc.corp.google.com ([2401:fa00:fc:202:5d70:9e45:7deb:72a7])
 (user=kyletso job=sendgmr) by 2002:a0c:eb4c:: with SMTP id
 c12mr11582424qvq.62.1612106346714; Sun, 31 Jan 2021 07:19:06 -0800 (PST)
Date:   Sun, 31 Jan 2021 23:18:32 +0800
In-Reply-To: <20210131151832.215931-1-kyletso@google.com>
Message-Id: <20210131151832.215931-4-kyletso@google.com>
Mime-Version: 1.0
References: <20210131151832.215931-1-kyletso@google.com>
X-Mailer: git-send-email 2.30.0.365.g02bc693789-goog
Subject: [PATCH v2 3/3] usb: typec: tcpm: Get Sink VDO from fwnode
From:   Kyle Tso <kyletso@google.com>
To:     linux@roeck-us.net, heikki.krogerus@linux.intel.com,
        gregkh@linuxfoundation.org, hdegoede@redhat.com, robh+dt@kernel.org
Cc:     badhri@google.com, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Kyle Tso <kyletso@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit a079973f462a ("usb: typec: tcpm: Remove tcpc_config
configuration mechanism") removed the tcpc_config which includes the
Sink VDO and it is not yet added back with fwnode. Add it now.

Signed-off-by: Kyle Tso <kyletso@google.com>
---
Changes since v1:
- updated the commit message

 drivers/usb/typec/tcpm/tcpm.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/usb/typec/tcpm/tcpm.c b/drivers/usb/typec/tcpm/tcpm.c
index 403a483645dd..84c8a52f8af1 100644
--- a/drivers/usb/typec/tcpm/tcpm.c
+++ b/drivers/usb/typec/tcpm/tcpm.c
@@ -5677,6 +5677,18 @@ static int tcpm_fw_get_caps(struct tcpm_port *port,
 			port->new_source_frs_current = frs_current;
 	}
 
+	ret = fwnode_property_read_u32_array(fwnode, "sink-vdos", NULL, 0);
+	if (ret <= 0 && ret != -EINVAL) {
+		return -EINVAL;
+	} else if (ret > 0) {
+		port->nr_snk_vdo = min(ret, VDO_MAX_OBJECTS);
+		ret = fwnode_property_read_u32_array(fwnode, "sink-vdos",
+						     port->snk_vdo,
+						     port->nr_snk_vdo);
+		if (ret < 0)
+			return -EINVAL;
+	}
+
 	return 0;
 }
 
-- 
2.30.0.365.g02bc693789-goog

