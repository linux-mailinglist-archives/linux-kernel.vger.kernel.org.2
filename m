Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E952C3C9E9B
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jul 2021 14:29:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237233AbhGOMb4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jul 2021 08:31:56 -0400
Received: from szxga03-in.huawei.com ([45.249.212.189]:11316 "EHLO
        szxga03-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229862AbhGOMby (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jul 2021 08:31:54 -0400
Received: from dggeme703-chm.china.huawei.com (unknown [172.30.72.54])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4GQYTV0lnHz7tgD;
        Thu, 15 Jul 2021 20:24:30 +0800 (CST)
Received: from huawei.com (10.175.124.27) by dggeme703-chm.china.huawei.com
 (10.1.199.99) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Thu, 15
 Jul 2021 20:28:59 +0800
From:   Miaohe Lin <linmiaohe@huawei.com>
To:     <akpm@linux-foundation.org>
CC:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        <linmiaohe@huawei.com>
Subject: [PATCH 0/3] Cleanup for vmstat
Date:   Thu, 15 Jul 2021 20:29:08 +0800
Message-ID: <20210715122911.15700-1-linmiaohe@huawei.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.124.27]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggeme703-chm.china.huawei.com (10.1.199.99)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,
This series contains cleanups to remove unneeded return value, correct
wrong comment and simplify the array size calculation. More details can
be found in the respective changelogs. Thanks!

Miaohe Lin (3):
  mm/vmstat: correct some wrong comments
  mm/vmstat: simplify the array size calculation
  mm/vmstat: remove unneeded return value

 mm/vmstat.c | 21 +++++----------------
 1 file changed, 5 insertions(+), 16 deletions(-)

-- 
2.23.0

