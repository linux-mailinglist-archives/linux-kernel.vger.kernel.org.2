Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 44CD441F7C2
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Oct 2021 00:49:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355862AbhJAWvM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Oct 2021 18:51:12 -0400
Received: from mga01.intel.com ([192.55.52.88]:9806 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230376AbhJAWtQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Oct 2021 18:49:16 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10124"; a="248174640"
X-IronPort-AV: E=Sophos;i="5.85,340,1624345200"; 
   d="scan'208";a="248174640"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Oct 2021 15:47:30 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.85,340,1624345200"; 
   d="scan'208";a="521420383"
Received: from fmsmsx606.amr.corp.intel.com ([10.18.126.86])
  by fmsmga008.fm.intel.com with ESMTP; 01 Oct 2021 15:47:29 -0700
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx606.amr.corp.intel.com (10.18.126.86) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12; Fri, 1 Oct 2021 15:47:29 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12 via Frontend Transport; Fri, 1 Oct 2021 15:47:29 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.176)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2242.12; Fri, 1 Oct 2021 15:47:29 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LKQXz47ynotuwu/ACdq6kg7mo1O+BipoMw6goPjF1DMgYsuw9jRo5KPu1RqdUOtCXxMSJtvL/5vOdjhE/VnmPrci0Gcm+wNJ/FfdSLTqDK0A2xP/4M6KrGcZVs9/x+g3Y+4tkPw5sFqp5rA7L8FuRTGLmQHUTbqi7rMP3mefv73p1n1lO67i57boHHH9jRnBLnGAhYpa9WuX7Q7MyHJm1FDiwKWHAP2hocxfo0GsqlGTVwjQP+/7g5IiQddYfNZND64eB5LeFjtLZyA7Wzt+IY2SRsco5g/H7IMW/fWRMH8Rp5XCyYloH1tBBFiskClZGERLLA1WDy1tQPHzUc7Sxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8OTAkgaY/1sxh4ysNU8ttz0VdxUvnBHyccx1+gPTGmQ=;
 b=QE6e544sJca4j4cWE4ETzZJP3/gREovdP96WUgni+IfFU7/ksLPQXxSpbD9YtcHjaboIea3hozJ6gnG87dN1gmxx3L0112AjZADGbfE24t8bfHbiFZPdSHoqOMpoIg2CvZ0IsEdtqxQkOp3GaZ3FxjdQoiavCIlNCF4ae6VJJtrBBF4dpt0f1I/celn3sOHnuhW4KrhzFrEx30Gp7IcjjdEg1hcWJhrpfGgCMmDdKhrtuNXA5n8gQiWLzOHqkcExEiLXdwJ5Z4ZsdVTz9D9BW/osWbKVHxbBOh8X+vVS2aJK8POB/QZ6x/zDczJ0WGawFr8WXIT57wx0By8ttc524w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8OTAkgaY/1sxh4ysNU8ttz0VdxUvnBHyccx1+gPTGmQ=;
 b=Du1mccL4qNA7at9Y6YOhL0ccdTV3nMTUJup9qYmii5SFOg43fLTit1qXnWxKU71eYDeNd7q4JjXlFOfZl7YgYxdacleZfh5qCvq/5bRDnC31BihFD5VZ7H5vGBjMAOkOkvBhb4U0FhxGTVNWlBf1gapK95V0vtyVefBshyAzZM8=
Received: from PH0PR11MB4855.namprd11.prod.outlook.com (2603:10b6:510:41::12)
 by PH0PR11MB5144.namprd11.prod.outlook.com (2603:10b6:510:3e::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.14; Fri, 1 Oct
 2021 22:47:28 +0000
Received: from PH0PR11MB4855.namprd11.prod.outlook.com
 ([fe80::b427:a68a:7cb6:1983]) by PH0PR11MB4855.namprd11.prod.outlook.com
 ([fe80::b427:a68a:7cb6:1983%3]) with mapi id 15.20.4566.019; Fri, 1 Oct 2021
 22:47:28 +0000
From:   "Bae, Chang Seok" <chang.seok.bae@intel.com>
To:     "tglx@linutronix.de" <tglx@linutronix.de>
CC:     "bp@suse.de" <bp@suse.de>, "Lutomirski, Andy" <luto@kernel.org>,
        "mingo@kernel.org" <mingo@kernel.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "Brown, Len" <len.brown@intel.com>,
        "lenb@kernel.org" <lenb@kernel.org>,
        "Hansen, Dave" <dave.hansen@intel.com>,
        "Macieira, Thiago" <thiago.macieira@intel.com>,
        "Liu, Jing2" <jing2.liu@intel.com>,
        "Shankar, Ravi V" <ravi.v.shankar@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v11 00/29] x86: Support Intel Advanced Matrix Extensions
Thread-Topic: [PATCH v11 00/29] x86: Support Intel Advanced Matrix Extensions
Thread-Index: AQHXtxXjpXjC3Qk5Sky+qg9KSaDYk6u+vnGA
Date:   Fri, 1 Oct 2021 22:47:27 +0000
Message-ID: <B1364EA9-C3D0-4711-8C5D-01C8ED32447B@intel.com>
References: <20211001223728.9309-1-chang.seok.bae@intel.com>
In-Reply-To: <20211001223728.9309-1-chang.seok.bae@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3608.120.23.2.7)
authentication-results: linutronix.de; dkim=none (message not signed)
 header.d=none;linutronix.de; dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f5e9070a-3edd-4c04-957e-08d9852d71e2
x-ms-traffictypediagnostic: PH0PR11MB5144:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <PH0PR11MB51440F7F3BC5896D99352F5CD8AB9@PH0PR11MB5144.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: qQIb1lg9nk7G6RUynN4waFVrpKGdmCdrHDO0Rbr4/FCESIBS5j3TWrDirtACMBJi5BOUjhh8arCrDp+9reTkqawWrTwgmRVlvhDVl7qSrz+v+IOqJuep7OrZZ8u5jGZ446uiyivub6hMVz3UTnATZlzH6G4wk6oL8Y0cxnnRrLkScMpqc0Cmnn5m4ATjuc5RZ73YZm6gta/lqdl24F/nMctF53i3lyxEpjYNJnOt/b7P8J2xbRNxv63ZF1wJYAXlqmNPssFAIYwTnX+uXPvIHUZIqXsrRElIXbroSBJAziOJRFerGVGGO0n7P8AprHt5r9E5mQlU5X6FS3985BxNn2OA6Z29Cn8vQ/VhtbRaFgy2QjYhSdg1Ib7DnPEbCUmVN6ZpJEuWBSvfWYFoWtI8IfEPlI2wrMRdDN3olnF99ubmsfHTnTT7vm4HO0dPKW76h0kC0GJWRo9G83N9GQLcOS/0RcPkYXkMdlBHdHKM/DvzH4FH3jLRevfJRjUvCRsGLh2jKcUDdscO2xJxHkWNuJSUnfrtr2v5OU2t8rYaHNNQ4Rt0pYmdXIe7GKaOXDS88RiDUhHj8D3CYW0OoYV/77lBf5/qA4AWJZGlrrElXtJT9oHRY0zlt2DsYYp94QGOF3xSb/SAvlYbzrQLG2kJm3KTD/5lLX3SUl4v1KMmkceiv7AW2cH5WXGMvyuxzP/wnxXgl8kV86dW4ZlLCChpytucwvOf86/finmlsrNucf6YXmVhMj+MkUyVBSrvnLVvFU/jxNkh8GVXeCRqJG2cdTzt3H0v2kn/lCId8US2yJ21ekRXDENzVklGeOqcp5NZ
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB4855.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(6506007)(4744005)(66446008)(66476007)(6486002)(8936002)(66556008)(4326008)(6916009)(508600001)(8676002)(5660300002)(316002)(6512007)(36756003)(71200400001)(64756008)(966005)(2906002)(33656002)(54906003)(66946007)(76116006)(2616005)(38070700005)(38100700002)(122000001)(186003)(26005)(86362001)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?fh6u42X4bLtX0vIOmEQceabp+vRtABzBBWX+Z3R0qdoSDhy06NqP4mL/L21Q?=
 =?us-ascii?Q?PAvWU/+C9gUbcRQyvic3p04edx6r5gtUcOy/cM3Bk8wA/LBQb4JqX/++E25e?=
 =?us-ascii?Q?9apEzj0UemU9XY9Du0XK3LWNJKSueclU8lY+8V2wYQJwc8cTqs2wQUv84Nw5?=
 =?us-ascii?Q?+SVHB1Yw8prpQ9DK55fcTUPEZp8B/vERpeUboHLvop31VwLy+HEFCn83YK8e?=
 =?us-ascii?Q?yp4JMSG1m/uHKlWqRlhuyhlM/qNgtWeAgA/BN49uSsskeprMAIH4ZtiGCN95?=
 =?us-ascii?Q?5gFjXZEmc8fSmQmD+3GvVBaps7WF/qD9JatdY62OGDwUvZJz7S5pnWc2nQ/n?=
 =?us-ascii?Q?g/oYXXHxwBJk1uMmOOTgFFajRkiJb6iPgbFrRZt2owc4rwzSOW2BqBFXGJ+X?=
 =?us-ascii?Q?BwgroWV81x444yFM9+6LUqCddCBIMilUqvGVnYLpVwGnFyzfrnleypXyXkzg?=
 =?us-ascii?Q?3g6wYBNojmLV1NlN3JJyWpr8okFB47NQiei8zxPLkyAlmL+eokUcea2388tQ?=
 =?us-ascii?Q?3pUl0zVu30ad0o+uyT0nWC9zykvS+YjOdCGJJdAHsvzRGbMs5rxb9qRsTWeE?=
 =?us-ascii?Q?32sBH1685koxZnkZdD3XPBsN/dKnCu1deBepliIDylylhMWAEp0Gj2SyOZ+9?=
 =?us-ascii?Q?YwtQcKm3+L0IebU6kUPyvP5HV+Lu1d832cffSevH96GF3wCjebu6xpx9F3LL?=
 =?us-ascii?Q?fZqtmE1a7V1JlGMP+2myobzp24NT4PtE9k70Y1oQKE89sJlG7z02iAiXI47k?=
 =?us-ascii?Q?fLS5UzZ6gfNUxZxUieU4Jps1OzBClgvcDe+qy0MD4cJRFRElFjVTAECYXMBa?=
 =?us-ascii?Q?2nkrYRnEpM7sHwVfLTemjsb2F53BSKyW5BjIUedmvPSyCTmpoFMWI7g6PI18?=
 =?us-ascii?Q?lRy6p6KjqfhhVwx0rx8biW9jw/K/O66C0E/l1tAA4gqC9VKWeN5Ec7wR/esb?=
 =?us-ascii?Q?Gqux/NiCMkpXHXfyWBnxs8vSxu86VqSWCq5LjvzE7S8npdaRAQSg036EkwDE?=
 =?us-ascii?Q?JcnQeTRHX7zToFd1MFH79OY0Nwm8v9AnCNLTha2jmirGYzZky4OFGhZuB8MZ?=
 =?us-ascii?Q?5WuRVMTDEEzEKFRuYIjF3UIbzlAMbLnCnTkm+2Z7ELhjAcfrmyXWZkfnzxja?=
 =?us-ascii?Q?WL67vO5RGEaqVClFyJyBX3LFDBsGSwDwxo6h87Mm1CLk4R2JgVOSQYae4ZaI?=
 =?us-ascii?Q?69YFG1RnF7hcIlYZC70wgr3UzKCcbfOwACv79xIfn6WFp/ikVRQ0duWITam5?=
 =?us-ascii?Q?UXiEZw2EaCPDoPv1I31eJMzje0V15d32qCLiLkljUDSIvzsksE1m7fZEuUmX?=
 =?us-ascii?Q?EwgN1rKiIjDb1ORqD11Dg+4P?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <84C314E7DB6EE54CA3A7FEF9BDE909E5@namprd11.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB4855.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f5e9070a-3edd-4c04-957e-08d9852d71e2
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Oct 2021 22:47:27.8929
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: VoL3ilrV7Uh/BXJfRm/AgL0YxRKeIwnr4WNK5daopq+OYfCsdfDrzdIQTdhnHIppzycnybcaUbGLtbwlWOKhmDtKYx5swNqYjTT0o46fTRw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5144
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Thomas,

Sending this version as it follows up the discussion [1] with some code cha=
nges from v10. This is not intended to ignore your comment on v10 at all. A=
ppreciate your points on my oversights that I will address in v12 soon.

[1] https://lore.kernel.org/lkml/CAJvTdKkK=3D_pp1PrWdh1_GN73VifuAkivnErgK+b=
o2h34Vd_55w@mail.gmail.com/#t

Thanks,
Chang=
