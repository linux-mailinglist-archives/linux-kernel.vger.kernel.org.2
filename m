Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C28D3D34FE
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jul 2021 09:03:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234224AbhGWGWX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jul 2021 02:22:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234217AbhGWGWV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jul 2021 02:22:21 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37757C061575
        for <linux-kernel@vger.kernel.org>; Fri, 23 Jul 2021 00:02:55 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id m2-20020a17090a71c2b0290175cf22899cso2572456pjs.2
        for <linux-kernel@vger.kernel.org>; Fri, 23 Jul 2021 00:02:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=uci-edu.20150623.gappssmtp.com; s=20150623;
        h=from:content-transfer-encoding:mime-version:subject:message-id:date
         :cc:to;
        bh=AdH+rx5+VPP3VWefoL3mhQLnCJH3lO4p1OcT4UPuSHw=;
        b=hqJ2SYmIYX6GXRc9Jx1OUkc2/AX3IBRoSxOuaHp8m2rF4Ftr/LF8tw/YiHrCU3osXl
         Q5hTdI+eG8cFd6SChXxLzNRFbLHVWHk9d8xlQoGSIc3dxENq9wjFjvzBlqu5kYgdp5EJ
         VSp89rgdFqcBanykXujfxHXCc89vXcoCB2lq/Xe+B+V+Y16oGgyMnBMN2FiYBgIQC6uc
         EtfJd2MrygQ3aV7e1ClCzh+Gtcjt9xPY0xEtQYd+bi3ZtvBhR7aEKPnG1AfuaUHjE4Z6
         R175syYwMni1ay3fsxtD6+2flE2/eBYlhSo0+IkC/7UTbKRkSIPhNTqztUBbqYNGRxj4
         kjXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:content-transfer-encoding:mime-version
         :subject:message-id:date:cc:to;
        bh=AdH+rx5+VPP3VWefoL3mhQLnCJH3lO4p1OcT4UPuSHw=;
        b=uh6PgqRRTcYzunCLCdGjpOv7DlOdX/ZRPNk2co8BWbkvmNZm6pDlHnrKE5jERI/7sD
         wSZuBT/ijW/2KDeIbCDnt0b0YXgZuSKzSpT8SDAHZd9ROMoe3nkwJ5eJiQ7Z7fPui76A
         rzGatg2qPc2THUuVAYy1TvG4jojap5sueq3ofuu71JKtsfM36FLw35pVXRtx9qnUH5tA
         lCkqAR2hzqW0aHuFbkkSI1DgieilqqMlk63erNKkZJ77EQ2GNbGftZYUISSHBkSIIfSX
         XUok3N7DysE0Xy0yP+ZaZ4EoCtUZGOXO4KZFQAwJwHvfkydkIq82Ksujv7grc1JZZ8ps
         PwAQ==
X-Gm-Message-State: AOAM532gKRpT69m/VThnXKKG7KxZR+lZ/8JO9i7uFP4i82nXC/9ch+SI
        i2e+ec9NP/31mNlevZQRcr3liA==
X-Google-Smtp-Source: ABdhPJw/fiEjM+NRZGB2+dG+Gyp/HN41VOVwQ79CbKl4rXQOQ76By2KyfQWR/6Rrc+nCRqwJhafIpA==
X-Received: by 2002:a17:903:244f:b029:12a:f0f9:19a3 with SMTP id l15-20020a170903244fb029012af0f919a3mr3129556pls.42.1627023774767;
        Fri, 23 Jul 2021 00:02:54 -0700 (PDT)
Received: from [192.168.1.3] ([183.98.43.105])
        by smtp.gmail.com with ESMTPSA id s5sm3501225pfk.114.2021.07.23.00.02.45
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 23 Jul 2021 00:02:54 -0700 (PDT)
From:   Dongjoo Seo <dseo3@uci.edu>
Content-Type: text/plain;
        charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.120.23.2.4\))
Subject: Re: [PATCH v34 00/13] Introduce Data Access MONitor (DAMON)
Message-Id: <2E16FC36-18B4-4F92-86AE-51249CCDB1A4@uci.edu>
Date:   Fri, 23 Jul 2021 16:02:44 +0900
Cc:     "Jonathan.Cameron@huawei.com" <Jonathan.Cameron@Huawei.com>,
        acme@kernel.org, akpm@linux-foundation.org,
        alexander.shishkin@linux.intel.com, amit@kernel.org,
        benh@kernel.crashing.org, brendanhiggins@google.com,
        corbet@lwn.net, david@redhat.com, dwmw@amazon.com,
        elver@google.com, fan.du@intel.com, foersleo@amazon.de,
        greg@kroah.com, gthelen@google.com, guoju.fgj@alibaba-inc.com,
        jgowans@amazon.com, joe@perches.com, linux-damon@amazon.com,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, mgorman@suse.de, mheyne@amazon.de,
        minchan@kernel.org, mingo@redhat.com, namhyung@kernel.org,
        peterz@infradead.org, riel@surriel.com, rientjes@google.com,
        rostedt@goodmis.org, rppt@kernel.org, shakeelb@google.com,
        shuah@kernel.org, sieberf@amazon.com, sjpark@amazon.de,
        snu@zelle79.org, vbabka@suse.cz, vdavydov.dev@gmail.com,
        zgf574564920@gmail.com
To:     SeongJae Park <sj38.park@gmail.com>
X-Mailer: Apple Mail (2.3608.120.23.2.4)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello, I am new user of this amazing tool.
I want to use this tool for Nvidia tx2 board with kernel version =
4.9.140.

Do you guys have any timeline or update schedule for different kernel =
version compatibility?

Best
Dongjoo Seo=
