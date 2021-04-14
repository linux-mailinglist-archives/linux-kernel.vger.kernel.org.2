Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0088035FA9B
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Apr 2021 20:22:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352944AbhDNSPT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Apr 2021 14:15:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352529AbhDNSMq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Apr 2021 14:12:46 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7ED4C06138E
        for <linux-kernel@vger.kernel.org>; Wed, 14 Apr 2021 11:12:24 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id r12so32835038ejr.5
        for <linux-kernel@vger.kernel.org>; Wed, 14 Apr 2021 11:12:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=qK+Xn3XSqnVGFlxnxNxfWPIqrE0tgY5h8GYqAB5G+DE=;
        b=iQsH62qmVgQp78TsW8LX2zKarBYm/qLuIbzzvH57gC/Kxf2vTlC+A1q+V/4Q4gcFQz
         6Tqj/NWg5ev3+BkX0gVoAi03M8ap3avCQhd3dBba+Je10VBz21AI0Knw5gL0C7DteEsR
         G5OQaFIrlhPX5WsKQ7hi5oEIib4KcdtFunT2bEGtY93sMoxjMYSNoBoGpC4VZ247E1zJ
         o9mcBfO9zlNsiq2kMpPF8EGpdQ6KfiCeqC3ZUrgcIeQQ3vVnv7Aa0jMZhIhY5cMfY5xV
         48IEtn+PVEsqRyUZmj3eCia/gyKioWntlr19uygqRDux9qQsjxKKSjd5GF2/qlXgsjwp
         qdGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qK+Xn3XSqnVGFlxnxNxfWPIqrE0tgY5h8GYqAB5G+DE=;
        b=ML4oE+Hn7rKtz5Ak5Emqvz8n410y1tRlNn0NQiwsDtHQdvXn86UYEvm0bUiMDpxaSH
         XJ/6zNI+cQcTGDW5hho7BrkKNajGaLvOXdNteDDekdl+YvMML2eCSuvDTCAQf2EMxv7m
         GrTNK6P8g62+MswAdg9uHyy1NS9ku6MZ6hIBjQyO2oDntn/HdjoEbep5kSZQe+S0geY1
         VSyC31CjDznppuqwdSy08r9Eo0oNrFrazw93s79Q47V54SRAK18HEFG6DZO5iKJ7gJ5r
         XrVIP9n+5H9qP5shus1gRVwyGOUS/CjZMCRlx5S2eXB9rIoPGpSsZi6oxs31ffEjxXgv
         nb5w==
X-Gm-Message-State: AOAM532YnMIvD2j81pGJKP0yhVEyDyGrg8TbK4E4klCthde/4HWYKgLF
        VmWpi/RbWwANiJLY0AjAJtKbvQ==
X-Google-Smtp-Source: ABdhPJxF/weuJqO70KbRUG7VR4Rut/kRyHLVGI1RAMOTVQijhUzPkHkhiln4aTmSI8qv8Eod9Px7WQ==
X-Received: by 2002:a17:906:3018:: with SMTP id 24mr176405ejz.186.1618423943723;
        Wed, 14 Apr 2021 11:12:23 -0700 (PDT)
Received: from dell.default ([91.110.221.215])
        by smtp.gmail.com with ESMTPSA id v1sm279493eds.17.2021.04.14.11.12.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Apr 2021 11:12:23 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev
Subject: [PATCH 47/57] staging: rtl8723bs: os_dep: ioctl_cfg80211: 'ack' is used when debug is enabled
Date:   Wed, 14 Apr 2021 19:11:19 +0100
Message-Id: <20210414181129.1628598-48-lee.jones@linaro.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210414181129.1628598-1-lee.jones@linaro.org>
References: <20210414181129.1628598-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c: In function ‘_cfg80211_rtw_mgmt_tx’:
 drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c:2754:7: warning: variable ‘ack’ set but not used [-Wunused-but-set-variable]

Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-staging@lists.linux.dev
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c b/drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c
index 89a21eb63c0a9..48b64fb579755 100644
--- a/drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c
+++ b/drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c
@@ -2591,7 +2591,7 @@ static int _cfg80211_rtw_mgmt_tx(struct adapter *padapter, u8 tx_ch, const u8 *b
 	struct pkt_attrib	*pattrib;
 	unsigned char *pframe;
 	int ret = _FAIL;
-	bool ack = true;
+	bool __maybe_unused ack = true;
 	struct ieee80211_hdr *pwlanhdr;
 	struct xmit_priv *pxmitpriv = &(padapter->xmitpriv);
 	struct mlme_ext_priv *pmlmeext = &(padapter->mlmeextpriv);
-- 
2.27.0

