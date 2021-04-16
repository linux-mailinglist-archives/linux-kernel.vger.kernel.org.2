Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B4C1361970
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Apr 2021 07:47:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238614AbhDPFqt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Apr 2021 01:46:49 -0400
Received: from smtprelay-out1.synopsys.com ([149.117.87.133]:54144 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236793AbhDPFqp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Apr 2021 01:46:45 -0400
Received: from mailhost.synopsys.com (us03-mailhost1.synopsys.com [10.4.17.17])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 1BE41C06A8;
        Fri, 16 Apr 2021 05:46:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1618551981; bh=pYVu+fyk48Z/JrUthJOl90bvsW/smMRvlVXz4gQns1I=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=GGw9QpYsfH0xpoDqW5Pz/Nkg9d3JmTYqdwuWtCE0vnrdVLvhXhVW9dipzbgvN8i5g
         XaV+2spZGQOmdRFmAVMVPT/sgnDPLoBkHXpTySsQFla0z+vY/YjZ7ByQClg81qjums
         1+LfjFmtHxJhlEBQq5/S3xm6Mp/Pr5Tu54/E8DXP467ry1f67EWqqieLTqWUIgSL3K
         D5SHTVFe6WmUvspFCtGVE5Np6QjHf7Sn9VBkXV+FvqhN5FXZkH+CCDPD47RKxP5sQu
         Kem2FOybFvYt5KxcRMOD4gd4b2EmFM5U7bvelzT3jp7NrwnTte3qiKtRMClTs7Zwbc
         H/xfb2gso3Rhw==
Received: from o365relay-in.synopsys.com (sv2-o365relay1.synopsys.com [10.202.1.137])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by mailhost.synopsys.com (Postfix) with ESMTPS id 7160FA0082;
        Fri, 16 Apr 2021 05:46:20 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2169.outbound.protection.outlook.com [104.47.59.169])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
        by o365relay-in.synopsys.com (Postfix) with ESMTPS id A1E22400DF;
        Fri, 16 Apr 2021 05:46:19 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=arturp@synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
        dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.b="Y+alVUDd";
        dkim-atps=neutral
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=c6BHO+JnfrH2yD+tE+CA2HymYvrHblMVMD5hvM7WP8NXIXUtb4RlztFIXo/DRY0di+yhVvT2BeVS/BMXWx9bN+fDv3gZYODWneC+7AvjrVifQaNWb4FkDO2QURLFQI4I7hpoWHPRTiFBAGjYIWinwcNsWP+rfPeOkPny1u7uxcTb4D4I0ZWcwQ1J7LEOHMzgWHT04qhCO63dpc42agU5AgRpVACIKytKr9BP81hrHBl+sKdM4BgWWAW5jXEiUfxKm+JLGanLFbFPN++pxHd4ST4X9HBQTo5rQ+s3NWn9LzXpGUvmkrdYGxDMTDEyp14tdKTDcudOzeoqCtjy6ePe+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pYVu+fyk48Z/JrUthJOl90bvsW/smMRvlVXz4gQns1I=;
 b=Z4kf+BEmaIiPcnmHFrABmlbuY66LHe4ZPzrD0bjIVsSIb5yl9WHcuAkr8OkMv7Ixqu5axMEMYwqjnVN9xCPPS4N3vOvCEKE2dN635N3ih4zk3xnFAHvDsN4ZKm/dSgAHVFvfpiGisNngVegz9IP4qjxihxfKhw6jwov3ZOZLusewpAn2GXw3HkU2tGg4yPmlzOviDNiNqPVkUG5FuOG7oEDdkOHIs4bMg/HyJosi8YiWV/NBZWH5kBhc8KxIQ5Ys7FqGF/AuuuAHGrKllNLMCtDmHpOopIn/eE7UzKmveizIDo7ANILE9NApMvo25gODj+5m3hQZe8Ga+3W82f/wtw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pYVu+fyk48Z/JrUthJOl90bvsW/smMRvlVXz4gQns1I=;
 b=Y+alVUDdeGM6Sj4gWtzAIYbVFQP4jaDBBjbIi3YsnUZrMnt4S0IupztjZZXoym2X7AJbcA8vu89RspLTT+rJcQva/QBPE6f4qEFDqj10nKUIhss9hRDHtvVY8dSF3leVouetipCFH/6eg2mtUZhmyzC14PHvi9bWllKtWnIIbrs=
Received: from CH0PR12MB5265.namprd12.prod.outlook.com (2603:10b6:610:d0::22)
 by CH0PR12MB5314.namprd12.prod.outlook.com (2603:10b6:610:d5::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4042.16; Fri, 16 Apr
 2021 05:46:17 +0000
Received: from CH0PR12MB5265.namprd12.prod.outlook.com
 ([fe80::b1a0:f306:3b5a:7f0c]) by CH0PR12MB5265.namprd12.prod.outlook.com
 ([fe80::b1a0:f306:3b5a:7f0c%7]) with mapi id 15.20.4042.019; Fri, 16 Apr 2021
 05:46:17 +0000
X-SNPS-Relay: synopsys.com
From:   Artur Petrosyan <Arthur.Petrosyan@synopsys.com>
To:     Sergei Shtylyov <sergei.shtylyov@gmail.com>,
        Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Minas Harutyunyan <Minas.Harutyunyan@synopsys.com>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     John Youn <John.Youn@synopsys.com>
Subject: Re: [PATCH 13/15] usb: dwc2: Add exit hibernation mode before
 removing drive
Thread-Topic: [PATCH 13/15] usb: dwc2: Add exit hibernation mode before
 removing drive
Thread-Index: AQHXMbnwG6GKyZcwnk+18ZkVNbr0Iaq1TsWAgAFVaQA=
Date:   Fri, 16 Apr 2021 05:46:17 +0000
Message-ID: <30efe9e7-d132-75a4-f76a-48aaeb6400f4@synopsys.com>
References: <cover.1618464534.git.Arthur.Petrosyan@synopsys.com>
 <d01d23e2473407af37c42acb6ca4815ae5fd256e.1618464534.git.Arthur.Petrosyan@synopsys.com>
 <6e51ca4c-b479-5ccb-59bd-a767db7118ec@gmail.com>
In-Reply-To: <6e51ca4c-b479-5ccb-59bd-a767db7118ec@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=synopsys.com;
x-originating-ip: [46.162.196.54]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b6cb42ed-0813-4e97-303d-08d9009af486
x-ms-traffictypediagnostic: CH0PR12MB5314:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CH0PR12MB5314EFF5672FC901AD4F92EBA74C9@CH0PR12MB5314.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: sk6lp7U59WsDxRDSox9hQMr5sjhGxx4BaVTJqJOPUQRYQYpswpgShiZ4fH6w0FlpPMLxXFdES7QaWJ9BgB1b76xY4wf4LyzhXFB7BjBBD+cdo79Nimu2ApU46w3G0RdcUyZHN1KbGCqRXZT9ySekGl8puujHNYgdgs2lw9SjrCHADotO7zcp/AI8RnJg1XHZ7CY4/grkRDShKM651n5mzIacPwkbhH4tviTVHvtYNhg2Qkn29fNcs2cC2Cal12O8ncE+hXoGTaw22gbIXZKHz1tCBTqQBs1f0yCwq6lGuSMuQ7Dy8j/uRCSHhW3jDlU3rsMKsDkaTJTeIZLw4cHhE8AGE+vE8Q1lW7CsZWBOa3miGX7kUktZu4luJmnvX5YV/DDb2Jrxir8HixiGFA6lU92Y3xUCbVsUfJuNppaTAY+BKs9XhztuL38LntkPIRmrxX6KCiY7dbn+hZ6WaVFLBWyddtj5JHW9rk7aKUcYvR5JSkoT2ta1MwE8wDPATIKmhe2wqc9q81ggugbBWx9WTA6FHlKsebvwwIXwlh59tmamtRwij0oNYL4em4OTKCeE5qcemsxG0nSdNkw4dR+qcAdkeuClQSfDrpoLRmUM1FFteCCwMP1p8/gBhbfCPdHHkWpBnSgj+IzNihDfXnTphGD2LjI1PVAj6XVpf8MABh0=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR12MB5265.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(39860400002)(136003)(376002)(366004)(346002)(396003)(66446008)(76116006)(66946007)(91956017)(64756008)(316002)(66556008)(2906002)(66476007)(5660300002)(36756003)(71200400001)(110136005)(107886003)(8676002)(4326008)(86362001)(31696002)(122000001)(38100700002)(6512007)(8936002)(83380400001)(2616005)(26005)(53546011)(6506007)(478600001)(6486002)(31686004)(186003)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?utf-8?B?S0J3RTZXOGlNMjg1Ym9mSlNSUWNnenp5REtrK0diaExEV1Q1cGd3TElTM1Nr?=
 =?utf-8?B?bjVtUk1IcFJTaHA4Rnp2V3lNK0dVQlJicE5TOHZpMlRxQlliWnFwVktoQWxL?=
 =?utf-8?B?T1IvQTdETG1VWUJNeEZSNXJLNmFZOEorcngzNmJKSXJyL0U1WVU2SmRSQnlX?=
 =?utf-8?B?MWlhZ0tZYXhuUDljbUJhYk96V3k5M1JhNGwyVCtIV0p3bmF3QmRzczZJY3g0?=
 =?utf-8?B?c1ZqSlovY05PMUxrVFdOalVoM1IrMkJWa2FoYzdyLy9SRDkxdlIrY3hYZ0xD?=
 =?utf-8?B?OUZGbDRxem1WeEY0bm4xSEdtTFIyYlRuRnAxU1lyM0k4eDNTZ2ltVjRPWFpH?=
 =?utf-8?B?RlpPcGZLN3FhVm5LVTRpTm1laElTZ010ZE82bkJ5aW95cDZDNm1saHdVWEti?=
 =?utf-8?B?RGh5bVBLTHpya2FaSllTWEpFRU9XK0VzcnVRdSsxWnJLMUFkaEUva2RRcVBM?=
 =?utf-8?B?NlRIT2xXSlVjaG00clVzMzUzaGoyV0Nkb051MEhtb0g0aEhyejZqdE1jY01p?=
 =?utf-8?B?ck9NcnJLRWZvbFBkRFZ1N3hqYTNGblRtN0pFZXpuR09KSzFSdGR5K0ZpNzAv?=
 =?utf-8?B?NnBrd2tkd1JHZ3V6bVFieEk0ZjJNclhKcDVSREgweHBoMzZYdS9DNnZ1U2sx?=
 =?utf-8?B?K3R4dkIrMW5mK1cyMEVtV2d4YUFkQ2NscmpTQmhoRmJ4VFppWTJBT1NzTGZj?=
 =?utf-8?B?c01JU1BjcHFRZnhoZWdqSjRjRld2Ujd1NEhtb2Y3SnFpcW9NZXp5WUd5eFk1?=
 =?utf-8?B?QUdaMDEzOTN5YjlvOGFBTGhpTjdDQW8rNGE4bWFxSWI1YTg3OGluYk85SUdy?=
 =?utf-8?B?QWlmbnBTNHc5YS9XQmp5Mm8vZzRKaHdKd2NGeSs4VXRpRm1hbmhIcmhORE5R?=
 =?utf-8?B?WFpwY1JFY2ppSzFhTnE2NzNGWTd4UHpvaUxmT25LZnREKzFqR2ptNm1xZmZR?=
 =?utf-8?B?QTBwT3hSQUQ1VWF4WXZjRkFnQjFzZng4b0xJK0IxT1JkRWl3VWl1Q1I4M0dv?=
 =?utf-8?B?bWJBYXF3bXVCYkpWTkVlaDMxTE04OXFwWFFkamQ1THJjM3VBN205b1ByZ01Q?=
 =?utf-8?B?RHNEWi9uL3hhV1U0VktBMU1Pc1B6c0l5UjA0d2NRZjBsS0g1ci9JY1JXeWxF?=
 =?utf-8?B?eUhRRkdPYkpOT3JSbmVFL1hySEppdlpFcGhHZkdhVWk3akpSbHpKb3lvVUx3?=
 =?utf-8?B?V3pLdmNJbVBURGFGWkNPRXlRTE9IWFBEZjJTa1pObFdDL0pRZUs0ZmJEVmkr?=
 =?utf-8?B?cVZaYUtDWjBPaWlGRGt2Y2hGYjYxZERUWXJRdUtPeEtQU2lGUkZvZXdLN29S?=
 =?utf-8?B?V003dlNpVnRaaTdCbEUydGltVnk4TXBPbTQrc2tCMUpxN1Y5NSs0d2RSbWJO?=
 =?utf-8?B?aVdWNjNaU3dwTUtSckx1a2tvYXlPbnBGMk9OL0haUlR4b0lCUTRDdERYNnRL?=
 =?utf-8?B?WHFrVlFVR0lKTHl6VTFpY1JUTzdaalU1ek1MZ2Znbmx3WUxYTkJvcXY5TVdZ?=
 =?utf-8?B?VG1jS1FhZ0pXTG0rQ3dPd1dmd0J0c1VaVWFYdkFRUnBkWUNkZit2SjNNcWFZ?=
 =?utf-8?B?SVV6bk1zVFR3VVBFMlY3Z2hELzlJc3BLdHdUaHhSNTZ3OWNtb0Z0S1lCNGNX?=
 =?utf-8?B?ZDgrd1FubHNTQTlFVFJNUE9oUHVRTTIrZU1oK0lUR3NJaEtQcmxwVEdIUWxZ?=
 =?utf-8?B?ZWtISlp3aXNISFF6QzV1Qlhoem5BWTJGbERuNTlOTzJ1U1Uzb1h6eXVEQ2JF?=
 =?utf-8?Q?ee09t6zaz1Jzf/uWOo=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <41C51091A6F4394C8826F1D07FFE4A57@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR12MB5265.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b6cb42ed-0813-4e97-303d-08d9009af486
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Apr 2021 05:46:17.5406
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: N66H6+vaM6zGRCIEN7Jhps8gWfYd04nS2PEX/FRqBueg8UjQKgjrTj5J0C4GKjbsqVeAf/uAAvR7UleGxgFyCw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5314
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgU2VyZ2VpLA0KDQpPbiA0LzE1LzIwMjEgMTM6MjQsIFNlcmdlaSBTaHR5bHlvdiB3cm90ZToN
Cj4gT24gMTUuMDQuMjAyMSA4OjQxLCBBcnR1ciBQZXRyb3N5YW4gd3JvdGU6DQo+IA0KPj4gV2hl
biBkd2MyIGNvcmUgaXMgaW4gaGliZXJuYXRpb24gbW9kZSBsb2FkaW5nDQo+PiBkcml2ZXIgYWdh
aW4gY2F1c2VzIGRyaXZlciBmYWlsLiBCZWNhdXNlIGluDQo+PiB0aGF0IG1vZGUgcmVnaXN0ZXJz
IGFyZSBub3QgYWNjZXNzaWJsZS4NCj4+DQo+PiBJbiBvcmRlciB0byBleGl0IGZyb20gaGliZXJu
YXRpb24gY2hlY2tpbmcNCj4+IGR3YzIgY29yZSBwb3dlciBzYXZpbmcgc3RhdGUgaW4gImR3YzJf
ZHJpdmVyX3JlbW92ZSgpIg0KPj4gZnVuY3Rpb24uIElmIGNvcmUgaXMgaW4gaGliZXJuYXRpb24s
IHRoZW4gY2hlY2tpbmcgdGhlDQo+PiBvcGVyYXRpb25hbCBtb2RlIG9mIHRoZSBkcml2ZXIuIFRv
IGNoZWNrIHdoZXRoZXIgZHdjMiBjb3JlDQo+PiBpcyBvcGVyYXRpbmcgaW4gaG9zdCBtb2RlIG9y
IGRldmljZSBtb2RlIHRoZXJlIGlzIG9uZSB3YXkNCj4+IHdoaWNoIGlzIHJldHJpZXZpbmcgdGhl
IGJhY2t1cCB2YWx1ZSBvZiAiZ290Z2N0bCIgYW5kIGNvbXBhcmUNCj4+IHRoZSAiQ3VyTW9kIiB2
YWx1ZS4gSWYgcHJldmlvdXNseSBjb3JlIGVudGVyZWQgaGliZXJuYXRpb24NCj4+IGluIGhvc3Qg
bW9kZSB0aGVuIHRoZSBleGl0IGlzIHBlcmZvcm1lZCBmb3IgaG9zdCBpZiBub3QgdGhlbg0KPj4g
ZXhpdCBpcyBwZXJmb3JtZWQgZm9yIGRldmljZSBtb2RlLiBUaGUgaW50cm9kdWNlZCBjaGVja2lu
Zw0KPj4gaXMgYmVjYXVzZSBpbiBoaWJlcm5hdGlvbiBzdGF0ZSBhbGwgcmVnaXN0ZXJzIGFyZSBu
b3QNCj4+IGFjY2Vzc2libGUuDQo+Pg0KPj4gU2lnbmVkLW9mZi1ieTogQXJ0dXIgUGV0cm9zeWFu
IDxBcnRodXIuUGV0cm9zeWFuQHN5bm9wc3lzLmNvbT4NCj4+IC0tLQ0KPj4gICAgZHJpdmVycy91
c2IvZHdjMi9wbGF0Zm9ybS5jIHwgMTYgKysrKysrKysrKysrKysrKw0KPj4gICAgMSBmaWxlIGNo
YW5nZWQsIDE2IGluc2VydGlvbnMoKykNCj4+DQo+PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy91c2Iv
ZHdjMi9wbGF0Zm9ybS5jIGIvZHJpdmVycy91c2IvZHdjMi9wbGF0Zm9ybS5jDQo+PiBpbmRleCBm
OGI4MTljZmE4MGUuLjJhZTQ3NDhlZDVlYyAxMDA2NDQNCj4+IC0tLSBhL2RyaXZlcnMvdXNiL2R3
YzIvcGxhdGZvcm0uYw0KPj4gKysrIGIvZHJpdmVycy91c2IvZHdjMi9wbGF0Zm9ybS5jDQo+PiBA
QCAtMzE2LDggKzMxNiwyNCBAQCBzdGF0aWMgaW50IGR3YzJfbG93bGV2ZWxfaHdfaW5pdChzdHJ1
Y3QgZHdjMl9oc290ZyAqaHNvdGcpDQo+PiAgICBzdGF0aWMgaW50IGR3YzJfZHJpdmVyX3JlbW92
ZShzdHJ1Y3QgcGxhdGZvcm1fZGV2aWNlICpkZXYpDQo+PiAgICB7DQo+PiAgICAJc3RydWN0IGR3
YzJfaHNvdGcgKmhzb3RnID0gcGxhdGZvcm1fZ2V0X2RydmRhdGEoZGV2KTsNCj4+ICsJc3RydWN0
IGR3YzJfZ3JlZ3NfYmFja3VwICpncjsNCj4+ICAgIAlpbnQgcmV0ID0gMDsNCj4+ICAgIA0KPj4g
KwkvKiBFeGl0IEhpYmVybmF0aW9uIHdoZW4gZHJpdmVyIGlzIHJlbW92ZWQuICovDQo+PiArCWlm
IChoc290Zy0+aGliZXJuYXRlZCkgew0KPj4gKwkJaWYgKGdyLT5nb3RnY3RsICYgR09UR0NUTF9D
VVJNT0RFX0hPU1QpIHsNCj4+ICsJCQlyZXQgPSBkd2MyX2V4aXRfaGliZXJuYXRpb24oaHNvdGcs
IDAsIDAsIDEpOw0KPj4gKwkJCWlmIChyZXQpDQo+PiArCQkJCWRldl9lcnIoaHNvdGctPmRldiwN
Cj4+ICsJCQkJCSJleGl0IGhpYmVybmF0aW9uIGZhaWxlZC5cbiIpOw0KPj4gKwkJfSBlbHNlIHsN
Cj4+ICsJCQlyZXQgPSBkd2MyX2V4aXRfaGliZXJuYXRpb24oaHNvdGcsIDAsIDAsIDApOw0KPj4g
KwkJCWlmIChyZXQpDQo+PiArCQkJCWRldl9lcnIoaHNvdGctPmRldiwNCj4+ICsJCQkJCSJleGl0
IGhpYmVybmF0aW9uIGZhaWxlZC5cbiIpOw0KPiANCj4gICAgICBBZ2Fpbiwgd2h5IGR1cGxpY2F0
ZSB0aGUgaW5uZXJtb3N0ICppZio/DQpBZ2FpbiB0aGUgcmVhc29uIGlzIHRoYXQgY29tYmluYXRp
b24gb2YgaW5uZXIgYW5kIG91dHNpZGUgaWZzIHdvdWxkIGdpdmUgDQphcyBhIHNpdHVhdGlvbiB3
aGVuIGNvcmUgd291bGQgbm90IGJlIGhpYmVybmF0ZWQgYnV0IGRyaXZlciB3b3VsZCB0cnkgdG8g
DQpleGl0IGZyb20gaG9zdCBvciBkZXZpY2UgaGliZXJuYXRpb24uDQoNCj4gDQo+PiAgICsJCX0N
Cj4+ICsJfQ0KPj4gKw0KPj4gICAgCS8qIEV4aXQgUGFydGlhbCBQb3dlciBEb3duIHdoZW4gZHJp
dmVyIGlzIHJlbW92ZWQuICovDQo+PiAgICAJaWYgKGhzb3RnLT5pbl9wcGQpIHsNCj4+ICAgIAkJ
cmV0ID0gZHdjMl9leGl0X3BhcnRpYWxfcG93ZXJfZG93bihoc290ZywgMCwgdHJ1ZSk7DQo+IA0K
PiBNQlIsIFNlcmdlaQ0KPiANClJlZ2FyZHMsDQpBcnR1cg0K
