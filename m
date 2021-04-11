Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 561DD35B6CC
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Apr 2021 21:50:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236445AbhDKTqR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 11 Apr 2021 15:46:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235338AbhDKTqR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Apr 2021 15:46:17 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63BE4C061574
        for <linux-kernel@vger.kernel.org>; Sun, 11 Apr 2021 12:46:00 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id n38so7794631pfv.2
        for <linux-kernel@vger.kernel.org>; Sun, 11 Apr 2021 12:46:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=jyH0A6ClPB0zsoVJunsM9FMNKSR906bep9nUXtpL+H0=;
        b=mMx3o2drvRIPugGDVwVww2EsbkyRserUm8cjFGBZmWUA9HIyBRymOz/5tRprlQ2yMx
         mDdA7cqDiXNDOpr/8t2X+f1X3gt8FOXLvFp5keHwPL34xYyFGiogtMWTS1CIBwqZp0EI
         ugVGZFCBGJZ4WUm1MffjpEFYCYMX+jTNoF6mTeP7iGL7XhFWyUSJMR90UJebZ7+jZJRz
         jFIrFTRU3+q/Ia7O8UqIPGEn+VcekC8rv2kDbwpYxF8MeHErJH8JH+9JEKu5PEIr6HAl
         kX8PhRhCkKJxtcrKwJZJ709ulDG1lcibHblZvx9YNmMVpchNXlLt5Do7x71up0JYhmeA
         dNXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=jyH0A6ClPB0zsoVJunsM9FMNKSR906bep9nUXtpL+H0=;
        b=nctwRZFqDDtcQgEkKNgfW7cbgzT2hPQ8pBHSFTF8AJ0uWYLFG+4C5SsNW/8v7CXBSV
         TK/X11RadKIAN19y3qV4gcdbDcweqrnhLup7d3I/PQyrpSwK3nz2ZfNOEzmUR4JW4C8S
         K3qgkPHPjOcE7e+lCLYzmi6IYGocbroxvIfHiKFtRsFvUtcxeUIXDYrZMMMLmtfBtbwi
         t1wuYElIp7LfqmUYJXeBRecOI7x1Ef02AIJ0UZXRsnKfu6ddybU0XATT1mkO1Yi56K02
         tlH2Iqy7oQ+9+JPr2s97VRViC+uHXMbcvHpbvxDq32OAvy9IVIrDOM6hbk6S/Bu44MCs
         FYRA==
X-Gm-Message-State: AOAM532Mye4fQByYngYsyF5aqIwed0f95oaxEGPYsqL92V4rOjDeeh7w
        aSW0/bdo5YKtCJgu1RXm2BfQG45qhaDN7Q==
X-Google-Smtp-Source: ABdhPJx/XYEjRr2opCzK8ijbVnePl0KVYe/0TWdDHP3rdLrw/WT7dOAkZnaU5oXcQYMd0w501wnHSA==
X-Received: by 2002:a63:175c:: with SMTP id 28mr22566637pgx.376.1618170359606;
        Sun, 11 Apr 2021 12:45:59 -0700 (PDT)
Received: from kali ([103.141.87.254])
        by smtp.gmail.com with ESMTPSA id fs3sm8431374pjb.30.2021.04.11.12.45.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Apr 2021 12:45:59 -0700 (PDT)
Date:   Mon, 12 Apr 2021 01:15:52 +0530
From:   Mitali Borkar <mitaliborkar810@gmail.com>
To:     nsaenzjulienne@suse.de, gregkh@linuxfoundation.org
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        outreachy-kernel@googlegroups.com, mitali_s@me.iitr.ac.in
Subject: [PATCH 0/2] remove whitespace and rectify spelling error
Message-ID: <cover.1618169920.git.mitaliborkar810@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fixes whitespace and spelling mistake issue.

Mitali Borkar (2):
  staging: vc04_services: remove trailing whitespace
  staging: vc04_services: rectify spelling mistake

 drivers/staging/vc04_services/interface/TODO | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

-- 
2.30.2

