Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 442CA3539F6
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Apr 2021 23:04:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231562AbhDDUwH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 4 Apr 2021 16:52:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230286AbhDDUwB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Apr 2021 16:52:01 -0400
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FAAEC061756
        for <linux-kernel@vger.kernel.org>; Sun,  4 Apr 2021 13:51:55 -0700 (PDT)
Received: by mail-lj1-x22e.google.com with SMTP id z8so10793161ljm.12
        for <linux-kernel@vger.kernel.org>; Sun, 04 Apr 2021 13:51:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=nd2uOMxAh5X4a/nY+KPVcgXpJ+Zppj7YeUaSujV7w+E=;
        b=q42M4a3ki91Ecw3m+TFxNzm+HK46z6MYd8UeYQSI8qzPU0LKX8smzmYn+VS8qNXyBf
         MUJEV8WEXLgE/nz+QAotTlNh8ZeuqGtZWZ/hH9H0FX7ymD7ObTmxEJfgUVq8zdx/2mkG
         4BJjcWOIp5zch/A0CMVOHZOBw2YA6z0G/fmZd5mNSHOOUqlqHvGdr4ugNmDveee19SbY
         EueX+XYsk131jzy6+ZGMmsNPBxLky2kHeh0K3iKO6qJzt/7g1nVm7pEseSRleYCrTmou
         MGBGJm6d/tYCv77DuQt2KxIA9cacZb5DRHBVNYiqw55OJaFH8bbztOayhAMgxv4NflP7
         tviA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=nd2uOMxAh5X4a/nY+KPVcgXpJ+Zppj7YeUaSujV7w+E=;
        b=Z4Ulgdb5pBj0DkKmO9TduaRtvm4jGNdvxhDyJ4zDpW4A30sCHgu7q+lpPKM4uVOW09
         U4rc1y6AJk+peJTCojJ9fmCjHSLSqRCJsJeHHh6M2J85xEag23FTS+H8XaP1/Mbqbv+S
         RJKeMt2PmSbhfs2Rp8h0tmTLbjCprsbL9vvcL+p4CKTQVoUsXUn9eI80OUjcX1JkN2er
         P83QG26ApPZxWSWNszSdahVmdBIcWTNYF2skUMx5cGHaHy5xulIknjVZfiCa05JiIMfQ
         AO8fcDFvHqvNQUXndCDOqEHa8VAijIA5G4HxxIKWKE6WBSR1TTb1F1OpDOsdTiWySIpI
         d+vQ==
X-Gm-Message-State: AOAM530woG7njQSYwaaEEgvN0JgHBf88pqOcMrMbCZ1tZob+ToeLwFJM
        Pxj8lYAN7PNvOFwBFidSasw=
X-Google-Smtp-Source: ABdhPJwYjg/AbYdzaP6/dh2LxXbEpTxXmVOVDwF1+jNLsypxJTuaG6InH7aDkNMdMZmm3HHkY3cfcg==
X-Received: by 2002:a2e:b178:: with SMTP id a24mr14114441ljm.329.1617569513722;
        Sun, 04 Apr 2021 13:51:53 -0700 (PDT)
Received: from zhans ([37.151.32.231])
        by smtp.gmail.com with ESMTPSA id x17sm1546124lfg.164.2021.04.04.13.51.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Apr 2021 13:51:53 -0700 (PDT)
Date:   Mon, 5 Apr 2021 02:51:51 +0600
From:   Zhansaya Bagdauletkyzy <zhansayabagdaulet@gmail.com>
To:     Larry.Finger@lwfinger.net, florian.c.schilhabel@googlemail.com,
        gregkh@linuxfoundation.org
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        outreachy-kernel@googlegroups.com
Subject: [PATCH 0/2] staging: rtl8712: add blank lines after declarations and
 remove extra blank lines
Message-ID: <cover.1617568354.git.zhansayabagdaulet@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset adds blank lines after function/struct/union/enum declarations and removes extra blank lines.
Reported by checkpatch.

Zhansaya Bagdauletkyzy (2):
  staging: rtl8712: add blank lines after declarations
  staging: rtl8712: remove extra blank lines

 drivers/staging/rtl8712/rtl8712_recv.h     |  2 +-
 drivers/staging/rtl8712/rtl871x_cmd.h      | 10 ++++++++++
 drivers/staging/rtl8712/rtl871x_event.h    |  1 +
 drivers/staging/rtl8712/rtl871x_mlme.c     |  3 ---
 drivers/staging/rtl8712/rtl871x_mp.c       |  1 +
 drivers/staging/rtl8712/rtl871x_mp.h       |  1 +
 drivers/staging/rtl8712/rtl871x_mp_ioctl.c |  3 +++
 drivers/staging/rtl8712/rtl871x_pwrctrl.h  |  3 ---
 drivers/staging/rtl8712/rtl871x_recv.c     |  1 +
 drivers/staging/rtl8712/rtl871x_recv.h     |  1 -
 10 files changed, 18 insertions(+), 8 deletions(-)

-- 
2.25.1

