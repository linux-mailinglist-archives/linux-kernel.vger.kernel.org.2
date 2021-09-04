Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 489E0400D11
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Sep 2021 23:30:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233006AbhIDV3v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Sep 2021 17:29:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229888AbhIDV3u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Sep 2021 17:29:50 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48795C061575
        for <linux-kernel@vger.kernel.org>; Sat,  4 Sep 2021 14:28:48 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id n11so3859975edv.11
        for <linux-kernel@vger.kernel.org>; Sat, 04 Sep 2021 14:28:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=UIj4kd16/zrsNXzE8q2OMx4c2eCEJ9nBcH+2bqe0QjM=;
        b=mQrchdQcqYhfsiwNvlqbFpaN+ZAsFxabIGsbkAN9H2RpMnbY6mtLBeWKGusnpoZnSV
         bwzN7yb2sVD2CsuhTAfroADDAU6ROpX102gyubSUtoMI0AyMbBM12B29bmMSR2LzcDic
         kBoz+TlMY3CU1rSra12Ne5w8oR7diAV3YLU29E/Ax2mJemV532L6YgHuKrdsf4h3C3go
         SfuN4G336neapwDpxz45vceI71X0JoLcryn1xMDVE4fPCqwq1pMEI6treRIFDwijUopV
         GU0b+c1TQ7woWdDuM1ZcD5jDsDKj6eJdWLcaA0lX7d41s5v/wKsGOxl5xNJNE8wrgwmT
         BCkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=UIj4kd16/zrsNXzE8q2OMx4c2eCEJ9nBcH+2bqe0QjM=;
        b=X2pHsxjKSE9d1Al8HUDwh3Vjr420LjOtxUwEMLN5d4F45skyQ6RFevJpPvKmMDNI4C
         j+wlEphKA10c6FMoQCl+wWTA8JcKuZARGJsAB3NHoWDy4n9IstpR5VC039qgv3Et1MBA
         f7X0DdJCrHCbDdJ/9QaY165qEF72SAk8ozGGQ7SCVgbY4gYYTVfe8QnfivjAjxt508BA
         fRiBVYlC4duWz7wOtZHcQPs4NdJKJsSWJJtPTf5ypoZxpi3KYoWUR0Ff4fPQo+nLEfF1
         vi8HKDA0a7MTtF2rx4cXIKdbssi2ksQB7EO6MG0I9gWBcEN02Djuwf4l5GADkzRqWtZM
         vnMQ==
X-Gm-Message-State: AOAM5317pjQ0MdpJG/ofasKlTvhcThR1FGwgyRg6jLPXQtjzPdzV9bBG
        G2xwi/KGsuCVJ//VhlynSjk=
X-Google-Smtp-Source: ABdhPJyy/9D1M5+/ZkZGzijGwmSPnQpQfixYDLZf0fZrsxU+d8ziwv/mchGa0hJofvgHDtMGTrQ+Pg==
X-Received: by 2002:a05:6402:1d25:: with SMTP id dh5mr5741429edb.91.1630790926708;
        Sat, 04 Sep 2021 14:28:46 -0700 (PDT)
Received: from localhost.localdomain (host-79-23-101-208.retail.telecomitalia.it. [79.23.101.208])
        by smtp.gmail.com with ESMTPSA id n13sm1866699edq.91.2021.09.04.14.28.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Sep 2021 14:28:46 -0700 (PDT)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Pavel Skripkin <paskripkin@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Cc:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
Subject: [PATCH v2 0/3] staging: r8188eu: Shorten and simplify calls chain
Date:   Sat,  4 Sep 2021 23:27:16 +0200
Message-Id: <20210904212719.11426-1-fmdefrancesco@gmail.com>
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

