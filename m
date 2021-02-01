Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB49230A098
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Feb 2021 04:38:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231360AbhBADhG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 31 Jan 2021 22:37:06 -0500
Received: from mailgw02.mediatek.com ([1.203.163.81]:57998 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S230439AbhBADg6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 Jan 2021 22:36:58 -0500
X-UUID: 4e7bcbfed94440ec94ca6d11cb948aae-20210201
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=Fb5TMlb/KzzokWa8gLqQllqr+RMLpIwXrONia/Hh3Ag=;
        b=G9FhDgV8LqX0bFWYN3SDSs4G2nMZ+zpEW3mJg5yCPIB5kSocvWfX53L9lMUXfQ+dDFjC+nUUpAbIVsF2nRU/wtKF3ZLfYe2mMjd+3V7pcqAu+PM+cjluD0h3d8npbptMK+uEK6SS3d/ur/x24nou9FdlmhqnKJUX5zLak8l8WfY=;
X-UUID: 4e7bcbfed94440ec94ca6d11cb948aae-20210201
Received: from mtkcas36.mediatek.inc [(172.27.4.253)] by mailgw02.mediatek.com
        (envelope-from <jitao.shi@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 871101342; Mon, 01 Feb 2021 11:36:11 +0800
Received: from MTKCAS36.mediatek.inc (172.27.4.186) by MTKMBS33N2.mediatek.inc
 (172.27.4.76) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Mon, 1 Feb
 2021 11:36:09 +0800
Received: from mszsdaap41.gcn.mediatek.inc (10.16.6.141) by
 MTKCAS36.mediatek.inc (172.27.4.170) with Microsoft SMTP Server id
 15.0.1497.2 via Frontend Transport; Mon, 1 Feb 2021 11:36:08 +0800
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
Subject: [PATCH v2 2/2] drm/mediatek: dsi: fine tune the line time cause by EOTp
Date:   Mon, 1 Feb 2021 11:36:03 +0800
Message-ID: <20210201033603.12616-3-jitao.shi@mediatek.com>
X-Mailer: git-send-email 2.12.5
In-Reply-To: <20210201033603.12616-1-jitao.shi@mediatek.com>
References: <20210201033603.12616-1-jitao.shi@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: ACEABE82BDDD8AC1D44B065C300327C1A829929A8C583854B1D308A61AB955862000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RW5hYmxpbmcgRW9UcCB3aWxsIG1ha2UgdGhlIGxpbmUgdGltZSBsYXJnZXIsIHNvIHRoZSBoZnAg
YW5kDQpoYnAgc2hvdWxkIGJlIHJlZHVjZWQgdG8ga2VlcCBsaW5lIHRpbWUuDQoNClNpZ25lZC1v
ZmYtYnk6IEppdGFvIFNoaSA8aml0YW8uc2hpQG1lZGlhdGVrLmNvbT4NCi0tLQ0KIGRyaXZlcnMv
Z3B1L2RybS9tZWRpYXRlay9tdGtfZHNpLmMgfCAxICsNCiAxIGZpbGUgY2hhbmdlZCwgMSBpbnNl
cnRpb24oKykNCg0KZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9tdGtfZHNp
LmMgYi9kcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2RzaS5jDQppbmRleCAyYmM0NmYyMzUw
ZjEuLjhjNzBlYzM5YmZlMSAxMDA2NDQNCi0tLSBhL2RyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9t
dGtfZHNpLmMNCisrKyBiL2RyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9tdGtfZHNpLmMNCkBAIC00
ODEsNiArNDgxLDcgQEAgc3RhdGljIHZvaWQgbXRrX2RzaV9jb25maWdfdmRvX3RpbWluZyhzdHJ1
Y3QgbXRrX2RzaSAqZHNpKQ0KIAkJCSAgdGltaW5nLT5kYV9oc196ZXJvICsgdGltaW5nLT5kYV9o
c19leGl0ICsgMzsNCiANCiAJZGVsdGEgPSBkc2ktPm1vZGVfZmxhZ3MgJiBNSVBJX0RTSV9NT0RF
X1ZJREVPX0JVUlNUID8gMTggOiAxMjsNCisJZGVsdGEgKz0gZHNpLT5tb2RlX2ZsYWdzICYgTUlQ
SV9EU0lfTU9ERV9FT1RfUEFDS0VUID8gMiA6IDA7DQogDQogCWhvcml6b250YWxfZnJvbnRwb3Jj
aF9ieXRlID0gdm0tPmhmcm9udF9wb3JjaCAqIGRzaV90bXBfYnVmX2JwcDsNCiAJaG9yaXpvbnRh
bF9mcm9udF9iYWNrX2J5dGUgPSBob3Jpem9udGFsX2Zyb250cG9yY2hfYnl0ZSArIGhvcml6b250
YWxfYmFja3BvcmNoX2J5dGU7DQotLSANCjIuMTIuNQ0K

