Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 93D6F34473C
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Mar 2021 15:32:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230476AbhCVOcP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Mar 2021 10:32:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230357AbhCVOcE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Mar 2021 10:32:04 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BD63C061574
        for <linux-kernel@vger.kernel.org>; Mon, 22 Mar 2021 07:32:04 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id bf3so19634588edb.6
        for <linux-kernel@vger.kernel.org>; Mon, 22 Mar 2021 07:32:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=W1CrrVQQfCM8oSgODUTN/4xbiArLi1X7MNgfBQ1mnN0=;
        b=O9AZ9jQIbmGFs2zt0vKwAZiZefUlw7T7LkI+mJwbIbe0VQH+y9CLo5zOBVYU7rXLOg
         jNIMqVGWoiHuH01MC+NBcJ798yjq4HDe/ZocOAEq6hbYex8UTpZMcf9bF6ovALp92ZIc
         ECz07ohHkFm6ZtljEX/XfQuBtadxwuF9l2S5/aTTfPKIevx1kvywFVYGbWEegN7C+Ilu
         eJZ/CNWq8V8MmfljfMWCbb2AtAkKNrRD2i0t5RaF7N+obK6HRvDndPIvXtHvmGGH+ol/
         goT60/aOr9ZaK8s0mlXiqwU+vDYyesUTW8vApB0SQ8GVB9IiWr2tA9KB608uwVRBV2PZ
         LeJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=W1CrrVQQfCM8oSgODUTN/4xbiArLi1X7MNgfBQ1mnN0=;
        b=cHroHe49C0ne15ox6POn2MkS862+39RG2mrjKWfNUlwXPFpetdWlLblPdgclI0QQi8
         PbmFVDpd8hxviYg2TipuGr3SPe64UMAVWFqEqLQT9ljL/a61Fj6fO4ZTaCQMyK1Cz3EE
         8Idf4W/tJ4eK6C2VRKr7oqN8+8kJv9ABSBBxydYG2YdCboI6oVxvHNstnZ//20Ei3T9R
         f6oN9ZCCr5vhfvh76kNUinFNjCnutUzpqhSX4nmpCmQ49momWw/OKtlw2RHGmlQdG/+K
         co5FEvasYaWiE1ENV7y8/YpeoCe/Tro63RK2l7PTrKBmsyN2ROOEmayIwnpg7R3hTRs3
         GAkw==
X-Gm-Message-State: AOAM531L7BhZpY252juo9PjKWDoY64A12qUWeiK697F0xfDx0hNA0s2F
        fJXkF0SDzotb/YMLJ6RXFsA=
X-Google-Smtp-Source: ABdhPJy1CaFLoy2jBvBzDg/xv0rkaByD2eGzXIsDVKKSWGBEzdDhrAkw9n0++Y5uscvGIDcLA1ySKQ==
X-Received: by 2002:aa7:da04:: with SMTP id r4mr26189361eds.343.1616423523117;
        Mon, 22 Mar 2021 07:32:03 -0700 (PDT)
Received: from agape ([151.57.176.11])
        by smtp.gmail.com with ESMTPSA id de17sm9686534ejc.16.2021.03.22.07.32.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Mar 2021 07:32:02 -0700 (PDT)
From:   Fabio Aiuto <fabioaiuto83@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     joe@perches.com, apw@canonical.com, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, Fabio Aiuto <fabioaiuto83@gmail.com>
Subject: [PATCH 00/11] staging: rtl8723bs: fix extern declaration checkpatch issues
Date:   Mon, 22 Mar 2021 15:31:38 +0100
Message-Id: <cover.1616422773.git.fabioaiuto83@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <YFbvwZjwMa4mPsn8@kroah.com>
References: <YFbvwZjwMa4mPsn8@kroah.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix extern declaration issues warned by checkpatch

Fabio Aiuto (11):
  staging: rtl8723bs: delete extern declarations in core/rtw_ap.c
  staging: rtl8723bs: moved function prototypes out of core/rtw_efuse.c
  staging: rtl8723bs: moved function prototype out of
    core/rtw_ioctl_set.c and core/rtw_mlme.c
  staging: rtl8723bs: moved function prototypes out of core/rtw_recv.c
  staging: rtl8723bs: remove argument in recv_indicatepkts_pkt_loss_cnt
  staging: rtl8723bs: move function prototype out of core/rtw_recv.c
  staging: rtl8723bs: delete extern declarations in core/rtw_wlan_util.c
  staging: rtl8723bs: move function prototypes out of hal/odm.c
  staging: rtl8723bs: move function prototypes out of os_dep/int_fs.c
  staging: rtl8723bs: remove undefined function prototype in of
    os_dep/sdio_intf.c
  staging: rtl8723bs: remove unnecessary extern in os_dep/sdio_intf.c

 drivers/staging/rtl8723bs/core/rtw_ap.c       |  5 --
 drivers/staging/rtl8723bs/core/rtw_efuse.c    | 10 ---
 .../staging/rtl8723bs/core/rtw_ioctl_set.c    |  1 -
 drivers/staging/rtl8723bs/core/rtw_mlme.c     |  2 -
 drivers/staging/rtl8723bs/core/rtw_recv.c     | 41 ++---------
 .../staging/rtl8723bs/core/rtw_wlan_util.c    |  3 -
 drivers/staging/rtl8723bs/hal/odm.c           | 68 -------------------
 drivers/staging/rtl8723bs/hal/odm.h           | 62 +++++++++++++++++
 .../staging/rtl8723bs/include/osdep_intf.h    |  3 +
 drivers/staging/rtl8723bs/include/rtw_efuse.h |  3 +
 .../staging/rtl8723bs/include/rtw_ioctl_set.h |  2 +
 drivers/staging/rtl8723bs/include/rtw_recv.h  | 53 +++++++++++++++
 drivers/staging/rtl8723bs/os_dep/os_intfs.c   |  3 -
 drivers/staging/rtl8723bs/os_dep/sdio_intf.c  |  3 -
 14 files changed, 129 insertions(+), 130 deletions(-)

-- 
2.20.1

