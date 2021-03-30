Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 839EB34E098
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Mar 2021 07:23:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229983AbhC3FWg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Mar 2021 01:22:36 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:60473 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S229569AbhC3FWZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Mar 2021 01:22:25 -0400
X-UUID: 51fd917c5c36470995b3ecc71db4e3cf-20210330
X-UUID: 51fd917c5c36470995b3ecc71db4e3cf-20210330
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw02.mediatek.com
        (envelope-from <pk.chi@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.14 Build 0819 with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1745265423; Tue, 30 Mar 2021 13:22:18 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 mtkmbs01n1.mediatek.inc (172.21.101.68) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Tue, 30 Mar 2021 13:22:12 +0800
Received: from mtkswgap22.mediatek.inc (172.21.77.33) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Tue, 30 Mar 2021 13:22:12 +0800
From:   Po-Kai Chi <pk.chi@mediatek.com>
To:     Matthias Brugger <matthias.bgg@gmail.com>
CC:     <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <wsd_upstream@mediatek.com>, CC Hwang <cc.hwang@mediatek.com>,
        Loda Chou <loda.chou@mediatek.com>,
        Po-Kai Chi <pk.chi@mediatek.com>
Subject: [PATCH v1] memory: mediatek: add DRAM controller driver
Date:   Tue, 30 Mar 2021 13:22:07 +0800
Message-ID: <1617081731-7408-1-git-send-email-pk.chi@mediatek.com>
X-Mailer: git-send-email 1.7.9.5
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These patch series introduces the MediaTek DRAM controller driver (DRAMC)
on MT6779 SoC, and enables to be built as a module by default for the
ARM64 builds.

MediaTek DRAMC driver provides cross-platform features as below:
  - API provided to other kernel modules for querying DRAM type,
    rank count, rank size, channel count and mode register settings.
  - Sysfs interface used to pass DRAM mode register settings and current
    DRAM data rate to user-space for MediaTek ecosystem.

The API user includes MediaTek External Memory Interface (EMI) and
DVFS Resource Control (DVFSRC), which will be sent to mainline later.

