Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 948A44211F6
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Oct 2021 16:49:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235182AbhJDOvd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Oct 2021 10:51:33 -0400
Received: from mga04.intel.com ([192.55.52.120]:60060 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235162AbhJDOva (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Oct 2021 10:51:30 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10126"; a="224225212"
X-IronPort-AV: E=Sophos;i="5.85,346,1624345200"; 
   d="scan'208";a="224225212"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Oct 2021 07:48:18 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.85,346,1624345200"; 
   d="scan'208";a="544323172"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmsmga004.fm.intel.com with ESMTP; 04 Oct 2021 07:48:18 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12; Mon, 4 Oct 2021 07:48:18 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12 via Frontend Transport; Mon, 4 Oct 2021 07:48:18 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.175)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2242.12; Mon, 4 Oct 2021 07:48:14 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=U2ZiSd/5CkbYgspvrhYBRRkPmTD1o+AAxBO+fph3w3jX28YUaSFbbbt7czaR4OD7i1EV658daYHea+cEUG041B/JCdVLJdZiz+1p0SS6MVQDkhCiO/UQfksPglkTvAx2w86racpdStxhraA1/CY/w8hhY3ypzaCwbs4uj6mZOd8OE89uYGwtoGgvUfWRkSZCPfb1I1WKXf2+ItT2FCmghkyIKEyFAnf9y+Ldc+lpx7IK8CZvHhHhPK6ggMVkC8YmGIc0JOUvSTOyNRbGREoAcMYFO8gAoIkNS9Z3DUssElxmp5UXwBvqT+WEBedWkQkCt+QNNvL8+K3Ft7Tz0qUNyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BIW6NMxJZKGHaRLqIfJxHVj3juAp0xw2/mqARki1A90=;
 b=iRewYy3bz6pFSNBaahmQ/N2CYmcSXZpD6A/76K8P/VwFZYH6cdaIVp+whnlPfjWJidrOTtYOeTk/y39Wl5OUQ+z83ZncUMMkzen3quWg0KDl1uMHwfl56PM3Sz0YBgKxGdEcgg+L5soeKDs4gMiP3peNUgxBw5gcympf1C/rXGciQhyEmCG15CDfNiEB5rlTcfuvyBfngoGpo/OnWknFhivSf9Ix06OMRsmjDH7o3BVQlRPZ4Nhsmkc4NAz8rqYRQDt1RUwU/dlP2W+QOm1aUAYemImJDq+4nViLTsWCbQOYp/ow9pUn2j3tY/QHLNiHFfy2y4kTsyq3Xnpa/DLARg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BIW6NMxJZKGHaRLqIfJxHVj3juAp0xw2/mqARki1A90=;
 b=t6GvsQtqsK2978Oyod7tO+xEkKqkTJEmaH/rPQB7zpf0Isn4UrdEI0gizN/0Yjpw1Iyp6HJGwWuchXBvJhwAfS4DzfVuxWex2wrJq0vPY+n+wQk1189KZO3do4V04MdJV3CICZUtqXL8E4jiSVxjIAz+ppexCJs39R1s3tzZflo=
Received: from PH0PR11MB4855.namprd11.prod.outlook.com (2603:10b6:510:41::12)
 by PH0PR11MB4904.namprd11.prod.outlook.com (2603:10b6:510:40::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.16; Mon, 4 Oct
 2021 14:47:52 +0000
Received: from PH0PR11MB4855.namprd11.prod.outlook.com
 ([fe80::b427:a68a:7cb6:1983]) by PH0PR11MB4855.namprd11.prod.outlook.com
 ([fe80::b427:a68a:7cb6:1983%3]) with mapi id 15.20.4566.022; Mon, 4 Oct 2021
 14:47:52 +0000
From:   "Bae, Chang Seok" <chang.seok.bae@intel.com>
To:     Thomas Gleixner <tglx@linutronix.de>
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
Thread-Index: AQHXtxXjpXjC3Qk5Sky+qg9KSaDYk6vAQgwAgAAEuoCAApcLgIAAEZ4A
Date:   Mon, 4 Oct 2021 14:47:52 +0000
Message-ID: <AB9AF2D5-D53A-44D5-A5CF-B66F7C685387@intel.com>
References: <20211001223728.9309-1-chang.seok.bae@intel.com>
 <87mtnrgkij.ffs@tglx> <5677A76F-82AA-458A-A910-C92E8B0C1061@intel.com>
 <8735pghpkg.ffs@tglx>
In-Reply-To: <8735pghpkg.ffs@tglx>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3608.120.23.2.7)
authentication-results: linutronix.de; dkim=none (message not signed)
 header.d=none;linutronix.de; dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 648c5e63-f0b7-46fd-54c7-08d98745f1c6
x-ms-traffictypediagnostic: PH0PR11MB4904:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <PH0PR11MB49042836D6D6900C01FE4047D8AE9@PH0PR11MB4904.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1728;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: /NJV3hckxnZkTWRGjJ8GLpxqu7IcANU1zO5EOjfhqrVxiXBJhO30ou2t0hyPLetk4rfpWqaVc941V8a2pFSBP3rRgoSVJMMo67auGJ6+pObKziybTUjRmBKAt/6DpVfjF1mUMKsQS2SXrh3laD2Dt2XRNtPWTHwexCSzDuz3zEO4QT+ze8Lc1eq4oW3swAOTZmWju120wA2eno5xnrL3eKcNWpWDE4TdTtGwvsXdgcSu/KEf7iL3tChxKe9Z/3UVz/SrrYif+l4MvxDgPwHM5gvVri3nYifpJJB6/QazMeee066zX2uFXFInrOsRIShesrcXy54brFM4rg7RoS3bp9iirYkcpe0tAhAOx15v05oML/v4LsRER5q6BbFpYnn7JMHvFnV6Qbs8zWhhzsb8YqSP2S6u/4qpKMcIG3bsUh/hNKQfW16XrLzXXtQro4RcHpAWABzL4QfZujm9C16uEln1lT3cPH8rlMF1lwh/Ns8j/i377ztkv52ucxJuaMJtz5e+6C6EiVSQrxWPJmnvgYawi1LrgRwz/hJXpeu2T8d3EG/V730K0sITYYV3Ii/4vIG0ndqCbeEYHYKI4G5w2ELKjs22LtjfXst46HjV/eNNVt5rI5hn8Cm54yuh/mgi5j3CGtsF9vfOrpa5hHZD+FmlISpw3nc/OWlwbDCT+ZzuXBlMIMO/u+4wTzsWM3V2WbGzEioBaQm9WHc/SMJMO1zZOq6t5ZQoJn7E3hS+oH6kc9iPeFEaVHtgJnZ5h7b8
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB4855.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(2906002)(6506007)(5660300002)(6486002)(4744005)(508600001)(71200400001)(53546011)(2616005)(38100700002)(8936002)(6512007)(4326008)(122000001)(54906003)(66446008)(38070700005)(186003)(86362001)(6916009)(36756003)(26005)(8676002)(66476007)(33656002)(66556008)(76116006)(66946007)(316002)(64756008)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?op7d0DMUSYt5FkKwy+QRyX9qzTaWN+awFL5lNZy3QadGnSWo0bx9Q+Xm9rgF?=
 =?us-ascii?Q?4ox5uiFmdD1Cg/JFCCDjPJof6SaJ4K1n6FSRDkhMahFjm0C/5JqM17BNg6Wc?=
 =?us-ascii?Q?C+aWqFhDWogqOS/aQD6/5o47GxykAxfm6a3tikQpKLLca7vSdE5KgKfewIBr?=
 =?us-ascii?Q?l3dThzRQhGp1XqfhRIqpQzbhke1z2iLKJ2w5+1QP0HJr5Z7uy1VOsmcfKIPP?=
 =?us-ascii?Q?PLe/TZlU24rnOftihrlPQrR27NV/3QTlajhXlGSdn1gqHyyxTECYFs7qbrCd?=
 =?us-ascii?Q?gqfuA1aHED6ydMPBChUSkRkH+txUfDToIchOYLMfpTk39SfS1trSkYto2ekW?=
 =?us-ascii?Q?2Xq1nRAmo7cBYebmV6Us+Ri6BEvaTP/ShdUi1rjm58cdRQRroznpCApT55JI?=
 =?us-ascii?Q?RO2MaUHRb1i/SFDoF6PZ/myMhT2FcL0Xbl4j7+cvGVM4h5crgFB4Px0EzGk2?=
 =?us-ascii?Q?6p1TXABvEKjAsCHu/LpVcP3crrHW5AQ6w+BBbbsovbjG8htCBaG1xdC+Q40h?=
 =?us-ascii?Q?1aM45j4yQewQq8GbArsYHvZsxfQksTZlggxo0Wj4J4cFvK5SABOxPasydEaI?=
 =?us-ascii?Q?HV72OD7/TtHw7Sgmu2tkQ87apu/vTC2yC5XnoJ2WpGi8LDSHE0x5r3/7U3NT?=
 =?us-ascii?Q?t5thcnI18gqP5oRgQiGUSSfzbpZ49mvPzO8i8GKm3KuTzErU9DvhTfHNmljp?=
 =?us-ascii?Q?TBh1MOR+wuXsquXC4iIlPqlDknyZLtvG2ddOMNRU/1DhVcPrTtTF7BMFvbD8?=
 =?us-ascii?Q?GrErWJJaEg5ZMn70LICTDeZGB1OhoOlphb6mk8aOcYmchuRTwuAvaXO+ZefA?=
 =?us-ascii?Q?jphFSCCxKFXZuKwznKenSJpku7/IruSLTEzzheMssd46vY45Enf/xLBqeBki?=
 =?us-ascii?Q?Oms/9t1liAeZtYEuqAR1iT4GD7bpBRXZa3+KTWXGQ7Rl6BXbapEhUwBqgBN9?=
 =?us-ascii?Q?aKu4TkFElir6Swtr7/8h6oFyjwZ1Jo99MUvBGEQdBfsQpIaKkVmK87RP9oay?=
 =?us-ascii?Q?QHTZU5RSrCxQbt00VkZ2Y3eO9PAdnBnhP77KB57zsi3nR1XfqBsbHDezQH/P?=
 =?us-ascii?Q?CRKB4D0zNdRoBWmQUISJl+ewtqqoBtidZ23o7Y9whfscrd6BAzBlQNsR6gbO?=
 =?us-ascii?Q?zXoA0W79e97PrchGJI+K8Z0JHsRhQZXL1FMfo3zWqysUXEdt5SgkZyT5uPNe?=
 =?us-ascii?Q?3CTlj5Vflfc/X52Xk48Y19kXc/iuFDenBTcgOEdvKLa04XkqWuZ01NO6vJ/x?=
 =?us-ascii?Q?PVlDkHjV43Mnv+tNGiVpaRF3+Li4gAPWApBzlgTbVHbfzgiUd1f9Ovg/Jq4d?=
 =?us-ascii?Q?bTdZXjwmLkciHSZvV9Qfv9b9?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <C282FDC7B221544EB59462AF7796CA43@namprd11.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB4855.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 648c5e63-f0b7-46fd-54c7-08d98745f1c6
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Oct 2021 14:47:52.7231
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Am+/CAQoTx0vz1rxpO/jsFnyGRi2mfsjxnaAdRu27a2rYBi8SFE7TKnd6NydpPo73Dtg15psDEckc5WveXSBWHtO4F7PpWeC2fVlR8lpcuo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB4904
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Oct 4, 2021, at 06:44, Thomas Gleixner <tglx@linutronix.de> wrote:
>=20
>=20
> I know what a base commit is, but this still does not make it apply on
> the tip tree which has already 10 patches against the FPU code applied
> in the x86/fpu branch for 5.16. And that's the reference tree not some
> arbitrary chosen base commit.

Sorry, will always make sure the series based on top of the tip tree.

Thanks,
Chang
