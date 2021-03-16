Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D852233D023
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Mar 2021 09:53:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235708AbhCPIxL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Mar 2021 04:53:11 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:35091 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S235450AbhCPIwj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Mar 2021 04:52:39 -0400
X-UUID: 10a3301a85454ce8b22d180966aca92d-20210316
X-UUID: 10a3301a85454ce8b22d180966aca92d-20210316
Received: from mtkcas11.mediatek.inc [(172.21.101.40)] by mailgw01.mediatek.com
        (envelope-from <guochun.mao@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.14 Build 0819 with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 2136175822; Tue, 16 Mar 2021 16:52:18 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs07n1.mediatek.inc (172.21.101.16) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Tue, 16 Mar 2021 16:52:16 +0800
Received: from localhost.localdomain (10.17.3.153) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Tue, 16 Mar 2021 16:52:16 +0800
From:   <guochun.mao@mediatek.com>
To:     Richard Weinberger <richard@nod.at>
CC:     Matthias Brugger <matthias.bgg@gmail.com>,
        <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>, <srv_heupstream@mediatek.com>
Subject: [Patch v1 0/1] ubifs: only check replay with inode type to judge if inode linked
Date:   Tue, 16 Mar 2021 16:52:13 +0800
Message-ID: <20210316085214.25024-1-guochun.mao@mediatek.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch make sure one file could be deleted completely when write and delete mixed
operations occur power-cut.

Guochun Mao (1):
  ubifs: only check replay with inode type to judge if inode linked

 fs/ubifs/replay.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--
2.18.0


