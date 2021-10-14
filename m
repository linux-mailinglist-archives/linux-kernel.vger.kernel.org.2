Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A492A42DE1D
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Oct 2021 17:26:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233362AbhJNP22 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Oct 2021 11:28:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232545AbhJNP2W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Oct 2021 11:28:22 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C557FC061570
        for <linux-kernel@vger.kernel.org>; Thu, 14 Oct 2021 08:26:17 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id r10so20591707wra.12
        for <linux-kernel@vger.kernel.org>; Thu, 14 Oct 2021 08:26:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=xJdt9xqgEepFbtbB1UkquFZ4VDLNOq6El+raZeZWSOM=;
        b=pt34RyPq6TeilQMWvaHMCBd0p6iBB5mQ8zyO7bsO0z01t93qtPnfhTtxhynXcJCNZI
         iejhkLmblTXq7J0R4WWX12xrJSxTJW0L0GLzhdteU9CAgzcrwsJlco9WizJRgcsgkMlf
         5SSeCrL3ajGsL5O2s7oUzFOnkoSIkFyX4d5TNYLMjAG3Obr8FEN2lK+YUXNF9NydQi1L
         P39e94inxhD6MtuCe4rImRHiIoHLnIIucIf205t/kkHURxK51E89grzki14Vr/RhGiA5
         p+Y1BsN/CDaqCfhOWBrF0dJNqtR+7ZDFhXLL1nhfz0eac2nIjIR7sxin3uJohE6T1QLY
         x/Lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=xJdt9xqgEepFbtbB1UkquFZ4VDLNOq6El+raZeZWSOM=;
        b=0qEe0/RGlibBOi/bC4TGaFUHbfniq0UOf7ctlY+aN7xSLSj7JJWVQzd2cPMo53bcrW
         /L4Oh+1Y57sF3uwnOlWdS7Gjy+cqBsDTkloxCB8/pvVCEZCRtASuK7TrHCtse3iuKbhB
         dIS8CDbrCI7tEJgeJ/gV6bA7QB9hJUEi27yz927ivtT0ZTmg98AWr6v6wtYec312DBsj
         v5oqo2FG4S/Log04Hx+pZaUmqPkHoezSOalCh8FKVrnGFHSIyilZhomK964xDvfJxLnN
         mosE28EBDnQ46bMCDkghHpvFA+2w+AtRp1DTWi63MtKXdTSoxo5h9+XXT2x4vpLn9vtP
         G1Sw==
X-Gm-Message-State: AOAM5324td9LZDE4g1DImGKbxMfH1kW1d9BZzLqdo4CxGRavtLll6e8w
        SIM0jOMYwUNSJ+oPNp/xceql7g==
X-Google-Smtp-Source: ABdhPJwK/ywxZ2fw2tMZOvBzRr4/yRNBMI1ZBNntxWcjpPuqQLTvL/JRBJL2y5JNH7j8BDDkiWNjnA==
X-Received: by 2002:adf:aa92:: with SMTP id h18mr7277007wrc.372.1634225176290;
        Thu, 14 Oct 2021 08:26:16 -0700 (PDT)
Received: from localhost.localdomain ([2001:861:44c0:66c0:209b:8400:2b80:b4ae])
        by smtp.gmail.com with ESMTPSA id k22sm2626790wrd.59.2021.10.14.08.26.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Oct 2021 08:26:15 -0700 (PDT)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     daniel@ffwll.ch, Laurent.pinchart@ideasonboard.com,
        robert.foss@linaro.org, jonas@kwiboo.se, jernej.skrabec@gmail.com
Cc:     martin.blumenstingl@googlemail.com,
        dri-devel@lists.freedesktop.org, linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Neil Armstrong <narmstrong@baylibre.com>
Subject: [PATCH 4/7] drm/bridge: synopsys: dw-hdmi: also allow interlace on bridge
Date:   Thu, 14 Oct 2021 17:26:03 +0200
Message-Id: <20211014152606.2289528-5-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211014152606.2289528-1-narmstrong@baylibre.com>
References: <20211014152606.2289528-1-narmstrong@baylibre.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=884; h=from:subject; bh=VqFA57uYRVnBWiC14bz6QM29bBtN5sRjm8xb2MmDNeU=; b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBhaEuAk+fmsK54XgR9Ufj2kk92eYhEp32GG1J/nqjJ orc3ih6JAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCYWhLgAAKCRB33NvayMhJ0VXbD/ sHJAJpjVaCD1jpnUNddl/tWvU1cQ93DRTHgJCZ4Vr+G+868TYNoXo/scludQSH488DVMDjgGBIJy3M 6jK35EeZgBAUAuD1qmSVEe+aawSSejSlM2Lsfem+TqSWohfPnegZ0q1E66Hm3VUWoaECFyJRPW8i/d 24vn91yOmynCdVKzNMndB5roqofG/5fPGZ1aDi74uySqBv4Cn7ZZ7Hg93KLAHVmcF/NvWr8TquzgCW zq5WoxWT+SIHWoqHLW8LAQTzTLzlNlGkAy15eFAE5PK4cSJebUxX9M+Fn8CEzedh8OsnRffzrydbh8 Bk3deAPoxjBKasnYv0xs1/zGc7Ya6Dic/085flzUlDSUjqz8HounBW3Nttrn7+w+wSvl8kgRm2/a+c bEG+nDgyUN/TGEBO45quuzXh7rTcK8aYsjixdqxkrQC3cbI5dXEs/5j8YWIPVFVfujGPCV+8rHy2Oj H1nPVMzDhd1JPMQ/rx+gZXzQ2U8L2DfxgxG5SUNpX+LJfs7yYLrtVG9aYoEj+goPNPU4txlZK9JaFZ Z1I8clZ/y5FdnnYlBF8iv/R5iCw+CGoZJuNCc7uriMIM0hfwTGGxD/RuQDMSlh+WMj8ULonwqM8rHz w6y1ruDofp+/TouykxmSWQSPPjwQvBgpLLPoa3VnSsUV55ANFAqA23zsLhOA==
X-Developer-Key: i=narmstrong@baylibre.com; a=openpgp; fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since we allow interlace on the encoder, also allow it on the bridge
so we can allow interlaced modes when using DRM_BRIDGE_ATTACH_NO_CONNECTOR.

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 drivers/gpu/drm/bridge/synopsys/dw-hdmi.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c b/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
index f08d0fded61f..62ae63565d3a 100644
--- a/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
+++ b/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
@@ -3413,6 +3413,7 @@ struct dw_hdmi *dw_hdmi_probe(struct platform_device *pdev,
 	hdmi->bridge.funcs = &dw_hdmi_bridge_funcs;
 	hdmi->bridge.ops = DRM_BRIDGE_OP_DETECT | DRM_BRIDGE_OP_EDID
 			 | DRM_BRIDGE_OP_HPD;
+	hdmi->bridge.interlace_allowed = true;
 #ifdef CONFIG_OF
 	hdmi->bridge.of_node = pdev->dev.of_node;
 #endif
-- 
2.25.1

