Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6669630CE28
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Feb 2021 22:45:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232546AbhBBVox (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Feb 2021 16:44:53 -0500
Received: from alln-iport-6.cisco.com ([173.37.142.93]:10286 "EHLO
        alln-iport-6.cisco.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231406AbhBBVot (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Feb 2021 16:44:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=cisco.com; i=@cisco.com; l=812; q=dns/txt; s=iport;
  t=1612302287; x=1613511887;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=hITetP0vfl5FlV+8DrxWLjCx1LiFKZot7vpq0ds1nBU=;
  b=izVp8Ju3TOSlHNBZXF/GtjRam8JYefxFPl9tXqkM0vEMvmYf7NUc4DZS
   g4MLD45IbtY+zPvsxXqjfEE1WCvCUq+9lKv/kHr4K2CCQM7boyTRl8vR9
   vrpxLGWA1QjjtlmJuNA/hlxp4gtDtn/PL5owqD+NYwLgO+htIzszeJGvz
   g=;
X-IPAS-Result: =?us-ascii?q?A0CcAwCDxhlgmIYNJK1iHgEBCxIMQIMiKSh9WjIxCgGHf?=
 =?us-ascii?q?QOODo9yFokRglMDVAsBAQENAQEjCgIEAQGESgKBfAIlOBMCAwEBAQMCAwEBA?=
 =?us-ascii?q?QEFAQEBAgEGBBQBAQEBAQEBAYY2DYVzAQEBBDoGAQE3AQ8CAQgVAx4QFB4nB?=
 =?us-ascii?q?A4FgltLAYJVAy4BDqUaAooldIE0gwUBAQaBMwGDWxiCEgMGFIEkgneKbhuBQ?=
 =?us-ascii?q?T+EKj6CXQECgV4ygxuCLIQDAoFMeZJwiCedWwqCeJtzMQ+jDbYdAgICAgQFA?=
 =?us-ascii?q?g4BAQaBbSGBWXAVgyRQFwINjiEaHYM6ilh0AjUCBgoBAQMJfIoIAYEQAQE?=
IronPort-PHdr: =?us-ascii?q?9a23=3Au1d8Whc0aqb8whVZ451oqj/PlGMj4e+mNxMJ6p?=
 =?us-ascii?q?chl7NFe7ii+JKnJkHE+PFxlwaTAdfD4u9Azu/RtLrtH2cH5MXJvHMDdclKUB?=
 =?us-ascii?q?kIwYUTkhc7CcGIQUv8MLbxbiM8EcgDMT0t/3yyPUVPXsqrYVrUry6q5CMWXx?=
 =?us-ascii?q?D4MhB4YO/yH92ag8G+zevn/ZrVbk1Bjya8ZrUnKhKwoE3Ru8AajJEkJLw2z0?=
 =?us-ascii?q?7Co2BDfKJdwmY7KA=3D=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.79,396,1602547200"; 
   d="scan'208";a="679837992"
Received: from alln-core-12.cisco.com ([173.36.13.134])
  by alln-iport-6.cisco.com with ESMTP/TLS/DHE-RSA-SEED-SHA; 02 Feb 2021 21:44:05 +0000
Received: from XCH-RCD-001.cisco.com (xch-rcd-001.cisco.com [173.37.102.11])
        by alln-core-12.cisco.com (8.15.2/8.15.2) with ESMTPS id 112Li5Kw019149
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=FAIL);
        Tue, 2 Feb 2021 21:44:05 GMT
Received: from xfe-rcd-003.cisco.com (173.37.227.251) by XCH-RCD-001.cisco.com
 (173.37.102.11) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Tue, 2 Feb
 2021 15:44:05 -0600
Received: from xhs-rcd-001.cisco.com (173.37.227.246) by xfe-rcd-003.cisco.com
 (173.37.227.251) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.792.3; Tue, 2 Feb 2021
 15:44:05 -0600
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (72.163.14.9) by
 xhs-rcd-001.cisco.com (173.37.227.246) with Microsoft SMTP Server (TLS) id
 15.0.1497.2 via Frontend Transport; Tue, 2 Feb 2021 15:44:04 -0600
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dN4KZjrFPZu0RHoSqkWqE240HN+hqgKdDKhTpgqWtUs6T5eYpb0bLc6UbNGm7gnYUh3Hb2ma1A4+jO2XYP0mL9l+7HywYWb24YBW7evZOfNIS3uNLkSHDiCd3Vr5coTcDLhec+w/j0YQvI5gJshZXPTk6IaYES7S3mjK/HZBMr91hGcHxxYGFB/lyq0aHrD59QQRm100eOypSyTQwZJj8ZkiX05olVjpEzlwwBV56RykQmZ3wJU6+m8vWeK2OF0mfvp0ngXKnip6t9kmFXxciCYW4AgS4CagjWPplo0TQvTj23RNdBwuMY/do+yvlhmvHR8pzvF+TbrYjF3DHgrvCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nrX9Gw9JjkknZNnQu6hSdQyGBVmCdcpw2UG2w2Kd7m8=;
 b=ZV44tEPvxzSev5yn0B2O/eqENfF6cC0Wun2kxjs/q2aAIszP/vvGR3xlHJeZ+wI2iBzbcSkMlKA4C3B0izlARmGnV9WK3UzHOxOIG16s3B2hcLMRn6eDKMweocFbR6mrHZ4qqfBdlnjE0rPigV1zp6L90RrsW/OhKggCfL4nZ8+mK6xKvMwKUMIkRcNRsbLGlK5FzM9GlHRtWI+1ITyb6ncFYYuuMtK5EUnZpNsAJ0yIzSbabY0TfOS4QyPjt0jNhINCOseAk4h0flSJ0fNZrCHBhNvFZUOkNbPbcMqZ/BmltUhPyzzVPPNxWVYZzMCycVrhUilnHiS0m2hCEfIStg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cisco.com; dmarc=pass action=none header.from=cisco.com;
 dkim=pass header.d=cisco.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cisco.onmicrosoft.com;
 s=selector2-cisco-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nrX9Gw9JjkknZNnQu6hSdQyGBVmCdcpw2UG2w2Kd7m8=;
 b=tOt5lhB2QVzl4Efb41hJpndd9rPOMvWBtM56bbbOkgxaIRs99MziYBuABFzi2bl8Y3ygVP7DGeC07Opf1ej+fT578pyWvepX6Oa6YKtyDWkUZ6u3nqk0cB1Mrspdz8Nm4/LErf656KKt0SvRJ/H/kEYHV2/tbyBWZxCPu0z3Rsc=
Received: from SJ0PR11MB5037.namprd11.prod.outlook.com (2603:10b6:a03:2ac::21)
 by SJ0PR11MB4847.namprd11.prod.outlook.com (2603:10b6:a03:2d9::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3825.17; Tue, 2 Feb
 2021 21:43:58 +0000
Received: from SJ0PR11MB5037.namprd11.prod.outlook.com
 ([fe80::f5b5:4b05:475a:f82c]) by SJ0PR11MB5037.namprd11.prod.outlook.com
 ([fe80::f5b5:4b05:475a:f82c%7]) with mapi id 15.20.3784.016; Tue, 2 Feb 2021
 21:43:58 +0000
From:   "Daniel Walker (danielwa)" <danielwa@cisco.com>
To:     Paul Moore <paul@paul-moore.com>
CC:     "Victor Kamensky (kamensky)" <kamensky@cisco.com>,
        Eric Paris <eparis@redhat.com>,
        "xe-linux-external(mailer list)" <xe-linux-external@cisco.com>,
        "Ruslan Bilovol -X (rbilovol - GLOBALLOGIC INC at Cisco)" 
        <rbilovol@cisco.com>,
        "linux-audit@redhat.com" <linux-audit@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/2] audit: show user land backtrace as part of audit
 context messages
Thread-Topic: [PATCH 1/2] audit: show user land backtrace as part of audit
 context messages
Thread-Index: AQHW+ayD0lMF6lgWmUKFQjEuERA8dQ==
Date:   Tue, 2 Feb 2021 21:43:58 +0000
Message-ID: <20210202214357.GD3710@zorba>
References: <20210202212930.18845-1-danielwa@cisco.com>
 <CAHC9VhShkEJHWmuE2C_RLQy-Z3CpvAhTj68ki22v=AKF5hfvrQ@mail.gmail.com>
In-Reply-To: <CAHC9VhShkEJHWmuE2C_RLQy-Z3CpvAhTj68ki22v=AKF5hfvrQ@mail.gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-Auto-Response-Suppress: DR, OOF, AutoReply
X-MS-TNEF-Correlator: 
user-agent: Mutt/1.9.4 (2018-02-28)
authentication-results: paul-moore.com; dkim=none (message not signed)
 header.d=none;paul-moore.com; dmarc=none action=none header.from=cisco.com;
x-originating-ip: [128.107.241.166]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 804d5706-7ccc-4304-b10c-08d8c7c3a599
x-ms-traffictypediagnostic: SJ0PR11MB4847:
x-ld-processed: 5ae1af62-9505-4097-a69a-c1553ef7840e,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SJ0PR11MB4847A426E4716B2AAEF46B40DDB59@SJ0PR11MB4847.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: pGdUec0yWy3k7gjdqs27l+SSycT/1sgXVQxMMioK9pDIrDtBLGbKLLNrfqkKlSFr4IKuuezCXWWl98rUbcDmEgrGT5at1dgO8NCkJZDmU2qwt1fqeVyYUuf2nOlyeGbGzcDWL1m1NNLKveCcJHaNFE6oc0eG0+shNBpIP8spuTbvZXoNfnEtWm19cmdfxDwcsSKq+2J4+Fuq0D5fo4gly/VJjWTtDiyFbEw7Tjkd8FUxzmvYI+Tpc2rfQRf34bloFfIude0DOxAwaxT0EPm4VT4HVmd7qtzg5/Z4P4RutN4J8bEhvZJz0XpOyho/9sGrmdx6DAS8I9dI9tR0NfCHJ8z0mlPmnHoxhOba+e1BFE62cVD/qDrIRTf9iXlyaY+X/fxSq/OKi0xsBjaakQrZN5bQCm4w6zcAMnU+jvfH3fsfoFcYkHuMWylMXdo861bWXcrDH55jeKwTPhhT7gpsceaQFSSaH6Ai5fAXvHB70Iq8mlnn+/8BD1WlqwJFpucbzyXyx5uX8IA0yPpeJN40lsa/gYO39os/VZOsYbDIYhe7VynKzkmtkI6g5Lflk/G+J9hdTaFyzIq0Jgg6S/eOONfoHN1lVP4Uw0jbFI6soZY=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB5037.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(7916004)(376002)(366004)(396003)(39860400002)(346002)(136003)(186003)(8676002)(15650500001)(2906002)(86362001)(6486002)(33656002)(83380400001)(26005)(966005)(6506007)(71200400001)(8936002)(53546011)(478600001)(33716001)(5660300002)(316002)(64756008)(54906003)(4744005)(66446008)(66556008)(1076003)(66946007)(66476007)(4326008)(9686003)(6512007)(6916009)(76116006);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?oqwwRIWhruAhsFEJ0L1KVvav4DtizILkNXq72ez0e6m0dbqHChQkPqfIYYdn?=
 =?us-ascii?Q?ElWQwQgD/eIdXkU5ysPrUaP6SQCdKWEiSUjd8xJivnRM4JN2plpTnTvOfXVY?=
 =?us-ascii?Q?4cfvXV0+7Pn9TJlccDP91XuHl9pk7g5j4HdgkU04nf2A3blAcDOz2oVO7XPt?=
 =?us-ascii?Q?HVtZvxqbH9Ht+uQCCznYRIe+IO0DCdaKWZV3/Aa/N04Fu6HuXd60xBah2eol?=
 =?us-ascii?Q?ip928uYrh9k8hXVJibYEEQGnNRzq2cfmN7D8/HjLeGDFIBGYr70KbS+u3f3V?=
 =?us-ascii?Q?wARybEP39UpLdWZIfORqyJJ4PK6CXxqMGNwxU7vjVdEkJModeVmGdrIugDnO?=
 =?us-ascii?Q?RQuy/R3RtzD2LlpvOWD/I/tYkonFvu1PLR7A3whT3dk7f1hbNrQKcrZtDMRj?=
 =?us-ascii?Q?VsFEVjkLD/6mzQtRbX7wThxbOL1cu1NbHn03IbRKmWvOpEm1cngkYoOU/Dsf?=
 =?us-ascii?Q?Axm9Mpp6n1ztbjIpcuyQSmsNL3mbHXfa8FiEPHfnvJktqers2dIQdtryytpR?=
 =?us-ascii?Q?Ydf3+7ZpBYcLIczd2n5gXCWznIKJ34iwwR9+ZQJYniJchbTE9nPN9MUDdr1Q?=
 =?us-ascii?Q?ainYxjQ5MBY3FWVwYTtBArR3+1q6zWQiDs7qtC0rrI1UEbN/hydHHv+fBv3g?=
 =?us-ascii?Q?zrkMzWISLrUr3NJj4dm0GSAb2dIsxJrviYlYhgM3xepgKyMA+sS0Lb7GXBNC?=
 =?us-ascii?Q?wJdMkaTs0kN2/d8RtEh+h4vYr0yoXMUwKyrDZeHUBxKCWViR5u/lEM/BFY3x?=
 =?us-ascii?Q?U+hLehXvuOElaFvZEzqChG2uFWf4GHzX001nq6KaWYpjKXnWA4c54u3dq36q?=
 =?us-ascii?Q?YedjbD8GadagF2JOLhuFXQ5DunajeUzittrf1Sa6jtAPxx5Je+Yd6M/IovM2?=
 =?us-ascii?Q?P0Sz6h0QOv7KCjBY3nH4+h+G5YG4HJsfRgFL8gSul4y7jFSK1/Mhjjl+mLX/?=
 =?us-ascii?Q?PYOvCoipoxE5IR9tPHgPeZbvmWOSbjPfs6p+/VbBcD3p6T0ahfupRY4Bbau7?=
 =?us-ascii?Q?21TkDQ4x0zPK7Sqsh/Id2tdWhgHy7O6aWYMFwVk/o1GNa3KNoDWhFFwEULi7?=
 =?us-ascii?Q?AJdzDTB1G4CsuXFkOM4TYBgy/C4w1Q=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <94C27F14C2310741B4EB9CF84B24D366@namprd11.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB5037.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 804d5706-7ccc-4304-b10c-08d8c7c3a599
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Feb 2021 21:43:58.2872
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5ae1af62-9505-4097-a69a-c1553ef7840e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HzXvSojhuXe9gZRm/OMSqo286O3XVquphcORzXauxbEAPlAswOCZFKE511drcLgIj8ngYJT7qvwJS3U66mliVQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB4847
X-OriginatorOrg: cisco.com
X-Outbound-SMTP-Client: 173.37.102.11, xch-rcd-001.cisco.com
X-Outbound-Node: alln-core-12.cisco.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 02, 2021 at 04:35:42PM -0500, Paul Moore wrote:
> On Tue, Feb 2, 2021 at 4:29 PM Daniel Walker <danielwa@cisco.com> wrote:
> > From: Victor Kamensky <kamensky@cisco.com>
> >
> > To efficiently find out where SELinux AVC denial is comming from
> > take backtrace of user land process and display it as type=3DUBACKTRACE
> > message that comes as audit context for SELinux AVC and other audit
> > messages ...
>=20
> Have you tried the new perf tracepoint for SELinux AVC decisions that
> trigger an audit event?  It's a new feature for v5.10 and looks to
> accomplish most of what you are looking for with this patch.
>=20
> * https://www.paul-moore.com/blog/d/2020/12/linux_v510.html

We haven't tried it, but I can look into it. We're not using v5.10 extensiv=
ely
yet.

Daniel=
