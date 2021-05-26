Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8EA99391AC0
	for <lists+linux-kernel@lfdr.de>; Wed, 26 May 2021 16:50:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235007AbhEZOwE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 May 2021 10:52:04 -0400
Received: from alln-iport-3.cisco.com ([173.37.142.90]:54415 "EHLO
        alln-iport-3.cisco.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235047AbhEZOwB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 May 2021 10:52:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=cisco.com; i=@cisco.com; l=2142; q=dns/txt; s=iport;
  t=1622040629; x=1623250229;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=CG79LcgGZKxKMHrfgrZz+SKYKr2LG/mXMbmhusHzy+o=;
  b=Qy9+/gd1v7KDFS2SgIR3z5VANN6agTHsLZjvCO7RQVqsYES06xi6k3Zj
   2peFQXiyztB2UtbO22z7lB2bLK7EsfAKFoHl92UVTO22XeEGyH90k/3uP
   fh9bsNVEHt7w459iQTE0b6sTvkjrxjJ/Ge3RM3vEK573Ai9WM9j3QuiLh
   I=;
X-IPAS-Result: =?us-ascii?q?A0B3CgACX65g/5tdJa1aHgEBCxIMQIFMC4FTUQd3WjcxC?=
 =?us-ascii?q?4gFA4U5jAiUPiiCBoEugSUDVAsBAQENAQE1CgIEAQGBGIM4AoF+AiU2Bw4CB?=
 =?us-ascii?q?AEBAQEDAgMBAQEBBQEBBQEBAQIBBgRxE4VoDYZFAgQSLgEBCi0BDwIBCBMzJ?=
 =?us-ascii?q?Q0lAgQODRqCTwGCVQMqBQEOmzIBgToCih94gTSBAYIHAQEGBASBCCwBhAcYg?=
 =?us-ascii?q?jEJgTqCe4MzgXGFSSccgUlEgRVDgl8+aYNbAoNLgi6CTHo+lmqKKZ0zCiOCd?=
 =?us-ascii?q?IoLk20RpVKGb5pigiQFhTeQKwIEAgQFAg4BAQaBWwwogVlwFYMkCUcXAg6OH?=
 =?us-ascii?q?4Nwil5zAgEBATMCBgoBAQMJfIdhAYEQAQE?=
IronPort-PHdr: A9a23:LCtTZhE7fgf0Td5TljbXuZ1Gfj4Y04WdBeZdwpkqkbRDduKk5Zuxd
 EDc5PA4iljPUM2b7v9fkOPZvujmXnBI+peOtn0OMfkuHx8IgMkbhUosVciCD0CoL/PwaSE+W
 sNYWwwt83SyK0MAHsH4ahXbqWGz6jhHHBL5OEJ1K+35F5SUgd6w0rW5+obYZENDgz/uCY4=
IronPort-HdrOrdr: A9a23:tgpcJ6rRU/ns8zWyXHAmL18aV5v+L9V00zEX/kB9WHVpm5Oj9v
 xGzc506farslkssSkb6K+90KnpewK6yXcH2/huAV7EZnimhILIFvAt0WKG+V3d8kLFh5VgPM
 tbAs1D4ZjLfCRHZKXBkUmF+rQbsaO6GcmT7I+0pRoAPGIaCZ2IrT0JdzpzeXcGIjWucKBJbK
 Z0kfA33gZIF05nCviTNz0gZazuttfLnJXpbVotHBg88jSDijuu9frTDwWY9g12aUIN/Z4StU
 z+1yDp7KSqtP+2jjXG0XXI0phQkNz9jvNeGc23jNQPIDmEsHfrWG0hYczGgNkGmpDp1L8Yqq
 iLn/7mBbUr15rlRBDwnfIq4Xi57N9h0Q649bbSuwqTnSWwfkNLNyMGv/MCTvMcgHBQ4O2VF8
 lwrj+kXtNsfGD9tTW46N7SWx5wkE2o5XIkjO4IlnRaFZATcblLsOUkjQ5o+bo7bWnHAbocYa
 NT5QDnlYBrmFihHjzkV6lUsZSRt1EIb1i7q2Q5y7ioOglt7TlEJhEjtbkid187heUAord/lp
 b5Dpg=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.82,331,1613433600"; 
   d="scan'208";a="706942369"
Received: from rcdn-core-4.cisco.com ([173.37.93.155])
  by alln-iport-3.cisco.com with ESMTP/TLS/DHE-RSA-SEED-SHA; 26 May 2021 14:50:26 +0000
Received: from mail.cisco.com (xbe-aln-003.cisco.com [173.36.7.18])
        by rcdn-core-4.cisco.com (8.15.2/8.15.2) with ESMTPS id 14QEoQXb027308
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=FAIL);
        Wed, 26 May 2021 14:50:26 GMT
Received: from xfe-aln-002.cisco.com (173.37.135.122) by xbe-aln-003.cisco.com
 (173.36.7.18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.792.15; Wed, 26 May
 2021 09:50:26 -0500
Received: from xfe-aln-005.cisco.com (173.37.135.125) by xfe-aln-002.cisco.com
 (173.37.135.122) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.792.15; Wed, 26 May
 2021 09:50:25 -0500
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (173.37.151.57)
 by xfe-aln-005.cisco.com (173.37.135.125) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.792.15
 via Frontend Transport; Wed, 26 May 2021 09:50:25 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fRmdQ+3BYTHyDUFl6CGp29b2OHJgsbZ3AZ9nHvQlJEcvPvtlDCJqLVfaBIgBD4U7RtvrGJhLl6IQRwMTdnoZV+2Z7krrP7A3FpPb6LjIHEAyHaVawtvnH6DwzC+NYtCgNdX+2Pv94Cs3UL90GQTS8EV0Q1pPHaHbBwvYIjzbYhlLgUPYpuWKrFUIwJ3LK8sh0FvU91Yr5xd7jjF0GuToNY5LIkjXCR181s0Yj/L8S1tAap8qfsdG0uaZa+zCIxd5osNZ316LdDmBw/pXwFnZurcmTWLDGtT6uKCnpqkVd38065HSAfIWBuXPFk69d7RYgrVUQ6ju5U8Hz/MjfSTBkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7EP2BTTnE1DiNIga3Hj86UjgcCR6Oyz+ND4nNkeGpsk=;
 b=N3GKz4ojT8DpMawHKVahQ0sMmcPOJYFFIzWJV9zp3RLe1OSj3aVmg/hJuqRZ/JkQ23ok1wEKx9Jr4q6ChkG3gXzmGc4mI26t+pZR7Jtl/uSHrX9lRbYvAriK0jIDeSeVis51zNvvtciFdMhqKsMvkeJYv378SWt8b8Qz7owkcZ7W3yFmsB56dgWTzmFDdbfP/VxrQYo+LTmq3V0zuRF1CZEyFrlGoonEjf1OKqWQUGVQCziiMjtq5wM/AbevxojzbFUUQOI8lf9uOTUCaV7O4oDoyolWrnfrWgNNov2PU8/yheBU9Xo8UsGGDHRadCoXdy4B5kAENHf9PKPg8e9wwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cisco.com; dmarc=pass action=none header.from=cisco.com;
 dkim=pass header.d=cisco.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cisco.onmicrosoft.com;
 s=selector2-cisco-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7EP2BTTnE1DiNIga3Hj86UjgcCR6Oyz+ND4nNkeGpsk=;
 b=hM5LhhQ7GUA0kxZe4km2vxDX+7C9EmvcFquaBQh1kMl4+u5yd7BxgrYS7ena4OhWjmmteS+zEG0wdTkQPpBSc+hEUH0MkzsG3ChOG9SfMjYMoS97CDlrKhAO1SX9izox1X1tupEczZCvvYBXGjBUGzspBIegNE9ZQT6NUX/QoaA=
Received: from BY5PR11MB4024.namprd11.prod.outlook.com (2603:10b6:a03:192::24)
 by SJ0PR11MB5199.namprd11.prod.outlook.com (2603:10b6:a03:2dd::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.21; Wed, 26 May
 2021 14:50:24 +0000
Received: from BY5PR11MB4024.namprd11.prod.outlook.com
 ([fe80::9553:3e54:a296:63de]) by BY5PR11MB4024.namprd11.prod.outlook.com
 ([fe80::9553:3e54:a296:63de%6]) with mapi id 15.20.4150.027; Wed, 26 May 2021
 14:50:24 +0000
From:   "Denys Zagorui -X (dzagorui - GLOBALLOGIC INC at Cisco)" 
        <dzagorui@cisco.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
CC:     "jolsa@redhat.com" <jolsa@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "alexander.shishkin@linux.intel.com" 
        <alexander.shishkin@linux.intel.com>,
        "namhyung@kernel.org" <namhyung@kernel.org>
Subject: Re: [PATCH v7 1/3] perf report: compile tips.txt in perf binary
Thread-Topic: [PATCH v7 1/3] perf report: compile tips.txt in perf binary
Thread-Index: AQHXUjiS0z/1HInS0kWXeDDO9E93jKr10GWP
Date:   Wed, 26 May 2021 14:50:24 +0000
Message-ID: <BY5PR11MB40248ABAFED285B92AE9F01CD9249@BY5PR11MB4024.namprd11.prod.outlook.com>
References: <20210522062016.84677-1-dzagorui@cisco.com>,<YK5WO3is6EW9TNrX@kernel.org>
In-Reply-To: <YK5WO3is6EW9TNrX@kernel.org>
Accept-Language: en-GB, en-US
Content-Language: en-GB
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=cisco.com;
x-originating-ip: [173.38.209.9]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8d79e786-98f6-46ab-ab45-08d92055980b
x-ms-traffictypediagnostic: SJ0PR11MB5199:
x-microsoft-antispam-prvs: <SJ0PR11MB519976E3BED49C44A7F884C8D9249@SJ0PR11MB5199.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:276;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: BM04Ck2uG55/UmAaU+bd2nzDjtTNR5kV0x/Bjrbz/Eko0r8Et7p/45HyXDhqd/zgALUUNodNj92UGV5tAhCmhCQSDK5j7aNbIbFENf71dnYr3YzcsD8+YjxoY4hFvfpRkF3OVSBcQ4EtrSCDPqUP0e13s2IjNdOK1f7dSmmGx5+KLwNP78A2JOhO2K4Y+jMOPEYxW1Qj1nh4q17SUz1/8jxUBukymGriN3lKRtzY18pDPDu+OdjevtPJd7CGggVPqROkRkEgrijoLlhmO9HGzgKvCVADm5wH703PcYfRwSYuOukz4nqvD9enaJndvinNAy3LK3oE1BWn54D3CKLaohpibqTD8VpUeBntv5wqTMjeHgryLeWt3Rt49Z8TOp+qkLuxrZTlYAc913PUIwVg7cbTKAKPB1KobBc/NIt4ilunYTViNqc3d10SZsDIn4MLq7ad8UQfqY02K3E3lSc1nRTmj6NpeQ9XPbKlU1xNVs1/+l4wk4dahxveLhHPEE2nGV0swkKzuvBT0RSrMcUIa+IwzCDzxOxCecnl0Fshd6AWpVzxepnXTzmNe7PhHq6sA1FuEW43XWCmaRVLpO6+54zWZV+aeO8PVK9bwbgci/313bwNXb7+qHDEwE34CntNmTkYat44GThjMNuvYjrueiYk0GAD5uCYwkQoxWyOu2li/KO8a/+kA5bt2Mp33WpbxVZqWHKmlDh7MwoBNTqw7YcbpHE8ply+rsMdDmV8boSz4U4WLsiy4MGHl0J58JQJYNO5Vt2QnuvyVAdbxlng0A==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR11MB4024.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(6019001)(136003)(396003)(39860400002)(366004)(376002)(346002)(269900001)(5660300002)(52536014)(86362001)(66946007)(66556008)(64756008)(66446008)(76116006)(91956017)(33656002)(66476007)(71200400001)(9686003)(83380400001)(2906002)(7696005)(26005)(6916009)(6506007)(4326008)(478600001)(8936002)(186003)(54906003)(38100700002)(316002)(122000001)(8676002)(55016002)(10721665004);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?iso-8859-1?Q?UnxBsv97Y+2pLvShYUTqdeFIcfUUFB9w23mxSEfX878L5D4LQ8RQIV7cIk?=
 =?iso-8859-1?Q?McHeAanmah8T0kxMu7866C+C/NeSaYSUq5FrICjn3X6OFQLv35eYb0rBVm?=
 =?iso-8859-1?Q?MpmeNMjloCK2eJQPoFmHf44PGcow39eGqJi5+Gr19Tt3KunVF7gjXQYpDN?=
 =?iso-8859-1?Q?jZv3yjOvNS2q9WR67WSR7Edxgboe0ftVDMy1C+XYUA5OJnN6Nj2GbL4AcC?=
 =?iso-8859-1?Q?jrulC33O0sBLMo51ku/JJzisrTS8v49EivChV1y6BIji98flmAf2/cCFru?=
 =?iso-8859-1?Q?fu/kWrrKjdeN/8FtGijGz2qY8MnhO71Cxdq4CpUU9GE/VQVRTKZbTq8Xk0?=
 =?iso-8859-1?Q?oG2/zsR7vXXm41gTdTeygV7ceCyTxqmhbr3FLpVG4dEZRWhW9tmYeCeC8W?=
 =?iso-8859-1?Q?pepDRA6MJ0RsuQHVapsy0ulyLRB7oYQ7UixUHU2i/baatLrz0J4bk1da2G?=
 =?iso-8859-1?Q?w4Bt0Z9XkEs5aJkXTpf+Yhcbd3QHCpzERJNVINQv1ScMo7WzE8afq5o9JF?=
 =?iso-8859-1?Q?Cuh4fWGxT8mC0Cu/eDRe1IOpfWrXilR5i+4ML919SCyRV2jGYy1i7wpv8o?=
 =?iso-8859-1?Q?TJ1Bo10avQrX9Bv7FsYVjbGrbWot4h4LJsNv28WjVVnBRnntudPhL0YoFi?=
 =?iso-8859-1?Q?FQhTVWf0sFovu/8D4WYJoE7kwkuzzqLTIHdEBX4qCbNQ3uWiU1UOpJWbeV?=
 =?iso-8859-1?Q?DxERne+2GLdmB+tXzPFp0QjwyfJfm3NtdWIZZhtmOqJC4ctKBEICGDeWyb?=
 =?iso-8859-1?Q?gEGkNm9BGu5vVGQG6nRvdxBsNeKb31eHBg4+KOH7hpKCs/xdJXI8DEEFvi?=
 =?iso-8859-1?Q?u0xz4gs0YVaHcXsY+KyOtS+2UnJ1CKGxcLfyBLvzz+YLvDxClp62uiN1kw?=
 =?iso-8859-1?Q?/oJDVyuOTg6/tyTIM8v8Oj8aCdorfc73yF/oQh381lneiSzoDT3KsK6aYr?=
 =?iso-8859-1?Q?uw1dLUSO/7QpWK0xVZNlsRNKzXOCzE8JSro8Nz3F5rHPqgV46KRu3NADlP?=
 =?iso-8859-1?Q?gd8ejBCWsOSwQWNSbD3GxRUPQrvd6WMSQ6nVY09dF0RJYEV9QGQ6HIoYNy?=
 =?iso-8859-1?Q?BCJZYleyKO30FnEL7a7Bsa84mBW2nEQ9d8ENWkvvJiobT1EopDkNBX1sKH?=
 =?iso-8859-1?Q?uwyrMqjzApQjnMi3lucmmO6Mls1vvhtcbxCocOt2CFWitvs2T1CN0t+Qp7?=
 =?iso-8859-1?Q?rxznOMxlFTwxgg+RVraCmxd10MXDCB0SRXHD2ZKLYJriFE5iDDrZ0F2jCm?=
 =?iso-8859-1?Q?sr1xPo3373ZwLt3VXErM5qGpk9kMWdj2EZkUSNLgUt+ZxT0o/kIkdqjG0I?=
 =?iso-8859-1?Q?wGaCN6kKxZXjF2vt3a/7bqWapESiHSaRbLbO/oggBbUOf+M=3D?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR11MB4024.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d79e786-98f6-46ab-ab45-08d92055980b
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 May 2021 14:50:24.2567
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5ae1af62-9505-4097-a69a-c1553ef7840e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: UYorrUEZHKS1hzT664tMG+KFLxTlySuiIpr+xD6pqHYT70fTIqCcL0W8ufUo9UcfE2yWqkg3PN2Aff1NDefNVA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5199
X-OriginatorOrg: cisco.com
X-Outbound-SMTP-Client: 173.36.7.18, xbe-aln-003.cisco.com
X-Outbound-Node: rcdn-core-4.cisco.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> [perfbuilder@five ~]$ export PERF_TARBALL=3Dhttp://192.168.100.2/perf/per=
f-5.13.0-rc3.tar.xz=0A=
> [perfbuilder@five ~]$ time dm=0A=
> Wed May 26 11:04:00 AM -03 2021=0A=
> # export PERF_TARBALL=3Dhttp://192.168.100.2/perf/perf-5.13.0-rc3.tar.xz=
=0A=
> # dm=0A=
>   1     9.39 alpine:3.4                    : FAIL gcc version 5.3.0 (Alpi=
ne 5.3.0)=0A=
>    builtin-report.c: In function 'cmd_report':=0A=
>    builtin-report.c:560:3: error: 'prev' may be used uninitialized in thi=
s function [-Werror=3Dmaybe-uninitialized]=0A=
>       fprintf(stdout, "#\n# (%s)\n#\n", help);=0A=
>       ^=0A=
>    builtin-report.c:622:20: note: 'prev' was declared here=0A=
>      char *tok, *tmp, *prev;=0A=
> <SNIP>=0A=
>=0A=
>  10    13.35 alpine:3.13                   : FAIL gcc version 10.2.1 2020=
1203 (Alpine 10.2.1_pre1)=0A=
>    builtin-report.c: In function 'cmd_report':=0A=
>    builtin-report.c:560:3: error: 'prev' may be used uninitialized in thi=
s function [-Werror=3Dmaybe-uninitialized]=0A=
>      560 |   fprintf(stdout, "#\n# (%s)\n#\n", help);=0A=
>          |   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~=0A=
>    builtin-report.c:622:20: note: 'prev' was declared here=0A=
>      622 |  char *tok, *tmp, *prev;=0A=
>          |                    ^~~~=0A=
>    cc1: all warnings being treated as errors=0A=
>  11    13.77 alpine:edge                   : FAIL gcc version 10.3.1 2021=
0424 (Alpine 10.3.1_git20210424)=0A=
>    builtin-report.c: In function 'cmd_report':=0A=
>    builtin-report.c:560:3: error: 'prev' may be used uninitialized in thi=
s function [-Werror=3Dmaybe-uninitialized]=0A=
>      560 |   fprintf(stdout, "#\n# (%s)\n#\n", help);=0A=
>          |   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~=0A=
>    builtin-report.c:622:20: note: 'prev' was declared here=0A=
>      622 |  char *tok, *tmp, *prev;=0A=
>          |                    ^~~~=0A=
>    cc1: all warnings being treated as errors=0A=
>=0A=
>=0A=
> I'll check later...=0A=
=0A=
prev should be initialized to _binary_Documentation_tips_txt_start, i can r=
esend =0A=
=0A=
=0A=
Thanks,=0A=
Denys=
