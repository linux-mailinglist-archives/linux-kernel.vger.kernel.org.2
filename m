Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 78D973AF863
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jun 2021 00:22:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231970AbhFUWY0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Jun 2021 18:24:26 -0400
Received: from mga05.intel.com ([192.55.52.43]:42831 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230423AbhFUWYZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jun 2021 18:24:25 -0400
IronPort-SDR: buHvKdQ3ikrCJCXdTGFbWXVQKLyegxDLDurjRsrfCdjbQzxaEfvfWIP9v9zIp45ZzqtBfL51RQ
 S2JWsEQYXfUQ==
X-IronPort-AV: E=McAfee;i="6200,9189,10022"; a="292572259"
X-IronPort-AV: E=Sophos;i="5.83,290,1616482800"; 
   d="scan'208";a="292572259"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jun 2021 15:22:07 -0700
IronPort-SDR: QXXhmUrnokfAiMrdrz8hn34yR0WQY3GBFbVF2IgyO9x7qkeoQSQi+JOWUDYXZ06VMHShBbzpDP
 NEuVxXFCKC4A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.83,290,1616482800"; 
   d="scan'208";a="406118803"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga003.jf.intel.com with ESMTP; 21 Jun 2021 15:22:07 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.4; Mon, 21 Jun 2021 15:22:06 -0700
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.4; Mon, 21 Jun 2021 15:22:06 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4
 via Frontend Transport; Mon, 21 Jun 2021 15:22:06 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.102)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2242.4; Mon, 21 Jun 2021 15:22:05 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DhkAb+5qaGQ0uAZJrxMc0+hSRNteW7fDkIxCE9KebAFOJnOCpcSQslQr+CgraQ8O5AyY2mOOF/I4CqqmlvvQHG2r39h8XK0/sAM/XrRWV7a7USnHz21Not5A2zmRfLnG1zbRX7AapUt8J68HgdmGOpr4ZvRBQuCITD5PyBH7n5/1TgJGTM5RRrWFraOpNs8RLCCt3CTVztkjybS/Qu6S2IPMUYelnwUq7p8hrOeSm6o1RDvnOnsqTkpKqbb8thQLuhSTc6Xmxq69cPm4cOVSxmgZRdR3dbqTr/FIKAyIGLPrGl1pgpYq81Nd6AhCBjLuL8IkRQU5sNGiocUxdgwPnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6PeK2y/3F9uXATSFtK525r3qORcMhzizwRPuGJSb1Co=;
 b=NSWAz8ee8NMv5FwvX/0pmDLgUU+CguxYt2VQUf/qrRT4bg4zQ/qmDBNbZsgvGCR+wnhyuCrANqXPfs66m8hrhk/KQTLW9pz2TDfmebISax1Jg5x1l/V6KRpddpCwoi02+1x3/nkyywpQ+az9tQ8dFcfqVLS9JpDinrJn7eyWxotps50QHIRjxdz498OeqwHwJVh+iz6HKavX5fXlxBABvI/KnRjekT0TY4qj2oq2OZU/T0VdVPTq12kdF1odjWPgOyFJmfzg+hFPKcNBgfVGJTOL0k7k9qPMi8QX+wi9w2z9//hTATULRekcjXoK3rde0epR+NmFCd1N0xRZJJnQ8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6PeK2y/3F9uXATSFtK525r3qORcMhzizwRPuGJSb1Co=;
 b=uOF2XJ/FhDtV5o903i+WzfqSb7FVpn/4oX2dhSVNz8HazUV3N2p4qvlmHmQxodzUvckGMEKuaUSOUmCt4TikzY+vE7nZoPZscu5Ql8KV5mXKCT1Bp08Nr7HKC0JJk4/kNybJDelH7Vzm4K9a0XOvtamZV6eesirkhiuhC6rtOwE=
Received: from PH0PR11MB4855.namprd11.prod.outlook.com (2603:10b6:510:41::12)
 by PH0PR11MB4933.namprd11.prod.outlook.com (2603:10b6:510:33::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.21; Mon, 21 Jun
 2021 22:22:04 +0000
Received: from PH0PR11MB4855.namprd11.prod.outlook.com
 ([fe80::713b:33e5:9d50:194]) by PH0PR11MB4855.namprd11.prod.outlook.com
 ([fe80::713b:33e5:9d50:194%5]) with mapi id 15.20.4242.023; Mon, 21 Jun 2021
 22:22:04 +0000
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
Thread-Index: AQHXZuvcsriNBxeowkOiSeaxUGQ97A==
Date:   Mon, 21 Jun 2021 22:22:03 +0000
Message-ID: <B345FDEF-7C90-40D8-AE9E-58D783B22670@intel.com>
References: <20210618141823.161158090@linutronix.de>
In-Reply-To: <20210618141823.161158090@linutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3608.120.23.2.4)
authentication-results: linutronix.de; dkim=none (message not signed)
 header.d=none;linutronix.de; dmarc=none action=none header.from=intel.com;
x-originating-ip: [73.189.248.82]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 44d2fcd1-7371-423a-1a3a-08d93502ff5e
x-ms-traffictypediagnostic: PH0PR11MB4933:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <PH0PR11MB49338A263B2DDC9E9C33E533D80A9@PH0PR11MB4933.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: u7henk6PvfKUA+BhjUI1iew00QR5NmwJAtzawChORACYktJCZ+glAmjEMBFj4HwGBYTu/fBXx1VwI0pqNYD8/ydamv9vWBUGtEcbB12baf0jty0NdOvMCUf/z3Fr0KjmhVL1I0dHgc98NJug/W9Ag7N6MDlAhkF/CYMrlmwW6sCvZnLRrIRYGjKXEdcR06ZaMNoPw8BbiccBVnSIW3aRAWimmL/1j46HpOTpOazvM4xRsLgI0gbcDT7rPJP5A866w8GETQQQnNbx73Nrf+5msyw5M5hsFGQYjokdZ0K1aFuM/nq0iT7rBq/TD8rEttsXB6UR9tbDiw8/McMxz1k4L66uxE0my4CemWeWOzGdQIWQ+Ua0llckDJhvHLwcwr8UG1LFxRzuX3r4gGr4/pXH3368C6GDeosKuC52gluNqNodNJhHOz2r/y3/SK+KIoUl90y/1YhK9pM4Iajq48URde9cMLz0yJfYzDWJ8JsH2JeIph1/7UTnkz01oCZwFHMA/Z0tmKBoEJj54SzcfQJ4OrVambi96HsE1b5pAXFXDipUx8S+PnXuNLvxGyQ7uIG89aOL42Nnb4wTrEWe03dwmNjaeqMig/3ZNA300VVIbdtpDU8NS3LGvTXcLzkpWcmzXTClKKE/G6uFinX87pMb5znclqFAdZR+FFQzKYWWjiA=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB4855.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(39860400002)(396003)(376002)(136003)(346002)(122000001)(186003)(38100700002)(2616005)(86362001)(54906003)(316002)(66446008)(26005)(64756008)(76116006)(66556008)(6916009)(6506007)(66946007)(53546011)(66476007)(4326008)(478600001)(4744005)(83380400001)(36756003)(8676002)(33656002)(6486002)(8936002)(6512007)(2906002)(71200400001)(5660300002)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?3/6TlA1kMOnVcMJVaAHIzKd86vpU/9DiBNEuDjyY4WVZVxw/OvGjRVncxbOQ?=
 =?us-ascii?Q?f7GjSWqfjwcxVo9cucFZTNi/G61M8GjdYzFbT389U0HiP5OFVNAzfDw7WhCc?=
 =?us-ascii?Q?c7+IiswH+doJSn0p1Jl8GBGaOg+XqXS/LGjL0zAVx67N4EIQHPS0ycJYfk+Z?=
 =?us-ascii?Q?qrmHrW7VWBtIDoX7O0dF8tVaBtK+L3qDAZK01v4m6gJ1wb5p7+kdj0Var7Ud?=
 =?us-ascii?Q?PpiK+9b8ebT4qn89tsI/q9xq+/p8w+CoMYKd91uuIHxK2mapyErTnvvDGVBN?=
 =?us-ascii?Q?vME+XsHddaik+MWzlm951A/fmyy6FWhD8MgOFEtFmer6HmWXT92XGjiuNdkm?=
 =?us-ascii?Q?TXMr8GNGjndqp7CF7u24UDkjHxz/Yh2aFwYWXKXi0mFhtlq041yFs1i5LAMP?=
 =?us-ascii?Q?YEJAc9l+VaeHQBrT9Bo5QGsK4zImJu2jZ5hf7oqAOl1OiycWrUogvRSOgV/e?=
 =?us-ascii?Q?4qLKkm9SOgyXB1JK40QD2F5WhAE5zF15H0tbXIUT3ZRLKBYdzAp9teZLdfva?=
 =?us-ascii?Q?44FtV8aNeReicO7c21YVqp+pN6bk7GHcx2VPrJsdaO7knUEDTXEi0uw6YzGE?=
 =?us-ascii?Q?Gv03cJJk/AVJh+GoEfmdqx1HmyI41E3Oh6P9XkLyM7exeXOkTWsSN42ifa1C?=
 =?us-ascii?Q?EM0QiKa1/RmVjATnm2OViGEpI8V5kMfm+mie10p3bieLP+aUJ6U6OLU/argc?=
 =?us-ascii?Q?KOH9NpiJKh3SDABiAxU4rESfEV17ZsmmCmI7NuTV6dDKn57h4exO0qWxsQoK?=
 =?us-ascii?Q?OwvGseFSG5JCQh8CNFQKqyurrqwiUswd7jDSQ5jbsem+eBbC0BJqFHJA1hRE?=
 =?us-ascii?Q?sewtdCIjMGmzaQdPfVRWu6vGOXKwiGLlu24HHHvS4ML4zVCy46FvKZ6r8+Ep?=
 =?us-ascii?Q?k2qQXD32ogBEbt+A2UQCYuoJfgwDz5AKW95MxpzDSgnm/lt40aZLfYqWYOXS?=
 =?us-ascii?Q?Crj+PqhorQlGI3pM8DI5l8pgRvakxjgB99yiN4WPyeJsYXvi73X/s9O5ON5L?=
 =?us-ascii?Q?CRN3He/fnlag97zVBhjEvEwPx2moSWgIjSBCl5sY8Kz+fkwJQxrme8Ecm0Ux?=
 =?us-ascii?Q?+92n++tngKm4RWe0Vvq4a5x/Lr7OqZ7/i5wK+Yzfdzu4n5g65LqfT4tvXeKk?=
 =?us-ascii?Q?ovXlbt/EYQu6S5mkzPj6HDgc2F5tejppVsXtDpq3ukUNT0h67JjIZLotx+n0?=
 =?us-ascii?Q?PYFbwMuZHD//aueY7G6563/O8x7PgzZdMENe0tp10htwYkH7RbhKgX0UH4ki?=
 =?us-ascii?Q?btwmlCRJg3YEkWL27P/yyuhQQnunoX9L7v7GBWmxGWd6YLCqAosnlf9ByE+D?=
 =?us-ascii?Q?Cg86XFvktpyFai5k7Dv/R5Nk?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <D1295ECD64DBB54DB24A62C93068ECE6@namprd11.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB4855.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 44d2fcd1-7371-423a-1a3a-08d93502ff5e
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Jun 2021 22:22:03.9104
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: QT8HmMXTJU+XzpnbKy2nx9pEV6JK8S2nOLXEofTOKiARWgQxVYmyzzaroQJMzwDqnMVtWgZTuncHOd81UC2Hzk7H7rxkZvt4CcCvt49ejgM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB4933
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Jun 18, 2021, at 07:18, Thomas Gleixner <tglx@linutronix.de> wrote:
>=20
> It applies on top of
>=20
>  git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git master
>=20
> and is also available via git:
>=20
>  git://git.kernel.org/pub/scm/linux/kernel/git/tglx/devel.git x86/fpu

I tried to apply AMX patches on top of this. The test looks to be okay by f=
ar.
I will also give an update here if I find anything.

Thanks,
Chang=
