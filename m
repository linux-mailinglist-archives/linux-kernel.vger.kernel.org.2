Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B6303EDBE1
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Aug 2021 18:59:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230216AbhHPRAS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Aug 2021 13:00:18 -0400
Received: from mga04.intel.com ([192.55.52.120]:18662 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229742AbhHPRAQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Aug 2021 13:00:16 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10078"; a="214048471"
X-IronPort-AV: E=Sophos;i="5.84,326,1620716400"; 
   d="scan'208";a="214048471"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Aug 2021 09:59:44 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,326,1620716400"; 
   d="scan'208";a="448679835"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmsmga007.fm.intel.com with ESMTP; 16 Aug 2021 09:59:44 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.10; Mon, 16 Aug 2021 09:59:44 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.10 via Frontend Transport; Mon, 16 Aug 2021 09:59:44 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.174)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2242.10; Mon, 16 Aug 2021 09:59:43 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Vj6l6xQq6IvXSLuvrQ2QV/KllDEuzhHNF6KVn+rhX4Qhs1yLmv+04/+8fUpmIAM5ouThjhxmsqOmkiuIZCVWBdba8oTWJP2VhIkTjIffEOtncNXUC6OWZv4jpj9IGbeGlw7k2eMFRna1bvpnCT+cZ/YwH6pR3jLRRWk+lFwBuFP0287R2FIMN3sFqQf8h3cy3DsGSqkQMsVJQUB+ENLqRM+qMV17v8kzGRMurH274qHg0ZVnmmjqCuPinDlmrTvsFqj7sBNgH+K2TV0l6wKI2na/XajizAe66WR7o/liaKNQG/Nc2TSrNY7guwGaFP0NxXLGzHqHeByq9Pg0LtdnDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d1dI/QKiGhpT4a3wA0ejadR/O/7VrRoV0WTn1A44ifg=;
 b=QJP0+qOUPO2qGwYRfD2QM2kjKJgTzpDqAaU5rHbgHhjOedbTEwYIpVBm3wGPQBIcJ9rl3uz5xKkqamKibMA5ct2c8o/QWMNw1Hrcdk+QlbT8YJTNw4pItuO05kJfHBu5xlIPmRf0tL5mPQZUOHW5U8Mje5LwzLbIxTeQR9zaqY+5nSFSkKgKgKzQOMODqCxIyoWcSPPYQzCX3u5pQT45yzKDPjTM+Yh3RWSrbnjBfzwJy+y3ZEILcf9xtCCIypr3QT802X6HQbre0Vx8ZeVJjIXIXWJi/sDZvxG7BplHQmYGgYvIrOPKnJ71XusVsBqCGdAihzE1psc26K3zST3guw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d1dI/QKiGhpT4a3wA0ejadR/O/7VrRoV0WTn1A44ifg=;
 b=aGe7xoigdZ0RYAprI5JRpDWgwslhNADg3Z0HuYtm06QOY709OiuSS6znqOchZz4Jy2bkyKEGblCYBQyWEK9wis9Py3ckaEb3LOUPrNIwlV4PW/kM7tHybuWfGvRuK5j1+gUG3PWB/Z5s4VWee2t/8SyuFRCHgiLj2JMId1pc86Q=
Received: from MW3PR11MB4523.namprd11.prod.outlook.com (2603:10b6:303:5b::16)
 by MW3PR11MB4681.namprd11.prod.outlook.com (2603:10b6:303:57::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.17; Mon, 16 Aug
 2021 16:59:42 +0000
Received: from MW3PR11MB4523.namprd11.prod.outlook.com
 ([fe80::c5d2:7f65:9e5b:8f96]) by MW3PR11MB4523.namprd11.prod.outlook.com
 ([fe80::c5d2:7f65:9e5b:8f96%8]) with mapi id 15.20.4415.023; Mon, 16 Aug 2021
 16:59:42 +0000
From:   "Kammela, Gayatri" <gayatri.kammela@intel.com>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
CC:     Platform Driver <platform-driver-x86@vger.kernel.org>,
        Mark Gross <mgross@linux.intel.com>,
        Hans de Goede <hdegoede@redhat.com>,
        "Rajneesh Bhardwaj" <irenic.rajneesh@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        You-Sheng Yang <vicamo.yang@canonical.com>,
        "Pandruvada, Srinivas" <srinivas.pandruvada@intel.com>,
        "Box, David E" <david.e.box@intel.com>,
        "Qin, Chao" <chao.qin@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Mashiah, Tamar" <tamar.mashiah@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rajat Jain <rajatja@google.com>,
        Shyam Sundar S K <Shyam-sundar.S-k@amd.com>,
        "Alex Deucher" <Alexander.Deucher@amd.com>,
        "mlimonci@amd.com" <mlimonci@amd.com>
Subject: RE: [PATCH v6 1/5] platform/x86/intel: intel_pmc_core: Move
 intel_pmc_core* files to pmc subfolder
Thread-Topic: [PATCH v6 1/5] platform/x86/intel: intel_pmc_core: Move
 intel_pmc_core* files to pmc subfolder
Thread-Index: AQHXhdLO7bwnkjRQNUmlidz7skhIvKtcxCOAgBmkPaA=
Date:   Mon, 16 Aug 2021 16:59:42 +0000
Message-ID: <MW3PR11MB4523306F175E69CEF6FF7171F2FD9@MW3PR11MB4523.namprd11.prod.outlook.com>
References: <cover.1627710765.git.gayatri.kammela@intel.com>
 <fa72dfad9282e2c24b99327d08cbe032d7034bbf.1627710766.git.gayatri.kammela@intel.com>
 <CAHp75VeAu2fs5zesQE0YqsOSTVO8zPacpW9e89adYBoZnGToOg@mail.gmail.com>
In-Reply-To: <CAHp75VeAu2fs5zesQE0YqsOSTVO8zPacpW9e89adYBoZnGToOg@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-version: 11.6.100.41
dlp-reaction: no-action
dlp-product: dlpe-windows
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9d3e01ee-1a22-470c-e502-08d960d73df6
x-ms-traffictypediagnostic: MW3PR11MB4681:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MW3PR11MB468140A4BB87F8A3C31E04D4F2FD9@MW3PR11MB4681.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 1vKhO6AVfpWGID0lLo3Cjd/7M+TSLE/MMxtylZZCLLCwniidfEUvxzxgkFA4uhmKlwcAWXyoqWHgXmRcoZV9M1Ueukjc4jKJVUy4ZnWBTYJX02upSL1VQ1GtNFaqDX2DxE2LIFnewrKYOCgPJqzpLmKSlx7RQcCbMS6IYyZczzcUvTGq87BZZTl7KO3rnjj+DnG1lHDNogHTINjkITVkS910TGGB7MLkURibevaYClln/uZSTiHWRQGdrLSu1BGKn/4/1e4VbtDK1NHxR/dE/4JA34gTDvRExSDJ0H0scWUX4Pr7MpAfEEJPNVag0pG9cVommnoFMdiLzw/1RMJqXC0MDKGOQuz1OzfWp1pQiL/6w84qgJ3ubScd3sX6EOpxpoZOgc/3aiBChVzqx6b88zmFLyWG+IgG3OYByA8CqRTwpK6z6xHFoLqz691fA+FqWTmMPG38eEEm0/+ldtEcE5pmgG1BwY9B/KmcfOEjyVIRYTkpbG8vVolcMPUw/9bE/ehEQtPyt+o5g5tbVhhyab5cgJN4Rj/ZVhham4t7WM2IPke/XA3OLxOyWQFHygpGr8L1g/eezqaoVVwVkBarXdBiV2r1ZgCfeV5DMZseVrJ7vPATTNCti7++c1w9sIZ3Y/AaJ3Y0mNfhepWCl9FwADNoISIlcCic5j62IeSWITSw84Q6inTvjxT7tAZNGAHVde0db/31oasgFX3zHDbWJA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR11MB4523.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(39860400002)(396003)(136003)(376002)(366004)(6916009)(7416002)(54906003)(53546011)(26005)(186003)(316002)(7696005)(71200400001)(38070700005)(9686003)(83380400001)(55016002)(6506007)(76116006)(86362001)(122000001)(4326008)(8676002)(66946007)(66446008)(64756008)(66476007)(33656002)(38100700002)(2906002)(8936002)(5660300002)(478600001)(66556008)(52536014);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?L0xQSTZBWmYzWFVYT1NFdWFZaklkL01xSUkrWE9WRktyS2VrWFJRRERjWncy?=
 =?utf-8?B?Zi9iMk5zM25qWkFsZXFYcmRocHVSUVcrMlFTMm10L05zbDRHWUtEcVJIV2dh?=
 =?utf-8?B?YzlaOVpjMUhnRUI4bU1WblB1NHU1N0NNWFM0RFdjalVGQVNOZlAyZElRcjRz?=
 =?utf-8?B?cVhlczVHY0kxekc0bjdKWEFZdDZRd1pndTNoZDh5ZndoRWJaT0dCV2tseks5?=
 =?utf-8?B?ZnR1YmtWdGZiSzhmUkFyWmNnTlc4Mjl3SG96MkxkWG1nMDZRYktXejNTamFW?=
 =?utf-8?B?bzdwVWI1ZGt2bGd4SHpiOUE2bS9idzhNcTVsMFhEbmphNWsybjRMYUZaYnVk?=
 =?utf-8?B?RlozTjVSaFlxdjRPdzBTTkRIS0x6dTQxcllJVTkyMTNyeUErYVgramM4RW9Q?=
 =?utf-8?B?bEpCZ0ROeWRwdTBaaFl2UDVwbHFNeEo3dldXRG9IVFRmRjRaTkV0c0Z1aVR6?=
 =?utf-8?B?OE0wMHN1NldONzNPaitTdmxPalFxS002NlJYRVA0alJScjI0bU9vblorVDZi?=
 =?utf-8?B?WVpBcFVvdlJyQWl5ZDJyODNNcFNZQUxYY3IzVm1SbU5FNDhGaS81WVgreFYz?=
 =?utf-8?B?ejh1ZC83cVArdlJUdXZvWGt5OHVSVWErSUpvTEF0a3lBMGhMbGhZM2RwL0M2?=
 =?utf-8?B?bWprZDlRWFZrV2Q4Zk9xYkpyZVlQK0pROTBUZ1FXbHFnKytXTlhCV3QyVklR?=
 =?utf-8?B?cEZ3L2FsVklxL04rN1hVYTg2VlNMN0pDNW5HSDNGRXRCNW85SUorR1cxb2w3?=
 =?utf-8?B?RTNUbWxWekpMaW90RVdlMGpYc1Z3Z3Q5ZmwxNkFuSXdvSUFEUGFEZkYva3ZE?=
 =?utf-8?B?UG12TUNoSTVLUlZxT3dVeld0Nno2a0s3M2I1Sk1lamNxR0NiWUVNYUpHZE9j?=
 =?utf-8?B?WWJBQm5rcVJlenFUeFFRMU9kRDZmUkxHU0tZSWxTd2xqWVZMVFlZaHUrQWRr?=
 =?utf-8?B?YktBVVR2UUNxbVFqWjR3STlxMXFqOSt3NzBBNEhVa3BscWVvTHlHT0xwd0Nm?=
 =?utf-8?B?RTlXSVRHREZUS1ZNaTQvdjY2dldmSWdSd2did0ZZSDZjQWYrdkZxcnJpQUhW?=
 =?utf-8?B?S0dXYmJJWDB3Q3puNmRqQXhsNEROQURlL1VYaGs2WWJVL1lqcUNNQ21HRWZ6?=
 =?utf-8?B?QndzVE1OOFJaR1hiaE5sNlMwcnhhUDhnODVMQnBmdkdoMUdBM3lDV2R3eFZv?=
 =?utf-8?B?NlFoRVBnL1NVU1pNTzNsOURVb0VSWXUzdW5SUU4yOGY5enlCYlFxRlJpRTNQ?=
 =?utf-8?B?TkxzNHZOa0JIMEprRWxnS0xWSVRKT3U1MUhjUEpCRUlQcmZicnc4V1ljQlhw?=
 =?utf-8?B?QmtuampRdndScW1jUlVoREV4T01LaEhTQ25BdThZQitCRGg0YldPSTR3Q2FE?=
 =?utf-8?B?QWJPZjRFdGU2ekRoOUE2Q1Z0dXpLcTBJbzNudDUzZlF1bEhBVUVkeUtjLzNW?=
 =?utf-8?B?MkJVd2d6L0hrWjNObklPYnhtUzVnWjhrcGVRWVd4OFNoMElGZytIYmNCQUw4?=
 =?utf-8?B?ZVMyaFp3TlQ1OFRwVGRDN1l2bDFvZCtQdXpJU3BpYVNkQTVIbDRWdWdqclQz?=
 =?utf-8?B?VDB1ZjJ4RVdRZjNlRk1IZllOUUs5TTJxOEFCNS82a1NzZkpUd1JNbzNzOWJq?=
 =?utf-8?B?ZFlTbC83NXdkblh0NEg0RDRzRE9IVVkxa01NSFdpT3FSTUplSis2Sm8rb2dQ?=
 =?utf-8?B?cjVMdTQ4NlM2VG14STd2Q0hBRDZwN0tES1NkYVh6MmlUMGZJZzdGbWFSQVZZ?=
 =?utf-8?Q?pcaGWxg7QPS1tWjWgw=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW3PR11MB4523.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d3e01ee-1a22-470c-e502-08d960d73df6
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Aug 2021 16:59:42.2107
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /ZQHKTfdTWmaOp+I7eKmGb2RkIhUwtRXEefzDzeSCLRl2XZxRog8WsutdBP730ROk6Cc/1ioY3mOy7vhlmuToYSNZwuZxKSLgVGkHplMhqI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR11MB4681
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBBbmR5IFNoZXZjaGVua28gPGFu
ZHkuc2hldmNoZW5rb0BnbWFpbC5jb20+DQo+IFNlbnQ6IFNhdHVyZGF5LCBKdWx5IDMxLCAyMDIx
IDE6NDIgQU0NCj4gVG86IEthbW1lbGEsIEdheWF0cmkgPGdheWF0cmkua2FtbWVsYUBpbnRlbC5j
b20+DQo+IENjOiBQbGF0Zm9ybSBEcml2ZXIgPHBsYXRmb3JtLWRyaXZlci14ODZAdmdlci5rZXJu
ZWwub3JnPjsgTWFyayBHcm9zcw0KPiA8bWdyb3NzQGxpbnV4LmludGVsLmNvbT47IEhhbnMgZGUg
R29lZGUgPGhkZWdvZWRlQHJlZGhhdC5jb20+Ow0KPiBSYWpuZWVzaCBCaGFyZHdhaiA8aXJlbmlj
LnJham5lZXNoQGdtYWlsLmNvbT47IEFuZHkgU2hldmNoZW5rbw0KPiA8YW5kcml5LnNoZXZjaGVu
a29AbGludXguaW50ZWwuY29tPjsgWW91LVNoZW5nIFlhbmcNCj4gPHZpY2Ftby55YW5nQGNhbm9u
aWNhbC5jb20+OyBQYW5kcnV2YWRhLCBTcmluaXZhcw0KPiA8c3Jpbml2YXMucGFuZHJ1dmFkYUBp
bnRlbC5jb20+OyBCb3gsIERhdmlkIEUgPGRhdmlkLmUuYm94QGludGVsLmNvbT47DQo+IFFpbiwg
Q2hhbyA8Y2hhby5xaW5AaW50ZWwuY29tPjsgTGludXggS2VybmVsIE1haWxpbmcgTGlzdCA8bGlu
dXgtDQo+IGtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc+OyBNYXNoaWFoLCBUYW1hciA8dGFtYXIubWFz
aGlhaEBpbnRlbC5jb20+Ow0KPiBHcmVnIEtyb2FoLUhhcnRtYW4gPGdyZWdraEBsaW51eGZvdW5k
YXRpb24ub3JnPjsgUmFqYXQgSmFpbg0KPiA8cmFqYXRqYUBnb29nbGUuY29tPjsgU2h5YW0gU3Vu
ZGFyIFMgSyA8U2h5YW0tc3VuZGFyLlMta0BhbWQuY29tPjsNCj4gQWxleCBEZXVjaGVyIDxBbGV4
YW5kZXIuRGV1Y2hlckBhbWQuY29tPjsgbWxpbW9uY2lAYW1kLmNvbQ0KPiBTdWJqZWN0OiBSZTog
W1BBVENIIHY2IDEvNV0gcGxhdGZvcm0veDg2L2ludGVsOiBpbnRlbF9wbWNfY29yZTogTW92ZQ0K
PiBpbnRlbF9wbWNfY29yZSogZmlsZXMgdG8gcG1jIHN1YmZvbGRlcg0KPiANCj4gT24gU2F0LCBK
dWwgMzEsIDIwMjEgYXQgOToxMCBBTSBHYXlhdHJpIEthbW1lbGENCj4gPGdheWF0cmkua2FtbWVs
YUBpbnRlbC5jb20+IHdyb3RlOg0KPiA+DQo+ID4gQXMgcGFydCBvZiBjb2xsZWN0aW5nIEludGVs
IHg4NiBzcGVjaWZpYyBkcml2ZXJzIGluIHRoZWlyIG93biBmb2xkZXIsDQo+ID4gbW92ZSBpbnRl
bF9wbWNfY29yZSogZmlsZXMgdG8gaXRzIG93biBzdWJmb2xkZXIgdGhlcmUuDQo+IA0KPiAuLi4N
Cj4gDQo+ID4gIC4uLi9wbWMvcGx0ZHJ2LmN9ICAgICAgICAgICAgICAgICAgICAgICAgICAgICB8
ICAwDQo+IA0KPiBJIHdvdWxkIGdvIGZ1cnRoZXIgYW5kIHNwZWxsIGl0IGFzIHBsYXRmb3JtLmMu
DQpIaSBBbmR5LCBzdXJlISBJIGhhdmUgcmVuYW1lZCB0aGUgZmlsZSBhcyBjb3JlX3BsYXRmb3Jt
LmMgaW4gdGhlIG5leHQgdmVyc2lvbiAsIHNvIHRoYXQgaXQgaXMgY29uc2lzdGVudCB3aXRoIHRo
ZSByZXN0IG9mIHRoZSBmaWxlIG5hbWVzIHVuZGVyIGludGVsL3BtYy8gKGNvcmUuYywgY29yZS5o
ICwgY29yZV9wbGF0Zm9ybS5jKQ0KPiANCj4gLi4uDQo+IA0KPiA+IC1GOiAgICAgZHJpdmVycy9w
bGF0Zm9ybS94ODYvaW50ZWxfcG1jX2NvcmUqDQo+ID4gK0Y6ICAgICBkcml2ZXJzL3BsYXRmb3Jt
L3g4Ni9pbnRlbC9wbWMvY29yZSoNCj4gDQo+IFRoaXMgc2VlbXMgaW5jb3JyZWN0Lg0KWWVhaCBJ
IGFncmVlLiBXaXRoIHRoZSBhYm92ZSBjaGFuZ2UgaW4gdGhlIGZpbGVuYW1lIChjb3JlX3BsYXRm
b3JtLmMpLCBJIHRoaW5rLCB0aGlzIGxpbmUgaW4gTUFJTlRBSU5FUlMgd291bGQgbWFrZSBzZW5z
ZS4NCj4gDQo+IC4uLg0KPiANCj4gPiArICAgICAgICAgU3VwcG9ydGVkIGZlYXR1cmVzOg0KPiA+
ICsgICAgICAgICAgICAgICAtIFNMUF9TMF9SRVNJREVOQ1kgY291bnRlcg0KPiA+ICsgICAgICAg
ICAgICAgICAtIFBDSCBJUCBQb3dlciBHYXRpbmcgc3RhdHVzDQo+ID4gKyAgICAgICAgICAgICAg
IC0gTFRSIElnbm9yZSAvIExUUiBTaG93DQo+IA0KPiA+ICsgICAgICAgICAgICAgICAtIE1QSFkv
UExMIGdhdGluZyBzdGF0dXMgKFN1bnJpc2Vwb2ludCBQQ0ggb25seSkNCj4gPiArICAgICAgICAg
ICAgICAgLSBTTFBTMCBEZWJ1ZyByZWdpc3RlcnMgKENhbm5vbmxha2UvSWNlbGFrZSBQQ0gpDQo+
ID4gKyAgICAgICAgICAgICAgIC0gTG93IFBvd2VyIE1vZGUgcmVnaXN0ZXJzIChUaWdlcmxha2Ug
YW5kIGJleW9uZCkNCj4gDQo+IFBlcmhhcHMgeW91IG1heSB1c2UgdGhlIG9wcG9ydHVuaXR5IHRv
IHNwZWxsIGNvZGVuYW1lcyBpbiBhIGJldHRlciB3YXksIGkuZS4NCj4gU3VucmlzZSBQb2ludA0K
PiBDYW5ub24gTGFrZQ0KPiBJY2UgTGFrZQ0KPiBUaWdlciBMYWtlDQo+IA0KPiBhcyBpdCdzIGRv
bmUgYWxtb3N0IGV2ZXJ5d2hlcmUgZWxzZSBpbiB0aGUga2VybmVsLg0KU3VyZSEgSSBoYXZlIG1h
ZGUgY2hhbmdlcyBhcyBwZXIgeW91ciBzdWdnZXN0aW9uLiBUaGFua3MhDQo+IA0KPiAuLi4NCj4g
DQo+ID4gK29iai0kKENPTkZJR19JTlRFTF9QTUNfQ09SRSkgICArPSBpbnRlbF9wbWNfY29yZS5v
DQo+ID4gK2ludGVsX3BtY19jb3JlLW9ianMgICAgICAgICAgICArPSBjb3JlLm8NCj4gDQo+IG9i
anMgc3VmZml4IGlzIG5vdCBmb3Iga2VybmVsIG1vZHVsZXMuDQo+IE1vcmVvdmVyLCA6PSBoYXMg
YSBkaWZmZXJlbmNlIHRvICs9LiBXaHkgaXMgdGhlIGxhdHRlciBpbiB1c2U/DQpZZWFoLCBpdCBp
cyBub3QgbmVlZGVkIGZvciBrZXJuZWwgbW9kdWxlcy4gSSBoYXZlIG1hZGUgY2hhbmdlcyBhY2Nv
cmRpbmdseS4NCj4gDQo+ID4gK29iai0kKENPTkZJR19JTlRFTF9QTUNfQ09SRSkgICArPSBwbHRk
cnYubw0KPiANCj4gVGhpcyB3aWxsIGhhdmUgdGhlIHZlcnkgc2FtZSBpc3N1ZSBhcyB3aXRoIHRo
ZSBjb3JlIG1vZHVsZS4gT24gdG9wIG9mIHRoYXQsDQo+IGRvIHlvdSBuZWVkIGEgc2VwYXJhdGUg
bW9kdWxlIGZvciBpdD8gSWYgc28sIHdoeT8NCkkgbWFkZSBjaGFuZ2VzLCBzbyB0aGF0IHdlIHdv
bid0IGhhdmUgdGhlIHNhbWUgaXNzdWUgYXMgd2l0aCB0aGUgY29yZSBtb2R1bGUuIGNvcmVfcGx0
ZHJ2IGhhcyBhbHdheXMgYmVlbiBtYWRlIGFzIGEgc2VwYXJhdGUgbW9kdWxlLCBBbmR5LiBEbyB5
b3Ugc3VnZ2VzdCB0aGF0IHdlIGRvbid0IG5lZWQgaXQgYXMgYSBzZXBhcmF0ZSBtb2R1bGU/DQo+
IA0KPiAtLQ0KPiBXaXRoIEJlc3QgUmVnYXJkcywNCj4gQW5keSBTaGV2Y2hlbmtvDQo=
