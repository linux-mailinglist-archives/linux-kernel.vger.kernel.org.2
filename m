Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 75ADC381938
	for <lists+linux-kernel@lfdr.de>; Sat, 15 May 2021 16:00:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231374AbhEOOA2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 15 May 2021 10:00:28 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:3698 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231304AbhEOOA0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 May 2021 10:00:26 -0400
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4Fj6Pm43B7z16Pgk;
        Sat, 15 May 2021 21:56:28 +0800 (CST)
Received: from code-website.localdomain (10.175.127.227) by
 DGGEMS405-HUB.china.huawei.com (10.3.19.205) with Microsoft SMTP Server id
 14.3.498.0; Sat, 15 May 2021 21:59:00 +0800
From:   Zheng Yejian <zhengyejian1@huawei.com>
To:     <linux-kernel@vger.kernel.org>
CC:     <akpm@linux-foundation.org>, <rdunlap@infradead.org>,
        <vbabka@suse.cz>, <guohanjun@huawei.com>, <zhangjinhao2@huawei.com>
Subject: [PATCH 0/2] Fix encode_comp_t()
Date:   Sat, 15 May 2021 22:06:29 +0800
Message-ID: <20210515140631.369106-1-zhengyejian1@huawei.com>
X-Mailer: git-send-email 2.25.4
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.127.227]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Type conversion in encode_comp_t() may look a bit problematic.

Zheng Yejian (2):
  acct: Fix accuracy loss for input value of encode_comp_t()
  acct: Fix potential integer overflow in encode_comp_t()

 kernel/acct.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

-- 
2.17.1

