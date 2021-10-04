Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC766421A16
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Oct 2021 00:32:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235915AbhJDWd6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Oct 2021 18:33:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235064AbhJDWd5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Oct 2021 18:33:57 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4BFBC061745
        for <linux-kernel@vger.kernel.org>; Mon,  4 Oct 2021 15:32:07 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id x7so68518434edd.6
        for <linux-kernel@vger.kernel.org>; Mon, 04 Oct 2021 15:32:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Eng+Zc+HfX4OrCQY5S7dCIwJB13LaLzXgwv+0bs9o/I=;
        b=QcolBkIEDg2+Lk6ufeObq+SQa+xNNRbFfNAF5IQmvN3OuuPF5KC4AMsAUI9Xr3hYn+
         wQ14b1zBbUSEaT/m+/REbOFGQIuDjquakozT1Evc+c3XW8cJpoPrrZIFay/pv99L/UUO
         X/Zh3nE7YSXOHC0Bp9jJ+ifzsbbp/NQIX4sKMjGVzjD9rD3ScgmDOSxHBzs7/QDSvdYj
         QucZLg2GEuWbiD3A+An/Q1kjYoALJTOndXcKx/dwqSIQeyu5VuG4DYyj1VEGPpEDW+X5
         /HkIRsFb6Qw0x/DG6uPHpFMzhL/fEkaAtjuZ6RJdbtulKR5U4Yi/GL/Dhp13gC2dEbC3
         +vLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Eng+Zc+HfX4OrCQY5S7dCIwJB13LaLzXgwv+0bs9o/I=;
        b=fMl+IqqQ55KPpHeLH3f919PdSGYajvtoBi0Lm44vsPLQH0uhprz8o8r89Ga5XLZiHS
         Vt3Rl0Y/xwrKb7lFBNbu7zJKTN+0zY/8Gfv2dQfbLrSxtEozX+nUm4IGiebbTK6JlZ/P
         fxM9Ksks6AdmOmoK0c8OH0B8Mn5AXLajxO70RZp5u2orzQe8xeE9AzPNHi+OWCBWdfJI
         9YrAVc9xveyVXy2yhq0ke3l1KbUoTS/9blsiXOjQoFzmS+4KG2wVskG9shotN7N0lOd4
         4J8rurAzeTlRNg2dPaaUHMmnWC3dBljic+4Kt8os8QwAr8gOeXkKKqMvqoRPbJIaoLYr
         1WhA==
X-Gm-Message-State: AOAM533EADGboEK/+413rPSYHJxFlavJKAdp32MFbg4n3/lw/oqP+pcH
        hBnQMhWGo+xf2/pXb2zXBTY=
X-Google-Smtp-Source: ABdhPJzXfMnM+C83Zh2R+7b6lODQPmv9RMYWH8ZtVXm9u7lxCYTzB8u1Ichz4xBTyxnfLGkK9voIdQ==
X-Received: by 2002:a17:906:70c5:: with SMTP id g5mr20991222ejk.63.1633386726262;
        Mon, 04 Oct 2021 15:32:06 -0700 (PDT)
Received: from tom-desktop.station (net-2-42-54-217.cust.vodafonedsl.it. [2.42.54.217])
        by smtp.gmail.com with ESMTPSA id dc8sm7780919edb.28.2021.10.04.15.32.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Oct 2021 15:32:05 -0700 (PDT)
From:   Tommaso Merciai <tomm.merciai@gmail.com>
Cc:     tomm.merciai@gmail.com, Forest Bond <forest@alittletooquiet.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Lucas Henneman <lucas.henneman@linaro.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH v6 0/3] staging: vt6655: replace camel case variables
Date:   Tue,  5 Oct 2021 00:31:55 +0200
Message-Id: <20211004223200.70524-1-tomm.merciai@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series replace the following camel case variables into
equivalent snake case variable for vt6655 driver.

bShortSlotTime -> short_slot_time
ldBmThreshold -> dbm_threshold
PortOffset -> port_offset

Tommaso Merciai (3):
  staging: vt6655: fix camelcase in bShortSlotTime
  staging: vt6655: fix camelcase in ldBmThreshold
  staging: vt6655: fix camelcase in PortOffset

 drivers/staging/vt6655/baseband.c    |  58 +++++------
 drivers/staging/vt6655/card.c        |  90 ++++++++--------
 drivers/staging/vt6655/channel.c     |  10 +-
 drivers/staging/vt6655/device.h      |   4 +-
 drivers/staging/vt6655/device_main.c | 150 +++++++++++++--------------
 drivers/staging/vt6655/mac.c         |  46 ++++----
 drivers/staging/vt6655/power.c       |  24 ++---
 drivers/staging/vt6655/rf.c          |  12 +--
 drivers/staging/vt6655/rxtx.c        |  12 +--
 9 files changed, 203 insertions(+), 203 deletions(-)

-- 
2.25.1

