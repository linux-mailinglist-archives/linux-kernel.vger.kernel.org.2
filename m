Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A67D4070AE
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Sep 2021 19:54:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231879AbhIJRz6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Sep 2021 13:55:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229476AbhIJRz5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Sep 2021 13:55:57 -0400
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11B22C061574
        for <linux-kernel@vger.kernel.org>; Fri, 10 Sep 2021 10:54:46 -0700 (PDT)
Received: by mail-pg1-x529.google.com with SMTP id w8so2515950pgf.5
        for <linux-kernel@vger.kernel.org>; Fri, 10 Sep 2021 10:54:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=aNdAt3bIyCf0OKCvnDHfldR4f9Z2Y9u67akOXp3+z54=;
        b=ZAvsshhZZBaZiHNl9M8e9qw1Sp8NuOS5+VedetlWLCqPs5SMzt5OJPHeX/dDDI7Q8m
         A2SiSKiJmI/y/keXRa8fNt3mr1U5I6Pjs0Ia60LfIn39mvgqgKC2KYTnvCXOxAJqqqqk
         qRp37zb7dVXk4s/zaVNP0WMCbD/un1Y8U3X+qaTJZId97lT5Vs75kSkeHgFU7BlfSrap
         Kkb+hyXk4ztYMWkQ/fWALZ37x+2lGV8brRgNqRd87QoaAggxF+05rvhqujhTJrp7LbWy
         MiX5l6g1w4bciKVlveZfJGMHvq4byU44BGcuxXf8f1J/KWB5WZ9yACLI+fAOAuYWwMpa
         oalg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=aNdAt3bIyCf0OKCvnDHfldR4f9Z2Y9u67akOXp3+z54=;
        b=zl8C/83ub7jrAOBVfhBBSOG/HmAX7hA/WxXU3rJRiinkOeGJDEl0r+cDvRRg031/fU
         6VcAruYBm/3oSCCBMp3fTsJz6HdbngXfuLyrPa/DZjzRRtHwgh9+YzET4OQOvmPWkQqS
         RTk1j/99prmmLR+efBqNpoHiBGXxYRIj64wKcTkeUwHXMs2Q8eD55Xu9DXu+A7TVK+tW
         lFkH1RVoi3TX+cDZqTTG3afLInEO9EayMnBwgm439OHpYyRXvD/W2mYGHwYPykqY4YXk
         AdDc/o8VcvntBY5YJDlyLGK78i/Y0vyAdfpViVTDSvkkXR8zHbd53UgxxGNbcf+zOP+j
         Wa7Q==
X-Gm-Message-State: AOAM532ERHqv2276A3//b926WQrewEIsHCfFwbioWT0lGwc/lpQqn7GP
        DWcN2D/QHj5WZEz4e5s0oes=
X-Google-Smtp-Source: ABdhPJwR236U1teahdmj4d8BkQvVQ4ygrxUYFsq342vIic5uJhW63bhYrd3OuLYLvFH8SRBibynpBQ==
X-Received: by 2002:a63:33cb:: with SMTP id z194mr8370058pgz.380.1631296485508;
        Fri, 10 Sep 2021 10:54:45 -0700 (PDT)
Received: from user ([117.98.200.228])
        by smtp.gmail.com with ESMTPSA id h8sm5550218pfr.219.2021.09.10.10.54.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Sep 2021 10:54:45 -0700 (PDT)
Date:   Fri, 10 Sep 2021 23:24:39 +0530
From:   Saurav Girepunje <saurav.girepunje@gmail.com>
To:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        gregkh@linuxfoundation.org, straube.linux@gmail.com,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Cc:     saurav.girepunje@hotmail.com
Subject: [PATCH] staging: r8188eu: core: remove the function
 power_saving_wk_hdl
Message-ID: <YTub30ZRG3oLbxQW@user>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove the function power_saving_wk_hdl() as it just calling
the rtw_ps_processor().Instead of power_saving_wk_hdl() call directly
rtw_ps_processor().

Signed-off-by: Saurav Girepunje <saurav.girepunje@gmail.com>
---
 drivers/staging/r8188eu/core/rtw_cmd.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/drivers/staging/r8188eu/core/rtw_cmd.c b/drivers/staging/r8188eu/core/rtw_cmd.c
index ce73ac7cf973..35e6a943c556 100644
--- a/drivers/staging/r8188eu/core/rtw_cmd.c
+++ b/drivers/staging/r8188eu/core/rtw_cmd.c
@@ -1669,11 +1669,6 @@ u8 rtw_antenna_select_cmd(struct adapter *padapter, u8 antenna, u8 enqueue)
 	return res;
 }

-static void power_saving_wk_hdl(struct adapter *padapter, u8 *pbuf, int sz)
-{
-	 rtw_ps_processor(padapter);
-}
-
 #ifdef CONFIG_88EU_P2P
 u8 p2p_protocol_wk_cmd(struct adapter *padapter, int intCmdType)
 {
@@ -1941,7 +1936,7 @@ u8 rtw_drvextra_cmd_hdl(struct adapter *padapter, unsigned char *pbuf)
 		dynamic_chk_wk_hdl(padapter, pdrvextra_cmd->pbuf, pdrvextra_cmd->type_size);
 		break;
 	case POWER_SAVING_CTRL_WK_CID:
-		power_saving_wk_hdl(padapter, pdrvextra_cmd->pbuf, pdrvextra_cmd->type_size);
+		rtw_ps_processor(padapter);
 		break;
 	case LPS_CTRL_WK_CID:
 		lps_ctrl_wk_hdl(padapter, (u8)pdrvextra_cmd->type_size);
--
2.32.0

