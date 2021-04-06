Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 282EF354EE3
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Apr 2021 10:45:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244473AbhDFIpj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Apr 2021 04:45:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234159AbhDFIpc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Apr 2021 04:45:32 -0400
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC739C06174A
        for <linux-kernel@vger.kernel.org>; Tue,  6 Apr 2021 01:45:24 -0700 (PDT)
Received: by mail-lj1-x236.google.com with SMTP id 15so15594542ljj.0
        for <linux-kernel@vger.kernel.org>; Tue, 06 Apr 2021 01:45:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=YLqQGd/T46D5zGOlykZcGAUvnOsHHqPoJRmoNN6xMvY=;
        b=ulSxid11kzmFSepZFCYx9snxXUw8kuxz7TyIiG3q/zhkOYukdIEERyp7D0yTCdby3O
         P9Wif3THUTcJJyYyG3Vc47vwYOUBD4nfce540PDzkY3pxGvi4pQ3SV2uvEGPUyygip9D
         5xTmjV+s8dx7zNZ7aMy8VmvL1WuY7+/bsFj7ZeH7lp1H1cfjZfZ2njkpHz750Jzs8zHc
         5uVMeQg9Khmx6C4gEHDCF8PAVCU5TISoErOe+ZvTLg7DOShkKjdeZZ9TxgpcZB9KNcBq
         8E78duyPdw5l6qyVqE6pPB+sxrd8RjAbQGHJbKPT5r+xmZBSMEmE38SgB11aQmwtyGbw
         zayw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=YLqQGd/T46D5zGOlykZcGAUvnOsHHqPoJRmoNN6xMvY=;
        b=NMLQAYLgyxi+DueCJK6X+2AOg32b0PWnvwz1eqm9/k23jPTxPtx9pMK+wOtjJlwchH
         wYXW/tzA15aFcj6lJf2IsHUNoN/ZXzUNy7G409RZ5bQtmx6Hkml26W4zcFyspPP+QtNM
         e9ForR/k9wVyFsbc++ffDBYacsvDvvUyaGSJ1MBRw+HyWtF27jHNPQ8WY+MEtmI1sy8D
         aWmESaFiDFZgiIMsk6ZrqonBxNvz7PdBUUJO3Snk6F4ilQmR7ZWfZBHVXg263/uhVZgV
         iPSuxwbaqxWWvAj9zxtZyi6v4/nHKTBYsfMpDTKvfVJKzTQvyS6J6R0Cosdt/is+KOFc
         0x7A==
X-Gm-Message-State: AOAM531CoUetGKjV7ttIbo6Ow8HAZMuEmioy/etxGTnkcg0RpxfOoI3R
        DLWLnxpIzInMvUsmWX/yfJo=
X-Google-Smtp-Source: ABdhPJxKp6VmTi/7ptEmpnj7Xjt67ejAcc7ZV7+cZb7sszoycP5DJgP3JuQmCqDyMlCEK+CQ1sR0zg==
X-Received: by 2002:a2e:9f08:: with SMTP id u8mr19268358ljk.50.1617698723125;
        Tue, 06 Apr 2021 01:45:23 -0700 (PDT)
Received: from zhans ([37.151.32.231])
        by smtp.gmail.com with ESMTPSA id n7sm2077713lft.65.2021.04.06.01.45.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Apr 2021 01:45:22 -0700 (PDT)
Date:   Tue, 6 Apr 2021 14:45:21 +0600
From:   Zhansaya Bagdauletkyzy <zhansayabagdaulet@gmail.com>
To:     Larry.Finger@lwfinger.net, florian.c.schilhabel@googlemail.com,
        gregkh@linuxfoundation.org
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        outreachy-kernel@googlegroups.com
Subject: [PATCH 0/4] staging: rtl8712: clean up coding style issues
Message-ID: <cover.1617697237.git.zhansayabagdaulet@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To fix style issues, this patchset removes blank lines, adds and removes
spaces, and matches paretheses alignment.

Zhansaya Bagdauletkyzy (4):
  staging: rtl8712: add spaces around operators
  staging: rtl8712: match parentheses alignment
  staging: rtl8712: remove extra blank lines
  staging: rtl8712: remove spaces after a cast

 drivers/staging/rtl8712/rtl871x_ioctl_linux.c |  6 ++---
 drivers/staging/rtl8712/rtl871x_recv.c        | 22 +++++++++----------
 drivers/staging/rtl8712/rtl871x_security.c    | 10 ++++-----
 drivers/staging/rtl8712/rtl871x_security.h    |  4 ++--
 drivers/staging/rtl8712/rtl871x_xmit.h        | 12 +++++-----
 drivers/staging/rtl8712/wifi.h                |  2 +-
 drivers/staging/rtl8712/xmit_osdep.h          |  8 +++----
 7 files changed, 31 insertions(+), 33 deletions(-)

-- 
2.25.1

