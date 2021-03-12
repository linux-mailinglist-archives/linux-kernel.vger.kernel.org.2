Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 37F76338740
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Mar 2021 09:25:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232206AbhCLIYj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Mar 2021 03:24:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231659AbhCLIYK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Mar 2021 03:24:10 -0500
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BAF0C061574
        for <linux-kernel@vger.kernel.org>; Fri, 12 Mar 2021 00:24:09 -0800 (PST)
Received: by mail-wm1-x32b.google.com with SMTP id g20so3250406wmk.3
        for <linux-kernel@vger.kernel.org>; Fri, 12 Mar 2021 00:24:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+QMJTUk4YqaFrTwIRMZ6sWpJbYfvw2gdjapEd5fgWkE=;
        b=qvfh72SGDJPsNuSgzMWHq7AlOB6oPhvfhWFvFxN0Tnfu1MXkka61qOV8ZF9VQ34QOr
         /GaRvka6O2ZXjpOvvUQusNqIW3/oGExyXpIJA5rRjPCyE31TL7y2BanjaCLQLqTOhl4u
         fvfgGGJhD8yfe+JNPavwlY3mmXWvAJc29D3EqCdMAkEY3GTkj54L8nfBqant3x68DZmk
         Xs8H6ceiGabADmK5+T/bKxDSyASiw028pdchgpVMVXTfblouJt1/avC1W/pN3qAoi+YD
         Oo/h+9BOTQb1xySLnbHEGz7+1ROF4kPCdC5TaH96SDYX6d7Yb6mrNY5Ooh+DrKiyUvjB
         s39w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+QMJTUk4YqaFrTwIRMZ6sWpJbYfvw2gdjapEd5fgWkE=;
        b=WdRxBMMHe7P0ZMSxpXbyNBw5AAR5qpWSLBshNPhfwFgh/HytYRGWjmfCzwugdCrFlF
         jkyVBEH0JDpfxvUCIyia0IdjIUd/tJKQx2iwz26NmI7dWm5pqGMNfV3pTE0gS3wCYWp0
         yFQt5aR3MTSRum6jd+kRdpFFIi0W9wGDLE/kB6Ewooq7kbPTC3gEWomyWPoK+DGr43FU
         lUq7DpKpeQoTs3DywkUxxRQdHYbTgFVAhDUnrv2pi4miI7VASzLri1Wzs/jyA8iPRuxj
         YpZ8oduKASUWGzXV70YxC3y3k1vMdN/wmE+kWXrX9X6GXk/G5aKd2jpMoqz1LFXA0j9S
         mntQ==
X-Gm-Message-State: AOAM531+wag+PhTrol5ZtYgW7m+SDPz9/3YJ/WA2DHx6hoEkoe3i9lPD
        FHKRBZ6yonUv0vZNqz6o3/A=
X-Google-Smtp-Source: ABdhPJxRgGVSs8cBXd5cDWXq1ZtuTdHER3IFJznWGsb8MFjRA6poYlmpi6rDdg/gGMlvkwUCU9SLZg==
X-Received: by 2002:a7b:cc84:: with SMTP id p4mr11991982wma.10.1615537448180;
        Fri, 12 Mar 2021 00:24:08 -0800 (PST)
Received: from gimli.cesven (93-48-145-141.ip257.fastwebnet.it. [93.48.145.141])
        by smtp.gmail.com with ESMTPSA id l21sm1334483wmg.41.2021.03.12.00.24.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Mar 2021 00:24:07 -0800 (PST)
From:   Marco Cesati <marcocesati@gmail.com>
X-Google-Original-From: Marco Cesati <marco.cesati@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Larry Finger <Larry.Finger@lwfinger.net>,
        linux-kernel@vger.kernel.org
Subject: [PATCHSET] Remove 153 typedefs in staging/rtl8723bs
Date:   Fri, 12 Mar 2021 09:23:27 +0100
Message-Id: <20210312082359.24266-1-marco.cesati@gmail.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This set of patches remove 153 useless typedef instructions in the
staging/rtl8723bs source code, as identified by the checkpatch.pl
script. Every patch is purely syntactical: it does not change the
generated machine code. Furthermore, every single patch leaves the
source code fully compilable, so that 'git bisect' will not be affected.

[PATCH 01/33] staging: rtl8723bs: remove typedefs in HalBtcOutSrc.h
[PATCH 02/33] staging: rtl8723bs: remove typedefs in rtw_mlme.h
[PATCH 03/33] staging: rtl8723bs: remove typedefs in odm.h
[PATCH 04/33] staging: rtl8723bs: remove typedefs in odm_CfoTracking.h
[PATCH 05/33] staging: rtl8723bs: remove typedefs in odm_NoiseMonitor.h
[PATCH 06/33] staging: rtl8723bs: remove typedefs in odm_interface.h
[PATCH 07/33] staging: rtl8723bs: remove typedefs in odm_EdcaTurboCheck.h
[PATCH 08/33] staging: rtl8723bs: remove typedefs in odm_HWConfig.h
[PATCH 09/33] staging: rtl8723bs: remove typedefs in odm_types.h
[PATCH 10/33] staging: rtl8723bs: remove typedefs in rtw_eeprom.h
[PATCH 11/33] staging: rtl8723bs: remove typedefs in hal_com.h
[PATCH 12/33] staging: rtl8723bs: remove typedefs in drv_types.h
[PATCH 13/33] staging: rtl8723bs: remove typedefs in rtw_ht.h
[PATCH 14/33] staging: rtl8723bs: remove typedefs in rtw_ioctl_set.h
[PATCH 15/33] staging: rtl8723bs: remove typedefs in wlan_bssdef.h
[PATCH 16/33] staging: rtl8723bs: remove typedefs in rtw_mp.h
[PATCH 17/33] staging: rtl8723bs: remove typedefs in osdep_service.h
[PATCH 18/33] staging: rtl8723bs: remove typedefs in rtw_security.h
[PATCH 19/33] staging: rtl8723bs: remove typedefs in hal_com_h2c.h
[PATCH 20/33] staging: rtl8723bs: remove typedefs in rtl8723b_xmit.h
[PATCH 21/33] staging: rtl8723bs: remove typedefs in HalVerDef.h
[PATCH 22/33] staging: rtl8723bs: remove typedefs in rtl8723b_hal.h
[PATCH 23/33] staging: rtl8723bs: remove typedefs in rtw_mlme_ext.h
[PATCH 24/33] staging: rtl8723bs: remove typedefs in HalPwrSeqCmd.h
[PATCH 25/33] staging: rtl8723bs: remove typedefs in sta_info.h
[PATCH 26/33] staging: rtl8723bs: remove typedefs in ieee80211.h
[PATCH 27/33] staging: rtl8723bs: remove typedefs in basic_types.h
[PATCH 28/33] staging: rtl8723bs: remove typedefs in osdep_service_linux.h
[PATCH 29/33] staging: rtl8723bs: remove typedefs in rtw_efuse.h
[PATCH 30/33] staging: rtl8723bs: remove typedefs in hal_btcoex.h
[PATCH 31/33] staging: rtl8723bs: remove typedefs in odm_DIG.h
[PATCH 32/33] staging: rtl8723bs: remove typedefs in hal_btcoex.c
[PATCH 33/33] staging: rtl8723bs: remove typedefs in odm_DynamicBBPowerSaving.h

Signed-off-by: Marco Cesati <marco.cesati@gmail.com>



