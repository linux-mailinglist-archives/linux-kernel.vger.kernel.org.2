Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2CD3E328395
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Mar 2021 17:22:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237019AbhCAQWC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Mar 2021 11:22:02 -0500
Received: from mx0a-0014ca01.pphosted.com ([208.84.65.235]:23240 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237704AbhCAQQV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Mar 2021 11:16:21 -0500
Received: from pps.filterd (m0042385.ppops.net [127.0.0.1])
        by mx0a-0014ca01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 121GCi7N005121;
        Mon, 1 Mar 2021 08:14:57 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=proofpoint;
 bh=KtK5X72JQF8htAgKkyrgLQgcCboNVPd6PfvJOSgGXvM=;
 b=b1VmoZfo2Om0c9uEr8LWpBX1VJDS+E2rceYX25Awj6EmUfWLJsZzWRBJEpGCYD1GYLea
 CbPTyAB9mgCTjBBCNxsSjrbpMtihdDEnn5rU+xgNRUcZVNbZK2kbYVtILTmT5fPoBJQ3
 NInVmJM/JZa1CNWR5ek2ihQWTWX2bVqN6I9apvRl0PrWUwkfxmao3wFS2GmBqRgng0rd
 eOQXTHF317JBXUN9La36rU/VDuBpuGlfH8A7UCfSbBC4gwedfzZveYSAbrYKKzYKTtZS
 yiLg9a4RIjp4CYOMyjDwPEPvH1BGr+yxcE8PLJ9elScr4MsHuCZNfTUUHSxMUd71P7g/ cA== 
Received: from nam02-cy1-obe.outbound.protection.outlook.com (mail-cys01nam02lp2058.outbound.protection.outlook.com [104.47.37.58])
        by mx0a-0014ca01.pphosted.com with ESMTP id 36ykh1ngf9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 01 Mar 2021 08:14:57 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XYEVeO24R2QTXfPFY3sB+BL3N48cvWYRfCGVlQ6XljWLkH2wXX93WLX2CQPeZihqaxb9v1/xfDLjoOS45O3BpH9PnYWHaGuZtyKB/XicQinmniMIL40HLwXgxoMuOUmvA7s4l0pmNJAd1HOJpDgRVW0XAIYIUN8x1tJAUieKXKGAJdtWJz8Oedfsfw71OeZyA4FoBHZ4qRLTsCkjz7WegEhi5j2CfgdsHhKCGK5kcxQ2wkPFYRqHlWMeaD7vPVFiv6GQxsfc71Siu63yy6GWWJPVaXiBTkBTyLAZGa6LTDKfRieDkwvVfZJfbSn4E7YAUMGv2A8xHzTc/uwnlasI1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KtK5X72JQF8htAgKkyrgLQgcCboNVPd6PfvJOSgGXvM=;
 b=EL/TAXxNm7y4dKjlGZPdwMIEYvvBoL/rM0ta2jpNqkCL6uOx5NSuFcnrj3J7JBso8zaUas+qbLy09rmRUX2M0Pf0i41SRnDBBFQnpJ3+giX1TMAK9mYLCi3K0LaoEobxIHXzM/SWsV0yj8EQAhyq+dZvHfzdAHeyLFnx9KEUx2PKAjs2qCYnt1iTVp8ZPnva5+p/ygDjFfVxqMZdkdYFZsKVaVC7R1IpA5+eQJHaLpJSSKAyWvRF9cGtBT8+zXlxKSWGeKIxI6ys3ab++qGNPMaYlr54k9plbB5+XvS8EVi4jV2Soa4DNY7vqn43TWyDm3mqxwXaoFHtSkZ8B9OXfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cadence.com; dmarc=pass action=none header.from=cadence.com;
 dkim=pass header.d=cadence.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KtK5X72JQF8htAgKkyrgLQgcCboNVPd6PfvJOSgGXvM=;
 b=HhCAeb2Dwu6hb4J2U1ODn+GDL92wLBomsWxNs/Rudxwtbl8IqCSmqNKuMK5ai+WUMgFqyWXKFMAQ5FvkyhUfWa7x2RUGVHDuR/Ha6hqNZo8AXmfRaso+bHS0Ur+zbCAbGZUtSxTNyrcBqV9ciJX/vPgzhbySOo8dWMk+6hn6fkI=
Received: from DM5PR07MB3196.namprd07.prod.outlook.com (2603:10b6:3:e4::16) by
 DM5PR07MB2923.namprd07.prod.outlook.com (2603:10b6:3:d::21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3890.19; Mon, 1 Mar 2021 16:14:55 +0000
Received: from DM5PR07MB3196.namprd07.prod.outlook.com
 ([fe80::3160:6a62:6e4d:2226]) by DM5PR07MB3196.namprd07.prod.outlook.com
 ([fe80::3160:6a62:6e4d:2226%5]) with mapi id 15.20.3890.028; Mon, 1 Mar 2021
 16:14:55 +0000
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
Thread-Index: AQHXDo0sCc9s3aGgTUeo76y9eToCYapvRZgAgAAHa+A=
Date:   Mon, 1 Mar 2021 16:14:54 +0000
Message-ID: <DM5PR07MB319661E8BFEB251CE17AF587C19A9@DM5PR07MB3196.namprd07.prod.outlook.com>
References: <1614597685-4192-1-git-send-email-pthombar@cadence.com>
 <1614597746-4563-1-git-send-email-pthombar@cadence.com>
 <YD0LKg3Jl5nauMqF@pendragon.ideasonboard.com>
In-Reply-To: <YD0LKg3Jl5nauMqF@pendragon.ideasonboard.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNccHRob21iYXJcYXBwZGF0YVxyb2FtaW5nXDA5ZDg0OWI2LTMyZDMtNGE0MC04NWVlLTZiODRiYTI5ZTM1Ylxtc2dzXG1zZy0zZmUwMzgwMC03YWE5LTExZWItODYyZC0wMGUwNGIzNmI1YjFcYW1lLXRlc3RcM2ZlMDM4MDItN2FhOS0xMWViLTg2MmQtMDBlMDRiMzZiNWIxYm9keS50eHQiIHN6PSI1MzIiIHQ9IjEzMjU5MDg4ODkxNTIyMzU0MiIgaD0iSFFUbURxcWZtaEtvUnJxdkNLMGJRLzlFcFRRPSIgaWQ9IiIgYmw9IjAiIGJvPSIxIi8+PC9tZXRhPg==
x-dg-rorf: true
authentication-results: ideasonboard.com; dkim=none (message not signed)
 header.d=none;ideasonboard.com; dmarc=none action=none
 header.from=cadence.com;
x-originating-ip: [59.145.174.78]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: be441305-0076-4edb-319f-08d8dccd26ef
x-ms-traffictypediagnostic: DM5PR07MB2923:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM5PR07MB2923AD5611E21D8684200826C19A9@DM5PR07MB2923.namprd07.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6430;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 2iZpH8gP7NNhiBsVAeNE8U2x3DZkdcZ+MYduLTTc5ea8I4YIRtcbHUHnKWLXLQON6uoaCKYX7+v0lt3gBU0pG8GiEaDLYC26FsRgz4viGUJjjmSI3ZhyhArtMrfswr2pqPNrmmVoRHJoGq0xnD3NFtkhVSwCWYhXQXH2ZekLSaE8cGroWO3PaaGBk32rIFnZV6YpYuGrLRIrSee2tqDvzPpiKfoLdPslFgLT6eBgbHWVaDghSQsbilYY+I+QVHmg2HSPp7AMSPV/aAGy8YFLe5CNTvoYPDrEbZE0RkjgCXwqf/OhtUynMbhRhWzq/R+eWP6D92NGAP8/JloMIDvBKcbv0JMcT5c32N1qIKFBgzjkx16Oiso+YAhIvQ9oA5jFUzYT6RxoD1HyHRDwTr4BAyH+yhs0rzH818allTYTDm3eT/k3c16yor8oJm22f7adVFurl4QFiTI9+EHvI9CPp3VAtmJebdqKpAK2wqhX2A0UlVSsoDq22cYmwVMUQTYZZTbkgo3rVBeaOak+fcHoY1aLbuBdQH+mSIzdE95R3rWEYpEBilDn/s+zVWP8GnkQg0+vkbV0409GH1J6Q0y2+g==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR07MB3196.namprd07.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(366004)(376002)(136003)(39860400002)(346002)(36092001)(33656002)(76116006)(7696005)(64756008)(66446008)(4326008)(66476007)(55016002)(2906002)(66556008)(66946007)(6506007)(4744005)(9686003)(8936002)(52536014)(8676002)(478600001)(71200400001)(86362001)(107886003)(186003)(54906003)(7416002)(5660300002)(316002)(26005)(6916009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?utf-8?B?aTk2ak5MRDFiZXIyejhNWXBxejdsRzVva3pvRHpld1R5clB5dEFpUVZiREFn?=
 =?utf-8?B?NHVYVEpOSTZtdGFXUmxNMmhaZHNlb2pYTUhXVk1XZUxRRDlqcUg1bWJhV2RP?=
 =?utf-8?B?em9vbmZ5YUYwYjllY0gzbUhOK1lmZFIxTTNGSWZVRkdDNlZwL3pQbVNTKzdh?=
 =?utf-8?B?b0NBZEJnUk1SRXNNc2dzQ3lsRkNENE90S2kzV3hiWTNXL0xnWHN6T2grdTBD?=
 =?utf-8?B?RWVQZi85bTJFMnE5c0xsdmdZRGlpYWh1NkMrRldiRlhaY21IUzhBZzk1SSth?=
 =?utf-8?B?cjR6ZEhtRTZWVW1xVU9UdEVwZWxFY0FDS0Z1OXNXazB5NXNIUXI0WE5GUHA0?=
 =?utf-8?B?ZldvR2JabWZtRjNnOGVzMjdyRkFyVEVGWFg1SnJaclJGNlgwbXBQY21DUzZN?=
 =?utf-8?B?eG9sRE1ibVF3dytMeFlMUWMwbmxZTGU1UmRYYis1dElXc21tZmpSWk1IVHNB?=
 =?utf-8?B?WnlHaTZxLzVDZDRhNVpQN3dHdk5KUllac2Y1UXdFc29KNzk0d0dmOFM2TXVk?=
 =?utf-8?B?M3c0enpuZVNQNS9la29pZUZpZ1E4ZzJ4aWQ0WjFFK0xhMW9qd1ljM1pHNW9X?=
 =?utf-8?B?NkwybTA5R1AwTG92RHN6VklEKzJPM0tLclAxYWpWK3l6R2FhVkM5RFV6WjNX?=
 =?utf-8?B?OVdYSkJITHU1b2xHalVGSWd2Z2wyL253TncrRlRZTkZuaCtxSVJTaWtZOXFn?=
 =?utf-8?B?d1lidXFkZkRkeCs4RjJENHppWVFEODRKQ3lNdlhycjdrWU9QQWE2ZHdWMVhO?=
 =?utf-8?B?YmJ4TUlwV3J2TVB0T2JrbCt2bTNVWll2V0t0ZnNpTlc1ZGRWdlQrSWZJL0E0?=
 =?utf-8?B?SnRsR2luS2o2VG5RODQ3Z0lKYmV1NEFFTWd0VnYvUlh0OURySW9QczdnNEpt?=
 =?utf-8?B?MUIrT1l1MnpWalZuZFQ2ZTFTTjNWTUtYWkRrTjM4NG1vdEVkcUJpS21JeDBk?=
 =?utf-8?B?Vit3QXJpcnBBOGZJU1pCc0dML090N1BaV0paMzQ4SWRVdXVjOG5oVW1sZ3k3?=
 =?utf-8?B?d0N1cnlUYmxJMUhaRjhjV0xnNTNRdm5hVjJlWjY4VUkyU0xhLzNGcEprRE1S?=
 =?utf-8?B?WUkzVjdZc2RpUWpXdmgwYW1vVFNFSGNoY095T2JzMlNlcHdtc0N0SytqVkxP?=
 =?utf-8?B?NFh2dlNVVFpQT0lQUE9hb2p5Vi9xNlcwWlh5ZmZ5S1hrcXg1WlVpdlA5VG5i?=
 =?utf-8?B?akFSTTJJR1NYRE9aR1JETiszZW1ibXVDY0NqTUdtdmxhd0FTS1lKUm84cXIy?=
 =?utf-8?B?cDJKSHZnRmJzUlZlM2N2REIyZFNWNXdFSXE0Y0FEeUhIWmg2TWkxcHV6NXhy?=
 =?utf-8?B?WFQ3OGljU2lYeHpjWk1aM3BJcFBIWHNhaWNSVXo0TFNYUHBGVXMzRWQzYkVK?=
 =?utf-8?B?UWtEOVdqcEs0WXp2Z3hBM1BoNEMyWEpRbmNMVU1maUNSWVBZUFNCdjh3Nloz?=
 =?utf-8?B?OEE0VnFmaWdjNUxVcDE1QTRnbVJUdklqaWN6MnRIbW9HazN1SHZXbUtaZFla?=
 =?utf-8?B?RnJVdGZoWUNoWVVVRTFCK0JjQTd2eW1mRFM1clcvaUJmV0tBNjUyMEMzQVFF?=
 =?utf-8?B?UmpoWnAwUlpuR3dGNitYVjlZRDRFczZGV0xRVmhOemZMQTJtZDR5YmFRZXpE?=
 =?utf-8?B?Yit0T1AyRzQzUUFKeEFwN1phbnE0MUhNd2ppMFBtVmliTGhoYk5SM1JieVVW?=
 =?utf-8?B?OEhmeHY3R3NRa2luSFlGeXUyd2ZJbmxwa2VsRWpHRHM5MGN4WTI4NzRpcEdD?=
 =?utf-8?Q?gRrvC61Jj+WRc7kd43Sd1wqyRmsWF9tn8UvuXh9?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR07MB3196.namprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: be441305-0076-4edb-319f-08d8dccd26ef
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Mar 2021 16:14:55.1252
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: UYTL+DcDsCeHATtY7FyuM/WnlQH3I5lgOpSASghmfG8mNJUQQZ0PgQJoyagYIK409E8oOh0GiICoM/ubgSxz3EDlLFjWCaoXJ0Vth/r6FF0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR07MB2923
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-03-01_11:2021-03-01,2021-03-01 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0
 lowpriorityscore=0 clxscore=1015 mlxlogscore=999 impostorscore=0
 phishscore=0 suspectscore=0 mlxscore=0 malwarescore=0 adultscore=0
 spamscore=0 bulkscore=0 priorityscore=1501 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2103010134
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgTGF1cmVudCwNCg0KPklzIHRoaXMgYSBwcm9wZXJ0eSBvZiB0aGUgaGFyZHdhcmUsIHRoYXQg
aXMsIGFyZSB0aGVyZSBtdWx0aXBsZSB2ZXJzaW9ucw0KPm9mIHRoaXMgSVAgY29yZSBjb3ZlcmVk
IGJ5IHRoZSBzYW1lIGNvbXBhdGlibGUgc3RyaW5nIHRoYXQgc3VwcG9ydCBIRENQDQo+MS40IG9u
bHksIERIQ1AgMi4yIG9ubHkgb3IgYm90aCA/IE9yIGlzIGl0IGEgd2F5IHRvIHNlbGVjdCB3aGF0
IGEgZ2l2ZW4NCj5zeXN0ZW0gd2lsbCBvZmZlciA/W10gDQoNCk1IRFAgaGFyZHdhcmUgc3VwcG9y
dHMgYm90aCBIRENQIDIuMiBhbmQgMS40LiBTbywgdGhpcyBpcyBhIHdheQ0KdG8gc2VsZWN0IHRo
ZSB2ZXJzaW9uIG9mIEhEQ1AsIHN5c3RlbSB3aXNoIHRvIHN1cHBvcnQuDQoNClJlZ2FyZHMsDQpQ
YXJzaHVyYW0gVGhvbWJhcmUNCg==
