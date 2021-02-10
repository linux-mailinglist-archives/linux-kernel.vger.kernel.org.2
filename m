Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BDC6B316B85
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Feb 2021 17:43:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233104AbhBJQmv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Feb 2021 11:42:51 -0500
Received: from esa12.fujitsucc.c3s2.iphmx.com ([216.71.156.125]:13294 "EHLO
        esa12.fujitsucc.c3s2.iphmx.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232918AbhBJQif (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Feb 2021 11:38:35 -0500
IronPort-SDR: qAV0ZFapijWj8jD8ZCXUZBCmlQZDO6F6AgI2J3e+0GLM64c7/0JCotxICOc4mP7CcyaEKtalVP
 GdOffuoKEdB0afT/8O2rV5Y26Z7bJ6m5pTPt4Y4RyzMZdU5f89Szz82m9RhMXribepZIp/qQ/Y
 HZoPSonFy+iBy7hEWLwCcUVKhxlvQw2ghIFqMPpMH8KBlKv69o8v+dkW4siteQUSSfKadwb+8D
 OsHiM18wheCjIU2UuQKNgI+GXlE5Y9iWB39L1AYQEQWsfmuG3isVmw2AbZC3Ylkeub+xhjTcrJ
 EJM=
X-IronPort-AV: E=McAfee;i="6000,8403,9891"; a="25996934"
X-IronPort-AV: E=Sophos;i="5.81,168,1610377200"; 
   d="scan'208";a="25996934"
Received: from mail-ty1jpn01lp2058.outbound.protection.outlook.com (HELO JPN01-TY1-obe.outbound.protection.outlook.com) ([104.47.93.58])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Feb 2021 01:36:10 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iJti6QVrLdUYXv7QCybagoApNZVKAaouAJwGP/bYAwFkw0I30QDNhDJ7RYi0yL3TobeHaf6ZsXd3FYE6qYTK6/02yYiv5pPdIyzYHkB62vLkOBv3rwS5yAeS3HtYIVo4/4/ZkJazjHO0ld+XTov/ogqHSm8ljF9+C0njU00jm3DrPbSoyC/pseRAy96EtRF3jxc248s+27XXM06gtUTCVgZVi0j0K8sERuQ+QBNNGhoZkqljGDBdvvzbq3017EgFnCW43RRQSDJTJCcUinzTYUIZ4Y/1Z274advOYTA5uvUovPqebDzbZgMZLtU9m3eMQ14AwiPUBn5YoPxTZLCxQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a9lBIe7jJsOV218Ea3u4Co+IxxPLtzM483yPvMTPHjs=;
 b=WAolSXLqa+Dx7e0hZNamC6rxljaHyYY2x1ZV+nWFsTEd8X96okKPM4/3KYAG2xk0peb6/BuqRCgNoiA/CvX45MshaPh4Qb465+00pqv1uXaJW10rMFS8DRgwpgC0yB/Xmp1ZS9nKEoOtzC5R84Igx5yIdM+5/6wrasYKq8mFG+/3YnVtyCN12B1QudY2AjEBm3MCif9LjFNeBGYVggidqOtHVJMKbUlp43c+fvb+z6LoQNejAzUepMORA0gKubM/A7d1OeDm3h2NSSFTFbv4dN/WGRzR/m9GNyHbbOYkDka1MN2YgG3pm623KD7AYFB8odokRyLnbaMfVe6DQaRoxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fujitsu.onmicrosoft.com; s=selector2-fujitsu-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a9lBIe7jJsOV218Ea3u4Co+IxxPLtzM483yPvMTPHjs=;
 b=pB/9uuvZDdDLXO+jxF7gSuH8+8hVU+uhQnEV1SKQA8ECIk3+hV/2K5URa061SYwqMoaJ61V+qdVoVKyXwpDW9VffDHx9nQAwiunSrDLUNVmitw0UZr1AEoayKJ9eRTUoMpesCg95bznS1YvQqiSMJKntzYMHQJRAxqMcrDjp1y0=
Received: from OSBPR01MB4600.jpnprd01.prod.outlook.com (2603:1096:604:7e::12)
 by OSBPR01MB2471.jpnprd01.prod.outlook.com (2603:1096:604:19::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3846.27; Wed, 10 Feb
 2021 16:36:06 +0000
Received: from OSBPR01MB4600.jpnprd01.prod.outlook.com
 ([fe80::340a:689c:36e1:fedd]) by OSBPR01MB4600.jpnprd01.prod.outlook.com
 ([fe80::340a:689c:36e1:fedd%7]) with mapi id 15.20.3825.030; Wed, 10 Feb 2021
 16:36:06 +0000
From:   "nakamura.shun@fujitsu.com" <nakamura.shun@fujitsu.com>
To:     John Garry <john.garry@huawei.com>,
        "'will@kernel.org'" <will@kernel.org>,
        "'mathieu.poirier@linaro.org'" <mathieu.poirier@linaro.org>,
        "'leo.yan@linaro.org'" <leo.yan@linaro.org>,
        "'peterz@infradead.org'" <peterz@infradead.org>,
        "'mingo@redhat.com'" <mingo@redhat.com>,
        "'acme@kernel.org'" <acme@kernel.org>,
        "'mark.rutland@arm.com'" <mark.rutland@arm.com>,
        "'alexander.shishkin@linux.intel.com'" 
        <alexander.shishkin@linux.intel.com>,
        "'jolsa@redhat.com'" <jolsa@redhat.com>,
        "'namhyung@kernel.org'" <namhyung@kernel.org>
CC:     "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>,
        "'linux-arm-kernel@lists.infradead.org'" 
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v5 0/4] perf vendor events: Support PMU events for A64FX
Thread-Topic: [PATCH v5 0/4] perf vendor events: Support PMU events for A64FX
Thread-Index: AQHW+WMHTGeMdPN4T0+BYj0CxDS1qqpFEjAAgADvEKCAA3DPIIAEFEWQgAB3wgCAA4EbUIAAFkuAgAAHqt0=
Date:   Wed, 10 Feb 2021 16:36:06 +0000
Message-ID: <OSBPR01MB46007DDD27AE7A6FA9C7D79FF78D9@OSBPR01MB4600.jpnprd01.prod.outlook.com>
References: <20210202125140.1785583-1-nakamura.shun@jp.fujitsu.com>
 <57c6b89d-e0b2-3df4-8dcf-2cc71f772cb4@huawei.com>
 <OSBPR01MB4600991FC47D2E5A7E013F0CF7B49@OSBPR01MB4600.jpnprd01.prod.outlook.com>
 <OSBPR01MB46007C599F706F3C56B20E64F7B29@OSBPR01MB4600.jpnprd01.prod.outlook.com>
 <OSBPR01MB4600E5D5B5BF038D5A3F8544F78F9@OSBPR01MB4600.jpnprd01.prod.outlook.com>
 <5b507e0e-0887-ee86-4fcd-06567d3f370b@huawei.com>
 <OSBPR01MB46003F3F8106E1AA231084D9F78D9@OSBPR01MB4600.jpnprd01.prod.outlook.com>,<ae8b6d89-5fcd-bff6-6d4d-bb350dca38fe@huawei.com>
In-Reply-To: <ae8b6d89-5fcd-bff6-6d4d-bb350dca38fe@huawei.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: huawei.com; dkim=none (message not signed)
 header.d=none;huawei.com; dmarc=none action=none header.from=fujitsu.com;
x-originating-ip: [218.44.52.176]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 2dfacb60-3b3c-414a-74d3-08d8cde1f6f5
x-ms-traffictypediagnostic: OSBPR01MB2471:
x-microsoft-antispam-prvs: <OSBPR01MB2471CE4137BDB8F7D9175CC8F78D9@OSBPR01MB2471.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 1i90BzlEgTANDt2yiAwMcAaFbV126PL9NRcpo1alxeQmxkjmWDsdDxIRWB+N8B/E098db+srmV1OhL8/IBtAcAdz8Mj2EdcWKDsvByV9S4Gv7iFSKAm61Gz1Z66vpgbR/FCAJGtYnVzQ9Jr9/I8HdF/pfGudvR5hkokgWxrfnUgVgelIvBI/TpoOmg8NKP2AvLklv6NAwypAvH7M4E4Vcy2UCKACDiZQNiIZeBFx4raucq0D8yemKxsHIc5zCTJdXMgaEuCjBeTNImPNim7iSf+10Gjo3MSgqytSycnQdwYFvSCdbenlbuPJaRUsKN72War6nJhYn5EQ6ic+j9yxTHh57cphDQDhH6CG+6oqg3cQmFMigwGU2z9xSHYjy6fFxaCsaavpDpqCipGjW3EKVu/qYQeZxfakvcalzok0PcGSZl9WDgrhz4JVKLmxUnkuileSjCFnvEdegXI+jQtxO6z1z6PKR9/LVIP0eMkIZTj+O0lESSsHC04bYTylXEZ9pwIpOW2bJbQhmYjzsFKBCV+3SwPGWbwpTMrqXxict4n4yMa1wJUhvyUl9+rlC7zlktl4zWD0Q6YauNN+sPLLTbAW9/mudxAKs0qNGfbWB+c=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSBPR01MB4600.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(396003)(136003)(346002)(366004)(376002)(54906003)(110136005)(316002)(71200400001)(9686003)(55016002)(478600001)(4326008)(85182001)(33656002)(2906002)(86362001)(26005)(8936002)(8676002)(921005)(6506007)(186003)(5660300002)(52536014)(66446008)(64756008)(66556008)(76116006)(66476007)(4744005)(66946007)(7416002)(7696005)(777600001)(491001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?iso-2022-jp?B?V3FyWDFwVXg2Um04NzlBZ2Jabm8rNnVkVytDdUhoSlZqR3pqVWw4dTUw?=
 =?iso-2022-jp?B?cFhYM1J1aFFDNW0zOHpkempNdUkzMzF2RnNIRDJsRWhja0pDcDdQQ0NY?=
 =?iso-2022-jp?B?KzB0NWJyMDZob2FFa1JsUWU2RmQrMDM5Ly92UXVSNXppMDFPTGJoQnl3?=
 =?iso-2022-jp?B?VGh6NTcwS2pUWDBlQS91cEpuMTg5ZmdHdDdKRXhFUWVRc2VIWUNsNit1?=
 =?iso-2022-jp?B?NGVwWVAyT0FWdTAzNkw4VmVndWJDUDV5WHhmNmlqRjlHRFI3LzBLb1pO?=
 =?iso-2022-jp?B?ZnM4bGdiSXMzcnQwOXRNNlluMENla2hkYUMzNGRDTXlKY21pU2JHWHo4?=
 =?iso-2022-jp?B?OGlJSEt3YjFjYkdBY2VTcURlVi9qK3RRcnd2ZHc5bDZwVUp5aXB4WVc0?=
 =?iso-2022-jp?B?d3orMWcrQTZhNkVZa0pKamordHZmbHRJbWR3Ylh1ZnJCNml1MGY1dnJM?=
 =?iso-2022-jp?B?NlpxeTJRK1ZDMWNiczZsdlJXbk5SN1FVOUhNeWNPZHNFMUhxWndVWVpo?=
 =?iso-2022-jp?B?T1pmRzZ6cnJ0NFRKejFxRkp3TzdkTGwxeDY4SkhaOWYrNlMzai9rUldE?=
 =?iso-2022-jp?B?ZVJZM082K2F3STBHWUM3UW5OcGRkeTJXclgySUIrVmJCeFhGOEdKWmV6?=
 =?iso-2022-jp?B?bmJjWjllYllUcFNtckV6bjdUNnk0T1pqcTZZQ2RXbkRoQW1rOE9yaEhj?=
 =?iso-2022-jp?B?UFREd3lQQ0JmUS9JTkdQdk1ZOFJMV1FodldaSHg3d2JNbjBnaVRUekl1?=
 =?iso-2022-jp?B?ZnZLckRVUVNPM25tRnA3YmhocmM1NTljQ2V3Y0V4cUl4NGJSSnArUjhp?=
 =?iso-2022-jp?B?MkhNTXh3TEIwRkk1K3I2M2s1cHZIRVVFZXFmejczM0t3T0RJbmQ3L2Fj?=
 =?iso-2022-jp?B?WWRtNHVNbENXQ0hneEpTN2k5Q2ZOeW8xRTBzaXBrWGs2SHZ2eXJVODdT?=
 =?iso-2022-jp?B?L0xaaTNPZGUrWEtRV3JxWWswcFF0M3V0ZHNYNmpob2F2UnIrNEhNb2xV?=
 =?iso-2022-jp?B?VUtqQzZUUTJuZjhrdUhOQXpndHdGNDVFMXR2aHRQcytBcTNPYlBVMEZj?=
 =?iso-2022-jp?B?UjRJNXFwMWs4eFpQeFFNSnNYbmhFSXVXb3BsREtWL1lpbEk4cmxWTFFK?=
 =?iso-2022-jp?B?SThjaEFaTjRWRnVzKzN2NHVMU2plZnNacktYWXhkQkhnLzd4eEZlN3Ev?=
 =?iso-2022-jp?B?ZTA2OFhzWkFRUWZ4emN1cnpBRkw0OWJQMW1wK2FEL0wvVVlhRkZLMlRk?=
 =?iso-2022-jp?B?OGthRW1aNkVHZElJVkxrMTJKb1NGTkdnNXVhbEpDalh0alZ1NC9ncDFT?=
 =?iso-2022-jp?B?SVpWOHpCVWUyeHNUNWtPc20zMWhOUU5IeGxpVGtWTHlFRzNZUFZSeFhF?=
 =?iso-2022-jp?B?SUl5aXJWTjE3ZXc2bWJkMUNtY3ErUXdyR1hybUpxTUZxTU9oMktXNHVF?=
 =?iso-2022-jp?B?RFBBU3RTalQwcEpMd0x1RGdrcmFEZjJLNVIrV2ZCK3BDa2dQbzdCQzZq?=
 =?iso-2022-jp?B?UXpyMkNhcXRucExlY3ZySjNRb3FHbW5xZjFiSWNEc0JoQWQ4ZzdodzJr?=
 =?iso-2022-jp?B?MTdGOXN3WDZlZllqemVHRWMveC9DbXZjQStlcUF5dm8xWUxnNU9GbkZG?=
 =?iso-2022-jp?B?UFQ5aCtEZXBsVTAzNklqU2RBd29BN0I3d2J3amJFYkl4ZjRTazdPNzUr?=
 =?iso-2022-jp?B?akhpRTZsZTJqTEFpRTNIN2pPK1RKRGUvT01zWXc0RHdkMUhKSncwUUgy?=
 =?iso-2022-jp?B?YkRZOGdPUTcyVHdrTExnaXBiQTgxMkREaUFYUGg2WmxvdHlZaUhJLzVD?=
 =?iso-2022-jp?B?S1Vabm5SUWhNOHVsMnZrU05CR0VKYUtBeWYxdHFNL1ZWRitNQkxCc1N4?=
 =?iso-2022-jp?B?YkVoVXd3R2dvZzFIK1NCK2d5dEl3PQ==?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSBPR01MB4600.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2dfacb60-3b3c-414a-74d3-08d8cde1f6f5
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Feb 2021 16:36:06.6942
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fcQsJR+ad1ho355wzTsLfsRdoehN9M9sf1ek3jjhePE5cF3rJeBeYabZ+AQtxMF3BcslfXdrVbeBuYDmrML8bK5HmrLfuMFuYLNi4tJK4AE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSBPR01MB2471
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, John=0A=
=0A=
>> I will resend based on tmp.perf/core.=0A=
>=0A=
> Actually it is now on perf/core, so that is a better baseline.=0A=
I will resend based on perf/core.=0A=
=0A=
> > I will send it in HTML format.=0A=
> =0A=
> Hmmm, that's not better. I think that the mail servers reject html.=0A=
> =0A=
> Please consult Documentation/process/email-clients.rst=0A=
Thanks for the info.=0A=
=0A=
Best Regards=0A=
Shunsuke=0A=
