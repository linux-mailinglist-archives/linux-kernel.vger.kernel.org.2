Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 21367350F86
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Apr 2021 08:56:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233635AbhDAGyC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Apr 2021 02:54:02 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:15427 "EHLO
        szxga06-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232310AbhDAGx0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Apr 2021 02:53:26 -0400
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4F9v3s4TylzjXhp;
        Thu,  1 Apr 2021 14:51:37 +0800 (CST)
Received: from localhost.localdomain (10.67.165.24) by
 DGGEMS403-HUB.china.huawei.com (10.3.19.203) with Microsoft SMTP Server id
 14.3.498.0; Thu, 1 Apr 2021 14:53:13 +0800
From:   Meng Yu <yumeng18@huawei.com>
To:     <marcel@holtmann.org>, <johan.hedberg@gmail.com>,
        <luiz.dentz@gmail.com>
CC:     <linux-bluetooth@vger.kernel.org>, <wangzhou1@hisilicon.com>,
        <yumeng18@huawei.com>, <linux-kernel@vger.kernel.org>
Subject: [PATCH 0/2] net/Blutooth - Coding style fix
Date:   Thu, 1 Apr 2021 14:50:37 +0800
Message-ID: <1617259839-31383-1-git-send-email-yumeng18@huawei.com>
X-Mailer: git-send-email 2.8.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.165.24]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove 'return' in void function and fix some coding style

Meng Yu (2):
  Bluetooth: Remove 'return' in void function
  Bluetooth: Coding style fix

 net/bluetooth/6lowpan.c     | 5 +----
 net/bluetooth/hci_debugfs.c | 8 ++++----
 net/bluetooth/hci_event.c   | 2 +-
 net/bluetooth/hci_request.c | 6 ++----
 net/bluetooth/l2cap_core.c  | 7 +++----
 5 files changed, 11 insertions(+), 17 deletions(-)

-- 
2.8.1

