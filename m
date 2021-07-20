Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC74A3CF72D
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jul 2021 11:49:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232795AbhGTJIw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jul 2021 05:08:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231922AbhGTJIu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jul 2021 05:08:50 -0400
Received: from mail-io1-xd33.google.com (mail-io1-xd33.google.com [IPv6:2607:f8b0:4864:20::d33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E312FC061574
        for <linux-kernel@vger.kernel.org>; Tue, 20 Jul 2021 02:49:27 -0700 (PDT)
Received: by mail-io1-xd33.google.com with SMTP id k11so23298886ioa.5
        for <linux-kernel@vger.kernel.org>; Tue, 20 Jul 2021 02:49:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:reply-to:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=EVr+GNugLlc0xK2l3OQNOEkKJ5gDmo5J6cp/NzY4KIo=;
        b=vL8vKnHcBkRYs4elCxdmmAJvT8name6TpaGNkZM0OltyMQ3rN6Mkw43PP+fMm01ywN
         433K9k8H+Mby793zK0itLcwcDQbgatRoP4qQ51o0NjnL3Qd9ZUyQs8mQoL4ToH1q13Zm
         M4z9rbKRiSR4/B9cq3LpXFq0y5K0tUL15dtA5sNKOtnS2bzxBRgtUFBa5BMj03r2xs9L
         6YovP2jtrXAvanepuGRaM5A1tQJful++DYJptHwH9j2WAIy4L6EsgM0J/pULj/qiOrU7
         E6R5WCMTLEO4lnRsl4gkzot4/Bw/LF+62Xchz2Ck2ST9z2CNrl26OsZUUXxcRBVcjObo
         4u/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to:content-transfer-encoding;
        bh=EVr+GNugLlc0xK2l3OQNOEkKJ5gDmo5J6cp/NzY4KIo=;
        b=Aj0b48Y8GsHnnnSDMV5pZX9Ysv4ny7xSZ6aupiHKqGDmLCbn1mUQHDS3Kp92bzbz52
         4M7t/OmDQPxv8uu4LK+lDvB11uAZJlNpsH7odgG5Ve6xy3K3Dm9hNxIieHd0RF7P0DD1
         lzk1jCBeaI+KgJo9nyjGlDWHLeWY/SC8Fc+kU4le1MvEETp4YCryRw1bYiJ9TQsUci/9
         522w2lW8+ustHRKeFM809+6z7jmrXdA/CKoU+sQBYTiPtGv/rZt36msgOzev7zHSBn2k
         ZLtsmHb6t1/LsmTsA5PTzrUNGUM1ua/eokoaj5M+FzKdjsdgw+9hDfFQ1Phgjqmc0WWZ
         ZYuA==
X-Gm-Message-State: AOAM530X2F0gfq9ij/e5F6lzy6k55nBdYkY2f09DnGSO09Qk4fgPhYQ7
        Al2RCGFaLNUDGj7u1n1hmvBHMYIjatm8bEMJS/o=
X-Google-Smtp-Source: ABdhPJzwVmF5zK3HoKC6ORZkMdO14SEC08oEQ6XI3wGXFzShby3iMevToPRXlTwknAUTtQ56XZ7IG3Hu5FYwCW3Qxxs=
X-Received: by 2002:a05:6638:58e:: with SMTP id a14mr20997564jar.81.1626774567419;
 Tue, 20 Jul 2021 02:49:27 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:6602:2003:0:0:0:0 with HTTP; Tue, 20 Jul 2021 02:49:27
 -0700 (PDT)
Reply-To: frankedwardjnr100@gmail.com
From:   Frank Edwardjnr <dcurtis1000@gmail.com>
Date:   Tue, 20 Jul 2021 10:49:27 +0100
Message-ID: <CAJR4kFa5Ep=cPzrPFMCm-VcWO9XFFJnr8nPS41i_T-u=vwD3Pg@mail.gmail.com>
Subject: hi
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGVsbG8sDQpJIGNhbGxlZCB0byBrbm93IGlmIHlvdSByZWNlaXZlZCBteSBwcmV2aW91cyBlbWFp
bCwgcmVwbHkgdG8gbWUNCmFzYXAuDQpGcmFuaw0KDQrslYjrhZXtlZjshLjsmpQNCuuCnCDri7ns
i6DsnbQg64K0IOydtOyghCDsnbTrqZTsnbzsnYTrsJvsnYAg6rK97JqwIOyVjOqzoCDsoITtmZQs
IOuCmOyXkOqyjCDtmozsi6ANCuu5qOumrC4NCuyGlOynge2VmOuLpA0K
