Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E230A3A9A26
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jun 2021 14:26:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232825AbhFPM2r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Jun 2021 08:28:47 -0400
Received: from szxga01-in.huawei.com ([45.249.212.187]:11039 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231180AbhFPM2p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jun 2021 08:28:45 -0400
Received: from dggemv711-chm.china.huawei.com (unknown [172.30.72.53])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4G4kqw1L0hzZdjS;
        Wed, 16 Jun 2021 20:23:40 +0800 (CST)
Received: from dggpemm500006.china.huawei.com (7.185.36.236) by
 dggemv711-chm.china.huawei.com (10.1.198.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Wed, 16 Jun 2021 20:26:35 +0800
Received: from thunder-town.china.huawei.com (10.174.179.0) by
 dggpemm500006.china.huawei.com (7.185.36.236) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Wed, 16 Jun 2021 20:26:34 +0800
From:   Zhen Lei <thunder.leizhen@huawei.com>
To:     Joe Perches <joe@perches.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Nicolas Dichtel <nicolas.dichtel@6wind.com>,
        Jason Baron <jbaron@akamai.com>,
        Stefani Seibold <stefani@seibold.net>,
        Jacob Keller <jacob.e.keller@intel.com>,
        Thomas Graf <tgraf@suug.ch>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Jens Axboe <axboe@kernel.dk>, Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        "Andy Shevchenko" <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        linux-kernel <linux-kernel@vger.kernel.org>
CC:     Zhen Lei <thunder.leizhen@huawei.com>
Subject: [PATCH v2 0/3] scripts/spelling.txt: add some spelling pairs and reorder
Date:   Wed, 16 Jun 2021 20:25:04 +0800
Message-ID: <20210616122507.896-1-thunder.leizhen@huawei.com>
X-Mailer: git-send-email 2.26.0.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.174.179.0]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpemm500006.china.huawei.com (7.185.36.236)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

v1 --> v2:
1) Avoid hard coding, dynamic identification of comment lines
2) Avoid creating a temporary file
3) Sort based on "correction", then "mistake"
4) Add "export LC_ALL=C"

v1:
Add spelling_sanitizer.sh and use it to reorder, then add some spelling
"mistake||correction" pairs.

Zhen Lei (3):
  scripts: add spelling_sanitizer.sh script
  scripts/spelling.txt: sort and remove duplicates
  scripts/spelling.txt: add some spelling "mistake||correction" pairs

 scripts/spelling.txt          | 1220 +++++++++++++++++----------------
 scripts/spelling_sanitizer.sh |   27 +
 2 files changed, 674 insertions(+), 573 deletions(-)
 create mode 100755 scripts/spelling_sanitizer.sh

-- 
2.25.1


