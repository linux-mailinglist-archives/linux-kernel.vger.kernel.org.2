Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7F499457350
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Nov 2021 17:44:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236023AbhKSQrp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Nov 2021 11:47:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232938AbhKSQro (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Nov 2021 11:47:44 -0500
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32451C061574
        for <linux-kernel@vger.kernel.org>; Fri, 19 Nov 2021 08:44:43 -0800 (PST)
Received: by mail-pj1-x1036.google.com with SMTP id gx15-20020a17090b124f00b001a695f3734aso9325468pjb.0
        for <linux-kernel@vger.kernel.org>; Fri, 19 Nov 2021 08:44:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20210112.gappssmtp.com; s=20210112;
        h=subject:date:message-id:mime-version:content-transfer-encoding:cc
         :from:to;
        bh=iaUYOytQ4CzTASh/0HsfVOpxwQKfPG9Q/UWHcdAuKg8=;
        b=7QZB70djv9ZmONgMWpzDrNHLi8Ia6mpxOQMSbYujLwCBXzg5+GyNrj7OmBWY6Ay7wk
         /VTAO8rstw9DtpmIypszmw2wepOutvL2b+LvnR4BoY2isCkax54KUsMAcYoWyPvZtExX
         qPpAc6khXoXZymJlV6kDTTIX5Ozoz8QlHNer00fk+AEwnmOme9ZlcNL+QGKhvV7D6/SZ
         tFyTXVDXAvTXRUTvnz4lo/XxdEJ2jgJ/Ej1grbY5cX1O2z9kdlE0ynQPPlhQkC4m26b1
         ogc3+sBTs2wfzjHW1B6Z5g6LBnJKCMTaNtdbEICcQiOhOkHSM1c9F+krylHBDjh+TMfW
         pDRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:date:message-id:mime-version
         :content-transfer-encoding:cc:from:to;
        bh=iaUYOytQ4CzTASh/0HsfVOpxwQKfPG9Q/UWHcdAuKg8=;
        b=dv9J+dhofh1q49yO0IJ/0mOC58SWLrQLs0oG8gbCFSbo2uCrlD9wUNOosTYqFQZ4KM
         g0XZwVkgAeadw7HKiHk0H14BzfuF0tN7NUVp08n9cyYkZ+IRjPPT8TbCXYUw1zPuE5uj
         MT+4ZYHkro9+ubYT9SnMB2naZPvEB2he4cb2H2Y/u0VB0qEeX0AGVym4TUOHDrglQ2Wx
         O3mnT8ZugHhiI+28pp21aBoIeDAxC9XrE7adiVq0FmyDsz7qBVPaBC5nP9Mu0ETvKK/h
         9XI+Qs8y3itvhE/BMtzDGfoEM5MJOGAkzeusY4nDEF1HQdqHGeCklvU3r1rlSJddsaI/
         2c2Q==
X-Gm-Message-State: AOAM530LtJoGr+y9rpt9Ui1ZFjcqtYPJ4kvDQ86UJlZb2iGZwa5Oqi7r
        bIQJFcT/U37hqEHMW4+jcWE/OA==
X-Google-Smtp-Source: ABdhPJzJNl3mb5xDK9JGkYGImUGtSE424YEbPc3JVtF3+D8k2G5mMHaRTCWukgTULvW/XhOEDdNxMg==
X-Received: by 2002:a17:90b:1644:: with SMTP id il4mr1178367pjb.39.1637340282742;
        Fri, 19 Nov 2021 08:44:42 -0800 (PST)
Received: from localhost (76-210-143-223.lightspeed.sntcca.sbcglobal.net. [76.210.143.223])
        by smtp.gmail.com with ESMTPSA id w189sm182817pfd.164.2021.11.19.08.44.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Nov 2021 08:44:42 -0800 (PST)
Subject: [PATCH 0/12] RISC-V: Clean up the defconfigs
Date:   Fri, 19 Nov 2021 08:44:01 -0800
Message-Id: <20211119164413.29052-1-palmer@rivosinc.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>, aou@eecs.berkeley.edu,
        anup.patel@wdc.com, heinrich.schuchardt@canonical.com,
        atish.patra@wdc.com, bin.meng@windriver.com,
        sagar.kadam@sifive.com, damien.lemoal@wdc.com, axboe@kernel.dk,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
From:   Palmer Dabbelt <palmer@rivosinc.com>
To:         linux-riscv@lists.infradead.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It's been a while since updating the defconfigs, so I figured it would
be good to go through all the diff to make sure nothing was lurking.  It
turns out there were two minor issues, which I've fixed with the first
two patches.  The rest of these are just cleanups that should have no
functional change.

I don't have a K210 (I might somewhere, but I've yet to boot it) so I
can't test this to make sure, but I think patch 2 is the reason we have
a special !MMU PAGE_OFFSET config.  If someone does have one it'd be
nice to be able to remove that special case.


