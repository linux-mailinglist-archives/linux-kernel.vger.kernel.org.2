Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF1343A2FDC
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jun 2021 17:53:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231788AbhFJPzA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Jun 2021 11:55:00 -0400
Received: from mail-qv1-f45.google.com ([209.85.219.45]:37806 "EHLO
        mail-qv1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231542AbhFJPy7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jun 2021 11:54:59 -0400
Received: by mail-qv1-f45.google.com with SMTP id x6so10037105qvx.4
        for <linux-kernel@vger.kernel.org>; Thu, 10 Jun 2021 08:53:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=UlKPbQCONCFR0Rgoli4txiZUTGz7LR+dp4EBO29/Mjk=;
        b=NI4KvWJGhjQ0FDiqPE/sIVHNbz22EoktFRWlTOhSM939Dj0S0mgu4hvj5tjvhJ6q9i
         9Foi2V820qEji4woPiRRUsbQ6cnF7Id/xcE78YUFtL2HB9yyZuAKfb8OYf9rE9pn9mtm
         xjZ64ap7+n/CVQJ2c2rFRfj5Z1wFZ7TP+hk8irP+6hVbGMfUdGM6HNDp5kLIrv2y0v8d
         anl9Sl3Ec63nJgiv3EkCQTqGUJDViYy2BSGcAA7P4OgAYbWwo/swSzAZDl1WA3i9yFHL
         QGfqI9XuJ0W1waE10P2XfnOTF1f7f9146kIgIuwXZjPVkdp37UUTX4SRQUBkqsOEn6h8
         J4aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=UlKPbQCONCFR0Rgoli4txiZUTGz7LR+dp4EBO29/Mjk=;
        b=t1+hqI4NI8aPMMSoLMlHt0udMrlTql6LNrdTZB9UIOct8ubzEClz2JpBqmZZJypJ+y
         sSAId8T6ClRkzUWusdciYj9cmKDzv+LZVQVqXOiGg3TKtGyitx1tW8lhFoU92crHgHOe
         ammr6cdGCKMVgl6z0l2M6tUxDxXd/5SMa6jH8ukfl7CTl83UR3/Matn+8B0QkGYpdb8q
         5ckCa0SYOq4qv+6VTw5T3iU9mzsL5wZbMYA2hZo1EWFHD2bXI+hU7gVyM9AFYch5aftl
         A8EL7tDCBui4tWVcZvTZvXsGiTpa+Pwpex+gUcCguqQeZHwXCHJ82Zj/6ws1br1A4Pjg
         MOHg==
X-Gm-Message-State: AOAM5321HJIoXEzxvdo9dmNFrqxSCVWPfIyog6IfAMDHGKUtFE8JIH7W
        VhaUmd7GQhMvPpPc0f/sc+c=
X-Google-Smtp-Source: ABdhPJxkPGb9ojisrQn3PxIFzfgNH8u8IP6ZFwBRKOkZ19V+eUfEU0FK5fShi3dsUk/+7ywTWik9Tw==
X-Received: by 2002:a05:6214:2a8a:: with SMTP id jr10mr287379qvb.50.1623340322476;
        Thu, 10 Jun 2021 08:52:02 -0700 (PDT)
Received: from ubuntu ([191.96.170.82])
        by smtp.gmail.com with ESMTPSA id q12sm2455232qtl.13.2021.06.10.08.52.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Jun 2021 08:52:01 -0700 (PDT)
From:   Philippe Dixon <philippesdixon@gmail.com>
To:     hdegoede@redhat.com, Larry.Finger@lwfinger.net
Cc:     Philippe Dixon <philippesdixon@gmail.com>,
        gregkh@linuxfoundation.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: [PATCH 0/3] Fix various checkpatch.pl warnings
Date:   Thu, 10 Jun 2021 08:51:14 -0700
Message-Id: <cover.1623339773.git.philippesdixon@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset contains minor changes to remove some checkpatch.pl
warnings and better follow the Linux kernel coding style
recommendations.

Philippe Dixon (3):
  staging: rtl8723bs: core: add blank line after variable declaration
  staging: rtl8723bs: core: add * to each line of block comment
  staging: rtl8723bs: core: remove whitespace from beginning of line

 drivers/staging/rtl8723bs/core/rtw_cmd.c | 36 +++++++++++++-----------
 1 file changed, 20 insertions(+), 16 deletions(-)

-- 
2.25.1

