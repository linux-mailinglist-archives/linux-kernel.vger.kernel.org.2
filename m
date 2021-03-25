Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD1A8349375
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Mar 2021 14:58:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231248AbhCYN5y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Mar 2021 09:57:54 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:14595 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231381AbhCYN5e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Mar 2021 09:57:34 -0400
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4F5mpC5r7Nz19Hp5;
        Thu, 25 Mar 2021 21:55:31 +0800 (CST)
Received: from huawei.com (10.175.104.175) by DGGEMS402-HUB.china.huawei.com
 (10.3.19.202) with Microsoft SMTP Server id 14.3.498.0; Thu, 25 Mar 2021
 21:57:23 +0800
From:   Miaohe Lin <linmiaohe@huawei.com>
To:     <akpm@linux-foundation.org>
CC:     <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
        <linmiaohe@huawei.com>
Subject: [PATCH 0/3] Cleanup for khugepaged
Date:   Thu, 25 Mar 2021 09:56:44 -0400
Message-ID: <20210325135647.64106-1-linmiaohe@huawei.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.104.175]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,
This series contains cleanups to remove unnecessary out label and
meaningless !pte_present() check. Also use helper function to simplify
the code. More details can be found in the respective changelogs.
Thanks!

Miaohe Lin (3):
  khugepaged: use helper function range_in_vma() in
    collapse_pte_mapped_thp()
  khugepaged: remove unnecessary out label in collapse_huge_page()
  khugepaged: remove meaningless !pte_present() check in
    khugepaged_scan_pmd()

 mm/khugepaged.c | 14 ++++----------
 1 file changed, 4 insertions(+), 10 deletions(-)

-- 
2.19.1

