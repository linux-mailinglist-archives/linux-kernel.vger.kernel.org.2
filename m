Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 82E813B0E05
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jun 2021 22:04:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232464AbhFVUGW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Jun 2021 16:06:22 -0400
Received: from mga18.intel.com ([134.134.136.126]:7861 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230381AbhFVUGU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jun 2021 16:06:20 -0400
IronPort-SDR: D53dt/LJY+iEOVBD3z59kYV6En59MmZcGJ1jHg9Fvbq2BuDeGvQOLUeIdH7Y1/tf24kocxkKPi
 nCLjT47BG5eQ==
X-IronPort-AV: E=McAfee;i="6200,9189,10023"; a="194442352"
X-IronPort-AV: E=Sophos;i="5.83,292,1616482800"; 
   d="scan'208";a="194442352"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jun 2021 13:04:04 -0700
IronPort-SDR: l0ZWDgrAG1/CFr3fXtn2UGOrnWwIqj8iF1fYKc1b4Mu1cUouguGRqqMnQTpP/I++Xbe/EB9T/j
 VjWE/zOExsNw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.83,292,1616482800"; 
   d="scan'208";a="639219924"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmsmga006.fm.intel.com with ESMTP; 22 Jun 2021 13:04:03 -0700
Received: from orsmsx607.amr.corp.intel.com (10.22.229.20) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.4; Tue, 22 Jun 2021 13:04:00 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX607.amr.corp.intel.com (10.22.229.20) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.4; Tue, 22 Jun 2021 13:03:53 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4
 via Frontend Transport; Tue, 22 Jun 2021 13:03:53 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.109)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2242.4; Tue, 22 Jun 2021 13:03:04 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Hl2s57Aad5+WpE1nDsCYulQF5dWyyX6OFlbK9z91fjqDCP3Kv/zMvLOBOV28gA5E8guvDMbfZiIslVq3+nlr/Bxd4ju7TJTI6kygwV1R5+W91YdnaTuKUWFpZycOn10kQ1pOe37XaFZHRsO5D3yUBeumoRgtgCG0t+N3x11QtlZelRtOxlLcGy7HVf6WSY6vbgTmkOk9QrjyB81dum0VuZheAvphuhgxUMzDKXTn2Vq8wMjtuPLWZR8+76K7npdeSYAg5a9t1RPw55Mxs472QjdAIcUxyto0EUAl6Z77crD3SYviNu+E3mPcDzIc7nVuzJpVqRilowzqDhEMXJ5nkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YpH7uHnILsTKYRvVeR9nBH7eYoPR05zgQEno6DjFy/o=;
 b=g/GQRe/Na+K69aoeIB8aqR/Vj5SYBrdrASZPaQFhbHQkuwIMto2pz7aTXmPYsIc/1cuMAWEofY6JiQnsqthTEvW1ZBsQ+bLGDWRQ+Q5mM4qwW7dvKEXaHc9GUd7N+SrtvzAzYLk+wNm0RJz2U3XONOpphts2fisb5pXjVysmpQZjl4WZ9X5b/RUI/9i980BATO1BIpze99qlwGGBQJnRxp5y5n8f73vZnMacQFuBCpsVAEMu/E2zZQBk1baaOKOPxshpIXcymCs5luF2V6/rnNAm/IfWuvpADT/enn56SBP0LaB/KKPw8RjTlCWJS5H9XuN/ZladZ6kRC0Xx3+OLeA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YpH7uHnILsTKYRvVeR9nBH7eYoPR05zgQEno6DjFy/o=;
 b=l+jEEktIqMGjJwsxB3ZV7Dha7ANH6j9WlTRoBpw/S+4XrRs4mHPQ/BbSFF8kSvXatRQhUlB3+PqAatbUa1qqKPMm9F1F1JSs/z1OqBV7iIaz/5w6lc1HMAidYAbPIl2xG+NxzkrrrE3l3iRTewec/TaCnKFBh/YEGmsoYVG53+g=
Received: from PH0PR11MB4855.namprd11.prod.outlook.com (2603:10b6:510:41::12)
 by PH0PR11MB5126.namprd11.prod.outlook.com (2603:10b6:510:3a::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.21; Tue, 22 Jun
 2021 20:02:39 +0000
Received: from PH0PR11MB4855.namprd11.prod.outlook.com
 ([fe80::713b:33e5:9d50:194]) by PH0PR11MB4855.namprd11.prod.outlook.com
 ([fe80::713b:33e5:9d50:194%5]) with mapi id 15.20.4242.023; Tue, 22 Jun 2021
 20:02:39 +0000
From:   "Bae, Chang Seok" <chang.seok.bae@intel.com>
To:     Thomas Gleixner <tglx@linutronix.de>
CC:     LKML <linux-kernel@vger.kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "Yu, Fenghua" <fenghua.yu@intel.com>,
        "Luck, Tony" <tony.luck@intel.com>,
        "Yu, Yu-cheng" <yu-cheng.yu@intel.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Borislav Petkov <bp@suse.de>,
        Peter Zijlstra <peterz@infradead.org>,
        "Kan Liang" <kan.liang@linux.intel.com>
Subject: Re: [patch V3 00/66] x86/fpu: Spring cleaning and PKRU sanitizing
Thread-Topic: [patch V3 00/66] x86/fpu: Spring cleaning and PKRU sanitizing
Thread-Index: AQHXZuvcsriNBxeowkOiSeaxUGQ97KsgdUEA
Date:   Tue, 22 Jun 2021 20:02:39 +0000
Message-ID: <73A33E4D-2D7C-4B79-80EB-952E7B754655@intel.com>
References: <20210618141823.161158090@linutronix.de>
 <B345FDEF-7C90-40D8-AE9E-58D783B22670@intel.com>
In-Reply-To: <B345FDEF-7C90-40D8-AE9E-58D783B22670@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3608.120.23.2.4)
authentication-results: linutronix.de; dkim=none (message not signed)
 header.d=none;linutronix.de; dmarc=none action=none header.from=intel.com;
x-originating-ip: [73.189.248.82]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a2a78d29-83d8-4b16-f358-08d935b8b006
x-ms-traffictypediagnostic: PH0PR11MB5126:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <PH0PR11MB51262F6049201F6B1E3D5249D8099@PH0PR11MB5126.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: GwuRd+dGpYkRVEtW6eRB5ooAdolMWl+Dxv6yV0MhUB+NK3Y80xoQzJc9PfIgKpgOqZjuYG1UxMT8l+tij3/3pKN3rR9i/DWY3T7RwacWsLmJA0P9QhxLMhr8TdAkBjF+/d2cpaiUoZ/EOJUxYW0Rd1ByITq7GkhCowj5QFwSAV/pPHCcFPLGG91BO/hPLYWPWo/BlBrNKyTsDqU1KfWTeYHcXkF/S3NgnjPxuEV/0sVALjWyuY2MmZ/eKo7eN8ME65em5dBgdQhVuP07GvD/GOUgzUYPB6EQl/qPSj8a/WzxOav2mCZT/rVYMr3DMxgGMopdzLkculSYd1HQ9r7xRd0tOp3R8UBJG8ESu7bIvEWUbIZw4opgrSnxMWVF2T9PT1y2CC6AeDeHoXnqavu7GFgcg+Vx3jcxm6ddNYSH7NOxNfyg2LNFNdmwLmWYLBVnmmjFF90292bqLwXB82W6vaMR9MHhzp7+/J0IKPjQwQzDN4obrPL0W/lvejAiISWwkUHf+cVvN0NH9ozg3/6JeiTRJqBZUnoHd+s+H438cwvBCAV02s0J8s8g5USdaE5yK5eGiyU53oArIeponYHW5EBmgt+ncpLpf+E2IVLbrWQQd9tFrQEvVQwvA94J0zcaAADLasT2N6flN9wTnUbLmeZLjopHrfeRE0ZSjAwNQsWQVoqrPhru0q9mpiGEv4Eq011e4zlv4FWOzX/OcEmJdwFA+LtSvqbc7WNdRHRIY+pV6hVnU6VFir7z9XsfwiKfjUamzo1jIGm22mqXd/1R7L/BYpw7T03jcblcBWt0bmE=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB4855.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(396003)(39860400002)(346002)(136003)(376002)(4326008)(8676002)(71200400001)(316002)(36756003)(54906003)(33656002)(966005)(8936002)(478600001)(83380400001)(186003)(26005)(2906002)(6512007)(53546011)(6506007)(6486002)(6916009)(38100700002)(66446008)(4744005)(122000001)(76116006)(66946007)(64756008)(66556008)(66476007)(2616005)(86362001)(5660300002)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?7Gthph1N9RJmEnQ3VE8w+11C8TjG+tRKapDeJkzVnZSxxk9HyYO6W9SsR7rP?=
 =?us-ascii?Q?1nktPVtpNG9E9rgtDsldSDveu08yes9ilY/kW9iL1+wWK/jQsvM9i7dElaN4?=
 =?us-ascii?Q?w5Lu0iSPIhgApcI3vXsbnAo+Dz2HYxCaLgoG8INXn94I4vhTFgfSigae+oaS?=
 =?us-ascii?Q?v/t9f1+ST/Ww1zIJmQ72s4hrlIimjVC8F36zhPbqkzVI5uNS1F9AQaqtO8h4?=
 =?us-ascii?Q?tw3YsXgIc+y2x6yjCJcJqqLY7Fx3J7JkRvP23qLSPNoR+M3o9KxYvdW6g5AS?=
 =?us-ascii?Q?Ey/yRVb9VtOeK3QcClms1PgyJYyGIzsJHS7gBB6HoheyHxUOS12+VjI7NV/w?=
 =?us-ascii?Q?hQ+Xaa3Bd+5p+qAwWGAyrSzKYGyd3BYvgSTEztH9KGyNGWvR22jS9uChyaxm?=
 =?us-ascii?Q?CiUTxCUMImkhORtPRwLD2wFv2MUe1kKp5PVvl095k7jFLtGAUyVB+1pqiZZL?=
 =?us-ascii?Q?WmM/s7ddgBgByqtMVBeVHd2MiPYx/ZiaISeSgiFoCzpLtBRMRjDHGEPQCQ0e?=
 =?us-ascii?Q?TlAr/VqibOSd0qWtGnBcKkup7T69MXi8tNsuFaIKfejCEme1tN9jR6g0N48f?=
 =?us-ascii?Q?cuLssKmZfpzHF/vgwfVe1ITq6xt9ihTm2QgntqfrfkpEZY8RlNZ9l23DZ1lf?=
 =?us-ascii?Q?wJh1C4FlHS1x33EHL27pYAU9s9rdmp35K7KDJXud6XReVp46q8q9/63MQGVq?=
 =?us-ascii?Q?fjdF7W6jf6mYgbwcpLavyqojPpvS8EVA0DskQlpPkb5M1VobFEdJpnF+sSqp?=
 =?us-ascii?Q?EJoJgouDndKdT8gkyQYjmjnpsl/uF3qzDg3tFLZMUmjE2sPuvd2UFsvB+L9t?=
 =?us-ascii?Q?4ar7g+Wry3OXYS9ompP+w7UZZ3SvyJG+BWvLOQ0d0a7nttsSeeH45yq94C3J?=
 =?us-ascii?Q?RkXnUloLqvlEJniJEsWXeUlW4A3D5jm1goMzulfjvAvRrdnNty2BxpOjHjj6?=
 =?us-ascii?Q?O6IpICmCUpDV5V8Go3gFeXQlXBvQDAN0p7I73qqQCQSRfI3z0BxaejO3hXqJ?=
 =?us-ascii?Q?M5mkMQv4OuxKUjW3HatLeI9JZOE8h/PGZ7emdrStt37fek99oMb8QLYWALom?=
 =?us-ascii?Q?MHSUbILPYHVtv3VULxvvJxJbQac0xgTax2pwFCR7bCViKSA/W5uXtkklE4Q4?=
 =?us-ascii?Q?aOR3RyFrz5Uo3I9LjcisyRuOZ6435vgJAbYQdV0h1WgJddTUKWetXI6fdMNv?=
 =?us-ascii?Q?vtaLij03hWXrn9BXsHmbZX+x7PFtyotLKa66+/XzbEt6HYRYCTdc6ClbGX1E?=
 =?us-ascii?Q?5VPiO0T84537vnmWuVLU0gURLmx/DpEiuOh5kMYmT9eoXA6TbvpEs4mCBZLT?=
 =?us-ascii?Q?pIQ9Kmc8EMYiIjzRgh9l0DWC?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <338ED0188BE81B44A4CB16AD6A6AF195@namprd11.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB4855.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a2a78d29-83d8-4b16-f358-08d935b8b006
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Jun 2021 20:02:39.2219
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: slIi3VCNCSw+Yi/UeIEpa1gRZjbKqyybpyIdXI2d2h0s9VUCV8eQPznlx/RoVtF+Pb3Db6b0aJDJeFKYtgDLSq/J19wJbmG6CxIQQ8OtBtI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5126
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Jun 21, 2021, at 15:22, Bae, Chang Seok <chang.seok.bae@intel.com> wrote=
:
> I tried to apply AMX patches on top of this. The test looks to be okay by=
 far.
> I will also give an update here if I find anything.

This looks to be vague about the test. I took cases shown in AMX v5 like th=
is:
	https://lore.kernel.org/lkml/20210523193259.26200-24-chang.seok.bae@intel.=
com/
It validates AMX state with context switches, signal delivery/return, and
context injection via ptrace.

Thanks,
Chang

