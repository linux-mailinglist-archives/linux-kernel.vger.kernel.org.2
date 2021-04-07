Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B8F443575D3
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Apr 2021 22:22:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349395AbhDGUWd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Apr 2021 16:22:33 -0400
Received: from smtprelay-out1.synopsys.com ([149.117.73.133]:39016 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234971AbhDGUW1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Apr 2021 16:22:27 -0400
Received: from mailhost.synopsys.com (badc-mailhost4.synopsys.com [10.192.0.82])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 0B2484033B;
        Wed,  7 Apr 2021 20:22:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1617826938; bh=szXKpmuOS4njUyx6afL8ZFFG7uQbEOv+oIrtYcsI360=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=COqoi3seqWG4IXKsA5A4I1NLope6qVUBPw2B6W9h9gYhv8Fqy+IWGSSgm1PLPyKQe
         Jc+TypB8DhK6ACRCqXMwDCq9srHacEgk1cz+Q5TNx9qJj0MdEi81xopd6EORCC+abO
         Yfs/ZZi2B2etr9Rkpdcpg86gU/C9R36aqyqCIJ5uup244eG1k/K2HR1ZLdZiBrLXYl
         XGzrVBM2GgRtKnNiaKS32pIUQWMUbZeKT6UxPtzegR+CzgLoZwi8VAaB9l2/KMsnYS
         4j2lucCC5/Ez17mPxpKLMf3WBPdEtmade2FJCzWpLF8yDaNtyYMKNlMxIkzNjQAgf0
         /7sixsKzWmoog==
Received: from o365relay-in.synopsys.com (us03-o365relay3.synopsys.com [10.4.161.139])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by mailhost.synopsys.com (Postfix) with ESMTPS id AFD3FA005F;
        Wed,  7 Apr 2021 20:22:13 +0000 (UTC)
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam08lp2047.outbound.protection.outlook.com [104.47.73.47])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
        by o365relay-in.synopsys.com (Postfix) with ESMTPS id 34AAD80091;
        Wed,  7 Apr 2021 20:22:11 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=vgupta@synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
        dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.b="CRc6di7C";
        dkim-atps=neutral
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JIJX3qT8iV1R/ZXLAjeDm6xEINde5/QZz+divlCHAr45P//rRf+xC0rH7ntY99rANlzi+RKuofB+ViP2PqlvCjJgAsiieX8pjmm2R3MV3Sb2yXWf9i/J+3Xy4+kzLZcPCTBQO0HJFnkeCR0w3tP53eHLfkJciJC+EfJhDDkNzQDiGqjS7dnWpF1dlApFWLj4fFhWAXSJQ3ede4UTYXCreCHqKyEnwRtSPH+EtFX1J9nllK8JsbzeW+GuAGTdcpuIGjjKKYCCnl7IXG/7Ie/jJeGGKVPs1h/19oIEdvdcDf1kDyjym+lT6o68oxWVNT9Q0KBBMn0ArcBgAwgOpIOIzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=szXKpmuOS4njUyx6afL8ZFFG7uQbEOv+oIrtYcsI360=;
 b=Kyn55M8vwo5rld4FUJtg+jGvqvQuRGlPRGc9Ye6pIgLajK78orroDhp7gbpUtEQacDWcRRMVzHDa8wGJOT42LWPd1dQhnhTsk4qHrallp5R9U59GmoNgi3uYSGVgYD+bH/yVOda6AgVyVgUffjauztoOnOBlkHsqqK2FNBRk+9AA0UlHygdsFxdtNSwE+iTUWun/OaEoq9thYCaWwzk8wSABWCVmMaDk9/0G5fuHqowE1DZPSVPl84iWRBWIxH7BAJz4jLHmmJP+HsZLjX40ZhkY0/Q6V87ZpLoxA6gC9EJXyRMQMq0c3wlpGkZMvk7iZrLEDrwdInZcHO51D9BrUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=szXKpmuOS4njUyx6afL8ZFFG7uQbEOv+oIrtYcsI360=;
 b=CRc6di7Cld5J8EJte/nPkP7RPih5jwAflB/in651VfEm1O1f9ieKKCoZlNiL/hUiUTIRnLJodGiPAdoB5XyTkXK1Xciwjtgeh2V/lOfca98jMmlnI0B/YGT2eYyU165mplbL9E16pkO9AtbIg062rkroYgVTpTQE76NDELvgLyQ=
Received: from BYAPR12MB3479.namprd12.prod.outlook.com (2603:10b6:a03:dc::26)
 by BYAPR12MB3351.namprd12.prod.outlook.com (2603:10b6:a03:de::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3999.27; Wed, 7 Apr
 2021 20:22:09 +0000
Received: from BYAPR12MB3479.namprd12.prod.outlook.com
 ([fe80::88a:1041:81ed:982]) by BYAPR12MB3479.namprd12.prod.outlook.com
 ([fe80::88a:1041:81ed:982%7]) with mapi id 15.20.3999.033; Wed, 7 Apr 2021
 20:22:09 +0000
X-SNPS-Relay: synopsys.com
From:   Vineet Gupta <Vineet.Gupta1@synopsys.com>
To:     Bhaskar Chowdhury <unixbhaskar@gmail.com>,
        "axboe@kernel.dk" <axboe@kernel.dk>,
        "gustavoars@kernel.org" <gustavoars@kernel.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "linux-snps-arc@lists.infradead.org" 
        <linux-snps-arc@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     "rdunlap@infradead.org" <rdunlap@infradead.org>
Subject: Re: [PATCH] arc/kernel/signal.c: Fix couple of typos
Thread-Topic: [PATCH] arc/kernel/signal.c: Fix couple of typos
Thread-Index: AQHXIHGdz0g2FlQLbEypFU8MShtEk6qplnoA
Date:   Wed, 7 Apr 2021 20:22:09 +0000
Message-ID: <62ddcadc-d4e6-e448-bc91-99c256c8a759@synopsys.com>
References: <20210324055213.26775-1-unixbhaskar@gmail.com>
In-Reply-To: <20210324055213.26775-1-unixbhaskar@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=synopsys.com;
x-originating-ip: [24.4.73.83]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 56b9ab04-be93-48c2-ff01-08d8fa02d1fc
x-ms-traffictypediagnostic: BYAPR12MB3351:
x-microsoft-antispam-prvs: <BYAPR12MB3351DEBC184F993D5B806B36B6759@BYAPR12MB3351.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:291;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: mR9/qO3x5VqUMDlpNHRaHHt8lfbY1UljhWuKAlyxvTV/iSUAfT/Giv3YfDQNFIK90yjUbOSSxXkicx8Y6bCNNDv16CB1W7X/CwJmpT4cFabPH75kyWJsE98sRYdFS1GMp2+EmVc+Z1GTXj2I26vwub3zK6hYP5lcPp3eoAETea9jWpBDo3JmZllA0TdlwCiSb5fBbSBF4M6eIBU6SUfQSkX51PwInF0BFj3STzwFoGWy3y6CgSZGQr0A+K1YLr87ysHjhsPZ2GvcTyhj2ONZXMhJLcDMA2bBi+tWQS/q7T7jQGLNrjz4xj2/zFHm5zn2+qyUbsIzTk/MDrCK8mfioq/LZ9Vo3jVjLhOwhGvbvZnpTFCHpOI++v7Oa+adIsdm+MqAEWvywO2542GOEQGlsYc5yOrzSScXQ7VYoRiISlJ9mCjR+kQAZ9ivmPrYrbu77GjUCthniQOtmGk7+KmGV0PjPsQBXMmAHDlPWaV6THjm5JsBSNOAq9XfF+bLGuky5ESZVLrpKx/Sufeh3eyJhUkWjJ+ItjzExmXYeqQz+CADSO0AMB6e9FprVPzS4cjo/w+TeFsYrhuZg+YDR2wVwxyU1lNp548Vx+B/2DiMobsRyxtwx8uY8hUpC9h2LA1E2SdKkb7nOddo6W084kvhw6hlwMCZSLX0Zj/8rFbGbWSNsps4fNX8/NXJiuNENtoiE4iaJM1nfvbtY5d3c1QRc2LX4OhUDSfoQRriKg1fjXg=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB3479.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(376002)(346002)(136003)(396003)(366004)(39860400002)(478600001)(26005)(66556008)(64756008)(2906002)(53546011)(6506007)(8936002)(186003)(66476007)(6512007)(31696002)(66946007)(76116006)(5660300002)(6486002)(31686004)(71200400001)(316002)(2616005)(110136005)(4326008)(8676002)(83380400001)(38100700001)(66446008)(36756003)(86362001)(43740500002)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?utf-8?B?WTlPMVZRNnZqRTZuTVRMOU1lckt0OXFldnBaaHRoMUxkbVdoSDhBd0xPZGtB?=
 =?utf-8?B?YThob01mVTNIYTVxWVdxZU5BSCtua3djTFBrMjBOY29PejBRVC9KUG9CQzdT?=
 =?utf-8?B?d1NUQXJmRUxzeU1Ta1JHNzN4YXZuQjhZbXBlQ3o4VjRmUXdISThRekowY282?=
 =?utf-8?B?cGVmejJxYUtENWw5bVBZbGY2TkNMV242UnRIR09hTmRWRkt0dk5ycDFnZm93?=
 =?utf-8?B?TGYwQlRSN3pySVBabXRQd29MTGo5R040dFJzOHpTSWRGOWZ1V1BEM0UySkdG?=
 =?utf-8?B?czZMMzVXZmZKQW85V3pOa3pSM0t1MWd5NE8vdUE4cC8vYzQ1Q05QRHVyeUNU?=
 =?utf-8?B?SzhoMCtCVXBIR1orNHNiVFNpMXN3aFZ4emwwaXEwdkNBL0cvUkd2bWRXWUtE?=
 =?utf-8?B?V1ZaMVZZVE1BSVdZVFF0UHc4emdYbE84WWYvSGdqSnBYNEtIb0VnQ2VraGhz?=
 =?utf-8?B?bVFPSUZNcXFZNlBNbEpkRTZlSXo1dUxMUmRqdk1PWmZ4V0lOTFBMaGt4REsz?=
 =?utf-8?B?TVJRelM1eHp5YXJWNE1VZ1JpeExFMzFkTkE2RXlhenNIODFUakVFblZDVmVQ?=
 =?utf-8?B?V3JJTnB0NWZadWlaMmx5dUJsRktzRys0YVFiS0ZiSFhQM2YycTJFeTM5NEt3?=
 =?utf-8?B?eTNRM1J3Q09vT1hMamdhYytBOWhzN2dFY0JHUURWRUJzR2dtc1p4aWZEMFNF?=
 =?utf-8?B?TEhqUXhwK3ZNc0FuckpaMDl0cktkbU9HclU3b1A5Y1RxRmdvTXJiMURvR0hZ?=
 =?utf-8?B?S0xyaE1ZS1VjNnVKZW1UMlRJTFY0NHhZNlZRWEF1bUFYSjlna1NpZnRwd2hU?=
 =?utf-8?B?TXdOUXB6ZitLdDVEZEJtQ0JTeGVTK0R1VXpHeGhPNXlGQUdYWm1JY0hZUmNK?=
 =?utf-8?B?ckZpUTVNSDdJWi9wZytDY25sb28rYWlVUHZEUW81Ym9hUXhEdUJoYUYzT2ha?=
 =?utf-8?B?QytpU0RMZzJiNGRzN0ZiclBaMHRuZkY4Nk5DRFpRSDZPZ3UvcElSRzVOUDVa?=
 =?utf-8?B?M3k4WGJlM0tVc3RzSGNKbmc5cTJUR2c2K1BnUmpsWU1VaklVdndaMEtPMDVU?=
 =?utf-8?B?ZnlUbVNCc25UQW9jKzBaQTc5eGwvUTREQlB1SkhiamNod0hNZzVhRkpwZWR6?=
 =?utf-8?B?WE8wdGN0WXluNnQxSlBGdngzV2ZhZUNGRXhMNGdZNFVQK0pQRCttVGJRQmtK?=
 =?utf-8?B?Umw2UFlKdlNCQlI1SlBycEJpVTNQb2tpSFJsdkVlZ01iT2hqMG9kdlJ5c0VD?=
 =?utf-8?B?UWFES0pNWXpKZHZ2WjNpSDJMdXQ5K1E4UXdHVlZycXlOSWRHUzJ6ZHg0bCtl?=
 =?utf-8?B?QUZZamdTa1o0OHBkaXVuTis4TTYzMlhpTmc2LzVWWk42ZU91Zk5pS1BXMUh3?=
 =?utf-8?B?YktWSVloTXJ4MDRJQlR1cnJOSlQxT21RSWhzWEovQ0twRzVpeFQ1dEZTSHhq?=
 =?utf-8?B?MmgreUowdW1IVmtENy9WdzNBNGhHb1JnT1JvdTR1N0F6Q2cvN21iSFVRT25B?=
 =?utf-8?B?eWV5WFBDUDJSbjNLaTY1MEpGZnREdFVmTGdSSlpxYnNSVnJBUVRsOTcvbHF3?=
 =?utf-8?B?SDhud29CRUJvVEVDNXRJUHFMRlk3NzdCRXBiZ3RzMjgzdU1rS2E4Q090dEhj?=
 =?utf-8?B?b3pHOUdyb2lBQzQ5ak9zSnhoNjZob1pCanVzM3VtWlcwRWh2Q3pJamVXT1JC?=
 =?utf-8?B?M0Zaa1c3V1ZGaUZEZXBOVi9Gcm9qUVdoTGVrSVJ1dXlERFhBQTZkM1lCRGwz?=
 =?utf-8?Q?m/EPhCglnyIsaytdZY=3D?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <5D490737A947FD438E76FD3A7CD005C7@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB3479.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 56b9ab04-be93-48c2-ff01-08d8fa02d1fc
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Apr 2021 20:22:09.1523
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8u0sRCv89PpMGwO+lxRi48f2QvCq267xzOqCACmxyb8wbVjpf3W6ctmmh+kI4q4Gs2ndgaS43BuIBfStt6fK1Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3351
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMy8yMy8yMSAxMDo1MiBQTSwgQmhhc2thciBDaG93ZGh1cnkgd3JvdGU6DQo+IHMvdW5jb25k
aXRvbmFsbHkvdW5jb25kaXRpb25hbGx5Lw0KPiBzL2dhdXJhbnRlZXMvZ3VhcmFudGVlcy8NCj4N
Cj4gU2lnbmVkLW9mZi1ieTogQmhhc2thciBDaG93ZGh1cnkgPHVuaXhiaGFza2FyQGdtYWlsLmNv
bT4NCg0KQW5kIHRoaXMgb25lIHRvby4NCg0KVGh4LA0KLVZpbmVldA0KDQo+IC0tLQ0KPiAgIGFy
Y2gvYXJjL2tlcm5lbC9zaWduYWwuYyB8IDQgKystLQ0KPiAgIDEgZmlsZSBjaGFuZ2VkLCAyIGlu
c2VydGlvbnMoKyksIDIgZGVsZXRpb25zKC0pDQo+DQo+IGRpZmYgLS1naXQgYS9hcmNoL2FyYy9r
ZXJuZWwvc2lnbmFsLmMgYi9hcmNoL2FyYy9rZXJuZWwvc2lnbmFsLmMNCj4gaW5kZXggYTc4ZDhm
NzQ1YTY3Li5jZjE3ODhmZDM4MTIgMTAwNjQ0DQo+IC0tLSBhL2FyY2gvYXJjL2tlcm5lbC9zaWdu
YWwuYw0KPiArKysgYi9hcmNoL2FyYy9rZXJuZWwvc2lnbmFsLmMNCj4gQEAgLTI1OSw3ICsyNTks
NyBAQCBzZXR1cF9ydF9mcmFtZShzdHJ1Y3Qga3NpZ25hbCAqa3NpZywgc2lnc2V0X3QgKnNldCwg
c3RydWN0IHB0X3JlZ3MgKnJlZ3MpDQo+ICAgCQlyZWdzLT5yMiA9ICh1bnNpZ25lZCBsb25nKSZz
Zi0+dWM7DQo+DQo+ICAgCQkvKg0KPiAtCQkgKiBzbWFsbCBvcHRpbSB0byBhdm9pZCB1bmNvbmRp
dG9uYWxseSBjYWxsaW5nIGRvX3NpZ2FsdHN0YWNrDQo+ICsJCSAqIHNtYWxsIG9wdGltIHRvIGF2
b2lkIHVuY29uZGl0aW9uYWxseSBjYWxsaW5nIGRvX3NpZ2FsdHN0YWNrDQo+ICAgCQkgKiBpbiBz
aWdyZXR1cm4gcGF0aCwgbm93IHRoYXQgd2Ugb25seSBoYXZlIHJ0X3NpZ3JldHVybg0KPiAgIAkJ
ICovDQo+ICAgCQltYWdpYyA9IE1BR0lDX1NJR0FMVFNUSzsNCj4gQEAgLTM5MSw3ICszOTEsNyBA
QCB2b2lkIGRvX3NpZ25hbChzdHJ1Y3QgcHRfcmVncyAqcmVncykNCj4gICB2b2lkIGRvX25vdGlm
eV9yZXN1bWUoc3RydWN0IHB0X3JlZ3MgKnJlZ3MpDQo+ICAgew0KPiAgIAkvKg0KPiAtCSAqIEFT
TSBnbHVlIGdhdXJhbnRlZXMgdGhhdCB0aGlzIGlzIG9ubHkgY2FsbGVkIHdoZW4gcmV0dXJuaW5n
IHRvDQo+ICsJICogQVNNIGdsdWUgZ3VhcmFudGVlcyB0aGF0IHRoaXMgaXMgb25seSBjYWxsZWQg
d2hlbiByZXR1cm5pbmcgdG8NCj4gICAJICogdXNlciBtb2RlDQo+ICAgCSAqLw0KPiAgIAlpZiAo
dGVzdF90aHJlYWRfZmxhZyhUSUZfTk9USUZZX1JFU1VNRSkpDQo+IC0tDQo+IDIuMzAuMQ0KPg0K
DQo=
