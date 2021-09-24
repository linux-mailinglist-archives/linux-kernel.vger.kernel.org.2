Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0F083417C05
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Sep 2021 21:55:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348263AbhIXT5G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Sep 2021 15:57:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344226AbhIXT5E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Sep 2021 15:57:04 -0400
Received: from mail-yb1-xb2f.google.com (mail-yb1-xb2f.google.com [IPv6:2607:f8b0:4864:20::b2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D167C061571
        for <linux-kernel@vger.kernel.org>; Fri, 24 Sep 2021 12:55:31 -0700 (PDT)
Received: by mail-yb1-xb2f.google.com with SMTP id m70so8164713ybm.5
        for <linux-kernel@vger.kernel.org>; Fri, 24 Sep 2021 12:55:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to;
        bh=sv+M0BOJ2CyaB00+hNHkCLSS2xHN3+av+4z9yo3LPH8=;
        b=gs5p96mQIvlnNYlX1YuC+o7hWnsMkEuevw83RyI2LlKKlsNV8XWjvVNMvIlbAEZ2Im
         UN7Gc+yYyvyhdcNwmIJDlOe8uxAB2i6sj9vio5sG1mDSxMXljjdpc2GyayZ06Oc5kSu+
         CNXcVakfKw1GRNka9sVZVz1i6RLq/y+JqQqA34NVgWzpP24c3gj9QWN861uNUEujNwXl
         r3sOsUyGE6zN6rFlnBjk7fetrwsmBNO+NYoJeGIiuYcWX2Cl7wO9gsi5lX4kEU0Q1cii
         7ext1OaDe+h9kekLUWHNLrgcKg64Tp4KEC+1rz2QGmb3apCV6bTGd7Rg68euYDQrLnBL
         AAxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=sv+M0BOJ2CyaB00+hNHkCLSS2xHN3+av+4z9yo3LPH8=;
        b=QLGPdMzNeSEpbOFR314dIrdoZYsk9AGhN6TPjxZeu5Fh+6AK63o1rPkV+BeZu1tfDd
         pUaQgPMHcKWqTYdEN8Tc8wxTHNvI9CbxB2z93Db6cW8T41RdwuUwwDWnJmZ23AEFkDsa
         jGrixbf7R3OFDIquEMQ4k+XSg4EkdzQONQ9EvZt2MNOESc7DJPMtjX/IPb9kQk5x9Ueq
         6I2q95CwAxta2I/xzVCEMmzvzPoDXaqAvSAwBQsA4/tR3y/8Hncr8RhaMS8+M2v+1wpu
         C/OZGou4Bkwit9b62at84EUD5rm4Rc0bfx8U3ouIQ8bzMCvCuCuwfZWrsuuvMSLxL5tg
         JDbQ==
X-Gm-Message-State: AOAM530SWle40PTM6DxxvQReEDtN4U+dfeDPtvyU3AMJljzCtErzBYoA
        JEPzPxuN7xJ8wcN39CuoUIIQJzlsAtv69lhzDRyH7IyQNluZEQ==
X-Google-Smtp-Source: ABdhPJzKWpf3iTCgtSpmKYrDwRovlFw5oJxH9hZvDkNFOp7yymIdTyhGkzoJZYIWF9OOdR+XKaPLHf7ktm1510JYkuo=
X-Received: by 2002:a25:7c42:: with SMTP id x63mr2266276ybc.225.1632513329865;
 Fri, 24 Sep 2021 12:55:29 -0700 (PDT)
MIME-Version: 1.0
From:   Eric Dumazet <edumazet@google.com>
Date:   Fri, 24 Sep 2021 12:55:18 -0700
Message-ID: <CANn89iL6AAyWhfxdHO+jaT075iOa3XcYn9k6JJc7JR2XYn6k_Q@mail.gmail.com>
Subject: [BUG] numa spreading of large hash tables no longer a thing
To:     Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrew and mm experts

It seems recent kernels lost the NUMA spreading of large hash tables
allocated at boot time.

Does it ring a bell, was it intentional ?
Thanks

Old behavior
otrv5:~# grep alloc_large_system_hash /proc/vmallocinfo
0x000000006381d67a-0x000000009bc8465a   12288
alloc_large_system_hash+0xf1/0x290 pages=2 vmalloc N0=1 N1=1
0x000000009bc8465a-0x00000000b70c6dfc   12288
alloc_large_system_hash+0xf1/0x290 pages=2 vmalloc N0=1 N1=1
0x00000000b70c6dfc-0x00000000ab13330f   12288
alloc_large_system_hash+0xf1/0x290 pages=2 vmalloc N0=1 N1=1
0x000000008685d551-0x000000009ce0c789   12288
alloc_large_system_hash+0xf1/0x290 pages=2 vmalloc N0=1 N1=1
0x000000004d87acca-0x00000000781b44e4  266240
alloc_large_system_hash+0xf1/0x290 pages=64 vmalloc N0=32 N1=32
0x00000000dea0f2d2-0x00000000909e9fb3 268439552
alloc_large_system_hash+0xf1/0x290 pages=65536 vmalloc vpages N0=32768
N1=32768
0x00000000909e9fb3-0x00000000d23f4353  528384
alloc_large_system_hash+0xf1/0x290 pages=128 vmalloc N0=64 N1=64
0x00000000d23f4353-0x000000003913e8bc 134221824
alloc_large_system_hash+0xf1/0x290 pages=32768 vmalloc vpages N0=16384
N1=16384
0x000000003913e8bc-0x000000007a60bcd6 4198400
alloc_large_system_hash+0xf1/0x290 pages=1024 vmalloc vpages N0=512
N1=512
0x000000007a60bcd6-0x0000000001bc8bf9 4198400
alloc_large_system_hash+0xf1/0x290 pages=1024 vmalloc vpages N0=512
N1=512
0x0000000001bc8bf9-0x0000000022629b89 4198400
alloc_large_system_hash+0xf1/0x290 pages=1024 vmalloc vpages N0=512
N1=512
0x0000000022629b89-0x0000000027d1b0a7 1052672
alloc_large_system_hash+0xf1/0x290 pages=256 vmalloc N0=128 N1=128
0x0000000027d1b0a7-0x0000000027310068 4198400
alloc_large_system_hash+0xf1/0x290 pages=1024 vmalloc vpages N0=512
N1=512
0x0000000027310068-0x00000000a845050a 1052672
alloc_large_system_hash+0xf1/0x290 pages=256 vmalloc N0=128 N1=128
0x00000000a845050a-0x0000000028b8c1bc 2101248
alloc_large_system_hash+0xf1/0x290 pages=512 vmalloc N0=256 N1=256
0x0000000028b8c1bc-0x000000002aff2d3d 2101248
alloc_large_system_hash+0xf1/0x290 pages=512 vmalloc N0=256 N1=256

New behavior
otrv6:~# grep alloc_large_system_hash /proc/vmallocinfo
0x00000000de22dded-0x000000006574cf88   12288
alloc_large_system_hash+0x18c/0x272 pages=2 vmalloc N0=2
0x000000006574cf88-0x00000000bc158a1d   12288
alloc_large_system_hash+0x18c/0x272 pages=2 vmalloc N0=2
0x00000000afa304a2-0x0000000009981fb8   12288
alloc_large_system_hash+0x18c/0x272 pages=2 vmalloc N0=2
0x00000000e3ab78c1-0x00000000ddbeadf2  528384
alloc_large_system_hash+0x18c/0x272 pages=128 vmalloc N0=128
0x0000000000cce551-0x0000000022096e73   12288
alloc_large_system_hash+0x18c/0x272 pages=2 vmalloc N0=2
0x0000000072a43217-0x00000000cf0c05f7  266240
alloc_large_system_hash+0x18c/0x272 pages=64 vmalloc N0=64
0x000000003f85e695-0x0000000042154f88 268439552
alloc_large_system_hash+0x18c/0x272 pages=65536 vmalloc vpages
N0=65536
0x0000000042154f88-0x0000000066fcdca2 134221824
alloc_large_system_hash+0x18c/0x272 pages=32768 vmalloc vpages
N0=32768
0x0000000066fcdca2-0x000000004074129c 4198400
alloc_large_system_hash+0x18c/0x272 pages=1024 vmalloc vpages N0=1024
0x000000004074129c-0x00000000ca32b7f9 4198400
alloc_large_system_hash+0x18c/0x272 pages=1024 vmalloc vpages N0=1024
0x00000000ca32b7f9-0x00000000a56b8117 4198400
alloc_large_system_hash+0x18c/0x272 pages=1024 vmalloc vpages N0=1024
0x00000000a56b8117-0x0000000089e9e39e 2101248
alloc_large_system_hash+0x18c/0x272 pages=512 vmalloc N0=512
0x0000000089e9e39e-0x0000000090a80b5a 1052672
alloc_large_system_hash+0x18c/0x272 pages=256 vmalloc N0=256
0x0000000090a80b5a-0x00000000e84776cb 4198400
alloc_large_system_hash+0x18c/0x272 pages=1024 vmalloc vpages N0=1024
0x00000000e84776cb-0x000000006cfc05bf 1052672
alloc_large_system_hash+0x18c/0x272 pages=256 vmalloc N0=256
0x000000006cfc05bf-0x00000000f6ce3623 1576960
alloc_large_system_hash+0x18c/0x272 pages=384 vmalloc N0=384
0x00000000f6ce3623-0x0000000002737823 2101248
alloc_large_system_hash+0x18c/0x272 pages=512 vmalloc N0=512
0x0000000002737823-0x00000000d4e74269 2101248
alloc_large_system_hash+0x18c/0x272 pages=512 vmalloc N0=512
