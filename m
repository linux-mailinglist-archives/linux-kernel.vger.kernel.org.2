Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BA0D33056E1
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jan 2021 10:27:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232617AbhA0J1K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jan 2021 04:27:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235283AbhA0JYx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jan 2021 04:24:53 -0500
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCB49C0613ED
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jan 2021 01:22:40 -0800 (PST)
Received: by mail-pj1-x1035.google.com with SMTP id jx18so968356pjb.5
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jan 2021 01:22:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=semihalf-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=JvxU13iYjcjDg03AytB70/7UdozftYcu83UQXA1xXRI=;
        b=WVArURekNUc5zR9702ut7h3QIJ8hu1EjcJhfCXKvHJ3Emzby9e4OjRFIg0Sffc6UHe
         MEYp8Z7Eq9IyoBsFain4rFvQYMmf68+LEdSp3IMuri/qP37+4Dw2uJJf7lv/dzHSpACr
         p1r88bP7sQp2Yz2AucA8oLuLhXLdG4mqixDJgAp0RpojHmzoeLEvxbrPKl8AZjpnln/x
         Tp8waBApl9IrWFNIvpVOyWd/R5jSvaS9QyUL0RvPgELgcW4DfphO+UztjcUOGysU0g0Y
         nW8bgJK12L7BJ0iKVLwDy9cKX4E83X3pCEaIEhDP8Nsf0Qm3I9VJpHVBCzxgjFYQGm52
         fc0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=JvxU13iYjcjDg03AytB70/7UdozftYcu83UQXA1xXRI=;
        b=M0LEYGT91Dy+We3GHIojlFAMIL86/DwnNAs+fAIn6V2tTCZPmmFm0YdFEA695jIMVN
         BSQ/t9nZ+QQhkW5oBXkvKdIS+wUzmvoZTWA/IvHBs10XZtx+0ZS71mpG95Tdrl79QlL6
         T0N1R3lmKCVTkS5G0VQmPsIzJ+MBaDRwFpTCqg0sYUbSKt3rxeDDFUGRa+DfCqMcbMm/
         fZrLKOGwK3mvwRvdhfMhHOItMaiOAOUZfvWlLNpBKhN8eRxNnJeaZeSvJyRTa1h96gnD
         Yv8oDLgw4yO2UMxdurtqo+PG/ZUZxdGhiMCfXeWg0hwV6hkSjGQMkg/hb+8ax2skj5BU
         WMQA==
X-Gm-Message-State: AOAM532IMns0IyFywKNYh3fGeNtVLVkXW39NfLGWdOMOF1y5IVZroqcG
        L3GwJo7NsU8GCg9nPoxSiZXwtxtDx8Ta8QaHWgmCmQ==
X-Google-Smtp-Source: ABdhPJwXBVuqtmdTUg6vUXswg11zryH6Q7OTA7MxMhew+XcVk2JuZDMqJgTJZLwer+K3GuxhuW6y+nzpEyEqAS6+n58=
X-Received: by 2002:a17:90a:9483:: with SMTP id s3mr4651822pjo.85.1611739360328;
 Wed, 27 Jan 2021 01:22:40 -0800 (PST)
MIME-Version: 1.0
From:   =?UTF-8?Q?=C5=81ukasz_Majczak?= <lma@semihalf.com>
Date:   Wed, 27 Jan 2021 10:22:29 +0100
Message-ID: <CAFJ_xbqT8h2Exix3S6AGgB7W1N0u-=WKffAyb7Hk9-8K8FBwKA@mail.gmail.com>
Subject: PROBLEM: Crash after mm: fix initialization of struct page for holes
 in memory layout
To:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Mike Rapoport <rppt@linux.ibm.com>
Cc:     =?UTF-8?Q?Rados=C5=82aw_Biernacki?= <rad@semihalf.com>,
        Marcin Wojtas <mw@semihalf.com>,
        Alex Levin <levinale@google.com>,
        Guenter Roeck <groeck@google.com>,
        Jesse Barnes <jsbarnes@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Crash after mm: fix initialization of struct page for holes in memory layout

Hi,
I was trying to run v5.11-rc5 on my Samsung Chromebook Pro (Caroline),
but I've noticed it has crashed - unfortunately it seems to happen at
a very early stage - No output to the console nor to the screen, so I
have started a bisect (between 5.11-rc4 - which works just find - and
5.11-rc5),
bisect results points to:

d3921cb8be29 mm: fix initialization of struct page for holes in memory layout

Reproduction is just to build and load the kernel.

If it will help any how I am attaching:
- /proc/cpuinfo (from healthy system):
https://gist.github.com/semihalf-majczak-lukasz/3517867bf39f07377c1a785b64a97066
- my .config file (for a broken system):
https://gist.github.com/semihalf-majczak-lukasz/584b329f1bf3e43b53efe8e18b5da33c

If there is anything I could add/do/test to help fix this please let me know.

Best regards
Lukasz
