Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6DA3339DC8E
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Jun 2021 14:35:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231160AbhFGMgc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Jun 2021 08:36:32 -0400
Received: from mail-ej1-f48.google.com ([209.85.218.48]:41609 "EHLO
        mail-ej1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230517AbhFGMg3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jun 2021 08:36:29 -0400
Received: by mail-ej1-f48.google.com with SMTP id ho18so15401487ejc.8
        for <linux-kernel@vger.kernel.org>; Mon, 07 Jun 2021 05:34:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sartura-hr.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=2o3lod6/tQHJli1HMNUrlxY009C4XIUm342TOsfm420=;
        b=LRXwdOLxb4x7g7xhsp9PBEKGxP4DmnE5Qj0csPwhaXSmxv4oBBVzcPcnS8wT3iGaEO
         reBH6BO45k7qMLKWgzs/pLiCcDgdH2W2LZB0IG+ELCry1k0wy+vAjTn8fTg4uCP+mNy3
         ywSRgxhypVz0oPAgeX26xLw2pV88b4AvuDhFGeR1t/BVnKoXOuis8k6jB15BVpkNuTss
         KXZrhePsdfvI3i8eVbW08KumrrUiWHePNNTk2ct3uulB1QRtee8ttvNjE+DLYVUWEsS9
         Kku6lMCSXSTlt+L142TDnSU7uNkgPKvZmB3gbD+DzyW4Ovt7F+Q46jSIcDzIZV78rycn
         JSLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2o3lod6/tQHJli1HMNUrlxY009C4XIUm342TOsfm420=;
        b=HzYD8LXEU0rUgc6TyIVn0Bms9PyBRnRuIkkd2HU4qBHXiMavjdAcR9glbbvD5cISMA
         Bk03C8nMOhdlGZgJFABYJYCnegkN/kdJyZH5hAI2o9qADhCvV/vvz78l1qfk3/wwEg+j
         kGI2ahXwxUHHUkmWuz3fH1go/1mODxVA8b3JrC4j+3qtDq1gvwRd+NnPP1Vi6dx8cB6c
         GKUG5grNu+8+9nKsWTl91894VPzre3NLYQiARfqnqEPQqjcTwhWx9+11QpI/F+BmnIrh
         62weh8mYvG7mG7yEZsqNwDd6NLJQOmgTqGjCE5A9smCu2B2su5u0R2LUbfxHykwCmdGK
         t6Jw==
X-Gm-Message-State: AOAM530PJ4FvuHV8jsOE7uF0LQzEqMBVx5ojO3VM3xt44+nEUd/aLFwh
        X3t4rCoLjVb7NOLcXjnNbAPGzQ==
X-Google-Smtp-Source: ABdhPJz/Hr+gO9MAPM9PRNPEay7RzqTJpJntQ+xo57MOxVAOjknOseGXUJ6OHBDpV3H6B+Sllz8ylg==
X-Received: by 2002:a17:907:770a:: with SMTP id kw10mr17723655ejc.213.1623069217160;
        Mon, 07 Jun 2021 05:33:37 -0700 (PDT)
Received: from localhost.localdomain (dh207-96-76.xnet.hr. [88.207.96.76])
        by smtp.googlemail.com with ESMTPSA id f18sm6471000ejz.119.2021.06.07.05.33.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Jun 2021 05:33:36 -0700 (PDT)
From:   Robert Marko <robert.marko@sartura.hr>
To:     linus.walleij@linaro.org, bgolaszewski@baylibre.com,
        robh+dt@kernel.org, lee.jones@linaro.org, p.zabel@pengutronix.de,
        linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     luka.perkov@sartura.hr, jmp@epiphyte.org, pmenzel@molgen.mpg.de,
        buczek@molgen.mpg.de, Robert Marko <robert.marko@sartura.hr>
Subject: [PATCH v6 6/6] MAINTAINERS: Add Delta Networks TN48M CPLD drivers
Date:   Mon,  7 Jun 2021 14:33:17 +0200
Message-Id: <20210607123317.3242031-6-robert.marko@sartura.hr>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210607123317.3242031-1-robert.marko@sartura.hr>
References: <20210607123317.3242031-1-robert.marko@sartura.hr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add maintainers entry for the Delta Networks TN48M
CPLD MFD drivers.

Signed-off-by: Robert Marko <robert.marko@sartura.hr>
---
Changes in v3:
* Add reset driver documentation

Changes in v2:
* Drop no more existing files

 MAINTAINERS | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 9450e052f1b1..82d9c2943c34 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -5096,6 +5096,15 @@ W:	https://linuxtv.org
 T:	git git://linuxtv.org/media_tree.git
 F:	drivers/media/platform/sti/delta
 
+DELTA NETWORKS TN48M CPLD DRIVERS
+M:	Robert Marko <robert.marko@sartura.hr>
+S:	Maintained
+F:	Documentation/devicetree/bindings/gpio/delta,tn48m-gpio.yaml
+F:	Documentation/devicetree/bindings/mfd/delta,tn48m-cpld.yaml
+F:	Documentation/devicetree/bindings/reset/delta,tn48m-reset.yaml
+F:	drivers/gpio/gpio-tn48m.c
+F:	include/dt-bindings/reset/delta,tn48m-reset.h
+
 DENALI NAND DRIVER
 L:	linux-mtd@lists.infradead.org
 S:	Orphan
-- 
2.31.1

