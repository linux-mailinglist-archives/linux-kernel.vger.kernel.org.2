Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D182738FD35
	for <lists+linux-kernel@lfdr.de>; Tue, 25 May 2021 10:53:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232190AbhEYIy0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 May 2021 04:54:26 -0400
Received: from esa1.fujitsucc.c3s2.iphmx.com ([68.232.152.245]:57174 "EHLO
        esa1.fujitsucc.c3s2.iphmx.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230459AbhEYIyZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 May 2021 04:54:25 -0400
X-Greylist: delayed 427 seconds by postgrey-1.27 at vger.kernel.org; Tue, 25 May 2021 04:54:24 EDT
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1621932776; x=1653468776;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=cs+LKuz+pwQAtGuPaNic5f2kyjKIm59PvibmG4Qgerk=;
  b=wdb4lajwD9hby1Q0Ux2Apf3RzoDCdt8h8FFi2DWouQXArt+BHpy3F+wO
   MPIeanvfBP2C588tAK9D9+PUWJLWhRRZp7jK7WUh7Wj2Md5S9B6utkw62
   2zyh9fCLFqoZlrVvySd/mke/qdGUUu09mJhk20GNKvqdqDY9C/MgmaYm6
   nPSy9w0qa+cNr01SzSOt2X53AZKAafeo3tZ9LFFHM74qGq3I/tivkaSmX
   /HoyqlUd9UUPz2aPe++MhkyzSMdgNumBHMKW99xMh8OG1yqTLC564lR1Z
   Oaf9B0NEcSOCwTTJf2UItg4v9sM9pFImQLCU2dAKd85GZLI9pvQieqNhj
   Q==;
IronPort-SDR: KLPniHgDcZDAEEQC+2y/SjlXjS5LNTEepQhYVuMqJu3F/TP7El441nNvd4jfWATagmip4Byv90
 Efuw3THkI1I5Bhk3cK9pLgv2Sq8CRUSvQyIkFW/s5M15rXvvirRJ9x9B+d4gc5iV2vFzap18Lp
 GaelakXUlYRUabWm5dd3bwzqDbIsn4DYhK/IN68dL98fZD2cyCKfiFahVJQA6CL4G5Bx/Tfbp6
 xwYnK7Qh0WlmheOJUsYhm0oshi14BdcQgBGOcazWVjEUVx9b1XHKoeB0pNmuTMVpL7KvdCMN0x
 dCg=
X-IronPort-AV: E=McAfee;i="6200,9189,9994"; a="40065357"
X-IronPort-AV: E=Sophos;i="5.82,328,1613401200"; 
   d="scan'208";a="40065357"
Received: from mail-pu1apc01lp2054.outbound.protection.outlook.com (HELO APC01-PU1-obe.outbound.protection.outlook.com) ([104.47.126.54])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 May 2021 17:45:45 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NjbDzzy9qhGjmF8v5NSqgtckHAo3Ul7VpOCXQFDzjYzHhMT18x8FDT+Yd4jHtART94GR5CgwvN297WJZV0Y/lcNLnrziNtAtRVU/AJ5zieD+60T9nhh8tT/1gek1jeXK7kPEFjYLqbKCLeBkV+OOpE0T1VyXlKgEKlvtYlvYG8O0VIdDHz2/ilVI5nrvd4Ok0b2YVlJwsmA3nzDf9JsIGhWjoe5757H76jG2xj042O8ulkXUgq3e79NfvtDpo0HVOHBMDR43OseJEfKBd0y0okGDKLBaiypOzTcZRFFZMK2ColBvg7lh30+dnfcWS7ejlpN+OolOoWOBAhAeBxYugQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ri6j7YnS7mvsPULseopg2Bz/Kjxvy1N3yXdmoR/Q53c=;
 b=V62b7mv9s/ReqmL0PzFuRipssfriKL7dzu2FQBg4wjifoX44yqqNHI1HAyNzcBUDCbA001fT4eqHt6jhKQaRB8tK5kNZAqupYDuugfaolsA9F4HnE4gg1JCWiTpuEf5PqaVytTYVvsaNbVyINI8TOlNFzRwP+e2gqxD0ieeFL7AcGzD6nUzU43VQdw9kXxSKoMBahTaC/gFTVDVB4ToraIjoiAAVzRps1hZTx64fTo/4pikubD6iMsghsRh11t10UuPLFgnjM/jZwTenftphsCTKS+92EYmhuhySaztdHp+25IH1RtIE9TgAv6h5ArzARKP5tXg7M6Aot9zNwW+xuA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fujitsu.onmicrosoft.com; s=selector2-fujitsu-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ri6j7YnS7mvsPULseopg2Bz/Kjxvy1N3yXdmoR/Q53c=;
 b=edQwI6CSqeWsqq4wBhHa+fdY0rhN/NhQ8PRgi9BocGdASHi8MvzZHP/1iGiauzRLOtfITdPEBuOa0R3bfZ9E/DjBPEmEP+zeKTCaptpjQ0sdL1sDpqUwUvFHzcTwSk74ZFfkfhVT8/nH7weEQCBK50B9pzAEQvrfV92SxuiZqxM=
Received: from TYAPR01MB6330.jpnprd01.prod.outlook.com (2603:1096:402:3e::12)
 by TY2PR01MB4649.jpnprd01.prod.outlook.com (2603:1096:404:111::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4150.23; Tue, 25 May
 2021 08:45:42 +0000
Received: from TYAPR01MB6330.jpnprd01.prod.outlook.com
 ([fe80::d496:4343:e4e6:c49b]) by TYAPR01MB6330.jpnprd01.prod.outlook.com
 ([fe80::d496:4343:e4e6:c49b%5]) with mapi id 15.20.4150.027; Tue, 25 May 2021
 08:45:42 +0000
From:   "tan.shaopeng@fujitsu.com" <tan.shaopeng@fujitsu.com>
To:     'Reinette Chatre' <reinette.chatre@intel.com>,
        "'fenghua.yu@intel.com'" <fenghua.yu@intel.com>
CC:     "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>,
        "'linux-arm-kernel@lists.infradead.org'" 
        <linux-arm-kernel@lists.infradead.org>,
        'James Morse' <james.morse@arm.com>,
        "misono.tomohiro@fujitsu.com" <misono.tomohiro@fujitsu.com>,
        "Luck, Tony" <tony.luck@intel.com>
Subject: RE: About add an A64FX cache control function into resctrl
Thread-Topic: About add an A64FX cache control function into resctrl
Thread-Index: AdctARUohIvM7pb1S52qTlM+pjp6RAJht/AAABE+WYABTmUCMABGH4GAA3M648AA3z+sgAC1LKkQ
Date:   Tue, 25 May 2021 08:45:42 +0000
Message-ID: <TYAPR01MB6330758A49FECF90B5290C768B259@TYAPR01MB6330.jpnprd01.prod.outlook.com>
References: <OSAPR01MB214600C7923AEF7C35B02E648B739@OSAPR01MB2146.jpnprd01.prod.outlook.com>
 <OSAPR01MB214657641D532FB8D112DD528B479@OSAPR01MB2146.jpnprd01.prod.outlook.com>
 <bb0967c0-5b88-c6c2-0242-1e3928189a04@intel.com>
 <OSAPR01MB2146D42FC04779268BA231878B409@OSAPR01MB2146.jpnprd01.prod.outlook.com>
 <14ddf86b-89e1-ba26-b684-f3d5d5f8ade7@intel.com>
 <TYAPR01MB633071CD547B0AAF818520E48B2D9@TYAPR01MB6330.jpnprd01.prod.outlook.com>
 <f53b9bfd-0d55-4cf2-fabb-82b3ec86e52a@intel.com>
In-Reply-To: <f53b9bfd-0d55-4cf2-fabb-82b3ec86e52a@intel.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: intel.com; dkim=none (message not signed)
 header.d=none;intel.com; dmarc=none action=none header.from=fujitsu.com;
x-originating-ip: [210.162.30.49]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 347ab921-5302-4712-f9fd-08d91f597ac9
x-ms-traffictypediagnostic: TY2PR01MB4649:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <TY2PR01MB4649E4F9827DF78385DF1CBD8B259@TY2PR01MB4649.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: UY7EkZp6TyJSod6J6S5K9cVMTIRvVS0e2sBQy9yibTa89w6o8ge8C7cLlNLviF+iHFNd6D/3EpMPOw2rq94enx0GbMRDd1e49e5jcFXI//QF2PJjRiLxhwK8ZjHgs3jp1c5c/ugluM0CZfdZF8rgpfH4J8iIXux05zeAwsYcjjCaoxgb3pvd2A6xdFmPQvCKdojGoqHnaQsKzv8856GaJaAaIRgb9lknoafTW8JYCT/OD4YRyLNasHGbcDtmOOGEULCXnBh4Hs7yMj1GC3/naL4sX5xEA35ewrpKFldBar/KvIWu+OmKu+CLcQYTjbuIDrh8jpf4GuswdDOkdawq/UqorqzgbV1j/JAMJohYLSNySUGIPUO5rcOZma9bYsHxLm4mx4BfDbj/1SZDoT07Kehy0R5xFeo0pP2L/LphwwmOYA9YfWzvXzYH8fN4DKeE3MUTOxYnNN1p/KcZu6B1Cnmn6D5AAoZ0RHORi5nkfWek7DfDW3ToUDg2RkOxjOXdFS0U5Hsl/dUhbP6I/vFjQ/JfwGjTe4bnvA1LSsoXuCYkIguTapMLtCFc1uMtQmtJQtmWtptt1LU9fPz5MYYYOcWmHxncON2FBarzU0vgKIGILnRGKIinP1/sInJQbL9ihkUdK5S8l4oYdU5vZ+8PMwrbGY4pvWySMiaK6V3ZHzA3oIarkojw2T/wHCik9LSRPGkeYB2Hkg6rmJC2PqlMpdC7UJOAx0IPCALwt4Cp1JUr42D+esY/rFhJ393dfmktiuBsqrk7rMGKTbs8zWBDTg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYAPR01MB6330.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(136003)(346002)(39860400002)(396003)(376002)(5660300002)(9686003)(53546011)(478600001)(8676002)(8936002)(30864003)(83380400001)(186003)(66946007)(7696005)(71200400001)(85182001)(55016002)(33656002)(966005)(76116006)(122000001)(52536014)(316002)(86362001)(66446008)(2906002)(54906003)(66476007)(26005)(38100700002)(66556008)(64756008)(110136005)(6506007)(4326008)(491001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?iso-2022-jp?B?VVpsTWdUZlgybENXM3NISGRYalNadFFjOVRGbzhvT3hET3NrSFdpQXll?=
 =?iso-2022-jp?B?L08yMk9oRUZwb3E0M3VwSlZKWE92L1M0a1k2b1pIUUJSWlZNVjErMnJj?=
 =?iso-2022-jp?B?VjkwQXZNUzZSdGsrRVhnZEhJRDYvQmtQU0RINk9ZRDRIOUc4RkNOUHk2?=
 =?iso-2022-jp?B?SzVablhwcHR4TjJNZDJ3NzNhVk90UmlPKzJkSDUrRDRHMi9URVdPT2Vh?=
 =?iso-2022-jp?B?WGxsNG9ZeS8vWWVZWTVpcHZYTGRjazBUWkxlcTkrMHdaRDlwZ3lDRU9M?=
 =?iso-2022-jp?B?aldEd1A3RGE4Y1hUU2JhTmNyS1ZQVHFQQnZFV1JTdjZXMVdiYW9FWUw0?=
 =?iso-2022-jp?B?eGlOTjBnRk9CdjUyU3l4UDd6WCtLWm5HTEFrNnQycWZPd0VNeGlHQXBy?=
 =?iso-2022-jp?B?dFk0TjFuT1FHaGR4YUtNTXh1VUYzNktWT3JMYmw0dG0yQmlQMVVid2RP?=
 =?iso-2022-jp?B?bk5nM1JZeThZa1FEV2hONFVNdUYrOXhFdVN0Z1FJaVFKckpQOGVTclg5?=
 =?iso-2022-jp?B?MEpaZjVMdWJEOVRHak5UL3JGVmZPeFA4SUdKQTNOcXhEaHQwVWpTSGtu?=
 =?iso-2022-jp?B?a1greVZURUp5cG5ZYVJJRjArMllkcE9MUEY3KzlGOFUxeTZRUUNCM3Fx?=
 =?iso-2022-jp?B?WDVDZk40NHhoWUNRRzZiR1c4NEhKaDdVbEhLb09wUUVoUUNvMjhQYVAy?=
 =?iso-2022-jp?B?SUw5QlVaNlVrNG1xRzh3bG9uQ0F1NkFFWm1lSEdaandoaC9pVE5JQmg4?=
 =?iso-2022-jp?B?cktnaDZ5Q1FYMkNqenpRWTdaSjdEK0twdjBGZDV2VUlFQ3ZTaStPZElN?=
 =?iso-2022-jp?B?WnZJWkY2Q2tBTzRQWFRBQlNNRFg4VXJ0QWsycHYzSHEwZm1PQVQxM2kz?=
 =?iso-2022-jp?B?T0lDNGdwSEUxcklKcUQya3BLSExueEhCZjM2ZkxoTHRRZm5NREpTMTFo?=
 =?iso-2022-jp?B?QTVJMGFEajVTQkRUc1F0K2MxMHZib3NNRUJmcjJpTm9Za3UrQ3BEREVk?=
 =?iso-2022-jp?B?eW1rV3pySUpQclZJbXlsR1JjQXAvS1MzU3o1RGlYSUp3V3JOVyswZUxT?=
 =?iso-2022-jp?B?ZWQxdHUzL2YzWjVEakdoRGZLS3pRTVB6eERzTG1zb3JtSklrM3BaSG5z?=
 =?iso-2022-jp?B?VnVFQjIrSEU5REY3aHlUNlcvYytibzJKNWpUOXl6ZzF5eXFMdXBzbnM5?=
 =?iso-2022-jp?B?czJDZDdsdTBWQThaQnFCR2JuQ3lLZFVsYzBPdFVJK3JzeG85eCtTU3ZY?=
 =?iso-2022-jp?B?bTJ6TUVlNUsyY2RSYUR6UDM0bVBwaVVSQy9VYU9uKzlDRVRIS3NVeERu?=
 =?iso-2022-jp?B?cVVCNkI0UVdjOExqZzJkemU2WFZ2MXBCWitzaVVkMzhKOHNzNDM3WmVp?=
 =?iso-2022-jp?B?NENzTHVtQ3Rpb1RGSVJ1YjJhYVl0M0FwWEhDTVFyWUI1ZER5VlpvTWpj?=
 =?iso-2022-jp?B?V0xLeHlDR2JTb1BlZVFXZnhBN0I1Y2hXUGFEckNiSStMTnBRa1BVM3R1?=
 =?iso-2022-jp?B?ZGlQWmpodnhsMGRBYzl4S2pqaWNRazJ2ei9MV0Q3c1kxTHJndUxvTmhL?=
 =?iso-2022-jp?B?c0NPNmphYVozczFOODlCOGNNWWYzWFRjQmE2a2d2cityYytrenVGMlEy?=
 =?iso-2022-jp?B?VTNGaTk2NG9PYmdqdW5MMi9Gdlg1dlpMV2tNRmY1ZmtQeHZqQ25YbEhO?=
 =?iso-2022-jp?B?TzNsOHpuSW1GOTZSQmtRa1dCYTBBSDdTVFpQTHBScE40ZkhFWGlHMmxs?=
 =?iso-2022-jp?B?bHBpYTJma3dFa2ZySFJ0M0hjNEFkRXh2aWdJMEpvK2cyaFQyMEhYdnF2?=
 =?iso-2022-jp?B?UEhnNExSOWZRcEsvemFtM0RxTFpGSVo3RUdhS1RmaXpmNEhJYWxtZXB5?=
 =?iso-2022-jp?B?bStsTWZuMjFnUkJBZnVzRlFBRVN3PQ==?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYAPR01MB6330.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 347ab921-5302-4712-f9fd-08d91f597ac9
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 May 2021 08:45:42.0899
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5DiiAkBGIB09XXJ4FKE3HD3vSkt/Qu/RDPEMMdeQDpq0jyy2Zpm7caIIFGvuYg5Pi/AHXzenUCgc/Co4250e49AhIpmuVh2KM0//UAiBbA8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY2PR01MB4649
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Reinette,

Sorry, I have not explained A64FX's sector cache function well yet.
I think I need explain this function from different perspective.

> On 5/17/2021 1:31 AM, tan.shaopeng@fujitsu.com wrote:
> > Hi Reinette,
> >
> > I=1B$B!G=1B(Bm sorry for the late reply.
> > I think I could not explain A64FX=1B$B!G=1B(Bs sector cache function we=
ll in my
> > first mail. While answering the question, I will also explain this
> > function in more detail. Though maybe you have already learned more
> > about this function by reading specification and manual, in order to
> > better understand this function, some contents may have duplicate
> > explanations.
> >
> >>>> The overview in section 12 was informative but very high level.
> >>>
> >>> I'm considering how to answer your questions from your email which I
> >>> received before, when I check the email again, I am sorry that the
> >>> information I provided before are insufficient.
> >>>
> >>> To understand the sector cache function of A64FX, could you please
> >>> see A64FX_Microarchitecture_Manual - section 12. Sector Cache
> >>>
> >>
> https://github.com/fujitsu/A64FX/blob/master/doc/A64FX_Microarchitect
> >> u
> >>> re_Manual_en_1.4.pdf
> >>> and,
> >>> A64FX_Specification_HPC_Extension ? section 1.2. Sector Cache
> >>>
> >>
> https://github.com/fujitsu/A64FX/blob/master/doc/A64FX_Specification_
> >> H
> >>> PC_Extension_v1_EN.pdf
> >>
> >> Thank you for the direct links - I missed that there are two documents
> available.
> >>
> >> After reading the spec portion it does seem to me even more as though
> >> "sectors" could be considered the same as the resctrl "classes of
> >> service". The Fujitsu hardware supports four sectors that can be
> >> configured with different number of ways using the registers you
> >> mention above. In resctrl this could be considered as hardware that
> >> supports four classes of service and each class of service can be allo=
cated
> a different number of ways.
> >
> > Fujitsu hardware supports four sectors that can be configured with
> > different number of ways by using "IMP_SCCR" registers, and when this
> > function is added into resctrl, the maximum ways of each sector are
> > indicated by bitmap.
> >
> > However, A64FX's L2 cache setting registers are shared among PEs
> > (Processor Element) in NUMA. If two PEs in the same NUMA are assigned
> > to different resource groups, changing one PE's L2 setting on one
> > resource group, the other PE's L2 setting on other resource groups
> > will be influenced. So, adding this function into resctrl, we will
> > assign NUMA to the resource group. (On F64FX, each NUMA has 12 PEs,
> > and each PE has L1 cache setting registers, but these registers are
> > not shared.) There are 4 NUMAs on A64FX, 4 NUMAs could be considered
> > as hardware that supports four classes of service at most, and each
> > class of service has 4 sectors (4 L1 sectors& 4 L2 sectors), and each
> > sector can be allocated a different number of ways.
> > And, when a running task on resource group, the [56:57] bits of
> > virtual address are used for sector selection (cache affinity).
>=20
> It is not clear to me why NUMA needs to be involved.
>=20
> Processors sharing a cache, either L2 or L3 cache, is familiar and well
> supported by resctrl.
>=20
> My understanding of the sector cache feature is that each cache can be sp=
lit
> into multiple (4) sectors. It thus seems to me something specific to the =
cache
> itself.
>=20
> Let me try and give an example of my understanding based on the cache
> architecture described in the A64FX Microarchitecture Manual.
>=20
> I see in Figure 9-2 that each processor has an L1D as well as L1I Cache, =
and
> twelve processors share an L2 cache. The L1D cache has 4 ways (0xF
> bitmask) and L2 cache has 16 (0xFFFF bitmask) ways. From what I understan=
d
> the sector cache function is supported on L1D and L2.
>=20
> First, the goal would be to discover all the caches on the system - since=
 it is the
> sectors need to be programmed on each cache. On the system with 48 cores
> there would thus be 48 L1D caches, and 4 L2 caches.
>=20
> Let's start by assigning the caches IDs: the L1D caches are numbered from=
 0 to
> 47 and the L2 caches numbered from 0 to 3.
>=20
> My understanding is that the goal is to program these sectors using resct=
rl.
> Each cache instance can have maximum four sectors, they cannot overlap. (=
I do
> not know if each sector has to have some portion of cache associated with=
 it or
> if a sector is allowed to be "empty").
>=20
> So, what is needed is, for example, to have a way to say: "sector 0 on ca=
che L1D
> with id X is assigned Y ways", "sector 1 on cache L2 with id Z is assigne=
d XX
> ways". Is this correct?
>=20
> If my understanding is correct then you can do this with resctrl as follo=
ws (I am
> making many assumptions on behavior here, especially regarding how many
> ways a sector is required to have, but I hope this could be a baseline to=
 evaluate
> and correct my understanding and build on how this could be supported):
>=20
> On boot all cache ways on all cache instances belong to sector 0:
>=20
> # cd /sys/fs/resctrl/
> # cat schemata
> L1D:0=3D0xf;1=3D0xf;2=3D0xf;.....;47=3D0xf
> L2:0=3D0xffff;1=3D0xffff;2=3D0xffff;3=3D0xffff
>=20
> Create sector2 and assign half of all cache ways to it:
> (In support of this it would be required that resctrl resource groups are
> exclusive. Exclusive resource groups are already supported but not the de=
fault
> as it needed here.)
>=20
> First, to provide cache ways to sector 1, the cache ways needs to be remo=
ved
> from sector 0:
> (I am not sure if specific ways can be assigned to a sector or just a num=
ber of
> ways, both could be supported) # echo 'L1D:0=3D0x3;1=3D0x3;...;47=3D0x3' =
>
> /sys/fs/resctrl/schemata # echo 'L2:0=3D0xff;1=3D0xff;2=3D0xff;3=3D0xff'>
> /sys/fs/resctrl/schemata
>=20
> Now create sector2 (alternatively all sectors could exist on boot for thi=
s
> system):
> # mkdir /sys/fs/resctrl/sector2
> # echo 'L1D:0=3D0x3;1=3D0x3;...;47=3D0x3' > /sys/fs/resctrl/sector2/schem=
ata #
> echo 'L2:0=3D0xff;1=3D0xff;2=3D0xff;3=3D0xff'> /sys/fs/resctrl/sector2/sc=
hemata
>=20
> At this point there are two sectors configured. Configuration of sector0 =
can be
> found in /sys/fs/resctrl/schemata and configuration of sector1 in
> /sys/fs/resctrl/sector1/schemata
>=20
> >> The other part is how hardware knows which sector is being used at
> >> any moment in time. In resctrl that is programmed by writing the
> >> active class of service into needed register at the time the
> >> application is context switched (resctrl_sched_in()). This seems
> >> different here since as you describe the sector is chosen by bits in
> >> the address. Even so, which bits to set in the address needs to be
> >> programmed also and I also understand that there is a "default"
> >> sector that can be programmed via register. Could these be equivalent =
to
> what is done currently in resctrl?
> >
> > Adding this function into resctrl, there is no need to write active
> > class of service into needed register. When running a task, the sector
> > id is decided by [56:57] bits of virtual address, and these bits are
> > programed by users. When creating a resource group, the maximum number
> > of ways of each sector are set by "IMP_SCCR" setting registers.
> > As long as the task is running in a certain resource group, the sector
> > and the maximum number of ways of sectors are used will not be changed.
> > Therefore, we need not consider context switches on A64FX.
> >
>=20
> The current interface would associate a "tasks" file with each sector to =
indicate
> which tasks run with the particular sector id. I thought there was a way =
to
> program the default sector id in a register, which is something that coul=
d be
> done when a task is context switched in.
> Otherwise there would need to be some re-architecting to remove the "task=
s"
> association. This would be a significant change.

--------
A64FX NUMA-PE-Cache Architecture:
NUMA0:
  PE0:
    L1sector0,L1sector1,L1sector2,L1sector3
  PE1:
    L1sector0,L1sector1,L1sector2,L1sector3
  ...
  PE11:
    L1sector0,L1sector1,L1sector2,L1sector3
 =20
  L2sector0,1/L2sector2,3
NUMA1:
  PE0:
    L1sector0,L1sector1,L1sector2,L1sector3
  ...
  PE11:
    L1sector0,L1sector1,L1sector2,L1sector3
 =20
  L2sector0,1/L2sector2,3
NUMA2:
  ...
NUMA3:
  ...
--------
In A64FX processor, one L1 sector cache capacity setting register is=20
only for one PE and not shared among PEs. L2 sector cache maximum=20
capacity setting registers are shared among PEs in same NUMA, and it is=20
to be noted that changing these registers in one PE influences other PE.=20
The number of ways for L2 Sector ID (0,1 or 2,3) can be set through=20
any PEs in same NUMA. The sector ID 0,1 and 2,3 are not available at=20
the same time in same NUMA.


I think, in your idea, a resource group will be created for each sector ID.
(> "sectors" could be considered the same as the resctrl "classes of servic=
e")
Then, an example of resource group is created as follows.
=1B$B!&=1B(B L1: NUMAX-PEY-L1sector0 (X =3D 0,1,2,3.Y =3D 0,1,2 ... 11),
=1B$B!&=1B(B L2: NUMAX-L2sector0 (X =3D 0,1,2,3)

In this example, sector with same ID(0) of all PEs is allocated to=20
resource group. The L1D caches are numbered from NUMA0_PE0-L1sector0(0)
to NUMA4_PE11-L1sector0(47) and the L2 caches numbered from=20
NUMA0-L2sector0(0) to NUM4-L2sector0(3).=20
(NUMA number X is from 0-4, PE number Y is from 0-11)
(1) The number of ways of NUMAX-PEY-L1sector0 can be set independently
    for each PEs (0-47). When run a task on this resource group,=20
    we cannot control on which PE the task is running on and how many=20
    cache ways the task is using.=20
(2) Since L2 can only use 2 sectors at a time, when creating more than
    2 resource groups, L2setctor0 will have to be allocated to a=20
    different resource group. If the L2sector0 is shared by different=20
    resource groups, the L2 sector settings on resource group will be=20
    influenced by each other.
etc... there are various problems, and no merit to using resctrl.


In my idea, in order to allocate the L1 and L2 cache to a resource=20
group, allocate NUMA to the resource group.
An example of resource group is as follows.
=1B$B!&=1B(B NUMA0-PEY-L1sectorZ (Y =3D 0,1,2...11. Z =3D 0,1,2,3)
=1B$B!&=1B(B NUMA0-L2sectorZZ (ZZ =3D 0,1,2,3)

  #cat /sys/fs/resctrl/p0/cpus
  0-11 *1
  #cat /sys/fs/resctrl/p0/schemata
  L1:0=3D0xF,0x3,0x1,x0x0 *2
  L2:0=3D0xFFF,0xF,0,0 *3

*1: PEs belong one NUMA. (Of course, multiple NUMAs can also be=20
    specified in one resource group)
*2: The number of ways for L1sector0,1,2,3. On this resource group=20
    the number of ways of all sector0 is the same(0xF). If 0 way is=20
    specified for one sector, this sector cannot be used. If 4(0xF)=20
    ways are specified for one sector, this sector can use cache fully.
    If 4 ways are specified for each sector, there will be no=20
    restriction for using cache.
*3: The number of ways for L2 sector 0,1. If L2sector0,1 is used,=20
    the number of ways of L2sector2,3 must be set to 0.

All sectors with the same ID on the same resource group were set to=20
the same number of ways, and when running a task on A64FX, the sector=20
ID used by task is determined by [56:57] bits of virtual address.=20
By specifying the PID to /sys/fs/resctrl/tasks, the task will be bound=20
to the resource group, and then, the cache size used by task will not=20
be changed never.


Best regards,
Tan Shaopeng
