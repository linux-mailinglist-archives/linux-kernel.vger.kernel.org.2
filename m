Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9793D30BB1F
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Feb 2021 10:39:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229813AbhBBJgy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Feb 2021 04:36:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232866AbhBBJfb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Feb 2021 04:35:31 -0500
Received: from mail-qt1-x849.google.com (mail-qt1-x849.google.com [IPv6:2607:f8b0:4864:20::849])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FA9EC061351
        for <linux-kernel@vger.kernel.org>; Tue,  2 Feb 2021 01:34:02 -0800 (PST)
Received: by mail-qt1-x849.google.com with SMTP id j14so12661288qtv.3
        for <linux-kernel@vger.kernel.org>; Tue, 02 Feb 2021 01:34:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=lQfe7kNroEGriP73lSMZoz+yhddXqDQiCmEoxJjsp9o=;
        b=LdKBe91q9llNWkTdx+Ln0iPTgIvE+rQXhYwDW/FNTahLG6PVgQLHp47hTm/ljOm4lp
         ogOuBLixxgSzizbpjlMRoOJnhyDY2HG2Q31bd9CQoM70iN/o8kQHklj/A+O/6VBUgFlO
         yxtTgO2ZPR8CORGxk/NemxSvv4SEymMKuEe09b1R6mdGAKwIF3nUZR9Vuu6lOMGjxdOt
         KBAHgzvnWX/Yvh8kqHbO9oYtcrzXzfCZcObWxSDtUS4j0FaGDCIDOt10LcPIl852WdAG
         B3iI3c0SQ0pqjvANqJ+w0PBvztylujJM6FUwT4APOuu94xdey14aQJQnl6jgP12uaTLB
         l80Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=lQfe7kNroEGriP73lSMZoz+yhddXqDQiCmEoxJjsp9o=;
        b=Esqt+dUbM5G972L5jztxS9d/gIJXREicsgtQM96CEv85E+ov/SspqW6AKnPjco1W71
         SAIwp1nn7vGprQUz6kQpIHAkVfIg2rjUTK+6cQXmpO/xeIE2WjN4ihlw7uXVrrxNBotF
         2UYc9FDqnjNmDhDzgTwfsMbPHeU4lTyFslAblV/XCYCI+qXNNLUwOZngJv2kHIPcnYBm
         E1RaSL16ZL13SnoscIXXjbwHeZQ5uTvKpGFL7dljvjEmkCki/yptrRUEitMkVYKEC1b4
         7dUSstmZrI+fqd4VMN+VwtTWhDoG8vRAfI+ZWJ6OWPuY7hGZcgX6ttJzRU1kSVOgHWJd
         qh/g==
X-Gm-Message-State: AOAM531WlvQ9GhSNZ1fVbCUCPvq0a6vxo0bgIS63g3AapxNOk7IOGCkG
        ZxsqTkxqeIneV7eBgOmgGlDxr+IrE4dn
X-Google-Smtp-Source: ABdhPJy+yqY5ykXENon7xf4+T3J0ATTYJBaiEqVnYYbYNM45kCBxyEasclBsxoTFuPzG3yHh1pBqwYyWD5rC
Sender: "kyletso via sendgmr" <kyletso@kyletso.ntc.corp.google.com>
X-Received: from kyletso.ntc.corp.google.com ([2401:fa00:fc:202:dd94:c753:a81d:c855])
 (user=kyletso job=sendgmr) by 2002:ad4:5887:: with SMTP id
 dz7mr15741345qvb.44.1612258441500; Tue, 02 Feb 2021 01:34:01 -0800 (PST)
Date:   Tue,  2 Feb 2021 17:33:37 +0800
In-Reply-To: <20210202093342.738691-1-kyletso@google.com>
Message-Id: <20210202093342.738691-4-kyletso@google.com>
Mime-Version: 1.0
References: <20210202093342.738691-1-kyletso@google.com>
X-Mailer: git-send-email 2.30.0.365.g02bc693789-goog
Subject: [PATCH v4 3/8] usb: pd: Make SVDM Version configurable in VDM header
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

PD Rev 3.0 introduces SVDM Version 2.0. This patch makes the field
configuable in the header in order to be able to be compatible with
older SVDM version.

Signed-off-by: Kyle Tso <kyletso@google.com>
---
 include/linux/usb/pd_vdo.h | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/include/linux/usb/pd_vdo.h b/include/linux/usb/pd_vdo.h
index e9b6822c54c2..69ed6929ce6e 100644
--- a/include/linux/usb/pd_vdo.h
+++ b/include/linux/usb/pd_vdo.h
@@ -21,22 +21,24 @@
  * ----------
  * <31:16>  :: SVID
  * <15>     :: VDM type ( 1b == structured, 0b == unstructured )
- * <14:13>  :: Structured VDM version (can only be 00 == 1.0 currently)
+ * <14:13>  :: Structured VDM version
  * <12:11>  :: reserved
  * <10:8>   :: object position (1-7 valid ... used for enter/exit mode only)
  * <7:6>    :: command type (SVDM only?)
  * <5>      :: reserved (SVDM), command type (UVDM)
  * <4:0>    :: command
  */
-#define VDO(vid, type, custom)				\
+#define VDO(vid, type, ver, custom)			\
 	(((vid) << 16) |				\
 	 ((type) << 15) |				\
+	 ((ver) << 13) |				\
 	 ((custom) & 0x7FFF))
 
 #define VDO_SVDM_TYPE		(1 << 15)
 #define VDO_SVDM_VERS(x)	((x) << 13)
 #define VDO_OPOS(x)		((x) << 8)
 #define VDO_CMDT(x)		((x) << 6)
+#define VDO_SVDM_VERS_MASK	VDO_SVDM_VERS(0x3)
 #define VDO_OPOS_MASK		VDO_OPOS(0x7)
 #define VDO_CMDT_MASK		VDO_CMDT(0x3)
 
@@ -74,6 +76,7 @@
 
 #define PD_VDO_VID(vdo)		((vdo) >> 16)
 #define PD_VDO_SVDM(vdo)	(((vdo) >> 15) & 1)
+#define PD_VDO_SVDM_VER(vdo)	(((vdo) >> 13) & 0x3)
 #define PD_VDO_OPOS(vdo)	(((vdo) >> 8) & 0x7)
 #define PD_VDO_CMD(vdo)		((vdo) & 0x1f)
 #define PD_VDO_CMDT(vdo)	(((vdo) >> 6) & 0x3)
-- 
2.30.0.365.g02bc693789-goog

