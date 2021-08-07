Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A895F3E34BA
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Aug 2021 12:24:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231878AbhHGKYN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 Aug 2021 06:24:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230090AbhHGKX6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Aug 2021 06:23:58 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94463C0613CF
        for <linux-kernel@vger.kernel.org>; Sat,  7 Aug 2021 03:23:39 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id u16so10639045ple.2
        for <linux-kernel@vger.kernel.org>; Sat, 07 Aug 2021 03:23:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=p5uebJso8aQthGFedEwXhZYm/bFWqeh7RO/o/YkMwHY=;
        b=avzHxCZJOL0JfsOGUYPcZsSa5wvQs59Mjbxn/7B6II7lzc0mQ5U3BJEZM5jEvqKiS3
         whnJ8WGQkhyC+XDpT3rNihRZL6ys42Io2lUOz4Lz6Z5maFgaNdJHAP/Deifu8JYmQHTN
         kXA+Icggreyddxk/NT3NzbxPQKSSB+2NtCtuoQhx/63XTzQ4tMH3crky0ZvUlyaccqnT
         LKk8JA324Yq7wVzbZoLuzPyxR1ntYK4ZFZZEOETlu2C4xvyZRDPrMIEppWh0g9hSaq3b
         uiGcRsFO0q8BtZvQxhl4j+y73Ht3fvVBFR8gSxY1H6eJEWxdPGpPfHiCjNbGbR+1aGN/
         1rUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=p5uebJso8aQthGFedEwXhZYm/bFWqeh7RO/o/YkMwHY=;
        b=Ssa1IxgJPyV4d7VSLVk0496ehkh+xrOCQ2NttOBG6QxIh/meDl81Gxyq442YN/yDds
         UhGLduFCwgL+dfb0ogkGEq+e/3hgOreZEUQy0kLEYLbGsAHYqqXpMXOzqyOA5pTRtQWW
         onPeV9C1rclWPHyMogHcrP7CKkRcO0WS/pQwlM+nrewAA01ATgZUxAkO+B9jyS7Q2OqH
         hhgDUfM6iCpypxEacn7v7nZxXClol2Iyg3norhcsl9KbkSsAGXUtT0XW0Xcnek1s3hOx
         VAB1HGfsBythS+dNi0sRFFzHRDAcRNCbDJRpMMmKgN8m7H5RsMcwUc2FynIiZXWqQZXB
         ooWg==
X-Gm-Message-State: AOAM532KczjiEJqNqNDFOz0ohUHZxM5Cmjxydo+F6ZByXlbzWHm5zVQu
        4XHHFdd2wIGRPnlIr9qsTBQ=
X-Google-Smtp-Source: ABdhPJxtvotFxKqBSqPZq6Zo7aM+j70bhRymhGZKVXb+3E7PeXfLV/tSeBO4gMWMcIDCJqa8vtUqXw==
X-Received: by 2002:a63:5c10:: with SMTP id q16mr102391pgb.128.1628331819049;
        Sat, 07 Aug 2021 03:23:39 -0700 (PDT)
Received: from user.. ([106.212.234.168])
        by smtp.gmail.com with ESMTPSA id d17sm13290717pfn.110.2021.08.07.03.23.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Aug 2021 03:23:38 -0700 (PDT)
From:   Saurav Girepunje <saurav.girepunje@gmail.com>
To:     gregkh@linuxfoundation.org, Larry.Finger@lwfinger.net,
        saurav.girepunje@gmail.com, insafonov@gmail.com,
        straube.linux@gmail.com, martin@kaiser.cx, will+git@drnd.me,
        dan.carpenter@oracle.com, apais@linux.microsoft.com,
        yashsri421@gmail.com, fabioaiuto83@gmail.com,
        marcocesati@gmail.com, ross.schm.dev@gmail.com,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 0/4] Remove unused variable
Date:   Sat,  7 Aug 2021 15:52:28 +0530
Message-Id: <20210807102232.6674-1-saurav.girepunje@gmail.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series contains 4 patches to remove unused local variable
from rtl driver files.

Saurav Girepunje (4):
  staging: rtl8188eu: os_dep: Remove unused variable
  staging: rtl8188eu :os_dep :os_intfs : remove unused variable
  staging: rtl8192e: rtl8192e: rtl_core: remove unused global variable
  staging: rtl8723bs: os_dep: remove unused variable

 drivers/staging/rtl8188eu/os_dep/mon.c       | 5 ++---
 drivers/staging/rtl8188eu/os_dep/os_intfs.c  | 4 ++--
 drivers/staging/rtl8192e/rtl8192e/rtl_core.c | 3 ---
 drivers/staging/rtl8723bs/os_dep/os_intfs.c  | 8 --------
 4 files changed, 4 insertions(+), 16 deletions(-)

--
2.30.2

