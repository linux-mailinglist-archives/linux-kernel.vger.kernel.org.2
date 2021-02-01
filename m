Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB74A30A096
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Feb 2021 04:38:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231312AbhBADg4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 31 Jan 2021 22:36:56 -0500
Received: from mailgw02.mediatek.com ([1.203.163.81]:4630 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S230439AbhBADgx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 Jan 2021 22:36:53 -0500
X-UUID: e206aecf62d047ebb74b72eeed204d99-20210201
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=X9UJf+Dfvvey3eOlYKu/5iaho5HJZbcdIR3EG1y2gAM=;
        b=b2wkwloe7K7YdrqgvCSes+mw5t1vQ+ZQsigdHfB0JFHljKp3UGDBtNHubOPRRdXg/p8barA0SO1ss9Ry+tPQnF3tTQ4JzS3eozTXr1Pch3tB+IWRiipolBF4LntWBUcMs0fshllFkWIOS0obB081xe9/k6sWJ5Wdw3kbQyhf2nI=;
X-UUID: e206aecf62d047ebb74b72eeed204d99-20210201
Received: from mtkcas34.mediatek.inc [(172.27.4.253)] by mailgw02.mediatek.com
        (envelope-from <jitao.shi@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 2066249804; Mon, 01 Feb 2021 11:36:08 +0800
Received: from MTKCAS36.mediatek.inc (172.27.4.186) by MTKMBS33N1.mediatek.inc
 (172.27.4.75) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Mon, 1 Feb
 2021 11:36:06 +0800
Received: from mszsdaap41.gcn.mediatek.inc (10.16.6.141) by
 MTKCAS36.mediatek.inc (172.27.4.170) with Microsoft SMTP Server id
 15.0.1497.2 via Frontend Transport; Mon, 1 Feb 2021 11:36:05 +0800
From:   Jitao Shi <jitao.shi@mediatek.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>
CC:     <linux-mediatek@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <srv_heupstream@mediatek.com>, <yingjoe.chen@mediatek.com>,
        <eddie.huang@mediatek.com>, <cawa.cheng@mediatek.com>,
        <bibby.hsieh@mediatek.com>, <ck.hu@mediatek.com>,
        <stonea168@163.com>, <huijuan.xie@mediatek.com>,
        Jitao Shi <jitao.shi@mediatek.com>
Subject: [PATCH v2 0/2] Fix EoTp flag
Date:   Mon, 1 Feb 2021 11:36:01 +0800
Message-ID: <20210201033603.12616-1-jitao.shi@mediatek.com>
X-Mailer: git-send-email 2.12.5
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: 9A769A91630558C31E795C4AC43FDD8B316D8CB066EF2D651DAB3736ADEA3FFD2000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Q2hhbmdlcyBzaW5jZSB2MToNCiAtIFNlcGVyYXRlIHRoZSBsaW5lIHRpbWUgYXMgc2luZ2xlIHBh
dGNoLg0KDQpKaXRhbyBTaGkgKDIpOg0KICBkcm0vbWVkaWF0ZWs6IGRzaTogRml4IEVvVHAgZmxh
Zw0KICBkcm0vbWVkaWF0ZWs6IGRzaTogZmluZSB0dW5lIHRoZSBsaW5lIHRpbWUgY2F1c2UgYnkg
RU9UcA0KDQogZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210a19kc2kuYyB8IDggKysrKysrLS0N
CiAxIGZpbGUgY2hhbmdlZCwgNiBpbnNlcnRpb25zKCspLCAyIGRlbGV0aW9ucygtKQ0KDQotLSAN
CjIuMTIuNQ0K

