Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 683D23B8871
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jun 2021 20:29:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233315AbhF3ScH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Jun 2021 14:32:07 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:32974 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232358AbhF3ScF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jun 2021 14:32:05 -0400
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 15UIOJY5002582;
        Wed, 30 Jun 2021 11:28:18 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=ZAylvdYt4FyLaHH1kbPX2jpkte5IVrtJ6byWWJapvq4=;
 b=ct3WaZ3WZ+8KFBVaxPzOk+qLjxwq2V95e0nJy5TepTcVEe7bGCXCphRc7z2rleuV/n/e
 zZnrzplxsOH0GYwK++TLbW9VptbCVYjnkrAn7pHc7lLlezgk4UZXKU33DPIXvBDcf7p8
 ftS5A3xp8yZvAGKBxONmbpRpS9B9upZ34W0= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 39gt0ha2mg-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Wed, 30 Jun 2021 11:28:18 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.35.175) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Wed, 30 Jun 2021 11:28:17 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TiMen6MWIXvYcHR3eh5exMSkIw5oUUrcNCiU8ZffCsDgUvFRqdivEjLitMHnNvWT/CEbVus+552b3B5XNVzQXhuBgjMQnIiaXq42RcKyQKUTi6qxMhbVw0iSTHwmW1qqKqwmP3i+adquY5hGu531skWOTx8Hl9yS1NoUH7hPfcAZ+cJBvjH1WT/qOuzZW4GgGUQ8vBn+DLE0ljtZVvfwxOSiI0x1ya9Mk0kTtasZLH1mM/xZLAjTMMJhgG6awYhj29GRcDvlwCMCunnUTvCRIegJ4WGmPSLFDFVD1B1YewYEhLlfwF4/ASzt3scPXUwu/ogH2x8uhoNQS7F1zP2+4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZAylvdYt4FyLaHH1kbPX2jpkte5IVrtJ6byWWJapvq4=;
 b=QqazAC+yXNHyDbYoK03D/HpBNGFY8v6oTt7L9EAmuTZVJOQV9MJmP580UTftfYSW7St0J99fgE6EnGgAbW/37M6iMFhDCMXhoSg3n50Bl2O4ud/WcXx191iJN3nB9+FX146wYozcMyClpNcJs1KseT4kxt580FA9VFzqVNP7xTyG/VFfm6DMxOyHK7vSbz6OfqVoB0e9/+r9fvwsLpH5zTI21HcuNS5FJ6lLXz8nQe6bwKASj/LOe1Oqyqo2vOPFPOe3naUVcR1dJIg72FWN5rw2+z31WF3FQ2KpkTT9wR7oZrJ6AILXe/INLgNN8KPvSNtbZ2m8BSQEvM8FQcXJ/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from SA1PR15MB5109.namprd15.prod.outlook.com (2603:10b6:806:1dc::10)
 by SA1PR15MB5112.namprd15.prod.outlook.com (2603:10b6:806:1df::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4287.21; Wed, 30 Jun
 2021 18:28:16 +0000
Received: from SA1PR15MB5109.namprd15.prod.outlook.com
 ([fe80::6ca0:8d70:ac3:14a]) by SA1PR15MB5109.namprd15.prod.outlook.com
 ([fe80::6ca0:8d70:ac3:14a%2]) with mapi id 15.20.4287.022; Wed, 30 Jun 2021
 18:28:16 +0000
From:   Song Liu <songliubraving@fb.com>
To:     Namhyung Kim <namhyung@kernel.org>
CC:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>, Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        Ian Rogers <irogers@google.com>,
        Stephane Eranian <eranian@google.com>
Subject: Re: [PATCH 3/4] perf tools: Move common bpf functions to
 bpf_counter.h
Thread-Topic: [PATCH 3/4] perf tools: Move common bpf functions to
 bpf_counter.h
Thread-Index: AQHXaZJTSWB6NfLt3EiUUwffDVqPwqss6DyA
Date:   Wed, 30 Jun 2021 18:28:16 +0000
Message-ID: <B664AA00-4B93-4809-8849-867F8B268132@fb.com>
References: <20210625071826.608504-1-namhyung@kernel.org>
 <20210625071826.608504-4-namhyung@kernel.org>
In-Reply-To: <20210625071826.608504-4-namhyung@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3654.100.0.2.22)
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=fb.com;
x-originating-ip: [2620:10d:c090:400::5:5c9b]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 76a3ee85-9aae-43da-3ecc-08d93bf4d415
x-ms-traffictypediagnostic: SA1PR15MB5112:
x-microsoft-antispam-prvs: <SA1PR15MB5112903F5016409B537AF5BDB3019@SA1PR15MB5112.namprd15.prod.outlook.com>
x-fb-source: Internal
x-ms-oob-tlc-oobclassifiers: OLM:983;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: zFG11u9wOoVw3R2xahJEJLT68sAAJX/PnDrU/XmhWRHyrpmQ2TxjwIPfvn6qz1Mhmv2+ZZZAMdhUws2VamvcpCllFcXhWYGrhiBuurjFWTo6KcyNkBWH8jZjiOCKJLhppMVP9BPhrW0cMFqVpUFTuFC/Y5cj09CmvtXFFdlBpmx1fy4Xrayjzhur6F2Vk0IoD0pNC7Nlv5uy9b4nuS/3ackVQV/m4wXRc5jqtwxRODJY/URm1c16g2ra575UiExYzbjNT24RNp/o0CH5Ap/RV3UHm/WYD29AazLZpYqSonndoTucOutovoKK19EqrVlI91vdowmUAY4lD7BT5lzODq0fLmn24CSU+JiwSqBp2xOQucEYL6akgUgEeRSmdjeskjqWEI7gsPOP81DULYqE3Fdl6wcOB4YeqEMUyxkN+T9i5HNMvcteNBpoIAxKhySvMKIFFZndWCvwA8xHM0rcGuV/0NtF8TPQh0VYXbviOEH5acUZ/sWt0yGaPsC4P4Tfm7vfEiOFDm+QL4x6nTcLM7/QoYyMz4SxX1sQLpKe4F84soCaPvMoaJjqgV/M14ku1onwUcDi2sQgiaMlOWjKSKe8dGJyd2RRoSkRHIA7kMRr1E57dqlP6S3VfjafewAvjhcQHFiOqBfzBw6du9LCqsFYuoUGAyqU6uvAD8/B0vOwxVWQ8qn0pnP4CF7zrFo9wTXpJVpYIJlGxD2NTos6qA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB5109.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(366004)(376002)(39860400002)(136003)(396003)(91956017)(2616005)(76116006)(478600001)(316002)(8676002)(66476007)(38100700002)(66446008)(54906003)(8936002)(186003)(66946007)(122000001)(6512007)(4326008)(66556008)(2906002)(64756008)(6506007)(86362001)(558084003)(33656002)(6486002)(5660300002)(71200400001)(6916009)(36756003)(53546011)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?kdPxbqR65hJfErzn4NkLl1RHK/K2QvSZu7FkvA3/Ior56gmOJwyiP0O8FAU5?=
 =?us-ascii?Q?F03WmBfhi7brpoq7kxUNspqC1Fk3wHQlJd0OC/528vFP/uhv4WBrcJMdoazc?=
 =?us-ascii?Q?UBTd8WWVh7hO8rXeJIp/R3dZhuUmAgHjfMmWrh3OhofTRP2FbS2V8eN7943H?=
 =?us-ascii?Q?IKjzmki7ORa4yNga1dTep0E3lAbqjWfBJOJPcPXTfuqgJDR3dygm2k7BhS+2?=
 =?us-ascii?Q?DGk9eLxDFybhjdxdCRpIER9RscHgLrfnpk3DzwQQJPVaplkhaR66GSbGBJbv?=
 =?us-ascii?Q?ITIpQMT5SJwrnR11vAOox5ksbwtdd0uTJ01h5bw4aZ1AXqQjoBHmMz6wK3vz?=
 =?us-ascii?Q?2vYi30hMAsndOjZf36IHOXbqYSq+x/x7DxX442QZb4GCwuzA9YPSwJf9y4GK?=
 =?us-ascii?Q?Lf2A/Fr07MH+mRInoEjuhXaLa0yb7N6+8PCC5Z6m+l/iRGOTfNmsyDL0Q77H?=
 =?us-ascii?Q?qP3v1Y+9uJf1daUBKiWEBfgA2yk+WRuzkTVFFb5SfAnoVylKNclJ4WOr1NQS?=
 =?us-ascii?Q?lPkpK0hcEemy/VTC9fgGmhOBDMkx/jlBpNEsVyufgfxJVWZO9jaDXWfANYL8?=
 =?us-ascii?Q?fGSopFFWId9z14bfmt0bCTr0gxfhEfnietraehZpTpmmzKab9/3RUMPsLh1v?=
 =?us-ascii?Q?iX9yE3uaz9xlWS7vMJXrsAL/r+wLATT6WxltdBmo71vO22wElRI46lIWiUTn?=
 =?us-ascii?Q?E9jssVIsF8nKOF9+RtJcXaVcGF9+8iIzOOBBQJvT2Q0hTvtJBOm2xsBGx55B?=
 =?us-ascii?Q?gKTq6X9fgSOHIAKNy7/6jqxYEE1wN07ihhwZz5P1gHdGRSvDZv5C7T32tVFt?=
 =?us-ascii?Q?R0KiyUenb8SW1YYCY+TfBDfihkYOTfuWYxGb9zDO/qmL9TDiLHh5lXQLAEFC?=
 =?us-ascii?Q?i1T1CYIs5PhlrbkkqM+sM1X+59FtaFx51i5DhsJootZZWwUiag2v+sQxBIYr?=
 =?us-ascii?Q?Ssa7K8NZWPOdXjL5R6JPQaj8b8w9bK1f/KQTw6sHDhVyxf5kLRD7MYOohYaZ?=
 =?us-ascii?Q?UNTXLaCp5e8GZJxe7jqH6o5xurImI6DENA91bNp9SBFu1b59ScOjSUh/2d9h?=
 =?us-ascii?Q?ZpzGEj2r0swA1tFDAnTkpJQGBh9E/+gvQz1P6HYsAd+2G3+xxEAhW+MDW2B6?=
 =?us-ascii?Q?aolPhin7VJglBLte/28QwxdSU576e3X5pzXs4CTM17r3CQws/P1kNv65amAf?=
 =?us-ascii?Q?4ulT050qVa0od/apJz+B+rq+eqtGogptBAEAtRtBD+7ENZMlt1XpqTvfuSNU?=
 =?us-ascii?Q?pie0Thch6BgLn+Gz/UlW4fu74s/pAXmwGpTPMKYkRFcpp6ZnRZVJ48oEM0Gr?=
 =?us-ascii?Q?TFu27Un/o9e8+dO7JXhnZZRJ952IsRQqbFAgbws07El9wi/OVDJXQK7PgRbU?=
 =?us-ascii?Q?yV3kdZ0=3D?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <AFB8C6A9C773C544A16C8A9F5E457694@namprd15.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR15MB5109.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 76a3ee85-9aae-43da-3ecc-08d93bf4d415
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Jun 2021 18:28:16.5100
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pZoccjmi8LvOay/mm2Efu2JOHo57x6zXwmRXRJiQYhpxut/fZSyAZ+GAg9GLgBz4es4AXQpI4Lp56o/RQOL4xA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR15MB5112
X-OriginatorOrg: fb.com
X-Proofpoint-ORIG-GUID: bd1AcKDhu81KdHFUPskGR8zMfnLRCbly
X-Proofpoint-GUID: bd1AcKDhu81KdHFUPskGR8zMfnLRCbly
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-06-30_08:2021-06-30,2021-06-30 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 adultscore=0
 lowpriorityscore=0 spamscore=0 phishscore=0 malwarescore=0 suspectscore=0
 mlxlogscore=770 mlxscore=0 impostorscore=0 bulkscore=0 priorityscore=1501
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2106300102
X-FB-Internal: deliver
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Jun 25, 2021, at 12:18 AM, Namhyung Kim <namhyung@kernel.org> wrote:
>=20
> Some helper functions will be used for cgroup counting too.
> Move them to a header file for sharing.
>=20
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>

Acked-by: Song Liu <songliubraving@fb.com>
