Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E1FC377C9D
	for <lists+linux-kernel@lfdr.de>; Mon, 10 May 2021 08:56:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230023AbhEJG5M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 May 2021 02:57:12 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:52982 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229608AbhEJG5L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 May 2021 02:57:11 -0400
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 14A6mA7I026794;
        Sun, 9 May 2021 23:56:05 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=Fj9UlAT+p7IjxZV1I+M3RzHB54HKPa4EsjSUAzZM6x8=;
 b=UXMMPkMmgpcojJ72k+gToyYm7HK542M2BMHMicsp9u1G3TG6gFe+M05pO+wrF1QxVzrG
 JwEr5XG4K3LdI/vDiwqIfibTBcbPS+igLZs1EWFN4/8EoQ5FQ6JV3u1JTHw3yrpHB8xi
 0YYyxd9ImYb332R5r+2nMxteuUaon73kcqo= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 38drfve7ve-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Sun, 09 May 2021 23:56:05 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.229) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Sun, 9 May 2021 23:56:04 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Vy1RStGtPtfBPo2aZGwqpbvqz1V7hiv7VGBE0VOKD+fDfNPpc/b3qbu29Oe5mtU+dJs1CWXoYlnyLDvdrepD+gkGzQJJ2DxOYC6wiiwHPT8/Bhj2aumuh1wsJQVelYBaA+gsiq1BUdtHTTD+8v6wCMSpBWx2HtPlqw/eN1zMSzFLe76uMbugopD3N4cNejxJkJEI7+PKhmuUKk1sp2qRH2ldMV8ZoNjLHmIg19duHi32cMswbScN7/NzYVcgobwPinGaUvW/mETXFFEBiB4b8kOtPBPJUDPDjoYytRlW1hEtrGUl7ozieq1S6VSy5nvisr8UJomVjVi3lQRDaed1Zg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Fj9UlAT+p7IjxZV1I+M3RzHB54HKPa4EsjSUAzZM6x8=;
 b=RxqwRINvrXwdyRSuGNZI8Q1EjJiFFauZ4M3BqFe3QqFaYPZLJEsDzbiJA/ddMnC8PvpvezD+NchjkM/kYQiwIdcjrL0wgPbXk/4N2yH/Wo2nyfPwGgdWSNSuII1ixwD9kMDINadGN88/LwdD4WrD8wFsRi2AwTl30IOJWckFFYliO6Tkr0boxUhoaWUoMGF+K4KyX5KZdWCmRpYJ/d15cX4QaYRmIIh6xUuORHv3evYZ+X86Rt5ZWUK1tMKP8mbnuPE7CPB1uGKlLyRZJo0NXDKeP2p2Hkwo+JCkYyoJsOXG2Y97YbmuEu6vTbROcMH4L4di0PJnR45AP3iQxRskoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from BYAPR15MB2999.namprd15.prod.outlook.com (2603:10b6:a03:fa::12)
 by BYAPR15MB4119.namprd15.prod.outlook.com (2603:10b6:a02:cd::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.26; Mon, 10 May
 2021 06:56:03 +0000
Received: from BYAPR15MB2999.namprd15.prod.outlook.com
 ([fe80::38d3:cc71:bca8:dd2a]) by BYAPR15MB2999.namprd15.prod.outlook.com
 ([fe80::38d3:cc71:bca8:dd2a%5]) with mapi id 15.20.4065.042; Mon, 10 May 2021
 06:56:03 +0000
From:   Song Liu <songliubraving@fb.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
CC:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>
Subject: Re: BUILD_BPF_SKEL error message
Thread-Topic: BUILD_BPF_SKEL error message
Thread-Index: AQHXRBIjMdBfTzC4xkSMGxXMawkr56rcSu8A
Date:   Mon, 10 May 2021 06:56:03 +0000
Message-ID: <88CE8174-6916-451D-81A0-B7F2BA1FAE7F@fb.com>
References: <YJaY2auB5advkzrg@kernel.org>
In-Reply-To: <YJaY2auB5advkzrg@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3654.80.0.2.43)
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=fb.com;
x-originating-ip: [2620:10d:c090:400::5:a660]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 41853047-0c47-4191-c0c5-08d91380ad3d
x-ms-traffictypediagnostic: BYAPR15MB4119:
x-microsoft-antispam-prvs: <BYAPR15MB4119EE9CBA4C51073E4A35A4B3549@BYAPR15MB4119.namprd15.prod.outlook.com>
x-fb-source: Internal
x-ms-oob-tlc-oobclassifiers: OLM:5797;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Ah7KXH6dOrD2GccnxIftcIgbewyZuSibLDBkaC6krssxFwnGhyidKgVQUTtRp5VDRkxd4JbPQBm4zz6c/Zo0Gfp8LjRSbrLvNTzRAsO/HoJ9DLkF7Qdut8qBvUO7ZPlyig/IGJVtn4t3+YnTk/R1J6Hgs7c5sm5gzRarkuVp+7QHWRiBpvvpn56K714mWUOfJGi1Ms2OcPONG5QbPQCsIp9PSd+YlG+qfdsZ/nUr9acKokTXEaUub+tBD6lurOoet1c4LbrUAEeJmwPK3D51JsMgkAWY6X7LZp3e2X8IkcenEXWBU6+dF/SFVUtQ7q1bdLpnPRb46CYHaXi+GCxWEr963AqpZU1yplrH6JvngebdtxetWflyWlFI2f63VZLZAeQ3CQC/ijk/+GoaAxI7+vRF8oLGk8RK0jlm7vcwmdQzFezzWNkIISbkiBcNBr9qjV0Wd1wRmY4SDj93rzXKJpj3bi6i43dKi6So54QDtiMkBionSOfvMxAKElBzAqelG0w32AAVH/eTzClyujT1RuR0oNGwEsN3X7RsMfGodPmJP8F8dp8PJ35fe4o+uQvTzmll6ySOHuQxEss8sAevKt1ceWpNAv/3CgcXT8ubw316aPtUEavGKS3I1IWl1Bz/ygxoh1C5kNXkr4M/rJAvHA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB2999.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(39860400002)(346002)(136003)(366004)(376002)(66946007)(36756003)(91956017)(66476007)(64756008)(8676002)(66446008)(66556008)(54906003)(6486002)(71200400001)(2616005)(76116006)(6512007)(33656002)(8936002)(5660300002)(53546011)(316002)(6506007)(4326008)(38100700002)(186003)(15650500001)(83380400001)(7116003)(478600001)(2906002)(6916009)(86362001)(122000001)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?5l5g2YBXXyIXmlu+/fqswy03k2iJ+oEDYNXob/JqIlAZtff+os9+1rUjac/Z?=
 =?us-ascii?Q?zPIRpSgvgDCYTPF294w1zsfq+OZMUVGgtqSFEJB75Dd1iyiwTwkH5ODZCI06?=
 =?us-ascii?Q?Q4SQ/m4WEtmj75YHO3bddaFM13zGno7tWtWB2QVeHCpFLbpHwZD0uzai+zjx?=
 =?us-ascii?Q?nk1D/v6D1y/fAT4aR4A/7622MZC+YUBD0bVNch2oqcu6tJkGrXLjfMF/awWP?=
 =?us-ascii?Q?LpyCKHR/iijGfwOCeg75skFIeV4g1+6lqGyMEuBD4GIrPjCw2V0fp/NReno7?=
 =?us-ascii?Q?hOAMNhbyhlvdvIcmuLeeIpRvAZh5x9SX89gsg36j41z1V82gIqxRQP66Xcd7?=
 =?us-ascii?Q?mHs0tCTcRaU4qmKd6i0X98s+H6VUXKju77OIMLQZoKygGbgovq83kUZnTUeE?=
 =?us-ascii?Q?+cTlHsgcDZXiv7hljf481MIknvmJTphmqJpulnqXorvngSsVidV72wojQ/MD?=
 =?us-ascii?Q?4UqDlMYBQ48P2JeXGQUPXQ8LJK7zfs0XENch+TYQALW1x9x1WYjdvRdQfRY8?=
 =?us-ascii?Q?VOButXVYzGVoyt0y1Jf1rzk2L8cvaAneU6A1qCoZiOp6275sXw3IF/Pf3pHg?=
 =?us-ascii?Q?JsbczeF80Fm6rQ+Q/fSkj2JvzTP0ENwYTGRqueE6vFs7i08Bgy8QezkYSQzc?=
 =?us-ascii?Q?pnXRDHtUR1p/qYd9K14jd9XszEm8/Bm1zV//godCXHFo9104ACNEbyvvwAyT?=
 =?us-ascii?Q?QCoJwYYfpv7h/4SMrFTvrPkd8ivpe9NYAx792XQ0NDfwYhenatSZiGMQKlUf?=
 =?us-ascii?Q?2UeRvdfNsAMOp6YhqYYuola1TZVk+IV0Nwm7Ji2rqshrhrjxmtn/SxpnbWFG?=
 =?us-ascii?Q?lNDEWgMKeDpQQmXaFe50zyALQMnDlO/RkoGgWaLHcu5UeHnYcouzzDkzAxc2?=
 =?us-ascii?Q?c6GXeUzCa6amEnwmWWRj+9gsFOezh/GDx+wTTqOJ3WiTZZVrcWfWIQcK44JN?=
 =?us-ascii?Q?ri8CVCPGn5Zkd7/4UnHKh3dD3HqNtD8wwPY1g+7Gn5kz7ZqncYjrO2EHh+C2?=
 =?us-ascii?Q?e1NERxjG4f+GcZEYhBegHf1IsT2+AIuZN/Hq2aCyZkRe/e2Lm8/dko2EKwzy?=
 =?us-ascii?Q?A8jfnITr0attQa0CyaN/UIq0mPAERbieX4bMgkUIL4blnjTNYqRmaOC6457P?=
 =?us-ascii?Q?xjDWaPFiuHUt13b6TJVxpLD9/ne2n9qXIfl5WJdjR7toGDt0wFTBIHiJjjcy?=
 =?us-ascii?Q?zHVWr3Vd6Mbvtljno9kiIcys+qduPvv+32UEQiHeJ2jO2xrJcr0Pr1vTae4G?=
 =?us-ascii?Q?Mf3TGFuU/xVLs0LhjB4UhFWKTngoeDRXtetOLliytTpKapqsQ76QvbmZ9SnR?=
 =?us-ascii?Q?T4Us2ip2LqPwYF6DfmLiL1qq2ls3ty1psnmylvT6fQlFioxPcNN7y8EeeP6a?=
 =?us-ascii?Q?kGHiQTQ=3D?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <638F95265E2BF24B82FFD701661B4799@namprd15.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR15MB2999.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 41853047-0c47-4191-c0c5-08d91380ad3d
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 May 2021 06:56:03.1713
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wloYhkGqp6SBBWLPeGErcUsmlYgN7VsfMcIRISPB5NE5QHSGKuji5sk2t7+ghDGIZjjj5FrddTQK9KlyRWPcgQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB4119
X-OriginatorOrg: fb.com
X-Proofpoint-GUID: 6GUV8HJu7NLM-KkSJM6KbgN_QI7hMakU
X-Proofpoint-ORIG-GUID: 6GUV8HJu7NLM-KkSJM6KbgN_QI7hMakU
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-05-10_02:2021-05-10,2021-05-10 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 lowpriorityscore=0
 priorityscore=1501 suspectscore=0 malwarescore=0 adultscore=0 phishscore=0
 mlxscore=0 impostorscore=0 bulkscore=0 spamscore=0 mlxlogscore=999
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2105100048
X-FB-Internal: deliver
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On May 8, 2021, at 6:57 AM, Arnaldo Carvalho de Melo <acme@kernel.org> wr=
ote:
>=20
>=20
> I switched to Fedora 34 Silverblue, and while installing the needed
> packages to build perf, using BUILD_BPF_SKEL=3D1 I noticed this:
>=20
> Makefile.config:637: *** Error: clang too old. Please install recent clan=
g.  Stop.
>=20
> The problem is not that clang is too old, its that it is not installed
> :-)
>=20
> Perhaps a slight improvement to state that, something like:
>=20
> Makefile.config:637: *** Error: clang too old/not installed. Please insta=
ll recent clang to build with BPF_SKEL.  Stop.
>=20
> As for a moment I thought clang now was _required_ to build perf, which
> isn't the case, it was just me using an alias to build perf:
>=20
> alias m=3D'make -k BUILD_BPF_SKEL=3D1 PYTHON=3Dpython3 O=3D/tmp/build/per=
f -C tools/perf install-bin && perf test python'
>=20

Yes, current message is confusing. How about we add the following?

Thanks,
Song


=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D 8< =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

From f44e1bb5a1ad343201e5d6ce2896073e74623d85 Mon Sep 17 00:00:00 2001
From: Song Liu <song@kernel.org>
Date: Sun, 9 May 2021 23:49:17 -0700
Subject: [PATCH] perf util: improve error message for old/missing clang

clang is required to build perf with BUILD_BPF_SKEL=3D1. Improve the
error message to highlight that:
  1) clang could be either missing or too old;
  2) clang is only required with BUILD_BPF_SKEL=3D1.

Suggested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Signed-off-by: Song Liu <song@kernel.org>
---
 tools/perf/Makefile.config | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/Makefile.config b/tools/perf/Makefile.config
index 0d6619064a838..3f58428244579 100644
--- a/tools/perf/Makefile.config
+++ b/tools/perf/Makefile.config
@@ -634,7 +634,7 @@ endif
 ifdef BUILD_BPF_SKEL
   $(call feature_check,clang-bpf-co-re)
   ifeq ($(feature-clang-bpf-co-re), 0)
-    dummy :=3D $(error Error: clang too old. Please install recent clang)
+    dummy :=3D $(error Error: clang too old/not installed. Please install =
recent clang to build with BUILD_BPF_SKEL)
   endif
   $(call detected,CONFIG_PERF_BPF_SKEL)
   CFLAGS +=3D -DHAVE_BPF_SKEL
--
2.30.2




