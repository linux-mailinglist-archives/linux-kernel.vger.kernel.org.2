Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 210CA3489BF
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Mar 2021 08:01:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229781AbhCYHA0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Mar 2021 03:00:26 -0400
Received: from mga04.intel.com ([192.55.52.120]:43407 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229695AbhCYG75 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Mar 2021 02:59:57 -0400
IronPort-SDR: Q1U9A7tQGF1N+lR9ALjX5JkEPaRDjvR2MquL2aiVTWyo3fURltIJjKEw9zu1q1uNwygTchwPPa
 E1iMd7XTcqbA==
X-IronPort-AV: E=McAfee;i="6000,8403,9933"; a="188570831"
X-IronPort-AV: E=Sophos;i="5.81,277,1610438400"; 
   d="scan'208";a="188570831"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Mar 2021 23:59:56 -0700
IronPort-SDR: kM/Uxkv49O/dILkhXiz80obM4+H2nP/jtopgdty5up7kuJa0xO/c3tOskB6OGTdiys+7nfLb9r
 TPU5ZIz/q/VA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,277,1610438400"; 
   d="scan'208";a="514493665"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmsmga001.fm.intel.com with ESMTP; 24 Mar 2021 23:59:56 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Wed, 24 Mar 2021 23:59:55 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2106.2
 via Frontend Transport; Wed, 24 Mar 2021 23:59:55 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.171)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2106.2; Wed, 24 Mar 2021 23:59:55 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BZDeAOTXCd/p0NXFsJNG5M4KyaRmMZLBm19Fmzmio5w3q8DksBZoQnzKeTUGnDzlyq4FVsneEWlspaj0Fm2xshevzZ3q7+BKKO92cSogFcTMyb2E3HfZBQ6WxcsLZk4TS2c2fkaDvHwpVG836gAYNnW/y/1SBfoQuvyNI4W5FcWV3wP9ZmuOCaCZFTOoR4VSDtfl0QJqYCUkYbqt1bLAz0koO47Pm8glbOVAbN9mLqWoe7hPZ0VWTHfk1/REV/TLIL4yOJmih8TsGzB091w++sOwgZGEyvkJ+D3lwY36Fck5I2GPKw39QPJlxN+tZe5TceUaW7KX3TRJ4d4OigEnww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4D6elVpq4XyYQk8/zHAwO4PJ67QLQGttdUz5+0//xO8=;
 b=j8OM1OUEotZouKkpL0Eb6FddJiNf1lUHaby8ysJL91ADx3wNY8U0UcaAjsSu3ZJCT0Yffa/7ZZTlzq4no8JyXE3PneBRL71Ggc+B40RUVH52JIttkJ+75qNBalOD2AA2ug71XSUknFDxdn2133gAiqyqkXKkS2h7rd7S1oAtTNQs+8na6bnGUOKNCxQYN3E8es2xv8JMd9PpLJtUetuP1hhLeXIrxx7+J8ccApPgCt8IEBXP0FaJlJ5JSt3DJxFr4o0EETAVksbVVuKIBnouyvWR1yWKSG2t6hNjjqieysyoMqdrC2H0yJR3ZoE4ddsAHyJr3DEvSqFoenQCdFNdAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4D6elVpq4XyYQk8/zHAwO4PJ67QLQGttdUz5+0//xO8=;
 b=e9KhSPp0I9eAZdre0f6G3Y/ulfQ0kHHaU2t2cIdY57GZYRlKLFYVttvx4lrfuV8saBgLQSoeI2C0Pl/ZTBI60BghXp5KV2ofiXuPAHzoBYHMWIlt/9KfqQSduxdDcn3+hEXV+FO0eKqNy0cARXjfXKdrF1bCtehewWLOZQR+ts4=
Received: from CO1PR11MB4849.namprd11.prod.outlook.com (2603:10b6:303:90::13)
 by CO1PR11MB4818.namprd11.prod.outlook.com (2603:10b6:303:93::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.25; Thu, 25 Mar
 2021 06:59:52 +0000
Received: from CO1PR11MB4849.namprd11.prod.outlook.com
 ([fe80::ad0a:c9b:9ecc:df48]) by CO1PR11MB4849.namprd11.prod.outlook.com
 ([fe80::ad0a:c9b:9ecc:df48%6]) with mapi id 15.20.3977.025; Thu, 25 Mar 2021
 06:59:52 +0000
From:   "Bae, Chang Seok" <chang.seok.bae@intel.com>
To:     "Liu, Jing2" <jing2.liu@linux.intel.com>
CC:     Len Brown <lenb@kernel.org>, Andy Lutomirski <luto@kernel.org>,
        "Thomas Gleixner" <tglx@linutronix.de>,
        Borislav Petkov <bp@suse.de>, Ingo Molnar <mingo@kernel.org>,
        X86 ML <x86@kernel.org>, "Brown, Len" <len.brown@intel.com>,
        "Hansen, Dave" <dave.hansen@intel.com>,
        "Liu, Jing2" <jing2.liu@intel.com>,
        "Shankar, Ravi V" <ravi.v.shankar@intel.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4 14/22] x86/fpu/xstate: Expand the xstate buffer on the
 first use of dynamic user state
Thread-Topic: [PATCH v4 14/22] x86/fpu/xstate: Expand the xstate buffer on the
 first use of dynamic user state
Thread-Index: AQHXCIQDYHRUMzQ+BU6HvOsZgq/N2KqNm3qAgAACNwCABKDNAIAAaDcAgAEsK4CAAIcXgIAAHeYA
Date:   Thu, 25 Mar 2021 06:59:51 +0000
Message-ID: <A2F31E33-4F15-431B-8407-438750186895@intel.com>
References: <20210221185637.19281-1-chang.seok.bae@intel.com>
 <20210221185637.19281-15-chang.seok.bae@intel.com>
 <87o8fda2ye.fsf@nanos.tec.linutronix.de>
 <CALCETrVaCmG4jzLCSuy7WYP2K7r-MVZntfugWa8HiVxQ7LpF_A@mail.gmail.com>
 <CAJvTdKmz7aePcpi4i+d3vnqLuNAJEuJCjpGDv5WTYcSUfuxoDg@mail.gmail.com>
 <6ed9d725-a6cb-4147-9c8a-2fe240e4bb10@linux.intel.com>
 <CAJvTdKm_uP-RqoprWWatg725WZOm3T-BHZU8S08dpWe2=1apGw@mail.gmail.com>
 <87fb254f-a904-303e-daee-c9a3e9bf13b7@linux.intel.com>
In-Reply-To: <87fb254f-a904-303e-daee-c9a3e9bf13b7@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3608.120.23.2.4)
authentication-results: linux.intel.com; dkim=none (message not signed)
 header.d=none;linux.intel.com; dmarc=none action=none header.from=intel.com;
x-originating-ip: [73.189.248.82]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1a4de15d-7c9d-49db-bc15-08d8ef5b96a2
x-ms-traffictypediagnostic: CO1PR11MB4818:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CO1PR11MB48180CE4D0E45ECDDD6A23DCD8629@CO1PR11MB4818.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 4Bc4YA0ct3dhMklNXRIVBt+NqntFNCei5hf2CXaDPpHLhFTYreq03SBtiL4dswRC8zzc/VxUhDcCr1KoPSG41moR1DAwy+okfJQZoCpRTCe7gWGulFDbc9sZZ+d3c1hC5qF7DiwebP76d/UW2QiERTststMcWjZ5uBtu6pAbh8i7uI5/d1spWrZNhAPzgwhlAFnDb1468M9GQIBUvcaw75Jxm+bZiCqHfNbG/mhXhM0D/caZ8YbH22TYfSLqCQKdC4jsncY8STdd0z5Pjq2ou0xud0k52qul7VDBrcylLvJFhBXKMcJxxF2Ccxlt/gcIP0Psx7IXXl1NEHulQNn9uC6dOO7+WWau87EQm6ZbWRztDiwAqmj1YmGmMHhPIpN5yVExIK5sQzoXH0Jsu5rSu66DbGFbjjORuG8dv75wXAWbJFGKIW2UCnN1WoLvL5sdtkTLw5o/6AJw/L3BEDnwpdNHCRK7BzWX3kcRGam4BEOHbkcoT7SjY9Odlz6Q89P7/poQfwGwg2QpAiib+lRucyFwtGFpv6nSEFhNGdJySAPZeeoMFKsa0rAII1r/drHwIA/7v6H2bMKE6XX34mZ0+34wjeMUDiyFrfV++VGZPYWn1MV+tBxfPI0G2R8ny92VdSrvpGA/nHvhR0EBkVU3upHYLp4mkvmvq6a2AErX4HudhCUg3jyFvnob0DPip7aWuMBQYUCx8+XSUkV+PYFaZ4e6dPNTKD7AtW+V7Z41vQ3xeA8ZEMTOKmCP3J3LL2EltQsK21m61LSwd2a60sNakQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB4849.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(136003)(396003)(346002)(376002)(39860400002)(76116006)(66476007)(66556008)(8676002)(8936002)(64756008)(4326008)(66446008)(86362001)(6916009)(91956017)(66946007)(6512007)(5660300002)(36756003)(4744005)(71200400001)(2616005)(966005)(54906003)(316002)(38100700001)(478600001)(186003)(2906002)(53546011)(6486002)(26005)(33656002)(6506007)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?DBTEkwNcmZjH765GwBYAQgUDzm5x5FLp41KdXjNsItru3D0RrR+U6m/e//TG?=
 =?us-ascii?Q?qPTpUHVV3yxchcP4g1ogWscCsG8HCx7cBamHHcfR88fTQh1R5D2wZOduAq6i?=
 =?us-ascii?Q?ZWHnfYgHc3Pu2mNJ0A1sS+TRRMjt3v0+bKN9bYYvouJpfPs5i5/ITlVk45ki?=
 =?us-ascii?Q?4IqMOB/g5D3CfLAOh3OkH8x1rxrbdY6Hg/gPli5sqJV3GjnWwRwg1dULMaLS?=
 =?us-ascii?Q?T8U9cLkSodHE33sUM7/13tFavhrl4LJtFchTEDYxNPfM5crmZPh+0VE5Cfzo?=
 =?us-ascii?Q?sM0jx9b5cY1l0XSpmk3SzCDz+Ka9ZGM/hhE+DqyTsrJhddQfcj+FHUj9z18Z?=
 =?us-ascii?Q?4KqjetBd6SevsuEZTYcmBZ8hORKnuniv424sa+9FcF5r4pqC5HvcBlrxgGC8?=
 =?us-ascii?Q?pflsLd7TCH4MaoL1I4f70yzTpRofUS2j46snfWAJNmxXO5JQdwhEPCFMLUXH?=
 =?us-ascii?Q?RISP2rLFl7ZM5WeKOGALOUM7F9qLVtxHHjIIlag7orxmVu6/7+cVUggu9ThD?=
 =?us-ascii?Q?Z4e9l/yGkbuQEuy2VdwmVohO/ahtKtOOOxUJeFZAEIO5Cq88Fga2dh7VQNqG?=
 =?us-ascii?Q?YCjgGQAsF5j34/RR14iVWSXFhhcdQG4h2iKMwBLzewNZCx7lptfo5cZ1Aogo?=
 =?us-ascii?Q?qmFme5rfndRLYoagc+JV6JWN2HGYPr55PKl4EGEIRdpq6uNzzmUb6D/qdl6u?=
 =?us-ascii?Q?oa5dHrViHTzJfVbClDR2E/xumpsuuL5UfW/D96fwFMK5ZgtsnzE0gPuDTQ2e?=
 =?us-ascii?Q?P0THb+La6dZzfwbmW44tBqjEgzdXXjPcynb1Ok0Dh5Rz5ocWIyGR4JDZHN/t?=
 =?us-ascii?Q?TtRA21gqk/VTGBCYZzdvOrGKsUvrEfBrTcRCeleQwBFuCUxscL4BuP3nHa0T?=
 =?us-ascii?Q?9SNhWPUHFNqM8K0xetV1czLFv1UvHG/wZReQv5EhXcchT2Ip+GlegKVblcIt?=
 =?us-ascii?Q?c0wmXevNyXB30VS2+FSsGSneYIB6u7mlBDo2qhFRzciTEtlpQCi+ytVqhnP6?=
 =?us-ascii?Q?WjxloKcJtrrQKVoDf/gO58ZD7yTCgi/bbs+vaP4eG1rmqZU2E0850vIxiDga?=
 =?us-ascii?Q?4FnzUoRtcOh0BGAcU0JqAj+ZoBBp7gREvnjVcw4+GfGWUGTEHzbw7dukA44+?=
 =?us-ascii?Q?3b6Yp1lOfobpfGl7MoHXXNapOBeIavIOUmZtV3Y+XJ2UZyjQ12ksRYcQylNq?=
 =?us-ascii?Q?iv8D0yczhoYuzRpvWw6PWuc3DUsV3VSJYk8l6AeMrMO/lquTac8T+iRJW88a?=
 =?us-ascii?Q?nBG7Xnl/QcGMsBihHA1mGIrmM46Y99TnWObjDZA8Xg+10eRBYI1jnQd7UxUZ?=
 =?us-ascii?Q?vy/LXe+YHFnClJJCXqjfNu/F?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <9A841A4D801D4049859EDFBA47ADB0D9@namprd11.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB4849.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1a4de15d-7c9d-49db-bc15-08d8ef5b96a2
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Mar 2021 06:59:51.9711
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ldQsScqcf6ODxv1XFThhgz5kDRNN464IvLYuq8H9t8l74F2j/Uro6YCmI7m9RFApGHI4vhCmFcSjE+XEYQi60zhT4/+sakVw/OtXjG/ZZBs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB4818
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mar 24, 2021, at 22:12, Liu, Jing2 <jing2.liu@linux.intel.com> wrote:
> On 3/25/2021 5:09 AM, Len Brown wrote:
>>=20
>> For AMX, we must still reserve the space, but we are not going to write =
zeros
>> for clean state.  We so this in software by checking XINUSE=3D0, and cle=
aring
>> the xstate_bf for the XSAVE.  As a result, for XINUSE=3D0, we can skip
>> writing the zeros, even though we can't compress the space.
> So my understanding is that clearing xstate_bv will not help prevent savi=
ng
> zeros, but only not masking EDX:EAX, since the following logic. Not sure =
if
> this is just what you mean. :)

FWIW, PATCH21 [1] uses the instruction mask to skip writing zeros on sigfra=
me.
Then, XSAVE will clear the xstate_bv for the xtile data state bit.

[1] https://lore.kernel.org/lkml/20210221185637.19281-22-chang.seok.bae@int=
el.com/

Thanks,
Chang=
