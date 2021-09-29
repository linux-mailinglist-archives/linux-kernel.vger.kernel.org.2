Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8246241CCCB
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Sep 2021 21:46:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344562AbhI2Trh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Sep 2021 15:47:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244887AbhI2Trg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Sep 2021 15:47:36 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81280C06161C;
        Wed, 29 Sep 2021 12:45:54 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id j5so10523386lfg.8;
        Wed, 29 Sep 2021 12:45:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=rqW9hhkISxwuGactI1ttFa+vzsKk4Z1qN+Hs81UQtqw=;
        b=NV/2IMlvCGKizUEH17J7x22FC9cOI/SmQP7u3nxMIDl4lZjr/isDvPyQHDes+owjDB
         NnStzNjllRqQRa8KXNbUlEP56y3pPlzvt5jHUl5cGnhzGK2k/+7R739scKUmuGjKzP+Q
         RiLn16d7F/iHeukFm5vtJXEfqJ8o1o8ppBtBk5M8PcVFd1Lxd9Dfh2cOONs4wtogPkRV
         AxgcPPHTvNR5dU9EHZ91lIc8fjgkd2to2VwAhfG3xKPH7nmFuwheXdb/967q1eEwJKdx
         2031wy/y4UgiOyCFBrz/Pi9p/N7egCfefcNAZl1DgA6QjrzAcjYiW+iVM/plPCm0Zzxg
         ha2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=rqW9hhkISxwuGactI1ttFa+vzsKk4Z1qN+Hs81UQtqw=;
        b=tdrgXQJGMDx0vwR6R0F8+wDN0BN3nh6NUZnd2UZYAdyIrDtpXe+d952kPyxj6Tc5ki
         qUNBKeoNVCe+SRaIxQxVhyaupAlcxF/hrAHZgB9LRGaULiDv5uuM9OiHHYMy68YIFSe3
         7pF/UU6zfZPBvBThxEUn9dQJ5osLxo47ajeEuwW3yNPCtWxoGGEGrGCLvZ4LAZO8ndst
         QRuQQ3EvjSCJjX5NvtcgaYjK1rWJtg/ru4aJ2RS8FMpaXF4EekgU4q57jHZ4J3Ssxk+q
         8yepcbk39oQFjRR8LfjCSjkZC+NYTVDi71ngurfFtYHEgMzXEPtpCyXlLUmMIciwJ8Qr
         KcQg==
X-Gm-Message-State: AOAM5311kTtKFjyPAGu+xmb6O44RQIiCsK72cF4bQ7UOEbDZ1cUowMDQ
        7O2BCdY+P4v7j1yv0rY5aTQ=
X-Google-Smtp-Source: ABdhPJyts3aNlfy2il1lBQlk5FeVxuJAsyZxkNt6bW6cPgTy7SYGw7q5TH9KI98x3HmgVLVXu/IX0Q==
X-Received: by 2002:a2e:8584:: with SMTP id b4mr1856451lji.477.1632944752950;
        Wed, 29 Sep 2021 12:45:52 -0700 (PDT)
Received: from localhost.localdomain (h-98-128-228-193.NA.cust.bahnhof.se. [98.128.228.193])
        by smtp.gmail.com with ESMTPSA id v27sm104607lfp.0.2021.09.29.12.45.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Sep 2021 12:45:52 -0700 (PDT)
From:   Rikard Falkeborn <rikard.falkeborn@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Loic Poulain <loic.poulain@linaro.org>,
        Wei Yongjun <weiyongjun1@huawei.com>
Cc:     Oliver Neukum <oneukum@suse.com>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Junlin Yang <yangjunlin@yulong.com>, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Rikard Falkeborn <rikard.falkeborn@gmail.com>
Subject: [PATCH V2 0/2] usb: cdc-wdm: Fix config and constify
Date:   Wed, 29 Sep 2021 21:45:45 +0200
Message-Id: <20210929194547.46954-1-rikard.falkeborn@gmail.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series fixes an ifdef of a renamed Kconfig option.

While at it, constify a static struct full of function pointers.

V1: https://lore.kernel.org/lkml/20210929132143.36822-1-rikard.falkeborn@gmail.com/

Changes
V2: Use ifdef instead of IS_ENABLED()

Rikard Falkeborn (2):
  usb: cdc-wdm: Fix check for WWAN
  usb: cdc-wdm: Constify static struct wwan_port_ops

 drivers/usb/class/cdc-wdm.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

-- 
2.33.0

