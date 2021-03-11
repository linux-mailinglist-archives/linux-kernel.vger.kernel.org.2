Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ACD82336FFC
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Mar 2021 11:27:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232335AbhCKK1N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Mar 2021 05:27:13 -0500
Received: from mx07-00178001.pphosted.com ([185.132.182.106]:36894 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232001AbhCKK04 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Mar 2021 05:26:56 -0500
Received: from pps.filterd (m0241204.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 12BAMUVX028034;
        Thu, 11 Mar 2021 11:26:37 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : subject :
 date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=STMicroelectronics;
 bh=rRSqiHjn7SwHn+GuviTETBtQTqXDQuQNtsb2cje7A+8=;
 b=pCxePe78RKMi+vASvOiTxEjqik+9DaG2c4NxGtjv4/JDtQFGDBJFz+bOPOZ6Nc7+iMc2
 kffPhN4y+SAS5OLaxeUP5cKo3fkZMjH2vsb25kGRqZ2XpR0Jk4Ba4FK+BiApPBu+W8Xo
 4VDeV6qA0uNZ/xzvMEhmKMfspgWLh6Z1dYvf4snnkuR2iVXkhYmR0MLLfmzsgFnUkiXI
 6pW9la6y6IxkjMX30Bb1Bi0j8tfAjOLTxdFP0fQkJYQHf6Djhw2mRZs+eFk+C/KH4mo/
 q+PU3E4oeBEKwSVcIg247YmnBWdz1446fWkTQNJxPW1C4EInl6HHodkawVj0Te+O4fVO 1A== 
Received: from eur03-ve1-obe.outbound.protection.outlook.com (mail-ve1eur03lp2054.outbound.protection.outlook.com [104.47.9.54])
        by mx07-00178001.pphosted.com with ESMTP id 3741y75g62-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 11 Mar 2021 11:26:37 +0100
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QUPLu6KsxbjR9dj+WhCb9YSPEZyPa8G4daS8oWFh33/yXG4aNsRyktSAWoJf1BwjYU/iGXa3gSzSdZT19FNsEbWfgqf5KsW8DwO6mBnvdn+VNwSYRgcCwdbCx81R+31LIFyPpJR2MDU09oSxGIVfQbxTJy+IsETjIEkoafEZFnb/d2rbuRBK4Ajvknh5rmAol/KwjP+PvoweU11XcjhjLHSslAeduR4MP9wBfflicbtR/3lOJDopouYnD5TzWP1pnPiq25UiXo/xX7UAjA4+GAW33AlsUYoOpJLwZMjAxvNEosKE59UHWO7clU2IuL6DavCPPUuHUCe6EMDFQu/oHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rRSqiHjn7SwHn+GuviTETBtQTqXDQuQNtsb2cje7A+8=;
 b=IX1H97lJ5SOUowXzuCawf0hcjin4cWUC/Jjmlw6Xyw4vR856UaOatFHE79S8/q0clCfWyXWZ8OJdEbrt2Z0zUt4/5MAutf1Wmxt72iAADwuzpftbIPzv7zS/YJe/gg2bq1pk6l26ekubR8tFO6FBX6yIR3jhke14LbVxMQksoSOjxDOR+8e9RNu4a/zL6wUqpVNFF98quAYSlZEu91OAJQUtQs7jINNq2pV8Vg6mnrXMVOF4qwfYXyEg2/OcISNSPxqb3uxjEgeHvlCUbE4R9jeqpF0aZs4WLaobWPMiTPF0Dp1ugZ1ygEsjZBpKiegXoaoC8CTU+FENjTFY+t85Ew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=st.com; dmarc=pass action=none header.from=st.com; dkim=pass
 header.d=st.com; arc=none
Received: from AS8PR10MB4712.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:31d::16)
 by AM6PR10MB3064.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:e3::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3933.31; Thu, 11 Mar
 2021 10:26:35 +0000
Received: from AS8PR10MB4712.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::e96b:5d97:d0a0:4aac]) by AS8PR10MB4712.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::e96b:5d97:d0a0:4aac%4]) with mapi id 15.20.3912.031; Thu, 11 Mar 2021
 10:26:35 +0000
From:   Alexandre TORGUE <alexandre.torgue@st.com>
To:     dillon min <dillon.minfei@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "linux-stm32@st-md-mailman.stormreply.com" 
        <linux-stm32@st-md-mailman.stormreply.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "linux@armlinux.org.uk" <linux@armlinux.org.uk>,
        Vladimir Murzin <vladimir.murzin@arm.com>,
        "afzal.mohd.ma@gmail.com" <afzal.mohd.ma@gmail.com>
Subject: RE: [PATCH 0/8] ARM: STM32: add art-pi(stm32h750xbh6) board support
Thread-Topic: [PATCH 0/8] ARM: STM32: add art-pi(stm32h750xbh6) board support
Thread-Index: AQHXEAP9VTLTArh4D0G/CLtaVTOXZ6p9JlgAgAF7XXA=
Date:   Thu, 11 Mar 2021 10:26:34 +0000
Message-ID: <AS8PR10MB47127FD40F6782B279B5998BEE909@AS8PR10MB4712.EURPRD10.PROD.OUTLOOK.COM>
References: <1614758717-18223-1-git-send-email-dillon.minfei@gmail.com>
 <CAL9mu0LwT7GqWQY1Dpw3zLnS+oX8KFq=Lrp6NSBJvSgcsxEQVQ@mail.gmail.com>
In-Reply-To: <CAL9mu0LwT7GqWQY1Dpw3zLnS+oX8KFq=Lrp6NSBJvSgcsxEQVQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=st.com;
x-originating-ip: [165.225.76.169]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6a5daf7d-185c-4c7e-996c-08d8e4782599
x-ms-traffictypediagnostic: AM6PR10MB3064:
x-microsoft-antispam-prvs: <AM6PR10MB3064284366987B521CBBE449EE909@AM6PR10MB3064.EURPRD10.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: N1h3ZhRjOIsWEJkNYUaPmxuz0DIO9uPUwrHohsGYttryCSM3kJl82wtXtP66clTAs2B4addZ+aWrheuTWx2KadjNP2FXc8ZrmHUjqOkiVdRUZi59/9B0IrH/BG1xjGls3chXs7zsleoLn07kf5Fq12PtjyZXmAFY2pLNbhehpGPAulxzAm025LzUaohCO+UX3Ii8jOyr+W2QcnrONDHTCnxnC47l2JnubOnlQuKh6UjylooKHHRzH+JHqqkkY4bZljEk3caAl+tNswgUqQEC4tjd1kRWv5SlN+Udk36sf19m42xYR8d2p4ehN9JV47NO5JyQP2KDMXYAsulEznJG86Yfu+KLTOTZtDNpSxWfbpJR3Bk4EujoMtzg9L8Y4rjZReqZjWTmcxQNYFgtBB87ao22z/aAw6x9w+SctUhPX0d6QCUibYkZTdnSow9tbcVKy3a3EV3Ti1xDewzTPPhavCS1NCWEzU2/LXyo6Qx0vHhhGW8A3cBe3iQXW27ARSgfzgM2zHjBH6Mnn16gH6Zt3a/MNkIVAhWuhF9+5CPnIxxZt+7HAVkGfKJYcraoIUHCuN+eex1YARFZwpgQN3J94PWp+WrOb+1DLikS5cFfxrrAdjXqF6zbvXlvuyweQCP7UYytGU4+7Ep1hyxnmId3C8dl5YC0mXuW8RQWdNgMmZfuftyNQkkX43yYHjgV4jVG
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR10MB4712.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(346002)(376002)(136003)(396003)(366004)(316002)(52536014)(478600001)(66476007)(8936002)(66556008)(76116006)(55016002)(66946007)(9686003)(66446008)(110136005)(53546011)(6506007)(86362001)(7696005)(5660300002)(33656002)(55236004)(64756008)(8676002)(83380400001)(2906002)(921005)(186003)(26005)(7416002)(71200400001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?utf-8?B?QW1XdWJVQlVZVmFMTWxDaXJPcTZpVjUzbUtlMCtoN2RCb3VxRmlUK2QybEVq?=
 =?utf-8?B?SzFuQ2xTYWluKzNjcGZNQTVYTm4ydythSlZ0WWl4eVZ0ZytDM05JL3hkUGtP?=
 =?utf-8?B?M0wyOWFNWmowNUZWWWMvSUJzRFVRcVRoM2RRcC84OG5zZGQzdTl0YXNROHg1?=
 =?utf-8?B?Vm9PN0tjTnIyL1Q3Zy9kTDQ3NGdjZ2dVNSsxQWJWS2x6WTd1eFdiNTBvWEpv?=
 =?utf-8?B?UVBzbktsUFZMZVpVUXRxTDVBcC9YVVZMMHNzb3QrT1ZsNTN3WDdkSVVNdWZY?=
 =?utf-8?B?Z2pRdjdWdm9RbFFBWmVodStjUzNMWitLdFIxL2I1WGdCNHhMY2hFMG05dnVv?=
 =?utf-8?B?SWFseTkzSnJhUGxHM01sTG5PY2FUeUF3YkpIaGNoT1VoV2FNa0FDMkxyOFBG?=
 =?utf-8?B?eVlWSU1Xb3gxOWtKbWN6OUZCcStlOEc2eElOZDgrNnMwdlA3L25jVzJnRnJk?=
 =?utf-8?B?a0dNdkFTMGg1OWJWQ29JMGhHSnJOQWVYOEJyWXd2VjU1N3NUV1hTVTVCMVly?=
 =?utf-8?B?akRxUU91dC9jWXJXbEl0ODY3NDVWZnZhWGRmZENMTmFmSFBaZ1ZvZkNiSDRN?=
 =?utf-8?B?Z3hQdmV5T0R1bVkrQXJyTmNTN01NWDRSbGV0VFk3WlU0SDZBRE4vR2hxMHVL?=
 =?utf-8?B?N1l0QUxvcHJhVTJ0YjczR09mbTRBWGRRSmFORms5OU9YeDhrN2o5YWF3Wmg2?=
 =?utf-8?B?eTZqZ0czdmVma0tWdEZPLzRUYm5WQjlVVEN5Q3BRQ3J5by83WURYaVVaUUpq?=
 =?utf-8?B?VjN3a0UxVHBuWWhHOVJFS1VILzg1NmkvbXNSS2lzNG9sZWR2K2lZTDEyUEZM?=
 =?utf-8?B?RlBjSjlwUGtPOGJQWDlEaEl4dlNpMDJsN1NYSEJtdGpBYm1lZTY4ZzVjblVU?=
 =?utf-8?B?QmxabWNRbTMxZWtrRXJRZjRleXlxL1c3TGIyU0s4OHFiQmsrQ29ZUkxzdFQx?=
 =?utf-8?B?ZmxTa2IzcmsySURLTkNneGhJNnR6eHYyc2JMbUZVbFFVQzFuaHlBWm9OTEdP?=
 =?utf-8?B?VXRML3hadTMxNGNsZHdDUmxMcnptZDRFSExMQVp3NzJVUWRKUFpJQnpuUnpq?=
 =?utf-8?B?MjAvQTQrQjVKTC9neHBSNVdSMk95eG5RdG5WU00vS0ttMTkzOGlaZ0tZWXVS?=
 =?utf-8?B?UGg1Szh6VlN0Q3pZYktYK2NUaVY3aXhBajFwSHp5bGNpYWpoNGFHNGk4ZEZM?=
 =?utf-8?B?VlRuMGdqZVo5VGdac28ySHo1L3MrOTd3SEtjYzVka3lOVmwvVTFRR3Y2UzBW?=
 =?utf-8?B?Q3o0VXYxZWJLMGo0Um9IS1lHZERTU3QyaTgrenBXa3RhVFJLN3BDTnBLNWRY?=
 =?utf-8?B?dndRT0hES3JNTndMY1dXRkpQQ3N5dXQzWk40TGY0QUpTeElIZWQzV1RjajlH?=
 =?utf-8?B?eTZNdFNudlZTcEZMWkQ2aHZJcm1iQjJXUmhlMkk0WTlVdDdNdlc3VkFCYXpu?=
 =?utf-8?B?OVRrVHFvc2xLemcwLzh2RHR0dkRoZmNqWEZkUHVobEdzZ3cyUlhIdFNrSFlp?=
 =?utf-8?B?dlV5Z0ptQkRJVkk3bHVyRW83NUVQaytpQjRmOVN6WUEzOHdGQXVvd1l4VGI5?=
 =?utf-8?B?clk2eUNIZTB1ZWM3YUkvVlNrRThWdE4vY2pmMTFHbVdHZk1WU3RYYmkwZHV3?=
 =?utf-8?B?cjRkRllOSUo0TzhwbVh3NFJ5d0cvY1pUR2llbnVuQVdTcnc0aVhsZXBzam1o?=
 =?utf-8?B?bXpZZGRMYlU2UGU3MnEzVnJYK2dWeGZ0aTZrMjlOUXg3N3FpYklaZVRMM1dx?=
 =?utf-8?Q?4qTCgik7Bbu2sg5QnGRK3C7waLs2fR1IRhZKW61?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: ST.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS8PR10MB4712.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a5daf7d-185c-4c7e-996c-08d8e4782599
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Mar 2021 10:26:35.0359
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 75e027c9-20d5-47d5-b82f-77d7cd041e8f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nJkytI/2I9PgAm0PtxP9nsZo/HPXgYEFzwJK+9zwdv18cGEwKKIF0YYau1Nicq6gLJIQOeGhvgSs7ddJVspsRA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR10MB3064
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-03-11_04:2021-03-10,2021-03-11 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 lowpriorityscore=0
 mlxlogscore=999 malwarescore=0 priorityscore=1501 adultscore=0 bulkscore=0
 phishscore=0 spamscore=0 clxscore=1011 impostorscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2103110055
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgRGlsbG9uDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogZGlsbG9u
IG1pbiA8ZGlsbG9uLm1pbmZlaUBnbWFpbC5jb20+DQo+IFNlbnQ6IG1lcmNyZWRpIDEwIG1hcnMg
MjAyMSAxMjo0OA0KPiBUbzogUm9iIEhlcnJpbmcgPHJvYmgrZHRAa2VybmVsLm9yZz47IE1heGlt
ZSBDb3F1ZWxpbg0KPiA8bWNvcXVlbGluLnN0bTMyQGdtYWlsLmNvbT47IEFsZXhhbmRyZSBUT1JH
VUUNCj4gPGFsZXhhbmRyZS50b3JndWVAc3QuY29tPjsgb3BlbiBsaXN0Ok9QRU4gRklSTVdBUkUg
QU5EIEZMQVRURU5FRA0KPiBERVZJQ0UgVFJFRSBCSU5ESU5HUyA8ZGV2aWNldHJlZUB2Z2VyLmtl
cm5lbC5vcmc+OyBsaW51eC1zdG0zMkBzdC1tZC0NCj4gbWFpbG1hbi5zdG9ybXJlcGx5LmNvbTsg
TGludXggQVJNIDxsaW51eC1hcm0tDQo+IGtlcm5lbEBsaXN0cy5pbmZyYWRlYWQub3JnPjsgTGlu
dXggS2VybmVsIE1haWxpbmcgTGlzdCA8bGludXgtDQo+IGtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc+
OyBsaW51eEBhcm1saW51eC5vcmcudWs7IFZsYWRpbWlyIE11cnppbg0KPiA8dmxhZGltaXIubXVy
emluQGFybS5jb20+OyBhZnphbC5tb2hkLm1hQGdtYWlsLmNvbQ0KPiBTdWJqZWN0OiBSZTogW1BB
VENIIDAvOF0gQVJNOiBTVE0zMjogYWRkIGFydC1waShzdG0zMmg3NTB4Ymg2KSBib2FyZA0KPiBz
dXBwb3J0DQo+IA0KPiBmb3IgdGhlIGRldmljZSB0cmVlIHBhcnQgLCBzdGlsbCB3YWl0aW5nIHJl
dmlldy4ganVzdCBhIGdlbnRsZSBwaW5nLg0KPiBpZiBNciBBbGV4YW5kcmUgdG9yZ3VlIGNhbiB0
YWtlIGEgbG9vaywgd291bGQgYmUgZ3JlYXQuDQo+IA0KDQpTb3JyeSBmb3IgdGhlIGRlbGF5LiBG
b3IgbmV4dCB2ZXJzaW9ucyBjYW4geW91IHNlbmQgaXQgdG8NCkFsZXhhbmRyZS50b3JndWVAZm9z
cy5zdC5jb20gcGxlYXNlLg0KDQpUaGFua3MNCkFsZXgNCg0KPiB0aGFua3MsDQo+IA0KPiBPbiBX
ZWQsIE1hciAzLCAyMDIxIGF0IDQ6MDUgUE0gPGRpbGxvbi5taW5mZWlAZ21haWwuY29tPiB3cm90
ZToNCj4gPg0KPiA+IEZyb206IGRpbGxvbiBtaW4gPGRpbGxvbi5taW5mZWlAZ21haWwuY29tPg0K
PiA+DQo+ID4gVGhpcyBwYXRjaHNldCBpbnRlbmQgdG8gYWRkIGFydC1waSBib2FyZCBzdXBwb3J0
LCB0aGlzIGJvYXJkIGRldmVsb3BlZA0KPiA+IGJ5IHJ0LXRocmVhZChodHRwczovL3d3dy5ydC10
aHJlYWQub3JnLykuDQo+ID4NCj4gPiBCb2FyZCByZXNvdXJjZXM6DQo+ID4NCj4gPiA4TWlCIFFT
UEkgZmxhc2gNCj4gPiAxNk1pQiBTUEkgZmxhc2gNCj4gPiAzMk1pQiBTRFJBTQ0KPiA+IEFQNjIx
MiB3aWZpLGJ0LGZtIGNvbWINCj4gPg0KPiA+IHN3IGNvbnRleHQ6DQo+ID4gLSBhcyBzdG0zMmg3
NTAganVzdCBoYXMgMTI4ayBieXRlcyBpbnRlcm5hbCBmbGFzaCwgc28gcnVubmluZyBhIGZ3IG9u
DQo+ID4gICBpbnRlcm5hbCBmbGFzaCB0byBkb3dubG9hZCB1LWJvb3Qva2VybmVsIHRvIHFzcGkg
Zmxhc2gsIGJvb3QNCj4gPiAgIHUtYm9vdC9rZXJuZWwgZnJvbSBxc3BpIGZsYXNoLiB0aGlzIGZ3
IGlzIGJhc2VkIG9uIHJ0LXRocmVhZC4NCj4gPiAtIGtlcm5lbCBjYW4gYmUgeGlwIG9uIHFzcGkg
Zmxhc2ggb3IgbG9hZCB0byBzZHJhbQ0KPiA+IC0gcm9vdCBmaWxlc3lzdGVtIGlzIGpmZnMyKGNy
ZWF0ZWQgYnkgYnVpbGRyb290KSwgc3RvcmVkIG9uIHNwaSBmbGFzaA0KPiA+DQo+ID4gdG8gc3Vw
cG9ydCB0aGUgYm9hZCwgYWRkIGZvbGxvd2luZyBjaGFuZ2VzLg0KPiA+IC0gZml4IHIwLXIzLCBy
MTIgcmVnaXN0ZXIgcmVzdG9yZSBmYWlsZWQgYWZ0ZXIgc3ZjIGNhbGwsDQo+ID4gLSBhZGQgZHRz
IGJpbmRpbmcNCj4gPiAtIHVwZGF0ZSB5YW1sIGRvYw0KPiA+DQo+ID4gZGlsbG9uIG1pbiAoOCk6
DQo+ID4gICBBUk06IEFSTXY3LU06IEZpeCByZWdpc3RlciByZXN0b3JlIGNvcnJ1cHQgYWZ0ZXIg
c3ZjIGNhbGwNCj4gPiAgIERvY3VtZW50YXRpb246IGFybTogc3RtMzI6IEFkZCBzdG0zMmg3NTAg
dmFsdWUgbGluZQ0KPiA+ICAgZHQtYmluZGluZ3M6IGFybTogc3RtMzI6IEFkZCBjb21wYXRpYmxl
IHN0cmluZ3MgZm9yIEFSVC1QSSBib2FyZA0KPiA+ICAgZHQtYmluZGluZ3M6IHBpbmN0cmw6IHN0
bTMyOiBBZGQgc3RtMzJoNzUwIHBpbmN0cmwNCj4gPiAgIEFSTTogZHRzOiBzdG0zMjogaW50cm9k
dWNlIHN0bTMyaDctcGluY3RybC5kdHNpIHRvIHN1cHBvcnQgc3RtMzJoNzV4DQo+ID4gICBBUk06
IGR0czogc3RtMzI6IGFkZCBzdG0zMmg3NTAtcGluY3RybC5kdHNpDQo+ID4gICBBUk06IGR0czog
c3RtMzI6IGFkZCBzdXBwb3J0IGZvciBhcnQtcGkgYm9hcmQgYmFzZWQgb24gc3RtMzJoNzUweGJo
Ng0KPiA+ICAgQVJNOiBzdG0zMjogYWRkIGluaXRpYWwgc3VwcG9ydCBmb3Igc3RtMzJoNzUwDQo+
ID4NCj4gPiAgRG9jdW1lbnRhdGlvbi9hcm0vaW5kZXgucnN0ICAgICAgICAgICAgICAgICAgICAg
ICAgfCAgIDEgKw0KPiA+ICBEb2N1bWVudGF0aW9uL2FybS9zdG0zMi9zdG0zMmg3NTAtb3ZlcnZp
ZXcucnN0ICAgICB8ICAzMyArKw0KPiA+ICAuLi4vZGV2aWNldHJlZS9iaW5kaW5ncy9hcm0vc3Rt
MzIvc3RtMzIueWFtbCAgICAgICB8ICAgNCArDQo+ID4gIC4uLi9iaW5kaW5ncy9waW5jdHJsL3N0
LHN0bTMyLXBpbmN0cmwueWFtbCAgICAgICAgIHwgICAxICsNCj4gPiAgYXJjaC9hcm0vYm9vdC9k
dHMvTWFrZWZpbGUgICAgICAgICAgICAgICAgICAgICAgICAgfCAgIDEgKw0KPiA+ICBhcmNoL2Fy
bS9ib290L2R0cy9zdG0zMmg3LXBpbmN0cmwuZHRzaSAgICAgICAgICAgICB8IDM5Mg0KPiArKysr
KysrKysrKysrKysrKysrKysNCj4gPiAgYXJjaC9hcm0vYm9vdC9kdHMvc3RtMzJoNzQzLXBpbmN0
cmwuZHRzaSAgICAgICAgICAgfCAzMDcgKy0tLS0tLS0tLS0tLS0tLQ0KPiA+ICBhcmNoL2FybS9i
b290L2R0cy9zdG0zMmg3NDMuZHRzaSAgICAgICAgICAgICAgICAgICB8ICAzMCArKw0KPiA+ICBh
cmNoL2FybS9ib290L2R0cy9zdG0zMmg3NTAtcGluY3RybC5kdHNpICAgICAgICAgICB8ICAxMSAr
DQo+ID4gIGFyY2gvYXJtL2Jvb3QvZHRzL3N0bTMyaDc1MC5kdHNpICAgICAgICAgICAgICAgICAg
IHwgICA1ICsNCj4gPiAgYXJjaC9hcm0vYm9vdC9kdHMvc3RtMzJoNzUwaS1hcnQtcGkuZHRzICAg
ICAgICAgICAgfCAyMjcgKysrKysrKysrKysrDQo+ID4gIGFyY2gvYXJtL21hY2gtc3RtMzIvYm9h
cmQtZHQuYyAgICAgICAgICAgICAgICAgICAgIHwgICAxICsNCj4gPiAgYXJjaC9hcm0vbW0vcHJv
Yy12N20uUyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgfCAgIDUgKy0NCj4gPiAgMTMgZmls
ZXMgY2hhbmdlZCwgNzE2IGluc2VydGlvbnMoKyksIDMwMiBkZWxldGlvbnMoLSkgIGNyZWF0ZSBt
b2RlDQo+ID4gMTAwNjQ0IERvY3VtZW50YXRpb24vYXJtL3N0bTMyL3N0bTMyaDc1MC1vdmVydmll
dy5yc3QNCj4gPiAgY3JlYXRlIG1vZGUgMTAwNjQ0IGFyY2gvYXJtL2Jvb3QvZHRzL3N0bTMyaDct
cGluY3RybC5kdHNpDQo+ID4gIGNyZWF0ZSBtb2RlIDEwMDY0NCBhcmNoL2FybS9ib290L2R0cy9z
dG0zMmg3NTAtcGluY3RybC5kdHNpDQo+ID4gIGNyZWF0ZSBtb2RlIDEwMDY0NCBhcmNoL2FybS9i
b290L2R0cy9zdG0zMmg3NTAuZHRzaSAgY3JlYXRlIG1vZGUNCj4gPiAxMDA2NDQgYXJjaC9hcm0v
Ym9vdC9kdHMvc3RtMzJoNzUwaS1hcnQtcGkuZHRzDQo+ID4NCj4gPiAtLQ0KPiA+IDIuNy40DQo+
ID4NCg==
