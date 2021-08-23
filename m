Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E6D3B3F53C7
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Aug 2021 01:50:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233362AbhHWXuw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Aug 2021 19:50:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233201AbhHWXuq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Aug 2021 19:50:46 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12BA6C061575
        for <linux-kernel@vger.kernel.org>; Mon, 23 Aug 2021 16:50:03 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id k8so28593018wrn.3
        for <linux-kernel@vger.kernel.org>; Mon, 23 Aug 2021 16:50:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=WlSzoC7+vYGsfYhRVPf9602RHAilsb/3ia2lRqV6Ta0=;
        b=tENuzhQMiSw5/A9fuaRYyuzQbcVXgmSz4/Zyirf09Ze+uEJZ2h/dBnuwlXYIbMHMIJ
         /7KRZktUpPHf7Cg7DB80Wwg38JPz4g3OE4eB6Q5gf4dFwV6Y+0bc+b0nQ3s7hCSNAmV9
         FVfncEJa4Ttho6GmUeNWA1xuKGtAlwGk1ublBrg/6Dk3sejx/zWCB7OCzTMQh/WxQd3r
         ugz0Ou8TD5ld08yT8uh2jgDthrlVMfdRmWis5pgQquTOL3H0MMi/QXx5bjcQfgLIXGun
         zVL1HYIvRA+CuTcqTAOrS8o3zRLiO1duCrQLE4u9yeSi/N1Yflu4ed63WCGt9InIxGt9
         ycmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=WlSzoC7+vYGsfYhRVPf9602RHAilsb/3ia2lRqV6Ta0=;
        b=MJ/ecIfw6I21TcHH5AflgnnWm8tPXqMgdefjhz9WPg4CTcLhKuCCEfMUab9Auzd9gZ
         dzCa4in97ZsXsSbfFT3DFOasbaU5sr3sIEo37vZ3La2TCkayzTEpPmOrXItJL1MI3CFw
         nU8+H8nrPsnHTShYW5183f3FchJC/nuevsPerfE0NbE1PMNhie8Ngwza5Sp6Kz10Kq0b
         7pRcFR57emX01aOX0E+Q0t0nww7bFSQ+sF/+w0U3gdQIAVLMYt9XZ5wF4zzAFFVuOoDM
         7odrn76KiqDK3jo3JIVIjhq5ZNPjcLJa1LoQCQUt4MIcdMG45nIFqfF1Op2D8PzBZHGH
         mYIQ==
X-Gm-Message-State: AOAM532PpCb+WOuuyK5j2CpjYey1IY/LQDGX9rgSPJRwEmG5qQf9BuSV
        NvG2qHytes6mvfu6zwoNMDI=
X-Google-Smtp-Source: ABdhPJyQwTRuk886qhJzb7vqBg+Mskg3FEEzM4Ur6ehoceQhDRMxYug0amLzI1xAy/TbmtOuHdR7CA==
X-Received: by 2002:adf:de83:: with SMTP id w3mr16449923wrl.342.1629762601700;
        Mon, 23 Aug 2021 16:50:01 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8108:96c0:3b88::687e])
        by smtp.gmail.com with ESMTPSA id r4sm562124wmq.34.2021.08.23.16.50.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Aug 2021 16:50:01 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk, martin@kaiser.cx,
        fmdefrancesco@gmail.com, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 0/2] staging: r8188eu: remove unneeded header files
Date:   Tue, 24 Aug 2021 01:48:56 +0200
Message-Id: <20210823234858.2633-1-straube.linux@gmail.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series removes the header files if_ether.h and ip.h as both just
duplicate in-kernel definitions.

Both patches were already sent as single patches but only the one or
the other can be applied due to conflicts, so I resend them in this
series.

Michael Straube (2):
  staging: r8188eu: remove if_ether.h header file
  staging: r8188eu: remove ip.h header file

 drivers/staging/r8188eu/core/rtw_recv.c      |   2 -
 drivers/staging/r8188eu/core/rtw_xmit.c      |   1 -
 drivers/staging/r8188eu/hal/rtl8188eu_recv.c |   2 -
 drivers/staging/r8188eu/include/if_ether.h   |  94 ----------------
 drivers/staging/r8188eu/include/ip.h         | 109 -------------------
 drivers/staging/r8188eu/os_dep/xmit_linux.c  |   2 -
 6 files changed, 210 deletions(-)
 delete mode 100644 drivers/staging/r8188eu/include/if_ether.h
 delete mode 100644 drivers/staging/r8188eu/include/ip.h

-- 
2.32.0

