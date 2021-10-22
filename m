Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 49D8B436FB0
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Oct 2021 04:01:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232149AbhJVCDI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Oct 2021 22:03:08 -0400
Received: from thorn.bewilderbeest.net ([71.19.156.171]:56659 "EHLO
        thorn.bewilderbeest.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231923AbhJVCDD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Oct 2021 22:03:03 -0400
Received: from hatter.bewilderbeest.net (71-212-29-146.tukw.qwest.net [71.212.29.146])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: zev)
        by thorn.bewilderbeest.net (Postfix) with ESMTPSA id 522BE98D;
        Thu, 21 Oct 2021 19:00:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bewilderbeest.net;
        s=thorn; t=1634868046;
        bh=a/XGFUg4+nH0ms1nAfRWPYozspJBU8EaTQ2O/BYzSYY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=DU7tY17FDr71jzgG2hHBqWK+HF30qVROqxkfhxnQd4PDWnwinchH8Eh1DnqGi11YN
         /VClEF+jolOai9moi6TK4ZrEIYJXVXlUP5HASzggFly1c8liUuj/4HOyA5ioxADpyJ
         cxLsXUTLz1Pyma9BF3JnMuTEhXLXcfmeksgLzRl4=
From:   Zev Weiss <zev@bewilderbeest.net>
To:     Frank Rowand <frowand.list@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     openbmc@lists.ozlabs.org, Jeremy Kerr <jk@codeconstruct.com.au>,
        Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Zev Weiss <zev@bewilderbeest.net>
Subject: [PATCH 3/5] of: property: add support for fwnode_device_is_reserved()
Date:   Thu, 21 Oct 2021 19:00:30 -0700
Message-Id: <20211022020032.26980-4-zev@bewilderbeest.net>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211022020032.26980-1-zev@bewilderbeest.net>
References: <20211022020032.26980-1-zev@bewilderbeest.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is just a simple pass-through to of_device_is_reserved().

Signed-off-by: Zev Weiss <zev@bewilderbeest.net>
---
 drivers/of/property.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/of/property.c b/drivers/of/property.c
index a3483484a5a2..67a8cb7ac462 100644
--- a/drivers/of/property.c
+++ b/drivers/of/property.c
@@ -872,6 +872,11 @@ static bool of_fwnode_device_is_available(const struct fwnode_handle *fwnode)
 	return of_device_is_available(to_of_node(fwnode));
 }
 
+static bool of_fwnode_device_is_reserved(const struct fwnode_handle *fwnode)
+{
+	return of_device_is_reserved(to_of_node(fwnode));
+}
+
 static bool of_fwnode_property_present(const struct fwnode_handle *fwnode,
 				       const char *propname)
 {
@@ -1458,6 +1463,7 @@ const struct fwnode_operations of_fwnode_ops = {
 	.get = of_fwnode_get,
 	.put = of_fwnode_put,
 	.device_is_available = of_fwnode_device_is_available,
+	.device_is_reserved = of_fwnode_device_is_reserved,
 	.device_get_match_data = of_fwnode_device_get_match_data,
 	.property_present = of_fwnode_property_present,
 	.property_read_int_array = of_fwnode_property_read_int_array,
-- 
2.33.1

