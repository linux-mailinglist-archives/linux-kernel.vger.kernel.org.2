Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 13C8C4211ED
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Oct 2021 16:48:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235084AbhJDOug (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Oct 2021 10:50:36 -0400
Received: from mga17.intel.com ([192.55.52.151]:15996 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234744AbhJDOub (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Oct 2021 10:50:31 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10126"; a="206268003"
X-IronPort-AV: E=Sophos;i="5.85,346,1624345200"; 
   d="scan'208";a="206268003"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Oct 2021 07:48:42 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.85,346,1624345200"; 
   d="scan'208";a="523342223"
Received: from fmsmsx605.amr.corp.intel.com ([10.18.126.85])
  by fmsmga008.fm.intel.com with ESMTP; 04 Oct 2021 07:48:42 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx605.amr.corp.intel.com (10.18.126.85) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12; Mon, 4 Oct 2021 07:48:42 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12 via Frontend Transport; Mon, 4 Oct 2021 07:48:42 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.169)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2242.12; Mon, 4 Oct 2021 07:48:41 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Brr3yIiYD/nodL2NbEXu3DzhTVinBzeTjfzlsI2hek1LBZzGwMxHrwRDtIEfAUP7aYwNt8p5gBpyNcI6LvTy/QmpMOgSrY+lPSFP1oooBWYTZJHy4HC4r5ZbZ7Owv+Ak2WxlAfwAzFphf46lUuyQp3ChaDt01xbRVxnvnm7VszsnCc6pr1JRlBkZWre+//wIutr0ioN2QMmEV1y4QrVH5gNmI+40TwnxMml3zMciRa2RGWYSn2MR13yfCM0RVDFwsaoMziRoFcZZC4A7qk9sCl4mngamtlyPpVdZiGtVDGyF8ksTorPO5ZuVBNXcws3U8Z1ZgRAjr+kn9hqoHPFTLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XwS4n72GRoHYYj4lbf0EReY3pVXPN2kxxdNc/UWZFJo=;
 b=FOg/Omr6fpIpUE/E90u1oguQ73SyCPueVqKIixgyTyLT/8ClaqpqQEaEl/hGXMsKko+L+YeKAJXwxxUrkAycCzfPneQmO+BpbNEl0vh17pfOqexRLaHuKk7TKdHMM8/zSN5tLy+GMJjE9v3VSEIk9F+8k53bd7pKHxe53Xr9jnzvLud0uYxjAc1fd9C3Ve+vql+/RnJVYMoXpkJGL4taTy+nXFe7BZ15x1fccOBzdOvEah7fBc8afznfZE9QifqNULQoPvP8x7/p+tg7sC3qAlAcQhPrkfxfjtKgEzLAOr386TmkuUMjpCR8MM/d7hLRGXwW6GiqfWCHoY1VtdPJiw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XwS4n72GRoHYYj4lbf0EReY3pVXPN2kxxdNc/UWZFJo=;
 b=VXKED08vgu296bitvMDmIpv3xh/yBmBWsPX3xornroDw2jTzNlx87HQ9k2M+ZhlD7uvdczwiQGSN+1H4wgTFohV+OKl0GcRiiSS0bhTAiNf7z09Sou41gcM0P5OY/iEX+ji2fYVxSAGFKT7ap6xqpUtIgvk/9vzQ5asgJ+I0VUw=
Received: from PH0PR11MB4855.namprd11.prod.outlook.com (2603:10b6:510:41::12)
 by PH0PR11MB4823.namprd11.prod.outlook.com (2603:10b6:510:43::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.14; Mon, 4 Oct
 2021 14:48:39 +0000
Received: from PH0PR11MB4855.namprd11.prod.outlook.com
 ([fe80::b427:a68a:7cb6:1983]) by PH0PR11MB4855.namprd11.prod.outlook.com
 ([fe80::b427:a68a:7cb6:1983%3]) with mapi id 15.20.4566.022; Mon, 4 Oct 2021
 14:48:39 +0000
From:   "Bae, Chang Seok" <chang.seok.bae@intel.com>
To:     Thomas Gleixner <tglx@linutronix.de>
CC:     "Brown, Len" <len.brown@intel.com>, "bp@suse.de" <bp@suse.de>,
        "Lutomirski, Andy" <luto@kernel.org>,
        "mingo@kernel.org" <mingo@kernel.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "lenb@kernel.org" <lenb@kernel.org>,
        "Hansen, Dave" <dave.hansen@intel.com>,
        "Macieira, Thiago" <thiago.macieira@intel.com>,
        "Liu, Jing2" <jing2.liu@intel.com>,
        "Shankar, Ravi V" <ravi.v.shankar@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v11 00/29] x86: Support Intel Advanced Matrix Extensions
Thread-Topic: [PATCH v11 00/29] x86: Support Intel Advanced Matrix Extensions
Thread-Index: AQHXtxXjpXjC3Qk5Sky+qg9KSaDYk6u+v02AgAG4KgCAAngwgA==
Date:   Mon, 4 Oct 2021 14:48:39 +0000
Message-ID: <C308DBEA-8D08-47EF-AFC9-B0D3B95AD61B@intel.com>
References: <20211001223728.9309-1-chang.seok.bae@intel.com>
 <89BFDA7D-C27F-4527-B494-1397876CA6F2@intel.com> <87k0iuhq8b.ffs@tglx>
In-Reply-To: <87k0iuhq8b.ffs@tglx>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3608.120.23.2.7)
authentication-results: linutronix.de; dkim=none (message not signed)
 header.d=none;linutronix.de; dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 18cedeae-9491-4563-a891-08d987460d7e
x-ms-traffictypediagnostic: PH0PR11MB4823:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <PH0PR11MB4823FD907C1062AE31CBDD9ED8AE9@PH0PR11MB4823.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: stOdpKt0oqk6umcJXcfpzk/bojciD6Q3yqB+po20ZfD/6NXU8kxM4aT/mS7SZn1fE+SvdYDXY5gMIUerSmgMUqHrkKwbcjDve/8Kbqsf4HiDA4Rkg+pNGXzFs+KTLzmxhE3HMNig39j/DvGFaIwuQpct/9zhOMy+ZEIJOgdaYV1/afJdgwNTgPdsh0x50OUTh88KRLy++orrsxEdIwcpE63/iHjySgJDXAf7+7B2+Qe/tUQ6X3w+y0g6IYcFcp24dbvVriz0QVVNxNrif+TXRoec0PUI5KU9CWaeD1eMbHAA0i1m/7ELltI+5XV6mT4bdpGC3tia8XIvfydKAeUI4Y5uka+GsDoe3VjUfPVZmKMmCkwvUUrrqZvK5xvZ0izUUPzg9/yR25mhzayktEaaPfRaTUh4Ju92RnJ6zDpdtM5ufJUZcY8b5GpZrRXxmpVy6aVQ7Af0T7XRnlBXIy0iceFpAb32mexg8wXEHX1RMfe2Lb+4+9FlIM4hYPWUpIbNUK4suRF98YjOSMu0ivk+bUhM//V49A4gTf7s+CR9WTlyuLGLFRSK9XS9Ofje96AN/t0iMyZFVg5cN+O84epb1k2fbG62a7eCEHmBECj34r4dKeMNxFRTdlHluHkWI+63kRXujX0TFviNRvmIv8iinduVE4bVAe1tVIBTUjQWov2R4e2qUXNwOAZmjEUuogWIjv5XdwizeB7ii5PWXI2xeeR1iaQ34dvsDpbVKvRzU2d4aMY3jHJw1sGfJHMrVmt3BOdRy45Vw2vThSL4jDz80uOYTc0y5SgQ0TrA1oi+6cJceNsCoApRD9JriFcdKGL4aHhZ0D042Cofk7lOpMPh0A==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB4855.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(6486002)(2616005)(8676002)(4744005)(316002)(2906002)(508600001)(6512007)(38070700005)(8936002)(38100700002)(54906003)(122000001)(4326008)(966005)(26005)(86362001)(33656002)(66446008)(64756008)(6916009)(76116006)(66946007)(66556008)(6506007)(53546011)(66476007)(71200400001)(36756003)(186003)(5660300002)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?0eBKnwoiPj7vfhPl+jxWm7LM1Nbs40Vi7ixVVXQ6cah8kaXI37QR+g38TpNi?=
 =?us-ascii?Q?9P4fJvIZdbxQP3hcYOaH21+ibT9To1P5xYkznMapbQs8qOl9KWq1/RDsP7mo?=
 =?us-ascii?Q?e/Ax3o6yO0/Dy52TefH8jxiTanGKYYv4c1IT6kgVADZM8miWyNwZbZyvKKa8?=
 =?us-ascii?Q?8Yp8dobrY6TA8oy42aRyzLNkUdZC8t1YCwo/RrGYRX4JUKh4rwHvmFcH5YKA?=
 =?us-ascii?Q?lBLRXihc5AHsSBS2ksXeB4XSimp5WQXL+bU+aQm+RiMfpvG1Po9jiGU5xoM4?=
 =?us-ascii?Q?P+A16OPGbP6EolU0kZXdW3d7pANW+eaaH0oaRcjCUlsLOLFaEtR1ozN7G2Yb?=
 =?us-ascii?Q?/XBlVpF6XLq66XxJRMTDtGBzzx0Xf/veK4HNgT574gmEtwWcXlPFlWsfeDFA?=
 =?us-ascii?Q?V2HNKbL5nBokOZ/e1fDBEDctcgFMGaWJZwLmHLSTQiwCF3wEHyN4JpEOo30/?=
 =?us-ascii?Q?Leq0NTEXAce7ivP6duT3fx4Cykiq6Gedmqqu6wwluHdFojYkWkdNxvMdO24X?=
 =?us-ascii?Q?IismpCFbBxX0bpUaMizLrgMcX72jTndDz5BZu09FHzooFuse/ykflNnFe7oE?=
 =?us-ascii?Q?nTEaclnKLxaw19pdso5CvNUQ2u1zrnEzGlRNmnh++eg8I/XvgB9EyX4euxEL?=
 =?us-ascii?Q?/xO7jdF1r6u9bXIfx6JRZrpDiTAsrRDCgCouo8C2u6p9Yd1SeUXf4gQVPx8I?=
 =?us-ascii?Q?5IO58Q8k9ZIWo6iVdTPBbOkTTVGlLwWWRwj8hrWRjAkK0HRj3EVO68Zs7Wji?=
 =?us-ascii?Q?WQwRXRiU4YtN2XWrOwBq7lASnswXN88lSCxHdOpBTfpSVyQgMAiwyM0KX87M?=
 =?us-ascii?Q?MPwHSkamqcMDtGlMJzRLicbLCGg4WpZA/3oD9RbLoJhGSPVKcIrplBktfcvw?=
 =?us-ascii?Q?KJqdsOZ+iMc99qlXSZqW7Eq+ZDpIekHXXkWQqC9nUEbl0paFlkjD+VntDXkc?=
 =?us-ascii?Q?jO9LuPwvTTene9NW3NbufEsnrI/7EOw/pdJQERMsys2nI/gSSwjGSCO0tZqk?=
 =?us-ascii?Q?j2rgWyD+nlqYtJrSkQa0d/8fkudqK6ZMPA05LyS0SP9NGDZ6q3iR95XKUnx8?=
 =?us-ascii?Q?hNa1/rJB9my3pje8PC5fmb1QWhP9ty0JtqfVa8CRj5n9RXM9tlkqtqt9iV5U?=
 =?us-ascii?Q?M+08naldHZgwg/S7EcdYnOh96uAPHXno9oROKbMCMFe5BbmzDh8BdO7Qf3pp?=
 =?us-ascii?Q?h9UIhGDgCyE2PxwWAe+Hmc+109Ei3aZv/a4uZKSozOd1T2qL8K35XzvomlG9?=
 =?us-ascii?Q?RJirPADxvS11gNMdL3kMWN+hhJsAJdzbxV/Z6xhMLOutfcE+cSXrok4Kw9DQ?=
 =?us-ascii?Q?6UA1/u/Ww1lNI37ikiRaOJsA?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <D62B78B8FD71EF45A02EA344E6466A51@namprd11.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB4855.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 18cedeae-9491-4563-a891-08d987460d7e
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Oct 2021 14:48:39.2246
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jIttnt3j+WjR9bOwsDWZEQeDzfNTGiipYsAbDpu+Zc1/lurVyO63FeLuXhFKBNmYH/wUweIrb6fX3+IitdRMu6LbMpEPdPEsUrqQKsbXaKM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB4823
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Oct 2, 2021, at 18:05, Thomas Gleixner <tglx@linutronix.de> wrote:
> On Fri, Oct 01 2021 at 22:50, Chang Seok Bae wrote:
>> Sending this version as it follows up the discussion [1] with some code
>> changes from v10. This is not intended to ignore your comment on v10 at =
all.
>> Appreciate your points on my oversights that I will address in v12 soon.
>=20
> why on earth did you make Chang send these patches out when there are
> fundamental review comments on the fly vs. the previous version?

My apologies. I regret sending v11 as fundamental rework is going on, that =
you
shared in the other mail [1].

Also, perhaps it might be a better way to separate the last patch in
particular. Soak out with more eyes on it, then send it as RFC at best IMO.

I would think right now to focus on helping your rework and addressing what
you pointed out on v10 patches. I will revisit the last patch later.

Thanks,
Chang

[1] https://lore.kernel.org/lkml/878rz9gdbb.ffs@tglx/=
