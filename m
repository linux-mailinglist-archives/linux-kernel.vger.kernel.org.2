Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3338C33202D
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Mar 2021 09:03:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229764AbhCIIDN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Mar 2021 03:03:13 -0500
Received: from mx0a-0014ca01.pphosted.com ([208.84.65.235]:63884 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229720AbhCIICu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Mar 2021 03:02:50 -0500
Received: from pps.filterd (m0042385.ppops.net [127.0.0.1])
        by mx0a-0014ca01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 1297vhVi031968;
        Tue, 9 Mar 2021 00:02:36 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=proofpoint;
 bh=mGencwVBE0FWcdBigcPNK9XMDtRoBNTvOOCssYUURG4=;
 b=kqvKqSCtGSstjjnvEwurTMqlKs6IsHIiNAVhC3jJx0N7C+W0G3xROBa0xcXEryDCGrlB
 gHU4jrJXkdoofXPbB9Li3S/FWwLuxCJXK4uDPWsUibBnQIAx0ulvUCO3EVCb2mJSNT1Y
 URNpzRXTHRF51QhGwv37+MhnSdBKbCo9oYDbSFk0VrrYKI/GP2frT+l98N11MmZZEAzf
 KYmggSyd2zXNt3hjpX4VEbhcrRmCjzvdAV3AOMgpPKYl8/tdbKNCImJG6LRToGh4/lAt
 LFN7aNLp7aQLw5g6/MvGhm6qjtdyOn5DgU9r60C5GEXs8ONHhOoHf1EeCv5kf43upoq5 pA== 
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2173.outbound.protection.outlook.com [104.47.56.173])
        by mx0a-0014ca01.pphosted.com with ESMTP id 374762yry2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 09 Mar 2021 00:02:35 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GlZIx+rCUv6gd0G7S9E/Gnzq4U8bdwqva18KRdT0aIX5OACBqDobIdbbIQn8awHphi11TGdPhK4SJKdjfLKf5vkXwBowm7uNi+qZT//gCx47yh4ldrtRWVaJ8zatgHvr6+5Uvto+KMGBTjfDbDL1wY4yRiE/e8Mq9anNcU4OsPoe+rbX9Lfr50BLqASBVgR1Zo7/GH5oca+xzDiI9XB4bYTVT+TILMVMxYjO2pHS1zmKi5uYzr5uaVyEgY1wpOhlvCP0Uqd2XXOHMovIKEIOOqKA3cejEUMKpEXSiUZYxnU6fOQGWKk3+hlm8OAi1gn908BbcR1XLm+JvO0+OxAoXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mGencwVBE0FWcdBigcPNK9XMDtRoBNTvOOCssYUURG4=;
 b=cogTV6Hi3wp2zcVptuZCSYlRo37xSC7+5YABRnttqSpz2y75uKU37tbfe3uOsBNKNrG2RTQe7NEmBosbdlurpg+nnS07pCjEtwYozE0H0Y5ZItjvTZDClsJo3/VvSJcmsn1FoSqol6BWUzEYtIWtwa/wvs3JR/wC6YB6bF8RrUTWbin2TS8sQWcT5iiKJKpC5PRNOjHEXyQMI5sIxW43IVt7McJBpoj++fpXhw6Ra8cpLLDbM1Qh+TckVnHWZaMORw9u7XYch0evjbZRqGMgbk6+TxsDDoAODTYkpFP/a1aLchG6xUIvd4pv8eFXm4jf9frw3LVxHD62DKTFN49BJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cadence.com; dmarc=pass action=none header.from=cadence.com;
 dkim=pass header.d=cadence.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mGencwVBE0FWcdBigcPNK9XMDtRoBNTvOOCssYUURG4=;
 b=t9kMftgGIkQaFa5wZ0UqbeBYeBaphxpXcS57MRrdkhUI2S6ZAuV8aN9foMhZDka1l8otEMxObuEBJQbRTDSizjIbU9ZFgPfwmX18/1rvYzDNsdUNR7gE75b43DLhYgildUUu3H8t8GXxmm59wbIeHJNBflvbHQirjXclwMuy8OM=
Received: from DM5PR07MB3196.namprd07.prod.outlook.com (2603:10b6:3:e4::16) by
 DM6PR07MB6890.namprd07.prod.outlook.com (2603:10b6:5:1e3::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3912.17; Tue, 9 Mar 2021 08:02:33 +0000
Received: from DM5PR07MB3196.namprd07.prod.outlook.com
 ([fe80::3160:6a62:6e4d:2226]) by DM5PR07MB3196.namprd07.prod.outlook.com
 ([fe80::3160:6a62:6e4d:2226%5]) with mapi id 15.20.3912.027; Tue, 9 Mar 2021
 08:02:32 +0000
From:   Parshuram Raju Thombare <pthombar@cadence.com>
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>
CC:     "robert.foss@linaro.org" <robert.foss@linaro.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "airlied@linux.ie" <airlied@linux.ie>,
        "daniel@ffwll.ch" <daniel@ffwll.ch>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "a.hajda@samsung.com" <a.hajda@samsung.com>,
        "narmstrong@baylibre.com" <narmstrong@baylibre.com>,
        "nikhil.nd@ti.com" <nikhil.nd@ti.com>,
        "kishon@ti.com" <kishon@ti.com>,
        Swapnil Kashinath Jakhade <sjakhade@cadence.com>,
        Milind Parab <mparab@cadence.com>
Subject: RE: [PATCH v2 1/2] dt-bindings: drm/bridge: MHDP8546 bridge binding
 changes for HDCP
Thread-Topic: [PATCH v2 1/2] dt-bindings: drm/bridge: MHDP8546 bridge binding
 changes for HDCP
Thread-Index: AQHXDo0sCc9s3aGgTUeo76y9eToCYapvRZgAgAAHa+CAAAWAAIABVXGggAnyKoCAALiYUA==
Date:   Tue, 9 Mar 2021 08:02:32 +0000
Message-ID: <DM5PR07MB3196C4564D51182A8068DD81C1929@DM5PR07MB3196.namprd07.prod.outlook.com>
References: <1614597685-4192-1-git-send-email-pthombar@cadence.com>
 <1614597746-4563-1-git-send-email-pthombar@cadence.com>
 <YD0LKg3Jl5nauMqF@pendragon.ideasonboard.com>
 <DM5PR07MB319661E8BFEB251CE17AF587C19A9@DM5PR07MB3196.namprd07.prod.outlook.com>
 <YD0WAMySrv53lxFR@pendragon.ideasonboard.com>
 <DM5PR07MB319628C858F667D9E5058904C1999@DM5PR07MB3196.namprd07.prod.outlook.com>
 <YEaMTbJ7Wx7otX2k@pendragon.ideasonboard.com>
In-Reply-To: <YEaMTbJ7Wx7otX2k@pendragon.ideasonboard.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNccHRob21iYXJcYXBwZGF0YVxyb2FtaW5nXDA5ZDg0OWI2LTMyZDMtNGE0MC04NWVlLTZiODRiYTI5ZTM1Ylxtc2dzXG1zZy1jOTk0Y2UxZi04MGFkLTExZWItODYyZC0wMGUwNGIzNmI1YjFcYW1lLXRlc3RcYzk5NGNlMjAtODBhZC0xMWViLTg2MmQtMDBlMDRiMzZiNWIxYm9keS50eHQiIHN6PSIxNzc3IiB0PSIxMzI1OTc1MDU0NzY0OTAwMjUiIGg9InE1elpHMHMwN1hGc3NMdWZ0NDF2Sk5rMEtCcz0iIGlkPSIiIGJsPSIwIiBibz0iMSIvPjwvbWV0YT4=
x-dg-rorf: true
authentication-results: ideasonboard.com; dkim=none (message not signed)
 header.d=none;ideasonboard.com; dmarc=none action=none
 header.from=cadence.com;
x-originating-ip: [59.145.174.78]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: accbd880-41ec-4221-2956-08d8e2d1b1a0
x-ms-traffictypediagnostic: DM6PR07MB6890:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR07MB6890A31843CF2827E1FEA1CDC1929@DM6PR07MB6890.namprd07.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: lWS3Z/KY1e9GQJPaEv9A8U6d4OY6Bx0yjjRJ7Z2PEDS51a6vRhP42FP6ccQYeg1wJ6LjGLjEtMgZEj2lQHEed9khOt80CO22FiH/uD2N4g1CvPFZzD+U1Y2laNTVNCTVTamMkSKBmAmZlyPH+VNHbEFQwgsiLICCzp1zKZ5ZJ2nj7OYmjT+UQWeCbDA53QWoXNo91NEmtar1x0rgeTfDs5GnSdqofoJI/VrOQOjE/oHuY3nRnmRLQwlaYX2MQfjFYMhRgRE7SscOg1u03RVdEWhBVD8PIDSv2GbTCeh19UTcS3axRAXeOPV+S+CRDqaeBjBcZuGPfYaeCrvFz0kncLmWO0ZaB9EDLwxWop3DYhRVTNvLV8aY0ttlGLmPtDmD/pOroXoQefMOUXiHRUBX5knafvrq5Lpox4MCxaD7hJ4xa/D5XgU45d4gtGg2lqcTy7GM8w9GHNdGpJDY6R/8yV3og5X/r/0dza0px+ol7zfPNbVlzrZ+mDwRA6abIKkCINq2iWKukd9okVumBuNMpx+luvQIqjf85Mv7gjl7Wv2xJpxzVqVky+yNlsc4h4wJ
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR07MB3196.namprd07.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(346002)(396003)(366004)(376002)(39860400002)(36092001)(26005)(7416002)(9686003)(66556008)(66476007)(8936002)(64756008)(52536014)(54906003)(71200400001)(33656002)(66446008)(4326008)(66946007)(8676002)(107886003)(5660300002)(478600001)(6506007)(55016002)(76116006)(7696005)(6916009)(86362001)(316002)(2906002)(186003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?utf-8?B?UnpUajhGMGZ4aVpHR0xKRWFCeG9yNmptbW0xc2swTUkwaUg0TzU5dzc2V21l?=
 =?utf-8?B?UjJxSkJ3ZzhWOTNMYmdwMkwyQzdyWXk3QnRYdno4aysyUmdVMTA0ek1ZbHI1?=
 =?utf-8?B?MDRBOEduUTArWm5sb05wWmUrWDJxWGNuZHdvaXBiTlZSNGcwd3N5VWQ1VzRZ?=
 =?utf-8?B?SlhNNElrN3BSendtblhlSS84eENYMFRtaGxEZTFYSGVCUkliVGpjZjdFQlZk?=
 =?utf-8?B?d2RhREJBNE9sOVZhYUJIUFdPaXh2VUlIbW9Wd1NpS3ZSZEU1aDVybnVtS3h5?=
 =?utf-8?B?RFVjbW9tWFl2cUtNNUdDb0htOFd0VVZYUGZzUTcxYnJhSmQ2eCs3UW1jRDJ2?=
 =?utf-8?B?dm9IRFFSRFJvc3FPVHBjTVBVS0h1Zi8vTFFZU25uUDVGeXdLbkduamVsVit4?=
 =?utf-8?B?ZE02OWIzTGwxZjNiemU1emRld3dmbzEzMmZ0bHpTeXZ0YUxiNU4rNklwT1Av?=
 =?utf-8?B?UjJoMlBTQWxXdkd3ZkpCVTFvWjdaTWFjUkJEMkN4MnRwMllrdFYvbzFSd3Yv?=
 =?utf-8?B?akhGNm5hWk5Ua0pFZy9WYUxmVzdoZGRpREw2YmVsQnR5UTEwSWdUcVNodnlO?=
 =?utf-8?B?VzY4Wi9Hd0NOSEEwUnl6MnhBSjc0dFp6akN6NVlJdEdVRitvUmY1T252U2JO?=
 =?utf-8?B?eW5XSjlDWjVVZHhsU0tWRmFxcEdCajVrOUtQSTlGc1BlOXZaVllUYldVYVVq?=
 =?utf-8?B?T3dIeWpIWmRYTk1EbGNTaE9ZeGtTdEpJaXJpcUhDbGM1Y1BpZkwra0N2bkJs?=
 =?utf-8?B?UkNDMk81dlQyVitLNXFLS1Z1S2FLV054TytnQ2swQ2lnV3VLRHRTMGowSWd0?=
 =?utf-8?B?a1JxajViakpJTGFTMU5STi92R0lDVVZsODU1MlFaVjhSUjVOeWpQdmpXczhV?=
 =?utf-8?B?cnlmbzA3K20yb1JjMUQyUFVnVXludS9KVzFreW9pdGNYSDl0L0pzOC9xNkN6?=
 =?utf-8?B?bEZ2MkdmaWxzeWRIbTlkMEkva2hRMXNnODBjSndWbVdSOHI1K0crSXJoNlJI?=
 =?utf-8?B?VSttWFBHQ1Z3K2dQTk9YSm9IWitPdjlVU0FubjdFZjdiak0zRy9uTXk1ek15?=
 =?utf-8?B?TithSHN5UjBoWEdVZEZtcW5DMlZnK0J5Z1UzNXZoVUVZWVZaSFp1Lzd1MEJo?=
 =?utf-8?B?Wi8rR0l5MzgrZnBvYkZBeDhMRGlnZ3BYSVR3bmMyNUtpVlFhUEJobXpXZ3d1?=
 =?utf-8?B?UTM2YnIwTEpnV1JaZUtlUmNCb2FnU2hIbzVvU2hRRk82aUlyWlFwOUZ3UzVV?=
 =?utf-8?B?ODN6b21KbllqdG9Wem9OQ2VtT2wvYTJGcUdLSTZlZGNzWWp5bFFSbTk0cXpz?=
 =?utf-8?B?aUw3dWhISjJSd0JmeWFWdCt3S3pMS0Q4ZDRrYzkwMTZ6YjR5RXphVVJOVzBM?=
 =?utf-8?B?NENqTUcyQlJKaUM2WUJ4RkkvYWVnUFR2a0ZyQ21kVi82VXFJT3ZaOGVzeXRm?=
 =?utf-8?B?MzNwWm1oL29zNzNBL2JvTzFWVVZ6QkYyTlZuMkJod3lGMEdROE9tVXJYMlZU?=
 =?utf-8?B?eU1Jemc5eHFJcXZhZURhWE5aRnFmdzRuczVsaHdtcnl6R2VIOVgrV3NkbTBG?=
 =?utf-8?B?aFN5akxsZHV1ZFZCckRRbEdsb0w2MmR5R2tDUzdBYmtQTXBaNEdYbjh3d1Ez?=
 =?utf-8?B?d2hteXQxM1RGSnFYN3pjeERiNjg0dSttMXhxTVd5cElFRjlnYm9CamxtQzNa?=
 =?utf-8?B?UW45Z3Z5QzgyYU5CL3preWxpK0tzWXR0dXVTZytVcHk1TjNVUnNMY0hKY0pz?=
 =?utf-8?Q?xIG0M9qoyoPVXyr1GvZGo34uMeS15tCyJTCcDnZ?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR07MB3196.namprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: accbd880-41ec-4221-2956-08d8e2d1b1a0
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Mar 2021 08:02:32.7701
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ndOZp/jQ7aXS2Ix0OHhRBT1YNl3ZBAxt9GgEydxlxoauP1UXHG21h3KSU5Aughx4653ciMn4b0cdQLC2Das6tbwHtEs6PXaOdmiMJeBFXME=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR07MB6890
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-03-09_06:2021-03-08,2021-03-09 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0
 lowpriorityscore=0 mlxscore=0 suspectscore=0 spamscore=0 clxscore=1015
 adultscore=0 phishscore=0 malwarescore=0 bulkscore=0 priorityscore=1501
 impostorscore=0 mlxlogscore=999 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2009150000 definitions=main-2103090039
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Pj4gPj4+IElzIHRoaXMgYSBwcm9wZXJ0eSBvZiB0aGUgaGFyZHdhcmUsIHRoYXQgaXMsIGFyZSB0
aGVyZSBtdWx0aXBsZSB2ZXJzaW9ucw0KPj4gPj4+IG9mIHRoaXMgSVAgY29yZSBjb3ZlcmVkIGJ5
IHRoZSBzYW1lIGNvbXBhdGlibGUgc3RyaW5nIHRoYXQgc3VwcG9ydCBIRENQDQo+PiA+Pj4gMS40
IG9ubHksIERIQ1AgMi4yIG9ubHkgb3IgYm90aCA/IE9yIGlzIGl0IGEgd2F5IHRvIHNlbGVjdCB3
aGF0IGEgZ2l2ZW4NCj4+ID4+PiBzeXN0ZW0gd2lsbCBvZmZlciA/W10NCj4+ID4+DQo+PiA+PiBN
SERQIGhhcmR3YXJlIHN1cHBvcnRzIGJvdGggSERDUCAyLjIgYW5kIDEuNC4gU28sIHRoaXMgaXMg
YSB3YXkNCj4+ID4+IHRvIHNlbGVjdCB0aGUgdmVyc2lvbiBvZiBIRENQLCBzeXN0ZW0gd2lzaCB0
byBzdXBwb3J0Lg0KPj4gPg0KPj4gPiBUaGVuIEknbSBub3Qgc3VyZSB0aGlzIHF1YWxpZmllcyBh
cyBhIERUIHByb3BlcnR5LCB3aGljaCBzaG91bGQgZGVzY3JpYmUNCj4+ID4gdGhlIHN5c3RlbSwg
bm90IGNvbmZpZ3VyZSBpdC4gQSB3YXkgZm9yIHVzZXJzcGFjZSB0byBjb25maWd1cmUgdGhpcw0K
Pj4gPiB3b3VsZCBiZSBiZXR0ZXIuDQo+Pg0KPj4gU2luY2UgdGhpcyBpcyBmb3Igc291cmNlIGRl
dmljZSwgSSBhbSBub3Qgc3VyZSBob3cgdXNlZnVsIGl0IGlzIHRvIGFsbG93DQo+PiB1c2VyIHRv
IGNoYW5nZSBIRENQIHZlcnNpb24gc3VwcG9ydGVkLiBJIHRoaW5rIGRvaW5nIGl0IGluIERUUw0K
Pj4gZ2l2ZXMgbW9yZSBjb250cm9sIG92ZXIgSERDUCB0byBzeXN0ZW0gZGVzaWduZXIvaW50ZWdy
YXRvci4NCj4NCj5CdXQgaG93IHdvdWxkIHRoZXkgZG8gc28gPyBXaGF0IHdvdWxkIGJlIHRoZSBy
YXRpb25hbGUgZm9yIHNlbGVjdGluZyBhDQo+cGFydGljdWxhciB2ZXJzaW9uIGluIERUID8NCj4N
Cj5JJ20gbm90IHRoaW5raW5nIGFib3V0IGdpdmluZyBjb250cm9sIG9mIHRoaXMgcGFyYW1ldGVy
IHRvIHRoZSBlbmQtdXNlciwNCj5idXQgaW4gdGhlIGNvbnRleHQgb2YgYW4gZW1iZWRkZWQgc3lz
dGVtLCBpdCBtYXkgYmUgdXNlZnVsIHRvIHNlbGVjdA0KPndoaWNoIEhEQ1AgdmVyc2lvbnMgdG8g
b2ZmZXIgYmFzZWQgb24gZGlmZmVyZW50IGNvbnN0cmFpbnRzIGF0IHJ1bnRpbWUuDQo+VGhpcyBy
ZWFsbHkgc2VlbXMgbGlrZSBhIHN5c3RlbSBjb25maWd1cmF0aW9uIHBhcmFtZXRlciB0byBtZSwg
bm90IGENCj5zeXN0ZW0gZGVzY3JpcHRpb24uDQoNCk9rLCB3ZSBjYW4gcmVtb3ZlIHRoaXMgcGFy
YW1ldGVyIGZyb20gRFRTIGFuZCBsZXQgZHJpdmVyIGF0dGVtcHQgYm90aA0KSERDUCAyLjIgYW5k
IEhEQ1AgMS40IGluIHRoZSBzYW1lIHNlcXVlbmNlIHNvIHRoYXQgSERDUCB2ZXJzaW9uIGlzDQpz
ZWxlY3RlZCBiYXNlZCBvbiBzaW5rIGNhcGFiaWxpdGllcy4gQnV0IHRoZW4gdXNlciBzcGFjZSBh
cHBsaWNhdGlvbiB3aWxsDQpub3QgaGF2ZSBpbmZvcm1hdGlvbiBhYm91dCB0aGUgSERDUCB2ZXJz
aW9uIHdpdGggd2hpY2ggY29udGVudCB3aWxsIGJlDQpwcm90ZWN0ZWQuIEkgc3VwcG9zZSBtb3N0
IFVIRCA0ayBjb250ZW50IHdvdWxkIG5lZWQgSERDUCAyLjIuDQpTbywgZm9yY2luZyBIRENQIHZl
cnNpb24gaW4gRFRTIHdhcyB0aGUgZWFzaWVzdCB3YXkuDQoNClJlZ2FyZHMsDQpQYXJzaHVyYW0g
VGhvbWJhcmUNCg==
