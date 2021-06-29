Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C15003B77E8
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jun 2021 20:35:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235150AbhF2SiP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Jun 2021 14:38:15 -0400
Received: from mga18.intel.com ([134.134.136.126]:3591 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234865AbhF2SiL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jun 2021 14:38:11 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10030"; a="195503940"
X-IronPort-AV: E=Sophos;i="5.83,309,1616482800"; 
   d="scan'208";a="195503940"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jun 2021 11:35:43 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.83,309,1616482800"; 
   d="scan'208";a="643816489"
Received: from fmsmsx606.amr.corp.intel.com ([10.18.126.86])
  by fmsmga005.fm.intel.com with ESMTP; 29 Jun 2021 11:35:43 -0700
Received: from fmsmsx604.amr.corp.intel.com (10.18.126.84) by
 fmsmsx606.amr.corp.intel.com (10.18.126.86) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.4; Tue, 29 Jun 2021 11:35:42 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx604.amr.corp.intel.com (10.18.126.84) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4
 via Frontend Transport; Tue, 29 Jun 2021 11:35:42 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.168)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2242.4; Tue, 29 Jun 2021 11:35:42 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=V9QRaTDZ5y95ZEtnuYNKPoc1g1EWnItk/xOW+fEaO42w32bTq5Cdiq2IwsG2j6zMe0CqoxYZ0FzJ9CkuuVoqaSOp2ZpMTTQeMF8mwslm3Ns4lx/Zro0+eA6rqk1kEgDTlM7eFtyYBh8FzDmo0Gzg8MSD6t7Ei5oJgPzRspDyKNxEZobLZWlmHMciZX6+5pKcc1xPvUMP/k2sYj4iUWZJxzW7LICgtOzyk/ElarcXXZSMUBFl7T6h9HSEcpMKUjEa8zZFwpFR+jxPCCJUvvhlCE9hLv4xysPRKYlCbjQu1uKEGmWmiPHNdX6qKsEyGJox+FB8wzoxasWXmI2w5RgMiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CWO41DCeKZjyctwzjLKUlKvRLNg9K7Ino38HnOSovYc=;
 b=oghWtb7gMy+/OLn5H0CFCbefzMTdhvbTyyESPQJN0zqZixIwtC/iYRWpwM8llKNZsK61ge7/Do1iSp643JKb1DB39XiPhNnRqDmCkyAhUEs9rBSQL64GYBxnggFmak764owyrGw8shlHbAQiMG4UwBUzYf8b8D1bkKI8MoJu3EOwvdYtK+AnQWH5PUjt3kdrFEYG+5EQL3zWj/KoWXyrTUo4Eqa3ZHeeBz99VF00dIhbBv3yDumxABgv8FYbfgY7ucgnhmbLnB3F5i/jUay6Zdtm7K53You3ON7WRdI6vBP9SP68KbG6TaYKHKzKbUVjrZlMg6dAiSgKkEWjHMfS1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CWO41DCeKZjyctwzjLKUlKvRLNg9K7Ino38HnOSovYc=;
 b=WkXw7w9+i6aOvA7jr9W7ZGGy7xulf1YR44d8367uYHRBs/DMQ/AZQ9C0OL4ScZCciF4wTe8bpDwPRUhXUE1IUMSFJzBk7bAHoa+OgrcD+oEoU7QS0dVT3I5GDWUa7ke8+0UY7P1mR37D4j1pFEM0CXwbXenIXvCmTs5wpjfkS38=
Received: from PH0PR11MB4855.namprd11.prod.outlook.com (2603:10b6:510:41::12)
 by PH0PR11MB5126.namprd11.prod.outlook.com (2603:10b6:510:3a::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4264.19; Tue, 29 Jun
 2021 18:35:39 +0000
Received: from PH0PR11MB4855.namprd11.prod.outlook.com
 ([fe80::713b:33e5:9d50:194]) by PH0PR11MB4855.namprd11.prod.outlook.com
 ([fe80::713b:33e5:9d50:194%6]) with mapi id 15.20.4264.026; Tue, 29 Jun 2021
 18:35:39 +0000
From:   "Bae, Chang Seok" <chang.seok.bae@intel.com>
To:     "Hansen, Dave" <dave.hansen@intel.com>
CC:     "Lutomirski, Andy" <luto@kernel.org>, Borislav Petkov <bp@suse.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>, "X86 ML" <x86@kernel.org>,
        "Brown, Len" <len.brown@intel.com>,
        "Liu, Jing2" <jing2.liu@intel.com>,
        "Shankar, Ravi V" <ravi.v.shankar@intel.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v5 14/28] x86/fpu/xstate: Prevent unauthorised use of
 dynamic user state
Thread-Topic: [PATCH v5 14/28] x86/fpu/xstate: Prevent unauthorised use of
 dynamic user state
Thread-Index: AQHXUAs71FpA6GLTCUWvxGMv7m3G8KsW+QQAgAAdOYCAAAnJgIAAA/+AgBRYTYCAAAMZAIAAC5mA
Date:   Tue, 29 Jun 2021 18:35:39 +0000
Message-ID: <406DB587-F598-484F-A128-990E2DB6EC78@intel.com>
References: <20210523193259.26200-1-chang.seok.bae@intel.com>
 <20210523193259.26200-15-chang.seok.bae@intel.com>
 <af093744-6f68-ff51-f40b-4db234b363d8@intel.com>
 <872cb0a2-3659-2e6c-52a8-33f1a2f0a2cd@kernel.org>
 <36D0486A-D955-4C32-941A-A2A4985A450C@intel.com>
 <48e86785-838d-f5d4-c93c-3232b8ffd915@intel.com>
 <3AB6DECB-2A53-4EC2-84A6-0CACE44CFC1C@intel.com>
 <6754330a-bbbb-aa29-7800-f2d16216ad8c@intel.com>
In-Reply-To: <6754330a-bbbb-aa29-7800-f2d16216ad8c@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3608.120.23.2.4)
authentication-results: intel.com; dkim=none (message not signed)
 header.d=none;intel.com; dmarc=none action=none header.from=intel.com;
x-originating-ip: [73.189.248.82]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: dc55efa7-5f4e-4059-aa99-08d93b2cb1ba
x-ms-traffictypediagnostic: PH0PR11MB5126:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <PH0PR11MB5126D16C349B1491673E75B5D8029@PH0PR11MB5126.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: jW7MnMdZg0yllPkTG75o6sTr5wDSs2d78udTpS8UMREa+aGKNCGwdZ8/5StaunQ2B/PRjF5Igp3oO3a31rQjWY63jNRe3C49f71CD7+ma4RvqMU2LJIzdMenTrqNkU8w/Jl3IYuqSqH8O9ADed4EDyLl2bCJzq3VDkYwCpYgP1haSTI8iQB0QWnYPMwsZQB1dAemfGSZ7pBIx6g2FL+zegrRuQu+heEHlgrhX6IADkU0yX0JofZP1MKy3bszHWi8unb7YSAbJevso/Nz81IaRSlp6Uhv03780O4wwU5AxiMn8aTqcafbiFgwlyZPemhG+ULezbbDzKdAjGmZPR57r7d0wjSVKtiF0rWuCtRk+GtgIybxxq7mqhEnXdc/PO7YS5cHzZQApBoatmhVh7RBkSszh3bIUqSiesmbPHhqYSjjY8zhCM9HjHKsko3ql72KmySgKWDWOA+1dP9oGgx0jUyh/VrLv55ihzZqEtS4Kva2MS5mBV+q2uTxdy9JUtYCDffuN+z5VxMFxaXD7d7cljZLcGKe73ySkUC9WW9EEK7jJd3PDigeMVjkK8dKgVJuO/aVawt/vl9oR1EDTA6ML8/5nPVCJTYGJu/AW1fl28F12RH8ChKIQZqw6e00kXklu4b6mKlK+JLE+azXRN4NAF3T1tSbvG8JgQQLB5yV62b2WnCESHMXyok9LYZIyWE4Q4xmoAKwsij3an+qaNDdAA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB4855.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(136003)(366004)(346002)(39860400002)(376002)(186003)(86362001)(6512007)(38100700002)(71200400001)(122000001)(478600001)(26005)(5660300002)(33656002)(2616005)(53546011)(6506007)(54906003)(37006003)(36756003)(316002)(6486002)(4326008)(2906002)(66946007)(64756008)(66446008)(76116006)(6636002)(6862004)(66476007)(8676002)(66556008)(8936002)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?jjmDLlQ4cNnqdiDyxZXAmtBjzm90mhQ/oHuPu/NPyVU2Z9t842Nlri+pUG3d?=
 =?us-ascii?Q?vaNtkkm42GLgHF2J090HZsohUyI16WCY4IYimXhiLqoonbbPvKR4dKyWJHCr?=
 =?us-ascii?Q?Srog2tGWYSn3t+YWZp9UXD7od1rtXsuIlQNYHl3p0GgUIAOd5+WUMrL5Wnr8?=
 =?us-ascii?Q?HC76Bj7Tkzodd8P446nvoynAqUXWhoRDmRu9P6/DagrlXX+yQuCrJSLB7wVn?=
 =?us-ascii?Q?QGV3FNJoxLwv0J/RRLwVtrbeN1NevZgLRT+pbO6XCtitO/Egwy/KHl3o8pKL?=
 =?us-ascii?Q?YPjsqkj3kn7vjqsrw/W1Xq8L7hIA7oCKEoUC2Z8SZlIAbcTVhx8cSeigaYdC?=
 =?us-ascii?Q?2DKYyqzq1/Uk9YvIRofl+6Nmd2ssupCv4uz3N8xv0znswZNZU77AyJ6gTYqj?=
 =?us-ascii?Q?n7abkwbj0jI28f9q0Bqty9YSUKY4EhD3WOU4Mv+2ZVhnjoXcm69bMfpzvcAu?=
 =?us-ascii?Q?9KPPXMnonnhQcnksicmDoyCTb/XvsKaPn+L9MIUKWO3ZKYhoR96IJXUqSrt+?=
 =?us-ascii?Q?b05gXg/wgFtUXxp3Ip54O6kK1GcRQWrRDiPj875oKAO7qt6oCM4v+uDcXn3L?=
 =?us-ascii?Q?sTH9fMVtHLjbLgdI0d6qZ2LsJozFEgzleWAoB5qNsIH4BKclLMX2JEdXzoFf?=
 =?us-ascii?Q?17JxDCTZo60XuXc2yXjSLJ03gyjMe51D2XO75ujeK19J2HQl07AZ6pcj7uNf?=
 =?us-ascii?Q?h54/qMd2rRFQFsqjbJrm6ieZwmyEDXcAVVPODYg7UTHAwupr9/HynfddgHqQ?=
 =?us-ascii?Q?U5veEKv/VmNaMs7HAB1R4Y1m7IHgowFwEWgm1KkDj3QGU6d2TreEEmRbQUue?=
 =?us-ascii?Q?4arOb+cP80B+Ws2370fei8o+oPyTUTSlfPPd2IOQNta7N+erW65UAzhU+Io0?=
 =?us-ascii?Q?1EzWwBNuD2fjPw6BVMXWdHlPEcocMVoPVDqZnmXBi/1Eli5CEwwxTbaBcuWo?=
 =?us-ascii?Q?TkEZvBxccYmVnRLcm/GThMRb7Ua4any2ea1jhTfQ2XO0ZCZhjI210xPk7dNJ?=
 =?us-ascii?Q?Oa13T/3Mtif8laAScGg3YHdrEQqH4h448JGOQ2xLrjxgbLxoaMubphyyeg/0?=
 =?us-ascii?Q?7APVK+n0PNH2mUanjjHssSaUtnMCyHq0A7wWT3R8N0t2w2mZfc1dr5ClHpt0?=
 =?us-ascii?Q?1GTM3HiRU4cCVtqvh7Hvdjzm7N5xRSR14HXOcZtv3JVEX/ftA91a01qMtSEW?=
 =?us-ascii?Q?kLhCjCisVNWdtKhpjfx+ONPm0l8GK3ITHVpmiMwGc2+ufaUpRV05VGDeuEJg?=
 =?us-ascii?Q?N407Tq7hSJeiWa7x2KJgpVppcng1A1wZuc5ZnQxIc8JhXqD/m2WNktxhgQuU?=
 =?us-ascii?Q?PVp5vjzUsUCb1d7EK2qTcqt/Qh9+EH8rq8NusaPEGCSuDQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <98A0762BC3502F448A88F31A28348D4D@namprd11.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB4855.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dc55efa7-5f4e-4059-aa99-08d93b2cb1ba
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Jun 2021 18:35:39.5120
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9Y5wwEvuahbK8JWg+NAGem22FlfrTqAvAsmxteBoXKZdOou+EoGaML9cSXjHuFSQPqLvURkHTD7c8+DpR57PRRcrYCUEBApb/258GDvhfSk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5126
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Jun 29, 2021, at 10:54, Hansen, Dave <dave.hansen@intel.com> wrote:
> How about we pay this 26-cycle cost, but only when XFD is in use?  We
> could either look at the shadowed value of the XFD MSR, or flip a global
> variable the first time XFD gets used.

How about something like this:

diff --git a/arch/x86/kernel/fpu/core.c b/arch/x86/kernel/fpu/core.c
index 777cccab0b47..9752ebe6be79 100644
--- a/arch/x86/kernel/fpu/core.c
+++ b/arch/x86/kernel/fpu/core.c
@@ -99,6 +99,23 @@ EXPORT_SYMBOL(irq_fpu_usable);
void save_fpregs_to_fpstate(struct fpu *fpu)
{
        if (likely(use_xsave())) {
+               /*
+                * MSR IA32_XFD write follows after this XSAVE(S). So if a
+                * state component is in use, XFD should not be armed for
+                * current. But, for potential changes in the future,
+                * cross-check XINUSE and XFD values. If a XINUSE state
+                * is XFD-armed, the following XSAVE(S) does not save the
+                * state.
+                *
+                * Reference the shadow XFD value instead of reading the
+                * MSR.
+                */
+               if (xfd_capable() && boot_cpu_has(X86_FEATURE_XGETBV1)) {
+                       u64 current_xfd =3D (fpu->state_mask & xfd_capable(=
)) ^ xfd_capable();
+
+                       WARN_ON_FPU(xgetbv(1) & current_xfd);
+               }
+
                os_xsave(&fpu->state->xsave, fpu->state_mask);

Thanks,
Chang=
