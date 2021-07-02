Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 684853B9EEC
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Jul 2021 12:16:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231440AbhGBKT3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Jul 2021 06:19:29 -0400
Received: from mailgw01.mediatek.com ([60.244.123.138]:32914 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S230351AbhGBKTZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Jul 2021 06:19:25 -0400
X-UUID: e615c15aae7a4510a52e7dcf0566415d-20210702
X-UUID: e615c15aae7a4510a52e7dcf0566415d-20210702
Received: from mtkcas07.mediatek.inc [(172.21.101.84)] by mailgw01.mediatek.com
        (envelope-from <yp.wu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1983520171; Fri, 02 Jul 2021 18:16:51 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 mtkmbs05n1.mediatek.inc (172.21.101.15) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Fri, 2 Jul 2021 18:16:49 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Fri, 2 Jul 2021 18:16:49 +0800
From:   YP WU <yp.wu@mediatek.com>
To:     <yp.wu@mediatek.com>, <leo.hsiao@mediatek.com>,
        <Lecopzer.Chen@mediatek.com>, <mchehab@kernel.org>,
        <gustavoars@kernel.org>, <hverkuil-cisco@xs4all.nl>,
        <linux-media@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <Jason-BF.Huang@mediatek.com>, <francis.lee@mediatek.com>
Subject: DVBS Blind scan implementation of Linux DVB
Date:   Fri, 2 Jul 2021 18:16:49 +0800
Message-ID: <20210702101649.12668-1-yp.wu@mediatek.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello, dvb frontend maintainer:
	We have an internal discussion about how to implement DVBS blind scan.
Currently, we can't see any structs and IOCTL commands related to DVBS blind scan in Linux-dvb framework.
So we want to confirm if Linux-dvb framework have inherent flow of DVBS blind scan or not.
If the answer is yes, could you tell us how to work in Linux-dvb.
If the answer is no, do you have any suggestions or design scenario for DVBS blind scan?

Sorry to bother you and thanks for your helps.
BRs,
YP
