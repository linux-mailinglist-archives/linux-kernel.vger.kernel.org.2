Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 18DE23BC37C
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jul 2021 22:53:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230031AbhGEUzb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jul 2021 16:55:31 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:46366 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229898AbhGEUzb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jul 2021 16:55:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1625518372;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=zyVy7U1xGMAhsJSSyPiE5KYJJ4IF5cO4BjmDZQjw5kI=;
        b=SpeZYV5NNGtQ07onXTato4e6t8qxuIHSPXfMs3KnsOHMEeKqz+oWRR8QU/lNWEV7BPgbLt
        AKl9LjhhY2QDJZS/jLOQFQpV1MNNASTk0Idwtm1EuwW58pT3/6z2z9JULMkUmg1goPkiZ8
        hPZF+ee0HswRoDpbXJLlk0oHLYA2aK0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-57-Gfa35KxRO-ehY-mi3omLdw-1; Mon, 05 Jul 2021 16:52:51 -0400
X-MC-Unique: Gfa35KxRO-ehY-mi3omLdw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7F69B5074C;
        Mon,  5 Jul 2021 20:52:50 +0000 (UTC)
Received: from x1.localdomain (ovpn-112-2.ams2.redhat.com [10.36.112.2])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 44D6B5D6CF;
        Mon,  5 Jul 2021 20:52:49 +0000 (UTC)
From:   Hans de Goede <hdegoede@redhat.com>
To:     Lee Jones <lee.jones@linaro.org>, Chen-Yu Tsai <wens@csie.org>
Cc:     Hans de Goede <hdegoede@redhat.com>, linux-kernel@vger.kernel.org
Subject: [PATCH] mfd: axp20x: Add supplied-from property to axp288_fuel_gauge cell
Date:   Mon,  5 Jul 2021 22:52:48 +0200
Message-Id: <20210705205248.25130-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The power-supply framework has the notion of one power-supply device
being supplied by another. A typical example of this is a charger
charging a battery.

A tablet getting plugged in to charge (or plugged out) only results in
events seen by the axp288_charger device / MFD cell. Which means that
a change udev-event only gets send for the charger power-supply class
device, not for the battery (the axp288_fuel_gauge device).

The axp288_fuel_gauge does have an external_power_change'd callback
which will generate a change udev-event when called. But before this
commit this never got called because the power-supply core only calls
this when a power-supply class device's supplier changes and the
supplier link from axp288_charger to axp288_fuel_gauge was missing.

Add a "supplied-from" property to axp288_fuel_gauge cell, pointing
to the "axp288_charger" power-supply class device, so that the
axp288_fuel_gauge's external_power_change'd callback gets called on
axp288_charger state changes.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/mfd/axp20x.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/mfd/axp20x.c b/drivers/mfd/axp20x.c
index db6a21465594..a400141be995 100644
--- a/drivers/mfd/axp20x.c
+++ b/drivers/mfd/axp20x.c
@@ -700,6 +700,18 @@ static const struct resource axp288_charger_resources[] = {
 	DEFINE_RES_IRQ(AXP288_IRQ_CBTO),
 };
 
+static const char * const axp288_fuel_gauge_suppliers[] = { "axp288_charger" };
+
+static const struct property_entry axp288_fuel_gauge_properties[] = {
+	PROPERTY_ENTRY_STRING_ARRAY("supplied-from", axp288_fuel_gauge_suppliers),
+	{ }
+};
+
+static const struct software_node axp288_fuel_gauge_sw_node = {
+	.name = "axp288_fuel_gauge",
+	.properties = axp288_fuel_gauge_properties,
+};
+
 static const struct mfd_cell axp288_cells[] = {
 	{
 		.name		= "axp288_adc",
@@ -717,6 +729,7 @@ static const struct mfd_cell axp288_cells[] = {
 		.name		= "axp288_fuel_gauge",
 		.num_resources	= ARRAY_SIZE(axp288_fuel_gauge_resources),
 		.resources	= axp288_fuel_gauge_resources,
+		.swnode		= &axp288_fuel_gauge_sw_node,
 	}, {
 		.name		= "axp221-pek",
 		.num_resources	= ARRAY_SIZE(axp288_power_button_resources),
-- 
2.31.1

