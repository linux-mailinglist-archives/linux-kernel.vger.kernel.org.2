Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 80BD733EED9
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Mar 2021 11:53:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230338AbhCQKwf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Mar 2021 06:52:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229989AbhCQKw3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Mar 2021 06:52:29 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D2C4C06174A
        for <linux-kernel@vger.kernel.org>; Wed, 17 Mar 2021 03:52:29 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id b2-20020a7bc2420000b029010be1081172so1027081wmj.1
        for <linux-kernel@vger.kernel.org>; Wed, 17 Mar 2021 03:52:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=7ZEmZdoNzTf0jQ1Rx3FYRD3InQh2pIlPzg/PoJOuS1A=;
        b=vGhqd8J/KOPvVcl54UKfueWhz/dmR19kbkBhnBbmE1ZP0xLMwmLG54v/oQfG9rTbIi
         mGDvgBwv1eSwbEePwnEFwqKt3R8VJWOLvmsvQtzh0fG1RjrgB2aCE9YoBc+wb0L39ihg
         HaA77dmjbmENhBTt04M96ddBTsuaT6YjpzKM1OzR2rFW7jw2ouTPsbwc3uiypGUhZGx/
         LT7UXjB6ce2hlrQthg+08DDXViWziOwlERwLaXNYYULIDmMcmDsJuBLZMctq04PTS3wK
         slv+NCI1ECxR0N+EbTIAeuv4HLlLUc6YVqlo+wrcupWIfNJBJ4qUvqCh5Xx9GbnH4Cwl
         3awQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7ZEmZdoNzTf0jQ1Rx3FYRD3InQh2pIlPzg/PoJOuS1A=;
        b=OK9z8SfJZN9F+VofZFdGiCd8ddI0JkY/VUiFcHKL6QkEU4iiK6Zs/6bwUO+lnuHdqT
         J0LGVWclmcfwNZSa/fWu9vBk2Rt4gB5JjtEtD0NOOHwU7BUPPcmIsH2cJVwPgwjqqHkw
         xnlmUXftiklHRLnJ2Nnr0kSY/bfu/nw91LY8ciqnrc/ZoIcPkgySl7eS5aQJfPtNdaQZ
         boZnDFLLd/iRdFPRgip+Fw0fE2bENnYqFeNMtJTJUkjWt82HU4FQYFUL/U51XzppMnw2
         LpK2wXDk9+JJZhNC+3ARTTY9c8v89ulQJBJvgF79WQ4v57PSwzWiU23jw15mO3FA7sFF
         P6Hg==
X-Gm-Message-State: AOAM530cAGMO6gxMUyDPISE/tyVYvZMNuIMa4n6H6HNMusuBOcSUxrFU
        6vyHlOnjha+dMJ6CUeaoFu8=
X-Google-Smtp-Source: ABdhPJzqR1Fv/5bJYHjRFxLg7ddyD6q0zfMkbWQa+WfG/ogOupuPRcnxqoC40LbMr6OSKPREfQA4/g==
X-Received: by 2002:a05:600c:4f44:: with SMTP id m4mr3035485wmq.175.1615978348153;
        Wed, 17 Mar 2021 03:52:28 -0700 (PDT)
Received: from agape ([5.171.81.191])
        by smtp.gmail.com with ESMTPSA id n1sm7855036wro.36.2021.03.17.03.52.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Mar 2021 03:52:27 -0700 (PDT)
From:   Fabio Aiuto <fabioaiuto83@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Fabio Aiuto <fabioaiuto83@gmail.com>
Subject: [PATCH] staging: rtl8723bs: remove unused code blocks completed
Date:   Wed, 17 Mar 2021 11:51:44 +0100
Message-Id: <20210317105144.3732-1-fabioaiuto83@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <YFHTpb6oSarirQJv@kroah.com>
References: <YFHTpb6oSarirQJv@kroah.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove related item in TODO list

-------------------------------------------------------

searched for other unused code blocks:

grep -r '^\(#ifdef \|#if defined(\|#ifndef \)CONFIG_' \
drivers/staging/rtl8723bs/

drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c:#if defined(CONFIG_PM)
drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c:#if defined(CONFIG_PM)
drivers/staging/rtl8723bs/os_dep/ioctl_linux.c:#if defined(CONFIG_WEXT_PRIV)
drivers/staging/rtl8723bs/include/drv_conf.h:#ifndef CONFIG_RTW_HIQ_FILTER
drivers/staging/rtl8723bs/include/autoconf.h:#ifndef CONFIG_WIRELESS_EXT

all blocks left are checked by existing defines.

Signed-off-by: Fabio Aiuto <fabioaiuto83@gmail.com>
---
 drivers/staging/rtl8723bs/TODO | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/staging/rtl8723bs/TODO b/drivers/staging/rtl8723bs/TODO
index 45065fd3fd5d..afa620ceb2d8 100644
--- a/drivers/staging/rtl8723bs/TODO
+++ b/drivers/staging/rtl8723bs/TODO
@@ -1,5 +1,4 @@
 TODO:
-- find and remove code blocks guarded by never set CONFIG_FOO defines
 - find and remove remaining code valid only for 5 GHz. Most of the obvious
   ones have been removed, but things like channel > 14 still exist.
 - find and remove any code for other chips that is left over
-- 
2.20.1

