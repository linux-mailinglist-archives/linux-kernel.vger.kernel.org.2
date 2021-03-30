Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F14E134E273
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Mar 2021 09:45:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231448AbhC3Hl7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Mar 2021 03:41:59 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:15394 "EHLO
        szxga06-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231163AbhC3Hlp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Mar 2021 03:41:45 -0400
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4F8hDc1ZmDzqSKD;
        Tue, 30 Mar 2021 15:40:00 +0800 (CST)
Received: from huawei.com (10.67.165.24) by DGGEMS406-HUB.china.huawei.com
 (10.3.19.206) with Microsoft SMTP Server id 14.3.498.0; Tue, 30 Mar 2021
 15:41:35 +0800
From:   Kai Ye <yekai13@huawei.com>
To:     <herbert@gondor.apana.org.au>
CC:     <linux-crypto@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <wangzhou1@hisilicon.com>, <yekai13@huawei.com>
Subject: [PATCH v2 0/5] bug fix and clear coding style
Date:   Tue, 30 Mar 2021 15:39:01 +0800
Message-ID: <1617089946-48078-1-git-send-email-yekai13@huawei.com>
X-Mailer: git-send-email 2.8.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.165.24]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

fixup coding style such as magic number and unneeded variable
initialization. Clear data operation in sg buf unmap, and other
misc fix.

Kai Ye (5):
  crypto: hisilicon/sgl - fixup coding style
  crypto: hisilicon/sgl - delete unneeded variable initialization
  crypto: hisilicon/sgl - add some dfx logs
  crypto: hisilicon/sgl - fix the soft sg map to hardware sg
  crypto: hisilicon/sgl - fix the sg buf unmap

 drivers/crypto/hisilicon/sgl.c | 36 +++++++++++++++++++++++++++++-------
 1 file changed, 29 insertions(+), 7 deletions(-)

-- 
2.8.1

