Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 796693805FA
	for <lists+linux-kernel@lfdr.de>; Fri, 14 May 2021 11:16:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231828AbhENJRb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 May 2021 05:17:31 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:2923 "EHLO
        szxga07-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230000AbhENJRb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 May 2021 05:17:31 -0400
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4FhN9r0D5YzBvS3;
        Fri, 14 May 2021 17:13:36 +0800 (CST)
Received: from [10.174.176.232] (10.174.176.232) by
 DGGEMS408-HUB.china.huawei.com (10.3.19.208) with Microsoft SMTP Server id
 14.3.498.0; Fri, 14 May 2021 17:16:13 +0800
CC:     Andrew Morton <akpm@linux-foundation.org>
From:   Miaohe Lin <linmiaohe@huawei.com>
Subject: [Question] Is there a race window between __anon_vma_prepare() with
 page_lock_anon_vma_read() ?
To:     Linux-MM <linux-mm@kvack.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Message-ID: <726b53ca-f8a5-c8cb-d704-bcd656afa68e@huawei.com>
Date:   Fri, 14 May 2021 17:16:12 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.176.232]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,
I am investigating the rmap code, and I found the below possible race window:

CPU 1								CPU 2
-----								-----
page_lock_anon_vma_read
  rcu_read_lock
  /* We assume anon_vam == root_anon_vma in this case. */
  root_anon_vma = READ_ONCE(anon_vma->root);
  root_anon_vma is *released* somewhere unfortunately.
  down_read_trylock(&root_anon_vma->rwsem)
								__anon_vma_prepare
								  anon_vma_alloc
								    root_anon_vma is *allocated* here.
								    init_rwsem(&anon_vma->rwsem);
  !page_mapped(page)
    up_read(&root_anon_vma->rwsem); -- *Oops!*

root_anon_vma->rwsem is reinitialized after locked. And reinitialized anon_vma->rwsem will be
unlocked without lock first.

I think this could happen due to the subtle SLAB_TYPESAFE_BY_RCU. But only can occur when anon_vma
is root anon_vma or they won't operate on the same rwsem.
Is this will really happen or Am I miss something ? Any reply would be very grateful.
Many Thanks! :)
