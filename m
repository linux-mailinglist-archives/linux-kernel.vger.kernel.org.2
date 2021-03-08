Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6AB65330EC7
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Mar 2021 14:00:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229917AbhCHM7l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Mar 2021 07:59:41 -0500
Received: from mx0a-0014ca01.pphosted.com ([208.84.65.235]:34182 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229551AbhCHM70 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Mar 2021 07:59:26 -0500
Received: from pps.filterd (m0042385.ppops.net [127.0.0.1])
        by mx0a-0014ca01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 128CvbTv020428;
        Mon, 8 Mar 2021 04:59:22 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=proofpoint;
 bh=Or/A1ikrvw7Hul8WVE+CZs4d4k1TmZJaXbKjosGZKwA=;
 b=E4hhfyKbb/mnyZcO+k5KR9ctEpfXSkpvzFKnP0NCkjWnAlxlG9RrRfG6a16cDtzT+OvZ
 x1fK5nmswPDcA198irrq2HBFRXhlq5eXdwp+cTj+JKULAHYqSfYqb0jozzl+4CZ6qmh/
 5YssGg43LMw6RcqZOKbfPyFGXdfE5gELnm440ma0ZJ34DNM1cPkbGPoS6GLd4JjiWJsG
 2TmanTSedfDzQEp0WV734l+SUThPxo7nu9BI9eS2kQ3m/mfuIABHUdELItjBX2dt6q1B
 vSazFgPiCE5rH9EyWOCpuoi2Fzx8VOYMlMcfQrF9/vAPYTnT9YHZdtX0vEkbNZ9ErRh2 SA== 
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2106.outbound.protection.outlook.com [104.47.55.106])
        by mx0a-0014ca01.pphosted.com with ESMTP id 374762vvwn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 08 Mar 2021 04:59:21 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Do3+I547ELesEU52BAIFOgQg9ZfzWVft1B63AJUna62hThA6WXmariiKGXpSog0RLaP1zF8G1NbxAdfCSFtRa1ixaWxSu3CezK0U+E86oJOsLwuWQ3a3tdBG04zUj/OBBTZ5FH5d5JABnez9FWcYNzj6dlR4FpvqzfpgJXzmEcwYDqbRvWI4DfVhOQNW3ajOEi56dHauMi8PJjUUQ4GgLv5afqi6yHAr17CKzbKz5p6GuWOl/dn9c5dOTzEYk7wced+NX+iBri8pRTtsV5fvLnjF017IDtHo1iUw7a2y3i9vwLgfHc0GE/lJbu/gBYQgxdHf6GBkj8+puTOTE0Za9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Or/A1ikrvw7Hul8WVE+CZs4d4k1TmZJaXbKjosGZKwA=;
 b=KHMn86AXgnCPuysm87INQs1MokD7Rq3fSJwaYfO3HEKUo/6t1c7zztjiBdvgZwfcQT0oovjcuaDFIeP7CGd2yIN3S+mn5el7Jgh+FnSnwPMaodje/YKiYse80+7BTtav8P9IiR/O5Hy3SnmvpcPRC68tsOXQDhdcg8ktiOhbNCOS1q892kzBhU8JyVBop2KHy1jlYn+IM4pPP/jI3a6SE65exn+VrCPRSYUAgYnafpNHU5Y3TAIt9+JRHIt9gNdoEUZyb315DjtjoAWaUsZoFAx3piQF4lyu40GsOki1eYtv0sDJDBTmdlt3NxGfOfJ6/ndYDn+OBoj8V+2FjGvI/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cadence.com; dmarc=pass action=none header.from=cadence.com;
 dkim=pass header.d=cadence.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Or/A1ikrvw7Hul8WVE+CZs4d4k1TmZJaXbKjosGZKwA=;
 b=a2dczhxjfebe5S/i/n31gRsuYXtFKEFG1QNAUllP2wtA/qedD26UzuBtF691tfVlQ4T6on60NAkhuv/6elfnQzZvQM9DL+0HPaRQodP+AdcbbBxWKtsqYJNM1qSyVqRKpEOccZR5XTohnZN9bgKq67r7XXQQvkX+R27qtjyxSVI=
Received: from BYAPR07MB5381.namprd07.prod.outlook.com (2603:10b6:a03:6d::24)
 by BYAPR07MB5574.namprd07.prod.outlook.com (2603:10b6:a03:9d::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.23; Mon, 8 Mar
 2021 12:59:16 +0000
Received: from BYAPR07MB5381.namprd07.prod.outlook.com
 ([fe80::5a:c16d:31b1:bcd0]) by BYAPR07MB5381.namprd07.prod.outlook.com
 ([fe80::5a:c16d:31b1:bcd0%7]) with mapi id 15.20.3890.038; Mon, 8 Mar 2021
 12:59:15 +0000
From:   Pawel Laszczak <pawell@cadence.com>
To:     Peter Chen <hzpeterchen@gmail.com>
CC:     "balbi@kernel.org" <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        USB list <linux-usb@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        "laurent.pinchart@ideasonboard.com" 
        <laurent.pinchart@ideasonboard.com>
Subject: RE: [PATCH] usb: gadget: uvc: add bInterval checking for HS mode
Thread-Topic: [PATCH] usb: gadget: uvc: add bInterval checking for HS mode
Thread-Index: AQHXEOxGZWqwmYnLykyxBly6kdc+cap34W8AgAHiinCAAE58MA==
Date:   Mon, 8 Mar 2021 12:59:15 +0000
Message-ID: <BYAPR07MB5381C20420DE2EEEA6C8B5EFDD939@BYAPR07MB5381.namprd07.prod.outlook.com>
References: <20210304104515.35933-1-pawell@gli-login.cadence.com>
 <CAL411-p4C4F9K--U=C+Yhu7Uy6GxOxwCHpXtdrXYMObLegFm9Q@mail.gmail.com>
 <BYAPR07MB5381E3BFF03139C805E6EDF5DD939@BYAPR07MB5381.namprd07.prod.outlook.com>
In-Reply-To: <BYAPR07MB5381E3BFF03139C805E6EDF5DD939@BYAPR07MB5381.namprd07.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNccGF3ZWxsXGFwcGRhdGFccm9hbWluZ1wwOWQ4NDliNi0zMmQzLTRhNDAtODVlZS02Yjg0YmEyOWUzNWJcbXNnc1xtc2ctMTJiNTlhNDUtODAwZS0xMWViLTg3ODYtMWM0ZDcwMWRmYmE0XGFtZS10ZXN0XDEyYjU5YTQ3LTgwMGUtMTFlYi04Nzg2LTFjNGQ3MDFkZmJhNGJvZHkudHh0IiBzej0iMjg3MiIgdD0iMTMyNTk2ODE5NTA2ODgwNTI1IiBoPSJIMG1aSWI4SmpiNjc3ZllkNHFlcngvWXhuY1k9IiBpZD0iIiBibD0iMCIgYm89IjEiLz48L21ldGE+
x-dg-rorf: true
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=cadence.com;
x-originating-ip: [185.217.253.59]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 0064ec06-74a4-4b61-e8d7-08d8e231fa92
x-ms-traffictypediagnostic: BYAPR07MB5574:
x-microsoft-antispam-prvs: <BYAPR07MB557450D4B2899AED2A368D3ADD939@BYAPR07MB5574.namprd07.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: UivJaYxqYGVkqgHycBIlpc3anC2eVLxsDiZdb9xc2HpEJ0kqNZ6HeVVE7PEeZmk9s2X3c52eO4HCF4mK5hEJOleIXfTs4r7Zc8uHp0D48Vs8C+D3MmNoHOHKF+Lnqr638HSO7ewVU6f63GHYLKcOdAe3iO7QhEIV1JdLFNwEM/P28SWRLffZ25RDSFPrTctdYkMAE2USTClG6NJIISWsVi9a4+NX8a5jXbT4jFCt05YsnnYyirsitbchhVZwbVkRWefILGmlE34TitDJ3YeMVFzSsLxORbMSEO/QgbLlYwnTljRe1S7tfL978L1F4O6ql4wgUXXvCo1pOWVN0D33kLciNvXmoOjA7LUmWHDaPRSYamac38G4y73/VJYKB5mZVrIqGk6EXbqvU/jF3aWvXCMeJTr5hmfIES2ztGL6fTvWTAQwzcAgglDSWEmih4y8t03J+op6tNt+5C8EvT4pXDBW/cqHWaLAirlxaEA7qYTyqpCMLYpeoSspylFDffC6yxo4PtNqJCI77hQefCTLgquBDDpF4UHdJoBooFlK82zgqBrrSciAaHozHOCZ3Ws8nGHU9BvvdkULdCHW86ouAQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR07MB5381.namprd07.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(36092001)(54906003)(6506007)(66556008)(66476007)(66946007)(66446008)(52536014)(55016002)(7696005)(2940100002)(8676002)(64756008)(71200400001)(76116006)(5660300002)(186003)(8936002)(33656002)(86362001)(9686003)(498600001)(4326008)(26005)(2906002)(6916009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?utf-8?B?Vk1HRWtVRFZ5NnhldHJXTHRtdFlFMHZzR3VxNnN3THRVblgvU0svV3hIWXor?=
 =?utf-8?B?MHVmMHpENU03UnB2dFU3VWlwczJIbk9vYnFHMHR0S1dyZDRrT0Yvb3hmU3NM?=
 =?utf-8?B?VjhYcXpiNEJuYTBwc0lrTERRanZMTGo2ZzRRcnF6akhmNlY1Z0hCK3NZTVpr?=
 =?utf-8?B?SGJJWEFrVTgxTWc4K0JsTUE0NENnN0haVlpQSm5TdUlYeWh4ZDBiaWM3eldR?=
 =?utf-8?B?Q3dneXFveDY5V1VyZnMzVElBQSsyQUpuSE9JQWROV3BQTEZ1NSswcVJKak5s?=
 =?utf-8?B?QURxY2RkOXNPMmt2VEQ1aHJldkVXS21PUGEzZ1R2NFU1QW9HNDlXYmUzTGh4?=
 =?utf-8?B?YjU0ZVNMWTdIcEJjTUI5K0tkNmVGWEFPMTJRTTVidkFGQzAxckFUMWphUDVs?=
 =?utf-8?B?WjZDbGxKM01CWlc1Uzl4ZHJtMHpIR054ZUIzYmk4Q1VuSHgrOHJkdDlNdkNT?=
 =?utf-8?B?WEhGVFZISUNVWUxMS2tWOUw1RWVaMDFmUWdIc2JtdE5ERXByclhrT3l6Mkxh?=
 =?utf-8?B?U3ZndkdIT2VoQ1dyaHpSSmZKT0c0b04wUXlqTXhTeHhvZEtHY050S1Q2RlVt?=
 =?utf-8?B?bklzbUtGSmZwQnF4TjA2dlhta2tSZWFxYjRKcXFWY2FFTm03bGM3ZDhaTDk4?=
 =?utf-8?B?Rk90THpUbEdxQnVjRlptNE5SR01BNHVjb2E2Y05lZkcyd3lkZE41elZES3Rx?=
 =?utf-8?B?OGx6YWNHKzR0dzd0Z0FOdThRYXc0UDFtTVUrcVZBU1RYU24xNW1KV3NOVHVs?=
 =?utf-8?B?cWl3ZS9YSEpQMTV2Sm82QWVXaXdQaFpDTThaNjZFM2hIdzJPSVRIb01yZ0F2?=
 =?utf-8?B?eWpFOElaNGdycVk0TU9mYytSRVVkSWVrMWRDL0phVTZtNHVHdEtucmdnYVdS?=
 =?utf-8?B?QU1lMW9IMTJTZ0hld0l3WE82NnMwY0NQLzhjN3BNdnhLaDBkOWlOYUxuZExx?=
 =?utf-8?B?NVZkejVraDV2Wmp5QmxQQkNlRUJ0MU1Ua3VZSWZ1cm1aVFRWT2htWVJZUjhm?=
 =?utf-8?B?UE5XRVJiRlV3ZS9yVUF0SUFTd1F6bnA3Q0tkb1BCYjdObWhOVWZRaGpkSDdF?=
 =?utf-8?B?aWhCZ0RUbllXQUlRMG40MkZRRjN2SjF5UzRnVEJXY0s3RkEvN3NvUjlDM2RH?=
 =?utf-8?B?VDF5OVlmbjJsaXVzd2RrU1VuZUZoLy8rUEFzcmcrSmlydUg2ZFRLT0VmcExU?=
 =?utf-8?B?cHZSTEgyVkgwZ0dwM3YvNkd5SXpOVExidkZJTjFjRit2Vmt5SDJXK2k4RDdC?=
 =?utf-8?B?LzFqUTE3dXp5alFuQWgreVdjS3hEcVBncGxCb01oR3NjeHNvZHFyLzVHWkhx?=
 =?utf-8?B?OVFzc3BRSXdBM0ZlOEdWWEYrcDVqcmR1dktucS9QcmRiYm5XTzYrU3ZId3la?=
 =?utf-8?B?UkVJRnM0cUFBM1l4czIrRVRmNCthN2xIOUJBS0dzbWE0MjViK29IMlIwNFRX?=
 =?utf-8?B?NmhhN29ORHNWbjd2YkMrczR3SnVsSHFOSVFBVEdxZWhQNVhxaEd1VnQvbnRv?=
 =?utf-8?B?Z0N4OWxKQlFqYVN6SjNMbW81M3ZnZHBmNStXbGtSZi9iTE9YVnFSUGljOSt4?=
 =?utf-8?B?dDg4ZFNtWG9xV2NzczU5T05WN093OGZpYTRJa0dSNmVGSUNqOEZEK0pqZ0tq?=
 =?utf-8?B?cUd3SVdQLzNhekQ5VXdHWnNXRzVuNllaTG9PTEpBZVRJcGpjeThEMHRyQUxr?=
 =?utf-8?B?bDRGZm14aEtZaGkzSktybm9oSFppMnBzdXJvYWN1bGtHa1E4c1FCNUhpZnp3?=
 =?utf-8?Q?t/2EWlWCm0ZhPyEerPA34p+fJ3i17PEj05ybwcE?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR07MB5381.namprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0064ec06-74a4-4b61-e8d7-08d8e231fa92
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Mar 2021 12:59:15.6922
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: g6fD6WdTBQhd2M3u8X2pNiecSA+EpiTEQ/epmzv0Pzlf0OIQCrFQcR8Wcti9KxTxDyWe0oLrjHhSNNty1Oz8j7nWJ1cUPu2u49+wgk8/uak=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR07MB5574
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-03-08_08:2021-03-08,2021-03-08 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0
 lowpriorityscore=0 mlxscore=0 suspectscore=0 spamscore=0 clxscore=1015
 adultscore=0 phishscore=0 malwarescore=0 bulkscore=0 priorityscore=1501
 impostorscore=0 mlxlogscore=908 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2009150000 definitions=main-2103080069
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

UGV0ZXIsDQoNCllvdSdyZSByaWdodC4gVGhpcyBwYXRjaCBpcyB3cm9uZy4gSSBkaWRuJ3QgcmVt
b3ZlIHRoZSAidXZjX2hzX3N0cmVhbWluZ19lcC5iSW50ZXJ2YWwiDQphc3NpZ25tZW50LiANCg0K
SXQgaGFzIGJlZW4gZml4ZWQgaW4gdjIuDQoNClBhd2VsDQoNCj4+DQo+Pk9uIEZyaSwgTWFyIDUs
IDIwMjEgYXQgMTI6NDAgQU0gUGF3ZWwgTGFzemN6YWsgPG1haWx0bzpwYXdlbGxAY2FkZW5jZS5j
b20+IHdyb3RlOg0KPj5Gcm9tOiBQYXdlbCBMYXN6Y3phayA8bWFpbHRvOnBhd2VsbEBjYWRlbmNl
LmNvbT4NCj4+DQo+PlBhdGNoIGFkZHMgZXh0cmEgY2hlY2tpbmcgZm9yIGJJbnRlcnZhbCBwYXNz
ZWQgYnkgY29uZmlnZnMuDQo+PlRoZSA1LjYuNCBjaGFwdGVyIG9mIFVTQiBTcGVjaWZpY2F0aW9u
IChyZXYuIDIuMCkgc2F5Og0KPj4iQSBoaWdoLWJhbmR3aWR0aCBlbmRwb2ludCBtdXN0IHNwZWNp
ZnkgYSBwZXJpb2Qgb2YgMXgxMjUgwrVzDQo+PihpLmUuLCBhIGJJbnRlcnZhbCB2YWx1ZSBvZiAx
KS4iDQo+Pg0KPj5UaGUgaXNzdWUgd2FzIG9ic2VydmVkIGR1cmluZyB0ZXN0aW5nIFVWQyBjbGFz
cyBvbiBDVi4NCj4+SSB0cmVhdCB0aGlzIGNoYW5nZSBhcyBpbXByb3ZlbWVudCBiZWNhdXNlIHdl
IGNhbiBjb250cm9sDQo+PmJJbnRlcnZhbCBieSBjb25maWdmcy4NCj4+DQo+PlNpZ25lZC1vZmYt
Ynk6IFBhd2VsIExhc3pjemFrIDxtYWlsdG86cGF3ZWxsQGNhZGVuY2UuY29tPg0KPj4tLS0NCj4+
wqBkcml2ZXJzL3VzYi9nYWRnZXQvZnVuY3Rpb24vZl91dmMuYyB8IDYgKysrKysrDQo+PsKgMSBm
aWxlIGNoYW5nZWQsIDYgaW5zZXJ0aW9ucygrKQ0KPj4NCj4+ZGlmZiAtLWdpdCBhL2RyaXZlcnMv
dXNiL2dhZGdldC9mdW5jdGlvbi9mX3V2Yy5jIGIvZHJpdmVycy91c2IvZ2FkZ2V0L2Z1bmN0aW9u
L2ZfdXZjLmMNCj4+aW5kZXggNDRiNDM1MmEyNjc2Li41ZDYyNzIwYmI5ZTEgMTAwNjQ0DQo+Pi0t
LSBhL2RyaXZlcnMvdXNiL2dhZGdldC9mdW5jdGlvbi9mX3V2Yy5jDQo+PisrKyBiL2RyaXZlcnMv
dXNiL2dhZGdldC9mdW5jdGlvbi9mX3V2Yy5jDQo+PkBAIC02MzEsNiArNjMxLDEyIEBAIHV2Y19m
dW5jdGlvbl9iaW5kKHN0cnVjdCB1c2JfY29uZmlndXJhdGlvbiAqYywgc3RydWN0IHVzYl9mdW5j
dGlvbiAqZikNCj4+wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgY3B1X3RvX2xlMTYobWluKG9wdHMt
PnN0cmVhbWluZ19tYXhwYWNrZXQsIDEwMjNVKSk7DQo+PsKgIMKgIMKgIMKgIHV2Y19mc19zdHJl
YW1pbmdfZXAuYkludGVydmFsID0gb3B0cy0+c3RyZWFtaW5nX2ludGVydmFsOw0KPj4NCj4+K8Kg
IMKgIMKgIMKgLyogQSBoaWdoLWJhbmR3aWR0aCBlbmRwb2ludCBtdXN0IHNwZWNpZnkgYSBiSW50
ZXJ2YWwgdmFsdWUgb2YgMSAqLw0KPj4rwqAgwqAgwqAgwqBpZiAobWF4X3BhY2tldF9tdWx0ID4g
MSkNCj4+K8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgdXZjX2hzX3N0cmVhbWluZ19lcC5iSW50ZXJ2
YWwgPSAxOw0KPj4rwqAgwqAgwqAgwqBlbHNlDQo+PivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoHV2
Y19oc19zdHJlYW1pbmdfZXAuYkludGVydmFsID0gb3B0cy0+c3RyZWFtaW5nX2ludGVydmFsOw0K
Pj4rDQo+Pg0KPj5UaGVyZSBpcyBhICJ1dmNfaHNfc3RyZWFtaW5nX2VwLmJJbnRlcnZhbCA9IG9w
dHMtPnN0cmVhbWluZ19pbnRlcnZhbDsiIGFnYWluIGF0IGJlbG93IGNvZGUNCj4+QmVzaWRlcywg
dGhlIGRlZmF1bHQgdmFsdWUgaXMgMSBmb3LCoG9wdHMtPnN0cmVhbWluZ19pbnRlcnZhbC4gV2hh
dCB0aGUgcmVhbCBpc3N1ZSB5b3Ugb2JzZXJ2ZWQNCj4+YXQgQ1YgdGVzdD8NCj4+DQo+DQo+VGhl
IGlzc3VlIG9jY3VycyB3aGVuIEkgaW50ZW50aW9uYWxseSBzZXQ6DQo+ICAgICAgICBlY2hvIDMw
NzIgID4gZnVuY3Rpb25zLyRGVU5DVElPTi9zdHJlYW1pbmdfbWF4cGFja2V0DQo+ICAgICAgICBl
Y2hvIDQgPiBmdW5jdGlvbnMvJEZVTkNUSU9OL3N0cmVhbWluZ19pbnRlcnZhbA0KPg0KPlRoZW4g
Zm9yICBDViBDSDkgVEQgOS41OiBFbmRwb2ludCBEZXNjcmlwdG9yIHRlc3QgaXQgZ290Og0KPiIo
TXVsdCA9IDIpSWxsZWdhbCBoaWdoIHNwZWVkIGlzb2Nocm9ub3VzIGVuZHBvaW50IE1heFBhY2tl
dFNpemUgOiAweDQwMA0KPihVU0I6IDEuMi43OCkgQSBIaWdoIHNwZWVkIEludGVycnVwdC9Jc29j
aHJvbm91cyBlbmRwb2ludCBtdXN0IGhhdmUgYSBNYXhQYWNrZXRTaXplIGJldHdlZW4NCj42ODMg
YW5kIDEwMjQgYW5kIGJJbnRlcnZhbCB2YWx1ZSBvZiAxIHdoZW4gdGhlIE11bHQgdmFsdWUgaXMg
dHdvLiINCj4NCj5Gb3IgZGVmYXVsdCB2YWx1ZSBDViBwYXNzZWQuICBPZiBjb3Vyc2UsIEkgY2Fu
IGZpeCBpdCBieSBjaGFuZ2luZyAgc3RyZWFtaW5nX2ludGVydmFsLCBidXQgSSB0aG91Z2h0IHRo
YXQNCj5pdCBjb3VsZCBiZSBnb29kIHRvIGhhdmUgcHJvdGVjdGlvbiBhZ2FpbnN0IHRoaXMgaXNz
dWUuDQo+RXNwZWNpYWxseSBzaW5jZSBVc2IgMiBzcGVjaWZpY2F0aW9uIHNheSB0aGF0IGJJbnRl
cnZhbCBtdXN0IGJlIDEgZm9yIGhpZ2ggYmFuZHdpZHRoIGVuZHBvaW50cy4NCj4NCj5QYXdlbA0K
Pg0KPj5QZXRlcg0KPj4NCj4+wqAgwqAgwqAgwqAgdXZjX2hzX3N0cmVhbWluZ19lcC53TWF4UGFj
a2V0U2l6ZSA9DQo+PsKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIGNwdV90b19sZTE2KG1heF9wYWNr
ZXRfc2l6ZSB8ICgobWF4X3BhY2tldF9tdWx0IC0gMSkgPDwgMTEpKTsNCj4+wqAgwqAgwqAgwqAg
dXZjX2hzX3N0cmVhbWluZ19lcC5iSW50ZXJ2YWwgPSBvcHRzLT5zdHJlYW1pbmdfaW50ZXJ2YWw7
DQo+Pi0tDQo+PjIuMjUuMQ0KDQpUaGFua3MsDQpQYXdlbCBMYXN6Y3phaw0K
