Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A41343941AD
	for <lists+linux-kernel@lfdr.de>; Fri, 28 May 2021 13:13:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230163AbhE1LOv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 May 2021 07:14:51 -0400
Received: from alln-iport-2.cisco.com ([173.37.142.89]:61607 "EHLO
        alln-iport-2.cisco.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229909AbhE1LOs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 May 2021 07:14:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=cisco.com; i=@cisco.com; l=1536; q=dns/txt; s=iport;
  t=1622200394; x=1623409994;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=0XeX0Qmgzr4TssGuyruKAUaSlRbm56HIfgdWeOzsfZA=;
  b=hp0KLicK2OYho1v5ouucdXpGT6hij85zX73Vje005too/1pC33q2+87s
   4J3G/lmEU/sIl/Y9cIyYYHwDYrVglr1pHSQosa0qwZhhaEbFA/aKBmlPl
   VWsxd24gMfjGt5YjTFMOj1lvLW0E+mdaoAWrvVWoIt1SMv+7C2G0sahdW
   Q=;
X-IPAS-Result: =?us-ascii?q?A0AYAADsz7Bgl4wNJK1aHAEBAQEBAQcBARIBAQQEAQFAg?=
 =?us-ascii?q?UMHAQELAYFSUX5aNzELhD2DSAOEWWCIdpoMgS6BJQNUCwEBAQ0BAS0SAgQBA?=
 =?us-ascii?q?YRQAheBZwIlNAkOAgQBAQEBAwIDAQEBAQUBAQUBAQECAQYEFAEBAQEBAQEBa?=
 =?us-ascii?q?IVoDYZFAQEDARIREQwBATcBBAsCAQgaAiYCAgIwFRACBA4NGoJPAYJVAw4hA?=
 =?us-ascii?q?ZtGAYE6AoofeoEygQGCBwEBBgQEhWoYgjEJgRAqAYJ6hA6GXyccgUlEgViCK?=
 =?us-ascii?q?TY+hEaDFTaCLoUFkk8bgwNCi2abOAojgnaKDZNzEYUgoDS5ZgICAgIEBQIOA?=
 =?us-ascii?q?QEGgVQ5gVtwFYMkCUcXAg6OHxmDV4Zxg21zOAIGAQkBAQMJfIlKATJeAQE?=
IronPort-PHdr: A9a23:Bk8xrhX2hfYRq/81ajNrJ2uC86bV8K3iAWYlg6HPw5pNf76l8pCkO
 1bQtr1hj17MCIPc7f8My+/bqLvpVmFI55Gd+GsDf5pBW15g640WkgUsDdTDBRj9K/jnPC83B
 sJPUBli5X7oeURQEdz1MlvVpHD65DUOGxL5YAxyIOm9GoPbg8mtke6o/JiGaARTjz37arR3f
 32L
IronPort-HdrOrdr: A9a23:hSqLyqp5QtuGMLacx9b6TRQaV5v+L9V00zEX/kB9WHVpm5Oj9v
 xGzc506farslkssSkb6K+90KnpewK6yXcH2/huAV7EZnimhILIFvAt0WKG+V3d8kLFh5VgPM
 tbAs1D4ZjLfCRHZKXBkUmF+rQbsaO6GcmT7I+0pRoAPGIaCZ2IrT0JdzpzeXcGIjWucKBJbK
 Z0kfA33gZIF05nCviTNz0gZazuttfLnJXpbVotHBg88jSDijuu9frTDwWY9g12aUIN/Z4StU
 z+1yDp7KSqtP+2jjXG0XXI0phQkNz9jvNeGc23jNQPIDmEsHfrWG0hYczGgNkGmpDp1L8Yqq
 iLn/7mBbUr15rlRBDwnfIq4Xi57N9h0Q649bbSuwqTnSWwfkNLNyMGv/MCTvMcgHBQ4O2VF8
 lwrj+kXtNsfGD9tTW46N7SWx5wkE2o5XIkjO4IlnRaFZATcblLsOUkjQ5o+bo7bWnHAbocYa
 NT5QDnlYBrmFihHjzkV6lUsZSRt1EIb1i7q2Q5y7ioOglt7TlEJhEjtbkid187heUAord/lp
 b5Dpg=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.83,229,1616457600"; 
   d="scan'208";a="725935765"
Received: from alln-core-7.cisco.com ([173.36.13.140])
  by alln-iport-2.cisco.com with ESMTP/TLS/DHE-RSA-SEED-SHA; 28 May 2021 11:13:13 +0000
Received: from mail.cisco.com (xbe-aln-001.cisco.com [173.36.7.16])
        by alln-core-7.cisco.com (8.15.2/8.15.2) with ESMTPS id 14SBDD66022645
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=FAIL);
        Fri, 28 May 2021 11:13:13 GMT
Received: from xhs-rtp-002.cisco.com (64.101.210.229) by xbe-aln-001.cisco.com
 (173.36.7.16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.792.15; Fri, 28 May
 2021 06:13:12 -0500
Received: from xfe-aln-003.cisco.com (173.37.135.123) by xhs-rtp-002.cisco.com
 (64.101.210.229) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Fri, 28
 May 2021 07:13:12 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (173.37.151.57)
 by xfe-aln-003.cisco.com (173.37.135.123) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.792.15
 via Frontend Transport; Fri, 28 May 2021 06:13:12 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kZDVCCBM6mFGHyybSBLNXMn+4o5eXfWp1t/vtIKI/WELmWWR1cm56kVutgLEpYAkONdpGCNs7fwQyVnmnijcbm3FxGUIaApUJb2Kio5kY3ZNGL9gdnE+cQeRj2zB/J3c++JpetUwWVth987IC1bKSuvO4HBrcrcsg4Z0yewZZqdXZ9+ATiR4mUZpxN5MtUVZ061xU5NxtCyr1CdCXMF1UwrHkfrGRaXUyRPyLrW4ARQ8WvdhMb+iJSyNI8hmYdO4gsOq2hPtAennz2lMxKtG5+6lFmb0LYfH8scTDcMtX/qt1MZLfv9Clj60oSHQ7w6h40B6mxn1WmCDOfsNHlTdiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0XeX0Qmgzr4TssGuyruKAUaSlRbm56HIfgdWeOzsfZA=;
 b=IUlTOCLinnvORmrtoNqMuMWVWMO9kTFU/AOa8i+UF28D7mBGZhAl82NpCvM1SoN7T9DUK8CfFOGktaRl+ttT4R6HRuo95VUt0bzuGrWHKyONnBkXDyxL3et3MBkEnu099Re/vslcpjyrXXYWbm8IT0Aw4PXF/73Y+Y2DJ3gNsqiWzyPLNqv2bP+6DbtUwddq2shKbuYw3B0H1tJw6xkc5JUehBP5U8Jw0DE65gecEIGTrUp20vqIY2W2Efs/gKvlAFieJKGaZY4o70tJIBlB5WWl8+cDvLJ2P2xn1ejojLj6UHPUv0CYGu56yKUQRXC8Dc7TJVCbZtknHUOl1GXWEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cisco.com; dmarc=pass action=none header.from=cisco.com;
 dkim=pass header.d=cisco.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cisco.onmicrosoft.com;
 s=selector2-cisco-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0XeX0Qmgzr4TssGuyruKAUaSlRbm56HIfgdWeOzsfZA=;
 b=haTb/QUr8Pnho2K2DbUUBu1ddW7pCThPYne/ErCswEE3Wuu0prGnymZxxvh7UPjJfs/M118kDCSKfKPKAoukzPl0ysWh3c0CZa+OyGRsACS3KZMXg02SDiBkvaBovQNqz4wG6I8Q68PUFheqzXOnsxNvJ4//21JbbklgGuqrwAA=
Received: from BY5PR11MB4024.namprd11.prod.outlook.com (2603:10b6:a03:192::24)
 by BYAPR11MB3366.namprd11.prod.outlook.com (2603:10b6:a03:7f::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4150.23; Fri, 28 May
 2021 11:13:09 +0000
Received: from BY5PR11MB4024.namprd11.prod.outlook.com
 ([fe80::9553:3e54:a296:63de]) by BY5PR11MB4024.namprd11.prod.outlook.com
 ([fe80::9553:3e54:a296:63de%6]) with mapi id 15.20.4173.024; Fri, 28 May 2021
 11:13:09 +0000
From:   "Denys Zagorui -X (dzagorui - GLOBALLOGIC INC at Cisco)" 
        <dzagorui@cisco.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
CC:     "jolsa@redhat.com" <jolsa@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "alexander.shishkin@linux.intel.com" 
        <alexander.shishkin@linux.intel.com>,
        "namhyung@kernel.org" <namhyung@kernel.org>
Subject: Re: [PATCH v8 2/3] perf tests: avoid storing an absolute path in perf
 binary
Thread-Topic: [PATCH v8 2/3] perf tests: avoid storing an absolute path in
 perf binary
Thread-Index: AQHXUxjyBwRNp6Ucb0yKJ0SmghZGi6r4so0x
Date:   Fri, 28 May 2021 11:13:09 +0000
Message-ID: <BY5PR11MB40243EB953DC674006115729D9229@BY5PR11MB4024.namprd11.prod.outlook.com>
References: <20210524111514.65713-1-dzagorui@cisco.com>
 <20210524111514.65713-2-dzagorui@cisco.com>,<YK/OpLStd2zPdHS9@kernel.org>
In-Reply-To: <YK/OpLStd2zPdHS9@kernel.org>
Accept-Language: en-GB, en-US
Content-Language: en-GB
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=cisco.com;
x-originating-ip: [173.38.209.9]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 2aa27370-0423-4d69-4e9d-08d921c9935d
x-ms-traffictypediagnostic: BYAPR11MB3366:
x-microsoft-antispam-prvs: <BYAPR11MB336635084B1445D6D2501FF9D9229@BYAPR11MB3366.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: wEGeryFUZqPBzcG7kjY8inysd8fIJikkQ2HAJDjmJo9ZaupzbkqS5t1DJ+4xq3ABI/5TNXyGvEJlRAl6DB5pIg2nNvIYolfdZPvH44zwIma584rLT1cOCIcrivIuOoiiU+fQ3RTrokoSEtfP9VYWokMVMM9fkKa1Q2fHA2GDriIloLq3B6EIU8MpcuxUSFe4dxol/Vgml2INPo5xeE7tBUvYJ+Zw6CTSYOVO/XRn25B8k/e8Z12k3jSf6nGdzDGcVYagtSQpU8Inu/40E8rLLEn10PYJ13wmgbCy6N10eqIcKXLbnZ6naRp9S8U3ehi4LuymRz1O/TGZwKzMVleITCGxIJ3MPeKk6Vfdd7FJy1wEQXOb2CwkQlGui1qjSrULZhocsZPrmX11k/kYuWxLWQubz4uZIBE7lawRBk/DXxx1qOmpJrbJedg0t8YjgVCXmag3oCdwmGbUWY7/U1T2FBmnAk+lwtynAz3fJFRbRgf/qCRKqHGOrqcRaztbiQzAlqTHfr7V/pBdHqjFDSugmoRDWQi3cxYhJ5Suvmn1l+1LiNre69RNdu84XbVi3T3wwf18cCxLhXdZ10K1NAAy21g7nYoyOL8AoRTFmEV5Y30=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR11MB4024.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(346002)(376002)(396003)(39860400002)(136003)(366004)(186003)(86362001)(83380400001)(5660300002)(316002)(6506007)(7696005)(54906003)(6916009)(66946007)(66476007)(2906002)(71200400001)(8676002)(122000001)(76116006)(66556008)(33656002)(91956017)(55016002)(66446008)(64756008)(26005)(9686003)(52536014)(478600001)(4326008)(38100700002)(8936002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?utf-8?B?dlZianZEYlFySllCbEVlU0xqRHNTRFNYc3V6SlVQT2I4aG1WQ0MyaHJ3WXlQ?=
 =?utf-8?B?Z3ljTjg3eGJzdm9ldUREaU9YU0lBYzVtT3dOUE9CaGhjbDR5elA0UExYM0h0?=
 =?utf-8?B?T3FFV3dFVXBaNzF3Q1RUVm1hZlZnMjBRSzBLdkc4b0p0cHhNWTZNamhNOHRr?=
 =?utf-8?B?ZWdHUi80LzB5V1FPNkZ2Sm1IS0ZlaWpERklRRXR4M0ZMRGVqN0JiTFM5NitP?=
 =?utf-8?B?Ump0Nks4anpETkhITzcvNm82aDZVQXVkKzVHdGtBK0FiVERCME1LdmdyeTBh?=
 =?utf-8?B?by8wWEcrY2Rub2JVRWhjdTlhd1ZoQnhOaVFmREFoSldyZ1NJVjR1a3A0bzE5?=
 =?utf-8?B?OXdIY0NDdyt3emJnYlpzeC9Ja1hDUFNOdlVzS0ozM1lGMHdJdG1MbTcvUlVR?=
 =?utf-8?B?MFFER2xJcWhjV29TMlYzTGNjcjljYlZLa3JmU05VaVdBMmhLMzV2ZllGVGpF?=
 =?utf-8?B?RlZuQ29VR3ZHZkdYMVdndFMyZWh5YndNeGNNN1Y1VWNYNCtqWXcwbitCVEFR?=
 =?utf-8?B?bTBBT0pLS3hwVVVydzZISWpPNGZHSWo5Z0JYMFB2azdlSmJXRHBGQm5xQ1Jo?=
 =?utf-8?B?NlVQcmYxb21pNFFQRGJSMy96S2svNHBWc3dNY3pwQTVUNE43MU01YzRvUkI1?=
 =?utf-8?B?bnBKSlFRcSt2ZEZFbXZETzYrbTNINEVwMURSUUYrUVR4R3FiZTU3OXRXUjVs?=
 =?utf-8?B?NHJTYThrWitHZWpKZFkySTduQmtieFBIb0RFRU15MFF0djgzb2w4WlNGSnF5?=
 =?utf-8?B?ZExobjdteXdsYkhmZFMwbFhLb1ZsVU5icEhyaVVZWmN6NXV5MkZlVFlUMFVj?=
 =?utf-8?B?UjNwT3pqTXNGZnUwN1FadXVPR29kSDE4RElVSWVGOGhRMmNuYytDVXliSUdQ?=
 =?utf-8?B?R2ZJNmgvYUQ5MC9VNmEra0dObmZZRkJJcXFiWTRXZGR6UEJISzhhenlVTncw?=
 =?utf-8?B?elhZbnJpOWc5eUNxN2VKYWhURjBnSUpDQ25mVUtHdU5JUnZxaUJtNm9hQmhu?=
 =?utf-8?B?Y014M3JyL2J1SkpMUGcrSTlyZGpFSnlCcmwveEEwNHJEdnpCRlFzMTl1b3RZ?=
 =?utf-8?B?eHhBK1ZmdDNMZVorR0ZrNk5WL05uTVRYTGc5Y2hlK1RvTkd1MXV4QTdld3Bh?=
 =?utf-8?B?anJQcGZjaWxhNEZWTldtYUxPbTJqZFpaVmw4MHlSZzZYajJ3MFN2eFZnbnZs?=
 =?utf-8?B?M3YyaFJ1QklGTlVrM1FUWWVobnVXWHE2NUVmN1JJcmdpUGhOTWRObFNHV3Zq?=
 =?utf-8?B?YWN1WUg5cGtFcXd3Rmd5NytCM09mUHhXSHFQcjF0Rm5jSzhlRFFtOEdHRDZO?=
 =?utf-8?B?MUdMblJyL1hKdk1EQXhiQ1pmNXYvZDBMTTBjcGlWemMwaEtKN2RDT1pXZGVF?=
 =?utf-8?B?Z2pXNFQyTVRaZHl0OTVTUTZ2M3hyMXZ0My91YkplK3pNeStGMGJCZSs3Y3Zp?=
 =?utf-8?B?NnFoSHNvYld5YStaMnpsZm44RUtEczU1dUhCY1FZVHhhaHcyV0tLczlsMEFK?=
 =?utf-8?B?SDh1SSt6WWhhRkt6YUZiMTgrczZSVVU2Z2RJcjBobFlqdi9MOGxpcXBWWWx4?=
 =?utf-8?B?M2xtbzVybjNranA2YjN2b2FGNER0WkJWYTVzSDN0UkxpVTFpcVExakZBaXVt?=
 =?utf-8?B?ejZENVhqRWhsMXp0QjFEaDRJZEYxMHRFU2FmZlgvRWtoUVdKRVhLSWtMcThL?=
 =?utf-8?B?eWtjU0tlRHBqZVJmcEpYaHRnaUFFTDgvUW9lcXV1d3E0OG9nUmFoU3RucEZ2?=
 =?utf-8?Q?SS9JnHAETKcUceHV5Q=3D?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR11MB4024.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2aa27370-0423-4d69-4e9d-08d921c9935d
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 May 2021 11:13:09.2725
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5ae1af62-9505-4097-a69a-c1553ef7840e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ENUX/Aap/qwUyRRICb18r68z+tibIfxyeDOgeUpIAzqCpEwNmLK91wUBmvvVJCBeLQrRQVww+bMOQ2NZX2qfSA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR11MB3366
X-OriginatorOrg: cisco.com
X-Outbound-SMTP-Client: 173.36.7.16, xbe-aln-001.cisco.com
X-Outbound-Node: alln-core-7.cisco.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Cj4gSSBub3RpY2VkIHRoaXMgaXMgZmFpbGluZyB0aGUgdGVzdCwgbm90aGluZyBpcyBiZWluZyBh
cHBlbmRlZC4gSSdsbAo+IGludmVzdGlnYXRlIGxhdGVyLiBDYW4geW91IHRyeSB0byByZXByb2R1
Y2UgdGhpcz8gSSBidWlsZCBwZXJmIHdpdGg6CgpNYXliZSB0aGlzIHRlc3Qgc2hvdWxkIGZhaWwu
IFBhdGggaXMgYmVpbmcgYXBwZW5kZWQgb25seSBpZiBwZXJmIGlzIGludm9rZWQgZnJvbSB0aGUg
YnVpbGQgZGlyZWN0b3J5IChiYXNpY2FsbHkgaWYgdGhlcmUgaXMgcHl0aG9uIGRpciBuZWFyIHBl
cmYgYmluYXJ5CnRoaXMgcGF0aCB3aWxsIGJlIGFkZGVkIHRvIHN5cy5wYXRoKQpJJ20gbm90IHN1
cmUgaWYgaW5zdGFsbC1iaW4gdGFzayBpbnN0YWxscyBwZXJmLnNvIHRvIHN5c3RlbSBpIG1lYW4g
YmVmb3JlIHRoaXMgcGF0Y2ggcHl0aG9uIGJpbmFyeSBjb250YWlucyBhbiBhYnNvbHV0ZSBwYXRo
IHRvIGl0cyBidWlsZCBkaXJlY3RvcnkKYW5kIGlmIHRoaXMgYnVpbGQgZGlyIGlzIGRlbGV0ZWQg
dGhpcyB0ZXN0IGFsc28gd2lsbCBmYWlsLgpNYXliZSB3ZSBzaG91bGQgdXNlIGV4cG9ydCBQWVRI
T05QQVRIPTxidWlsZCBkaXI+L3B5dGhvbiBmb3Igc3VjaCB0ZXN0CgpUaGFua3MsCkRlbnlzCgo+
IGFsaWFzIG09J3BlcmYgc3RhdCAtZSBjeWNsZXM6dSxpbnN0cnVjdGlvbnM6dSBtYWtlIC1rIENP
UkVTSUdIVD0xIEJVSUxEX0JQRl9TS0VMPTEgUFlUSE9OPXB5dGhvbjMgTz0vdG1wL2J1aWxkL3Bl
cmYgLUMgdG9vbHMvcGVyZiBpbnN0YWxsLWJpbiAmJiBwZXJmIHRlc3QgcHl0aG9uJwo+IAo+Cj4g
4qyiW2FjbWVAdG9vbGJveCBwZXJmXSQgcGVyZiB0ZXN0IHB5dGhvbgo+IDE5OiAnaW1wb3J0IHBl
cmYnIGluIHB5dGhvbiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgOiBG
QUlMRUQhCj4g4qyiW2FjbWVAdG9vbGJveCBwZXJmXSQgcGVyZiB0ZXN0IC12IHB5dGhvbgo+IENv
dWxkbid0IGJ1bXAgcmxpbWl0KE1FTUxPQ0spLCBmYWlsdXJlcyBtYXkgdGFrZSBwbGFjZSB3aGVu
IGNyZWF0aW5nIEJQRiBtYXBzLCBldGMKPiAxOTogJ2ltcG9ydCBwZXJmJyBpbiBweXRob24gICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIDoK
