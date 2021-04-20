Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4E7C5365E3D
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Apr 2021 19:11:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233238AbhDTRLG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Apr 2021 13:11:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232769AbhDTRLC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Apr 2021 13:11:02 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D557C06174A
        for <linux-kernel@vger.kernel.org>; Tue, 20 Apr 2021 10:10:31 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id o16so6416593plg.5
        for <linux-kernel@vger.kernel.org>; Tue, 20 Apr 2021 10:10:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=DXsClQzPyy3ZZmtTQRhi81u0hIqu+HrYWRKXDHtKEAo=;
        b=OsYYelzxirfur10BaaAx/ihgv2EY9UtnNcx/QFBAX7gGKx7tc8iNVkrZFU4mLtEhFu
         ffWQxAU5ciGB3bU6oqngT3syljik/L3h3QxmplVXK1RbXFdUMifpFVMyZWstzQXDqPcN
         L16AG/OclfErCto8rG8Dz/RFnpNrJyYwStXOE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=DXsClQzPyy3ZZmtTQRhi81u0hIqu+HrYWRKXDHtKEAo=;
        b=Qwz+wx02iD2JSeaWHrDmv4jHiRXNpyUzopauGXDMpTSllFYrq7VjqX7Kmoi2SaDZOl
         mWLx4QQNW//mACzSUMGoEd20UYfLXezqZjz53PL2IN6bvv4PiylLZUhgT3xvVLvPoj5H
         k0cFT2KNBB/CxgazHNRU8Mx78fVCXK9se31BnT+QM1I0YZTKVRtJEviU5C238yBaNh1e
         9IbwgJrCZQbDZpM/sQSzPEsK39yKQlzLzZ/+5tEoRWmiPDKl3B7ga9oNwkU7zIS80aWE
         zdTUk6FtMTAhsNWMHWkYGc/0U1bSjeml+iuJu199hRRA0lfphq+7UkbiAQU2PvCakzbC
         mwTg==
X-Gm-Message-State: AOAM530SOVYzRmYXMoKQrLhU9i1oEHFYZDkdx6QgxEPiW3BKdo22y7Bo
        dGrV2vA550QNQsGbREafvri+AiXE3BBzTg==
X-Google-Smtp-Source: ABdhPJzrB8NVeFyHwyFNasgCJwHfdzKF7dbt9NyXEmtsqbXdqxmpeaMaMiSu1wSanjmbWQ6fKD1rFg==
X-Received: by 2002:a17:902:7043:b029:ec:939f:c9e5 with SMTP id h3-20020a1709027043b02900ec939fc9e5mr16922762plt.64.1618938630574;
        Tue, 20 Apr 2021 10:10:30 -0700 (PDT)
Received: from pmalani2.mtv.corp.google.com ([2620:15c:202:201:ee88:6ec6:b8ee:20b9])
        by smtp.gmail.com with ESMTPSA id g2sm2934216pju.18.2021.04.20.10.10.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Apr 2021 10:10:30 -0700 (PDT)
From:   Prashant Malani <pmalani@chromium.org>
To:     linux-kernel@vger.kernel.org
Cc:     Prashant Malani <pmalani@chromium.org>,
        "Nikunj A . Dadhania" <nikunj.dadhania@intel.com>,
        Deepti Deshatty <deepti.deshatty@intel.com>,
        Benson Leung <bleung@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Guenter Roeck <groeck@chromium.org>
Subject: [PATCH] platform/chrome: cros_ec_typec: Track port role
Date:   Tue, 20 Apr 2021 10:10:09 -0700
Message-Id: <20210420171008.3829549-1-pmalani@chromium.org>
X-Mailer: git-send-email 2.31.1.368.gbe11c130af-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Stash the currently reported port role in the port struct and add a
check for that too while determining whether to re-configure on-board
Type C switches (this deals with cases like role swaps where the mux
flags don't change, but the port role does).

Signed-off-by: Prashant Malani <pmalani@chromium.org>
Suggested-by: Nikunj A. Dadhania <nikunj.dadhania@intel.com>
Tested-by: Deepti Deshatty <deepti.deshatty@intel.com>
---
 drivers/platform/chrome/cros_ec_typec.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/platform/chrome/cros_ec_typec.c b/drivers/platform/chrome/cros_ec_typec.c
index d3df1717a5fd..1a06b8c80f80 100644
--- a/drivers/platform/chrome/cros_ec_typec.c
+++ b/drivers/platform/chrome/cros_ec_typec.c
@@ -58,6 +58,7 @@ struct cros_typec_port {
 	/* Variables keeping track of switch state. */
 	struct typec_mux_state state;
 	uint8_t mux_flags;
+	uint8_t role;
 
 	/* Port alt modes. */
 	struct typec_altmode p_altmode[CROS_EC_ALTMODE_MAX];
@@ -995,10 +996,12 @@ static int cros_typec_port_update(struct cros_typec_data *typec, int port_num)
 	}
 
 	/* No change needs to be made, let's exit early. */
-	if (typec->ports[port_num]->mux_flags == mux_resp.flags)
+	if (typec->ports[port_num]->mux_flags == mux_resp.flags &&
+	    typec->ports[port_num]->role == resp.role)
 		return 0;
 
 	typec->ports[port_num]->mux_flags = mux_resp.flags;
+	typec->ports[port_num]->role = resp.role;
 	ret = cros_typec_configure_mux(typec, port_num, mux_resp.flags, &resp);
 	if (ret)
 		dev_warn(typec->dev, "Configure muxes failed, err = %d\n", ret);
-- 
2.31.1.368.gbe11c130af-goog

