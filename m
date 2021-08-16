Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5C21F3EDCE6
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Aug 2021 20:10:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232897AbhHPSKf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Aug 2021 14:10:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233028AbhHPSKW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Aug 2021 14:10:22 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B3B6C0617AF
        for <linux-kernel@vger.kernel.org>; Mon, 16 Aug 2021 11:09:34 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id b7so27832629edu.3
        for <linux-kernel@vger.kernel.org>; Mon, 16 Aug 2021 11:09:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mind.be; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=JPEdTz55eeFZmTipGCcbNE0GKiAhFZ1eLySPvZceEsU=;
        b=USZrrePZsDm1l8YAZ/qA5fx/fzePtZlbfJmkcDUvidT8YYfBpHcnJ9Ru5an+FSzJZU
         6Ksam4Ily92x5UxlqvSAhFzkuhQR7yP+a7bK5fItcVA9fziVe02VifdHAi5sVIcP+y3X
         mQRFG+iXGFPyxISaCewFUPws/p4y3rRhWCCOpZLTCVs73SBmIldOZ/VQeFV10HHemunT
         E0+8CZtfAo9HDcixqDp5Ny7WaQVm2NVMCMiN+GRi5ZG5XOl3P62mX0Cdir5HAI10hW6Y
         rT2fgRd6EBVEdDhsMSUv2njTokMe6+eGzae6wMs+iCd7HVjotR6yM4l5/3jrtzWzxO28
         OQ0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=JPEdTz55eeFZmTipGCcbNE0GKiAhFZ1eLySPvZceEsU=;
        b=eiIRYt8DDAiPZzydPZ2Ok1MLSrihs1VXNkCZdURWa0nfCDIPzKsKdRYJ2V8Edw1aq9
         6NQYrTi0yXEJAlSK9B7xh53OVeuNzpZZFCDrJXeygyV39NdFjdnmWV9kBauxyB6zw/RD
         HufFlJQBtxMN/jnUIe3UZbIvC07Bj/47b+G1IWJ98pXL+C0gRuRIK+X9LlDKjvfWfT4j
         6l/pl8OOVTFovt7TaGuxNC8HRXJg4qz8CutpqB8tS0q/1wZ5VGSJotC48mTWjWQhwetm
         LUtHBx0X8o588B/yjYa5MiEi1GkZcvtQbjdHmPC911lqMfjd6MeI2fhC0TrQwHirVip7
         WjgQ==
X-Gm-Message-State: AOAM530hYGKdRmbNqrXL/vh2Ip+Iv6mXjH94xa+u2RlMCiUcMVFiJbSJ
        8TWF1jNaj6K5rHbkp6SUvbC9XA==
X-Google-Smtp-Source: ABdhPJxszyCJ08/thUnQI+lhz3dx9qB5WP9ylaGefLhrTFvXdKKvVKNZnl6sgZrrxL5mNFug+OqH7Q==
X-Received: by 2002:a05:6402:27d2:: with SMTP id c18mr22129669ede.87.1629137373079;
        Mon, 16 Aug 2021 11:09:33 -0700 (PDT)
Received: from cephalopod (168.7-181-91.adsl-dyn.isp.belgacom.be. [91.181.7.168])
        by smtp.gmail.com with ESMTPSA id m6sm5201725edq.22.2021.08.16.11.09.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Aug 2021 11:09:32 -0700 (PDT)
Date:   Mon, 16 Aug 2021 20:09:31 +0200
From:   Ben Hutchings <ben.hutchings@mind.be>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 3/5] net: dsa: microchip: ksz8795: Reject unsupported
 VLAN configuration
Message-ID: <20210816180930.GG18930@cephalopod>
References: <20210816174905.GD18930@cephalopod>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210816174905.GD18930@cephalopod>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

commit 8f4f58f88fe0d9bd591f21f53de7dbd42baeb3fa upstream.

The switches supported by ksz8795 only have a per-port flag for Tag
Removal.  This means it is not possible to support both tagged and
untagged VLANs on the same port.  Reject attempts to add a VLAN that
requires the flag to be changed, unless there are no VLANs currently
configured.

VID 0 is excluded from this check since it is untagged regardless of
the state of the flag.

On the CPU port we could support tagged and untagged VLANs at the same
time.  This will be enabled by a later patch.

Fixes: e66f840c08a2 ("net: dsa: ksz: Add Microchip KSZ8795 DSA driver")
Signed-off-by: Ben Hutchings <ben.hutchings@mind.be>
Signed-off-by: David S. Miller <davem@davemloft.net>
[bwh: Backport to 5.10:
 - This configuration has to be detected and rejected in the
   port_vlan_prepare operation
 - ksz8795_port_vlan_add() has to check again to decide whether to
   change the Tag Removal flag, so put the common condition in a
   separate function
 - Handle VID ranges]
Signed-off-by: Ben Hutchings <ben.hutchings@mind.be>
---
 drivers/net/dsa/microchip/ksz8795.c    | 55 +++++++++++++++++++++++++-
 drivers/net/dsa/microchip/ksz_common.h |  1 +
 2 files changed, 54 insertions(+), 2 deletions(-)

diff --git a/drivers/net/dsa/microchip/ksz8795.c b/drivers/net/dsa/microchip/ksz8795.c
index 3d36ffff1f4e..b4b164d75520 100644
--- a/drivers/net/dsa/microchip/ksz8795.c
+++ b/drivers/net/dsa/microchip/ksz8795.c
@@ -801,15 +801,66 @@ static int ksz8795_port_vlan_filtering(struct dsa_switch *ds, int port,
 	return 0;
 }
 
+static bool ksz8795_port_vlan_changes_remove_tag(
+	struct dsa_switch *ds, int port,
+	const struct switchdev_obj_port_vlan *vlan)
+{
+	bool untagged = vlan->flags & BRIDGE_VLAN_INFO_UNTAGGED;
+	struct ksz_device *dev = ds->priv;
+	struct ksz_port *p = &dev->ports[port];
+
+	/* If a VLAN is added with untagged flag different from the
+	 * port's Remove Tag flag, we need to change the latter.
+	 * Ignore VID 0, which is always untagged.
+	 */
+	return untagged != p->remove_tag &&
+		!(vlan->vid_begin == 0 && vlan->vid_end == 0);
+}
+
+int ksz8795_port_vlan_prepare(struct dsa_switch *ds, int port,
+			      const struct switchdev_obj_port_vlan *vlan)
+{
+	struct ksz_device *dev = ds->priv;
+
+	/* Reject attempts to add a VLAN that requires the Remove Tag
+	 * flag to be changed, unless there are no other VLANs
+	 * currently configured.
+	 */
+	if (ksz8795_port_vlan_changes_remove_tag(ds, port, vlan)) {
+		unsigned int vid;
+
+		for (vid = 1; vid < dev->num_vlans; ++vid) {
+			u8 fid, member, valid;
+
+			/* Skip the VIDs we are going to add or reconfigure */
+			if (vid == vlan->vid_begin) {
+				vid = vlan->vid_end;
+				continue;
+			}
+
+			ksz8795_from_vlan(dev->vlan_cache[vid].table[0],
+					  &fid, &member, &valid);
+			if (valid && (member & BIT(port)))
+				return -EINVAL;
+		}
+	}
+
+	return ksz_port_vlan_prepare(ds, port, vlan);
+}
+
 static void ksz8795_port_vlan_add(struct dsa_switch *ds, int port,
 				  const struct switchdev_obj_port_vlan *vlan)
 {
 	bool untagged = vlan->flags & BRIDGE_VLAN_INFO_UNTAGGED;
 	struct ksz_device *dev = ds->priv;
+	struct ksz_port *p = &dev->ports[port];
 	u16 data, vid, new_pvid = 0;
 	u8 fid, member, valid;
 
-	ksz_port_cfg(dev, port, P_TAG_CTRL, PORT_REMOVE_TAG, untagged);
+	if (ksz8795_port_vlan_changes_remove_tag(ds, port, vlan)) {
+		ksz_port_cfg(dev, port, P_TAG_CTRL, PORT_REMOVE_TAG, untagged);
+		p->remove_tag = untagged;
+	}
 
 	for (vid = vlan->vid_begin; vid <= vlan->vid_end; vid++) {
 		ksz8795_r_vlan_table(dev, vid, &data);
@@ -1128,7 +1179,7 @@ static const struct dsa_switch_ops ksz8795_switch_ops = {
 	.port_stp_state_set	= ksz8795_port_stp_state_set,
 	.port_fast_age		= ksz_port_fast_age,
 	.port_vlan_filtering	= ksz8795_port_vlan_filtering,
-	.port_vlan_prepare	= ksz_port_vlan_prepare,
+	.port_vlan_prepare	= ksz8795_port_vlan_prepare,
 	.port_vlan_add		= ksz8795_port_vlan_add,
 	.port_vlan_del		= ksz8795_port_vlan_del,
 	.port_fdb_dump		= ksz_port_fdb_dump,
diff --git a/drivers/net/dsa/microchip/ksz_common.h b/drivers/net/dsa/microchip/ksz_common.h
index a51c716ec920..309ad4a72d78 100644
--- a/drivers/net/dsa/microchip/ksz_common.h
+++ b/drivers/net/dsa/microchip/ksz_common.h
@@ -27,6 +27,7 @@ struct ksz_port_mib {
 struct ksz_port {
 	u16 member;
 	u16 vid_member;
+	bool remove_tag;		/* Remove Tag flag set, for ksz8795 only */
 	int stp_state;
 	struct phy_device phydev;
 
-- 
2.20.1

