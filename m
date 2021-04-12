Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A965535C447
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Apr 2021 12:44:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239522AbhDLKoZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Apr 2021 06:44:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237386AbhDLKoU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Apr 2021 06:44:20 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8217CC061574
        for <linux-kernel@vger.kernel.org>; Mon, 12 Apr 2021 03:44:02 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id 20so2185989pll.7
        for <linux-kernel@vger.kernel.org>; Mon, 12 Apr 2021 03:44:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=nfSnDyKH8eQyblcVTBktK3kbpdYMJZiJC2JxbskSzHw=;
        b=LjAUt+sq2bBQByg90jwnPgHNjJt8VwRb+Czau/fcSUfKl8MXfbn5XkBeny3hL8WoiN
         GKzSiYFfVgDaNSWoReOQ3208Fhp4hTGe8Os6jga1nGNoLRx8AI8IDVwoX208TgY4aaN2
         LnCpqOOwAQwl+Ir7PbP5+AUDXatcs4FAjPseeJFd6KUT4dHY4EZ1yq2yaUI5/LFQV1W9
         u7EBHziZRtDxqK2fkLLu1/Vo/6jvHKBhETpHPDqHQ/+JmLtbFQCWFlVubEi+YJWx8S+T
         bmmZ2mgEASbRqRNRcuCJ7OKvcFPoIvekXET/be31nslbmc2/euO47ht/C3Tk+MJwnd0M
         rk1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=nfSnDyKH8eQyblcVTBktK3kbpdYMJZiJC2JxbskSzHw=;
        b=LUQWkB9vpILiD9ndz2nWmcJI6r0PY0hveyRJTLiqWcAWD520ya1asBj4oC0FZokztB
         ADIF0/lPlBrI4bZnssV7NPx6XjVAwawX4mkzVwQpEOZZwmhymFIc/a3bGkJP2wRXTew8
         8vbi/w384cj8Wc4Uf5D0EvF7AGUwDzCvOqJVbbXg7RnhIwAwbpM7IdM28gjOML6esxAP
         Xn5AnMK+5LbgaaLFDIl6687ZMnX0QKLit16JnmFY1mHAuPTSgpsu4jddPJ8etNxy1Myg
         Y1/Dy/5LMj09YJWdJpnFnBFM7tOuv2YP97wKlkvLuYPJacLzhC4uecKnQ5E6f9lgt+iR
         7KAg==
X-Gm-Message-State: AOAM531iWzzykwM3+JSzLt8y+J6wqUNZ1bzA31OsMh96H6X8VROEppzo
        yMf+OYdcgybZeuEuHbCcYtGi9ksul30qJQ==
X-Google-Smtp-Source: ABdhPJy1sJjJMZb3JF3C/YE+UzV7C9XvFVrV16gUrCjy4nwVDdnBRKSn8WRrC9bYAYiIGP1BlaVqIw==
X-Received: by 2002:a17:90a:b292:: with SMTP id c18mr23074230pjr.179.1618224241916;
        Mon, 12 Apr 2021 03:44:01 -0700 (PDT)
Received: from kali ([103.141.87.254])
        by smtp.gmail.com with ESMTPSA id 184sm9695577pfx.156.2021.04.12.03.43.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Apr 2021 03:44:01 -0700 (PDT)
Date:   Mon, 12 Apr 2021 16:13:54 +0530
From:   Mitali Borkar <mitaliborkar810@gmail.com>
To:     nsaenzjulienne@susu.de, gregkh@linuxfoundation.org
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        outreachy-kernel@googlegroups.com, mitali_s@me.iitr.ac.in
Subject: [PATCH v2 0/2] staging: vc04_services: cleanup patchset for style
 issues
Message-ID: <cover.1618223171.git.mitaliborkar810@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Changes from v1:- Threaded mails properly and changed the subject line
to match prefix on patches.
[PATCH 1/2]:- No changes.
[PATCH 2/2]:- No changes.

Mitali Borkar (2):
  staging: vc04_services: remove trailing whitespace
  staging: vc04_services: rectify spelling mistake

 drivers/staging/vc04_services/interface/TODO | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

-- 
2.30.2

