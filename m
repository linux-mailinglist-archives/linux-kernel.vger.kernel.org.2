Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4089B3D879D
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jul 2021 08:03:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233736AbhG1GDN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jul 2021 02:03:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230118AbhG1GDL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jul 2021 02:03:11 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFE2DC061757
        for <linux-kernel@vger.kernel.org>; Tue, 27 Jul 2021 23:03:09 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id e2so1036865wrq.6
        for <linux-kernel@vger.kernel.org>; Tue, 27 Jul 2021 23:03:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorremedies-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:from:date:message-id:subject:to;
        bh=CQUhb6DsxNEPonVMs6jvXFr3i/Eu8tPyQaZL/lVX1ow=;
        b=GRCaLbxw6H58iJN6wTnHRLRXRtwZk0bOThM9r3Z1eamnEKrcCM2c7TsHllJ9r3wRpz
         zksBLP1D2mTjXbqVptPTh92hJoY7aPBxV6e8WQytuxv6k6rrdnoJia4T1QbrndXNxgga
         Azwe6SprWhR3ftCbL8oZ5bEpVqMl8+a+cFu7yilUs+yEhw1wErbHdL+Xb82/CqKstt9p
         eIR/J5Grgfvg2Q8pKke51F7gv9EGWt3xIYIuvgXckxYazbNcUlbctSt0nzj/Uy057HQ1
         NDBzNIIH8NEjBy5nYclP+zhHy++PFk31wG0l3RB7syxY2d4U/qaMtnB5u9egN/PTQ3Wm
         fP6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=CQUhb6DsxNEPonVMs6jvXFr3i/Eu8tPyQaZL/lVX1ow=;
        b=CxI8rk/pSDHkEdF3370q0mz8a99z9uuS+cmz0GDeUVIiJgtd3JbaKrjXKWYUkWjv9x
         rw8oDtx5bRGIZETghAyyA4ULy+fMQ5KaLAfVclBdj+QzYLCaXFCiQvEWUw7lIP8zuxUm
         h9yyx0Uz2inaD6zQ/lr2WDPnU9EmmhltBuw7wQizsUp+cqKHwv3mlJMtCBIFjEKW46in
         jLfNw+aE+hAzuutBuG8jqJ8FpbXbsOWOD4CfsVBLi0LUq0iBhwYk5js4LiR7RBypzANA
         8faKuSSoq9Q6bNhYdhfTkIClkjLJb9xNd2uTJhnqLMbFWLPxf7hmCg0a9EsJ02u24ad9
         oFFA==
X-Gm-Message-State: AOAM532I1QeQDhiYKiIIsTOzASxD+53EOj5GGccAyKShNPP27CtLeulj
        ZZuAr+Qps2r54HKiY3XQUDFJ6vv2O+SqQzRki2jfVeRFgAl2xHgX
X-Google-Smtp-Source: ABdhPJzUtEOARQmUc0qG9CcdQWg3TVoNEH5WAUq+rhbfdEc+soeO0v5qV4BYrV2LaDTzuCZCkKeFwN1vmNtWpXU2DL0=
X-Received: by 2002:a5d:5642:: with SMTP id j2mr28049022wrw.65.1627452188270;
 Tue, 27 Jul 2021 23:03:08 -0700 (PDT)
MIME-Version: 1.0
From:   Chris Murphy <chris@colorremedies.com>
Date:   Wed, 28 Jul 2021 00:02:52 -0600
Message-ID: <CAJCQCtT_O1Q1bqoS5EZU7Xht9=KdCrMKRhto5yACP9UWW3_fEw@mail.gmail.com>
Subject: 5.14-rc3 WARNING: at kernel/dma/debug.c:1180 debug_dma_map_sg+0x1f0/0x340
To:     linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4,1759,1754332600,-;CPU: 3 PID: 4768 Comm: Web Content Not tainted
5.14.0-0.rc3.29.fc35.x86_64+debug #1
4,1760,1754332604,-;Hardware name: LENOVO 20QDS3E200/20QDS3E200, BIOS
N2HET63W (1.46 ) 06/01/2021
4,1761,1754332606,-;RIP: 0010:debug_dma_map_sg+0x1f0/0x340

full kmesg:
http://cwillu.com:8080/73.229.236.113/2

full /proc/lock_stat
http://cwillu.com:8080/73.229.236.113/3



-- 
Chris Murphy
