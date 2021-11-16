Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DDF2245348E
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Nov 2021 15:44:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237771AbhKPOrB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Nov 2021 09:47:01 -0500
Received: from mx0a-0064b401.pphosted.com ([205.220.166.238]:12404 "EHLO
        mx0a-0064b401.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237528AbhKPOqe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Nov 2021 09:46:34 -0500
Received: from pps.filterd (m0250809.ppops.net [127.0.0.1])
        by mx0a-0064b401.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 1AGDTg90015883;
        Tue, 16 Nov 2021 06:43:28 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=PPS06212021;
 bh=x4dTkhl07kgUGJatqpIMvID8md28D8THWc6hj2x8880=;
 b=B9TOr46ZuIqGEVUiJ4vHZLx13FFKoiqdtN4+r5W+c24n6tqGvQCN/N4es/WPEbaOxKHC
 m/SB27eqzI8rctJQtbbxkPLXDvTJMVcsiMcVBdbWuRqd4FsS1s4wXTrcEJ6CBpmJeoep
 Cj2zj6YwRTfUqmPgUhZD/C1TmF+1GEkeSHm/Ykh2dahXQwkXHCFnANTDNZbqmGPGGR56
 t7qLIsWJV6lEcoQrm53iZa16UeVulwnNvNdpo/sMDIYm74d1+msNC7AIMsJu1EtMYobi
 AbjQKi9hRpXOr0g8kbF9OAvLiHZR+/DKckHCsQpCW1ZgvBths+dmt1yQF+AZyVeQgrIb /A== 
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2103.outbound.protection.outlook.com [104.47.58.103])
        by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 3cbqrus3n1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 16 Nov 2021 06:43:28 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Q6Ks8F/p78OnK/5DH3TlnLZ1WcLka0Lfdn52zmfSXw1VZnnbfPtq2uzrcAL+4NCqUVhsx7MO5tyjWoTziVwvgyaFscuOnF/Q5tnlFPj4MvVmVib7VyiZdo6atSaCRgoz/5eDDQjtayAA1mlTiOp2WJfFv3KvdZTCaHrqFiRSHuutFF2IU/eUW+Aq8oVsnd7+s+yEGGISM3uTk6oBovTlAWKBOWCkW2u91aOcGkrLqRAQRDH0QLvFs4h2u7XP48pZx8ihNvMKEMh1cXLJRJQhr/E46sOGYQkFCi3Lo8oE3iX7YAnf7wI/Tz5j7LJf9AdkAgG9/6e1sQtWdcU1iIxYLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=x4dTkhl07kgUGJatqpIMvID8md28D8THWc6hj2x8880=;
 b=hD5GX3EXbVAQvqbRuOtsLfThfsmTxJ7WHNvIMVhy741pmjbkO3JWD9+RV5wvRbA32u/dcEeDucFtqSIuDLv1jCp+rGh+/853NUDMGIhZuzUoVoA1lKn32Qr8N7PFswH+xE2Dn9zEhufFK1Hux23ts0fKhznUafpH863A1dvr5nOKjdfQC2XifrTHmEefkg4hEsA5O02lAEySI3A1bWgQmNXI/jppZ0kK1Qge7+HyW4xNYk6qSA98pt1wImU7qrFG4lJwMetqldpwQn5A966bp1jZDp5pgtidnt8g6ZIqhKsulFV+AHiDIstt6v5or97JhxURJppuqF7Blibk1QvP1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from PH0PR11MB5191.namprd11.prod.outlook.com (2603:10b6:510:3e::24)
 by PH7PR11MB5818.namprd11.prod.outlook.com (2603:10b6:510:132::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4690.16; Tue, 16 Nov
 2021 14:43:25 +0000
Received: from PH0PR11MB5191.namprd11.prod.outlook.com
 ([fe80::a090:40db:80ae:f06a]) by PH0PR11MB5191.namprd11.prod.outlook.com
 ([fe80::a090:40db:80ae:f06a%9]) with mapi id 15.20.4690.027; Tue, 16 Nov 2021
 14:43:25 +0000
From:   "Li, Meng" <Meng.Li@windriver.com>
To:     Arnd Bergmann <arnd@arndb.de>
CC:     "thor.thayer@linux.intel.com" <thor.thayer@linux.intel.com>,
        Lee Jones <lee.jones@linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] mfd: altera-sysmgr: enable raw spinlock feature for
 preempt-rt kernel
Thread-Topic: [PATCH] mfd: altera-sysmgr: enable raw spinlock feature for
 preempt-rt kernel
Thread-Index: AQHX2th3swEitpfWC0aos9Q3CXq7i6wGDekAgAAjI2A=
Date:   Tue, 16 Nov 2021 14:43:25 +0000
Message-ID: <PH0PR11MB5191FEE6D75B558D629D517AF1999@PH0PR11MB5191.namprd11.prod.outlook.com>
References: <20211116105424.12685-1-Meng.Li@windriver.com>
 <CAK8P3a241g2vQrfiEf_YcQ0=t5fhN0R0CrzQE5DK7XQgAGxKYg@mail.gmail.com>
In-Reply-To: <CAK8P3a241g2vQrfiEf_YcQ0=t5fhN0R0CrzQE5DK7XQgAGxKYg@mail.gmail.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: fdbe0384-39e9-4cce-2283-08d9a90f7252
x-ms-traffictypediagnostic: PH7PR11MB5818:
x-microsoft-antispam-prvs: <PH7PR11MB581846C77C067DE5B9191333F1999@PH7PR11MB5818.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: KFpqUdFjL7UPe+7b4EYqLJREMI7IU4Yo5SkAfCKhwz+AkFVjM4tDr522eHwmXUe0GFC0FNadfSYx2VcDLbwjOd0ZnoWSg0HXsD2gb7NSQinCFyfYhKlnKb4fCmOPsP1LfSk8B/lwPKnPSQMP7f0x9vFLkYH2PKZ3pg27hpXsr7iAsBDa9AC8sbNNCTsWDJqB1AkU0Z09GJANk8XTj6jxkvvW5FmzyBn7WTI4ST1Z0b3uykR8TNSKL6OiHgz/xdeWuNNAGxjccI3Xvi+yLRAjna4D5U3kjxvLjbyBtoiWkWxjg+eA4Q7bZ8wcMQfxxeU2d2YtQvcRu2AnWNNXxlh7dzEgkyiG1k2Dsqyc/leX65vwXS2fgWum7QCYB4CnRlnZVxaIGkcX7RGFGNUO0l7wxr72p3W5/0kugrr+VFdhKoXjN7itfQiiwQ/B8r1epKeLlPW2NnQG8x0v9W5SaswvmiG9IwI4OTJrdhCRMnp5uSW58XAtNvoF1dmOjLL7wW3xpGy+liZjncSDO4t529Sk/5QC4vK8Bm2q2JtHXVdTBw70l38pdJiWesHomV3fFCod4okTdDCIY7Jh8uxqXla/B01NU8PJVz8NaVHxq+pOXwcbQIk1DhmWh5RcZwHukr8L6ffPDFt+g2qCbx65CG2TQwgD8c0WB4XmBMYPZV2o+t7RNq7QKirtRGoe+HNFTVR/AnrFtXO/jlseQLSpvEknzw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5191.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(26005)(6506007)(8676002)(508600001)(8936002)(54906003)(2906002)(186003)(316002)(53546011)(9686003)(55016002)(52536014)(71200400001)(6916009)(4326008)(5660300002)(86362001)(66476007)(38070700005)(76116006)(33656002)(83380400001)(7696005)(66946007)(66446008)(64756008)(66556008)(122000001)(38100700002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RHZ3b3FrRUcxNXNCZGJDbnd1WlRqOHl3MEhtQXE3T1lUMWNFZExSQ3pPdElq?=
 =?utf-8?B?UXRLeGZnL0JPamR3Z0JzdmhFT05ha2VOMEZVeXQvdVl3N0Yvb2V6Q0srVEJO?=
 =?utf-8?B?NzduQ2c2YWZTV01ucWxqSG5EcmN4cktxTHhrbHI2cTVja0Q2eGs1Uk9jbk9p?=
 =?utf-8?B?clZuUUUwZnZjYjczbWxFRC8xaXo1V0dEbTFvLzgzcnczRmsyc1ZabjZEbnVC?=
 =?utf-8?B?aGh4S05NQWNRWVh5ZmV6ZUZUbnpGNjAxVEppMndQMlNUTXN2Yk9HYUl4L1BT?=
 =?utf-8?B?bFFtM3FmNjFZdGdrV2E5bXRYS2JJOVl2cWMzdEs2U0pBRzRHYnlmU3VicWVm?=
 =?utf-8?B?d3pTY2cvUC82aERzSkx0Qmx6NDhBNzBwSVlLNkdGbjNMT2FKK1NWWFhPTEYv?=
 =?utf-8?B?UDY5dzJiTk1NTi8rbmI1ZDQwNzljVDZuRzcxd09RTFY3dEtRZjBGOC9NdUYr?=
 =?utf-8?B?WVBiSkYwMXhycDBuTXBvb0ZWMjlqa2JxTlgxa3F2UDI5MXZhcUl0M1JVNzF2?=
 =?utf-8?B?WHphaUlIb2tZSzA5aE0yazdYRW5jcTY5eEFkNlZOZndBZDlFUFJBQ3NsS2lj?=
 =?utf-8?B?Z0RiNnJnenRmOEg1N29IdTJzZnNVUUJDM3VFUWVMWkZXZTJWRDl6TFhkcm1k?=
 =?utf-8?B?VnFqTXIrNVZxcXdJU25xR0pBcStDZ29saDZDbTlPOWVQSng5R3k4S2E2Vlh5?=
 =?utf-8?B?NUJVRHFUdjRRa2NyNWpHamtoV1ZFK3hENWdXN2I3a0IzckZ1SVd1YlY0YVp1?=
 =?utf-8?B?MGFHVEZxanMySmowT2JBNlJ0aVN5aFlPOWpQMnM1MlphY0t0c0NhdVFOcEZp?=
 =?utf-8?B?TXhSRTB1REdHYkNkWHJWWEdtVTl3aFRtRVpFazJYVThhZFBuNHhoVmZlQlF3?=
 =?utf-8?B?VXI2ZWFjVDNkdWUxNDR5eC95VUFiaEE1c3NMdHlHOFpkTDNJR3lxMkk4STEw?=
 =?utf-8?B?SktYeG5RakpPdjl2S3VZa1htaHJBa1FySFlGUTZXaUU5amI0aEhRU1ZONU1W?=
 =?utf-8?B?NCt3TTBncVU1N2xaL0dPYU9ORlNQOTlTYXRPN3JBWFJUYnlLK0wrd3IxZ2Rp?=
 =?utf-8?B?OWFab3lQZnBhM1FXNXBlTlhYMk9qeEVmekp6RFpnQzJwcndpQk03OEJpaG9K?=
 =?utf-8?B?dUVLZytwL3E2TXAvQm85YW0zNmNZS0JtOUs3NC90bEJzS2JtaGI2bDNDdnBN?=
 =?utf-8?B?Tk1YYTFvY1pXN3Z4R2xvTk55TkszeUc2bkxaTGZrdmtYbWs0enErUVg5RjYy?=
 =?utf-8?B?dVRpS1pYSXNFdE9ESGp3TEtOT2VBMlA5TzV3bTltQnJBd1ZIQXJJVGJMSDVv?=
 =?utf-8?B?M24rZEl6NXN5WU5vMWs4T2RDNm55cmc4MXBZaU84NUVHNXJMeFpmeHo2M1VJ?=
 =?utf-8?B?SWxFQ3lTTGdhUjBuWlphV3NvdGVnamVGMVNUbXVOVW5abUVGaFR3LzFCUjZJ?=
 =?utf-8?B?NXJhelhCUUtzVnA1ajd3alpjTE1vRkZvNzh3Tk03bTB4TjdDYUhvVEhNeXlS?=
 =?utf-8?B?SDRiL1RhK3NETnlRS2xvMExIREVYNlpnK3V0YkVkMU96STlMaDQzMUFXY3BU?=
 =?utf-8?B?aFZrZllvaEpBZ0dzSW00ZWN4L0RvcjRrNHhlaDVwcUNZcVh4cVQxSE4wYlNH?=
 =?utf-8?B?cjJmdkZzZTN5Ykt1Wk5jV2VKQmpjSkxZdXg5bHJUd01pdUxNZmRuTlhKRVV4?=
 =?utf-8?B?U0FvRForMTNNT1dvV29qckFoSlYzbi9EMCtiNUVuOWV5MFBxLyt3Wk1UVXla?=
 =?utf-8?B?V2tqamZRODJFL2FjL1ZmZmY2RVh5V1hNeUVsUFIxaFJUWmZyZjgrcmZlZkw5?=
 =?utf-8?B?dU11K1lxbnpKVEdVZ1BkY0lNTDNqa2k0NWF0Snk5RGUrazlERUMrOEw1SU1z?=
 =?utf-8?B?Nm1XV2E4aFRhLzhxajVSU29UUUFpZ1JQb2RaSGFRbWhzajZEUG9TMzY4bGgw?=
 =?utf-8?B?dGFNNHM2dzRjM2RjOW1CNVBXSnBCSlY2c3B2MFBiaW9MRnl0djVRSktFSzNK?=
 =?utf-8?B?NkY1UHpIVHF0WjJCcEpQME9LV3l2V2JwT1pPUFpBemFScTdEK2hrcEg2Mk1q?=
 =?utf-8?B?aGtlRENWWEVjcEpSM0Ztc05pdXpoUVFPUk1FR2dVblExbXIyUXZhcmxsd1Iv?=
 =?utf-8?B?emgvNy9FeU5HZmFPSWdLNGhTOHdndjJIZVJEK2Zxc3pBejJCZmRTWW8wekUv?=
 =?utf-8?B?d1E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5191.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fdbe0384-39e9-4cce-2283-08d9a90f7252
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Nov 2021 14:43:25.5860
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Bb3tc/jdjdhMtCfXoSlE8cnOWrPHlYxUCQFrhu6kE1BRuMXIzrF5U+dLWPd0UK1HzmnZoUsQgv0L0aocEFss7Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB5818
X-Proofpoint-ORIG-GUID: CVdylG1BeZqKjSGnlsjm0407Bd02vwD3
X-Proofpoint-GUID: CVdylG1BeZqKjSGnlsjm0407Bd02vwD3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-11-16_02,2021-11-16_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 malwarescore=0 clxscore=1015 adultscore=0 mlxlogscore=999 mlxscore=0
 suspectscore=0 priorityscore=1501 spamscore=0 phishscore=0
 lowpriorityscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2110150000 definitions=main-2111160072
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogQXJuZCBCZXJnbWFubiA8
YXJuZEBhcm5kYi5kZT4NCj4gU2VudDogVHVlc2RheSwgTm92ZW1iZXIgMTYsIDIwMjEgODowMiBQ
TQ0KPiBUbzogTGksIE1lbmcgPE1lbmcuTGlAd2luZHJpdmVyLmNvbT4NCj4gQ2M6IHRob3IudGhh
eWVyQGxpbnV4LmludGVsLmNvbTsgTGVlIEpvbmVzIDxsZWUuam9uZXNAbGluYXJvLm9yZz47IEFy
bmQNCj4gQmVyZ21hbm4gPGFybmRAYXJuZGIuZGU+OyBMaW51eCBLZXJuZWwgTWFpbGluZyBMaXN0
IDxsaW51eC0NCj4ga2VybmVsQHZnZXIua2VybmVsLm9yZz4NCj4gU3ViamVjdDogUmU6IFtQQVRD
SF0gbWZkOiBhbHRlcmEtc3lzbWdyOiBlbmFibGUgcmF3IHNwaW5sb2NrIGZlYXR1cmUgZm9yDQo+
IHByZWVtcHQtcnQga2VybmVsDQo+IA0KPiBbUGxlYXNlIG5vdGU6IFRoaXMgZS1tYWlsIGlzIGZy
b20gYW4gRVhURVJOQUwgZS1tYWlsIGFkZHJlc3NdDQo+IA0KPiBPbiBUdWUsIE5vdiAxNiwgMjAy
MSBhdCAxMTo1NCBBTSBNZW5nIExpIDxNZW5nLkxpQHdpbmRyaXZlci5jb20+IHdyb3RlOg0KPiA+
IGRpZmYgLS1naXQgYS9kcml2ZXJzL21mZC9hbHRlcmEtc3lzbWdyLmMgYi9kcml2ZXJzL21mZC9h
bHRlcmEtc3lzbWdyLmMNCj4gPiBpbmRleCA1ZDM3MTVhMjhiMjguLjI3MjcxY2VjNWQ1MyAxMDA2
NDQNCj4gPiAtLS0gYS9kcml2ZXJzL21mZC9hbHRlcmEtc3lzbWdyLmMNCj4gPiArKysgYi9kcml2
ZXJzL21mZC9hbHRlcmEtc3lzbWdyLmMNCj4gPiBAQCAtODMsNiArODMsOSBAQCBzdGF0aWMgc3Ry
dWN0IHJlZ21hcF9jb25maWcgYWx0cl9zeXNtZ3JfcmVnbWFwX2NmZyA9DQo+IHsNCj4gPiAgICAg
ICAgIC5mYXN0X2lvID0gdHJ1ZSwNCj4gPiAgICAgICAgIC51c2Vfc2luZ2xlX3JlYWQgPSB0cnVl
LA0KPiA+ICAgICAgICAgLnVzZV9zaW5nbGVfd3JpdGUgPSB0cnVlLA0KPiA+ICsjaWZkZWYgQ09O
RklHX1BSRUVNUFRfUlQNCj4gPiArICAgICAgIC51c2VfcmF3X3NwaW5sb2NrID0gdHJ1ZSwNCj4g
PiArI2VuZGlmDQo+IA0KPiBJIHRoaW5rIHlvdSBzaG91bGQgcmVtb3ZlIHRoZSAjaWZkZWYgaGVy
ZTogaWYgUFJFRU1QVF9SVCBpcyBkaXNhYmxlZCwgdGhlDQo+IGZsYWcgaGFzIG5vIGVmZmVjdCBi
ZWNhdXNlIHNwaW5sb2NrIGJlaGF2ZXMgdGhlIHNhbWUgd2F5IGFzIHJhd19zcGlubG9jay4gSWYN
Cj4gYW55dGhpbmcgZWxzZSBzdGFydHMgcmVxdWlyaW5nIHRoZSB1c2Ugb2YgcmF3IHNwaW5sb2Nr
cywgdGhlbiB3ZSBwcm9iYWJseQ0KPiB3YW50IHRoZSBmbGFnIHRvIGJlIHNldCAgaGVyZSBhcyB3
ZWxsLg0KPiANCg0KVGhhbmtzIGZvciB5b3VyIHN1Z2dlc3Rpb24sIGFuZCBJIGFsc28gYWdyZWUg
d2l0aCB0aGUgc3BpbmxvY2sgYWN0aW9uIHdoZW4gUFJFRU1QVF9SVCBpcyBkaXNhYmxlZC4NCkJ1
dCBwbGVhc2UgYWxsb3cgbWUgdG8gZXhwbGFpbiB3aHkgSSBrZWVwIHRoZSAiaWZkZWYiDQoxLiBh
bHRob3VnaCBJIHNlbmQgdGhpcyBwYXRjaCB0byBtYWlubGluZSB1cHN0cmVhbSwgSSBvbmx5IHdh
bnQgdG8gZml4IHRoaXMgaXNzdWUgaW4gUlQga2VybmVsLg0KICAgIE1vcmVvdmVyLCB0aGUgY29t
bWl0IDY3MDIxZjI1ZDk1MigicmVnbWFwOiB0ZWFjaCByZWdtYXAgdG8gdXNlIHJhdyBzcGlubG9j
a3MgaWYgcmVxdWVzdGVkIGluIHRoZSBjb25maWcgIikgaXMgYWxzbyBmb3IgUlQga2VybmVsIGV2
ZW4gaWYgaXQgZG9lc24ndCB1c2UgImlmZGVmIENPTkZJR19QUkVFTVBUX1JUIiANCiAgICBNeSBp
ZGVhbCBpcyB0aGF0IGlmIHRoaXMgcGF0Y2ggaXMgbWVyZ2VkIGludG8gbWFpbmxpbmUsIExpbnV4
LXJ0IG1haW50YWluZXIgd2lsbCBub3Qgc3BlbmQgZXh0cmEgZWZmb3J0IHRvIGZvY3VzIG9uIHRo
aXMgcGF0Y2guIEFmdGVyIGFsbCwgdGhpcyBmaXhpbmcgaXMgbW9yZSByZWxhdGVkIHdpdGggZHJp
dmVyLg0KICAgIEluIGFkZGl0aW9uLCBJIGZvdW5kIG91dCB0aGVyZSBhcmUgb3RoZXIgcGF0Y2hl
cyB3aXRoICJpZmRlZiBDT05GSUdfUFJFRU1QVF9SVCIgbWVyZ2VkIGJ5IG1haW5saW5lLCBzbyBJ
IGFsc28gc2VuZCB0aGlzIHBhdGNoIHRvIG1haW5saW5lLCBub3QgTGludXgtcnQuDQoNCjIuIEkg
Y2hlY2sgcmVnbWFwLmMgY29kZSB0aGF0IGlzIHJlbGF0ZWQgd2l0aCB1c2VfcmF3X3NwaW5sb2Nr
LiBJZiBQUkVFTVBUX1JUIGlzIGRpc2FibGVkIGFuZCB1c2VfcmF3X3NwaW5sb2NrIGlzIHNldCBh
cyB0cnVlLCB0aGUgZWxzZSBjYXNlIHdpbGwgbm90IGJlIGVudGVyZWQgYW55IGxvbmdlci4NCiAg
ICBJbiBvdGhlciB3b3JkcywgaW4gbWFpbmxpbmUgc3RhbmRhcmQga2VybmVsLCBpZiB1c2VfcmF3
X3NwaW5sb2NrIGlzIHNldCBhcyB0cnVlLCByYXcgc3BpbmxvY2sgd2lsbCBiZSB1c2VkIGZvcmV2
ZXIsIGFuZCB0aGUgY29kZSBpbiBlbHNlIGNhc2Ugd2lsbCBiZWNvbWUgdXNlbGVzcy4NCiAgICBJ
IGZlZWwgaXQgaXMgYSBsaXR0bGUgdW5yZWFzb25hYmxlLiBTbywgSSBrZWVwIHRoZSAiaWZkZWYi
DQoJaWYgKChidXMgJiYgYnVzLT5mYXN0X2lvKSB8fA0KCQkgICAgY29uZmlnLT5mYXN0X2lvKSB7
DQoJCQlpZiAoY29uZmlnLT51c2VfcmF3X3NwaW5sb2NrKSB7DQoJCQkJcmF3X3NwaW5fbG9ja19p
bml0KCZtYXAtPnJhd19zcGlubG9jayk7DQoJCQkJbWFwLT5sb2NrID0gcmVnbWFwX2xvY2tfcmF3
X3NwaW5sb2NrOw0KCQkJCW1hcC0+dW5sb2NrID0gcmVnbWFwX3VubG9ja19yYXdfc3BpbmxvY2s7
DQoJCQkJbG9ja2RlcF9zZXRfY2xhc3NfYW5kX25hbWUoJm1hcC0+cmF3X3NwaW5sb2NrLA0KCQkJ
CQkJCSAgIGxvY2tfa2V5LCBsb2NrX25hbWUpOw0KCQkJfSBlbHNlIHsNCgkJCQlzcGluX2xvY2tf
aW5pdCgmbWFwLT5zcGlubG9jayk7DQoJCQkJbWFwLT5sb2NrID0gcmVnbWFwX2xvY2tfc3Bpbmxv
Y2s7DQoJCQkJbWFwLT51bmxvY2sgPSByZWdtYXBfdW5sb2NrX3NwaW5sb2NrOw0KCQkJCWxvY2tk
ZXBfc2V0X2NsYXNzX2FuZF9uYW1lKCZtYXAtPnNwaW5sb2NrLA0KCQkJCQkJCSAgIGxvY2tfa2V5
LCBsb2NrX25hbWUpOw0KCQkJfQ0KCQl9IGVsc2Ugew0KCQkJbXV0ZXhfaW5pdCgmbWFwLT5tdXRl
eCk7DQoJCQltYXAtPmxvY2sgPSByZWdtYXBfbG9ja19tdXRleDsNCgkJCW1hcC0+dW5sb2NrID0g
cmVnbWFwX3VubG9ja19tdXRleDsNCgkJCW1hcC0+Y2FuX3NsZWVwID0gdHJ1ZTsNCgkJCWxvY2tk
ZXBfc2V0X2NsYXNzX2FuZF9uYW1lKCZtYXAtPm11dGV4LA0KCQkJCQkJICAgbG9ja19rZXksIGxv
Y2tfbmFtZSk7DQoJCX0NCg0KVGhhbmtzLA0KTGltZW5nDQoNCj4gICAgICAgIEFybmQNCg==
