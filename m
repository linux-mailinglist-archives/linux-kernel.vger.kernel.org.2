Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 661143B2431
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jun 2021 02:07:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229831AbhFXAJL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Jun 2021 20:09:11 -0400
Received: from mga07.intel.com ([134.134.136.100]:63271 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229726AbhFXAJK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jun 2021 20:09:10 -0400
IronPort-SDR: maoU2RQqpc7YFtX/telHzwMQ2kmUSaqu1cmJCBGmS70uL4eNhnS5jjSYDob2V9SedrvcYk3e8r
 dCqUgj4s3uEg==
X-IronPort-AV: E=McAfee;i="6200,9189,10024"; a="271209283"
X-IronPort-AV: E=Sophos;i="5.83,295,1616482800"; 
   d="scan'208";a="271209283"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jun 2021 17:06:52 -0700
IronPort-SDR: ZJwHKd27IvDabkYHZwZa6/ZR+h+MbbxXaQslgQk0l4sPqSIGy3phauGecO/ebkkCQL94PKNKIw
 KXuhCwg8UxBw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.83,295,1616482800"; 
   d="scan'208";a="487537221"
Received: from orsmsx605.amr.corp.intel.com ([10.22.229.18])
  by orsmga001.jf.intel.com with ESMTP; 23 Jun 2021 17:06:52 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX605.amr.corp.intel.com (10.22.229.18) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.4; Wed, 23 Jun 2021 17:06:51 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.4; Wed, 23 Jun 2021 17:06:51 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4
 via Frontend Transport; Wed, 23 Jun 2021 17:06:51 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.174)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2242.4; Wed, 23 Jun 2021 17:06:51 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Aj9Cc7baL71cq9BZ3aURB41hG95/jQE9+fytbwDb1Jn1QNNKRwP2cT54kEzZDyy/zikzQ01fWw23h4JKn3GW67wbRkD0rnXAkjxGTeIp8rAecdPK/nmhOqesrCqzbeBp3Ui4j8MAAxuVK7GXd1HLwn6Ll1k4St6HQdQk2YB1BR9nNaP2lqqqlnChw+nbxtDcMMMf6VAKm9QMZ1XjhovG8/r0Drzvj8o/gZ8qOthcOWMn8NSV4oGREUw0zPwGNlCd3n1JidlsBfFiYLHIdcd5qHURz/ocKpFGE1GX6TbyT2PFnuSAlCxjoShlIQuOBWVP1jvtQ+cLA631FKdSi59Zzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BtMSqQhI9faeLmfaAzW8UrA+O0ichfHUSBuo0nrj1oQ=;
 b=PdpvyoAXj6uvpgEzpZLfOvFbQmBettXO8eXOpz7zE0/Rowwg1x6Prfwba0iWAJfgiGUdA6ErFhY0dJqGDjRGNNqanw2xc8P3r+M7JRHkwzjehHW9c0ssnafIOLDm76VxEIFUCarNHLdFclka5ssMA0CcZAfSxm1e92ihzHRItDEsy/fkPHEDV/pDEEszAdLwgyi4tictZuaxKThk95Cq1IC4hnq2tugxAPQ/XmNnmrKmfZQ+uTxDr6nWMlxseAYjn0MkNwJ8xz+oNJitm0mIZ8wErap6kuT9zjpWVCUV5A4PY3NH5YNXjI39ij02aLUl/UQUdFaZ1J+2sLX3aFLzWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BtMSqQhI9faeLmfaAzW8UrA+O0ichfHUSBuo0nrj1oQ=;
 b=N9cxq2P6kuBNZKvDoA4x2KHaxIxD/6sBm6EiQoNKUaB+zrqvM4FJ6IDdsoTD5Pp1TaixOlE2G5oMXO5N52DIrz4JXNqoeI/EGDSTEEM8afLVOS4LoF92GUszUbIxuKh2F9Jagw6yYanm9qZsC2zVfsenD6tRKSFu2zRdeK+lUDk=
Received: from PH0PR11MB4855.namprd11.prod.outlook.com (2603:10b6:510:41::12)
 by PH0PR11MB5061.namprd11.prod.outlook.com (2603:10b6:510:3c::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4264.19; Thu, 24 Jun
 2021 00:06:48 +0000
Received: from PH0PR11MB4855.namprd11.prod.outlook.com
 ([fe80::713b:33e5:9d50:194]) by PH0PR11MB4855.namprd11.prod.outlook.com
 ([fe80::713b:33e5:9d50:194%6]) with mapi id 15.20.4264.019; Thu, 24 Jun 2021
 00:06:48 +0000
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
        "Kan Liang" <kan.liang@linux.intel.com>,
        "Brown, Len" <len.brown@intel.com>,
        "Shankar, Ravi V" <ravi.v.shankar@intel.com>
Subject: Re: [patch V3 00/66] x86/fpu: Spring cleaning and PKRU sanitizing
Thread-Topic: [patch V3 00/66] x86/fpu: Spring cleaning and PKRU sanitizing
Thread-Index: AQHXZuvcsriNBxeowkOiSeaxUGQ97KsgdUEAgAHWiwA=
Date:   Thu, 24 Jun 2021 00:06:48 +0000
Message-ID: <FF79EFCF-5D2C-4F3D-AF94-4BC2F7EED255@intel.com>
References: <20210618141823.161158090@linutronix.de>
 <B345FDEF-7C90-40D8-AE9E-58D783B22670@intel.com>
 <73A33E4D-2D7C-4B79-80EB-952E7B754655@intel.com>
In-Reply-To: <73A33E4D-2D7C-4B79-80EB-952E7B754655@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3608.120.23.2.4)
authentication-results: linutronix.de; dkim=none (message not signed)
 header.d=none;linutronix.de; dmarc=none action=none header.from=intel.com;
x-originating-ip: [73.189.248.82]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6a24fc6f-ecdf-448f-fe0b-08d936a3f603
x-ms-traffictypediagnostic: PH0PR11MB5061:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <PH0PR11MB506119971DB01AB6FAA903CAD8079@PH0PR11MB5061.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: muSLZdhI/eCx1ZAYL2Ulztdc3PCudHUpUc4tgko0WxVyd5JXIvFkBknTrYkVtyBq0DSVHvjkye13E9hXsgcRApucTQqpl8F/7FBvgAe+T8MDAECqxoHlUXKWsNTOv8wZnmMKiRgkUj97Ga2kPILGfeanA6qALMrgRO9sQGundJpYoGgaie57ef0HhI0rXQm/EXrk1hOjeIAOVxhDC78/9xLJvLTXY3nxMC878YGfN7W086L7DTuZsSQvvRHq/XxgIhKJ8FZmHkPIK5B2wmbfBtBdwjmaKD9/WCZALGZXhj4cupWPonarBBGhI3cf1G+VPCnEmFkeVZGjS9llxahPfzU7dIfXF1b641LInvF9xmK2GIiRJ9VQWnAKWOG4QXVReHjdE3uv/ENMjKowpbGV56NhPNhCRq91z16ToL716yEcPKnXKJYNgL7iNnj+LjNc4PN0RuOy7PBuiPPA99osYWUAIo8fUiwlLB+ZynpzFq4DehPfu+4FabSK3k2NM9Kep1VljmUzVjMpFBACfCsh71pt1Nq1Jg560ijmTmyN92VdR/1BZkzD0R6ZP3p8sTR9/+KNdYvsmmcH0EDd1WTQ31Jc85xi5FXS0VSqEzc8k0uAeyCAo54XJpUvYN5mOYmYS1SJQKp5+Su0z0ztEziXFmW9/5b6cHmKfA62CP8DIkstKfWuCvdM9vQMFMH5D6R6/P21REEuJQu5frEeygzWf/lK4C0JF1GVCBI69TdrMLmdteLefbVvo/xqbbuzh+sr3Pzg+Q914gKVkfgCDdFNwEhnAXdQ5lDeTya5R1I7uL4=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB4855.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(376002)(366004)(346002)(39860400002)(136003)(396003)(8936002)(33656002)(66446008)(64756008)(66556008)(66476007)(6916009)(53546011)(36756003)(6506007)(316002)(2906002)(54906003)(5660300002)(86362001)(66946007)(83380400001)(478600001)(6486002)(2616005)(71200400001)(122000001)(38100700002)(26005)(4326008)(76116006)(8676002)(966005)(186003)(6512007)(4744005)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?bV1aaSNMOmH3K3r4H0/pfU4AzBzXct7Sow9dTIKyh+/okhEFynzGSBryyRyf?=
 =?us-ascii?Q?IiW6pQnWR389ob83EGooXi4cAvuExnQPwBJCe2KykBeaQF5S6IJ1z3mU4UsS?=
 =?us-ascii?Q?V62vD96cj0TEEPflXCt0itINMNXKjqkklqvDNtteIlfiyeAjcWFeKFgiukx3?=
 =?us-ascii?Q?cbQvqqUrqV2F8okVzDuKwaAlOrxHJO/obf5DxNtrUVlDGf5Q1EC0SnCSbZWC?=
 =?us-ascii?Q?38yCLmy6VS9cdT4pGt+H41qKdrlnqgoy6ekjLszgQ2b//iBm6+9/p30EQO5U?=
 =?us-ascii?Q?SJyPghcJyGGeiicSpBFmGJ2evOdoJo2Ztq5QgE6MRdJol3v982skUytW6sXe?=
 =?us-ascii?Q?jmAeGUo+9rLs/htotYegGDd05qAezlg32NItPyJkSx0qOoqgw2NjrojjMkds?=
 =?us-ascii?Q?0fV841i15SrC/DqlU03VxYP9kxmqTdM44TjLMdhdcSrLqFuErsrAKgntOWeJ?=
 =?us-ascii?Q?LUZguKw/HsiFOr0BnBDIFSXzaR093PIblP3R6pKGf6/vtehYkWauhLm4sAeI?=
 =?us-ascii?Q?NWKyuofKiohqfZRbOqs9uQNMKHd8gnrhhIiJsvfCdc2m3vF440uzWeIQpfwo?=
 =?us-ascii?Q?e+0KTasYABhB3v2HpiNwpJpHZhDGEJoG6AcnuA+zQpXsQ397n0q2hh2qSsn6?=
 =?us-ascii?Q?vBZBX84NtCTIe3S+pmfb4LLKaZms+vpWbtifylYgGyr9A1MYR6dSSxRY/rVF?=
 =?us-ascii?Q?DJ6BjI50sI0W87ZN8OP2OFsU5QqjCQ4ytnqH4uoTwFFg0+66omnFXarpdv+d?=
 =?us-ascii?Q?VjtEAU9wj5EC9mORKDnx7FTx4QDopL0pmQ8KpMfWeZKLFSLaHSQZ28YCLqAk?=
 =?us-ascii?Q?gQ883TE5MTgvrW3mfhFj1CZxZFR/qiQBgSxw3lmbrpptzQDYcaBFHeMpICEm?=
 =?us-ascii?Q?HxJSPTWOAVYlwd8JX67JCNcRVmf/fzd61unDYKLBpRuh352DYI83KlQg1dnQ?=
 =?us-ascii?Q?gPgilcVM8eaa8QqSbHs5wvh8oarWmElrIXRhuQ4MRvymJJAEZClYMR/I2m9J?=
 =?us-ascii?Q?JEBMUTZMGIVzZvf02ie1L2ueTt5No694uxox20JrYHlHvbuMJalM1q//jNXY?=
 =?us-ascii?Q?POYXnoNF3yWXzzQZ7UAHcqhnSEZweJ8mwuQnQ01LQrgMdtcEIxlBQf7o4NXm?=
 =?us-ascii?Q?mdwDbrq50AUiS5hC9Q+J7hlySvgpYTmYIVGrI49eznL/XosuszP8ybYoTIUt?=
 =?us-ascii?Q?n1lOhElzqbJbiPDlXqgfVN4rJ296blx9vrB1K4/tKF4MlAOr5Boqq1VW2H9I?=
 =?us-ascii?Q?z7SelwZEgDFikPgUJhZmTN82ut6wJk2KzvgK6fNXoTma4F70390LRtxY0aO+?=
 =?us-ascii?Q?u/jPPVyUN0VoUPYNx2+lKkKm?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <2717E48063076E4A95175D79D7C0950E@namprd11.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB4855.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a24fc6f-ecdf-448f-fe0b-08d936a3f603
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Jun 2021 00:06:48.3178
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: aB+SIhauYRPSrv5clJKX9TlldS4XQPemrXBtHUEmfZHuEZdT9wFE9jDNWmgkzXmxJeJxD554VBaEjxK4Ojd26Q17f6MSIixTI+WIxj1+f2k=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5061
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Jun 22, 2021, at 13:02, Bae, Chang Seok <chang.seok.bae@intel.com> wrote=
:
> On Jun 21, 2021, at 15:22, Bae, Chang Seok <chang.seok.bae@intel.com> wro=
te:
>> I tried to apply AMX patches on top of this. The test looks to be okay b=
y far.
>> I will also give an update here if I find anything.
>=20
> This looks to be vague about the test. I took cases shown in AMX v5 like =
this:
> 	https://lore.kernel.org/lkml/20210523193259.26200-24-chang.seok.bae@inte=
l.com/
> It validates AMX state with context switches, signal delivery/return, and
> context injection via ptrace.

Also, just for the record, as the next AMX version is imminent:

Lots of AMX-related code are mostly function name changes and I had to
readjust my assumption. (Maybe this is not conclusive yet as still digestin=
g
the code.) But I think the rebase went well with the test results, and this
change improves the mainline in many ways that affect adjusting AMX code in
the right way.

Thanks,
Chang=
