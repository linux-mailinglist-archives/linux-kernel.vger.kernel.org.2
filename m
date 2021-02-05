Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BA866311AB2
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Feb 2021 05:08:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231137AbhBFEIS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Feb 2021 23:08:18 -0500
Received: from mga18.intel.com ([134.134.136.126]:31166 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232254AbhBFDFf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Feb 2021 22:05:35 -0500
IronPort-SDR: OH5vYv5TEB9s1/7TlJUcIzNWBfoWX9mrtqvpMv10jYpIzOJY72ti7Z+FSTvXLMCwkXrCuYNvPz
 +L6MisYeBr2w==
X-IronPort-AV: E=McAfee;i="6000,8403,9886"; a="169173111"
X-IronPort-AV: E=Sophos;i="5.81,156,1610438400"; 
   d="scan'208";a="169173111"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Feb 2021 14:56:22 -0800
IronPort-SDR: QBRqYThpmPfrZKgKX3WESfJMnGUJg7qqilye0XjFYO7Qpd5K6FXZPJCRFb+Gz2LjSyKDV6iFnJ
 vDHYq6h4EPOg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,156,1610438400"; 
   d="scan'208";a="373718243"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga008.fm.intel.com with ESMTP; 05 Feb 2021 14:56:22 -0800
Received: from fmsmsx604.amr.corp.intel.com (10.18.126.84) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Fri, 5 Feb 2021 14:56:22 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx604.amr.corp.intel.com (10.18.126.84) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2106.2
 via Frontend Transport; Fri, 5 Feb 2021 14:56:22 -0800
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.169)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.1713.5; Fri, 5 Feb 2021 14:56:22 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bBncZ1zIhEaZbE5qfHW1IgmuuhXpsM+RmxJ4hGkPReuSLbCP3A9byLi7yVvtjJX2YM6x02207ABLuQ2D53tDK95ySeAjAW3sya/M+4IoF/Tby1Pnj8PD9nLOav8Lt2+p3AOF9OwAPkdlwcFrqf48n6xHRBdCFtEoidjl4DdovwHbRT8sxtfNmZA6i+T2VAz32mtdQZpLZ1zhi97+4SSxxV3TaqgRQvZyiA23aIoNLXiN30BtIfhuEVVwkoOSn6yvYmPggLvFbisDlAspn8Mkuj3/zcwKvrcW5vok0y/biGaTBtdOOYD4NHq7cck+rFDsUb5jfAaQz8/YCQlD/G5Egw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AohT67NBlht4e/vAcB6ErTHXRQI4zCfnlyAJBSfzTQ8=;
 b=fZddT+fw6C+9hYa0/GvNmO2+cg7RulMzdbsVjJxsVv5L9CeqQp2YK3uy5XfuH4Fq5wYkxy70UikEEnDlpVFCz59ju1bU+SNP49JZHfSbe1EBppZ3PFe5QkOPznELproEDuqa2ifYgOkYTeYy4DwvWPKLEom6EUeAO9kfuaPR30QrfPEWnwPHFrHEMS+sOZVxiGUq3abdxUp/NdKa1iLqaz7DApfzKfmNug4ix9Rqy9lOkgNQEAz5Z7GLc2CMMhe6C3pLe57rSLAOBLwHftNJWZ4PmiYtjW4kr3lpD94quKsq4PRBWKIjLDziNqn7Yq8+23kr1rBTc94/F7QQ3L7MFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AohT67NBlht4e/vAcB6ErTHXRQI4zCfnlyAJBSfzTQ8=;
 b=R6TAqoNefhGHfCHbuHGs3SeidRXogjIdPPKVjPp7ByYisbt2a4H+OrBzAp02IifO7vnmC32wCYTjAD83VQR23VWfvilAPq6TYf4MDJcgbKKsGPs2yvcqe6hhnZzq8OLivNf5pgYa5osqaGFrO54IE70kYDvylRtu97cTYEVxgCc=
Received: from DM6PR11MB3963.namprd11.prod.outlook.com (20.176.127.16) by
 DM6PR11MB3675.namprd11.prod.outlook.com (20.178.231.149) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3805.17; Fri, 5 Feb 2021 22:56:21 +0000
Received: from DM6PR11MB3963.namprd11.prod.outlook.com
 ([fe80::69a6:7774:f8dd:8b6a]) by DM6PR11MB3963.namprd11.prod.outlook.com
 ([fe80::69a6:7774:f8dd:8b6a%7]) with mapi id 15.20.3805.026; Fri, 5 Feb 2021
 22:56:21 +0000
From:   "Mani, Rajmohan" <rajmohan.mani@intel.com>
To:     Prashant Malani <pmalani@chromium.org>
CC:     Benson Leung <bleung@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Guenter Roeck <groeck@chromium.org>,
        "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>
Subject: RE: [PATCH 1/2] platform/chrome: cros_ec_typec: Skip port partner
 check in configure_mux()
Thread-Topic: [PATCH 1/2] platform/chrome: cros_ec_typec: Skip port partner
 check in configure_mux()
Thread-Index: AQHW+/hnlvlRWJ5JNEGaBCorHikVdapJ/Q4AgAAvGZA=
Date:   Fri, 5 Feb 2021 22:56:20 +0000
Message-ID: <DM6PR11MB3963CE613ED4F666EBDA27E6F6B29@DM6PR11MB3963.namprd11.prod.outlook.com>
References: <20210205195113.20277-1-rajmohan.mani@intel.com>
 <20210205195113.20277-2-rajmohan.mani@intel.com>
 <CACeCKadzdTGi3y_WbihX_p_rfL8wcTFVwbUGPU=de53fA9dVog@mail.gmail.com>
In-Reply-To: <CACeCKadzdTGi3y_WbihX_p_rfL8wcTFVwbUGPU=de53fA9dVog@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-reaction: no-action
dlp-version: 11.5.1.3
authentication-results: chromium.org; dkim=none (message not signed)
 header.d=none;chromium.org; dmarc=none action=none header.from=intel.com;
x-originating-ip: [76.126.121.82]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ef21ff38-636b-4504-fa03-08d8ca29415f
x-ms-traffictypediagnostic: DM6PR11MB3675:
x-microsoft-antispam-prvs: <DM6PR11MB367567EE917CCD77AEDCD9E4F6B29@DM6PR11MB3675.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3631;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: wskR3lpJpC6+UrmxybjUiAbRCgAQOgoO/q6buhZ5WeYH0W8JcHO0+jc8AF37/a+DGJmZkHdD9ZWFE7ZK1r26RW2CVUV1rViLE4/bwyKi/IrJAHiWzetkOLAtz6rma5JrN5xWv1GeobNHXRL6a8fYjIXZVVWbIl4syvWFqTDqpMUKQsaUAB/8eAwbGu0ogcHIXhrUkA55SvLqyKNGv+eQmKwQ4d9x+3Xl7qj+Nf4CNT/TLduO6icsZA3gyvJhSaNUptvfqlB9FMx+vt5tNfQhPCZXQ1ae0bmH/aeG2OKnOCpqfN4Y//6djOR4kd3Q0z1EwaYb7XsoHwp8OhKXrWsNh8HB2PhN7h8xpnJtuilsOucxcmmPfFEN7PWv93N1ol1XmtfkQ/2VNC1euK/g0Vs+hpypYFLIy/AbwbCKz1k+m7BF43BpNlPYkQTY5BFYlMVzu3oXFhVqoW1VYSIhfX49HHvuwxlNiwoxIeeZEiiyeH2JhpuWKrKiYXh6FRTNLgTfvOhXpLAFMkqgZKvPoOTGKw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB3963.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(39860400002)(366004)(136003)(376002)(346002)(54906003)(316002)(26005)(5660300002)(76116006)(8936002)(83380400001)(66946007)(66476007)(4326008)(33656002)(6916009)(8676002)(478600001)(2906002)(71200400001)(64756008)(55016002)(7696005)(53546011)(86362001)(186003)(6506007)(66556008)(66446008)(9686003)(52536014);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?utf-8?B?ZE4rUFBLN0dFaW1kUzBGL3pLWkFrMlNzZnJvNld0aUxsYlU1UUNvTFVGdENr?=
 =?utf-8?B?ai9keDVuVGhlblpaWmIxNTgxQTJwaU4yMmNlNTNkN3FpRHUwMGtJOUdUdWtm?=
 =?utf-8?B?VUw1aHZSN0pjam1zQmx4eGFqVTFnU3lFMTBkQWFIc0M5TWQ5akRiRTlTNmN2?=
 =?utf-8?B?R1hNczRlNXVXN1UrMlZsL1pNSDNYVGpRdzl1UW1wSFpUK2U4SGI0MTg3ZjF6?=
 =?utf-8?B?NmZRaDJTcmdvaXlDajF5WThBUGNaNzhDdnlSSE5rOEFYSkc0ZlVCd25NdU1a?=
 =?utf-8?B?NXJKZWF4MGs1ekhnMU9tQ1FRTG5tVmdsVVEzUTJpYkpLZkowVDRxK0k1N3ZO?=
 =?utf-8?B?MTdvekJueE5ZNThRU2Vzd1Z0aHM2VzNPdDIybHRDeTYwa0F1S2dJYkFxdjNH?=
 =?utf-8?B?bk94TXRqNFd2dTdxUDA0TCtnVGlKaDZ6b2JVWnVCZFlmb3hwRW5jaERGVU5T?=
 =?utf-8?B?Yk5ZQnd2RklVMk93cGNpOFpna0tSd2pCT3ZvMmlWZjdpa0lPNGhnT0dpT1BY?=
 =?utf-8?B?Ym44YWxEQWpOY1lTK0xZN2VDUFpEOXZaRmtsYnFyWDh4dUdqNWJHN2hpRk5I?=
 =?utf-8?B?N0ZOWS9UQzhyS3dCcjdmcVJFSGI2eVhBZm1qRzFZWnZJMUFUM3FKWVN2MWg3?=
 =?utf-8?B?OVRxcmJ3dTljQUR4VDFtVDZpZkJ5Qmk2cWI2UXFUQ0hhaHcxRUEzNGtQV2FY?=
 =?utf-8?B?eDBrRlhndGozbzFlUlZBVDF2VVFRSm1Henp0RWJWVmVDUmU1SWFiazdCL0pi?=
 =?utf-8?B?dmE5ZkZMYk1jYUJ0WGhQU21jbnNzME9hTGx2eEE2Ykx4Y1hteVpqMkRtb3pE?=
 =?utf-8?B?eFA5dmZjdWo4RFR4Qit2TUNtSXZpVkVtSERkSnYyS1QyQlV4ZzErenZRNU11?=
 =?utf-8?B?Zk0weXRmZjdNZkl5WWE0bXhKRS9teDBXL0Vqa2JUUlhWWGVZV1I1cnVpNUxS?=
 =?utf-8?B?YnpXeUY0ZEFLQ1hwdDFtOW9zallwYmZ1d2lOaklNNnNKUWVrU2NZVERxTWR5?=
 =?utf-8?B?eldoc2sxWkNrelprVmJzUWVBMWM4ZVVNNkFCUXZLRjRNVkZOSzFpeVN5YjJq?=
 =?utf-8?B?TXJBWTgxaDEwL2RnQ1hDL2pZR3g1bUs2TllvTU8yVG15d0JiaFlBV3FXeVho?=
 =?utf-8?B?Vm9JSm84L0hhTzlmWkZzY1BRQkgvNmtUcyt5eCtBeUgxRUJPQzg3WktjcXJv?=
 =?utf-8?B?dmFjTElsWWpmTHZVNEJ3b1UzaXdDN3NsNGZtcnBZenlxalY4TnJHNVpKQS9M?=
 =?utf-8?B?SndXNE1oOTRrYWowTVk0YTBYdWxTRDZhQ3V6WVJZb1EwVEhaazNMazFNTnJq?=
 =?utf-8?B?UFN2TTgxdTFwUDVnR2ZyQWs4ZEg0TDlxc0FpUzI2WWNGK0lqUThLcUt0R2kv?=
 =?utf-8?B?K1NNdWYxZy85L1pmY1NydDBtZkRIaVhsNTZienVVN243dWhvcEhrK3JiOGRU?=
 =?utf-8?B?bTVrbzlvTTZYVFRydHB0SWoxeE4ySy9mUHRSZUVSVGZaMENHWjh2UHlLcDA0?=
 =?utf-8?B?MUk4aDgvSWR2U21Wc2tUZTJxaGJTWDFIMnV1bE41V01CTHZzWnNYZjN4WXky?=
 =?utf-8?B?VEhuSHl6NmVHd2dsL1JaWXZLL3dDOXAwVEsyV2tOaUM2QnBTMTlUY1ZZZ0lk?=
 =?utf-8?B?c3QrenBXcW9HalRvMXZGdWwwaVFHZkxwcU9YZ25ud3BTbnB5M1lLUXhoOFY5?=
 =?utf-8?B?dS9DL1BhZmlhdjY2dDAwK0IwUk1kbEwwNE8zWStGaUdWcGhnNDAraTBDY1RS?=
 =?utf-8?Q?XXBqXyj68OeUV/+KZPK0ixnFx7mOt4Umkg2U3Ub?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB3963.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ef21ff38-636b-4504-fa03-08d8ca29415f
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Feb 2021 22:56:21.1194
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: C3uMprDjqoRIDd0rcSzb6qm1rUNPb3dBBbaNkBQgt2kDpApwkU0sYOghJ3mtcaJonR8MSAs7zBOrfPTGIIGqpA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB3675
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgUHJhc2hhbnQsDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogUHJh
c2hhbnQgTWFsYW5pIDxwbWFsYW5pQGNocm9taXVtLm9yZz4NCj4gU2VudDogRnJpZGF5LCBGZWJy
dWFyeSAwNSwgMjAyMSAxMjowNyBQTQ0KPiBUbzogTWFuaSwgUmFqbW9oYW4gPHJham1vaGFuLm1h
bmlAaW50ZWwuY29tPg0KPiBDYzogQmVuc29uIExldW5nIDxibGV1bmdAY2hyb21pdW0ub3JnPjsg
RW5yaWMgQmFsbGV0Ym8gaSBTZXJyYQ0KPiA8ZW5yaWMuYmFsbGV0Ym9AY29sbGFib3JhLmNvbT47
IEd1ZW50ZXIgUm9lY2sgPGdyb2Vja0BjaHJvbWl1bS5vcmc+Ow0KPiBMaW51eCBLZXJuZWwgTWFp
bGluZyBMaXN0IDxsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnPjsgSGVpa2tpIEtyb2dlcnVz
DQo+IDxoZWlra2kua3JvZ2VydXNAbGludXguaW50ZWwuY29tPg0KPiBTdWJqZWN0OiBSZTogW1BB
VENIIDEvMl0gcGxhdGZvcm0vY2hyb21lOiBjcm9zX2VjX3R5cGVjOiBTa2lwIHBvcnQgcGFydG5l
cg0KPiBjaGVjayBpbiBjb25maWd1cmVfbXV4KCkNCj4gDQo+IEhpIFJhaiwNCj4gDQo+IE9uIEZy
aSwgRmViIDUsIDIwMjEgYXQgMTE6NTIgQU0gUmFqbW9oYW4gTWFuaQ0KPiA8cmFqbW9oYW4ubWFu
aUBpbnRlbC5jb20+IHdyb3RlOg0KPiA+DQo+ID4gRm9yIGNlcnRhaW4gbmVlZHMgbGlrZSB1cGRh
dGluZyB0aGUgVVNCNCByZXRpbWVyIGZpcm13YXJlIHdoZW4gbm8NCj4gPiBkZXZpY2UgYXJlIGNv
bm5lY3RlZCwgdGhlIFR5cGUtQyBwb3J0cyByZXF1aXJlIG11eCBjb25maWd1cmF0aW9uLCB0bw0K
PiA+IGJlIGFibGUgdG8gY29tbXVuaWNhdGUgd2l0aCB0aGUgcmV0aW1lci4gU28gcmVtb3ZlZCB0
aGUgYWJvdmUgY2hlY2sgdG8NCj4gPiBhbGxvdyBmb3IgbXV4IGNvbmZpZ3VyYXRpb24gb2YgVHlw
ZS1DIHBvcnRzLCB0byBlbmFibGUgcmV0aW1lcg0KPiA+IGNvbW11bmljYXRpb24uDQo+ID4NCj4g
PiBTaWduZWQtb2ZmLWJ5OiBSYWptb2hhbiBNYW5pIDxyYWptb2hhbi5tYW5pQGludGVsLmNvbT4N
Cj4gUmV2aWV3ZWQtYnk6IFByYXNoYW50IE1hbGFuaSA8cG1hbGFuaUBjaHJvbWl1bS5vcmc+DQo+
IA0KDQpUaGFua3MgZm9yIHRoZSByZXZpZXcgb2YgdGhlIHBhdGNoIHNlcmllcy4NCg0KPiA+IC0t
LQ0KPiA+ICBkcml2ZXJzL3BsYXRmb3JtL2Nocm9tZS9jcm9zX2VjX3R5cGVjLmMgfCAzIC0tLQ0K
PiA+ICAxIGZpbGUgY2hhbmdlZCwgMyBkZWxldGlvbnMoLSkNCj4gPg0KPiA+IGRpZmYgLS1naXQg
YS9kcml2ZXJzL3BsYXRmb3JtL2Nocm9tZS9jcm9zX2VjX3R5cGVjLmMNCj4gPiBiL2RyaXZlcnMv
cGxhdGZvcm0vY2hyb21lL2Nyb3NfZWNfdHlwZWMuYw0KPiA+IGluZGV4IGU3MjRhNWVhZWYxYy4u
M2Q4ZmYzZjhhNTE0IDEwMDY0NA0KPiA+IC0tLSBhL2RyaXZlcnMvcGxhdGZvcm0vY2hyb21lL2Ny
b3NfZWNfdHlwZWMuYw0KPiA+ICsrKyBiL2RyaXZlcnMvcGxhdGZvcm0vY2hyb21lL2Nyb3NfZWNf
dHlwZWMuYw0KPiA+IEBAIC01MzYsOSArNTM2LDYgQEAgc3RhdGljIGludCBjcm9zX3R5cGVjX2Nv
bmZpZ3VyZV9tdXgoc3RydWN0DQo+IGNyb3NfdHlwZWNfZGF0YSAqdHlwZWMsIGludCBwb3J0X251
bSwNCj4gPiAgICAgICAgIGVudW0gdHlwZWNfb3JpZW50YXRpb24gb3JpZW50YXRpb247DQo+ID4g
ICAgICAgICBpbnQgcmV0Ow0KPiA+DQo+ID4gLSAgICAgICBpZiAoIXBvcnQtPnBhcnRuZXIpDQo+
ID4gLSAgICAgICAgICAgICAgIHJldHVybiAwOw0KPiA+IC0NCj4gPiAgICAgICAgIGlmIChtdXhf
ZmxhZ3MgJiBVU0JfUERfTVVYX1BPTEFSSVRZX0lOVkVSVEVEKQ0KPiA+ICAgICAgICAgICAgICAg
ICBvcmllbnRhdGlvbiA9IFRZUEVDX09SSUVOVEFUSU9OX1JFVkVSU0U7DQo+ID4gICAgICAgICBl
bHNlDQo+ID4gLS0NCj4gPiAyLjMwLjANCj4gPg0K
