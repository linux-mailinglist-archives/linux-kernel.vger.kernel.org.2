Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C5E48436EA6
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Oct 2021 02:07:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232060AbhJVAJW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Oct 2021 20:09:22 -0400
Received: from mga14.intel.com ([192.55.52.115]:60259 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229512AbhJVAJU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Oct 2021 20:09:20 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10144"; a="229456364"
X-IronPort-AV: E=Sophos;i="5.87,170,1631602800"; 
   d="scan'208";a="229456364"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Oct 2021 17:07:04 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,170,1631602800"; 
   d="scan'208";a="721515194"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmsmga005.fm.intel.com with ESMTP; 21 Oct 2021 17:06:48 -0700
Received: from fmsmsx607.amr.corp.intel.com (10.18.126.87) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12; Thu, 21 Oct 2021 17:06:46 -0700
Received: from fmsmsx602.amr.corp.intel.com (10.18.126.82) by
 fmsmsx607.amr.corp.intel.com (10.18.126.87) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12; Thu, 21 Oct 2021 17:06:45 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12 via Frontend Transport; Thu, 21 Oct 2021 17:06:45 -0700
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (104.47.73.41) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2242.12; Thu, 21 Oct 2021 17:06:45 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=U9Lym9pNa/snnESaMn8wZg9UqbO8jDNZrjiTTa/BnJZ+dlpeHimsLg4lPMHghe+7Qk2swOenLi1Rtno+eZ/woXavgv5UA1gO/ZjS31TMiY1ZH+D6H0EcWfW+Ff4GtIw6uQ3324UWpL7xp6H91SS85YqMBSn3XHNdvdANsLvijwkAaW2I40NaEVfxjibHUiHGXNPMUAkH4DWV06adQn0nEvehR9+JI/GiCpo3qsZHIFUKrRZSsOlTi6hUxNxmGvW7DYrRsOsYJv3hbP9YWupLUhf+/PJet8rjzHTQVvpWda+uFWqfyu6hoLpM7dUO6z3hRaGYbFfEyXKenexsRu0lOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=x/tn47qUqWLoVz2V7wnvfq1m5bZmq3zmgvlnqMCheNI=;
 b=KEw8Sk011TGKJ9DDsTBTHY6EiVMh/biKt1GPqGJMyC43/rE1kRPJTkNeKsnCXj/pMHk7yRjBJDguitJW5fZCH/zYpfcGYcvclvaWpGC8YiZvRwHJpcQuIJ0uxk7gxbsyo3PJ4exVGNYmjPtmMA+AyxGzvENHhYaiIQC8DhIY6ILzCDwjlKeYLEwR838NR37+b8+LmpzN1Ge+P4B6qnLRJTRrsrArv4sa/8yqrrQN4DuvEMs/ZIzA0QZu2Rnsd82efGpKM8ePIDTyY3Cf4P1voffYKw8tVVKZCnDGlOevXGjM15Gsny48V3DSNYux7jdT0m3o9zCE7AaV6ZD/qEK9ng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x/tn47qUqWLoVz2V7wnvfq1m5bZmq3zmgvlnqMCheNI=;
 b=A8msgQyT9FwKEgtz0Lf6gM7DUp4uJX3rrcgiABogVuC3fWcNNLGlGz/Yjws5kHrSVokSMEl4fVxfbwrap2Z48Mm8wsq5v9O0kHVdn/+d7M55jS62OY6SmsifaZLTa2+0NO/+pyOyX5DklqkWytMHVPkQEXJLf0deQgCK2xyuUNU=
Received: from PH0PR11MB4855.namprd11.prod.outlook.com (2603:10b6:510:41::12)
 by PH0PR11MB4791.namprd11.prod.outlook.com (2603:10b6:510:43::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.16; Fri, 22 Oct
 2021 00:06:44 +0000
Received: from PH0PR11MB4855.namprd11.prod.outlook.com
 ([fe80::11ef:b2be:5019:6749]) by PH0PR11MB4855.namprd11.prod.outlook.com
 ([fe80::11ef:b2be:5019:6749%7]) with mapi id 15.20.4628.016; Fri, 22 Oct 2021
 00:06:44 +0000
From:   "Bae, Chang Seok" <chang.seok.bae@intel.com>
To:     "oleg@redhat.com" <oleg@redhat.com>
CC:     LKML <linux-kernel@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Arjan van de Ven <arjan@linux.intel.com>,
        "Shankar, Ravi V" <ravi.v.shankar@intel.com>,
        "Eric W . Biederman" <ebiederm@xmission.com>
Subject: Re: [PATCH 01/23] signal: Add an optional check for altstack size
Thread-Topic: [PATCH 01/23] signal: Add an optional check for altstack size
Thread-Index: AQHXxs/KH/zAunRvyU+haqpjnaTycqveI8IA
Date:   Fri, 22 Oct 2021 00:06:44 +0000
Message-ID: <36CBC1EF-F30B-4A90-988B-CAE692EF4561@intel.com>
References: <20211021225527.10184-1-chang.seok.bae@intel.com>
 <20211021225527.10184-2-chang.seok.bae@intel.com>
In-Reply-To: <20211021225527.10184-2-chang.seok.bae@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3608.120.23.2.7)
authentication-results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 119c4c8d-5997-460f-14b0-08d994efd50a
x-ms-traffictypediagnostic: PH0PR11MB4791:
x-microsoft-antispam-prvs: <PH0PR11MB4791C91A0A01DE9089ABC8D9D8809@PH0PR11MB4791.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4714;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: DPHRnp/1+DHRoWF9nvrjIiI40BOGHJEIhwxm9w9F6+x9Iyx5wEkd+Ztg10zd3KGxcw28sBJOpegxKKxtkPiRI26b826B+R7e57ZQbLqGjCmkh+yeJZTnmPdJ7XwGZMmgEeSIqY3vArCzG9T1iI4zJTZl0uJAKcrla2EjsBkTcfn65GVxAeJB3AeznrKpFDTVX/spT3HPpJGd+yc2kxETL7LX0Q63vix2UzRsu2hO8ICYLAhchjipH4SWyZfLncoB2RFMztLbtnnvZZ+2G2PHRuRFqAZHgjuPX/g9V3TdCUqt2jAJQNAQoBfFGO8Bd+uVvvhv8SEFTKSOSfxPEC/q8g8SMWcptYuXbQMnzwUASN63x1jTePnaxdTNFrVj0QCPtsKKR4TMHaf9XkGKPZahC11uG5Ka0MQAMhoNvjHCJ+FnwX7UewTKfDK7MjDWZrYPAWApIaBg6TSwyD7yi3sQH20u5P57BnaiW1J4iJ/FRTalvUZSB8G8dhVwFwLs03lN3CouGEdZ5fCGGdXBzKXLYmpDrZUYUjrJj/xdFvNtBI89LWXIjLLns4cPb7y+JYSSnJy2hzI/gt3XmsYxL8RnA/CV5bzXhchfEupKlalrMF8Xxhco5PGWJAT/GrfU0fujXl3nSXSi2It86TFbbHDhJ9xgT7KIyU9KeQ/lVZDD7P+gihF3fy56Y/qc5nkor85H0ZSIvPWHsfRA7N0NSqMcbPP4mWhgxyiOIlW7zgBt7eEHA8sTnwPHJBtTVdhX8BvArTyjaWHM438dblGPrn01Y8zWl3puJac3qxGXv0LgBjHNgdJRAG2yFeGWGuH1N3Da
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB4855.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(6486002)(6916009)(33656002)(86362001)(6512007)(6506007)(186003)(26005)(2906002)(5660300002)(558084003)(82960400001)(38070700005)(38100700002)(66446008)(122000001)(64756008)(83380400001)(66946007)(4326008)(66556008)(2616005)(36756003)(53546011)(76116006)(54906003)(966005)(316002)(508600001)(8676002)(8936002)(66476007)(71200400001)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?sLS3LzpjoNiXGJeBQQX+++cgwZU8Psn2YS2bRI9MM4nL0u35NUq+T5nJOufC?=
 =?us-ascii?Q?nBYHU9QQeXPnTdwnTMc4GqxwXHyVh3UnrbMFk9Qs1KBuDkY1eHj16usQr72l?=
 =?us-ascii?Q?tYHCQd/9cIZRtmP0bSXyC2ZAQ2Ze7qvKmY/jW7wG6vE+QNnjBvWKm9+w91ix?=
 =?us-ascii?Q?mHAJj06yLBMDISLOZZBlhXXyFWELVjNC33LEiKXWuie241AhEh0GWvDEil/O?=
 =?us-ascii?Q?34re16m4z6ziqfRGIju2XnZ4t/Rs2HzY71riiFuhEUzqJiDJUJ3WNJkmvEV2?=
 =?us-ascii?Q?q9Xfa8Q3YeBhvRcfuoHq8WHVNeJQtfsF3TR3wF2CRNSAtPLlPTpGytepzBqv?=
 =?us-ascii?Q?SZAQNOwwXOi8WjKzB+Q3WVjsUDy+qvrndXs21xirrmvQ1aKyeInnVVtwgzrH?=
 =?us-ascii?Q?BqemCc5IpIFVR6oeyHpoDPmVn/13tuOrjHJDkAHxYcasHs1zltUExoYoYwHg?=
 =?us-ascii?Q?CtdphzLHnv6LfspgO84EjffuiAvw+9s8Zr9iJTMsmhyrr6BK4jbSr5jb6k31?=
 =?us-ascii?Q?6JaAabJf3vLzWp23rzNbieySDV/6KE8I7wfbgj3RCOdT9Xq+SlV6tsLKLWru?=
 =?us-ascii?Q?bAeHrDkCf7V+ja4o6CyxaAcMkEYGKwmjT1W/e7OLucHy3oCKiCTcKbc4CDxz?=
 =?us-ascii?Q?7N1ZjGxrypOIsiePAe1ZhPeioHByyH8nkyoJST0WzKlAxlKHQyrCcrCl0ozy?=
 =?us-ascii?Q?jGOhbjOxvc0pKqljjRxniY1ojg6Q96jYc+jEMeAdGL//tcH0dlGkyXq8mACv?=
 =?us-ascii?Q?c+JVyWHLpw0yaQMb6NafEAYh/IC7Psq04aIWs5JTGbwq35oKuqDECIEvACOT?=
 =?us-ascii?Q?n/2xP70Fg2Cf10JwQ3sNIQXMtcRctofO7YxLHPM4l3xkvSGMvtJC45bmjBBP?=
 =?us-ascii?Q?zV2U0KIsaHCOjM98DB57XpQaUaApaJcBIvbTefbFMVYz0DW6uslanBp1GJhp?=
 =?us-ascii?Q?nP8BYYa1Q4u1lJmbkqNMkuA9QjjSoy5Ss7JXdPhWTJaakRJeWSU4ve8QPFXe?=
 =?us-ascii?Q?F25ysKYhKVJx9dPIbdkRpAsIToQ2SMTHT6pWVWzGdcDlg38vsRaloZiTaYhx?=
 =?us-ascii?Q?qxYf8EaR5l/9PjBbwzXMdYxfvmjQUkZZG75oNVmTHF7iscix4VLOmGVv/TDm?=
 =?us-ascii?Q?gqT3gmr8ypr39zLdXWUrE+yFjc1RUfwtd95HErDntVtTboqScunSXnxpKQne?=
 =?us-ascii?Q?rdp/ASHwvKWKYEPKcOKL7jGg36cC0Uc4Y7vWRSA9UN3mg/9b23FreWlItmMn?=
 =?us-ascii?Q?2pWJ6xDnv2dG9lN8Ph4FMfANXlVuJ5Qx7P0G6sEVs+s9eUvT/aQtySMqQngt?=
 =?us-ascii?Q?W8axdrKA5p6t9KbdkMG8TxG+m/2rQqTdvYEj5SV00fxhAckTPfwli/ia8XXw?=
 =?us-ascii?Q?HyQSxrKA61euRFq5a7eZAyAUUtVPmAsDf4ZWnRSEPYMjWE9RwC+CyY6xpaVp?=
 =?us-ascii?Q?J2IIMUTvyec6cUS6jHYs+U2QfNviVasU?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <932AA08D411DD64187A7608A59D3536B@namprd11.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB4855.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 119c4c8d-5997-460f-14b0-08d994efd50a
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Oct 2021 00:06:44.0713
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: chang.seok.bae@intel.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB4791
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Oct 21, 2021, at 15:55, Bae, Chang Seok <chang.seok.bae@intel.com> wrote=
:
>=20
> Cc: Oleg Nesterov <ole@redhat.com>

Hi Oleg,

Apologies on my typo -- s/ole/oleg/

The original message can be found:
    https://lore.kernel.org/lkml/20211021225527.10184-2-chang.seok.bae@inte=
l.com/

Thanks,
Chang=
