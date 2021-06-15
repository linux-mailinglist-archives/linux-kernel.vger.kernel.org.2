Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 66DE93A87D3
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jun 2021 19:35:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231686AbhFORgP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Jun 2021 13:36:15 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:34965 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S231310AbhFORe7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jun 2021 13:34:59 -0400
X-UUID: bf25e5c96581468d96a59c8cc0e1598a-20210616
X-UUID: bf25e5c96581468d96a59c8cc0e1598a-20210616
Received: from mtkcas06.mediatek.inc [(172.21.101.30)] by mailgw01.mediatek.com
        (envelope-from <tinghan.shen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1821328680; Wed, 16 Jun 2021 01:32:49 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs08n2.mediatek.inc (172.21.101.56) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Wed, 16 Jun 2021 01:32:42 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 16 Jun 2021 01:32:42 +0800
From:   Tinghan Shen <tinghan.shen@mediatek.com>
To:     <robh+dt@kernel.org>, <matthias.bgg@gmail.com>
CC:     <devicetree@vger.kernel.org>, <linux-mediatek@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <srv_heupstream@mediatek.com>,
        <seiya.wang@mediatek.com>, <wenst@google.com>,
        <Project_Global_Chrome_Upstream_Group@mediatek.com>
Subject: arm64: dts: mt8195: Add Mediatek SoC MT8195 device nodes
Date:   Wed, 16 Jun 2021 01:32:07 +0800
Message-ID: <20210615173233.26682-1-tinghan.shen@mediatek.com>
X-Mailer: git-send-email 2.15.GIT
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series is a collection of device nodes for Mediatek SoC MT8195 and
depends on patches[1][2][3].

The dependency list is not complete.
some dependencies are still under working.

[1] arm64: dts: Add Mediatek SoC MT8195 and evaluation board dts and Makefile
    https://patchwork.kernel.org/project/linux-mediatek/patch/20210601075350.31515-2-seiya.wang@mediatek.com/

[2] dt-bindings: power: Add MT8195 power domains
    https://patchwork.kernel.org/project/linux-mediatek/patch/20210610023614.5375-3-chun-jie.chen@mediatek.com/

[3] dt-bindings: pinctrl: mt8195: add pinctrl file and binding document
    https://patchwork.kernel.org/project/linux-mediatek/patch/20210413055702.27535-2-zhiyong.tao@mediatek.com/


