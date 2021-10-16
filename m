Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 47D894300D2
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Oct 2021 09:22:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243749AbhJPHYK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Oct 2021 03:24:10 -0400
Received: from szxga01-in.huawei.com ([45.249.212.187]:28949 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236583AbhJPHYG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Oct 2021 03:24:06 -0400
Received: from dggeme762-chm.china.huawei.com (unknown [172.30.72.54])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4HWZGG606ZzbmgB;
        Sat, 16 Oct 2021 15:17:26 +0800 (CST)
Received: from ubuntu1804.huawei.com (10.67.174.44) by
 dggeme762-chm.china.huawei.com (10.3.19.108) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2308.8; Sat, 16 Oct 2021 15:21:53 +0800
From:   Gaosheng Cui <cuigaosheng1@huawei.com>
To:     <paul@paul-moore.com>, <eparis@redhat.com>, <rgb@redhat.com>
CC:     <linux-audit@redhat.com>, <linux-kernel@vger.kernel.org>,
        <wangweiyang2@huawei.com>
Subject: [PATCH -next,v3 0/2] Audit: fix warning and check priority early
Date:   Sat, 16 Oct 2021 15:23:49 +0800
Message-ID: <20211016072351.237745-1-cuigaosheng1@huawei.com>
X-Mailer: git-send-email 2.30.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.67.174.44]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggeme762-chm.china.huawei.com (10.3.19.108)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

v3:
  drop the redundant commit message and add a Fixes tag to the first 
  patch
v2:
  audit: fix possible null-pointer dereference in audit_filter_rules
  audit: return early if the rule has a lower priority
v1:
  audit: return early if the rule has a lower priority

Gaosheng Cui (2):
  audit: fix possible null-pointer dereference in audit_filter_rules
  audit: return early if the rule has a lower priority

 kernel/auditsc.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

-- 
2.30.0

