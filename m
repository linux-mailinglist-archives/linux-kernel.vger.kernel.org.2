Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 105C6410FEE
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Sep 2021 09:18:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233294AbhITHTf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Sep 2021 03:19:35 -0400
Received: from smtp-relay-internal-1.canonical.com ([185.125.188.123]:49448
        "EHLO smtp-relay-internal-1.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234782AbhITHTe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Sep 2021 03:19:34 -0400
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com [209.85.128.69])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id E91023FE01
        for <linux-kernel@vger.kernel.org>; Mon, 20 Sep 2021 07:18:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1632122286;
        bh=g/5RG3r3yZseQXLqjOW/OPcxsvmzNDs0bMtIh+wjazo=;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version;
        b=Rk5yJtnYQOjh8Bt7XBs/pZczD7mKoK+3dihEQTAMaDAQMbAuwV61WtNZICKdZWyo0
         OfaCNYd9TSf7pDy4jfQVA8uofZ4oEtGK8vBr/ZjmHJbg5lUYMpyToDvDap/w/bC0Wl
         aDwDqqVRURupVmDPslOU0VYsEa17B/K1ogoUYV+slWO4LuMeJFo/NoVkfhgfQ7iF1p
         Cu9MWF8E+zngFUETaDa+PIHKYn6wY019TAO1HN8BdYqVZ1rayuK+WjDdJqZCoxYYvM
         2ieOtccGOnQ4i0Vvq9DNDaw43hOiGgWEARhZM4tVRlpduktsnuSaPCKIJRIJLcZQrW
         N8oOCqNLTe1JA==
Received: by mail-wm1-f69.google.com with SMTP id l27-20020a05600c1d1b00b00308ef9d8a98so4738527wms.9
        for <linux-kernel@vger.kernel.org>; Mon, 20 Sep 2021 00:18:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=g/5RG3r3yZseQXLqjOW/OPcxsvmzNDs0bMtIh+wjazo=;
        b=GoXcgifljAHaON4E4Z01rtARAI0eoo/NrEk4aDq6GWU7ruyjfVrEMvS42rcAgZZ/aC
         +DdKXrivtBW65RM1fIq7Z9B5PNKFWxgMDi4A/3JhhCFztnjyvfP5oSqwG+OtzosJdRux
         yzm6y10vxCwWeYc5PTdEI0yOT57lQPkiMnjeEk4Gksr0wATLaMtxqqw97srdujK5oKOe
         qydZhQ/ln7txipjGEYAvCDucgF5v6DG15gINNuaUiFFzYlLJTac4wkvbJXpJvGQCJ36i
         tj39SYEFXzZHCCpNICsKRxK8It7GiG0L+1m2PaWf2QktGtLQATJYm05YbSh+o77yvPhX
         jaHA==
X-Gm-Message-State: AOAM531HZBSaKn1w5KRiqvT8OHjLIFryJO2ET2kxFGSitLvz7gV96qrg
        PDPCDSSHdBMu8piOEf76dmCLH2NQAjBNQGaDHAT+HNl13K3+GTDnglqZwy91P8psn4K0SWDn4cR
        mwke++L+0Wiic67y85JwGJs6wDN9KQ7lMKAK/2SApPA==
X-Received: by 2002:adf:b7c5:: with SMTP id t5mr26612613wre.322.1632122286577;
        Mon, 20 Sep 2021 00:18:06 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz09HTrwbItt4V4htloX64whzplHYzcpSmGaXTvrQepaoBp1J3Tpven9yjUCHjyNrL5/xX1aw==
X-Received: by 2002:adf:b7c5:: with SMTP id t5mr26612589wre.322.1632122286380;
        Mon, 20 Sep 2021 00:18:06 -0700 (PDT)
Received: from kozik-lap.lan (lk.84.20.244.219.dc.cable.static.lj-kabel.net. [84.20.244.219])
        by smtp.gmail.com with ESMTPSA id a202sm6990798wmd.15.2021.09.20.00.18.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Sep 2021 00:18:05 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org
Cc:     Marek Szyprowski <m.szyprowski@samsung.com>,
        Sylwester Nawrocki <snawrocki@kernel.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: [PATCH v2 2/3] devfreq: exynos-ppmu: simplify parsing event-type from DT
Date:   Mon, 20 Sep 2021 09:17:52 +0200
Message-Id: <20210920071753.38560-2-krzysztof.kozlowski@canonical.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210920071540.38337-1-krzysztof.kozlowski@canonical.com>
References: <20210920071540.38337-1-krzysztof.kozlowski@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When parsing devicetree, the function of_get_devfreq_events(), for each
device child node, iterates over array of possible events "ppmu_events"
till it finds one matching by node name.  When match is found the
ppmu_events[i] points to element having both the name of the event and
the counters ID.

Each PPMU device child node might have an "event-name" property with the
name of the event, however due to the design of devfreq it must be the
same as the device node name.  If it is not the same, the devfreq client
won't be able to use it via devfreq_event_get_edev_by_phandle().

Since PPMU device child node name must be equal to the "event-name"
property (event-name == ppmu_events[i].name), there is no need to find
the counters ID by the "event-name".  Instead use ppmu_events[i].id
which must be equal to it.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
---
 drivers/devfreq/event/exynos-ppmu.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/devfreq/event/exynos-ppmu.c b/drivers/devfreq/event/exynos-ppmu.c
index 541bd13ab61d..9b849d781116 100644
--- a/drivers/devfreq/event/exynos-ppmu.c
+++ b/drivers/devfreq/event/exynos-ppmu.c
@@ -566,13 +566,10 @@ static int of_get_devfreq_events(struct device_node *np,
 			 * use default if not.
 			 */
 			if (info->ppmu_type == EXYNOS_TYPE_PPMU_V2) {
-				int id;
 				/* Not all registers take the same value for
 				 * read+write data count.
 				 */
-				id = __exynos_ppmu_find_ppmu_id(desc[j].name);
-
-				switch (id) {
+				switch (ppmu_events[i].id) {
 				case PPMU_PMNCNT0:
 				case PPMU_PMNCNT1:
 				case PPMU_PMNCNT2:
-- 
2.30.2

