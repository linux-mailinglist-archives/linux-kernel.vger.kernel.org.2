Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 295323FAB14
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Aug 2021 13:26:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235184AbhH2L1A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 Aug 2021 07:27:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235110AbhH2L07 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Aug 2021 07:26:59 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 291A1C061575
        for <linux-kernel@vger.kernel.org>; Sun, 29 Aug 2021 04:26:07 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id x2-20020a1c7c02000000b002e6f1f69a1eso12600356wmc.5
        for <linux-kernel@vger.kernel.org>; Sun, 29 Aug 2021 04:26:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Io8xO0I4IEBB9vVq6AY5ZVVzX55PtEN8u1vYr2NZxCM=;
        b=vao9VY4VlO9XySUqx4Dwg2sIPDmE1CPN0tM++A9Zhk2sSp/yic7WoIqfcjyJiSaBd4
         Fj4WNZfBIHwV8tQP+wFWfdBfF+XX2Avlt9bwkQuqXJ/MFmkGJhq7rcMJ2hvE63FVFIis
         SoL+5WXfJ4pqa7X3tySoISatx0ZVNbIw4noHEX0Ys5FVTo4KxwR2glvqOH5X5zMVrpLK
         B5TA7RVHvftMAVktGJuUea799TUpSLap/cebgejwQq+os44vJI81MVaedYBp6ZhLbbI5
         xdMVOVcFWS/lgygyWekXy2B+wXIeOCVd/5MiedWAu9TT2rUx//REjU8F4/cuFdAqnuxT
         YCvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Io8xO0I4IEBB9vVq6AY5ZVVzX55PtEN8u1vYr2NZxCM=;
        b=L8hSEhGrp0eY6JLTaOGGQFJEWXX1sPKA47PGJohhahF1OW5JEYfm7MbOr+X0/9Bxba
         yXh7kZkD83FNoBicVxlk5FzqeZD9Uv/xMgQIrP/fgAkuohzl4sonxHgSV8b2Uq2Ewj5i
         BBpBCaTeUcMZRJU0i4nu8J96eDWqpqV/ebRtbfecPZadiCg4mzdV0kR6eNQkPTcPzqx7
         yG6gwBBJ9/VFJQW52tTKlrEFX5OAPSbkL1ST6rxc1xPBp0ojoq8wuRQpbePs1+cRZGaf
         bEofCfiYXn1e8DwwgwQ4XRfHvoVUTpmCdiOTQ7j6tK+sPOJH+idwZrsJmImiidQ1U3sF
         DtFA==
X-Gm-Message-State: AOAM5337RBYKjfVxJwGRAy+PtwN63lpuNfUxQcM8pzMuRbyQIav4BVed
        o3TOHvvkvJBGLhMyqI0Uq3c=
X-Google-Smtp-Source: ABdhPJxznOGld6n7fDomSJ5/KFFe9dG71xxXjUI/K1zYz1bvzbJ7Ql4bPBYdywubpQKRMatJFy467g==
X-Received: by 2002:a05:600c:1457:: with SMTP id h23mr22177449wmi.143.1630236365339;
        Sun, 29 Aug 2021 04:26:05 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8108:96c0:3b88::16fa])
        by smtp.gmail.com with ESMTPSA id h8sm15826581wmb.35.2021.08.29.04.26.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Aug 2021 04:26:05 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk, martin@kaiser.cx,
        fmdefrancesco@gmail.com, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 0/3] staging: r8188eu: clean up unnecessary type casts
Date:   Sun, 29 Aug 2021 13:25:52 +0200
Message-Id: <20210829112555.8726-1-straube.linux@gmail.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series removes unnecessary type casts from de/encrypt functions
in core/rtw_security.c.

Tested with Inter-Tech DMG-02 adapter connected to a CCMP network.

Michael Straube (3):
  staging: r8188eu: convert type of second parameter of rtw_*_encrypt()
  staging: r8188eu: convert type of second parameter of rtw_*_decrypt()
  staging: r8188eu: remove unnecessary type casts

 drivers/staging/r8188eu/core/rtw_mlme_ext.c   |  2 +-
 drivers/staging/r8188eu/core/rtw_recv.c       |  6 +-
 drivers/staging/r8188eu/core/rtw_security.c   | 61 +++++++++----------
 drivers/staging/r8188eu/core/rtw_xmit.c       |  6 +-
 .../staging/r8188eu/include/rtw_security.h    | 12 ++--
 5 files changed, 42 insertions(+), 45 deletions(-)

-- 
2.32.0

