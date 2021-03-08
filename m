Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC20D331571
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Mar 2021 19:04:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230125AbhCHSD2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Mar 2021 13:03:28 -0500
Received: from mx0b-00154904.pphosted.com ([148.163.137.20]:27490 "EHLO
        mx0b-00154904.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230409AbhCHSDL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Mar 2021 13:03:11 -0500
Received: from pps.filterd (m0170394.ppops.net [127.0.0.1])
        by mx0b-00154904.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 128Hl5nl004228;
        Mon, 8 Mar 2021 13:02:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dell.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=smtpout1;
 bh=jH09qDCo8ljOsJl8kuAyqFZrLgkTk3Q9uBvjDzMCw+Y=;
 b=GogrUBOalFtfr7B7SadcB5pk2BCpSrIXuzZMZhqWOz/vvcJAQfnX6arqE4SKYXqlnCcN
 VYulR1P80TmjxGwyeLKkQRkc52qOnB0WEuZIbVkS1jiVfsLfbfU6ZDvnJa+R/1omSiXE
 If58Ddtbn5NiDZe1klNCaWm1HtOAYUBmgCfVQg5EDcXgKyNOxJ6tAr3k7nXuM1DhTIcv
 LixoHOfc3vn1QKQKm9UbdjsOVKtKwI+hUN8s7bip/o6uSHfqgkWuAgB9b87fUpj1PZWM
 bGH+uuDLGWkfwwlqd3GeCu4pkhu0LBl0NdKuzjhCBZf8V3AusGw5SXi7H7H0DQLsQhTo 4A== 
Received: from mx0b-00154901.pphosted.com (mx0b-00154901.pphosted.com [67.231.157.37])
        by mx0b-00154904.pphosted.com with ESMTP id 37456bdmsm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 08 Mar 2021 13:02:04 -0500
Received: from pps.filterd (m0089483.ppops.net [127.0.0.1])
        by mx0b-00154901.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 128HjM3c046632;
        Mon, 8 Mar 2021 13:02:03 -0500
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2168.outbound.protection.outlook.com [104.47.57.168])
        by mx0b-00154901.pphosted.com with ESMTP id 374qkn2u2d-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 08 Mar 2021 13:02:02 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Tm02rFYxiOij3/9F9UIZfpHzi33e6NXOpjt9X5pZcpM8p4GkHalHJVCsU8t6IBFuZREep5Ja24bpBWE9BAbeT6a9670Q2KgA6XX9hFQS/XZHevLvg+gA60rQGY0sajVBRRNjaHJYI3fPwksjrKto9qBFYD7yv4H2/N2acVnvcoFUKmRufg0niWE69C0hKL8NhrAqVFJnUv2xvk2aP42B8B1HT4wnJpNvoADLc2reFsPZgGTg+p37qqjnr4zyfJCIk2UH/tTNCDjgYhGQg9im93sLsn03rtlya4XHtbR1UO279DSgrUj/f7FHzUBr6pMuzg6Y3KIdyrsF4rW+PcMZLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jH09qDCo8ljOsJl8kuAyqFZrLgkTk3Q9uBvjDzMCw+Y=;
 b=bjNAqByEPJGTZdPL+34sRGC5C7n+TCRSCcmZ5AdHgiTqEMh2cgYvuON0hb6di0INlSu06OanvqDT1NpoyC5JjD+CC4oQnhBP4Ms/CT6WgfgT0O4D4NWidDJkHWCSc1hck8CnlOGAuhY5a16QepjB7JbTNwLch/k615utaFOu1Qco438NQwy9jcDiFE9X+ALBpXczlsfRGCR7rMZ9CGQr1RgNg5YY1No4yzw2AGzsEnuhw9jfMPLQKzuYt19/v25UAj809cWHfto1JogfinO0obFr2NwV0GONBirgI2x0OAzaqJwRWTho+pwAPOH9BmO7MvPV02jubxzL1omvQBYr4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=dell.com; dmarc=pass action=none header.from=dell.com;
 dkim=pass header.d=dell.com; arc=none
Received: from SA1PR19MB4926.namprd19.prod.outlook.com (2603:10b6:806:1a6::18)
 by SA0PR19MB4443.namprd19.prod.outlook.com (2603:10b6:806:c3::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3912.26; Mon, 8 Mar
 2021 18:02:01 +0000
Received: from SA1PR19MB4926.namprd19.prod.outlook.com
 ([fe80::1c92:24d3:b11f:bc50]) by SA1PR19MB4926.namprd19.prod.outlook.com
 ([fe80::1c92:24d3:b11f:bc50%6]) with mapi id 15.20.3912.027; Mon, 8 Mar 2021
 18:02:01 +0000
From:   "Limonciello, Mario" <Mario.Limonciello@dell.com>
To:     Rajneesh Bhardwaj <irenic.rajneesh@gmail.com>
CC:     "David E. Box" <david.e.box@linux.intel.com>,
        "hdegoede@redhat.com" <hdegoede@redhat.com>,
        "mgross@linux.intel.com" <mgross@linux.intel.com>,
        "sasha.neftin@intel.com" <sasha.neftin@intel.com>,
        "platform-driver-x86@vger.kernel.org" 
        <platform-driver-x86@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>
Subject: RE: [PATCH] platform/x86: intel_pmc: Ignore GBE LTR on Tiger Lake
 platforms
Thread-Topic: [PATCH] platform/x86: intel_pmc: Ignore GBE LTR on Tiger Lake
 platforms
Thread-Index: AQHXEfLhzYLSroQh8UmKnpvnJJhjqqp6Wj0AgAADo4CAAAd1sA==
Date:   Mon, 8 Mar 2021 18:02:00 +0000
Message-ID: <SA1PR19MB49260612D4BEC9AA3FCA85A3FA939@SA1PR19MB4926.namprd19.prod.outlook.com>
References: <20210305190608.1834164-1-david.e.box@linux.intel.com>
 <SA1PR19MB49261823693E915E7D646B07FA939@SA1PR19MB4926.namprd19.prod.outlook.com>
 <CAE2upjT1SabzsEtxnVzFV9hVDVm-KuqXP9QEQqO6HHKVS0-HZg@mail.gmail.com>
In-Reply-To: <CAE2upjT1SabzsEtxnVzFV9hVDVm-KuqXP9QEQqO6HHKVS0-HZg@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Enabled=True;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_SiteId=945c199a-83a2-4e80-9f8c-5a91be5752dd;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Owner=Mario_Limonciello@Dell.com;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_SetDate=2021-03-08T18:01:57.9155413Z;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Name=External Public;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_ActionId=df8f9ae3-0702-410c-b19a-7376884fb7c9;
 MSIP_Label_17cb76b2-10b8-4fe1-93d4-2202842406cd_Extended_MSFT_Method=Manual
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=Dell.com;
x-originating-ip: [76.251.167.31]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 0617429b-1110-4139-2c31-08d8e25c45ec
x-ms-traffictypediagnostic: SA0PR19MB4443:
x-microsoft-antispam-prvs: <SA0PR19MB4443193AA3442F3435841509FA939@SA0PR19MB4443.namprd19.prod.outlook.com>
x-exotenant: 2khUwGVqB6N9v58KS13ncyUmMJd8q4
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: p+ZehGY5Up5eCrWJGRmdMtB+ER2hZx8NpFLifAOzq3gR0JCJX0rqXbSwsQAWYwjdpU6kc1KHnT9LCzZoeIQW+V1Ph4h3x4WcwbgZ7QpjnTYUk9hgcvhJy26+YaCJRwiYLDgnOtKpa0GVL5M//02+mDiCUSnWy44bKNElwnIT2Lx8rfuaZrVBVG2vhogGSAzOLIrBY8I3r9/t2cela6O59G+lBZyPTh20CIIMkb/yi4gpvT8OyABMjIImzgYjGI3PAkayRQusFaQ6WEXDw8FjwXXOzxwl0tORsc3WB6pP32zeqnkokb0ieVho7CBjdq9msmpAqcebEv+ZkvrmsRt0cym5F3cCqRArDStFjKKHv7ilSNyHvh/4+bsp90WfUfCyvxNugns9IMMfu/FuHlbLc5Z6iscFi/2YIZGbYggjBeKypiXAEbes8A6hRpQ3nzih0SgidYLNnf/+aGgDzGsnlhbEG60nUD0sF0hEX1IBrqGKVJ+cUQGyimA7u+kLUOYGDP5qdMuAu1XMJHXwrYjgJg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR19MB4926.namprd19.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(136003)(366004)(376002)(396003)(346002)(83380400001)(86362001)(9686003)(55016002)(186003)(33656002)(316002)(6506007)(53546011)(786003)(7696005)(6916009)(8676002)(478600001)(8936002)(66556008)(71200400001)(5660300002)(76116006)(66946007)(54906003)(66476007)(66446008)(64756008)(52536014)(26005)(2906002)(4326008);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?utf-8?B?dHJObktTQWkxVmRQdGZ2ZmlKR0F3Q29IWnVzWmo5MXVoakdvSWg1WDc0cjNh?=
 =?utf-8?B?aCtyWTQzMjUxSEVzWS9xRFRGWk8xakkvd3VwT0xUNjJROG1XdXZPaXVZcVRu?=
 =?utf-8?B?T3R0YnNzT1cxSDBtTFFURG5NN2MwYVErQjc5anlQTlNINXpyMWR3KzJDV2VU?=
 =?utf-8?B?bm1aMFZKa1J3bDdGWnFIWnNiSTZPYURDZEtEazNrSkJqQ1htakVzUDV3TWxj?=
 =?utf-8?B?UnRrejVaeWlIa1l1QmZZOTg5d044UERkZnNzb2FSaVZENTAxcERvSVBUL3N0?=
 =?utf-8?B?YW9BOXVsV0M4VElCVHAwUVZFRmE0SlNreXhWdCtLcVJEWHRhU3U0Tm5TU3lO?=
 =?utf-8?B?cnhmNlh0amE1MEs5K1p6WFlDSXdBdGNPbmt1T1FMMXgwRTdkUUFXMVZFeFlu?=
 =?utf-8?B?bGtOTlc0Qk9LeENER2VsdDFNK1Mxai9ES0Nxa0VQOTV5T1NSeUxibEtEOVJM?=
 =?utf-8?B?VXZCTzlOOFZIeUFWWXBCcG5QVG84WVdSQ0VlNmtDZWdMd3k3N0dHVTd6UDVS?=
 =?utf-8?B?NEhjdE5ET1FOM2x0elF0Z2NzVnh1UnJ2THZlTTdzczJGMkJEdUtEV1lMUWJP?=
 =?utf-8?B?T3hIWlhzVnFlcGNIclFGWTZHSUFIRkxVeDdUTUpRWFUxd1JqTTZ6WVFoZUZR?=
 =?utf-8?B?SU1QdDRheFFTQ3RYSzhCSFV3ZHpuUFlaUmdWZVF0ejloZEJ1VzR4NWR2VW1U?=
 =?utf-8?B?WElSV2pyekY4MmVKQ2gvZXZtcTdYbFd3dkdmbXljbUJVOUdKL2tPV01RK1pt?=
 =?utf-8?B?T25Sa1ZRaENrOFpuMTNMSUxIZjM1Y2NaSzRqQ2RUMjhPRW9mSVhudFhuaWF3?=
 =?utf-8?B?eUtkUEhlbUtoUm5RMHBSdURpVm9DT3RodmZsM0pLdFJHaE52ZERqOERsNFAx?=
 =?utf-8?B?YXZiOEliZ3NUTmNmbVdVSnFRamxDdVFmdVFwQno5VHNud0kwMzBSNnJITVNW?=
 =?utf-8?B?K2lhZm5NVlUyNjZQT0hONm9QcHo1YUpHU3RlRmxyeEg1QTk2Y1RzYk5TY01r?=
 =?utf-8?B?ck81ZHhaTGZUNFlNNFlsTjVPNDlzZzRVZFIrRUhQdEdhSnkrZmlFcnczNDRQ?=
 =?utf-8?B?bE4yNkFCZ1NQU05QSWlzTWFxVkttTEJWY0s0V0FQVHFrNURVeEEvdGdvYTRT?=
 =?utf-8?B?OEc1UlBXZ28rOFN6NUtzbzlod1hYcTNBWVFmTFlvMU15elpMbmx1MFNiNjFY?=
 =?utf-8?B?a3ZaS3hjemJZd25EZndHUy82S3NaTnJaRUpDVFo5TjdsZ3pqSm1aVFY1WFl1?=
 =?utf-8?B?TUc4eHZHSGM2a2hyTnByUWtXNGpjZndhYXNWYldaL1FYY1ZUclVGOHdJaG5S?=
 =?utf-8?B?T1QxZE1GQTMrQnVGR2F5T09jMFN6cHFoVGhreUNXWm5PRHBNOWdKbUxYSFp1?=
 =?utf-8?B?UWdoNHhxeXQ4bnMrQkZyVmhuSzZVZUFPTlR6RmgrbDh3OFJ3MkovR0xlRUl6?=
 =?utf-8?B?V3I4YTdoK0c5T3RtNjQwYVdkT2E2enl5V2gxaWtQRzNoaWtYY3VMdlhrSW5R?=
 =?utf-8?B?eXdRSHgrSkt1REUyUzA2Mk9iVmF6MUxUeUNBaGVWamRUWVYwUXpLRzFQRVpt?=
 =?utf-8?B?SS9HYk9HeDhoV1NXQkJidytuYVd4OFdEbUJEYllSMUd4NUlMSGc5NmQyeHlv?=
 =?utf-8?B?dStHSmpKb0YyU2RUSWtxR3E5YmFmZjZVd29waFg5Q0RQbDR6Q2JQYXlxOGNO?=
 =?utf-8?B?cmFEaHpHU3dWZHNKWDNublJuWjdCTjVZWDBEdTRwT2IxL09vYk4rZ2Q3RWxi?=
 =?utf-8?Q?b8YN28LZy9T+o4R7qLNtMBt8glziZj0W/2VZNik?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Dell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR19MB4926.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0617429b-1110-4139-2c31-08d8e25c45ec
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Mar 2021 18:02:00.8131
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 945c199a-83a2-4e80-9f8c-5a91be5752dd
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hOj9UNv//mSkSuBEATzzOPA6ylIe4pJXSsTGV5PtYZkUnC4lCep3qUiDZbfxEcElEELR4re6hprZR9BLJcxi7jt8eo9uUm7BGNv8xRWnH7s=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR19MB4443
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-03-08_14:2021-03-08,2021-03-08 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 bulkscore=0
 spamscore=0 clxscore=1015 priorityscore=1501 mlxscore=0 malwarescore=0
 impostorscore=0 lowpriorityscore=0 phishscore=0 mlxlogscore=999
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2103080095
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 adultscore=0 bulkscore=0
 mlxlogscore=999 mlxscore=0 malwarescore=0 phishscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2103080095
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogUmFqbmVlc2ggQmhhcmR3
YWogPGlyZW5pYy5yYWpuZWVzaEBnbWFpbC5jb20+DQo+IFNlbnQ6IE1vbmRheSwgTWFyY2ggOCwg
MjAyMSAxMTozMg0KPiBUbzogTGltb25jaWVsbG8sIE1hcmlvDQo+IENjOiBEYXZpZCBFLiBCb3g7
IGhkZWdvZWRlQHJlZGhhdC5jb207IG1ncm9zc0BsaW51eC5pbnRlbC5jb207DQo+IHNhc2hhLm5l
ZnRpbkBpbnRlbC5jb207IHBsYXRmb3JtLWRyaXZlci14ODZAdmdlci5rZXJuZWwub3JnOyBsaW51
eC0NCj4ga2VybmVsQHZnZXIua2VybmVsLm9yZzsgaW50ZWwtd2lyZWQtbGFuQGxpc3RzLm9zdW9z
bC5vcmcNCj4gU3ViamVjdDogUmU6IFtQQVRDSF0gcGxhdGZvcm0veDg2OiBpbnRlbF9wbWM6IEln
bm9yZSBHQkUgTFRSIG9uIFRpZ2VyIExha2UNCj4gcGxhdGZvcm1zDQo+IA0KPiANCj4gW0VYVEVS
TkFMIEVNQUlMXQ0KPiANCj4gT24gTW9uLCBNYXIgOCwgMjAyMSBhdCAxMjoyMCBQTSBMaW1vbmNp
ZWxsbywgTWFyaW8NCj4gPE1hcmlvLkxpbW9uY2llbGxvQGRlbGwuY29tPiB3cm90ZToNCj4gPg0K
PiA+ID4NCj4gPiA+IFtFWFRFUk5BTCBFTUFJTF0NCj4gPiA+DQo+ID4gPiBEdWUgdG8gYSBIVyBs
aW1pdGF0aW9uLCB0aGUgTGF0ZW5jeSBUb2xlcmFuY2UgUmVwb3J0aW5nIChMVFIpIHZhbHVlDQo+
ID4gPiBwcm9ncmFtbWVkIGluIHRoZSBUaWdlciBMYWtlIEdCRSBjb250cm9sbGVyIGlzIG5vdCBs
YXJnZSBlbm91Z2ggdG8gYWxsb3cNCj4gPiA+IHRoZSBwbGF0Zm9ybSB0byBlbnRlciBQYWNrYWdl
IEMxMCwgd2hpY2ggaW4gdHVybiBwcmV2ZW50cyB0aGUgcGxhdGZvcm0NCj4gZnJvbQ0KPiA+ID4g
YWNoaWV2aW5nIGl0cyBsb3cgcG93ZXIgdGFyZ2V0IGR1cmluZyBzdXNwZW5kLXRvLWlkbGUuICBJ
Z25vcmUgdGhlIEdCRSBMVFINCj4gPiA+IHZhbHVlIG9uIFRpZ2VyIExha2UuIExUUiBpZ25vcmUg
ZnVuY3Rpb25hbGl0eSBpcyBjdXJyZW50bHkgcGVyZm9ybWVkDQo+IHNvbGVseQ0KPiA+ID4gYnkg
YSBkZWJ1Z2ZzIHdyaXRlIGNhbGwuIFNwbGl0IG91dCB0aGUgTFRSIGNvZGUgaW50byBpdHMgb3du
IGZ1bmN0aW9uIHRoYXQNCj4gPiA+IGNhbiBiZSBjYWxsZWQgYnkgYm90aCB0aGUgZGVidWdmcyB3
cml0ZXIgYW5kIGJ5IHRoaXMgd29yayBhcm91bmQuDQo+ID4gPg0KPiA+ID4gU2lnbmVkLW9mZi1i
eTogRGF2aWQgRS4gQm94IDxkYXZpZC5lLmJveEBsaW51eC5pbnRlbC5jb20+DQo+ID4gPiBSZXZp
ZXdlZC1ieTogU2FzaGEgTmVmdGluIDxzYXNoYS5uZWZ0aW5AaW50ZWwuY29tPg0KPiA+ID4gQ2M6
IGludGVsLXdpcmVkLWxhbkBsaXN0cy5vc3Vvc2wub3JnDQo+ID4gPiAtLS0NCj4gPiA+ICBkcml2
ZXJzL3BsYXRmb3JtL3g4Ni9pbnRlbF9wbWNfY29yZS5jIHwgNTUgKysrKysrKysrKysrKysrKysr
KystLS0tLS0tDQo+ID4gPiAgMSBmaWxlIGNoYW5nZWQsIDQyIGluc2VydGlvbnMoKyksIDEzIGRl
bGV0aW9ucygtKQ0KPiA+DQo+ID4gSSBmZWVsIGxpa2UgdGhpcyBkcml2ZXIgY2hhbmdlIGNhdXNl
cyBhIHdlYWsgcmVmZXJlbmNlIGJldHdlZW4gZTEwMDBlIGFuZA0KPiBpbnRlbF9wbWNfY29yZS4N
Cj4gPiBJdCB3b3VsZCBtZWFuIHNpZ25pZmljYW50bHkgZGlmZmVyZW50IGJlaGF2aW9yIGlmIHlv
dSB1c2UgZTEwMDBlIGJ1dCBkb24ndA0KPiBoYXZlIFBNQyBtb2R1bGUNCj4gPiBhdmFpbGFibGUg
Zm9yIGFueSByZWFzb24uDQo+IA0KPiBDYW4geW91IGVsYWJvcmF0ZSB3aGF0IHdvdWxkIGNoYW5n
ZSBzaWduaWZpY2FudGx5PyBUaGlzIGlzIGEgRlcvSFcNCj4gaXNzdWUgYW5kIHRoZSBkcml2ZXIg
aXMganVzdCBkb2luZyBhIHdvcmsgYXJvdW5kIHRvIGxldCB0aGUgcGxhdGZvcm0NCj4gZW50ZXIg
YSBkZWVwIGlkbGUgc3RhdGUgYmV5b25kIFBDMTAuIElmIHRoZSBzeXN0ZW0gY291bGQgZW50ZXIg
UEMxMA0KPiBhbmQgd2FzIGRlbmllZCBlbnRyeSBieSBQTUMgb25seSBiZWNhdXNlIG9mIGEgYmFk
IExBTiBMVFIsIHRoZW4gdGhhdCdzDQo+IHB1cmVseSBhbiBlMTAwMGUgZHJpdmVyL0dCRSBmdyBp
c3N1ZS4NCj4gDQpCZWNhdXNlIHRoZSB3b3JrYXJvdW5kIGlzIGluIHBtYyBkcml2ZXIsIHRoZSBw
bGF0Zm9ybSBiZWhhdmlvciBiZWNvbWVzIHRpZWQNCnRvIHdoZXRoZXIgdGhpcyBkcml2ZXIgd2Fz
IGVuYWJsZWQuICBCZWZvcmUgdGhpcyB0aGUgZHJpdmVyIHdhcyBtb3N0bHkgZm9yIGRlYnVnZ2lu
Zw0KcHVycG9zZSBhbmQgcmVhbGx5IG5vdCBuZWNlc3NhcnkuICBOb3cgaXQgaGFzIGEgZnVuY3Rp
b25hbCBwdXJwb3NlLg0KDQpBcyBzdWNoIEkgdGhpbmsgaXQgc2hvdWxkIGJlIG1hZGUgYXBwYXJl
bnQgdGhhdCB5b3UgbmVlZCBpdCBub3cgZm9yIHNvbWUgc3lzdGVtcy4NCg0KPiA+DQo+ID4gSW4g
dGhpcyBjYXNlIGRvZXMgaXQgbWF5YmUgbWFrZSBzZW5zZSB0byBhdCBsZWFzdCB1c2UgImltcGx5
IiBpbiB0aGUgS2NvbmZpZw0KPiBmb3IgZTEwMDBlIHNvDQo+ID4gdGhhdCBzZWxlY3RpbmcgZTEw
MDBlIGdldHMgaW50ZWwtcG1jLWNvcmUgZW5hYmxlZCB0b28/DQo+IA0KPiBUaGlzIGNoYW5nZSB3
b3VsZCB0ZWxsIFBNQyB0byBpZ25vcmUgR0JFIExUUiwgcmVnYXJkbGVzcyBvZiB3aGljaCBHQkUN
Cj4gZHJpdmVyIGlzIHNlbGVjdGVkLiBUaGlzIGRvZXNuJ3QgYmluZCBlMTAwMGUuDQoNClllYWgs
IHRoYXQncyBhIGdvb2QgcG9pbnQuDQoNCk1heWJlIG15IHN1Z2dlc3Rpb24gY2FuIGJlIHRvIHRh
a2UgdGhpcyBpbnRvIGRvY3VtZW50YXRpb24gc29tZXdoZXJlIGluc3RlYWQuDQoNCj4gDQo+ID4N
Cj4gPiA+DQo+ID4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9wbGF0Zm9ybS94ODYvaW50ZWxfcG1j
X2NvcmUuYw0KPiA+ID4gYi9kcml2ZXJzL3BsYXRmb3JtL3g4Ni9pbnRlbF9wbWNfY29yZS5jDQo+
ID4gPiBpbmRleCBlZTJmNzU3NTE1YjAuLmFiMzFlYjY0NmExYSAxMDA2NDQNCj4gPiA+IC0tLSBh
L2RyaXZlcnMvcGxhdGZvcm0veDg2L2ludGVsX3BtY19jb3JlLmMNCj4gPiA+ICsrKyBiL2RyaXZl
cnMvcGxhdGZvcm0veDg2L2ludGVsX3BtY19jb3JlLmMNCj4gPiA+IEBAIC04NjMsMzQgKzg2Myw0
NSBAQCBzdGF0aWMgaW50IHBtY19jb3JlX3BsbF9zaG93KHN0cnVjdCBzZXFfZmlsZSAqcywNCj4g
dm9pZA0KPiA+ID4gKnVudXNlZCkNCj4gPiA+ICB9DQo+ID4gPiAgREVGSU5FX1NIT1dfQVRUUklC
VVRFKHBtY19jb3JlX3BsbCk7DQo+ID4gPg0KPiA+ID4gLXN0YXRpYyBzc2l6ZV90IHBtY19jb3Jl
X2x0cl9pZ25vcmVfd3JpdGUoc3RydWN0IGZpbGUgKmZpbGUsDQo+ID4gPiAtICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICBjb25zdCBjaGFyIF9fdXNlciAqdXNlcmJ1ZiwNCj4g
PiA+IC0gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHNpemVfdCBjb3VudCwg
bG9mZl90ICpwcG9zKQ0KPiA+ID4gK3N0YXRpYyBpbnQgcG1jX2NvcmVfd3JpdGVfbHRyX2lnbm9y
ZSh1MzIgdmFsdWUpDQo+ID4gPiAgew0KPiA+ID4gICAgICAgc3RydWN0IHBtY19kZXYgKnBtY2Rl
diA9ICZwbWM7DQo+ID4gPiAgICAgICBjb25zdCBzdHJ1Y3QgcG1jX3JlZ19tYXAgKm1hcCA9IHBt
Y2Rldi0+bWFwOw0KPiA+ID4gLSAgICAgdTMyIHZhbCwgYnVmX3NpemUsIGZkOw0KPiA+ID4gLSAg
ICAgaW50IGVycjsNCj4gPiA+IC0NCj4gPiA+IC0gICAgIGJ1Zl9zaXplID0gY291bnQgPCA2NCA/
IGNvdW50IDogNjQ7DQo+ID4gPiAtDQo+ID4gPiAtICAgICBlcnIgPSBrc3RydG91MzJfZnJvbV91
c2VyKHVzZXJidWYsIGJ1Zl9zaXplLCAxMCwgJnZhbCk7DQo+ID4gPiAtICAgICBpZiAoZXJyKQ0K
PiA+ID4gLSAgICAgICAgICAgICByZXR1cm4gZXJyOw0KPiA+ID4gKyAgICAgdTMyIGZkOw0KPiA+
ID4gKyAgICAgaW50IGVyciA9IDA7DQo+ID4gPg0KPiA+ID4gICAgICAgbXV0ZXhfbG9jaygmcG1j
ZGV2LT5sb2NrKTsNCj4gPiA+DQo+ID4gPiAtICAgICBpZiAodmFsID4gbWFwLT5sdHJfaWdub3Jl
X21heCkgew0KPiA+ID4gKyAgICAgaWYgKGZscyh2YWx1ZSkgPiBtYXAtPmx0cl9pZ25vcmVfbWF4
KSB7DQo+ID4gPiAgICAgICAgICAgICAgIGVyciA9IC1FSU5WQUw7DQo+ID4gPiAgICAgICAgICAg
ICAgIGdvdG8gb3V0X3VubG9jazsNCj4gPiA+ICAgICAgIH0NCj4gPiA+DQo+ID4gPiAgICAgICBm
ZCA9IHBtY19jb3JlX3JlZ19yZWFkKHBtY2RldiwgbWFwLT5sdHJfaWdub3JlX29mZnNldCk7DQo+
ID4gPiAtICAgICBmZCB8PSAoMVUgPDwgdmFsKTsNCj4gPiA+ICsgICAgIGZkIHw9IHZhbHVlOw0K
PiA+ID4gICAgICAgcG1jX2NvcmVfcmVnX3dyaXRlKHBtY2RldiwgbWFwLT5sdHJfaWdub3JlX29m
ZnNldCwgZmQpOw0KPiA+ID4NCj4gPiA+ICBvdXRfdW5sb2NrOg0KPiA+ID4gICAgICAgbXV0ZXhf
dW5sb2NrKCZwbWNkZXYtPmxvY2spOw0KPiA+ID4gKw0KPiA+ID4gKyAgICAgcmV0dXJuIGVycjsN
Cj4gPiA+ICt9DQo+ID4gPiArDQo+ID4gPiArc3RhdGljIHNzaXplX3QgcG1jX2NvcmVfbHRyX2ln
bm9yZV93cml0ZShzdHJ1Y3QgZmlsZSAqZmlsZSwNCj4gPiA+ICsgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgIGNvbnN0IGNoYXIgX191c2VyICp1c2VyYnVmLA0KPiA+ID4gKyAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgc2l6ZV90IGNvdW50LCBsb2ZmX3Qg
KnBwb3MpDQo+ID4gPiArew0KPiA+ID4gKyAgICAgdTMyIGJ1Zl9zaXplLCB2YWw7DQo+ID4gPiAr
ICAgICBpbnQgZXJyOw0KPiA+ID4gKw0KPiA+ID4gKyAgICAgYnVmX3NpemUgPSBjb3VudCA8IDY0
ID8gY291bnQgOiA2NDsNCj4gPiA+ICsNCj4gPiA+ICsgICAgIGVyciA9IGtzdHJ0b3UzMl9mcm9t
X3VzZXIodXNlcmJ1ZiwgYnVmX3NpemUsIDEwLCAmdmFsKTsNCj4gPiA+ICsgICAgIGlmIChlcnIp
DQo+ID4gPiArICAgICAgICAgICAgIHJldHVybiBlcnI7DQo+ID4gPiArDQo+ID4gPiArICAgICBl
cnIgPSBwbWNfY29yZV93cml0ZV9sdHJfaWdub3JlKDFVIDw8IHZhbCk7DQo+ID4gPiArDQo+ID4g
PiAgICAgICByZXR1cm4gZXJyID09IDAgPyBjb3VudCA6IGVycjsNCj4gPiA+ICB9DQo+ID4gPg0K
PiA+ID4gQEAgLTExODksNiArMTIwMCwxNSBAQCBzdGF0aWMgaW50IHF1aXJrX3h0YWxfaWdub3Jl
KGNvbnN0IHN0cnVjdA0KPiBkbWlfc3lzdGVtX2lkDQo+ID4gPiAqaWQpDQo+ID4gPiAgICAgICBy
ZXR1cm4gMDsNCj4gPiA+ICB9DQo+ID4gPg0KPiA+ID4gK3N0YXRpYyBpbnQgcXVpcmtfbHRyX2ln
bm9yZSh1MzIgdmFsKQ0KPiA+ID4gK3sNCj4gPiA+ICsgICAgIGludCBlcnI7DQo+ID4gPiArDQo+
ID4gPiArICAgICBlcnIgPSBwbWNfY29yZV93cml0ZV9sdHJfaWdub3JlKHZhbCk7DQo+ID4gPiAr
DQo+ID4gPiArICAgICByZXR1cm4gZXJyOw0KPiA+ID4gK30NCj4gPiA+ICsNCj4gPiA+ICBzdGF0
aWMgY29uc3Qgc3RydWN0IGRtaV9zeXN0ZW1faWQgcG1jX2NvcmVfZG1pX3RhYmxlW10gID0gew0K
PiA+ID4gICAgICAgew0KPiA+ID4gICAgICAgLmNhbGxiYWNrID0gcXVpcmtfeHRhbF9pZ25vcmUs
DQo+ID4gPiBAQCAtMTI0NCw2ICsxMjY0LDE1IEBAIHN0YXRpYyBpbnQgcG1jX2NvcmVfcHJvYmUo
c3RydWN0IHBsYXRmb3JtX2RldmljZQ0KPiAqcGRldikNCj4gPiA+ICAgICAgIHBtY2Rldi0+cG1j
X3hyYW1fcmVhZF9iaXQgPSBwbWNfY29yZV9jaGVja19yZWFkX2xvY2tfYml0KCk7DQo+ID4gPiAg
ICAgICBkbWlfY2hlY2tfc3lzdGVtKHBtY19jb3JlX2RtaV90YWJsZSk7DQo+ID4gPg0KPiA+ID4g
KyAgICAgLyoNCj4gPiA+ICsgICAgICAqIE9uIFRHTCwgZHVlIHRvIGEgaGFyZHdhcmUgbGltaXRh
dGlvbiwgdGhlIEdCRSBMVFIgYmxvY2tzIFBDMTANCj4gd2hlbg0KPiA+ID4gKyAgICAgICogYSBj
YWJsZSBpcyBhdHRhY2hlZC4gVGVsbCB0aGUgUE1DIHRvIGlnbm9yZSBpdC4NCj4gPiA+ICsgICAg
ICAqLw0KPiA+ID4gKyAgICAgaWYgKHBtY2Rldi0+bWFwID09ICZ0Z2xfcmVnX21hcCkgew0KPiA+
ID4gKyAgICAgICAgICAgICBkZXZfZGJnKCZwZGV2LT5kZXYsICJpZ25vcmluZyBHQkUgTFRSXG4i
KTsNCj4gPiA+ICsgICAgICAgICAgICAgcXVpcmtfbHRyX2lnbm9yZSgxVSA8PCAzKTsNCj4gPiA+
ICsgICAgIH0NCj4gPiA+ICsNCj4gPiA+ICAgICAgIHBtY19jb3JlX2RiZ2ZzX3JlZ2lzdGVyKHBt
Y2Rldik7DQo+ID4gPg0KPiA+ID4gICAgICAgZGV2aWNlX2luaXRpYWxpemVkID0gdHJ1ZTsNCj4g
PiA+IC0tDQo+ID4gPiAyLjI1LjENCj4gPg0KPiANCj4gDQo+IC0tDQo+IFRoYW5rcywNCj4gUmFq
bmVlc2gNCg==
