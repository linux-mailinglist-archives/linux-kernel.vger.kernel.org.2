Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 228E034559A
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Mar 2021 03:41:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230029AbhCWClA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Mar 2021 22:41:00 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:37132 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S229665AbhCWCku (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Mar 2021 22:40:50 -0400
X-UUID: 50913b347a2d41aea06632d42a7acc0c-20210323
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=DAu9+vkOf+gCUcKhPMtDjJ5ojxZRjj0OXppDvCNG5gM=;
        b=ZJmEO6xI/GNbOHoXIIgtpjpVrrSTTc9GZ2XkVAqRBNu3kYICbJSBfvvwDR3QcV8sZuxsmLtXDKeXrknPwgqTgWG4B3+Xn/0WwiXkajRwBCZJvTio+5r6SD3MYr20+8TrcOKu5ek0RYqFoTQ++0/OjUwgKLdDTtHh1sHcIrLeVYU=;
X-UUID: 50913b347a2d41aea06632d42a7acc0c-20210323
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw01.mediatek.com
        (envelope-from <chunfeng.yun@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.14 Build 0819 with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1532448559; Tue, 23 Mar 2021 10:40:48 +0800
Received: from MTKCAS32.mediatek.inc (172.27.4.184) by mtkmbs06n2.mediatek.inc
 (172.21.101.130) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Tue, 23 Mar
 2021 10:40:46 +0800
Received: from [10.17.3.153] (10.17.3.153) by MTKCAS32.mediatek.inc
 (172.27.4.170) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Tue, 23 Mar 2021 10:40:45 +0800
Message-ID: <1616467245.11286.3.camel@mhfsdcap03>
Subject: Re: [PATCH 10/13] usb: mtu3: support ip-sleep wakeup for MT8183
From:   Chunfeng Yun <chunfeng.yun@mediatek.com>
To:     Sergei Shtylyov <sergei.shtylyov@gmail.com>
CC:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mathias Nyman <mathias.nyman@intel.com>,
        "Matthias Brugger" <matthias.bgg@gmail.com>,
        <linux-usb@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Eddie Hung <eddie.hung@mediatek.com>,
        Nicolas Boichat <drinkcat@chromium.org>
Date:   Tue, 23 Mar 2021 10:40:45 +0800
In-Reply-To: <47c8e339-114c-9693-222b-173e54bf298e@gmail.com>
References: <1616382832-28450-1-git-send-email-chunfeng.yun@mediatek.com>
         <1616382832-28450-10-git-send-email-chunfeng.yun@mediatek.com>
         <47c8e339-114c-9693-222b-173e54bf298e@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
X-TM-SNTS-SMTP: 98F5B813B71D1B91477EEA6AB7E05F98280E6CE8EF4B0335014B6F4348ABFFEC2000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gTW9uLCAyMDIxLTAzLTIyIGF0IDExOjU3ICswMzAwLCBTZXJnZWkgU2h0eWx5b3Ygd3JvdGU6
DQo+IFNhbWUgY29tbWVudHMgYXMgdG8gdGhlIHBhdGNoICM2Lg0KT2ssIHdpbGwgY2hlY2sgb3Ro
ZXJzLCB0aGFua3MgYSBsb3QNCg0KPiANCj4gTUJSLCBTZXJnZWkNCg0K

