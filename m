Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D3AD6305E3F
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jan 2021 15:27:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233787AbhA0O1E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jan 2021 09:27:04 -0500
Received: from mail-eopbgr80084.outbound.protection.outlook.com ([40.107.8.84]:59317
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231995AbhA0O05 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jan 2021 09:26:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C4EXtHQa8cM67xNRcrIc3mWRLsnU4WUszwJuXfjD4bU=;
 b=wmrSc5z8AC5aMrTrr+gCRkxfQbfQcKnzSIdgFAeA9mVQdg5EqCqUpwOWX1OGXI6RCLI1Ty+fUuu8gE7OIPEBjX3xf/EZ8Keo1ISz0nDA4XnzBpfr1YLYR6CeyCE4fOkz14eIoduDDl+RNno9Aaw9DMGA0hS7M0F7dbCXb7m6a94=
Received: from DBBPR09CA0046.eurprd09.prod.outlook.com (2603:10a6:10:d4::34)
 by HE1PR0801MB1963.eurprd08.prod.outlook.com (2603:10a6:3:4f::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3784.13; Wed, 27 Jan
 2021 14:26:04 +0000
Received: from DB5EUR03FT016.eop-EUR03.prod.protection.outlook.com
 (2603:10a6:10:d4:cafe::26) by DBBPR09CA0046.outlook.office365.com
 (2603:10a6:10:d4::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3805.16 via Frontend
 Transport; Wed, 27 Jan 2021 14:26:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; vger.kernel.org; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;vger.kernel.org; dmarc=pass action=none
 header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 DB5EUR03FT016.mail.protection.outlook.com (10.152.20.141) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3784.11 via Frontend Transport; Wed, 27 Jan 2021 14:26:04 +0000
Received: ("Tessian outbound e989e14f9207:v71"); Wed, 27 Jan 2021 14:26:04 +0000
X-CR-MTA-TID: 64aa7808
Received: from 7cf2cf83872b.1
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id EE134512-4962-4039-A8D2-E0B5A8DE1D08.1;
        Wed, 27 Jan 2021 14:25:59 +0000
Received: from EUR01-DB5-obe.outbound.protection.outlook.com
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id 7cf2cf83872b.1
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Wed, 27 Jan 2021 14:25:59 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ku6gi2a/SmZ+VaBmf95F30F4A6U/LRT6Dh7/JMNtC3bhpFQryYRg/LqnN6+e/6+Y5tA6AcVoBnTkZ3lBT9+EX4yW9LpQ2/MuQJ8IsAI3mW1sxfbpkzj18zbg/WYN+7O1xwoLrO0BmrYwDU+O5uOFt/zOUTTUeKIu4b0qnhLc1Wh05uxVLPavT4fWfjuIJRwPqkzGOpF2UvorrZBOlgsiBocXv1OM9bUPTRgKkTsewFvW7zGDNQURQoyoEcYDwSDu5CrvrIAgaNeK3lFQClY8ZHQ8tn1nRPHSx9SGVBkjH1qauq0tBSjqEoFy5v47L4tAnbFBM/GxOFuIeBTvoQBTig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C4EXtHQa8cM67xNRcrIc3mWRLsnU4WUszwJuXfjD4bU=;
 b=Esa+IYXeAEMzazPXsSbNGLIv2VVytauzKhKRDcskD3ZQPk+f169OqwOe4zJBZI0A5LUBaESFNMUUUKP2P3udlbIr6ooFYfF6XqwQZqx88qyucQbbQNNLTZac7OJ5/0cRYnZ8l+YvQJ3/aeOBewkD6KTTzL2U1UFniM+obHkPttqDwhjFxBvHcXzmwJXVG/7147hQqEL6ch4/VjQrVkUoFLPy4A48B1q2HRtR2S1IORV1o4PolMy1sJqajlAxmJtmxpLIFHdeEqTDsPG9LWnc3pQVaEifUiEHRaBUK2w4jB+Se43b/ELqfIhdA1y97fEdvpy6HVmc9Vt1R0lOcn/Dvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C4EXtHQa8cM67xNRcrIc3mWRLsnU4WUszwJuXfjD4bU=;
 b=wmrSc5z8AC5aMrTrr+gCRkxfQbfQcKnzSIdgFAeA9mVQdg5EqCqUpwOWX1OGXI6RCLI1Ty+fUuu8gE7OIPEBjX3xf/EZ8Keo1ISz0nDA4XnzBpfr1YLYR6CeyCE4fOkz14eIoduDDl+RNno9Aaw9DMGA0hS7M0F7dbCXb7m6a94=
Received: from AM6PR08MB3589.eurprd08.prod.outlook.com (2603:10a6:20b:46::17)
 by AM6PR08MB4817.eurprd08.prod.outlook.com (2603:10a6:20b:c4::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3784.15; Wed, 27 Jan
 2021 14:25:57 +0000
Received: from AM6PR08MB3589.eurprd08.prod.outlook.com
 ([fe80::201c:d613:b9bd:fa33]) by AM6PR08MB3589.eurprd08.prod.outlook.com
 ([fe80::201c:d613:b9bd:fa33%7]) with mapi id 15.20.3763.019; Wed, 27 Jan 2021
 14:25:57 +0000
From:   Jianlin Lv <Jianlin.Lv@arm.com>
To:     Masami Hiramatsu <mhiramat@kernel.org>
CC:     Oleg Nesterov <oleg@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v3] tracing: precise log info for kretprobe addr err
Thread-Topic: [PATCH v3] tracing: precise log info for kretprobe addr err
Thread-Index: AQHW8zNhQKRvGbxdckymzuUtTURLX6o4ptSAgAAFXgCAAKEyAIABDbmAgABfZwCAAAtrAIAAtAyAgAAPwGA=
Date:   Wed, 27 Jan 2021 14:25:57 +0000
Message-ID: <AM6PR08MB35893F025846337815C6C8EA98BB0@AM6PR08MB3589.eurprd08.prod.outlook.com>
References: <20210125160108.2147511-1-Jianlin.Lv@arm.com>
        <20210125181926.GA10248@redhat.com>
        <20210125133840.511b1496@gandalf.local.home>
        <20210126131536.f6e3a737a7b948799084fa7a@kernel.org>
        <20210126202058.GC12469@redhat.com>
        <20210127110226.a65b3e8c66eeab6ee63f8aee@kernel.org>
        <AM6PR08MB3589EE4B5F1F56B84FE2750598BB0@AM6PR08MB3589.eurprd08.prod.outlook.com>
 <20210127222743.771338cf7f89fb0b78dd838c@kernel.org>
In-Reply-To: <20210127222743.771338cf7f89fb0b78dd838c@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ts-tracking-id: 192BFA20D8AD6C40BDA250D4618A2F2B.0
x-checkrecipientchecked: true
Authentication-Results-Original: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=arm.com;
x-originating-ip: [2409:8a1e:6f3c:a010:9402:2a8f:81e5:4b2e]
x-ms-publictraffictype: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: c6b13e3d-d83f-47fe-d7dd-08d8c2cf7aa3
x-ms-traffictypediagnostic: AM6PR08MB4817:|HE1PR0801MB1963:
X-Microsoft-Antispam-PRVS: <HE1PR0801MB1963E4DA714BC58FF1379C2798BB0@HE1PR0801MB1963.eurprd08.prod.outlook.com>
x-checkrecipientrouted: true
nodisclaimer: true
x-ms-oob-tlc-oobclassifiers: OLM:7219;OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: S/3L21/6tQYUwcEstCkV56/El6ot1llmU5ACYUDPLPGYxpuqVfUKuruqC767pIwM7/ImlXmnK0pMtvBNf1EAOzZC4oRADprReQZc0eNMTOnHdaPdFpzHvYYJxVFSWSo3EZo0usEOU85yvANIs3lYwjOf+/uITpvhGajkNwVimEykiUW2UcZMlU8Y6wuooSS5zk06mEmP4HRaaHIAzx6EeiN2lIepER8Cw/jHYmCyE1Hdhgl6ydO/L9oK44V5olzLTEqpUjRZjx2DIanQZlyIKH0Mw8t2+khiBjhtvBUto8C3ynQ88gIAAv02Wl2c6USksTjU+e3zHX9AIPSBtaPMJIEMJGFFctNf/YE0VjOT9exSXdQ+XRCEgDfyGLDFVJGvrKB5Mdtd1EFPIWfyLTIkJhgukEt3X8QhFaiYV/Zimlk4Mn089pD18S3E3iF5l1p7rPNo0s4H2+iIYNmthIGjClYuA2NC/henTQ7R7NFF7sjdK6qhoW7gZ2ChYb66bwW8iQx+/h35zO+ch2ri2kBIRQ==
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR08MB3589.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(396003)(376002)(39860400002)(136003)(366004)(54906003)(33656002)(8676002)(66556008)(66946007)(66446008)(7696005)(186003)(52536014)(76116006)(316002)(83380400001)(66476007)(64756008)(2906002)(9686003)(53546011)(71200400001)(8936002)(55016002)(478600001)(6506007)(86362001)(6916009)(5660300002)(4326008);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?Dy6u7TQjLD1CS5qj0ywSC7r69JWcZXWHDTs+6QEFv6N/PQKsrzr9TzDV3ISY?=
 =?us-ascii?Q?6gm5l1fEBwqHOc84QSRVQwUkZxEkWxd10NN6Aq9ZO8prf58FM0SnB+yxBWwY?=
 =?us-ascii?Q?EKx2O+zZ+zJGG0mwPFTMOM0Fu2+Fqv44XXN5uaXArMmtxWKcsFFoXKapcs39?=
 =?us-ascii?Q?nCTZszxBrrYmV33ANFe1IZ1hK4sD3b25lNfUN/Md2u9Taeo5nYTEykT/C29E?=
 =?us-ascii?Q?lz3kuAK1L5TCZsJlGxh1jRRLpMonvpQs8SJPaKxweX9uf40rH/qBq9iYRHp1?=
 =?us-ascii?Q?Ar8xCimTqDciUbek3nY/9VMtHJAoaXeC1sJaz85jVKLay3PapD6g5Rben72H?=
 =?us-ascii?Q?A0xyvFTPE6hhV3xQUiULQkTKlgfbKJz5MDDLCvSbgfFQdmnSoRBWV57HIASC?=
 =?us-ascii?Q?IdvZxtjFsvL0UttW9Nh8jkL7cBbE/A5Io1R16TCStqmvcCc8HhfjBBnaDsWO?=
 =?us-ascii?Q?lZn5kahpNHCqVkLOVuOOsHtDujkgK9Y24meevOIx6XjiUKC1sko9Aj0TV7jp?=
 =?us-ascii?Q?lr49Ggwg2IduOPZZSHN2f6tlZB0jHHon4ROdMKYZ8pCnn9MpUDR2fvvEJ3/t?=
 =?us-ascii?Q?G/iaa0UEniGKQZucjL+iV2adD7qdVrFA9AvakmCx2q4bq1hF6pkQdI5LO9GM?=
 =?us-ascii?Q?XxM/NMKqNmMw8zu13SbrLe/uODYGeYDU/1git6nZodmmE9MaF3a4D0jbDe22?=
 =?us-ascii?Q?G/PG2u7Cz10CuyNl+kEXO24hRXJSab8NRX4Uk9+PbdJpTEPvhd19V4m2eqN4?=
 =?us-ascii?Q?zhgk6baX/o7QClfauVrZidcOIXrZGUZaQPmKSTN0W8z0lqSuAf9ogSmqph7m?=
 =?us-ascii?Q?dxq13JmQ2yp3Fy8uEHwt/3YUZ/DmoA6aJj3pWvbyeWkpbCsQPkvofMGqwICQ?=
 =?us-ascii?Q?o1/IWwdhM7TO1tPyy1VeaLQV1wOkHFteJdy5uFRM691FWvxOYFo6bhXLFMW8?=
 =?us-ascii?Q?Lg4erV45UStJJVF1pmi9Va9fQjecIYc7goA1nULgjqAjvfegaIHiaEUfAXrW?=
 =?us-ascii?Q?9woD06RYAYxEJjvpPZ+hsoyQNl7L7PQNmiRvDoc5YdBTol0FrkycLGJc3JPp?=
 =?us-ascii?Q?wIPzy5KYmxRPI94kUiDNjYC8RC4azuFN+XwvJwBc1IAXQZIoKi97hyOHyBXC?=
 =?us-ascii?Q?luC6c8GiS1D7?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB4817
Original-Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=arm.com;
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: DB5EUR03FT016.eop-EUR03.prod.protection.outlook.com
X-MS-Office365-Filtering-Correlation-Id-Prvs: 301e37a4-71b3-4113-0eb6-08d8c2cf76ae
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: AdBI8gt0Ci1bOM4ydo7RCdafEaE8I1nGd4hgvxDBA7oyjpUG12LaCfq+GvO0/h9YsZJJ+CUyK10Wy0tegRpSwMzLJUUTx/uSw0uX311jA4t/a18QMapZUcNNgnC+6VTT6M7mSp0t7F9uipe6olvczdncZ5NBF8uemoH90cGy9svAbX8WBJPHM6GAsUtKLU6/OMOCpbO2cuPH9UEZNNNxldqrYsAmJDTVRsryOTX/z4qru7KPr1+0iNfNIRZSzLo6fx9r26kSIwxdMexzSAa5+yILLz/etxEw20Tzu1mzC56co7RFnuPw09fBOxv5IeEsGgx8cpSYqRdY3dS7q16DgmSw/M/zbYCF1cabbdnpsdJQ/8ADFcCzlM4BEZfvCUFhVGhPp2K7I9cHUQ1T7l88rMoWMVPI7sRz41HNjnfecPyS6IKKlyLx+iise5QuAynrz0xxP0x/fDEKKmWlFspFtyDxrgqP8Dl2gpw/g5FrV5DmnKLsnASXM23DNjGQ0Avr6rMzBeWnixgQsSNmTLEIw+GK/G8w5joqv6DxYLEnorgJ9lrTCp+P6vcchKytBdBrUzdq7Fe0XqB50/RkMW6fC8YFel3s9ea3EKWammGJYUo=
X-Forefront-Antispam-Report: CIP:63.35.35.123;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:64aa7808-outbound-1.mta.getcheckrecipient.com;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;CAT:NONE;SFS:(4636009)(136003)(396003)(346002)(39860400002)(376002)(46966006)(8936002)(316002)(82310400003)(47076005)(70206006)(186003)(70586007)(336012)(2906002)(53546011)(52536014)(33656002)(5660300002)(8676002)(82740400003)(86362001)(6506007)(6862004)(26005)(54906003)(55016002)(7696005)(81166007)(4326008)(9686003)(83380400001)(356005)(478600001);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jan 2021 14:26:04.4372
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c6b13e3d-d83f-47fe-d7dd-08d8c2cf7aa3
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-AuthSource: DB5EUR03FT016.eop-EUR03.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0801MB1963
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Message-----
> From: Masami Hiramatsu <mhiramat@kernel.org>
> Sent: Wednesday, January 27, 2021 9:28 PM
> To: Jianlin Lv <Jianlin.Lv@arm.com>
> Cc: Oleg Nesterov <oleg@redhat.com>; Steven Rostedt
> <rostedt@goodmis.org>; mingo@redhat.com; linux-kernel@vger.kernel.org
> Subject: Re: [PATCH v3] tracing: precise log info for kretprobe addr err
>
> On Wed, 27 Jan 2021 02:46:10 +0000
> Jianlin Lv <Jianlin.Lv@arm.com> wrote:
>
> >
> >
> > > -----Original Message-----
> > > From: Masami Hiramatsu <mhiramat@kernel.org>
> > > Sent: Wednesday, January 27, 2021 10:02 AM
> > > To: Oleg Nesterov <oleg@redhat.com>
> > > Cc: Steven Rostedt <rostedt@goodmis.org>; Jianlin Lv
> > > <Jianlin.Lv@arm.com>; mingo@redhat.com; linux-
> kernel@vger.kernel.org
> > > Subject: Re: [PATCH v3] tracing: precise log info for kretprobe addr
> > > err
> > >
> > > On Tue, 26 Jan 2021 21:20:59 +0100
> > > Oleg Nesterov <oleg@redhat.com> wrote:
> > >
> > > > On 01/26, Masami Hiramatsu wrote:
> > > > >
> > > > > > >
> > > > > > > IOW, the "offset !=3D 0" check removed by this patch is
> > > > > > > obviously wrong,
> > > right?
> > > > > > >
> > > > >
> > > > > No, not wrong. Even offset !=3D 0, if the symbol exists in the
> > > > > kernel,
> > > > > kprobe_on_func_entry() will check it.
> > > >
> > > > Yes, but unless I am totally confused... if kprobe_on_func_entry()
> > > > returns false, then trace_kprobe_create() should fail with
> > > > BAD_RETPROBE
> > > even if offset =3D=3D 0 ?
> > >
> > > Yes, if kprobe_on_func_entry() returns false, register_kretprobe()
> > > also returns an error.
> > >
> > > -----
> > > int register_kretprobe(struct kretprobe *rp) {
> > >         int ret =3D 0;
> > >         struct kretprobe_instance *inst;
> > >         int i;
> > >         void *addr;
> > >
> > >         if (!kprobe_on_func_entry(rp->kp.addr, rp->kp.symbol_name,
> > > rp-
> > > >kp.offset))
> > >                 return -EINVAL;
> > >
> > > -----
> > >
> > > Thank you,
> > >
> > > --
> > > Masami Hiramatsu <mhiramat@kernel.org>
> >
> >
> > If register_kretprobe()returns an error -EINVAL.
> > This means that __register_trace_kprobe return -EINVAL,
> >
> > ---
> > ret =3D __register_trace_kprobe(tk);
> > if (ret =3D=3D -ENOENT && !trace_kprobe_module_exist(tk)) { pr_warn("Th=
is
> > probe might be able to register after target module is loaded.
> > Continue.\n"); ret =3D 0; }
> > ---
> > As code show, cannot enable kretprobe for an unloaded module.
> >
> > This is consistent with my test results (no VXLAN module is loaded).
> >
> > # perf probe -m /lib/modules/5.11.0-rc2+/kernel/drivers/net/vxlan.ko
> > \ 'vxlan_xmit%return $retval'
> > Failed to write event: Invalid argument
> >   Error: Failed to add events.
> >
> > Is this a bug?
>
> Oops, good catch!
> It seems that the bug has been introduced when I added
> kprobe_on_func_entry() to register_Kretprobe.
> Let me fix it.
>
> Thank you!
>
>
> --
> Masami Hiramatsu <mhiramat@kernel.org>

After confirming this problem, my worries are eliminated,
and the current patch will be updated later.

I am also investigating this bug, and I think this process will deepen
my understanding of kernel probes.

Jianlin

IMPORTANT NOTICE: The contents of this email and any attachments are confid=
ential and may also be privileged. If you are not the intended recipient, p=
lease notify the sender immediately and do not disclose the contents to any=
 other person, use it for any purpose, or store or copy the information in =
any medium. Thank you.
