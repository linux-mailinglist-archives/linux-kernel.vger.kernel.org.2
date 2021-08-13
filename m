Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A001E3EB185
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Aug 2021 09:32:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239439AbhHMHc2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Aug 2021 03:32:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238816AbhHMHc2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Aug 2021 03:32:28 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 894DBC061756
        for <linux-kernel@vger.kernel.org>; Fri, 13 Aug 2021 00:32:01 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id f5so11916158wrm.13
        for <linux-kernel@vger.kernel.org>; Fri, 13 Aug 2021 00:32:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=YhM3/UTYz8dk2sZhZpZTt6st98MzOChtEhO/bHLaAHg=;
        b=GAED6S7AkBJXCV/TQx04ArgCnRr8eWa4lxo3X2wfeSnhw0mistR2xpnCMd3idw9fxY
         7iQZIIk+slLq9a8+4jhuphW3EtoO2opL7tX9sveSnoaKop2/rqPFzr/xISdHZ29x376v
         5q1xYOMcPV88hos0872fOx/MrvGY1G8y7mPhGsjIzqir+lQW1+pJsngoHkAjKt1cOowl
         Ep3Ds6CokxyGor/i77Y7OnuJdffk6bjOBONfurTLmyt+Z7zayYk41BOexqfKADE3EWMr
         p1GVHGcwTTqDNXM9vVTTQetJ+EdIcS/WyCaFD1S/caWLeVdP5m/MofXUWwd6f0H3JN/l
         cIKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=YhM3/UTYz8dk2sZhZpZTt6st98MzOChtEhO/bHLaAHg=;
        b=kdno44nLt3XiSPjcH5M7VHmLGHtr1zhD5Azif6KYWYt7bt4Z5xhxDKF2HqO4RB/sxF
         ryL7I/N1gsUq3QixoQQM/gy47tSq6y1KvjbpUnzTqCF86BG6LPeP9fA+RjJA0mKotHRr
         62x2E4eGX7776P/x8ABa3N31Si3LT5LVQA+JjcV5RuuhUtJL76Ub/HNSrvzfuQGBdPEg
         LfSA1XDy3EDlgMzAMM8bdJrUP8IMEd3+y/FF1aUVWxLXVhtNx8HztBy8fOYoU2Nwpmw4
         TOhLYpnmeZeteWfDdpVBlUfLWEgrAp9cQffkRCE+AO8ydwb0Mr3C/bACJRSTwl7xTi2k
         dkXg==
X-Gm-Message-State: AOAM533dTw46uFAs025lSGhrDX0wZjN4afi7626xipu4H0VdEpNOW8uz
        SGBqcKvRz6J+J4q7kWJ8xi8=
X-Google-Smtp-Source: ABdhPJx8BsxU6DfJINDtdlyeWIgRdFDxAh0rYxwdF+2TYDObmkCGYC2XAM6vKhd+LrRc/bvyo9piaQ==
X-Received: by 2002:a5d:4d12:: with SMTP id z18mr1421138wrt.195.1628839920023;
        Fri, 13 Aug 2021 00:32:00 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8108:96c0:3b88::2571])
        by smtp.gmail.com with ESMTPSA id k12sm697406wrd.75.2021.08.13.00.31.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Aug 2021 00:31:59 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk, martin@kaiser.cx,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 0/4] staging: r8188eu: refactor Hal_GetChnlGroup88E()
Date:   Fri, 13 Aug 2021 09:31:05 +0200
Message-Id: <20210813073109.25609-1-straube.linux@gmail.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series refactors Hal_GetChnlGroup88E().
 - removes 5GHz code
 - changes return type to void
 - cleans up camel case naming

Michael Straube (4):
  staging: r8188eu: remove 5GHz code from Hal_GetChnlGroup88E()
  staging: r8188eu: convert return type of Hal_GetChnlGroup88E() to void
  staging: r8188eu: rename parameter of Hal_GetChnlGroup88E()
  staging: r8188eu: rename Hal_GetChnlGroup88E()

 .../staging/r8188eu/hal/rtl8188e_hal_init.c   | 90 ++++++-------------
 1 file changed, 26 insertions(+), 64 deletions(-)

-- 
2.32.0

