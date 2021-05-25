Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F170838FD7E
	for <lists+linux-kernel@lfdr.de>; Tue, 25 May 2021 11:11:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232377AbhEYJMl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 May 2021 05:12:41 -0400
Received: from wnew2-smtp.messagingengine.com ([64.147.123.27]:54361 "EHLO
        wnew2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232364AbhEYJMj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 May 2021 05:12:39 -0400
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailnew.west.internal (Postfix) with ESMTP id AEDB1A09;
        Tue, 25 May 2021 05:11:08 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Tue, 25 May 2021 05:11:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm2; bh=uQPzFz4rsR1CZ
        Eyj9NEDhDZyvUIuqds/jM6YN+Bp8Yw=; b=v3oNEPbQZCKbTJHYgNi4p6WJGadSF
        dBm9kQyizws/1qRyYlWRrdDF0NXAToqWhtc/w6pOgImZAD1DQxtuUCuejmrcgCrb
        z7mu8ShruIFh1FscZXNyio4amADV2uHBTCvpvpumbf0hk/grljZMKTak2uu1PFMC
        r0K4YSKzp2ntdh9gClOGDBDWaLfR5GXj+7LM9aGZNmFq5YgtHTi3ErLE4jn8+S7r
        VlltL8F5eqvpUa3+F5KJxjn+wHRBk+JCwrEhmuIecQVzNV+FhaJfxc+4akynGCGM
        sItv+GGSrDXvaxqNsyMw9jPNu9QPi1frN8a4sgmIpXTXflcZV68HFxnyw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm2; bh=uQPzFz4rsR1CZEyj9NEDhDZyvUIuqds/jM6YN+Bp8Yw=; b=ekTzkxU9
        QKKoE4lf387CUY0NxzluXZ/7NwSolxI2DgJwK/3M7hftS5M6FsrzD3oIasFjN1VR
        WkmP+Q2AQHu6plkdU3ZmzCfQADX6+8ONb+caR1HbipQjINIHn/G3p+h8gR6TrAzn
        lMkMmvNFJyvE3fkbp/wNBizpYSZ1OqLyBHOhG7HOx7aJNH/n6yKpYUq8nosdXkx9
        XpatXTYQRfRiZQllhnyK5konLDE4xOsuEPznFpD4q5xhKqu5zwX9HwzvUOXDLJb0
        n3qgBJZuaieWpb4xukJK7t21moYEsIEYQNm4vhdsOeIO6kmlHYtuyxSle5Lm7V9q
        BsQ19VE6jS6e1w==
X-ME-Sender: <xms:K7-sYMz-QS4Xivf-7Ol4iWhBsrIq4ktbbmybEByq8fnhRq1O5KJEpQ>
    <xme:K7-sYAThChFuiFAVxQHsWliF2sEnjb83YILcghh7YBgcisqxuu1yQwED6Ys2VvRH4
    KEao_Y0a03owGXbGIo>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrvdekuddgudefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpeforgigihhm
    vgcutfhiphgrrhguuceomhgrgihimhgvsegtvghrnhhordhtvggthheqnecuggftrfgrth
    htvghrnhepvdekleevfeffkeejhfffueelteelfeduieefheduudfggffhhfffheevveeh
    hedvnecukfhppeeltddrkeelrdeikedrjeeinecuvehluhhsthgvrhfuihiivgeptdenuc
    frrghrrghmpehmrghilhhfrhhomhepmhgrgihimhgvsegtvghrnhhordhtvggthh
X-ME-Proxy: <xmx:K7-sYOW-2-bphzXG666x1hn2K-gjAwFAU_BeblujW9fmCBQ0kiZ_3A>
    <xmx:K7-sYKhxEY-uOelwyyHY70AF5mJ3B4xy8nv4fNqQu2P1k8jAKIqM0A>
    <xmx:K7-sYOAYrkl24_rQy0rtLoG-opBBq0saG74l198rJDN48nV65dh1ow>
    <xmx:LL-sYKx9gOBwk-hL7f7Rr51WEZkGsfFQV0g1FYISOrc3qf0atiOFmaFGJFk>
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        by mail.messagingengine.com (Postfix) with ESMTPA;
        Tue, 25 May 2021 05:11:06 -0400 (EDT)
From:   Maxime Ripard <maxime@cerno.tech>
To:     dri-devel@lists.freedesktop.org,
        Daniel Vetter <daniel.vetter@intel.com>,
        David Airlie <airlied@linux.ie>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Maxime Ripard <maxime@cerno.tech>
Cc:     Daniel Vetter <daniel@ffwll.ch>,
        Boris Brezillon <bbrezillon@kernel.org>,
        linux-kernel@vger.kernel.org, Eric Anholt <eric@anholt.net>,
        Emma Anholt <emma@anholt.net>,
        Dave Stevenson <dave.stevenson@raspberrypi.com>,
        Phil Elwell <phil@raspberrypi.com>,
        Tim Gover <tim.gover@raspberrypi.com>,
        Dom Cobley <dom@raspberrypi.com>,
        Maxime Ripard <mripard@kernel.org>
Subject: [PATCH 1/3] drm: Mention the power state requirement on side-channel operations
Date:   Tue, 25 May 2021 11:10:57 +0200
Message-Id: <20210525091059.234116-2-maxime@cerno.tech>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210525091059.234116-1-maxime@cerno.tech>
References: <20210525091059.234116-1-maxime@cerno.tech>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The drm_connector detect, drm_dp_aux transfer and mipi_dsi_host
operations typically require to access their underlying device to
perform what is expected of them.

However, there's no guarantee on the fact that the device has been
enabled through atomic_enable or similar that will usually power the
device. The access to an unpowered device is then an undefined behaviour
ranging from the access being ignored to a hard CPU hang.

Let's document that expectation to avoid as much as possible those
consequences.

Signed-off-by: Maxime Ripard <maxime@cerno.tech>
---
 include/drm/drm_connector.h | 5 +++++
 include/drm/drm_dp_helper.h | 4 ++++
 include/drm/drm_mipi_dsi.h  | 5 +++++
 3 files changed, 14 insertions(+)

diff --git a/include/drm/drm_connector.h b/include/drm/drm_connector.h
index 714d1a01c065..0a1d9a0fcbb2 100644
--- a/include/drm/drm_connector.h
+++ b/include/drm/drm_connector.h
@@ -848,6 +848,11 @@ struct drm_connector_funcs {
 	 * locks to avoid races with concurrent modeset changes need to use
 	 * &drm_connector_helper_funcs.detect_ctx instead.
 	 *
+	 * Also note that this callback can be called no matter the
+	 * state the connector is in. Drivers that need the underlying
+	 * device to be powered to perform the detection will first need
+	 * to make sure it's been properly enabled.
+	 *
 	 * RETURNS:
 	 *
 	 * drm_connector_status indicating the connector's status.
diff --git a/include/drm/drm_dp_helper.h b/include/drm/drm_dp_helper.h
index 06681bf46d81..4fcb027c8821 100644
--- a/include/drm/drm_dp_helper.h
+++ b/include/drm/drm_dp_helper.h
@@ -1884,6 +1884,10 @@ struct drm_dp_aux_cec {
  * Note that the aux helper code assumes that the @transfer() function only
  * modifies the reply field of the &drm_dp_aux_msg structure. The retry logic
  * and i2c helpers assume this is the case.
+ *
+ * Also note that @transfer() can be called no matter the state @dev is
+ * in. Drivers that need that device to be powered to perform this
+ * operation will first need to make sure it's been properly enabled.
  */
 struct drm_dp_aux {
 	const char *name;
diff --git a/include/drm/drm_mipi_dsi.h b/include/drm/drm_mipi_dsi.h
index 360e6377e84b..849d3029e303 100644
--- a/include/drm/drm_mipi_dsi.h
+++ b/include/drm/drm_mipi_dsi.h
@@ -80,6 +80,11 @@ int mipi_dsi_create_packet(struct mipi_dsi_packet *packet,
  * Note that typically DSI packet transmission is atomic, so the .transfer()
  * function will seldomly return anything other than the number of bytes
  * contained in the transmit buffer on success.
+ *
+ * Also note that those callbacks can be called no matter the state the
+ * host is in. Drivers that need the underlying device to be powered to
+ * perform these operations will first need to make sure it's been
+ * properly enabled.
  */
 struct mipi_dsi_host_ops {
 	int (*attach)(struct mipi_dsi_host *host,
-- 
2.31.1

