Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE142400BC7
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Sep 2021 17:05:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233473AbhIDPFz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Sep 2021 11:05:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230039AbhIDPFy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Sep 2021 11:05:54 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04E68C061575
        for <linux-kernel@vger.kernel.org>; Sat,  4 Sep 2021 08:04:53 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id i21so4072434ejd.2
        for <linux-kernel@vger.kernel.org>; Sat, 04 Sep 2021 08:04:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=P7GqOoj/G1bVSV52xZTKKhDlmKWWb1exvuS27GdN4bo=;
        b=c4B2Tsxa4gkb2PFRWZ6FRPEDtDh7uMSENgvMOJ3Wp4joLiSb6A3qTHhpPZXb5ry4Ir
         FSfqMtE0cJQ3haCj2Wh69QlXIoWCVlJuqU+0oByjcg37QiGkEoe1+cDr1uoUAXJryLSL
         /7oYVg9Iof8znH8vZZT255mzsXvbXLyMLrbyGG1kdW2YXkkxdwPqJMHA5Dwz5n8yfkN9
         WJvrTW+3k75N+cgN3WjoKq+DLuhDLtdPJE2Fy5zClQqmaKVv23pXEIQ/7XhWF8n4wfmq
         YQsnJL8uCRot+EPq6+6RZKP9iR+jsdwHlzw+RLfRgRWFYJZK15TP3E7XLq1vU3Qe/ELN
         yR8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=P7GqOoj/G1bVSV52xZTKKhDlmKWWb1exvuS27GdN4bo=;
        b=QQ4gotPDq9BQzW+rQI8IVPuxFvR5716xHmx9HECS437iFL70DR5OzAhy7mywiMNCMW
         FCo7tUFEJJglQVg2PeAYLiU8ovsbWntzVjL+2b8prSEsLSsw+kLbezPZfhri11iBLdBn
         oMbpo8R4ZFOp/uPgPP0S6WEVlk3Kw9eArFbHii7Xeb7J2OHdq+RdW00q/NGOvpc9FfQ0
         ciTY8gpqdHGr1Wp5inUs78ALH1UV3ZhOVqKN1Kvx5Tn2jLZeoGUzFgIJE9UobBzgRGGO
         uNFADZfe2PrcbtVDwI/sO2MgkTVdqZYxxel1m3SMnuovZXeAW3TOi4JYe33Ki1T2Lsbb
         wRwA==
X-Gm-Message-State: AOAM5305YxruNiArY+4ObKvx33VS8R1NHzrtXxbZ0iJ2GEDg3h79Up05
        ylts/Ig/1Twk/baV0mFMQLE=
X-Google-Smtp-Source: ABdhPJzvv1M5hI8rf8nKLDFn1iJAeDH1TomuaOn7/UecbFVI2PglWj7ac8rOGUJzIJD4Eh+mQ3SajQ==
X-Received: by 2002:a17:907:7752:: with SMTP id kx18mr4654691ejc.276.1630767891632;
        Sat, 04 Sep 2021 08:04:51 -0700 (PDT)
Received: from localhost.localdomain (host-79-23-101-208.retail.telecomitalia.it. [79.23.101.208])
        by smtp.gmail.com with ESMTPSA id da16sm1463452edb.28.2021.09.04.08.04.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Sep 2021 08:04:51 -0700 (PDT)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Cc:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
Subject: [PATCH 0/3] staging: r8188eu: Shorten and simplify calls chain 
Date:   Sat,  4 Sep 2021 17:04:44 +0200
Message-Id: <20210904150447.14659-1-fmdefrancesco@gmail.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

io_ops abstraction is useless in this driver, since there is only one ops
registration. Without io_ops we can get rid of indirect calls mess and
shorten the calls chain.

Shorten the calls chain of rtw_read8/16/32() down to the actual reads.
For this purpose unify the three usb_read8/16/32 into the new
usb_read(); make the latter parameterizable with 'size'; embed most of
the code of usbctrl_vendorreq() into usb_read() and use in it the new
usb_control_msg_recv() API of USB Core.

Shorten the calls chain of rtw_write8/16/32() down to the actual writes.
For this purpose unify the four usb_write8/16/32/N() into the new
usb_write(); make the latter parameterizable with 'size'; embed most of
the code of usbctrl_vendorreq() into usb_write() and use in it the new
usb_control_msg_send() API of USB Core.

The code with the modifications was thoroughly tested by Pavel Skripkin 
using a TP-Link TL-WN722N v2 / v3 [Realtek RTL8188EUS]

Fabio M. De Francesco (2):
  staging: r8188eu: Shorten calls chain of rtw_read8/16/32()
  staging: r8188eu: Shorten calls chain of rtw_write8/16/32/N()

Pavel Skripkin (1):
  staging: r8188eu: remove _io_ops structure

 drivers/staging/r8188eu/core/rtw_io.c         | 241 +-----------------
 drivers/staging/r8188eu/hal/usb_halinit.c     |   6 +-
 drivers/staging/r8188eu/hal/usb_ops_linux.c   | 232 ++++++++++-------
 drivers/staging/r8188eu/include/rtw_io.h      |  76 +-----
 drivers/staging/r8188eu/include/usb_ops.h     |   2 -
 .../staging/r8188eu/include/usb_ops_linux.h   |   8 -
 drivers/staging/r8188eu/os_dep/usb_intf.c     |   2 +-
 .../staging/r8188eu/os_dep/usb_ops_linux.c    |  40 +--
 8 files changed, 169 insertions(+), 438 deletions(-)

-- 
2.33.0

