Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 07C3442F9C9
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Oct 2021 19:10:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242026AbhJORNA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Oct 2021 13:13:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242028AbhJORM5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Oct 2021 13:12:57 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1950C061764
        for <linux-kernel@vger.kernel.org>; Fri, 15 Oct 2021 10:10:50 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id w19so40517719edd.2
        for <linux-kernel@vger.kernel.org>; Fri, 15 Oct 2021 10:10:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=pqrs.dk; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=cYwvQ9XrInIgpM4FjyC+ETtjnk6rOF0XKp2OfoEFVCI=;
        b=P1bCKfmwJhlya6S1wz5nxhKX7HSNl/3lv709VUYuV93Bypywyh6qRxFtUDzoJyn6Yq
         BMyeDt8QoN3zT+5jPqaggKX9fbyMgtTl4oExg5+GkgoRgsCi6Bbo7irXnNLelcLE/OwD
         MiQQ0Z5KV6k1OA4T7AgO1O6V/Ru+zxgu1L8x0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=cYwvQ9XrInIgpM4FjyC+ETtjnk6rOF0XKp2OfoEFVCI=;
        b=H6oN2hKnWadoJbqp+o7JhTzR4OI1Lr3TksOKSUSyqJjyn0we4DivFw0dIIFpVHp17T
         3sHt3BQiWdFfkU4yi32Dq4x+eB7mQXl5bI1L4tAYUu3qWrzdfp+FqbwT51IGMWnIHXP5
         t4XQmI6hTINQu1q1BQl/EkHqWbXyoHIXw2+Yt20D/8vNYwlzHgTr2ern8gJy+B0BChx2
         BB2aH789ndPjotTAEL1yIzf42U8fq8FuyZUztbZko8E2MfOxADuJSaAu77Wmpb2rnil1
         yA9PiN/M1wr6MZpRJUT8cDhUmntR54QeL65WXjgRZ2kGwSIP+bdb+rc8tclUz2RbvXGh
         kFuQ==
X-Gm-Message-State: AOAM532gHOsKSrKRVPpWldbODBupRppJFwBdl6y2Tz9PP2/d5wsry+mi
        tPrlmN8dQ9d93MikiSqyfNePBQ==
X-Google-Smtp-Source: ABdhPJzZOszo07gwPGeYOASE/oaQFBAlzbizVtUsuCZzikYH/NvO7qXGIjUHPwD9czP9aF/g+x2+2g==
X-Received: by 2002:a17:906:3cb:: with SMTP id c11mr8668459eja.404.1634317849478;
        Fri, 15 Oct 2021 10:10:49 -0700 (PDT)
Received: from capella.. (80.71.142.18.ipv4.parknet.dk. [80.71.142.18])
        by smtp.gmail.com with ESMTPSA id jt24sm4735792ejb.59.2021.10.15.10.10.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Oct 2021 10:10:48 -0700 (PDT)
From:   =?UTF-8?q?Alvin=20=C5=A0ipraga?= <alvin@pqrs.dk>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Andrew Lunn <andrew@lunn.ch>,
        Vivien Didelot <vivien.didelot@gmail.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Vladimir Oltean <olteanv@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Russell King <linux@armlinux.org.uk>
Cc:     =?UTF-8?q?Alvin=20=C5=A0ipraga?= <alsi@bang-olufsen.dk>,
        netdev@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 net-next 2/7] net: dsa: allow reporting of standard ethtool stats for slave devices
Date:   Fri, 15 Oct 2021 19:10:23 +0200
Message-Id: <20211015171030.2713493-3-alvin@pqrs.dk>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20211015171030.2713493-1-alvin@pqrs.dk>
References: <20211015171030.2713493-1-alvin@pqrs.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alvin Šipraga <alsi@bang-olufsen.dk>

Jakub pointed out that we have a new ethtool API for reporting device
statistics in a standardized way, via .get_eth_{phy,mac,ctrl}_stats.
Add a small amount of plumbing to allow DSA drivers to take advantage of
this when exposing statistics.

Suggested-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Alvin Šipraga <alsi@bang-olufsen.dk>
---

v2 -> v3: this patch is new

 include/net/dsa.h |  6 ++++++
 net/dsa/slave.c   | 34 ++++++++++++++++++++++++++++++++++
 2 files changed, 40 insertions(+)

diff --git a/include/net/dsa.h b/include/net/dsa.h
index d784e76113b8..8fefd58ced8f 100644
--- a/include/net/dsa.h
+++ b/include/net/dsa.h
@@ -645,6 +645,12 @@ struct dsa_switch_ops {
 	int	(*get_sset_count)(struct dsa_switch *ds, int port, int sset);
 	void	(*get_ethtool_phy_stats)(struct dsa_switch *ds,
 					 int port, uint64_t *data);
+	void	(*get_eth_phy_stats)(struct dsa_switch *ds, int port,
+				     struct ethtool_eth_phy_stats *phy_stats);
+	void	(*get_eth_mac_stats)(struct dsa_switch *ds, int port,
+				     struct ethtool_eth_mac_stats *mac_stats);
+	void	(*get_eth_ctrl_stats)(struct dsa_switch *ds, int port,
+				      struct ethtool_eth_ctrl_stats *ctrl_stats);
 	void	(*get_stats64)(struct dsa_switch *ds, int port,
 				   struct rtnl_link_stats64 *s);
 	void	(*self_test)(struct dsa_switch *ds, int port,
diff --git a/net/dsa/slave.c b/net/dsa/slave.c
index 11ec9e689589..499f8d18c76d 100644
--- a/net/dsa/slave.c
+++ b/net/dsa/slave.c
@@ -789,6 +789,37 @@ static int dsa_slave_get_sset_count(struct net_device *dev, int sset)
 	return -EOPNOTSUPP;
 }
 
+static void dsa_slave_get_eth_phy_stats(struct net_device *dev,
+					struct ethtool_eth_phy_stats *phy_stats)
+{
+	struct dsa_port *dp = dsa_slave_to_port(dev);
+	struct dsa_switch *ds = dp->ds;
+
+	if (ds->ops->get_eth_phy_stats)
+		ds->ops->get_eth_phy_stats(ds, dp->index, phy_stats);
+}
+
+static void dsa_slave_get_eth_mac_stats(struct net_device *dev,
+					struct ethtool_eth_mac_stats *mac_stats)
+{
+	struct dsa_port *dp = dsa_slave_to_port(dev);
+	struct dsa_switch *ds = dp->ds;
+
+	if (ds->ops->get_eth_mac_stats)
+		ds->ops->get_eth_mac_stats(ds, dp->index, mac_stats);
+}
+
+static void
+dsa_slave_get_eth_ctrl_stats(struct net_device *dev,
+			     struct ethtool_eth_ctrl_stats *ctrl_stats)
+{
+	struct dsa_port *dp = dsa_slave_to_port(dev);
+	struct dsa_switch *ds = dp->ds;
+
+	if (ds->ops->get_eth_ctrl_stats)
+		ds->ops->get_eth_ctrl_stats(ds, dp->index, ctrl_stats);
+}
+
 static void dsa_slave_net_selftest(struct net_device *ndev,
 				   struct ethtool_test *etest, u64 *buf)
 {
@@ -1695,6 +1726,9 @@ static const struct ethtool_ops dsa_slave_ethtool_ops = {
 	.get_strings		= dsa_slave_get_strings,
 	.get_ethtool_stats	= dsa_slave_get_ethtool_stats,
 	.get_sset_count		= dsa_slave_get_sset_count,
+	.get_eth_phy_stats	= dsa_slave_get_eth_phy_stats,
+	.get_eth_mac_stats	= dsa_slave_get_eth_mac_stats,
+	.get_eth_ctrl_stats	= dsa_slave_get_eth_ctrl_stats,
 	.set_wol		= dsa_slave_set_wol,
 	.get_wol		= dsa_slave_get_wol,
 	.set_eee		= dsa_slave_set_eee,
-- 
2.32.0

