Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B9251400D47
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Sep 2021 00:02:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235781AbhIDWB7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Sep 2021 18:01:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229888AbhIDWB5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Sep 2021 18:01:57 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34DA2C061575
        for <linux-kernel@vger.kernel.org>; Sat,  4 Sep 2021 15:00:55 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id i6so3969652edu.1
        for <linux-kernel@vger.kernel.org>; Sat, 04 Sep 2021 15:00:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=UIj4kd16/zrsNXzE8q2OMx4c2eCEJ9nBcH+2bqe0QjM=;
        b=JjrzR21iTp8MOgF2CBiYaE4wx86vRPS31uKTG/O5Xr5sh0iS18qmeNacbK2uPILrNB
         V6z5MuO7OZPoFRHx4ZLB7aY/yr2vLxrsvRonwZTPSdTqUPc3EwajL/rkGeOwGxhnfs60
         4QR/tqHpiU1Dnu1RdJMH3XQUV+/bZvLW9OS+p97vi6Q9RpZLXUnAaqRAHvOGuVxqQPQ4
         iIQGPktEmGYkTda+DYxNXeQiZhk90oC2sSeBnPhx9VZyRLYEdCMNTdaHb0E0qoR0b6l0
         pGw03wV8IKpW7fYQw9xNrHtNbEanhqzoJt61QNMXwo11HgLmwV61OU41lEgym5xKRMEl
         Vzlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=UIj4kd16/zrsNXzE8q2OMx4c2eCEJ9nBcH+2bqe0QjM=;
        b=VnkgIJfbN2LSaJb0hd0nEZtmxwD3jmcJOGO/B21IfaZK3gcGhRJyh+Ccn4NDSsYJnq
         WDe+jEogYgBO31wBRKSW6zyHFtWKk4aeIaKAG7CW1bqOnFxox/Sl90KFjCjM5hnM5VIz
         3XFPFiLnlhhlnfLlukrBs+eN3W/rD42829J/xfepAGptfpjcHo0TW+P/YFK9ZnitID2B
         NLgFsXF9mEscoTeH5+yB+69sWGq58ol+cmBYRjASKzojL5rIhb6kXRaw15V7BzhL72xj
         1elGUmFAra7JJ8XjYirLtgwxLuNLfo4MPxiE9gIUsrF0bnmNF50c0qLFXkIxrbQezT9Q
         mFFg==
X-Gm-Message-State: AOAM530NB02uEkxgaE8M5PqlqX+6Hst8aHvoVcVodQQpRohQlvIxuqHb
        kZ9fZmIvnHtgeAhHZvih2hM=
X-Google-Smtp-Source: ABdhPJz9u8FVT5ux1Zgb9U2RGewrl2xapXPVTyS8egz/zYwhx2n8b5Fne3auaV5m9hhxN3qH+WRK7Q==
X-Received: by 2002:aa7:c857:: with SMTP id g23mr5988804edt.219.1630792853287;
        Sat, 04 Sep 2021 15:00:53 -0700 (PDT)
Received: from localhost.localdomain (host-79-23-101-208.retail.telecomitalia.it. [79.23.101.208])
        by smtp.gmail.com with ESMTPSA id i4sm1940258edq.34.2021.09.04.15.00.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Sep 2021 15:00:52 -0700 (PDT)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Pavel Skripkin <paskripkin@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Cc:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
Subject: [PATCH v3 0/3] staging: r8188eu: Shorten and simplify calls chain
Date:   Sun,  5 Sep 2021 00:00:45 +0200
Message-Id: <20210904220048.12822-1-fmdefrancesco@gmail.com>
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

 drivers/staging/r8188eu/core/rtw_io.c         | 241 +----------------
 drivers/staging/r8188eu/hal/usb_halinit.c     |   6 +-
 drivers/staging/r8188eu/hal/usb_ops_linux.c   | 242 +++++++++++-------
 drivers/staging/r8188eu/include/rtw_io.h      |  76 +-----
 drivers/staging/r8188eu/include/usb_ops.h     |   2 -
 .../staging/r8188eu/include/usb_ops_linux.h   |   8 -
 drivers/staging/r8188eu/os_dep/usb_intf.c     |   2 +-
 .../staging/r8188eu/os_dep/usb_ops_linux.c    |  40 +--
 8 files changed, 174 insertions(+), 443 deletions(-)

-- 
2.33.0

