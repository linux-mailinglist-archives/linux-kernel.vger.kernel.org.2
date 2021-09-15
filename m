Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A7D7440C24C
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Sep 2021 11:02:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237063AbhIOJDk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Sep 2021 05:03:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236766AbhIOJDi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Sep 2021 05:03:38 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE6ADC061575
        for <linux-kernel@vger.kernel.org>; Wed, 15 Sep 2021 02:02:19 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id g16so2682389wrb.3
        for <linux-kernel@vger.kernel.org>; Wed, 15 Sep 2021 02:02:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=mqCyO1mG9ovNges4P3yiXDZD1penTas/8IEFz1KTDdI=;
        b=P17ld7iBxQ3i8w4fb/Ij9aE9sSXdPv2eKQQiOZwnyGvHbkOUmYO8YiKdcFlxp0UFVn
         l8nkMIqLjBxt1Kw82AqWsf5mx3ode/CSMiQkoIiXbTK2Q7yVfcaVUmkblXKBOdXjvE/N
         ZaEgEt3sSa2LI51hy4ZROc/BThUVd142muMbHK5WGBXeWPRiO9P7kIWJTTeQaM+wjvhk
         oEgO8iCRMqSh9R0/iKk7+UNx+M058ZCqeLnPamFci3Jo4TFSeinpsqV2l2of206UaRNH
         VLqXVFgkE9moT1yAXmnpnxCO1C8hTlHaCE/IDys1yHoAMhhG9mvjEqnu1/qi+HsQ6PFK
         m4YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=mqCyO1mG9ovNges4P3yiXDZD1penTas/8IEFz1KTDdI=;
        b=5aKeMtoJk+i6PFsyEtwiOC9aVt8uS5m1owpNfkf7XAQA2p+KrOonk0cOHesEfUShHr
         0Fo0BjsqDiFOK99PcQ1Vn/hR13GIszzUuSs4Cu3U15cL7WtCUvOqe79px6kIKRA7Ale2
         8M3rmdi3ep/96DsQq9cTC1F2Lbs2Dxm4aTQFADI/7+9Krj2DxgBbFJx1o8Hoc8I6bsPV
         OI/v8Au0kG4K/KgLOxp7FW2NHHAFBKzr9FHHqhf65HyJqrQYJihLMGiH94DSyMIZTRne
         p3GQOGyPcivh36juV0SCTdm6YfkeOSwP3+rCdBBmcr37rMYY004YNqRnoGF8cV3wYNtT
         2Ipw==
X-Gm-Message-State: AOAM532HSLtm6ndPAgqd+P/NG6lgYsrJAeul2IwHbwrTcZlqN8mGBW10
        uRxXeqMGxwAdH3YSw3RNVFLpQBDoUNe+8w==
X-Google-Smtp-Source: ABdhPJxAXDP3qv6YPXzvn7hHyTgu3aJUH3M6woXe70hweKKO1SvalSh4fCZtsmc4DIkJGPiY64lXqw==
X-Received: by 2002:a05:6000:1623:: with SMTP id v3mr3790400wrb.288.1631696537566;
        Wed, 15 Sep 2021 02:02:17 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8108:96c0:3b88::1db2])
        by smtp.gmail.com with ESMTPSA id n186sm3565530wme.31.2021.09.15.02.02.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Sep 2021 02:02:17 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk, martin@kaiser.cx,
        fmdefrancesco@gmail.com, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH v2 0/4] staging: r8188eu: remove unused fields from struct hal_data_8188e
Date:   Wed, 15 Sep 2021 11:01:52 +0200
Message-Id: <20210915090156.4169-1-straube.linux@gmail.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series removes some unused fields from struct hal_data_8188eu.

Tested on x86_64 with Inter-Tech DMG-02.

v1 -> v2
Fixed a typo in the subject line of patch 3/4.

Michael Straube (4):
  staging: r8188eu: remove unused macros from rtl8188e_hal.h
  staging: r8188eu: remove write-only fields from struct hal_data_8188e
  staging: r8188eu: remove unused enums from rtl8188e_hal.h
  staging: r8188eu: remove unused field from struct hal_data_8188e

 .../staging/r8188eu/hal/rtl8188e_hal_init.c   |  5 -----
 .../staging/r8188eu/include/rtl8188e_hal.h    | 22 -------------------
 2 files changed, 27 deletions(-)

-- 
2.33.0

