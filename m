Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1CBE233D7AC
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Mar 2021 16:34:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237907AbhCPPe3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Mar 2021 11:34:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238089AbhCPPdX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Mar 2021 11:33:23 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABBABC061756
        for <linux-kernel@vger.kernel.org>; Tue, 16 Mar 2021 08:33:22 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id u16so10708111wrt.1
        for <linux-kernel@vger.kernel.org>; Tue, 16 Mar 2021 08:33:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=TdM1lN7kRe1YT/ljmmWFHK6v3XjvwZu7i3f7+t7L+TI=;
        b=jvEz2SC5IgW+7dXloe8HF3hJjVRlr4FhIJGug6VFYLiH5wubW1DMNVFp4IVgIEvxhk
         IUYUF7NdpJPo3lB3SRoTJPCUxAQxe6haQFfXjd3SdExlxN5XKC21wKDmfWSvsEFabwXi
         QEpjwqwpafoXTgq9Ese82uY2r9wwtAe25Ec0krp3YHNYDwT8AoEeFznB3WsfAgCE2KCX
         qtCK4o/vdvlF3Xl/T4Pb8tOa8g3GPkNyBqvygDFrHQLzQ9cb4GSFDrFxyjCY1bdazglZ
         r3u3D1PUq1i5hysB/V3NxrIMjwGq+MfVW28fLl1cc8iNzIE5K8yq4lAtLxtB/Uz4h5Vr
         EUMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=TdM1lN7kRe1YT/ljmmWFHK6v3XjvwZu7i3f7+t7L+TI=;
        b=YiRPugXV64zfCGYpa32XRE6r4F2eYpEJ4lp/cO5QziTfI3aowGcifG2YjyCekjzxCl
         H4UQO0Zfao9r7luu742ZM59ui54ZyiX6574D4kqZ9UHvMCa4NyQoCRZ8CpHqoKsmg6nT
         38XGzB6foDadJKWWt7dgk+WBWPW5y6dQUc1Q90Bweb0mJB88jnHPvHWrCP9B3bLboD3M
         CVr7FIhkUoZPy7P34TO+UwjlTjqH9Uwkb3Y8WMk3pkt5u8L3KyCcyAYxaQFuppt1Se43
         102kiq5LG01YKVy7MXnwjRtV5KE3EXLMoP6gCdzOTP08nb6G/UyM/Zmt24BlvApRPYiQ
         mvVg==
X-Gm-Message-State: AOAM532XcB830fJ0nuSfkg78A5TAtGK2RiAuLS9AVP3uHMSs4H2JV6Tw
        f9LeDV1ALcALO1FzN5wUUpg=
X-Google-Smtp-Source: ABdhPJyD62lAnwAa8rPeMIeLt/v/zeiYBe3Zy77KfY2GSUks+w0X548FMlxJQCIy0tfg0TiwygBfhw==
X-Received: by 2002:adf:e68e:: with SMTP id r14mr5480551wrm.273.1615908801530;
        Tue, 16 Mar 2021 08:33:21 -0700 (PDT)
Received: from agape.jhs ([5.171.72.71])
        by smtp.gmail.com with ESMTPSA id c16sm27488851wrs.81.2021.03.16.08.33.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Mar 2021 08:33:21 -0700 (PDT)
Date:   Tue, 16 Mar 2021 16:33:18 +0100
From:   Fabio Aiuto <fabioaiuto83@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: [PATCH 12/12] staging: rtl8723bs: remove unused code blocks
 conditioned by never set CONFIG_MULTI_VIR_IFACES
Message-ID: <dfc3cf4234dbe166a75068a8405b43be0070d375.1615907632.git.fabioaiuto83@gmail.com>
References: <cover.1615907632.git.fabioaiuto83@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1615907632.git.fabioaiuto83@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

remove conditional code blocks checked by unused
CONFIG_MULTI_VIR_IFACES

cleaning required in TODO file:

find and remove code blocks guarded by never set CONFIG_FOO defines

Signed-off-by: Fabio Aiuto <fabioaiuto83@gmail.com>
---
 drivers/staging/rtl8723bs/include/drv_types.h | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/staging/rtl8723bs/include/drv_types.h b/drivers/staging/rtl8723bs/include/drv_types.h
index 9c0e7b6946f8..30bf7fc0994d 100644
--- a/drivers/staging/rtl8723bs/include/drv_types.h
+++ b/drivers/staging/rtl8723bs/include/drv_types.h
@@ -196,9 +196,6 @@ struct registry_priv {
 	u8 RFE_Type;
 	u8  check_fw_ps;
 
-#ifdef CONFIG_MULTI_VIR_IFACES
-	u8 ext_iface_num;/* primary/secondary iface is excluded */
-#endif
 	u8 qos_opt_enable;
 
 	u8 hiq_filter;
-- 
2.20.1

