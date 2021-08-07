Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AAFE03E347D
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Aug 2021 11:49:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232125AbhHGJth (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 Aug 2021 05:49:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231916AbhHGJs4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Aug 2021 05:48:56 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7249DC0613CF
        for <linux-kernel@vger.kernel.org>; Sat,  7 Aug 2021 02:48:39 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id m28-20020a05600c3b1cb02902b5a8c22575so7554484wms.0
        for <linux-kernel@vger.kernel.org>; Sat, 07 Aug 2021 02:48:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=6SDVwAxo8MuHClJKgaVJAPWUKlCJYuiKpUSio+EsXf4=;
        b=gMS6SctLHDCRPcwWmcR+TmjFJveV434CNMBCOi9q71OTUw3SiaCW0MEAGoGSEDxw5f
         XYo1zIQ4HKaUVmBQvJxPmw256xes8VIzViUfnppzEhoo4+gYmyCLcdZLx3IAUrRQMTIP
         NZOUt9L9CSpvKEsm+kry1stXCbOdnZYZh0RYyiqymlS1yhSsBvmAcuBam+/2PUFWGiAi
         eGULh3aCHeQm6u9kGE1a29RNjTHLLGjBPYrLxNAY2i8jvFXWxGdQDcUPOOSpgaBnib+A
         EK4gxPIFTff9yCOuGuXvHO/vE+wR7XNt/SfCBYRJ/iWASeky1ECoH/dZIXLxqj0gVho8
         lPdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6SDVwAxo8MuHClJKgaVJAPWUKlCJYuiKpUSio+EsXf4=;
        b=I/5nsbPZTQogVHo54Hks2WX6RWnhidruF/HOe5hQcBGl2GFy4blQmfiZLn7ngHjpxm
         38e/ugSpAuKwJ7O3XOSjIIvkoMEbxveq6HGkFtm4GP3ZqoN9At1HhhHVaQ6YyjitgaUJ
         7Pm5TO8MSoG9Fdo8KGt7mRjKqzXII+JdB1kE8bViE/76wmqP8eOxbzjEyZddi7L54kPz
         xvoYEu+gHJ2EpsUeXuT85KRKlBYxI2KMHicwcTPtSBkPeXIGUrnSHuKLyfuE0VSSeEA8
         gX94Ikzc6nSFFMpOa7xs0YvZbr/zbzuIkF/2EctnBY3CpVMEmr5A6H6jJHOEdtafDAZ3
         xFWA==
X-Gm-Message-State: AOAM5318mM/YmxUdRAyYnnGOYoAxFP3xWtpFb8yygXwYqUuKLdMiqSed
        JqvLwwbIEPcj2gBZ33rV84IyGlhWiZ0=
X-Google-Smtp-Source: ABdhPJxmJLXuCSsatnpHPIZpX4tl0hFbZodDj/NY74F7Lw0zONQN3VAoXEbdBdeLKLToRH5t9Afinw==
X-Received: by 2002:a05:600c:4b86:: with SMTP id e6mr24184388wmp.110.1628329718022;
        Sat, 07 Aug 2021 02:48:38 -0700 (PDT)
Received: from agape ([5.171.80.112])
        by smtp.gmail.com with ESMTPSA id d9sm1809720wrw.26.2021.08.07.02.48.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Aug 2021 02:48:37 -0700 (PDT)
From:   Fabio Aiuto <fabioaiuto83@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     hdegoede@redhat.com, Larry.Finger@lwfinger.net,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 17/21] staging: rtl8723bs: remove unused macro in include/hal_data.h
Date:   Sat,  7 Aug 2021 11:48:09 +0200
Message-Id: <13b4f41247d1b8bc10f0576d82e4dc9a285d88e1.1628329348.git.fabioaiuto83@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1628329348.git.fabioaiuto83@gmail.com>
References: <cover.1628329348.git.fabioaiuto83@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

remove unused macro in include/hal_data.h

Signed-off-by: Fabio Aiuto <fabioaiuto83@gmail.com>
---
 drivers/staging/rtl8723bs/include/hal_data.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/staging/rtl8723bs/include/hal_data.h b/drivers/staging/rtl8723bs/include/hal_data.h
index f0b26e44f9b9..2bd7a7151db1 100644
--- a/drivers/staging/rtl8723bs/include/hal_data.h
+++ b/drivers/staging/rtl8723bs/include/hal_data.h
@@ -404,6 +404,5 @@ struct hal_com_data {
 #define GET_HAL_DATA(__padapter)	((struct hal_com_data *)((__padapter)->HalData))
 #define GET_HAL_RFPATH_NUM(__padapter) (((struct hal_com_data *)((__padapter)->HalData))->NumTotalRFPath)
 #define RT_GetInterfaceSelection(_Adapter)	(GET_HAL_DATA(_Adapter)->InterfaceSel)
-#define GET_RF_TYPE(__padapter)		(GET_HAL_DATA(__padapter)->rf_type)
 
 #endif /* __HAL_DATA_H__ */
-- 
2.20.1

