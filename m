Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 05AE539EF43
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jun 2021 09:11:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230293AbhFHHNd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Jun 2021 03:13:33 -0400
Received: from szxga01-in.huawei.com ([45.249.212.187]:3101 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230268AbhFHHNa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jun 2021 03:13:30 -0400
Received: from dggemv704-chm.china.huawei.com (unknown [172.30.72.56])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4Fzh9x7384zWsSM;
        Tue,  8 Jun 2021 15:06:45 +0800 (CST)
Received: from dggpemm500006.china.huawei.com (7.185.36.236) by
 dggemv704-chm.china.huawei.com (10.3.19.47) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Tue, 8 Jun 2021 15:11:36 +0800
Received: from thunder-town.china.huawei.com (10.174.177.72) by
 dggpemm500006.china.huawei.com (7.185.36.236) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Tue, 8 Jun 2021 15:11:36 +0800
From:   Zhen Lei <thunder.leizhen@huawei.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
CC:     Zhen Lei <thunder.leizhen@huawei.com>
Subject: [PATCH 0/5] lib: remove trailing spaces and tabs
Date:   Tue, 8 Jun 2021 15:11:12 +0800
Message-ID: <20210608071117.12634-1-thunder.leizhen@huawei.com>
X-Mailer: git-send-email 2.26.0.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.174.177.72]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpemm500006.china.huawei.com (7.185.36.236)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

find lib/ -type f | xargs sed -r -i 's/[ \t]+$//'

Run the above command to find and remove the trailing spaces and tabs. To keep
the patch from being too big, I broke it down into five parts.


Zhen Lei (5):
  lib/zlib: remove trailing spaces and tabs
  Fonts: remove trailing spaces and tabs
  lib/inflate.c: remove trailing spaces and tabs
  lib/ts_bm.c: remove trailing spaces and tabs
  lib: remove trailing spaces and tabs

 lib/Kconfig                     |  2 +-
 lib/fonts/font_acorn_8x8.c      |  2 +-
 lib/fonts/font_mini_4x6.c       |  8 ++++----
 lib/inflate.c                   | 26 +++++++++++++-------------
 lib/libcrc32c.c                 |  2 +-
 lib/textsearch.c                |  4 ++--
 lib/ts_bm.c                     | 24 ++++++++++++------------
 lib/ts_kmp.c                    |  2 +-
 lib/zlib_deflate/deflate.c      | 10 +++++-----
 lib/zlib_deflate/deftree.c      |  4 ++--
 lib/zlib_deflate/defutil.h      | 10 +++++-----
 lib/zlib_inflate/inflate_syms.c |  2 +-
 lib/zlib_inflate/infutil.h      |  2 +-
 13 files changed, 49 insertions(+), 49 deletions(-)

-- 
2.25.1


