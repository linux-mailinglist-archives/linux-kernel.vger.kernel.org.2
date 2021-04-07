Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 35B62356769
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Apr 2021 10:59:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349776AbhDGI7l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Apr 2021 04:59:41 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:48552 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1345774AbhDGI7d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Apr 2021 04:59:33 -0400
X-UUID: dbb6a8fee67b482991ca2f842c363947-20210407
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=oqD57DlmW9FeiutinF7pItU5KlzzK5pXIF6q2cyJPd0=;
        b=ZiBg/7RQwuC4IAEFnYWIr32l8UqkknhbEkORIBR7QfEySLL90vjpHAG5R83jEhPrbPB3EvNs40ZTpAGGI4F4kscya2nLMp8IgqracBGFCYu+xb1AFFSoIidFvUpPOyHZ5GYXK1rsEIDeTRWxqjFzKZM7RfHc+qLMISHKtl/czk0=;
X-UUID: dbb6a8fee67b482991ca2f842c363947-20210407
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw01.mediatek.com
        (envelope-from <mason.zhang@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.14 Build 0819 with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 575342156; Wed, 07 Apr 2021 16:59:19 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 mtkmbs01n2.mediatek.inc (172.21.101.79) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Wed, 7 Apr 2021 16:59:17 +0800
Received: from [10.15.20.246] (10.15.20.246) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 7 Apr 2021 16:59:17 +0800
Message-ID: <1617785396.21900.5.camel@mbjsdccf07>
Subject: Re: [PATCH 1/2] arm64: dts: mediatek: add MT6779 spi master dts node
From:   Mason Zhang <mason.zhang@mediatek.com>
To:     Matthias Brugger <matthias.bgg@gmail.com>
CC:     Rob Herring <robh+dt@kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <hanks.chen@mediatek.com>,
        <wsd_upstream@mediatek.com>
Date:   Wed, 7 Apr 2021 16:49:56 +0800
In-Reply-To: <d3666864-cb46-755c-0d0d-d05ac9af0379@gmail.com>
References: <20210226105918.3057-1-Mason.Zhang@mediatek.com>
         <d3666864-cb46-755c-0d0d-d05ac9af0379@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
X-TM-SNTS-SMTP: 685E9AA9F582A0743CC24CDB68AF885E381088F60B605229656993D54DBF98E12000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gTW9uLCAyMDIxLTAzLTI5IGF0IDE3OjUwICswMjAwLCBNYXR0aGlhcyBCcnVnZ2VyIHdyb3Rl
Og0KDQo+IFBsZWFzZSBhbHNvIHVwZGF0ZSBiaW5kaW5nIGRlc2NyaXB0aW9uIGFjY29yZGluZ2xp
bmcgYW5kIGFkZCBhcyBhbm90aGVyIHBhdGNoLiBJDQo+IHdhc24ndCBhYmxlIHRvIGZpbmQgYSAy
LzIgbmVpdGhlci4gSSBmb3VkbiB2MSAyLzIgd2hpY2ggb24gYSBxdWljayBsb29rIHNlZW1lZA0K
PiB0aGUgc2FtZSBhcyB0aGlzIHBhdGNoLg0KDQpEZWFyIE1hdHRoaWFzOg0KDQpwYXRjaCAyLzIg
aW4gdGhpcyBsaW5rIGFuZCB0aGlzIHBhdGNoIGhhcyBiZWVuIG1lcmdlZDoNCmh0dHBzOi8vcGF0
Y2h3b3JrLmtlcm5lbC5vcmcvcHJvamVjdC9saW51eC1tZWRpYXRlay9wYXRjaC8yMDIxMDIyNjEx
MDEwOS4zMDUwMC0xLU1hc29uLlpoYW5nQG1lZGlhdGVrLmNvbS8NCg0Kc28sIFBsZWFzZSBnZW50
bGUgcGluZyBvbiBwYXRjaCAxLzIuIFRoYW5rIHlvdX4NCg0KVGhhbmtzDQpNYXNvbg0K

