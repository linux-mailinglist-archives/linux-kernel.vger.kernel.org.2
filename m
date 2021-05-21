Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B415438C767
	for <lists+linux-kernel@lfdr.de>; Fri, 21 May 2021 15:02:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232891AbhEUNDd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 May 2021 09:03:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232965AbhEUNDW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 May 2021 09:03:22 -0400
Received: from mail-qk1-x74a.google.com (mail-qk1-x74a.google.com [IPv6:2607:f8b0:4864:20::74a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D856C0613ED
        for <linux-kernel@vger.kernel.org>; Fri, 21 May 2021 06:01:58 -0700 (PDT)
Received: by mail-qk1-x74a.google.com with SMTP id r25-20020a05620a03d9b02903a58bfe037cso10483580qkm.15
        for <linux-kernel@vger.kernel.org>; Fri, 21 May 2021 06:01:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=hjK4qHjpBKdfkmlPVsP8X40hmtzrrpX8nHB5WsA0A04=;
        b=XKQA7O5anoKZTBb5fhFPVJNHly1HSjklTYpjQrzLk2nElaNookpsYbWxC3wF+0fkEZ
         S6yOr8tNtpwVK4cwEkyw/nt3auSDfi35oF9whSuCeeyKvhSJRsmBK6bvug+MGmQRRfD3
         j9Rk75MwFM6p0CuGcaHBxs7Lm3b8CFZDK1xS15P07bRB/2nGPznqWZBOqbdvoNBINr+R
         hJjHQi5BIxvutEwpr1NIJZeYX5wSEf7y4R5ACZTXHRYMXt+p0JakMdvM7JQDpRNaF4VM
         /h3DBtN8D23VaP0CrYyRVSUj/kV8yv0py5FrgTYeUk0ncWPuK9C6V6X/y6ypZH71U7RM
         2rog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=hjK4qHjpBKdfkmlPVsP8X40hmtzrrpX8nHB5WsA0A04=;
        b=k0/MRpF0yRnrjqNJo32wzq1ffwA0HSRJKoaC6VA9NLIE2T7FxJE/kXdl0SQwsTestj
         KwX2sZbgQBzcsvkMm406F6Zsuz1f4J/reKAuLX6MIyJkkrGMy9FoyfJAvrhEzQn1h918
         j3aG3cpCnbjV4FILw5qHi0alN1/LAQNX4+UIDspFglsLL0CIsBWGtUY9Pr3+gTFU0GNv
         f9UChHGG59WlpL/boz1Qrig2oxGHj+bqPdEH9mfxo+JGrYlLEd4Tg0Fo9v1Kmes8jWES
         atqCfjCuv1aRtr68ds18XhGrA/p95GEtyUo5buh8I5ZehPhjqjvcB0CURhCTOUM3MlQR
         yiAA==
X-Gm-Message-State: AOAM533i+ELp8MqpYbMWg5fpiKeyIj9VgF0EwmEhZlIUhMmiGCJsxEMx
        EKETV2c0BL417Sc+5GbkGeg75onyLAJY
X-Google-Smtp-Source: ABdhPJyTiKqGw1Th8nl1MJyY14wZpSQyYGtOGYphjIfhkiIKDQjCZGKKlqiAdOL67/52seMuerF2U2AJLNkZ
X-Received: from kyletso.ntc.corp.google.com ([2401:fa00:fc:202:905b:c174:8f59:4851])
 (user=kyletso job=sendgmr) by 2002:a05:6214:dc8:: with SMTP id
 8mr8616260qvt.58.1621602117277; Fri, 21 May 2021 06:01:57 -0700 (PDT)
Date:   Fri, 21 May 2021 21:01:21 +0800
In-Reply-To: <20210521130121.1470334-1-kyletso@google.com>
Message-Id: <20210521130121.1470334-3-kyletso@google.com>
Mime-Version: 1.0
References: <20210521130121.1470334-1-kyletso@google.com>
X-Mailer: git-send-email 2.31.1.818.g46aad6cb9e-goog
Subject: [PATCH 2/2] usb: typec: tcpm: Respond Not_Supported if no snk_vdo
From:   Kyle Tso <kyletso@google.com>
To:     linux@roeck-us.net, heikki.krogerus@linux.intel.com,
        gregkh@linuxfoundation.org
Cc:     badhri@google.com, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, Kyle Tso <kyletso@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If snk_vdo is not populated from fwnode, it implies the port does not
support responding to SVDM commands. Not_Supported Message shall be sent
if the contract is in PD3. And for PD2, the port shall ignore the
commands.

Fixes: 193a68011fdc ("staging: typec: tcpm: Respond to Discover Identity commands")
Signed-off-by: Kyle Tso <kyletso@google.com>
---
 drivers/usb/typec/tcpm/tcpm.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/typec/tcpm/tcpm.c b/drivers/usb/typec/tcpm/tcpm.c
index deb8a9d01f73..d32caa875d9a 100644
--- a/drivers/usb/typec/tcpm/tcpm.c
+++ b/drivers/usb/typec/tcpm/tcpm.c
@@ -2430,7 +2430,10 @@ static void tcpm_pd_data_request(struct tcpm_port *port,
 					   NONE_AMS);
 		break;
 	case PD_DATA_VENDOR_DEF:
-		tcpm_handle_vdm_request(port, msg->payload, cnt);
+		if (tcpm_vdm_ams(port) || port->nr_snk_vdo)
+			tcpm_handle_vdm_request(port, msg->payload, cnt);
+		else if (port->negotiated_rev > PD_REV20)
+			tcpm_pd_handle_msg(port, PD_MSG_CTRL_NOT_SUPP, NONE_AMS);
 		break;
 	case PD_DATA_BIST:
 		port->bist_request = le32_to_cpu(msg->payload[0]);
-- 
2.31.1.818.g46aad6cb9e-goog

