Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 02B2E3E1709
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Aug 2021 16:34:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241995AbhHEOeS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Aug 2021 10:34:18 -0400
Received: from mail-co1nam11on2071.outbound.protection.outlook.com ([40.107.220.71]:1248
        "EHLO NAM11-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S241663AbhHEOeQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Aug 2021 10:34:16 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=C6SrnLlq4sWERgPcMNsWqmQh4oUYB/G3E2Zsyn/EjcYG47eGVY+8LAH8wDrO3e0/Eh15oyTw8axlmeh3/AYYAc5igUyhc6gjP+8YSTlvo6sz8YnSm26xBcXV9vKkTj7wba86KxY6HqNjBEHl7/802TV7Qa244XbwUwFrYJlefbSPytHGtEe6Sti5PP7bTo0m/KRz4N1TdlT2X4JwWTmJuUaGD+js3Rkdxa/CyNDL1PCvctDcMZ+a5vz7b+mzNKGuv/rmFqehiZ6Cko0n2TxGvbT/PY5cjgOZSr+lu+OR+NiOREX5v5gKgxEOgb8TbqWEK8anMs0CUugJOrNuhxF/xQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j+yngB1uhs7rwKMNZikUS6JstU1NOp3LpxfNTlL9VDY=;
 b=XZCH7NxSSjqAgHFtZnJpUsPXCThQky/okCJKdLUzXi0oLSq7MaKKuHXxeKPCRjXsa5YevO+x4PXPqJMmjQ/6hmonQipzJ19NtqjJKr4VPl5SVq1gm9/GH01A5qMvXKR8Oz487bVR7brtEaIeq9ur5KZ6gtLfG+aO/V32/DgcstelzKP/yKQHe7vC0nzHl8IZiVuJ7iaT8gcSQODiHO2XlL+H1/nXsp4Yrnda2Y//2nlTsHk5XIi/F+OMnVibgC4Vr+48fcWTrNOf6pWh4rc5b2jb17UQIIRmWz/pw4WgY+kbhczwiN0MjHSNKsTksG72nkR+LoQsW4dJd8uKy9i9VA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vmware.com; dmarc=pass action=none header.from=vmware.com;
 dkim=pass header.d=vmware.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vmware.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j+yngB1uhs7rwKMNZikUS6JstU1NOp3LpxfNTlL9VDY=;
 b=sY2SXm6Pt5/F/h/iVhiy0r3bStcgSpnVYxsfqBwh8dJa/SNms5lO+qcYvCXzDLve6li7v9n9OH/uplqoX25dz1orTjddBmOvOmlIGsbku29Cfsl+4Knqfn37pE/JR1feQl/PGk2LSM54jCsXV6HcKSeAmMvQ8umhjC3ERz8x95I=
Received: from BYAPR05MB5206.namprd05.prod.outlook.com (2603:10b6:a03:96::22)
 by BY5PR05MB7076.namprd05.prod.outlook.com (2603:10b6:a03:1cb::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.6; Thu, 5 Aug
 2021 14:33:53 +0000
Received: from BYAPR05MB5206.namprd05.prod.outlook.com
 ([fe80::8c39:38a4:39ec:f5c2]) by BYAPR05MB5206.namprd05.prod.outlook.com
 ([fe80::8c39:38a4:39ec:f5c2%6]) with mapi id 15.20.4415.005; Thu, 5 Aug 2021
 14:33:53 +0000
From:   Rahul Gopakumar <gopakumarr@vmware.com>
To:     Valentin Schneider <valentin.schneider@arm.com>,
        Abdul Anshad Azeez <aazees@vmware.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     "peterz@infradead.org" <peterz@infradead.org>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "juri.lelli@redhat.com" <juri.lelli@redhat.com>,
        "vincent.guittot@linaro.org" <vincent.guittot@linaro.org>,
        "rostedt@goodmis.org" <rostedt@goodmis.org>,
        Rajender M <manir@vmware.com>
Subject: Re: [Linux Kernel 5.13 GA] ESXi Performance regression
Thread-Topic: [Linux Kernel 5.13 GA] ESXi Performance regression
Thread-Index: AQHXhTyNLF9o+lnoy02JoxwVp6cTWKtbgqkAgAl6+kk=
Date:   Thu, 5 Aug 2021 14:33:52 +0000
Message-ID: <BYAPR05MB520669C6C1A8A522B1DE0EAAA4F29@BYAPR05MB5206.namprd05.prod.outlook.com>
References: <BYAPR05MB483975D437F293A40BEF3189A6EC9@BYAPR05MB4839.namprd05.prod.outlook.com>
 <87a6m4kk4f.mognet@arm.com>
In-Reply-To: <87a6m4kk4f.mognet@arm.com>
Accept-Language: en-GB, en-US
Content-Language: en-GB
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: arm.com; dkim=none (message not signed)
 header.d=none;arm.com; dmarc=none action=none header.from=vmware.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 840f7434-9de2-4c8f-c3ac-08d9581e0c70
x-ms-traffictypediagnostic: BY5PR05MB7076:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BY5PR05MB7076919AB0DD0A7ACF737F37A4F29@BY5PR05MB7076.namprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:254;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: n7pcHjxi/cP/bv1wjJU/WhTomhcFfCQYggoiknTU48MVBJbsEAI0VsdWnKwg8BMSN0F90HYsAUp6aptYI84Lwwb605vRSArQ/WGLG+Y3tPCKWnXu5B8tRycwqRW1X4XaezYAEScZAg6ntjCEqP0CkW5AiON3ztklEhRxkZP5WDZ3Cy2+mZNTS7Em0edpcdKtvYaqHHCpOW3ZNP4uwphOUOOYHO3uHVcbdEUStZcK8BrDgyHhqpS52PZW+eyMga2N4TgLNHOY78bjvAE/F6OtLcAGxWnnrsCgvEnwdkmhpXr/RNEPBfZ9JjXredxatx/J1s5hQdUbjVc8EJsUH7UFTsQMnA7Not4spcrT/Ta8CjI9kEtA5YECxUbA5mzKfeN4O6KRlXQfupx4loR9J/3c138r30FZUxl3NK+MHlfbsIJS7nJLmAsE4aZzVPsVdHg3+4BU5cGRxjvuccjKwaYx/1k46EXLKyzcoehaJbUVES/kgiX1GDukgA8wxLZT6pJ8snnuNpC6N1QS/Bi2CUkqZDD7t2dj1yYrAtYfglHHpoA8g3rvv7Iyw/6xcv5L1msH34jpiLAcA/C9+/WNhpEWDlZJa2MnJieiYAsxguD+ZUU/DLzWvXItdiBUD7k7qCK03ecLINRVCeaqWnNpHF9t3pOVP+BdmEoo3fmc7xxQDQMNBy9sNgt7OQaXSnlaPDWKEjd+s1bi3xkuvaO3Xa/f+w==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR05MB5206.namprd05.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(71200400001)(33656002)(86362001)(7696005)(6506007)(83380400001)(4326008)(2906002)(122000001)(316002)(55016002)(38070700005)(54906003)(26005)(9686003)(186003)(110136005)(4744005)(38100700002)(107886003)(8936002)(508600001)(64756008)(66446008)(66556008)(66476007)(76116006)(91956017)(66946007)(5660300002)(52536014)(8676002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?tOHd6ieHoXFYLDZADawpwSEdDyf90utoGgUPGOkcv/+aPDH1s0Vs5he7C5?=
 =?iso-8859-1?Q?maZEj74aoietpHXO9yiZAyezJfhW2Ju7EgvouXXJ1zTLnXBl6PAZUnHu3V?=
 =?iso-8859-1?Q?jXC/RPyXfHK2bYsMG624xRt5uOhzIYQYnSryLFifnloXPceF5xWVWMveVk?=
 =?iso-8859-1?Q?jxuePWnm67OMGCUq3kcHOIgPev/JMEO95/ldJ1d0DwdvMcQPSXVDDpyBjc?=
 =?iso-8859-1?Q?0uUx76Vh1fEPbb5sN0Ls6uYEnJ3SgHkAY34iGBbVIJCuuGL3KgHtwlVmGA?=
 =?iso-8859-1?Q?YWxIvQbcxhlSKnAHe4MU57MHGnsK+28y3iyM1Jl80uPyVPTdCV8l510eK4?=
 =?iso-8859-1?Q?xmqNnzjefRGRY+QlhXMrf90VLjJ4L/GzvByRd00/IizXrFvLxwQhPr+pay?=
 =?iso-8859-1?Q?9mcWwfJRZ+DfkF8hq6S6VZtnhoeAI/EX4Y2ME3XbDuwgaNgtDTH8PQB7lb?=
 =?iso-8859-1?Q?Xa45Enb2S+UwamPlBQ+p/ThJwZcLSEaRNIadsJWwKT3xAIyb+w9OcKAGzD?=
 =?iso-8859-1?Q?fpKv+R/hckpUOqHvVlV19RYOQN7vL6NDWpnqwcZxwlEWEWC+UmV82FQW50?=
 =?iso-8859-1?Q?aZm+a14+3aFTq7wLIiII+LQpvyJWDsNJRxe9oh4PGVD0wtTp7rn9ez3qEp?=
 =?iso-8859-1?Q?fUPhC68nvCBA8jdhQ+wT+CtZMvMnHHc3y2yjBcm5OQJxJJhS+XDzPzBh7T?=
 =?iso-8859-1?Q?77LKFTayBbQrl6UFHs686vi7RxKED/meKTsjVqS9sjt4tP95iH5PkN3RtD?=
 =?iso-8859-1?Q?czByddkZr4nGL6OKua27DrjI3adciHYgJ6y20aAXCkUwChxdYAMR9ZzohQ?=
 =?iso-8859-1?Q?ag7mFbEgwCoSUwH8wAHAT3KtdPcSsGnFqCatBIdTnKrRlFXAq421CuXE7T?=
 =?iso-8859-1?Q?1Fi3ddkowvSImRsLl8cdvp6Ardw0+i42TzlX9EN/wmrR+ymrWB7HrFPBvy?=
 =?iso-8859-1?Q?+fktoGW4Bp6mdCgQ2o3dusiZmnv5QWp7WYXXW6hgDX/M99SE5sf8M+zKqc?=
 =?iso-8859-1?Q?qz5U9PmcBn5dlA1Kp5TySdWekPf0dyKsP6+5c1/TRd32OGfNXXV4eTqkd0?=
 =?iso-8859-1?Q?QTCPQxtri6BrbfKyhfGX29+Cy5M7RQ7tKmSmTuxmEqAgH4hhK4G9ge08tB?=
 =?iso-8859-1?Q?oBes2+k0dTPiuXg1g6RLw+q10TYEAqQV5Tf6eov7qd84WCDXNDxG9JyOiz?=
 =?iso-8859-1?Q?vmrZSv6fSvkR7jfQQiuVzZ97tdudShxVJHmi7r9vrLo8og5rOjxJ89vnC0?=
 =?iso-8859-1?Q?9EBkAljLeWpYeEkEsP9RIJ0ybspvFI9SdJv7+eGtVcaSpjiv0QTaVYpX6q?=
 =?iso-8859-1?Q?w0DxEjeewgAj+6irpzAbwlp2xCGeqq8OUf0v6lELXWAnzXg=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: vmware.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR05MB5206.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 840f7434-9de2-4c8f-c3ac-08d9581e0c70
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Aug 2021 14:33:52.9366
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KBFq+vUUfE5XzAoB/i/Bzq5/h7rpGiOkMdLMG0KOzbdNlsB11B+LY0JDpqDGmu9M7hdIStjurz30Ir7J40ywaQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR05MB7076
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> sysctl_sched_wakeup_granularity's default value hasn't been touched since=
=0A=
> 2009:=0A=
> =0A=
> 172e082a9111 ("sched: Re-tune the scheduler latency defaults to decrease =
worst-case latencies")=0A=
>=0A=
> and the automagic scaling (see kernel/sched/fair.c::update_sysctl()) hasn=
't=0A=
> changed much either.=0A=
> =0A=
> What's likely to happen here is that you have a service in your distro (o=
r=0A=
> somesuch) tweaking those values and since the incriminated commit moves=
=0A=
> those files to /sys/kernel/debug/sched/, said service doesn't do anything=
=0A=
> anymore.=0A=
=0A=
Hi Valentin,=0A=
=0A=
In our testing, we use RHEL 8.1 distro. It looks like tuned daemon updates=
=0A=
15ms (per tuned virtual-guest profile) in /proc/sys/kernel/sched_wakeup_gra=
nularity_ns=0A=
file during tuned's startup.=0A=
=0A=
Now tuned daemon is not able to update the value as the commit moves those=
=0A=
files to debugs and thus sched_wakeup_granularity_ns file remains with the=
=0A=
default value.=0A=
=0A=
Regards,=0A=
Rahul Gopakumar,=0A=
Performance Engineering,=0A=
VMware, Inc.=
