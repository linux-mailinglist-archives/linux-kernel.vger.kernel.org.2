Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B7FEC33A3B5
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Mar 2021 10:05:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235021AbhCNJEZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 Mar 2021 05:04:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230482AbhCNJDn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Mar 2021 05:03:43 -0400
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A35DAC061574
        for <linux-kernel@vger.kernel.org>; Sun, 14 Mar 2021 01:03:42 -0800 (PST)
Received: by mail-lj1-x230.google.com with SMTP id 16so12629720ljc.11
        for <linux-kernel@vger.kernel.org>; Sun, 14 Mar 2021 01:03:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=X8n4cikQJdHTIiRxlL6pQYUz7x1I5c7q0U0cLWIHRy4=;
        b=KqWgI/G6Xa7DX7SPRHyjRYVfDTeqsVaVQPKSn777bpuBc33MXF7vbB0cADsrOhcfkz
         2WZLhI+nr6NxAH1cEnuQHz47oWYE6a2cJ7r+Rra8h4dt43kpggypxMjXavSEpzHQYXlU
         WBfgyuUVc9jXLVqVEKBxXnhtJmj5hf5DEzboNX1XpsgiwZnos26FcvJbZVpf5pQwO2jh
         hrfJQa2aBWZw05Nhs3y/SYQkwyOp6ncDwgVcZvGAM4PlrROfIfrfWljvnWra7+ZJryOW
         K1bp4ITWbm9Zi1Rzh50/2qLr2PJdrx8ueP1tdzpAv9ZH80kxLiEhymcrp03X3iFE/lCp
         Bc+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=X8n4cikQJdHTIiRxlL6pQYUz7x1I5c7q0U0cLWIHRy4=;
        b=mQwzEUdQ3j9z6YD4XMC35862P/qEYnujyVbJvSPa2lVoXyscOG83c9/obK2MtALR7W
         eLHw128cddTpVlb2JKjtmUT7U//TEQvD9rhjA4k3Lpc2jOkVA3AibcZxjXyuLj/2PxKu
         YQ0M9o9mAHPTZ2pXzF8KoDh5fOGHc8+2Quo4c9VlCiMxKH5Tz1V/2zdHje6IZUi+W8YB
         uQ0FoO6/7J9zGBQJCCW57eWkaGdiUXIwVQS2iO6wkGUSyPCHuybwv/9+jjxP0qDWdaP6
         yysTOiDZ/Eq5Uv5l1Ii82C6IlyUtYIK2tvm2rVcbCx7bfaSDZ+6Xs0Ym4sy7fKK9DZXh
         b0SA==
X-Gm-Message-State: AOAM532hMy2+nVZc72i6RKEAI1s0WvKppNPYv6SERUvQw8jL+M2j7p02
        19VKQinMmwMPPLMb8XXkFmw=
X-Google-Smtp-Source: ABdhPJwBLsagmfK7HJUQZkVc1/tNtDamblgfF9hZ8n8IiOYyJcLHPtAsde4BauAuhaNIpqkjOwOfiw==
X-Received: by 2002:a2e:88cc:: with SMTP id a12mr7258686ljk.402.1615712619300;
        Sun, 14 Mar 2021 01:03:39 -0800 (PST)
Received: from alpha (10.177.smarthome.spb.ru. [109.71.177.10])
        by smtp.gmail.com with ESMTPSA id p5sm2541096ljj.26.2021.03.14.01.03.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Mar 2021 01:03:38 -0800 (PST)
Received: (nullmailer pid 21227 invoked by uid 1000);
        Sun, 14 Mar 2021 09:03:26 -0000
From:   Ivan Safonov <insafonov@gmail.com>
To:     Larry Finger <Larry.Finger@lwfinger.net>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Brooke Basile <brookebasile@gmail.com>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Michael Straube <straube.linux@gmail.com>,
        Mrinal Pandey <mrinalmni@gmail.com>,
        Peilin Ye <yepeilin.cs@gmail.com>,
        Shreeya Patel <shreeya.patel23498@gmail.com>,
        Simon Fong <simon.fodin@gmail.com>, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, Ivan Safonov <insafonov@gmail.com>
Subject: [PATCH 0/4] staging:r8188eu: remove unnecessary definitions from wifi.h
Date:   Sun, 14 Mar 2021 12:02:43 +0300
Message-Id: <20210314090247.21181-1-insafonov@gmail.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

wifi.h contains unnecessary definitions. Some of them are not used
at all, some can be replaced with native definitions.

Ivan Safonov (4):
  staging:r8188eu: replace get_(d|s)a with ieee80211_get_(D|S)A
  staging:r8188eu: remove unused definitions from wifi.h
  staging:r8188eu: replace cap_* definitions with native kernel
    WLAN_CAPABILITY_*
  staging:r8188eu: use ieee80211_is_ctl instead IsFrameTypeCtrl

 .../staging/rtl8188eu/core/rtw_ieee80211.c    |   6 +-
 drivers/staging/rtl8188eu/core/rtw_mlme_ext.c |  12 +-
 drivers/staging/rtl8188eu/core/rtw_recv.c     |   4 +-
 .../staging/rtl8188eu/hal/rtl8188e_rxdesc.c   |   8 +-
 drivers/staging/rtl8188eu/include/wifi.h      | 156 ------------------
 5 files changed, 16 insertions(+), 170 deletions(-)

-- 
2.26.2

