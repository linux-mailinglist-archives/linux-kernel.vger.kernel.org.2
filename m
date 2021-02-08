Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 54ADF3128D2
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Feb 2021 02:43:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229615AbhBHBnN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 7 Feb 2021 20:43:13 -0500
Received: from mailgw02.mediatek.com ([1.203.163.81]:23657 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S229537AbhBHBnL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Feb 2021 20:43:11 -0500
X-UUID: 2db5fc76fb9d45429ee431b732e731b3-20210208
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=ULBBv16Q1mHQSjrxC5JC4Ng01qNvDvITXA02Ecv37fg=;
        b=BvWtgzgnh27TIfSJNdpyEniL6t03GY8v0Ix7KDFL8zkAxtuXv4zKERRmW7h07+ftxg8EHkmtf6iPeeb571EsR+qwwxrDY9lRwAFfkWcUVLClNB8PCv8D1TmMReyX77pLfKp31gVL/7OZsv3lz4PPI/v672RlYSFvMqNEQPPBr2A=;
X-UUID: 2db5fc76fb9d45429ee431b732e731b3-20210208
Received: from mtkcas36.mediatek.inc [(172.27.4.253)] by mailgw02.mediatek.com
        (envelope-from <jitao.shi@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1119160678; Mon, 08 Feb 2021 09:42:27 +0800
Received: from MTKCAS36.mediatek.inc (172.27.4.186) by MTKMBS33N2.mediatek.inc
 (172.27.4.76) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Mon, 8 Feb
 2021 09:42:24 +0800
Received: from mszsdclx1018.gcn.mediatek.inc (10.16.6.18) by
 MTKCAS36.mediatek.inc (172.27.4.170) with Microsoft SMTP Server id
 15.0.1497.2 via Frontend Transport; Mon, 8 Feb 2021 09:42:22 +0800
From:   Jitao Shi <jitao.shi@mediatek.com>
To:     Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>
CC:     <airlied@linux.ie>, <daniel@ffwll.ch>, <robh+dt@kernel.org>,
        <matthias.bgg@gmail.com>, <srv_heupstream@mediatek.com>,
        <yingjoe.chen@mediatek.com>, <eddie.huang@mediatek.com>,
        <ck.hu@mediatek.com>, <dri-devel@lists.freedesktop.org>,
        <devicetree@vger.kernel.org>, <stonea168@163.com>,
        <huijuan.xie@mediatek.com>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>, <shuijing.li@mediatek.com>,
        Jitao Shi <jitao.shi@mediatek.com>
Subject: [PATCH v3 0/3] Add check for max clock rate in mode_valid
Date:   Mon, 8 Feb 2021 09:42:18 +0800
Message-ID: <20210208014221.196584-1-jitao.shi@mediatek.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: DB4EF7886213DC2036DBC34BDC2F48D6D3B3115A91A2E902F0F987A4E432E1842000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Q2hhbmdlcyBzaW5jZSB2MjoNCiAtIGFkZCBjb25zdCBzdHJ1Y3QgZHJtX2Rpc3BsYXlfaW5mbyAq
aW5mbyBpbiBtdGtfZHBpX2JyaWRnZV9tb2RlX3ZhbGlkDQoNCkppdGFvIFNoaSAoMyk6DQogIGRy
bS9tZWRpYXRlazogbXRrX2RwaTogQWRkIGNoZWNrIGZvciBtYXggY2xvY2sgcmF0ZSBpbiBtb2Rl
X3ZhbGlkDQogIGRybS9tZWRpYXRlazogbXRrX2RwaTogQWRkIGRwaSBjb25maWcgZm9yIG10ODE5
Mg0KICBkdC1iaW5kaW5nczogbWVkaWF0ZWssZHBpOiBhZGQgbXQ4MTkyIHRvIG1lZGlhdGVrLGRw
aQ0KDQogLi4uL2Rpc3BsYXkvbWVkaWF0ZWsvbWVkaWF0ZWssZHBpLnlhbWwgICAgICAgIHwgIDEg
Kw0KIGRyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9tdGtfZHBpLmMgICAgICAgICAgICB8IDI2ICsr
KysrKysrKysrKysrKysrKysNCiAyIGZpbGVzIGNoYW5nZWQsIDI3IGluc2VydGlvbnMoKykNCg0K
LS0gDQoyLjI1LjENCg==

