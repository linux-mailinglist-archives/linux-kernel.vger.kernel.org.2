Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 165A245E3AC
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Nov 2021 01:28:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238462AbhKZAb2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Nov 2021 19:31:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346344AbhKZA31 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Nov 2021 19:29:27 -0500
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34B61C06173E
        for <linux-kernel@vger.kernel.org>; Thu, 25 Nov 2021 16:26:15 -0800 (PST)
Received: by mail-lf1-x129.google.com with SMTP id u3so19961278lfl.2
        for <linux-kernel@vger.kernel.org>; Thu, 25 Nov 2021 16:26:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ULEeSU3LKj9dHbNjZ+wW9dIVHqv9jNyz7Kz7dNf303A=;
        b=Bxstt1Brj1xbiFXm44anso8UKf/3bGvcXySWRwsd9O31iFprDihzA2t7Oj7lb6rTma
         G8ezVsVdZ1K9dJnaC+gRNTAvUexHfNt/vfRUI9ocfMwCgqxQW4rHtosswL3Usv7zSEje
         5n40Cp0AghDKBIT+lgQHl/qIONlqi7GLNbBJWQsB+4a5WjmDk9cKGrnOu39a7R9jLjgb
         i8x3byUm5fnt+Q5wdyfyG3uBz++6mw55NJyjCER/tfnMZh6aFyseNsCveppJ5NA2hxly
         GzzGMiHVlftrY0vUx74OXcWho7ZOt2SYhPF7ge9y5Hs4RR2taHroIsoK/SBykrrzjiAh
         0PRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ULEeSU3LKj9dHbNjZ+wW9dIVHqv9jNyz7Kz7dNf303A=;
        b=k7sTFy0VQi2qzZJAfbdPpwuQudt2Cvrd4Ve4PLYoCwabP0vj59esGzMW8ChgUnTANL
         ccdbJSwqwNln5NqANqB376OwXT+wyzAKNR9Qml9Tv9/ImjdcZXizumEZF2Z6lp/fMo6+
         //p0ZUk6lKR3aQoLsxMlAgJhRTuZv7ABSeUlvpKpPwPIwxuU0l2JR+TfkMAg0WVLSdFW
         2r5jAapxjb5lmzqOJcHUsD6n+mdIvL5HvMO3YzkHhcPyQozQ1o/g/bcsP08tBRkDsiwL
         Ebkrld99/BzRgFrv9/IV1zWi778zpRyI7+s/fUter6bMQuZ50XODj30KG0Q59uzFLI8W
         2kPg==
X-Gm-Message-State: AOAM532NosBstlY6aolSYzXMRT72OCSLGu+KUtR+/lxsJXse10B1n3t8
        feShap10Yvsxxo9KQd3P8HS1zQ==
X-Google-Smtp-Source: ABdhPJy/5TtyvNOPAR5phFf4AC3qB6IyLlAGCnrkbtWmL85ISfkfv3NCVYz/Cyvixuzx44V2qSlLSw==
X-Received: by 2002:a05:6512:374b:: with SMTP id a11mr27016850lfs.48.1637886373517;
        Thu, 25 Nov 2021 16:26:13 -0800 (PST)
Received: from eriador.lan ([37.153.55.125])
        by smtp.gmail.com with ESMTPSA id 3sm375880lfr.77.2021.11.25.16.26.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Nov 2021 16:26:12 -0800 (PST)
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To:     Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Saravana Kannan <saravanak@google.com>
Subject: [PATCH] of: property: stop parsing remote-endpoint graph properties
Date:   Fri, 26 Nov 2021 03:26:12 +0300
Message-Id: <20211126002612.1030246-1-dmitry.baryshkov@linaro.org>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When parsing remote-endpoint properties, two counter devlinks will be
created, resulting in the circular dependency, which is later broken. In
most of the cases, the order in which depency is broken does not matter
(or is correct). However lately I stumbled upon the following
configuration.

In this case for some reason devlink code decided to break the loop by
making panel depend on the bridge driver, enforcing that bridge is
probed before the panel.

However in such cases the bridge will lookup next bridge or panel using
drm_of_find_panel_or_bridge() in the probe callback. Thus we have a
deadlock: panel is waiting for the bridge because of the devlink
dependency and bridge probe() expects the panel to be available and thus
returns -EPROBE_DEFER.

To prevent such deadlocks, stop parsing the remote-endpoint property and
let drivers decide their probe order using standard -EPROBE_DEFER
returns.

DTS except follows:

/ {
        panel0 {
                compatible = "powertip,ph800480t013-idf02";
                power-supply = <&vreg_l11c_3p3>;
                backlight = <&lcd0_reg>;
                port {
                        panel0_in: endpoint {
                                remote-endpoint = <&bridge0_out>;
                        };
                };
        };
};

&dsi0 {
        #address-cells = <1>;
        #size-cells = <0>;
        status = "okay";

        bridge@0 {
                reg = <0>;
                compatible = "toshiba,tc358762";

                ports {
                        #address-cells = <1>;
                        #size-cells = <0>;

                        port@0 {
                                reg = <0>;
                                bridge0_in: endpoint {
                                        remote-endpoint = <&dsi0_out>;
                                };
                        };

                        port@1 {
                                reg = <1>;
                                bridge0_out: endpoint {
                                        remote-endpoint = <&panel0_in>;
                                };
                        };
                };
        };
        ports {
                port@1 {
                        endpoint {
                                remote-endpoint = <&bridge0_in>;
                                data-lanes = <0 1 2 3>;
                        };
                };
        };

};

Fixes: f7514a663016 ("of: property: fw_devlink: Add support for remote-endpoint")
Cc: Bjorn Andersson <bjorn.andersson@linaro.org>
Cc: Stephen Boyd <swboyd@chromium.org>
Cc: Saravana Kannan <saravanak@google.com>
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 drivers/of/property.c | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/drivers/of/property.c b/drivers/of/property.c
index f7229e4030e3..83548076ee63 100644
--- a/drivers/of/property.c
+++ b/drivers/of/property.c
@@ -1249,7 +1249,6 @@ static struct device_node *parse_##fname(struct device_node *np,	     \
  * @parse_prop.index: For properties holding a list of phandles, this is the
  *		      index into the list
  * @optional: Describes whether a supplier is mandatory or not
- * @node_not_dev: The consumer node containing the property is never a device.
  *
  * Returns:
  * parse_prop() return values are
@@ -1261,7 +1260,6 @@ struct supplier_bindings {
 	struct device_node *(*parse_prop)(struct device_node *np,
 					  const char *prop_name, int index);
 	bool optional;
-	bool node_not_dev;
 };
 
 DEFINE_SIMPLE_PROP(interconnects, "interconnects", "#interconnect-cells")
@@ -1285,7 +1283,6 @@ DEFINE_SIMPLE_PROP(pinctrl5, "pinctrl-5", NULL)
 DEFINE_SIMPLE_PROP(pinctrl6, "pinctrl-6", NULL)
 DEFINE_SIMPLE_PROP(pinctrl7, "pinctrl-7", NULL)
 DEFINE_SIMPLE_PROP(pinctrl8, "pinctrl-8", NULL)
-DEFINE_SIMPLE_PROP(remote_endpoint, "remote-endpoint", NULL)
 DEFINE_SIMPLE_PROP(pwms, "pwms", "#pwm-cells")
 DEFINE_SIMPLE_PROP(resets, "resets", "#reset-cells")
 DEFINE_SIMPLE_PROP(leds, "leds", NULL)
@@ -1388,7 +1385,6 @@ static const struct supplier_bindings of_supplier_bindings[] = {
 	{ .parse_prop = parse_pinctrl6, },
 	{ .parse_prop = parse_pinctrl7, },
 	{ .parse_prop = parse_pinctrl8, },
-	{ .parse_prop = parse_remote_endpoint, .node_not_dev = true, },
 	{ .parse_prop = parse_pwms, },
 	{ .parse_prop = parse_resets, },
 	{ .parse_prop = parse_leds, },
@@ -1437,9 +1433,7 @@ static int of_link_property(struct device_node *con_np, const char *prop_name)
 		while ((phandle = s->parse_prop(con_np, prop_name, i))) {
 			struct device_node *con_dev_np;
 
-			con_dev_np = s->node_not_dev
-					? of_get_compat_node(con_np)
-					: of_node_get(con_np);
+			con_dev_np = of_node_get(con_np);
 			matched = true;
 			i++;
 			of_link_to_phandle(con_dev_np, phandle);
-- 
2.33.0

