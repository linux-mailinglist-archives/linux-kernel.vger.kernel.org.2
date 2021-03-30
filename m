Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E313434DF7A
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Mar 2021 05:38:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231300AbhC3Dhk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Mar 2021 23:37:40 -0400
Received: from mx0a-0014ca01.pphosted.com ([208.84.65.235]:7268 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231394AbhC3DhS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Mar 2021 23:37:18 -0400
Received: from pps.filterd (m0042385.ppops.net [127.0.0.1])
        by mx0a-0014ca01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 12U3MBkv030326;
        Mon, 29 Mar 2021 20:37:15 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=proofpoint;
 bh=9lWskBQq2fHDshRe3yJu9dRK5nWSBHc5xxHf2RAVqx4=;
 b=ZzuHAEG8ez82CTiRNTaO06lbi6ht0q0Xfe2AqF8q69qtn3zED+jYWBMKWlsfisdXdlnc
 aC+Sbjx4t98U2NMNlnxbgi4VpRvjN8qqD37j54nqq3wRdCdKYQ8KAs7C6lCdHYokpo+P
 sPho2FN9lFUFXBhY8gw7t7wT0EgrsxYo8+AaWOy8SnbaCZZB7TSC0vh1CrVMlUprP62L
 7SVd7V7mGePqO8uuYzr+wER5fcUDQQwmPF6unKTiSUHcA5hgaeFkzOh1sF/3qiNeJO9T
 FQjBHaabVnxLFeT3m1IyK2lU9n0UncLcw89agaDPw5VZW2b82G5kwdTT+H9KDKtBb8KL BA== 
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2171.outbound.protection.outlook.com [104.47.55.171])
        by mx0a-0014ca01.pphosted.com with ESMTP id 37khww1prf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 29 Mar 2021 20:37:15 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jJmLaCzNZ/3HqfRU8RHR8ibYgwbGIVZ/GVrI5GDEi9bmvxSbjPNieIi8RPczLDBOIlKkJxX4cIAEwmrSWcYDIZudpZ7bLeLdt8FEg9MdZGdXda9OnQPSoIzik7RtYEP4Tk9sH+KnRvDdhMrWsPTIEINVs/J5ioZDSvsgg0z80KIAGCmX+NGGiToe20Pt7aAnhgka5OCmyddXRfuNJafF450SOST4ePs+M9lMBId33pRe4kjb2ExH6vwE7OgHMRVc1wKwRn2jenhgbkpzFFYKRB6FSkES82/xOIhVNyv1a/bN2aiyTj7ALJuycOdlLgRFrNRQVQjcviLoSy1kQ4fKDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9lWskBQq2fHDshRe3yJu9dRK5nWSBHc5xxHf2RAVqx4=;
 b=ZIc+7Q0jNzWMZFuCUslOlc8wNdHGxMv7uin2Z/swdEhSVkNfEJVMEH57p0XsRAfSRloxpUt6V4Z0jR1SFXwKcvRn8QzspgMgfcUGyBopwinNDON7ggHykL5JCMWjtmYv7q9+KaiUfGwp6GDlCeUbqdLDIjSEdI2z6Oowd3liowdpFkBlY0S4efQAT2TuwVKLMtzUkUR5MXtP85mvHcvL3eVmMU7kJ0CjvtM+ewZhns0VtJkf1FJ+YkVHHu+YJv3FJdzetShoQ3On8wcYfbR27awyshvDl68vC+VlujEaVNpwdrnhH/nrv9weHFcPRV9n3I527G1KCILmF6FSwbIYEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cadence.com; dmarc=pass action=none header.from=cadence.com;
 dkim=pass header.d=cadence.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9lWskBQq2fHDshRe3yJu9dRK5nWSBHc5xxHf2RAVqx4=;
 b=56miJvlZhfslpYHKB+4LwUiE2GWi7PJiX5rHG31lFGNctXdvLVXNpFl34255ayCxoNSFLj1jbweuSb1PAh9ijjD6OsLt2Obif6/9/uz3pOBt4DAM99dN5fEj3B963EMsZZ5yTCN12UCfaLiJirlU5/40Yi9bp3CmywGnHNpLh3o=
Received: from BYAPR07MB5381.namprd07.prod.outlook.com (2603:10b6:a03:6d::24)
 by BYAPR07MB5864.namprd07.prod.outlook.com (2603:10b6:a03:131::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3955.18; Tue, 30 Mar
 2021 03:37:13 +0000
Received: from BYAPR07MB5381.namprd07.prod.outlook.com
 ([fe80::5a:c16d:31b1:bcd0]) by BYAPR07MB5381.namprd07.prod.outlook.com
 ([fe80::5a:c16d:31b1:bcd0%7]) with mapi id 15.20.3977.033; Tue, 30 Mar 2021
 03:37:12 +0000
From:   Pawel Laszczak <pawell@cadence.com>
To:     Colin King <colin.king@canonical.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>
CC:     "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] usb: cdnsp: remove redundant initialization of variable
 ret
Thread-Topic: [PATCH] usb: cdnsp: remove redundant initialization of variable
 ret
Thread-Index: AQHXInQu8HdxJQymDkuAbZyISS3Lfaqb5mwQ
Date:   Tue, 30 Mar 2021 03:37:12 +0000
Message-ID: <BYAPR07MB53810B0E4CCAD94F17DBF9C4DD7D9@BYAPR07MB5381.namprd07.prod.outlook.com>
References: <20210326191357.622683-1-colin.king@canonical.com>
In-Reply-To: <20210326191357.622683-1-colin.king@canonical.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNccGF3ZWxsXGFwcGRhdGFccm9hbWluZ1wwOWQ4NDliNi0zMmQzLTRhNDAtODVlZS02Yjg0YmEyOWUzNWJcbXNnc1xtc2ctMzRlMjA2NTItOTEwOS0xMWViLTg3ODctMWM0ZDcwMWRmYmE0XGFtZS10ZXN0XDM0ZTIwNjU0LTkxMDktMTFlYi04Nzg3LTFjNGQ3MDFkZmJhNGJvZHkudHh0IiBzej0iMTExMiIgdD0iMTMyNjE1NDkwMzAyOTYwMzg3IiBoPSJnVCs2bUplYWZZMEhCZnNEWm1RajE3d2tmRGM9IiBpZD0iIiBibD0iMCIgYm89IjEiLz48L21ldGE+
x-dg-rorf: true
authentication-results: canonical.com; dkim=none (message not signed)
 header.d=none;canonical.com; dmarc=none action=none header.from=cadence.com;
x-originating-ip: [185.217.253.59]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d8042f4a-a35d-4aff-94fb-08d8f32d1b37
x-ms-traffictypediagnostic: BYAPR07MB5864:
x-microsoft-antispam-prvs: <BYAPR07MB58648DD1202BFC377C24B6F3DD7D9@BYAPR07MB5864.namprd07.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5236;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: KcaNXll7tdqf9V4rAAaiHHekB9sZLiOemZJb9Eff0ogMXlTzypjU2oG9u+t/iu3pPER+zBsJaKTzo1O8c7GQitN6FzyZ6Slg1hzKoCucoybaqPPmc2ubw75TZRiu9oGb/0kwY7a/pdVaW1C7AVhgFDetLani8nN7tmLsQl9c0VoY5jW4jvUJlA/u58PqjGqbDJ/1ioi8l3jDM479jDbkE4aMS5p1y8hjv/FvRYqovZ7sFExqY19JwKhOfvTqLb0h8Im5AIMdPQWBum5VKeErpkEziHq7UDSlzz1eZCriWg5KO3ANpMb31HI7+9NLg2dUAqvkdh/ayGfyy4Vdp/Msq0jE4LmUxe6NuE72BskQueKqyKA77T27xjVM7MpFgBddk6TSz3/DVU0/u36UcFJ2SiV1d/UJfBjj8HUQMp85oyC5a+WlVPw82qiTZQjiPpJREAUPQSOqkG+eyNV8TjnjKDHIpgDJzUN1jRyGKtTOiH6rDklpy/BcB4H8wK4q5jF7VrAeuN47bgd/sssbWYfXmIVr41m+w3FWdYf/AnVU3Vtia8ROcMHb1nl1aRxkvgb2W/du/22tGKAOXKCo21CNB+y93pvOOPvOGkC/8DgONSqczAKYBZVvpStBV5AausTGVANjMhVQQCA33ry7QvpvfCf11wRFvHmqSq8wyO6v0DKTmdMnRz9CuMWlwyal0d19
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR07MB5381.namprd07.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(136003)(346002)(39860400002)(376002)(396003)(36092001)(7696005)(2906002)(186003)(64756008)(26005)(110136005)(66946007)(83380400001)(5660300002)(52536014)(478600001)(71200400001)(38100700001)(86362001)(8676002)(316002)(6506007)(9686003)(8936002)(54906003)(55016002)(33656002)(66446008)(66476007)(76116006)(66556008)(4326008)(4744005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?utf-8?B?QUNwT3o2U0N5Q2FOaHN1WU9KY2MvQzBqbTc3M2l6bnVVbmRVVU1nMlNHL0Uy?=
 =?utf-8?B?Z1hrMnFXVHlnNWJhZWNTeFFuRTFLUS9UMGJqRTJUYlNhZThqSFByZmk3QW1y?=
 =?utf-8?B?dWlmMXN0V2E4QldtNXcvelRmSXhiRlQyN1h6ZjJ5dWNMRURFOVNUQTlGck1Q?=
 =?utf-8?B?dUs0aUd3QjhyWmI1dGZkS0UzUHF3UHpCOUowR0ptYUgwdEl2aDB3SUYzTDZz?=
 =?utf-8?B?b2NteWNKdUpnN1pFVmV0NEkxMElDd0JQK2UzL0F5R1hmWlVHelFtc1VOWmpV?=
 =?utf-8?B?MXBRNG92LzYzaG5lM1hiWU5FYmp1K2F3TkM1SDJUVEF1bWoxODM0QVVXNGJm?=
 =?utf-8?B?ZFltTVYrVmJmZVNJbDcvcG1NOFl1MWNkRVluUUE4VDREY3U3M3lXQ3RtMXdm?=
 =?utf-8?B?SHZYVXZYU1FPNG1wMFBIVHFiWGpWMGd2ajhmU1Q3NU5BRzBCT3A0eFI4WTcv?=
 =?utf-8?B?TjdJYXJaeWZIbzR3a1R1ZThMUE9qOG8xTHA4d1dwb3g5aEhFY21oZkRLeVpU?=
 =?utf-8?B?UFo2YTdPSUNDVFovb0FieG1HRTZkaEh2aVJJSFJ1VUdUZXJwV3ZNUEhCVG5R?=
 =?utf-8?B?SmNzQUdtWms4aFVtSnV5Z3dnVG91Mk83ZGZmczhhd1lqUk1pSytqelRKWDN6?=
 =?utf-8?B?VU5SN1RNWDhPR2tLY3BqRkJHOU1OcDk3RlhITitTclZaNkhEamo4TUlXMmp1?=
 =?utf-8?B?K2tYem1IQXFNaHJXSHRYT3RBaE5US0hMUmJHV3kxaC9yaWI0UGcrTENzQjRY?=
 =?utf-8?B?RWIvMCttdHBnT29qMmhLZW1wdGdzb0RKaTdxZnREVHc3UVJOWTRaYTFDYytF?=
 =?utf-8?B?Z0U3K2Vqdnh6VU4wY085UEtBcWlsZlJFdnJGcnBPZEw0R1R3NDNzclVuWFNH?=
 =?utf-8?B?UktKaThycTNQZTJJUkp0cTRBT2xMaXpDbVlpNXNXeURhdU1jWThBbFN5Qnpz?=
 =?utf-8?B?VXowbGJ5K21wVGl4MWpZRXVPbEliNDZwdTlScmpuUFp1MS9FMDFlckdTSUhG?=
 =?utf-8?B?VXlCSWRpSlhja1N3ZXVCRjBPSXpKM2YzQm0vNVZ5RHA3UzIrS25wUzhLWVp6?=
 =?utf-8?B?V05HQWx2b2dudzY2VWQwNUVlR3NNeUNLL3NlQW14QjRpcnZhS3BmS2x1UGp1?=
 =?utf-8?B?bUVWUndLZW4rV0tUNVk3K1Q3K2NXUWhnZXo4dTQ4RnNmQllUYTdIZFhidllj?=
 =?utf-8?B?cUluOTJxdTBnU2Q3QTgzeFBPUHdESFdmcEJKeUM2V2JBTXFVb1BYVXZsU0dw?=
 =?utf-8?B?VjBHMEdsNFEwV2VWZTV0SGZJME9LNkR1T3BTeWFMUitJMXJWNmR5ZG81aEpn?=
 =?utf-8?B?UDVacERWWldocWJSbUppcVdVVnNRck5nT3FKRXB3YnhtNVhKa0xhS2hPVEVX?=
 =?utf-8?B?MVJkVkRYZWhGMVV0MGZPQnhnTVNKRml6cjRjUnFPMllmdVNIcFBQWGpvMjRw?=
 =?utf-8?B?bXhJVXNTa011SnBodnVZT3BzVTV1eVUzUnMwZW1LTVBjOHZ4eFM2eHRyQzdN?=
 =?utf-8?B?bXc0elRMWTQyTEM3WkZzVmtGRjFDRytyNjRTKzN1RmI0eXZZRlFYc1R5SThq?=
 =?utf-8?B?cHFhdnFqc0YwS3FDVHJsUWEyaW9peDI4Q0p5OGJBNjlxOHFRS00vc2tmZTdK?=
 =?utf-8?B?ZzFCWkJpeE03d3oxd25OVmRsK1pXd3I1YnhueWhMR0FPRFlEZkdYTUlXNHpJ?=
 =?utf-8?B?RVpwWjQ5TFp6MVZpZUl6M3c1RlYrSHVVem02dml3cHBaM0tIYXIwQVZzSERQ?=
 =?utf-8?Q?DMwxB1oW668XRd/Dgn7w8doTO3h6xu5i5bbzKy8?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR07MB5381.namprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d8042f4a-a35d-4aff-94fb-08d8f32d1b37
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Mar 2021 03:37:12.7622
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PQ1H9LVCCP3xTJxbIjuB4zIGBd3jT7gUwRUbJ9Rul2SWBwKyEvEGyNh5PfOgmJm6XG70IIRvG3YZvUNrdJsm04g5RD5nyQbzJz1GXxL60cc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR07MB5864
X-Proofpoint-ORIG-GUID: 19LCl9Xi4N8hEPxi9vd6yocDDUj-bAB3
X-Proofpoint-GUID: 19LCl9Xi4N8hEPxi9vd6yocDDUj-bAB3
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-03-29_16:2021-03-26,2021-03-29 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0 suspectscore=0
 malwarescore=0 bulkscore=0 spamscore=0 adultscore=0 lowpriorityscore=0
 phishscore=0 mlxscore=0 impostorscore=0 priorityscore=1501 clxscore=1011
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2103250000 definitions=main-2103300022
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgQ29saW4sDQoNClRoYW5rcyBmb3IgdGhpcyBmaXguIA0KDQo+DQo+RnJvbTogQ29saW4gSWFu
IEtpbmcgPGNvbGluLmtpbmdAY2Fub25pY2FsLmNvbT4NCj4NCj5UaGUgdmFyaWFibGUgcmV0IGlz
IGJlaW5nIGluaXRpYWxpemVkIHdpdGggYSB2YWx1ZSB0aGF0IGlzDQo+bmV2ZXIgcmVhZCBhbmQg
aXQgaXMgYmVpbmcgdXBkYXRlZCBsYXRlciB3aXRoIGEgbmV3IHZhbHVlLiAgVGhlDQo+aW5pdGlh
bGl6YXRpb24gaXMgcmVkdW5kYW50IGFuZCBjYW4gYmUgcmVtb3ZlZC4NCj4NCj5BZGRyZXNzZXMt
Q292ZXJpdHk6ICgiVW51c2VkIHZhbHVlIikNCj5TaWduZWQtb2ZmLWJ5OiBDb2xpbiBJYW4gS2lu
ZyA8Y29saW4ua2luZ0BjYW5vbmljYWwuY29tPg0KDQpSZXZpZXdlZC1ieTogUGF3ZWwgTGFzemN6
YWsgPHBhd2VsbEBjYWRlbmNlLmNvbT4NCg0KPi0tLQ0KPiBkcml2ZXJzL3VzYi9jZG5zMy9jZG5z
cC1tZW0uYyB8IDIgKy0NCj4gMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspLCAxIGRlbGV0
aW9uKC0pDQo+DQo+ZGlmZiAtLWdpdCBhL2RyaXZlcnMvdXNiL2NkbnMzL2NkbnNwLW1lbS5jIGIv
ZHJpdmVycy91c2IvY2RuczMvY2Ruc3AtbWVtLmMNCj5pbmRleCA3YTg0ZTkyODcxMGUuLmQ4N2I2
NDBlN2I0OSAxMDA2NDQNCj4tLS0gYS9kcml2ZXJzL3VzYi9jZG5zMy9jZG5zcC1tZW0uYw0KPisr
KyBiL2RyaXZlcnMvdXNiL2NkbnMzL2NkbnNwLW1lbS5jDQo+QEAgLTY4Niw3ICs2ODYsNyBAQCBz
dGF0aWMgdm9pZCBjZG5zcF9mcmVlX3ByaXZfZGV2aWNlKHN0cnVjdCBjZG5zcF9kZXZpY2UgKnBk
ZXYpDQo+DQo+IHN0YXRpYyBpbnQgY2Ruc3BfYWxsb2NfcHJpdl9kZXZpY2Uoc3RydWN0IGNkbnNw
X2RldmljZSAqcGRldikNCj4gew0KPi0JaW50IHJldCA9IC1FTk9NRU07DQo+KwlpbnQgcmV0Ow0K
Pg0KPiAJcmV0ID0gY2Ruc3BfaW5pdF9kZXZpY2VfY3R4KHBkZXYpOw0KPiAJaWYgKHJldCkNCj4t
LQ0KPjIuMzAuMg0KDQpSZWdhcmRzLA0KUGF3ZWwgTGFzemN6YWsNCg0K
