Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8066B375FDA
	for <lists+linux-kernel@lfdr.de>; Fri,  7 May 2021 07:46:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234019AbhEGFri (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 May 2021 01:47:38 -0400
Received: from alln-iport-2.cisco.com ([173.37.142.89]:27484 "EHLO
        alln-iport-2.cisco.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233977AbhEGFrd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 May 2021 01:47:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=cisco.com; i=@cisco.com; l=5299; q=dns/txt; s=iport;
  t=1620366394; x=1621575994;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=cv0QXPxLQQJi8SDX+ZjCBMLZd7T5KYVS8GR3LkH2muQ=;
  b=kaZw150oHDzb0RLtNUDWQ0RtOoruBYWJ5GDePW8v+p8HCUzqVwkbw91i
   TISrAyEz2U9ZJtB9rhFqaOKqZFwJ/GgBKYU8e63dnvvo/0SiGQqPYZ2x8
   M8bfQsXU+Yf1URqQ1bQoTDqGE9zaD+D+KwK5guxg0KKmhUy1/B2FsohEU
   w=;
X-IPAS-Result: =?us-ascii?q?A0AkAACI05RgmIUNJK1aHQEBAQEJARIBBQUBQIFDCAELA?=
 =?us-ascii?q?YFSUYFYNjELiAEDhFlgiHQDmVWBLoElA1QLAQEBDQEBMgIEAQGBFgGDOQKCA?=
 =?us-ascii?q?wIlNAkOAgQBAQEDAgMBAQEBAQUBAQECAQYEFAEBAQEBAQEBaIVQDYZEAQEBA?=
 =?us-ascii?q?wEnEwYBATcBBAsCAQgOAwQBAQEeEDIdCAIEDgUIgmmCVgMOIQGccQKKH3iBA?=
 =?us-ascii?q?TOBAYIGAQEGBASFHhiCEwmBOgGCeIpmJxyBSUKBFUOCXz5pg1kCg0uCK4IrI?=
 =?us-ascii?q?AGBDQGBMBuBGZEmgnenNQojgm6dShClJoZprUOEaAIEAgQFAg4BAQaBVDiBW?=
 =?us-ascii?q?3AVgyRQFwIOjh8MDQmDTopdcwI2AgYKAQEDCXyLAwGBDwEB?=
IronPort-PHdr: A9a23:XU6RDBdZMjqui1IRtlTRVpiTlGM/rYqcDmcuAtIPkb9Ccq2/uZ/lO
 R+X6fZsiQrPWoPWo7JBhvHNuq/tEWoH/d6asX8EfZANMn1NicgfkwE6RsLQD0r9Ia3wYiA6F
 dgEX1hgrDm3NEFPE5P4YFvf6nS58T8VHED5Mgx4buT4E4LflYK5zee3rpbSeA5PwjG6ZOAaE
 Q==
IronPort-HdrOrdr: A9a23:cROJEa9rbSPp0OVALWJuk+ENdb1zdoMgy1knxilNoENuE/Bwxv
 rBoB1E73DJYW4qKQ4dcdDpAtjmfZquz+8K3WB3B8biYOCGghrnEGgG1+vfKlLbalbDH4JmpM
 Jdmu1FeaHN5DtB/IbHCWuDYqwdKbC8mcjC74qzvhQdLz2CKZsQkjuRYTzrdHGeMTM2fabRY6
 Dsn/avyQDQHUg/X4CePD0oTuLDr9rEmNbNehgdHSMq7wGIkHeB9KP6OwLw5GZcbxp/hZMZtU
 TVmQ3w4auu99uhzAXH6mPV55NK3PP819p4AtCWgMR9EESvtu/oXvUlZ1SxhkFznAid0idtrD
 AKmWZ4Ay1H0QKUQohym2q05+Cv6kd015ao8y7ovZKqm72IeNt9MbsauWqcGSGpt3bJe7pHof
 92NiuixulqJAKFkyLn69fSURZ20kKyvHo5iOYWy2dSSI0EddZq3MEiFW5uYdw99RjBmcoa+S
 hVfbfhDf1tAB+nhrDizyFSKfmXLzsO9zu9Mzw/U/2uonFrdSpCvj4lLeQk7wA9HbwGOut529
 g=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.82,279,1613433600"; 
   d="scan'208";a="714661149"
Received: from alln-core-11.cisco.com ([173.36.13.133])
  by alln-iport-2.cisco.com with ESMTP/TLS/DHE-RSA-SEED-SHA; 07 May 2021 05:46:33 +0000
Received: from mail.cisco.com (xbe-aln-004.cisco.com [173.36.7.19])
        by alln-core-11.cisco.com (8.15.2/8.15.2) with ESMTPS id 1475kWJa001939
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=OK);
        Fri, 7 May 2021 05:46:32 GMT
Received: from xfe-rcd-003.cisco.com (173.37.227.251) by xbe-aln-004.cisco.com
 (173.36.7.19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.792.3; Fri, 7 May 2021
 00:46:32 -0500
Received: from xfe-rcd-001.cisco.com (173.37.227.249) by xfe-rcd-003.cisco.com
 (173.37.227.251) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.792.3; Fri, 7 May 2021
 00:46:32 -0500
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (72.163.14.9) by
 xfe-rcd-001.cisco.com (173.37.227.249) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.792.3
 via Frontend Transport; Fri, 7 May 2021 00:46:32 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=E/MtCZbRNw0Y7Rz3jrY9MM5H78QcPevUDcLdQAgctrL4ckHITo/wtWp68lIYNQMs2INv+RvVN0t2Wh+INPF8yNxpkzf1WlePcc3Mm09U8Kylqpv7z2OfphiXRklTRLSYe10sk2t8oAgxhyR5u5lNKl/5kUT582bODZuor3Sxk2Dt3DHXk5MFEIqCTlRpJmmVPiYqR2oOqoDa5ypEFkj4tgkcLTxtUXUReswSS0yfc0/TD58hsWF0k8RKiNXbK7u5sKqiWUwbMfi8oye3sEWA3YCMK6rrwIVsAv8CsxzOVu2OU0dO0MdeIwZ7hEBS68ZrQUpdJc9IAEdIJSii6byLWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=74DZnjgWyck/cTIOOtm0//nwD3bqQTgatibqLNXlpk8=;
 b=OeZfRWTtBGsC2IKCiytlZhRjdggf+DE6/IyKSxTEYzIV0tDGDqTsdGWpoY7oCKqikDGcuWMmPEnY5xitC/r8Hj2roILtNovc7F7GZv6eZ7FZSgplEwQoce6tnR8s9QGSe6EFHFET+30lUpt5RX8fMhnRLeNoh1pOoPCbfN4V0XLfZyBCKsUeTF5TxtDbq2PbcC8wNIfZ22zD/E1M+0ctxi+Yy/U3wyg90cRliTvVIaj0sJS9o5PHHMRMEUj6+4rc+zG2KMn6V3y48jU5m7U8QSymPYf46BLSYeNrIk722BkMKHqgg1Z3bSUkkd+RDlScPjV7RAYhSFLvfoLTkxm9aQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cisco.com; dmarc=pass action=none header.from=cisco.com;
 dkim=pass header.d=cisco.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cisco.onmicrosoft.com;
 s=selector2-cisco-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=74DZnjgWyck/cTIOOtm0//nwD3bqQTgatibqLNXlpk8=;
 b=b65UJjpsR87Y+nxFgv0w7Q4qOKwXiPcOX/xxLxm8r4P4ky2iLZfR+EjhxnC8HT8p1OH1BMWVdxV6dRvpFsD1idwk3Re8WuFyf3D6bJACKWVXdzHZFhuT9lMraFcG6nVilbYQlIlm23ekW+wlX0Lc6cKuKFWbuDVldjqX4B9asQM=
Received: from DM6PR11MB4025.namprd11.prod.outlook.com (2603:10b6:5:197::31)
 by DM6PR11MB4026.namprd11.prod.outlook.com (2603:10b6:5:198::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.29; Fri, 7 May
 2021 05:46:29 +0000
Received: from DM6PR11MB4025.namprd11.prod.outlook.com
 ([fe80::1010:a537:8253:4025]) by DM6PR11MB4025.namprd11.prod.outlook.com
 ([fe80::1010:a537:8253:4025%6]) with mapi id 15.20.4108.027; Fri, 7 May 2021
 05:46:29 +0000
From:   "Denys Zagorui -X (dzagorui - GLOBALLOGIC INC at Cisco)" 
        <dzagorui@cisco.com>
To:     Jiri Olsa <jolsa@redhat.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "acme@kernel.org" <acme@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "alexander.shishkin@linux.intel.com" 
        <alexander.shishkin@linux.intel.com>,
        "namhyung@kernel.org" <namhyung@kernel.org>
Subject: Re: [PATCH v4 1/3] perf report: compile tips.txt in perf binary
Thread-Topic: [PATCH v4 1/3] perf report: compile tips.txt in perf binary
Thread-Index: AQHXQn9lG6UDAOt1jUGn1lCHhYHsvarXf1Og
Date:   Fri, 7 May 2021 05:46:29 +0000
Message-ID: <DM6PR11MB4025626D34B0521A01EBAB03D9579@DM6PR11MB4025.namprd11.prod.outlook.com>
References: <20210430133350.20504-1-dzagorui@cisco.com>,<YJP1HfjAd6hEirmg@krava>
In-Reply-To: <YJP1HfjAd6hEirmg@krava>
Accept-Language: en-GB, en-US
Content-Language: en-GB
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=cisco.com;
x-originating-ip: [173.38.209.9]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 78b8a487-7004-4a75-e46c-08d9111b7611
x-ms-traffictypediagnostic: DM6PR11MB4026:
x-microsoft-antispam-prvs: <DM6PR11MB40268F5A6E0BF628BE14EA41D9579@DM6PR11MB4026.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 4xYs3eNqZ5WaJcKI063tillsbE7wAH/5SboIqs11UmRvQyKWTz77DVTGVgSP0zTyOWSncsUJuAb/o+4voQTTZg+xKlc9oGoQ719q/9FSZ2TW7EXqK4hawbtbcxIo+1GSE434GRt9b80BDlaGI9YkbY0Eb3Z43M8SZYNGv/85nIwdmrH+C/LPYYr4k7WgPnz07kacDFlQFEQ2Wkad/oLZr1F7SvnGMooo/XYNN+LzyVi53cL2mpD4FNL68VbL29dvgaIOsZSDso5/GZHJ+s1xe8wjW/S/NcGI2TORmTWLd5pUpBDqu3O6+dIeVF3sTvt8Fc7FVtSC5cg8AWXPol9o8FfgY5Ky+dkVK/Vl6AOYpoiZuWjm7KokwPg53QLyeTbynYv0SwEMxbjiZNvyyVgjXs7rxsV+lxn38LHyZv25iLa5XgOr+0sJw5LIMWB03/cP2jAzbvwqzeESuVfu6opPQOOXYn8shEPeXHnkGt3dziSqk2p+bHVDm/x5e99DLnmryq4hPsoq18OT7A5U1BOZYq8Q6UGLNB5FQRy5aKnUgl4Ke52WVYAGWTTkSJ/Ga0pfEGKPCt18RTjOjmhZ0FTsIOXRkeeKqxjwTpj6fG9ALcY=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB4025.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(39860400002)(396003)(366004)(136003)(346002)(376002)(2906002)(86362001)(8676002)(71200400001)(8936002)(6916009)(186003)(316002)(7696005)(478600001)(83380400001)(52536014)(55016002)(122000001)(66946007)(64756008)(66476007)(54906003)(66574015)(66556008)(38100700002)(66446008)(4326008)(91956017)(9686003)(76116006)(6506007)(33656002)(53546011)(5660300002)(26005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?OGxl+vg6Xa5luNK2rr2HfAkqymfmBsfbRoFBDc1n8geptzNBMPGc/AA37E26?=
 =?us-ascii?Q?cvw9LHUVtCKqAm30DN4sRcg7157LdQf8A/LYWfm+Q1KZl6Tj72BjsGmFT7dY?=
 =?us-ascii?Q?OgnPLbLN0lCgCf/F0BCf25NiqZRrF9SVVsZ7gGRxDmMu9etA7jA5+OztEyrd?=
 =?us-ascii?Q?Tmy48wy36XlaREGuzY4Z+MAyQJ5xxqs+ECR/94xHetAZcz1wy8KCSVOD1r2W?=
 =?us-ascii?Q?Q4LXp+3C3eK7jUWe/RKGBRhHXRPXNdsJoGPFZwYBLOe06qP7cMr04b/sfYZS?=
 =?us-ascii?Q?10indBglyCcsjeoa216i7rdrzo3bhrsR1bLBq1hHqIgDvMYi9VkHSrlJiPxs?=
 =?us-ascii?Q?VBZCjwYdyxtUs6r0i3pYMZfJLWJtYAd4Y2/t2N5e62kRs06AthfQKgho6s9K?=
 =?us-ascii?Q?TYFS4bg1SfmkaAn0NG9rDYu6yOwNqzLTIHB6aS5RkAKvM6pAhGnr7QCYpItO?=
 =?us-ascii?Q?IUTHRDSa81An1U5OBhn+eB37NUp8YUElGaG7QYJwTweFUKXHmOondeZT10TI?=
 =?us-ascii?Q?+mxwyhuEREYsr4sPjSwyE00+Aq2zT5FKQ1VkAeU8mBMAqypPj3ZVxYwYNY+/?=
 =?us-ascii?Q?ISpxZLGQm3y1IKD5811bKvJ0NPAtyU/EpsF3fkYrQzFlPHTl7ykaPIrlufWJ?=
 =?us-ascii?Q?L7JI4OSfRhr4QiTRdQvX6sOfHM63wUamkCKgq0CasGgdmzddVnSnMUVJG3PU?=
 =?us-ascii?Q?JZPt6Bkssd6WzPJIjD79ZVzsLMh8V2s1H9iRCFOb/sRW3MZLZlxjoi9nDcfN?=
 =?us-ascii?Q?96/i8dX4fe51VzdFQlxyrWSwFpZVrW4nOHVaGtb3wyU5X9nYhX6jkuCU/x3R?=
 =?us-ascii?Q?Vy+9yqDlvDu5SCjbjPVJS3T9GMNxny5glGfhe7m3Sejvpfrb4Wpzt2wNLMca?=
 =?us-ascii?Q?BvG0BbSbJn7/7z/8iK5avfHGHNfADaYdzozI8mqMeBgi9EyJ4R6IpESs8jRN?=
 =?us-ascii?Q?8LyVGWwVqeBVuTVZI7HHpeWQ1PtpbNMJ0sWf4teZdkLjF7jdVbIl8X20azTd?=
 =?us-ascii?Q?3zv/GMxvFiFutXfm/+fIkuH8TkkPuX6iFtCciGcRdxLZnmYyDqd7ZuyIKrri?=
 =?us-ascii?Q?3+Im1C+LgLbFzo4/YaMJSeeXT2qo2mmgp9XkePB5e63kEwGiYCjcpKvWJ7qv?=
 =?us-ascii?Q?pLlaybE0u66q6Uwb0poR0IdtmuBFTgmn6pZFnrAhIGKCZMFjNhAa/Iga2/O2?=
 =?us-ascii?Q?u06xXN/8kvUysCDgKjXXfRzxujwssyFKigFw4GSK9cT1fImRmIKX3ddekRPc?=
 =?us-ascii?Q?qxrUJX6Nw5jTwSFvryyIpeU4UuW0yFB8Ju5MW3DhLRdnAEILtxN/lE7CV5jZ?=
 =?us-ascii?Q?sD4=3D?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB4025.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 78b8a487-7004-4a75-e46c-08d9111b7611
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 May 2021 05:46:29.0720
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5ae1af62-9505-4097-a69a-c1553ef7840e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: w6G5n2I9MwNDJKrAjKmRgIkPvIKowz2S6NFCpMO0uJRxdTW8bE8PjUePhNAXF+iyG0yoMhoSBpQ9nFNe4L6Hnw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB4026
X-OriginatorOrg: cisco.com
X-Outbound-SMTP-Client: 173.36.7.19, xbe-aln-004.cisco.com
X-Outbound-Node: alln-core-11.cisco.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> I dont mind to keep static count of tips, but would be great
> to have some check when there are more tips in the tips.txt
>
> or perhaps pick tip with random index within the tips data size?
> you would just do strtok until you reach the string that has the
> random index inside.. you wouldn't need str pointers then

There is no static counter of tips. MAX_TIPS is just maximum number
of tips. Number of tips in tips.txt file:

tools/perf$ wc -l Documentation/tips.txt
43 Documentation/tips.txt

By invoking strtok(..."\n") in a while loop we count how many tips do we ha=
ve
and also save a pointer to corresponding tip in str[]
After we randomly pick up one of those tips (how it works previously).

________________________________________
From: Jiri Olsa <jolsa@redhat.com>
Sent: 06 May 2021 16:54
To: Denys Zagorui -X (dzagorui - GLOBALLOGIC INC at Cisco)
Cc: linux-kernel@vger.kernel.org; peterz@infradead.org; mingo@redhat.com; a=
cme@kernel.org; mark.rutland@arm.com; alexander.shishkin@linux.intel.com; n=
amhyung@kernel.org
Subject: Re: [PATCH v4 1/3] perf report: compile tips.txt in perf binary

On Fri, Apr 30, 2021 at 06:33:48AM -0700, Denys Zagorui wrote:
> It seems there is some need to have an ability to invoke perf from
> build directory without installation
> (84cfac7f05e1: perf tools: Set and pass DOCDIR to builtin-report.c)
> DOCDIR definition contains an absolute path to kernel source directory.
> It is build machine related info and it makes perf binary unreproducible.
>
> This can be avoided by compiling tips.txt in perf directly.
>
> Signed-off-by: Denys Zagorui <dzagorui@cisco.com>
> ---
>  tools/perf/Build               |  2 +-
>  tools/perf/Documentation/Build |  9 ++++++++
>  tools/perf/builtin-report.c    | 39 ++++++++++++++++++++++++++--------
>  tools/perf/util/util.c         | 28 ------------------------
>  tools/perf/util/util.h         |  2 --
>  5 files changed, 40 insertions(+), 40 deletions(-)
>  create mode 100644 tools/perf/Documentation/Build
>
> diff --git a/tools/perf/Build b/tools/perf/Build
> index db61dbe2b543..3a2e768d7576 100644
> --- a/tools/perf/Build
> +++ b/tools/perf/Build
> @@ -45,12 +45,12 @@ CFLAGS_perf.o              +=3D -DPERF_HTML_PATH=3D"B=
UILD_STR($(htmldir_SQ))" \
>                             -DPREFIX=3D"BUILD_STR($(prefix_SQ))"
>  CFLAGS_builtin-trace.o          +=3D -DSTRACE_GROUPS_DIR=3D"BUILD_STR($(=
STRACE_GROUPS_DIR_SQ))"
>  CFLAGS_builtin-report.o         +=3D -DTIPDIR=3D"BUILD_STR($(tipdir_SQ))=
"
> -CFLAGS_builtin-report.o         +=3D -DDOCDIR=3D"BUILD_STR($(srcdir_SQ)/=
Documentation)"
>
>  perf-y +=3D util/
>  perf-y +=3D arch/
>  perf-y +=3D ui/
>  perf-y +=3D scripts/
>  perf-$(CONFIG_TRACE) +=3D trace/beauty/
> +perf-y +=3D Documentation/
>
>  gtk-y +=3D ui/gtk/
> diff --git a/tools/perf/Documentation/Build b/tools/perf/Documentation/Bu=
ild
> new file mode 100644
> index 000000000000..83e16764caa4
> --- /dev/null
> +++ b/tools/perf/Documentation/Build
> @@ -0,0 +1,9 @@
> +perf-y +=3D tips.o
> +
> +quiet_cmd_ld_tips =3D LD       $@
> +      cmd_ld_tips =3D $(LD) -r -b binary -o $@ $<
> +
> +$(OUTPUT)Documentation/tips.o: Documentation/tips.txt FORCE
> +     $(call rule_mkdir)
> +     $(call if_changed,ld_tips)

nice, I had no idea ld could do it like this ;-)

> +
> diff --git a/tools/perf/builtin-report.c b/tools/perf/builtin-report.c
> index 2a845d6cac09..88375ed76d53 100644
> --- a/tools/perf/builtin-report.c
> +++ b/tools/perf/builtin-report.c
> @@ -47,7 +47,6 @@
>  #include "util/time-utils.h"
>  #include "util/auxtrace.h"
>  #include "util/units.h"
> -#include "util/util.h" // perf_tip()
>  #include "ui/ui.h"
>  #include "ui/progress.h"
>  #include "util/block-info.h"
> @@ -107,6 +106,9 @@ struct report {
>       int                     nr_block_reports;
>  };
>
> +extern char _binary_Documentation_tips_txt_start[];
> +extern char _binary_Documentation_tips_txt_end[];
> +
>  static int report__config(const char *var, const char *value, void *cb)
>  {
>       struct report *rep =3D cb;
> @@ -604,19 +606,38 @@ static int report__gtk_browse_hists(struct report *=
rep, const char *help)
>       return hist_browser(rep->session->evlist, help, NULL, rep->min_perc=
ent);
>  }
>
> +#define MAX_TIPS        60
> +
> +static const char *perf_tip(void)
> +{
> +     char *str[MAX_TIPS];
> +     int i =3D 0;
> +
> +     _binary_Documentation_tips_txt_start[_binary_Documentation_tips_txt=
_end -
> +             _binary_Documentation_tips_txt_start - 1] =3D 0;
> +
> +     str[i] =3D strtok(_binary_Documentation_tips_txt_start, "\n");
> +     if (!str[i])
> +             return "Tips cannot be found!";
> +
> +     i++;
> +
> +     while (i < MAX_TIPS) {
> +             str[i] =3D strtok(NULL, "\n");
> +             if (!str[i])
> +                     break;
> +             i++;
> +     }

I dont mind to keep static count of tips, but would be great
to have some check when there are more tips in the tips.txt

or perhaps pick tip with random index within the tips data size?
you would just do strtok until you reach the string that has the
random index inside.. you wouldn't need str pointers then

jirka

