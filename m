Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 79EA230859D
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Jan 2021 07:24:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231888AbhA2GQl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Jan 2021 01:16:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231977AbhA2GPk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jan 2021 01:15:40 -0500
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6813DC06178B
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jan 2021 22:14:22 -0800 (PST)
Received: by mail-pj1-x1032.google.com with SMTP id a20so5241221pjs.1
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jan 2021 22:14:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=mV7nf+buXJQ9+XxF7K4sp0VELy5hFFaKIItPtbNn5WA=;
        b=VW9HbEAybqcA1AcQzeng934Z38FnPt59yz4mXRIKlMpe5SQDtsrOKXZ7wXiwjXQ5in
         dMoVzuudHfCWL+oeqJIGNf8rSqwowKHCbbg+nheiIx+FYSXtUeTBSenrjKQvb6KU0W7z
         zTEdksDK+dbWC3uLKhX9KyO6xRyoP0nQOqY+0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=mV7nf+buXJQ9+XxF7K4sp0VELy5hFFaKIItPtbNn5WA=;
        b=Fc+RA4pOvdL94Ad+XriURuM61QjcVeA4e3yk+eSSPJcwHSiUFVNYtYadlTU75EqhZb
         ex27gF+7pFuYi1/jGsjPeKg0Rk/WHpyqlSFqxuqXniLonAtj/ymd17L9x9K1njRKFiFQ
         Y//SXLsr+h0tx6WySrQXPMvIAdPhGd65NgoVtT5tEGGOVdZaXc7bGNBk4jYDcgCxOq9P
         8yE9OrCaRP8w1Dtpp0+B5c5Sg5jEfh3G/K1qbdLT//vN9X3syfogpc7K72tTnJZ9W10i
         mV/1t7VgS5IzA9zMTa+WbEA4M2PdVOgSmd0xzSn/WMoUlYZO7JoaTaqZPfLORmWmHEHn
         rTlg==
X-Gm-Message-State: AOAM530MzCyK48nNrhzrOoJhF1Zn+XLCrHfNrPBpqTs2GK2Vp7G9+Cij
        MB5rdlamgbn+9MWoyMKKt1Zy1A==
X-Google-Smtp-Source: ABdhPJwtT0ZRfXmWvhktB4knPBnVOUNlL3eryEdErZCiOeAPwExtYPJGu5aBc7eSz+b/QAuGP0mB5A==
X-Received: by 2002:a17:902:fe08:b029:de:36a1:9f12 with SMTP id g8-20020a170902fe08b02900de36a19f12mr2816050plj.30.1611900862047;
        Thu, 28 Jan 2021 22:14:22 -0800 (PST)
Received: from bleung.mtv.corp.google.com ([2620:15c:202:201:f693:9fff:fef4:fc72])
        by smtp.gmail.com with ESMTPSA id 17sm7551013pfv.13.2021.01.28.22.14.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Jan 2021 22:14:21 -0800 (PST)
From:   Benson Leung <bleung@chromium.org>
To:     heikki.krogerus@linux.intel.com, enric.balletbo@collabora.com,
        pmalani@chromium.org, gregkh@linuxfoundation.org,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     groeck@chromium.org, bleung@google.com, bleung@chromium.org
Subject: [PATCH 4/6] platform/chrome: cros_ec_typec: Report SOP' PD revision from status
Date:   Thu, 28 Jan 2021 22:14:04 -0800
Message-Id: <20210129061406.2680146-5-bleung@chromium.org>
X-Mailer: git-send-email 2.30.0.365.g02bc693789-goog
In-Reply-To: <20210129061406.2680146-1-bleung@chromium.org>
References: <20210129061406.2680146-1-bleung@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

cros_typec_handle_sop_prime_disc now takes the PD revision provided
by the EC_CMD_TYPEC_STATUS command response for the SOP'.

Attach the properly formatted pd_revision to the cable desc before
registering the cable.

Signed-off-by: Benson Leung <bleung@chromium.org>
---
 drivers/platform/chrome/cros_ec_typec.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/platform/chrome/cros_ec_typec.c b/drivers/platform/chrome/cros_ec_typec.c
index e724a5eaef1c..30600e9454e1 100644
--- a/drivers/platform/chrome/cros_ec_typec.c
+++ b/drivers/platform/chrome/cros_ec_typec.c
@@ -748,7 +748,7 @@ static void cros_typec_parse_pd_identity(struct usb_pd_identity *id,
 		id->vdo[i - 3] = disc->discovery_vdo[i];
 }
 
-static int cros_typec_handle_sop_prime_disc(struct cros_typec_data *typec, int port_num)
+static int cros_typec_handle_sop_prime_disc(struct cros_typec_data *typec, int port_num, u16 pd_revision)
 {
 	struct cros_typec_port *port = typec->ports[port_num];
 	struct ec_response_typec_discovery *disc = port->disc_data;
@@ -794,6 +794,7 @@ static int cros_typec_handle_sop_prime_disc(struct cros_typec_data *typec, int p
 	}
 
 	c_desc.identity = &port->c_identity;
+	c_desc.pd_revision = pd_revision;
 
 	port->cable = typec_register_cable(port->port, &c_desc);
 	if (IS_ERR(port->cable)) {
@@ -893,7 +894,11 @@ static void cros_typec_handle_status(struct cros_typec_data *typec, int port_num
 
 	if (resp.events & PD_STATUS_EVENT_SOP_PRIME_DISC_DONE &&
 	    !typec->ports[port_num]->sop_prime_disc_done) {
-		ret = cros_typec_handle_sop_prime_disc(typec, port_num);
+		u16 sop_prime_revision;
+
+		/* Convert BCD to the format preferred by the TypeC framework */
+		sop_prime_revision = (le16_to_cpu(resp.sop_prime_revision) & 0xff00) >> 4;
+		ret = cros_typec_handle_sop_prime_disc(typec, port_num, sop_prime_revision);
 		if (ret < 0)
 			dev_err(typec->dev, "Couldn't parse SOP' Disc data, port: %d\n", port_num);
 		else
-- 
2.30.0.365.g02bc693789-goog

