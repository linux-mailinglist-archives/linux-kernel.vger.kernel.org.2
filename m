Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9AAB737646A
	for <lists+linux-kernel@lfdr.de>; Fri,  7 May 2021 13:25:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231500AbhEGL0y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 May 2021 07:26:54 -0400
Received: from alln-iport-3.cisco.com ([173.37.142.90]:5526 "EHLO
        alln-iport-3.cisco.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229537AbhEGL0x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 May 2021 07:26:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=cisco.com; i=@cisco.com; l=5051; q=dns/txt; s=iport;
  t=1620386753; x=1621596353;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Hhn+Irzvs3ZzePzr0dDk5/Hd49LSPH7/dyztBRVUrGw=;
  b=Es5klRn0iV+ww7TBQXIOyA6lE/XCjgA86PKhUmC2HYJt0BH8uOdMwz3a
   RM6xMbbFzwuTPl4kVJZn+8K06/XpPFYDWNkZG90sKxtU4mpehl4BIIy0+
   CCEPBdNUHT1kvgYhznGdREza6hVmtpaZGYHTTO3lZfR/HJ9QsAC6Z+z/P
   M=;
X-IPAS-Result: =?us-ascii?q?A0ByAAAVI5Vg/49dJa1aHAEBAQEBAQcBARIBAQQEAQFAg?=
 =?us-ascii?q?UMHAQELAYFSUQd3WjYxC4gBA4RZYIh2gQyYS4EugSUDVAsBAQENAQEgEgIEA?=
 =?us-ascii?q?QGBFgGDOQKCAwIlNAkOAgQBAQEDAgMBAQEBAQUBAQECAQYEcROFUA2GRAEBA?=
 =?us-ascii?q?QMBOgYBATcBDwIBCA4DAgIBAQEeEDIdCAIEDgUIgmqCVQMOIQGdGwKKH3iBN?=
 =?us-ascii?q?IEBggYBAQYEBIUiGIITCYE6AYJ4imYnHIFJQoEVQ4IpNj6EQgKDS4IrgjkLB?=
 =?us-ascii?q?wGBDhOTUoMdpzkKI4JviX2TUBCFFqASuRgCBAIEBQIOAQEGgVQ6gVlwFYMkC?=
 =?us-ascii?q?UcXAg6OHwwWgzUZhnGDbHMCNgIGCgEBAwl8iwMBgQ8BAQ?=
IronPort-PHdr: A9a23:IK2BZx87AnhMof9uWD3oyV9kXcBvk6/5Mg4c9twsjLcdOqig/pG3O
 kvZ6L0tiVLSRozU5rpCjPaeqKHvX2EMoPPj+HAPeZBBTVkJ3MMRmQFzGsOJCUTnavXtan9yE
 MFLTlQw+Xa9PABcE9r/YFuHpHq04HYSFxzzOBAzKP7yH9vZjt+80Ka5/JiACzg=
IronPort-HdrOrdr: A9a23:3UhiN6+6LGYrjCn329xuk+ENdb1zdoMgy1knxilNoENuE/Bwxv
 rBoB1E73DJYW4qKQ4dcdDpAtjmfZquz+8K3WB3B8biYOCGghrnEGgG1+vfKlLbalbDH4JmpM
 Jdmu1FeaHN5DtB/IbHCWuDYqwdKbC8mcjC74qzvhQdLz2CKZsQkjuRYTzrdHGeMTM2fabRY6
 Dsn/avyQDQHUg/X4CePD0oTuLDr9rEmNbNehgdHSMq7wGIkHeB9KP6OwLw5GZcbxp/hZMZtU
 TVmQ3w4auu99uhzAXH6mPV55NK3PP819p4AtCWgMR9EESvtu/oXvUlZ1SxhkFznAid0idtrD
 AKmWZ4Ay1H0QKUQohym2q05+Cv6kd015ao8y7ovZKqm72IeNt9MbsauWqcGSGpt3bJe7pHof
 92NiuixulqJAKFkyLn69fSURZ20kKyvHo5iOYWy2dSSI0EddZq3MEiFW5uYdw99RjBmcoa+S
 hVfbfhDf1tAB+nhrDizyFSKfmXLzsO9zu9Mzw/U/2uonFrdSpCvj4lLeQk7wA9HbwGOut529
 g=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.82,280,1613433600"; 
   d="scan'208";a="695549275"
Received: from rcdn-core-7.cisco.com ([173.37.93.143])
  by alln-iport-3.cisco.com with ESMTP/TLS/DHE-RSA-SEED-SHA; 07 May 2021 11:25:53 +0000
Received: from mail.cisco.com (xbe-rcd-003.cisco.com [173.37.102.18])
        by rcdn-core-7.cisco.com (8.15.2/8.15.2) with ESMTPS id 147BPrTa004240
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=OK);
        Fri, 7 May 2021 11:25:53 GMT
Received: from xfe-aln-002.cisco.com (173.37.135.122) by xbe-rcd-003.cisco.com
 (173.37.102.18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.792.3; Fri, 7 May 2021
 06:25:52 -0500
Received: from xfe-rcd-002.cisco.com (173.37.227.250) by xfe-aln-002.cisco.com
 (173.37.135.122) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.792.3; Fri, 7 May 2021
 06:25:52 -0500
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (72.163.14.9) by
 xfe-rcd-002.cisco.com (173.37.227.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.792.3
 via Frontend Transport; Fri, 7 May 2021 06:25:52 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MBMvjuluMtMHNuYELvRwpEMSPW/VpPYsLN03v80/yRAFQ+QY7Ei4IvdVUviWgetwG8h8Y5KDQB5UN6iq3MNWT5GmtYP4lYL+F+0UDk5Cabf0Yup7kShKeNKaz83iDRbatnkoLp9bFm41XkBAJc9U4RPh1cTACEJ6FyzHIAp+vzLeRbIuzl+63hD2V/9Ss3YhB4o9uKjYCYVbPWRroDHL91hdPPIwrfAjnwHwqs66IrtcpzeG0tj1AxOuAAE0CjATshuDMiJtfxwe7Lz0VoHTtyKzkPrqQRLbLpzDxVGnOG5APzQjVS2PuNXeI5H/x57IlguwP9BSS1nNSvIB3s3V+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qwirxJQV5chnuoWTUncOLI6IKRRc6BFCESAr1VG2yMI=;
 b=VqnWA0wsRdCA5T3Z4a60rLeRiTIPVlG4oJurWsiNHZ44mpPfcdczsJ+LsVGVjgl8Os9mcnzP2Sir+xMG/MNQONYtMRC5ib9Upx3BSWQ0FvGw+ZBR3Z1JPPD6TjfFpTCTT7531T2WyaoS5yFLm+joAomNT1wPDbT4Snk1JBxJdCFc77ajLA44H3/0wYsjCcxfa7eSWXoSdysFYk8qg9jgqgfIAPMEbmj5C17vLI9PKE8fD/PzF9+UpX0GXY+odWsnP7adjNmN+RQgPaHBZxO2NrOev2Fyvbt/s9Rc/Li0aag/2NxWPV2HVfq5xtuvCv7QafErugve06KWJqbTlGLDYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cisco.com; dmarc=pass action=none header.from=cisco.com;
 dkim=pass header.d=cisco.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cisco.onmicrosoft.com;
 s=selector2-cisco-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qwirxJQV5chnuoWTUncOLI6IKRRc6BFCESAr1VG2yMI=;
 b=RnJLZ5tgRcy07XyocrH1p4HBJeP/a9qkBq6lLC4BUTUf9chQJ3mnXAXPqv6GK0P1kg/ddBBNAdetndeVKRv6HNy4UgEtvWEWsZ6FXC4CoDpc8IbrZHPh0gbDhfIqLk6nA0ejUoNVUnrmZ2sy9Fb/Er0QchZmV16/kQleN7a/po4=
Received: from BY5PR11MB4024.namprd11.prod.outlook.com (2603:10b6:a03:192::24)
 by BY5PR11MB4069.namprd11.prod.outlook.com (2603:10b6:a03:191::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.29; Fri, 7 May
 2021 11:25:51 +0000
Received: from BY5PR11MB4024.namprd11.prod.outlook.com
 ([fe80::9553:3e54:a296:63de]) by BY5PR11MB4024.namprd11.prod.outlook.com
 ([fe80::9553:3e54:a296:63de%6]) with mapi id 15.20.4108.029; Fri, 7 May 2021
 11:25:51 +0000
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
Subject: Re: [PATCH v4 2/3] perf tests: avoid storing an absolute path in perf
 binary
Thread-Topic: [PATCH v4 2/3] perf tests: avoid storing an absolute path in
 perf binary
Thread-Index: AQHXQoXAMcfZOmyFyUqfrBbHL7WC86rX4Udi
Date:   Fri, 7 May 2021 11:25:51 +0000
Message-ID: <BY5PR11MB4024A423BC46263285CC19B4D9579@BY5PR11MB4024.namprd11.prod.outlook.com>
References: <20210430133350.20504-1-dzagorui@cisco.com>
 <20210430133350.20504-2-dzagorui@cisco.com>,<YJP/wDx/cIKLkpLk@krava>
In-Reply-To: <YJP/wDx/cIKLkpLk@krava>
Accept-Language: en-GB, en-US
Content-Language: en-GB
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=cisco.com;
x-originating-ip: [173.38.209.11]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e6cdd3dc-f3ea-41c2-2908-08d9114adecd
x-ms-traffictypediagnostic: BY5PR11MB4069:
x-microsoft-antispam-prvs: <BY5PR11MB4069C690BE316FD6C182143AD9579@BY5PR11MB4069.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:800;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: /8nK1B/4yS9Pgl8Bpx2pv3w73SwajG4e7tURTBBeHNJ0hyPVDtvrfTFmNxKnA3j8pqosT7Eidzl45a/jxOVV5OLl0yCthEr5QPdsi9M2IjtRczn/4oKDiDRyLAX1jotLxmmvcTrnQZqyP/W5Ejlfn0YyWNuZGutnhMLdnFyvUQ7Qy8idsscD/1nx0kWIPZ/u77Pyla/aIRx0cX+ZCFaXVOdZ+GMlkJoi/whGuJbI9peas2vPZNSDB0CE+VTmayrKv6Ys5nrc2PSeK9/oa8eEn2SyhBCbMcn13Ix7dLeHYw0BVkdRI+EDsKuVXrQwvLeRGBb3y39DGfFDgC6ov+P4W7h/O/JdWsTX5Cd68HvDUg2OsEUTjSW+g3QSpsNehs8ogXI9BpfpXV+ir1prT/EJflrCE+GOoTFUFoBBRDl5jy5tp0RTnc3xCx5bzHHOm6VGwCaUIQE0AXxwvy6ihYSXkMFhUTlH6p8FCvDip01QSJwbaBooRgKXgBOsg8MfQXniICTQAYc2sjdNjPxPMlAFKiydM7v9Ha+EGQrXSZPz5mnNityneKRYMXEmH8esrnjQrNavKgTMOMY9firYQTTn2gjxaTxSz2kbs7epyKnRqQ0=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR11MB4024.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(396003)(39860400002)(136003)(346002)(376002)(478600001)(54906003)(8676002)(6916009)(186003)(4326008)(8936002)(5660300002)(66556008)(66476007)(64756008)(66446008)(66946007)(316002)(9686003)(55016002)(2906002)(38100700002)(33656002)(91956017)(76116006)(52536014)(7696005)(83380400001)(6506007)(53546011)(26005)(86362001)(71200400001)(122000001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?qBBs98vBUaQi3aq7Qs1uM0YSflZx9kgfzqWUTWjpdfjTv8/kduxdsXnJvgvJ?=
 =?us-ascii?Q?QAQtDbaP7jmMZLK5iz2maKLNBKNT+mnslTswxEKx6d36ypbEe4G4jvJBqdgI?=
 =?us-ascii?Q?S4y6yTncUaoQTqVcnNhQlX0hIqH4oFF+7AVT4m/01gnfrkIBhQ7wr6ibYGQ/?=
 =?us-ascii?Q?TvVW5eu5yl6pJR85pNLawK3M+sG+7jOkXlXdHkfov5j2hgxlqeYh9xWQdRyb?=
 =?us-ascii?Q?MchrFcEK8MPdLR6L9Biiq59rLzHKY2dPwgrNe27/OaoTLQ7teNVtKwEZ39oZ?=
 =?us-ascii?Q?L2qChLdnCnZ+29AZ0nwJZJP8kmUWo7Q5b4J/myjdbynXlWF9Wsx7dUJWJvhK?=
 =?us-ascii?Q?rD9xkvQYnVrot1reT0DpMpQ5tMFkCKZFRlQo4sBpiSZVZP2lpfF5Ei8C7Roy?=
 =?us-ascii?Q?CR4duRCvEGPIOrj9hvt/NW2x4xdIh5CFDSoIZTloqB5vdDc5CA8fxBjnXFyd?=
 =?us-ascii?Q?24+KTjVDgUcYL2EGeMqhgd6r1lCQZYhc+MIPTo7rWJgbCzsNjp37hQ0Nr8po?=
 =?us-ascii?Q?mafZ0cMqurWACK6qbmuR0yyYBhN66nZaU4bxADD23H/+wCbVoex/3vxMr0mH?=
 =?us-ascii?Q?lUWB1Y7/aZNGgfMSusLz0qye5HHz+3rXttbrtWwC7i79czNoCRWSnoS6a4+8?=
 =?us-ascii?Q?Fj12sNfHZsvafNQK0NVQHzrIrhiVlipWCLuAkYcDB9g7UY7eeb0t2UxhGaZb?=
 =?us-ascii?Q?N66LnyhMEEs/idVi9q2dKuUKAZzsZvGRk2ZLl3qmKCagOJXEn+AYfpnBQltr?=
 =?us-ascii?Q?5+C0otvFnaWvNsXmopSlO36P7Vpst7BGFmzXel1CSHv3v6/PG6zyxX+zNLY+?=
 =?us-ascii?Q?YXbjJiUt2ioq3v9iJeCLyganH2zziu4DtV+DxiuOW1X4+tyjAcYfRJQsy2ct?=
 =?us-ascii?Q?UW8DfLSLqNboKuZqYQ/SD5VsHCavVAZ4INrGFii4Zcp9AR8gfx59vuWqZrmF?=
 =?us-ascii?Q?2kzQZMAd+0F3+IwJj8pE28XzxSCrDMwt6lMM2FktlKR5hG+GzqcfBuC2xa9F?=
 =?us-ascii?Q?X87yS8DpomUWZdLq9p79wTleYZaX4WtVGczfTuEB5hb53SbLGogHZPmP4y88?=
 =?us-ascii?Q?XzdJYp7uSfnPvG5GyzPJntTN+Fu1kRyx/cXsOheJtCDD2w5OJXRqirRWyuU4?=
 =?us-ascii?Q?pVyb0y3+b9AB/HR89UXSUYxvkJSfz1Sa4mFT9gAo0vEnOxq07ZwqgwIZtkUW?=
 =?us-ascii?Q?j84o3mKtgMvt3+mF0DH3OlLOJuQDtKV6WjB8fBbpjWdKggNw3qbdI1y1mY3K?=
 =?us-ascii?Q?wiTKSUjTbv1c/BJPWRToGViqv25Iod0xjFur4G+jkNGykAt2Q4wmmI25vWLH?=
 =?us-ascii?Q?Z4g=3D?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR11MB4024.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e6cdd3dc-f3ea-41c2-2908-08d9114adecd
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 May 2021 11:25:51.1136
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5ae1af62-9505-4097-a69a-c1553ef7840e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gG1s+U+B9gBITKFCkPbIwQdjZ0NHHTdrG0Mq4Px6NkNY9LkKxFgnRjCiHvOxxH13DDLB1mzNg5JD4tlWAQnZmA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR11MB4069
X-OriginatorOrg: cisco.com
X-Outbound-SMTP-Client: 173.37.102.18, xbe-rcd-003.cisco.com
X-Outbound-Node: rcdn-core-7.cisco.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>>  int test__python_use(struct test *test __maybe_unused, int subtest __ma=
ybe_unused)
>>  {
>>        char *cmd;
>>        int ret;
>> +     char *exec_path;
>> +     char *pythonpath;
>> +     struct stat sb;
>> +
>> +     exec_path =3D perf_exe_path();
>> +     if (exec_path =3D=3D NULL)
>> +             return -1;
>
> should we return TEST_SKIP in here?

I'm not sure how it differs from a case where asprintf returns -1

>> +     buf =3D perf_exe(buf, PATH_MAX);
>> +
>> +     for (i =3D strlen(buf) - 1; i !=3D 0 && buf[i] !=3D '/'; i--)
>> +             ;
>
> could we call dirname for this?

Yes

Thanks,
Denys

________________________________________
From: Jiri Olsa <jolsa@redhat.com>
Sent: 06 May 2021 17:40
To: Denys Zagorui -X (dzagorui - GLOBALLOGIC INC at Cisco)
Cc: linux-kernel@vger.kernel.org; peterz@infradead.org; mingo@redhat.com; a=
cme@kernel.org; mark.rutland@arm.com; alexander.shishkin@linux.intel.com; n=
amhyung@kernel.org
Subject: Re: [PATCH v4 2/3] perf tests: avoid storing an absolute path in p=
erf binary

On Fri, Apr 30, 2021 at 06:33:49AM -0700, Denys Zagorui wrote:
> python binding test uses PYTHONPATH definition to find python/perf.so
> library. This definition is an absolute path that makes perf binary
> unreproducible. This path can be found during runtime execution.
>
> Signed-off-by: Denys Zagorui <dzagorui@cisco.com>
> ---
>  tools/perf/tests/Build        |  2 +-
>  tools/perf/tests/python-use.c | 19 ++++++++++++++++++-
>  tools/perf/util/util.c        | 21 +++++++++++++++++++++
>  tools/perf/util/util.h        |  2 ++
>  4 files changed, 42 insertions(+), 2 deletions(-)
>
> diff --git a/tools/perf/tests/Build b/tools/perf/tests/Build
> index 650aec19d490..a20098dcdbc4 100644
> --- a/tools/perf/tests/Build
> +++ b/tools/perf/tests/Build
> @@ -98,5 +98,5 @@ perf-$(CONFIG_DWARF_UNWIND) +=3D dwarf-unwind.o
>  endif
>
>  CFLAGS_attr.o         +=3D -DBINDIR=3D"BUILD_STR($(bindir_SQ))" -DPYTHON=
=3D"BUILD_STR($(PYTHON_WORD))"
> -CFLAGS_python-use.o   +=3D -DPYTHONPATH=3D"BUILD_STR($(OUTPUT)python)" -=
DPYTHON=3D"BUILD_STR($(PYTHON_WORD))"
> +CFLAGS_python-use.o   +=3D -DPYTHON=3D"BUILD_STR($(PYTHON_WORD))"
>  CFLAGS_dwarf-unwind.o +=3D -fno-optimize-sibling-calls
> diff --git a/tools/perf/tests/python-use.c b/tools/perf/tests/python-use.=
c
> index 98c6d474aa6f..c7a0c9b5366f 100644
> --- a/tools/perf/tests/python-use.c
> +++ b/tools/perf/tests/python-use.c
> @@ -8,18 +8,35 @@
>  #include <linux/compiler.h>
>  #include "tests.h"
>  #include "util/debug.h"
> +#include "util/util.h"
> +#include <sys/stat.h>
>
>  int test__python_use(struct test *test __maybe_unused, int subtest __may=
be_unused)
>  {
>       char *cmd;
>       int ret;
> +     char *exec_path;
> +     char *pythonpath;
> +     struct stat sb;
> +
> +     exec_path =3D perf_exe_path();
> +     if (exec_path =3D=3D NULL)
> +             return -1;

should we return TEST_SKIP in here?

> +
> +     if (asprintf(&pythonpath, "%spython", exec_path) < 0)
> +             return -1;

leaking exec_path

> +
> +     if (stat(pythonpath, &sb) || !S_ISDIR(sb.st_mode))
> +             pythonpath[0] =3D 0;
>
>       if (asprintf(&cmd, "echo \"import sys ; sys.path.append('%s'); impo=
rt perf\" | %s %s",
> -                  PYTHONPATH, PYTHON, verbose > 0 ? "" : "2> /dev/null")=
 < 0)
> +                  pythonpath, PYTHON, verbose > 0 ? "" : "2> /dev/null")=
 < 0)
>               return -1;

leaking exec_path and pythonpath

>
>       pr_debug("python usage test: \"%s\"\n", cmd);
>       ret =3D system(cmd) ? -1 : 0;
>       free(cmd);
> +     free(exec_path);
> +     free(pythonpath);
>       return ret;
>  }
> diff --git a/tools/perf/util/util.c b/tools/perf/util/util.c
> index 3bba74e431ed..54e80452887c 100644
> --- a/tools/perf/util/util.c
> +++ b/tools/perf/util/util.c
> @@ -388,3 +388,24 @@ char *perf_exe(char *buf, int len)
>       }
>       return strcpy(buf, "perf");
>  }
> +
> +char *perf_exe_path(void)
> +{
> +     int i;
> +     char *buf;
> +
> +     buf =3D malloc(PATH_MAX);

need to check buf !=3D NULL

> +     buf =3D perf_exe(buf, PATH_MAX);
> +
> +     for (i =3D strlen(buf) - 1; i !=3D 0 && buf[i] !=3D '/'; i--)
> +             ;

could we call dirname for this?

thanks,
jirka

> +
> +     if (!i) {
> +             free(buf);
> +             return NULL;
> +     }
> +
> +     buf[i + 1] =3D 0;
> +
> +     return buf;
> +}
> diff --git a/tools/perf/util/util.h b/tools/perf/util/util.h
> index 80b194ee6c7d..4e871e890ef8 100644
> --- a/tools/perf/util/util.h
> +++ b/tools/perf/util/util.h
> @@ -49,6 +49,8 @@ void perf_set_singlethreaded(void);
>  void perf_set_multithreaded(void);
>
>  char *perf_exe(char *buf, int len);
> +/* perf_exe_path return malloc'd string on success, caller must free it =
*/
> +char *perf_exe_path(void);
>
>  #ifndef O_CLOEXEC
>  #ifdef __sparc__
> --
> 2.26.2.Cisco
>

