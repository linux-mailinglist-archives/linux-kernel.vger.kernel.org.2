Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 608DB3A94C1
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jun 2021 10:09:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232118AbhFPILF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Jun 2021 04:11:05 -0400
Received: from szxga01-in.huawei.com ([45.249.212.187]:4806 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231481AbhFPILB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jun 2021 04:11:01 -0400
Received: from dggemv704-chm.china.huawei.com (unknown [172.30.72.57])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4G4d492KQBzXgJX;
        Wed, 16 Jun 2021 16:03:53 +0800 (CST)
Received: from dggpeml500017.china.huawei.com (7.185.36.243) by
 dggemv704-chm.china.huawei.com (10.3.19.47) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Wed, 16 Jun 2021 16:08:52 +0800
Received: from huawei.com (10.175.103.91) by dggpeml500017.china.huawei.com
 (7.185.36.243) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.2; Wed, 16 Jun
 2021 16:08:52 +0800
From:   Yang Yingliang <yangyingliang@huawei.com>
To:     <linux-kernel@vger.kernel.org>, <linux-staging@lists.linux.dev>
CC:     <gregkh@linuxfoundation.org>
Subject: [PATCH -next 0/3] use eth_broadcast_addr() to assign broadcast address
Date:   Wed, 16 Jun 2021 16:12:40 +0800
Message-ID: <20210616081243.2511663-1-yangyingliang@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.103.91]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpeml500017.china.huawei.com (7.185.36.243)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Yang Yingliang (3):
  staging: rtl8723bs: os_dep: use eth_broadcast_addr() to assign
    broadcast address
  staging: rtl8723bs: core: use eth_broadcast_addr() to assign broadcast
    address
  staging: rtl8723bs: hal: use eth_broadcast_addr() to assign broadcast
    address

 drivers/staging/rtl8723bs/core/rtw_mlme_ext.c     | 8 +++-----
 drivers/staging/rtl8723bs/hal/rtl8723b_cmd.c      | 3 +--
 drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c | 5 ++---
 drivers/staging/rtl8723bs/os_dep/ioctl_linux.c    | 2 +-
 4 files changed, 7 insertions(+), 11 deletions(-)

-- 
2.25.1

