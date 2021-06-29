Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 643833B6E0E
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jun 2021 08:05:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231974AbhF2GCm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Jun 2021 02:02:42 -0400
Received: from mga17.intel.com ([192.55.52.151]:47496 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231881AbhF2GCj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jun 2021 02:02:39 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10029"; a="188468361"
X-IronPort-AV: E=Sophos;i="5.83,308,1616482800"; 
   d="scan'208";a="188468361"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jun 2021 23:00:12 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.83,308,1616482800"; 
   d="scan'208";a="419443868"
Received: from orsmsx605.amr.corp.intel.com ([10.22.229.18])
  by fmsmga007.fm.intel.com with ESMTP; 28 Jun 2021 23:00:12 -0700
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX605.amr.corp.intel.com (10.22.229.18) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.4; Mon, 28 Jun 2021 22:59:53 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4
 via Frontend Transport; Mon, 28 Jun 2021 22:59:53 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.104)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2242.4; Mon, 28 Jun 2021 22:59:50 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=N0ckXV87wsdyo1mWwSNO2k5JW9ZagDczn7LXQtIZxH9PlzBrPaPjGexb8iOpQU7HZ4eTJjLUmG3YUSnGRo3B5QPLxECwkIvt2guijJHD+CeLcxcp8LCFEYbDMDXTN9DzEwifd97RsgLRRj31uclTouIRij/sML9Afw/CAxLIacmnEsB9grcZ4Pk2mgcK7nZ/jqiphduAqHsZPsIM1FCrzv5BNEZ02Kb5rvrn0rLhQt2epybqWJHwF20NY2bUU3QDxYBbV85LugNnb5rOgyyHgzdH7W4FEE5KWt9OL7YwUPboH/E/94ucmvmCRUj13NaeUpATWq0IX1S6JydWUWFXOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LalhRS8y19TgRj6NgFzQwgGHmohTmh+9n8rhk5CgM1o=;
 b=kVBaDDDkOrL6e5Ylgx/0cpzv9M6/6onai1LuuAQxsCet6B1Dj2D5xk3yb3K7MlWuWg7O3aQZU1s55OH1XW8k+rLk0yFXO8QOpWQ8vY+PNwkHgkv0lMR6V6yO6TjiZO7KwOBRlbbM6jadIcIvAQ2cMUdzktHn3X4q+S7HH0EZgbRJVX96Gc2HeqA/K4a0UZnOMKoVCHKamCcFtefCZujviD/GAPe6DyHeUFDyJlLep87Sz9dfMALye+TxruyyiY+0o+suhOTosomaKgdEBr4IJYbY8yUrM/DIjIBAmheMMX87NDsoqP6Ui/QkkVEIDt0FfTiW1xNkzRPlafUPz072ow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LalhRS8y19TgRj6NgFzQwgGHmohTmh+9n8rhk5CgM1o=;
 b=fb4x8d71o5NtXV6T9pLqRS6snDpXcs1QYCeBqFBJx8Jykjylji8p84kgmOosqakEaTpr5yuN7pVyUlBI7G7tvUrVAali6+6dT/4Wi/ZPllr6zgr3ZpffPPwBLcfDcEICKLEzH1+Fo1vGmjBfB7GkaGY7pohSxm0dmadGoQV3NeA=
Received: from SJ0PR11MB5598.namprd11.prod.outlook.com (2603:10b6:a03:304::12)
 by SJ0PR11MB5615.namprd11.prod.outlook.com (2603:10b6:a03:305::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4264.18; Tue, 29 Jun
 2021 05:59:46 +0000
Received: from SJ0PR11MB5598.namprd11.prod.outlook.com
 ([fe80::e50f:8709:f404:8b4b]) by SJ0PR11MB5598.namprd11.prod.outlook.com
 ([fe80::e50f:8709:f404:8b4b%4]) with mapi id 15.20.4264.026; Tue, 29 Jun 2021
 05:59:46 +0000
From:   "Liu, Yujie" <yujie.liu@intel.com>
To:     Peter Zijlstra <peterz@infradead.org>
CC:     Ingo Molnar <mingo@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "lkp@lists.01.org" <lkp@lists.01.org>, lkp <lkp@intel.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        "Sang, Oliver" <oliver.sang@intel.com>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: RE: [LKP] Re: [jump_label, x86]  e7bf1ba97a:
 BUG:unable_to_handle_page_fault_for_address
Thread-Topic: [LKP] Re: [jump_label, x86]  e7bf1ba97a:
 BUG:unable_to_handle_page_fault_for_address
Thread-Index: AQHXaAiH7ZAQDH07J0+GlvPgeMbkGasitFqwgAZ5xQCAAAzdAIAAGISAgAEzpVA=
Date:   Tue, 29 Jun 2021 05:59:46 +0000
Message-ID: <SJ0PR11MB559827267F45AF7F344E1937FB029@SJ0PR11MB5598.namprd11.prod.outlook.com>
References: <20210623022826.GA20282@xsang-OptiPlex-9020>
 <YNLtSKUtqxqPxmGP@hirez.programming.kicks-ass.net>
 <SJ0PR11MB5598608507B7EB38983113BCFB079@SJ0PR11MB5598.namprd11.prod.outlook.com>
 <YNmUzDjX6sECp37P@hirez.programming.kicks-ass.net>
 <YNmflj/WpFG5Ivmb@hirez.programming.kicks-ass.net>
 <YNm0J6etioinNhJH@hirez.programming.kicks-ass.net>
In-Reply-To: <YNm0J6etioinNhJH@hirez.programming.kicks-ass.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-version: 11.5.1.3
dlp-reaction: no-action
authentication-results: infradead.org; dkim=none (message not signed)
 header.d=none;infradead.org; dmarc=none action=none header.from=intel.com;
x-originating-ip: [192.198.142.21]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 826db21c-c945-4a90-6d0e-08d93ac31952
x-ms-traffictypediagnostic: SJ0PR11MB5615:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SJ0PR11MB561523AA7ECFB2158ADB131FFB029@SJ0PR11MB5615.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4714;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Zdx9w+5X5CP+C3HzT1GPHDDAK5Kpm/7+qH8jiImwV6DbkW0bsEOmAa96bG6qcgQ3FNz/aMyfZRySe7jjZixRE+VP2MYFcTjU36GqFmJKTQk5bCwiv+D+cVsSOrM7CnMuB1MmKeR/MEw2zQ20QyDdLtyIuYfjAGc6AvhaxUS1E/59u/lRXyPTB8JKRwhR63V/DW8/bczqRWg9qLvPj2efAHh4j7qo6Ux1xwyw+TjAhkpi+j+1uuMpE/7kSUJRAgAvu1CFwHDbv7vyV8XTApKbT+xlpbSQns0LyZN2yt1yL56k+bp/0MFhCTMy9ArGqOyecAqEgyr+ZX0p3bbEQrB3O3ddjOYhAkJfTyiYq6EvBRh8SMZjv4yDeqCPqAW0V2/ZdZeN+iyGjCS84PvlgIcYI0D5+sZS9IzcfSiTo/1XyJ2K0Pa85fucFb7keYsBBYoHgjzXDdbBxten3/9WbWjvpSn93I0f+oKkcu227MSegs5t+nJu+CTGJzA6x9SLjHO6s6ZHMHWjJzHAm7GGNqdan0H6CmhVV/qMUmS9I4sWNuacTf3uiL6G402XVCYfW/iS2ZKEwTZEWp9sIzLLm0/e26HBJFvaJNCiK9p54C1qWta1kDPx0iGm4QS1/TPwvUx2lLVC5oGasyw9tn2E0zqMwvkYC1awxoGnSL6jL1uMIP81BMDd/OYKzZlvtKCuTfeztIa5D8b7/QEfYSQ6329VswjgIEgOU4gmLRmx92meJJHF0d1ugxgSe1O1axjhv6/v6eNPwNzrkdWQvjjSBD3JbQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB5598.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(396003)(376002)(39860400002)(366004)(346002)(186003)(8676002)(8936002)(6916009)(38100700002)(26005)(122000001)(71200400001)(316002)(54906003)(5660300002)(558084003)(86362001)(966005)(33656002)(6506007)(66556008)(66446008)(64756008)(478600001)(7696005)(66946007)(76116006)(52536014)(2906002)(55016002)(66476007)(9686003)(4326008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?l+NYmJJVL/WqRORJw8fe558DqJYuVs7iJ+duiwkdYoI/OgYwMAOeMbeZV7yM?=
 =?us-ascii?Q?G1NcEe93U3+ReKibnG00bIMfHE33iSJVbM9P1ZG7D7JQvzdywCTb2XeW3CC3?=
 =?us-ascii?Q?6KJaUf2xIJdTNAF+nao9nUsyyNseNgh5OSmnuTRLaYZM9dF4ElGnbbfvpCQM?=
 =?us-ascii?Q?xMOb273ZofQvU2ncGyaaBfT+EQhD1UqUCYBpuOMFunIU2psQkwsaaYVLWmQl?=
 =?us-ascii?Q?y4EozYN3yv9q5KoSHZjqyPVU1LmBrMBpuYKrQ5zrvBEqfN4rTK1AfPHjaPHQ?=
 =?us-ascii?Q?56FRl1qzO6wImDR46E0qmvyVMOdh8elNbIKhWjL9XjyfT5Xe3sUatsMVmXxa?=
 =?us-ascii?Q?ffB5M6AZ7DYXKIgm73ap1/oDvXGMK1rmPgq6BW5TIAIvPwkcUY2zmqt6bFGx?=
 =?us-ascii?Q?DgnTQyknU9sTK9wfQzHh3R4wLo7fHfy1E5MYhWxdARV6EuacJm2QiHHikwXH?=
 =?us-ascii?Q?ws+ILDtV6cWJoHfVoljPX6TKh9m6Ync/D0Ve9vjOltrVTIkgoUT13oojuf+e?=
 =?us-ascii?Q?lX2m1t/HdqOQ0g0s2WIVDJaxY3iwN/1EhiXfoz8EYrBvmIJjjTxpLHWiBW99?=
 =?us-ascii?Q?a1Et0Sjwt0NB4Jc5y1jcBxw6hIDjCPclL0yN1DLDG6gfVvPuY1qd4X7naZMI?=
 =?us-ascii?Q?JOhQQR/aynD4G5o5V0PGDPtLz33JMIZj0ZeVgcMqk7Y738kY5nS1q+RguLrV?=
 =?us-ascii?Q?RwzyT751+sNvPtJg+gioMCxYQeTk6Z9d1rzugsQKj1ayS6bqrZdrsHyqotx4?=
 =?us-ascii?Q?5U3nfoWVbSVyIu1f/RKJFPLGUd0yvVnmjYYNM0u89z3n2ay58hgM9GtwjHcn?=
 =?us-ascii?Q?zkUQBxoGdCkTLQFV/dcoRXRfy+P4qtt+gZ/FQRxQqqaV2wOq0xD5rUjyx3dJ?=
 =?us-ascii?Q?/pqPfMpKtoBPVq6yLpp9+VHMmvJNFoJiuDt9oAVrMHrkAyfh26XIx3BtYO2q?=
 =?us-ascii?Q?1UwmJvRdGMPANkdZiAfvKTopXnc0H07z2TFmFvchrRx5uDHwxKMvkApj1o2R?=
 =?us-ascii?Q?KsfpcM3x8AMXMwlpuNzdrFbsJAFHdxFVkH7MjoDoGSYocQqwX18tZNUn1soh?=
 =?us-ascii?Q?Y9jM5xGY9cVcWCfBWvZ9BqPL05wfVjxqe5BOb6Ft0stwMxjnYwZCSChif1FQ?=
 =?us-ascii?Q?qRdH6GzehuCF206iboDNxJLPAJNNW/EF9AB+wwG4hRpaL/Wpson84emRRzl9?=
 =?us-ascii?Q?MfH8ckhz0QCk5KHuut4qRouamD7W1K1VTb6NejuRsdq8x+tR0zCNSDG/C40i?=
 =?us-ascii?Q?ZFzVLvzDGMyb/dJE4kXDPoJNYkfHq+P0uNjzpjMbvZqjHsu+V6+mqiX/fqJP?=
 =?us-ascii?Q?Dc/8vo/gWqRL45sL2NHuJ6+l?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB5598.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 826db21c-c945-4a90-6d0e-08d93ac31952
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Jun 2021 05:59:46.6217
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vhbdRQH4XzuYU/xcUfkk/THt8ZhOYWijfYcKAmNIbc9AKIxj29WGEDByh/RbTe56P6mzZhUcCif6/HEgJjdZZA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5615
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>=20
> On Mon, Jun 28, 2021 at 12:08:22PM +0200, Peter Zijlstra wrote:
> > Let me go write up a proper patch and do the same for static_call.
>=20
> https://lkml.kernel.org/r/20210628112409.233121975@infradead.org

We have tested the patch set provided in above link, and it can fix the bug=
.

Thanks.
