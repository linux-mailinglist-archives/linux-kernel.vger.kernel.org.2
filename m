Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD90639719D
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Jun 2021 12:40:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232694AbhFAKli (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Jun 2021 06:41:38 -0400
Received: from Mailgw01.mediatek.com ([1.203.163.78]:17522 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S230170AbhFAKlh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Jun 2021 06:41:37 -0400
X-UUID: 22bd144d035e4b1f8241e3ee549ea738-20210601
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=DoywdP/w1rKs6wXh5ZMYNkbDujOKch0ZiIWy/6BtozU=;
        b=QwwTad0vUA2gf30+0t6F/gI2CgmKccO/50+6leyiKT5ROM7L+ejS1hwyz3+uA6zQB48w8jihG5kbwZ5lpYCjRGEYkDOkTKh3YbcLH8hpf/R5pxr52KklWQGhPqgN7246uOv5IcEj5go7gs7Dgh6kDWAjGUpK6/l36fNO5Jqaoww=;
X-UUID: 22bd144d035e4b1f8241e3ee549ea738-20210601
Received: from mtkcas32.mediatek.inc [(172.27.4.253)] by mailgw01.mediatek.com
        (envelope-from <rocco.yue@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1979514290; Tue, 01 Jun 2021 18:39:54 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 MTKMBS32N1.mediatek.inc (172.27.4.71) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Tue, 1 Jun 2021 18:39:51 +0800
Received: from localhost.localdomain (10.15.20.246) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Tue, 1 Jun 2021 18:39:50 +0800
From:   Rocco Yue <rocco.yue@mediatek.com>
To:     <linux-kernel@vger.kernel.org>
CC:     Rocco Yue <rocco.yue@mediatek.com>
Subject: Re: [PATCH] ipv6: align code with context
Date:   Tue, 1 Jun 2021 18:26:01 +0800
Message-ID: <20210601102601.26572-1-rocco.yue@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <162252480501.23898.10631295560871610587.git-patchwork-notify@kernel.org>
References: <162252480501.23898.10631295560871610587.git-patchwork-notify@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: 4C097B9DB0F4F99EA584198AA322CE9524DFFD805E93584CB724ECE6E2F257D72000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVHVlLCAyMDIxLTA2LTAxIGF0IDA1OjIwICswMDAwLCBwYXRjaHdvcmstYm90K25ldGRldmJw
ZkBrZXJuZWwub3JnIHdyb3RlOg0KSGVsbG86DQo+IA0KPiBUaGlzIHBhdGNoIHdhcyBhcHBsaWVk
IHRvIG5ldGRldi9uZXQtbmV4dC5naXQgKHJlZnMvaGVhZHMvbWFzdGVyKToNCj4gDQo+IE9uIFN1
biwgMzAgTWF5IDIwMjEgMTk6Mzg6MTEgKzA4MDAgeW91IHdyb3RlOg0KPiA+IFRoZSBUYWIga2V5
IGlzIHVzZWQgdGhyZWUgdGltZXMsIGNhdXNpbmcgdGhlIGNvZGUgYmxvY2sgdG8NCj4gPiBiZSBv
dXQgb2YgYWxpZ25tZW50IHdpdGggdGhlIGNvbnRleHQuDQo+ID4gDQo+ID4gU2lnbmVkLW9mZi1i
eTogUm9jY28gWXVlIDxyb2Njby55dWVAbWVkaWF0ZWsuY29tPg0KPiA+IC0tLQ0KPiA+ICBuZXQv
aXB2Ni9hZGRyY29uZi5jIHwgOCArKysrLS0tLQ0KPiA+ICAxIGZpbGUgY2hhbmdlZCwgNCBpbnNl
cnRpb25zKCspLCA0IGRlbGV0aW9ucygtKQ0KPiANCj4gSGVyZSBpcyB0aGUgc3VtbWFyeSB3aXRo
IGxpbmtzOg0KPiAgIC0gaXB2NjogYWxpZ24gY29kZSB3aXRoIGNvbnRleHQNCj4gICAgIGh0dHBz
Oi8vZ2l0Lmtlcm5lbC5vcmcvbmV0ZGV2L25ldC1uZXh0L2MvMTJlNjRiM2JiOWE4DQo+IA0KPiBZ
b3UgYXJlIGF3ZXNvbWUsIHRoYW5rIHlvdSENCj4gLS0NCj4gRGVldC1kb290LWRvdCwgSSBhbSBh
IGJvdC4NCj4gaHR0cHM6Ly9rb3JnLmRvY3Mua2VybmVsLm9yZy9wYXRjaHdvcmsvcHdib3QuaHRt
bA0KDQpUaGFua3M=

