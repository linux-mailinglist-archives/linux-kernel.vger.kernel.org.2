Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B7D17307BBD
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jan 2021 18:06:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232702AbhA1RFW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jan 2021 12:05:22 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:3034 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S232677AbhA1RAj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jan 2021 12:00:39 -0500
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
        by m0001303.ppops.net (8.16.0.43/8.16.0.43) with SMTP id 10SGgGFq013197;
        Thu, 28 Jan 2021 08:59:39 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=4Q+7acPJfzT2DzzQZg3tbZihQAZBWgcCxa+Rw9SoDDc=;
 b=NcnAdf1nTEAXb8rzmSkGzbVyMkW0lqMRbPOC/28wM5RfI6BMVnIUbjks8iYqrAkUcQXG
 6yyZBbFEafirNBkYR5XPj4vBJR0kX4dYt+gyGoo+nrE25eDItodcXXhQGqWf6hukVTtu
 PQO2gZlQFrMk5JqzNPloFfAKyXvq1hNrfLU= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by m0001303.ppops.net with ESMTP id 36b4ws8gbs-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Thu, 28 Jan 2021 08:59:39 -0800
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Thu, 28 Jan 2021 08:59:38 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dlQo4FEITb09sJxzeRwGWSw+8SDpqS0uVlC9TgquupMuRMHpW4Mu1ot7r77VPn0OklrTSHrDOXJPO9zV/Znc/LofeUMA8g6wMD6P4inkpnWa51FGYb3IKjDxJN3eEFGUxipBa1Y+LKM/hj+eYpuXKskhTZbfoQIw983baebnadUsOxT+IDXdY2fOfyldpCOZkPX7PetXhLmhWX6JwyaMcbqORYKyoUWbaEzwAz/fo2OJ5HF6G73Tdp7ua1FlgCppS1OA3LeIJ5ulhAiMFsuLcXeXxWUsJjtBHdYTT3t7gZpPUd6w5R8F5f8TJwMDIAh1SeZEyA9OVgv0HEr42NQ5Tw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4Q+7acPJfzT2DzzQZg3tbZihQAZBWgcCxa+Rw9SoDDc=;
 b=TCHzlFd8i+HJakY0tq6GXpucdcBVKxlEwDnku5LeSvsYeOECp0VA4/0zKBD4/jUpGpPQzrLL+a6gTHDH+ZtWBMw4nILG8g7kws96jFj4TN6GipywpCuOwKBnwoNSv7K0MwMlPosX+s0zSj0eswLNmuT8dJ4gz/GO2DXNGUS4gHrTsT2+/6z9gi1ZldgY8CKzjI10ZOhml4X4qQy546SY4aM0TrDKbsQ1Xd7S2WIg89g9t1HDOQjk+aoKN+WgOEiA4Uh8yzzi57OQ4HqP3vXwX4Zz7WJ3BpT2TGck9uEXoucD+N34ikgtccWSMgwc1PIoM1/dvm5XgkiL+QNtoVFP+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4Q+7acPJfzT2DzzQZg3tbZihQAZBWgcCxa+Rw9SoDDc=;
 b=DBuoBYa0ZW2exEPkvpC0LUryjmMR6LqVUcdtiDthysf2vxTXWrZRXxm3TnYRArMHO+hxJ8BUBzYPnl7ZioNzMYwNHp1FI51jJj7MAuRubgdo0h3WyLmTyB7ePA25SmN6IJN7Cf9vAmVogzXfVL7/Gn3Qk/4CCVGmlwW6JyBAQGA=
Received: from BYAPR15MB2999.namprd15.prod.outlook.com (2603:10b6:a03:fa::12)
 by BYAPR15MB2245.namprd15.prod.outlook.com (2603:10b6:a02:89::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3805.17; Thu, 28 Jan
 2021 16:59:36 +0000
Received: from BYAPR15MB2999.namprd15.prod.outlook.com
 ([fe80::c97:58e4:ee9:1dc0]) by BYAPR15MB2999.namprd15.prod.outlook.com
 ([fe80::c97:58e4:ee9:1dc0%7]) with mapi id 15.20.3763.019; Thu, 28 Jan 2021
 16:59:36 +0000
From:   Song Liu <songliubraving@fb.com>
To:     Zi Yan <ziy@nvidia.com>
CC:     Saravanan D <saravanand@fb.com>,
        Xing Zhengjun <zhengjun.xing@linux.intel.com>,
        the arch/x86 maintainers <x86@kernel.org>,
        "dave hansen@linux intel com" <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Ziljstra <peterz@infradead.org>,
        "corbet@lwn.net" <corbet@lwn.net>,
        Matthew Wilcox <willy@infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Kernel Team <Kernel-team@fb.com>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>
Subject: Re: [PATCH V5] x86/mm: Tracking linear mapping split events
Thread-Topic: [PATCH V5] x86/mm: Tracking linear mapping split events
Thread-Index: AQHW9WQhBvy3Y1me+0ugtJS/cCj9Fqo9O+cAgAAHOYA=
Date:   Thu, 28 Jan 2021 16:59:36 +0000
Message-ID: <80C276A5-4EC0-4078-A1EC-A05AF5741264@fb.com>
References: <20210128045153.GW308988@casper.infradead.org>
 <20210128104934.2916679-1-saravanand@fb.com>
 <EBB7E363-FE25-453C-89C6-9FC4A90615B9@nvidia.com>
In-Reply-To: <EBB7E363-FE25-453C-89C6-9FC4A90615B9@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3654.40.0.2.32)
authentication-results: nvidia.com; dkim=none (message not signed)
 header.d=none;nvidia.com; dmarc=none action=none header.from=fb.com;
x-originating-ip: [2620:10d:c090:400::5:f23b]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f30f7ec0-de85-4460-afb1-08d8c3ae17f4
x-ms-traffictypediagnostic: BYAPR15MB2245:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR15MB2245CCA12E1415ECFD2AE4C3B3BA9@BYAPR15MB2245.namprd15.prod.outlook.com>
x-fb-source: Internal
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: GZe1dU+N5qzRSmRqCM9L8GuEMtFjqTICtvIZTKVzry03USDGGnLz+ETPkCmJwoiLJgG1y11CvFYUPbomuFy+bQZTm03tDiBVjmZ//7NXIVxc3mGcO1QBevOqVwJTysIUMCjLQ6blx6QcEgeYuc17uRskWcrERxUEL9RW6KQqIwPRLJ0AyJcRSypAkTRWb/DxMVFoX0d0ODV8BE7pEw+2uNx5udfRC7Y4AriWe5jAWtsp6eWr5gv0uoXb/fYJR+hL/SYT5HNQh9vjau0O4RIKiu9d9OstWxj7610WZegd3siGAB+hJPEhnZ3wGNhzjUOg9iNgPYfg9XKnec8qfzOLeD+UDUyH3UoQogCVwssviA5LtrcRz9W07IXCXDyPL5r0s2aHYXZaRvR5NTzFBxoZrtRhwzsqlfCoX5p1ciePaEv+MmWXOhHn4/Ok9zZ12QGWuABjrtcT8itgmdL30r4ZVI0X1//A6m70RluEyFbMG9Z3xODjOQnU5zq+uBNUn3wBofiGd+G/DYzgIYe4eS5Uwh0DQQCBqe6SNmpXzo6y6ooh4rVmavuple8Dh19KW4bD6OqNdFp7J5+0hBlw4qCMEQ+FeUzb/FT1NJig0wyOgLPBEw/CS4P+mTehIjJyWJvx9ZLp2x32E37c0sVkBMpeO+ldR9vpXBlsjkqrqtlunMQPei544uDG/dqJTDPiWAMr
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB2999.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(366004)(346002)(136003)(39860400002)(376002)(186003)(4326008)(86362001)(66556008)(2616005)(91956017)(64756008)(66446008)(6486002)(66946007)(76116006)(71200400001)(66476007)(2906002)(8936002)(6512007)(83380400001)(54906003)(8676002)(6506007)(53546011)(7416002)(6916009)(36756003)(33656002)(5660300002)(478600001)(316002)(21314003)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?utf-8?B?U25vaW13eFE1eDQ0aTVvZ1NqcGFKK2pEM1llV1ZrSEJwSzVoQjlZdk1RQXlj?=
 =?utf-8?B?OFBWakhVZCtvNDU5ZnJPNm84UWpUYjlONFZnUXRuUjJOZCtRdENlRWhUMHUy?=
 =?utf-8?B?aWFhWVdWb2hpZnZYUnpBMndKM3ZlTGJsWENmU0lPbTBRT2RJZnVhVThPTjRE?=
 =?utf-8?B?TkJuckdnUjIyRHZER0hjN1hSNGJ4ajBSUkRERW1iVGwvUGx6K2s4Y0QraTRX?=
 =?utf-8?B?a040b2FXdVE3WVJxY0VkdGJ5eGRScnZqajh0MnFSZGRFWXM1QmZ1V3JBNWNt?=
 =?utf-8?B?N2hDUFVSOTRMOG5RU1ZnekRaZ2tEb2RGeWdrRmd3dW9FTVdzSzdjRG1vODNa?=
 =?utf-8?B?b0gvNXJZb3NGY0RjYWxlbmJDandtaC9FQkVyTno4K2ZrbXdDY3psaE9YcnFC?=
 =?utf-8?B?cGtoczI2L20vbkR5aS9rWHhFQlFZSGRCSHYxT3hYRE1Gb3lROUdRRjMwdFNH?=
 =?utf-8?B?TzlVQWs1ZitsdzJoYnVSYVMrYnc1QlhXbC9IUFFTTjhkSmV1RFNhVUxPRlA2?=
 =?utf-8?B?VXVVTmw1OEJxdEFOcGlCWG1aN2VYb1FuSkoxK25WWDJOdkgxT3dta0NKcDdL?=
 =?utf-8?B?VVY2ekxmZTYxTXpHMUduaXErSHBWWjZJTm5OeFdpVkR1V3I1L3hTcEJxQjZy?=
 =?utf-8?B?YnlNLzFha29KSHNwZDVEUFJjUHIzTHpKak1lMUhMbmFQMzJpR3IrSE00QldY?=
 =?utf-8?B?NDF0STh6UjlNNHFmV2FZU0RodERCUmptVllGKzlLSDFBYzlUb2IxYW1TNWRM?=
 =?utf-8?B?ckhsY1JYbEpmWWVIQytyZWdnYVprRHp0OE0zdjlaZnZMc1g3dGhDRmZzd2lJ?=
 =?utf-8?B?c2ZLVFpBRnlqbTBQbG05SlNoUSs0MTNQbFlxRjlBbEVzN0FlZ3JXczlaZzA2?=
 =?utf-8?B?UlI2MndDNjZaaVRJRzlmNG5Qem10WDgrbVdibXlFVDdaVjIvOUFKZldwSUlF?=
 =?utf-8?B?Tk8vbUNZWGJxTEFZTUZoK3JUMG82NnN6cUhJR3JwZjZUTHpLWFhEWC90Tndr?=
 =?utf-8?B?QjBDSWNHT2hiOGJMVXc4MWxUanFaT050WWZHR0JOaXRwM2ZLY3dISHB6WjBH?=
 =?utf-8?B?Y0ppTXRSUUpPSkt1QUd3YnlZV3o4MldQckZOM3N5NUpOQTlic0FkdGZ0UU1R?=
 =?utf-8?B?Ykc0YmFSa0ZPdVYzM3FxbTNYSHJTR2dIQTczbW1mb0N4RDNoa2w1d0phNTVN?=
 =?utf-8?B?bGpQQU9ib1FkaFZuQVFrWkVmL01OeWdNSytwU2dFcmppRy9NeXNJWTRZVlNw?=
 =?utf-8?B?QktWa1JMRWxadXByRElxVTRnNjhqa0FjSVJudUhFbVBlYzlXSGhYcUMxTmEz?=
 =?utf-8?B?WEdoU212bndkNlFER1hEMDUvVmQySEkzblBPeVRVMzNsTzJhRUpISG1tVy95?=
 =?utf-8?B?cGU5bkFnUUFkMlBhS2dEWCtiL3YrQlRsbTBtMytsMEdxVU1GUEdwVlBkVHcr?=
 =?utf-8?B?SE5JWUd2a2FTUXhRV25uaTNjZUYrOFRKR3BIU2MwNVczRmt0ZjBjdXR2UkI4?=
 =?utf-8?Q?gMLkN0=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <E33CE94385050F4F8EC7D5B59793F26A@namprd15.prod.outlook.com>
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR15MB2999.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f30f7ec0-de85-4460-afb1-08d8c3ae17f4
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Jan 2021 16:59:36.5773
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: A/zHFj6hmq56qFl/Hqunw/WRqTwMZqw3INwtyKPzF5uZsBeKvUo8Hpr9UqkfXvcwmcY/ymqlncRc7Ow1G9j+fw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB2245
X-OriginatorOrg: fb.com
Content-Transfer-Encoding: base64
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.343,18.0.737
 definitions=2021-01-28_12:2021-01-28,2021-01-28 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 suspectscore=0
 spamscore=0 lowpriorityscore=0 adultscore=0 mlxlogscore=999 malwarescore=0
 impostorscore=0 clxscore=1011 phishscore=0 priorityscore=1501 mlxscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2101280082
X-FB-Internal: deliver
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCj4gT24gSmFuIDI4LCAyMDIxLCBhdCA4OjMzIEFNLCBaaSBZYW4gPHppeUBudmlkaWEuY29t
PiB3cm90ZToNCj4gDQo+IE9uIDI4IEphbiAyMDIxLCBhdCA1OjQ5LCBTYXJhdmFuYW4gRCB3cm90
ZToNCj4gDQo+PiBUbyBoZWxwIHdpdGggZGVidWdnaW5nIHRoZSBzbHVnZ2lzaG5lc3MgY2F1c2Vk
IGJ5IFRMQiBtaXNzL3JlbG9hZCwNCj4+IHdlIGludHJvZHVjZSBtb25vdG9uaWMgbGlmZXRpbWUg
aHVnZXBhZ2Ugc3BsaXQgZXZlbnQgY291bnRzIHNpbmNlDQo+PiBzeXN0ZW0gc3RhdGU6IFNZU1RF
TV9SVU5OSU5HIHRvIGJlIGRpc3BsYXllZCBhcyBwYXJ0IG9mDQo+PiAvcHJvYy92bXN0YXQgaW4g
eDg2IHNlcnZlcnMNCj4+IA0KPj4gVGhlIGxpZmV0aW1lIHNwbGl0IGV2ZW50IGluZm9ybWF0aW9u
IHdpbGwgYmUgZGlzcGxheWVkIGF0IHRoZSBib3R0b20gb2YNCj4+IC9wcm9jL3Ztc3RhdA0KPj4g
Li4uLg0KPj4gc3dhcF9yYSAwDQo+PiBzd2FwX3JhX2hpdCAwDQo+PiBkaXJlY3RfbWFwX2xldmVs
Ml9zcGxpdHMgOTQNCj4+IGRpcmVjdF9tYXBfbGV2ZWwzX3NwbGl0cyA0DQo+PiBucl91bnN0YWJs
ZSAwDQo+PiAuLi4uDQo+PiANCj4+IE9uZSBvZiB0aGUgbWFueSBsYXN0aW5nIChhcyB3ZSBkb24n
dCBjb2FsZXNjZSBiYWNrKSBzb3VyY2VzIGZvciBodWdlIHBhZ2UNCj4+IHNwbGl0cyBpcyB0cmFj
aW5nIGFzIHRoZSBncmFudWxhciBwYWdlIGF0dHJpYnV0ZS9wZXJtaXNzaW9uIGNoYW5nZXMgd291
bGQNCj4+IGZvcmNlIHRoZSBrZXJuZWwgdG8gc3BsaXQgY29kZSBzZWdtZW50cyBtYXBwZWQgdG8g
aHVnZSBwYWdlcyB0byBzbWFsbGVyDQo+PiBvbmVzIHRoZXJlYnkgaW5jcmVhc2luZyB0aGUgcHJv
YmFiaWxpdHkgb2YgVExCIG1pc3MvcmVsb2FkIGV2ZW4gYWZ0ZXINCj4+IHRyYWNpbmcgaGFzIGJl
ZW4gc3RvcHBlZC4NCj4gDQo+IEl0IGlzIGludGVyZXN0aW5nIHRvIHNlZSB0aGlzIHN0YXRlbWVu
dCBzYXlpbmcgc3BsaXR0aW5nIGtlcm5lbCBkaXJlY3QgbWFwcGluZ3MNCj4gY2F1c2VzIHBlcmZv
cm1hbmNlIGxvc3MsIHdoZW4gWmhlbmdqdW4gKGNj4oCZZCkgZnJvbSBJbnRlbCByZWNlbnRseSBw
b3N0ZWQNCj4gYSBrZXJuZWwgZGlyZWN0IG1hcHBpbmcgcGVyZm9ybWFuY2UgcmVwb3J0WzFdIHNh
eWluZyAxR0IgbWFwcGluZ3MgYXJlIGdvb2QNCj4gYnV0IG5vdCBtdWNoIGJldHRlciB0aGFuIDJN
QiBhbmQgNEtCIG1hcHBpbmdzLg0KPiANCj4gSSB3b3VsZCBsb3ZlIHRvIGhlYXIgdGhlIHN0b3Jp
ZXMgZnJvbSBib3RoIHNpZGVzLiBPciBtYXliZSBJIG1pc3VuZGVyc3RhbmQNCj4gYW55dGhpbmcu
DQoNCldlIGhhZCBhbiBpc3N1ZSBhYm91dCAxLjUgeWVhcnMgYWdvLCB3aGVuIGZ0cmFjZSBzcGxp
dHMgMk1CIGtlcm5lbCB0ZXh0IHBhZ2UNCnRhYmxlIGVudHJ5IGludG8gNTEyeCA0a0Igb25lcy4g
VGhpcyBzcGxpdCBjYXVzZWQgfjElIHBlcmZvcm1hbmNlIHJlZ3Jlc3Npb24uIA0KVGhhdCBpbnN0
YW5jZSB3YXMgZml4ZWQgaW4gWzFdLiANCg0KU2FyYXZhbmFuLCBjb3VsZCB5b3UgcGxlYXNlIHNo
YXJlIG1vcmUgaW5mb3JtYXRpb24gYWJvdXQgdGhlIHNwbGl0LiBJcyBpdCANCnBvc3NpYmxlIHRv
IGF2b2lkIHRoZSBzcGxpdD8gSWYgbm90LCBjYW4gd2UgcmVncm91cCBhZnRlciB0cmFjaW5nIGlz
IGRpc2FibGVkPw0KDQpXZSBoYXZlIHRoZSBzcGxpdC1hbmQtcmVncm91cCBsb2dpYyBmb3IgYXBw
bGljYXRpb24gLnRleHQgb24gVEhQLiBXaGVuIHVwcm9iZSANCmlzIGF0dGFjaGVkIHRvIHRoZSBU
SFAgdGV4dCwgd2UgaGF2ZSB0byBzcGxpdCB0aGUgMk1CIHBhZ2UgdGFibGUgZW50cnkuIFNvIHdl
DQppbnRyb2R1Y2VkIG1lY2hhbmlzbSB0byByZWdyb3VwIHRoZSAyTUIgcGFnZSB0YWJsZSBlbnRy
eSB3aGVuIGFsbCB1cHJvYmVzIGFyZQ0KcmVtb3ZlZCBmcm9tIHRoZSBUSFAgWzJdLiANCg0KVGhh
bmtzLA0KU29uZw0KDQpbMV0gY29tbWl0IDdhZjAxNDUwNjdiYyAoIng4Ni9tbS9jcGE6IFByZXZl
bnQgbGFyZ2UgcGFnZSBzcGxpdCB3aGVuIGZ0cmFjZSBmbGlwcyBSVyBvbiBrZXJuZWwgdGV4dCIp
DQpbMl0gY29tbWl0IGYzODVjYjg1YTQyZiAoInVwcm9iZTogY29sbGFwc2UgVEhQIHBtZCBhZnRl
ciByZW1vdmluZyBhbGwgdXByb2JlcyIpDQoNCj4gDQo+IA0KPiBbMV1odHRwczovL2xvcmUua2Vy
bmVsLm9yZy9saW51eC1tbS8yMTNiNDU2Ny00NmNlLWYxMTYtOWNkZi1iYmQwYzg4NGViM2NAbGlu
dXguaW50ZWwuY29tLw0KPj4gDQo+PiBEb2N1bWVudGF0aW9uIHJlZ2FyZGluZyBsaW5lYXIgbWFw
cGluZyBzcGxpdCBldmVudHMgYWRkZWQgdG8gYWRtaW4tZ3VpZGUNCj4+IGFzIHJlcXVlc3RlZCBp
biBWMyBvZiB0aGUgcGF0Y2guDQo+PiANCj4+IFNpZ25lZC1vZmYtYnk6IFNhcmF2YW5hbiBEIDxz
YXJhdmFuYW5kQGZiLmNvbT4NCj4+IC0tLQ0KPj4gLi4uL2FkbWluLWd1aWRlL21tL2RpcmVjdF9t
YXBwaW5nX3NwbGl0cy5yc3QgIHwgNTkgKysrKysrKysrKysrKysrKysrKw0KPj4gRG9jdW1lbnRh
dGlvbi9hZG1pbi1ndWlkZS9tbS9pbmRleC5yc3QgICAgICAgIHwgIDEgKw0KPj4gYXJjaC94ODYv
bW0vcGF0L3NldF9tZW1vcnkuYyAgICAgICAgICAgICAgICAgIHwgIDggKysrDQo+PiBpbmNsdWRl
L2xpbnV4L3ZtX2V2ZW50X2l0ZW0uaCAgICAgICAgICAgICAgICAgfCAgNCArKw0KPj4gbW0vdm1z
dGF0LmMgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHwgIDQgKysNCj4+IDUgZmls
ZXMgY2hhbmdlZCwgNzYgaW5zZXJ0aW9ucygrKQ0KPj4gY3JlYXRlIG1vZGUgMTAwNjQ0IERvY3Vt
ZW50YXRpb24vYWRtaW4tZ3VpZGUvbW0vZGlyZWN0X21hcHBpbmdfc3BsaXRzLnJzdA0KPj4gDQo+
PiBkaWZmIC0tZ2l0IGEvRG9jdW1lbnRhdGlvbi9hZG1pbi1ndWlkZS9tbS9kaXJlY3RfbWFwcGlu
Z19zcGxpdHMucnN0IGIvRG9jdW1lbnRhdGlvbi9hZG1pbi1ndWlkZS9tbS9kaXJlY3RfbWFwcGlu
Z19zcGxpdHMucnN0DQo+PiBuZXcgZmlsZSBtb2RlIDEwMDY0NA0KPj4gaW5kZXggMDAwMDAwMDAw
MDAwLi4yOTg3NTEzOTFkZWINCj4+IC0tLSAvZGV2L251bGwNCj4+ICsrKyBiL0RvY3VtZW50YXRp
b24vYWRtaW4tZ3VpZGUvbW0vZGlyZWN0X21hcHBpbmdfc3BsaXRzLnJzdA0KPj4gQEAgLTAsMCAr
MSw1OSBAQA0KPj4gKy4uIFNQRFgtTGljZW5zZS1JZGVudGlmaWVyOiBHUEwtMi4wDQo+PiArDQo+
PiArPT09PT09PT09PT09PT09PT09PT09DQo+PiArRGlyZWN0IE1hcHBpbmcgU3BsaXRzDQo+PiAr
PT09PT09PT09PT09PT09PT09PT09DQo+PiArDQo+PiArS2VybmVsIG1hcHMgYWxsIG9mIHBoeXNp
Y2FsIG1lbW9yeSBpbiBsaW5lYXIvZGlyZWN0IG1hcHBlZCBwYWdlcyB3aXRoDQo+PiArdHJhbnNs
YXRpb24gb2YgdmlydHVhbCBrZXJuZWwgYWRkcmVzcyB0byBwaHlzaWNhbCBhZGRyZXNzIGlzIGFj
aGlldmVkDQo+PiArdGhyb3VnaCBhIHNpbXBsZSBzdWJ0cmFjdGlvbiBvZiBvZmZzZXQuIENQVXMg
bWFpbnRhaW4gYSBjYWNoZSBvZiB0aGVzZQ0KPj4gK3RyYW5zbGF0aW9ucyBvbiBmYXN0IGNhY2hl
cyBjYWxsZWQgVExCcy4gQ1BVIGFyY2hpdGVjdHVyZXMgbGlrZSB4ODYgYWxsb3cNCj4+ICtkaXJl
Y3QgbWFwcGluZyBsYXJnZSBwb3J0aW9ucyBvZiBtZW1vcnkgaW50byBodWdlcGFnZXMgKDJNLCAx
RywgZXRjKSBpbg0KPj4gK3ZhcmlvdXMgcGFnZSB0YWJsZSBsZXZlbHMuDQo+PiArDQo+PiArTWFp
bnRhaW5pbmcgaHVnZSBkaXJlY3QgbWFwcGVkIHBhZ2VzIGdyZWF0bHkgcmVkdWNlcyBUTEIgbWlz
cyBwcmVzc3VyZS4NCj4+ICtUaGUgc3BsaW50ZXJpbmcgb2YgaHVnZSBkaXJlY3QgcGFnZXMgaW50
byBzbWFsbGVyIG9uZXMgZG9lcyByZXN1bHQgaW4NCj4+ICthIG1lYXN1cmFibGUgcGVyZm9ybWFu
Y2UgaGl0IGNhdXNlZCBieSBmcmVxdWVudCBUTEIgbWlzcyBhbmQgcmVsb2Fkcy4NCj4+ICsNCj4+
ICtPbmUgb2YgdGhlIG1hbnkgbGFzdGluZyAoYXMgd2UgZG9uJ3QgY29hbGVzY2UgYmFjaykgc291
cmNlcyBmb3IgaHVnZSBwYWdlDQo+PiArc3BsaXRzIGlzIHRyYWNpbmcgYXMgdGhlIGdyYW51bGFy
IHBhZ2UgYXR0cmlidXRlL3Blcm1pc3Npb24gY2hhbmdlcyB3b3VsZA0KPj4gK2ZvcmNlIHRoZSBr
ZXJuZWwgdG8gc3BsaXQgY29kZSBzZWdtZW50cyBtYXBwZWQgdG8gaHVnZXBhZ2VzIHRvIHNtYWxs
ZXINCj4+ICtvbmVzIHRodXMgaW5jcmVhc2luZyB0aGUgcHJvYmFiaWxpdHkgb2YgVExCIG1pc3Mv
cmVsb2FkcyBldmVuIGFmdGVyDQo+PiArdHJhY2luZyBoYXMgYmVlbiBzdG9wcGVkLg0KPj4gKw0K
Pj4gK09uIHg4NiBzeXN0ZW1zLCB3ZSBjYW4gdHJhY2sgdGhlIHNwbGl0dGluZyBvZiBodWdlIGRp
cmVjdCBtYXBwZWQgcGFnZXMNCj4+ICt0aHJvdWdoIGxpZmV0aW1lIGV2ZW50IGNvdW50ZXJzIGlu
IGBgL3Byb2Mvdm1zdGF0YGANCj4+ICsNCj4+ICsJZGlyZWN0X21hcF9sZXZlbDJfc3BsaXRzIHh4
eA0KPj4gKwlkaXJlY3RfbWFwX2xldmVsM19zcGxpdHMgeXl5DQo+PiArDQo+PiArd2hlcmU6DQo+
PiArDQo+PiArZGlyZWN0X21hcF9sZXZlbDJfc3BsaXRzDQo+PiArCWFyZSAyTS80TSBodWdlcGFn
ZSBzcGxpdCBldmVudHMNCj4+ICtkaXJlY3RfbWFwX2xldmVsM19zcGxpdHMNCj4+ICsJYXJlIDFH
IGh1Z2VwYWdlIHNwbGl0IGV2ZW50cw0KPj4gKw0KPj4gK1RoZSBkaXN0cmlidXRpb24gb2YgZGly
ZWN0IG1hcHBlZCBzeXN0ZW0gbWVtb3J5IGluIHZhcmlvdXMgcGFnZSBzaXplcw0KPj4gK3Bvc3Qg
c3BsaXRzIGNhbiBiZSB2aWV3ZWQgdGhyb3VnaCBgYC9wcm9jL21lbWluZm9gYCB3aG9zZSBvdXRw
dXQNCj4+ICt3aWxsIGluY2x1ZGUgdGhlIGZvbGxvd2luZyBsaW5lcyBkZXBlbmRpbmcgdXBvbiBz
dXBwb3J0aW5nIENQVQ0KPj4gK2FyY2hpdGVjdHVyZQ0KPj4gKw0KPj4gKwlEaXJlY3RNYXA0azog
ICAgeHh4eHgga0INCj4+ICsJRGlyZWN0TWFwMk06ICAgIHl5eXl5IGtCDQo+PiArCURpcmVjdE1h
cDFHOiAgICB6enp6eiBrQg0KPj4gKw0KPj4gK3doZXJlOg0KPj4gKw0KPj4gK0RpcmVjdE1hcDRr
DQo+PiArCWlzIHRoZSB0b3RhbCBhbW91bnQgb2YgZGlyZWN0IG1hcHBlZCBtZW1vcnkgKGluIGtC
KQ0KPj4gKwlhY2Nlc3NlZCB0aHJvdWdoIDRrIHBhZ2VzDQo+PiArRGlyZWN0TWFwMk0NCj4+ICsJ
aXMgdGhlIHRvdGFsIGFtb3VudCBvZiBkaXJlY3QgbWFwcGVkIG1lbW9yeSAoaW4ga0IpDQo+PiAr
CWFjY2Vzc2VkIHRocm91Z2ggMk0gcGFnZXMNCj4+ICtEaXJlY3RNYXAxRw0KPj4gKwlpcyB0aGUg
dG90YWwgYW1vdW50IG9mIGRpcmVjdCBtYXBwZWQgbWVtb3J5IChpbiBrQikNCj4+ICsJYWNjZXNz
ZWQgdGhyb3VnaCAxRyBwYWdlcw0KPj4gKw0KPj4gKw0KPj4gKy0tIFNhcmF2YW5hbiBELCBKYW4g
MjcsIDIwMjENCj4+IGRpZmYgLS1naXQgYS9Eb2N1bWVudGF0aW9uL2FkbWluLWd1aWRlL21tL2lu
ZGV4LnJzdCBiL0RvY3VtZW50YXRpb24vYWRtaW4tZ3VpZGUvbW0vaW5kZXgucnN0DQo+PiBpbmRl
eCA0YjE0ZDhiNTBlOWUuLjk0Mzk3ODBmM2YwNyAxMDA2NDQNCj4+IC0tLSBhL0RvY3VtZW50YXRp
b24vYWRtaW4tZ3VpZGUvbW0vaW5kZXgucnN0DQo+PiArKysgYi9Eb2N1bWVudGF0aW9uL2FkbWlu
LWd1aWRlL21tL2luZGV4LnJzdA0KPj4gQEAgLTM4LDMgKzM4LDQgQEAgdGhlIExpbnV4IG1lbW9y
eSBtYW5hZ2VtZW50Lg0KPj4gICAgc29mdC1kaXJ0eQ0KPj4gICAgdHJhbnNodWdlDQo+PiAgICB1
c2VyZmF1bHRmZA0KPj4gKyAgIGRpcmVjdF9tYXBwaW5nX3NwbGl0cw0KPj4gZGlmZiAtLWdpdCBh
L2FyY2gveDg2L21tL3BhdC9zZXRfbWVtb3J5LmMgYi9hcmNoL3g4Ni9tbS9wYXQvc2V0X21lbW9y
eS5jDQo+PiBpbmRleCAxNmY4NzhjMjY2NjcuLmE3YjNjNWYxZDMxNiAxMDA2NDQNCj4+IC0tLSBh
L2FyY2gveDg2L21tL3BhdC9zZXRfbWVtb3J5LmMNCj4+ICsrKyBiL2FyY2gveDg2L21tL3BhdC9z
ZXRfbWVtb3J5LmMNCj4+IEBAIC0xNiw2ICsxNiw4IEBADQo+PiAjaW5jbHVkZSA8bGludXgvcGNp
Lmg+DQo+PiAjaW5jbHVkZSA8bGludXgvdm1hbGxvYy5oPg0KPj4gI2luY2x1ZGUgPGxpbnV4L2xp
Ym52ZGltbS5oPg0KPj4gKyNpbmNsdWRlIDxsaW51eC92bXN0YXQuaD4NCj4+ICsjaW5jbHVkZSA8
bGludXgva2VybmVsLmg+DQo+PiANCj4+ICNpbmNsdWRlIDxhc20vZTgyMC9hcGkuaD4NCj4+ICNp
bmNsdWRlIDxhc20vcHJvY2Vzc29yLmg+DQo+PiBAQCAtOTEsNiArOTMsMTIgQEAgc3RhdGljIHZv
aWQgc3BsaXRfcGFnZV9jb3VudChpbnQgbGV2ZWwpDQo+PiAJCXJldHVybjsNCj4+IA0KPj4gCWRp
cmVjdF9wYWdlc19jb3VudFtsZXZlbF0tLTsNCj4+ICsJaWYgKHN5c3RlbV9zdGF0ZSA9PSBTWVNU
RU1fUlVOTklORykgew0KPj4gKwkJaWYgKGxldmVsID09IFBHX0xFVkVMXzJNKQ0KPj4gKwkJCWNv
dW50X3ZtX2V2ZW50KERJUkVDVF9NQVBfTEVWRUwyX1NQTElUKTsNCj4+ICsJCWVsc2UgaWYgKGxl
dmVsID09IFBHX0xFVkVMXzFHKQ0KPj4gKwkJCWNvdW50X3ZtX2V2ZW50KERJUkVDVF9NQVBfTEVW
RUwzX1NQTElUKTsNCj4+ICsJfQ0KPj4gCWRpcmVjdF9wYWdlc19jb3VudFtsZXZlbCAtIDFdICs9
IFBUUlNfUEVSX1BURTsNCj4+IH0NCj4+IA0KPj4gZGlmZiAtLWdpdCBhL2luY2x1ZGUvbGludXgv
dm1fZXZlbnRfaXRlbS5oIGIvaW5jbHVkZS9saW51eC92bV9ldmVudF9pdGVtLmgNCj4+IGluZGV4
IDE4ZTc1OTc0ZDRlMy4uN2MwNmMyYmRjMzNiIDEwMDY0NA0KPj4gLS0tIGEvaW5jbHVkZS9saW51
eC92bV9ldmVudF9pdGVtLmgNCj4+ICsrKyBiL2luY2x1ZGUvbGludXgvdm1fZXZlbnRfaXRlbS5o
DQo+PiBAQCAtMTIwLDYgKzEyMCwxMCBAQCBlbnVtIHZtX2V2ZW50X2l0ZW0geyBQR1BHSU4sIFBH
UEdPVVQsIFBTV1BJTiwgUFNXUE9VVCwNCj4+ICNpZmRlZiBDT05GSUdfU1dBUA0KPj4gCQlTV0FQ
X1JBLA0KPj4gCQlTV0FQX1JBX0hJVCwNCj4+ICsjZW5kaWYNCj4+ICsjaWZkZWYgQ09ORklHX1g4
Ng0KPj4gKwkJRElSRUNUX01BUF9MRVZFTDJfU1BMSVQsDQo+PiArCQlESVJFQ1RfTUFQX0xFVkVM
M19TUExJVCwNCj4+ICNlbmRpZg0KPj4gCQlOUl9WTV9FVkVOVF9JVEVNUw0KPj4gfTsNCj4+IGRp
ZmYgLS1naXQgYS9tbS92bXN0YXQuYyBiL21tL3Ztc3RhdC5jDQo+PiBpbmRleCBmODk0MjE2MGZj
OTUuLmE0M2FjNGFjOThhMiAxMDA2NDQNCj4+IC0tLSBhL21tL3Ztc3RhdC5jDQo+PiArKysgYi9t
bS92bXN0YXQuYw0KPj4gQEAgLTEzNTAsNiArMTM1MCwxMCBAQCBjb25zdCBjaGFyICogY29uc3Qg
dm1zdGF0X3RleHRbXSA9IHsNCj4+IAkic3dhcF9yYSIsDQo+PiAJInN3YXBfcmFfaGl0IiwNCj4+
ICNlbmRpZg0KPj4gKyNpZmRlZiBDT05GSUdfWDg2DQo+PiArCSJkaXJlY3RfbWFwX2xldmVsMl9z
cGxpdHMiLA0KPj4gKwkiZGlyZWN0X21hcF9sZXZlbDNfc3BsaXRzIiwNCj4+ICsjZW5kaWYNCj4+
ICNlbmRpZiAvKiBDT05GSUdfVk1fRVZFTlRfQ09VTlRFUlMgfHwgQ09ORklHX01FTUNHICovDQo+
PiB9Ow0KPj4gI2VuZGlmIC8qIENPTkZJR19QUk9DX0ZTIHx8IENPTkZJR19TWVNGUyB8fCBDT05G
SUdfTlVNQSB8fCBDT05GSUdfTUVNQ0cgKi8NCj4+IC0tIA0KPj4gMi4yNC4xDQo+IA0KPiANCj4g
4oCUDQo+IEJlc3QgUmVnYXJkcywNCj4gWWFuIFppDQoNCg==
