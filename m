Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ACD09348B97
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Mar 2021 09:32:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229728AbhCYIbs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Mar 2021 04:31:48 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:14893 "EHLO
        szxga06-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229662AbhCYIbg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Mar 2021 04:31:36 -0400
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.59])
        by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4F5dZY0hzvzlVpQ;
        Thu, 25 Mar 2021 16:29:57 +0800 (CST)
Received: from DESKTOP-FKFNUOQ.china.huawei.com (10.67.101.50) by
 DGGEMS414-HUB.china.huawei.com (10.3.19.214) with Microsoft SMTP Server id
 14.3.498.0; Thu, 25 Mar 2021 16:31:28 +0800
From:   Zhe Li <lizhe67@huawei.com>
To:     <joakim.tjernlund@infinera.com>
CC:     <chenjie6@huawei.com>, <dwmw2@infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-mtd@lists.infradead.org>,
        <lizhe67@huawei.com>, <richard@nod.at>, <wangfangpeng1@huawei.com>,
        <xukunkun1@huawei.com>, <zhongjubin@huawei.com>
Subject: Re: [PATCH] jffs2: fix kasan slab-out-of-bounds problem
Date:   Thu, 25 Mar 2021 16:31:27 +0800
Message-ID: <20210325083127.32796-1-lizhe67@huawei.com>
X-Mailer: git-send-email 2.21.0.windows.1
In-Reply-To: <CY4PR1001MB2389E99ECB5B04A65BE35E22F4659@CY4PR1001MB2389.namprd10.prod.outlook.com>
References: <CY4PR1001MB2389E99ECB5B04A65BE35E22F4659@CY4PR1001MB2389.namprd10.prod.outlook.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.67.101.50]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>Reviewe-by: Joakim Tjernlund <joakim.tjernlund@infinera.com>
Thanks for your review.

>It would be interesting to known how you managed to create such a dir entry as that is a bug too.
We discovered this bug by performing fuzzing tests, which simulate bit flips that may occur anywhere in a flash device in real-world scenarios.
