Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 878ED33C5A9
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Mar 2021 19:30:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231265AbhCOS3p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Mar 2021 14:29:45 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:20968 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231685AbhCOS3N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Mar 2021 14:29:13 -0400
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 12FIS5LR025288;
        Mon, 15 Mar 2021 11:29:08 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=069rUPAB9O6M50E9w+7lCX5ilSfE3GZ65X5hbGAGMmQ=;
 b=Ua71q8VHeJIyGy+5o+cbvqyv35iQSDQZoTpUnoV5kP0TAJjqQ/q6SY09QgqHDrGNhnII
 rPRapg56oGaF1VNdW/cjMYapv1XuT8BDYJEZOhJOqSPpgubISU0t/NFo0pf8DOfHrAbr
 5X6Fad9pGSwCH2z6AofiTPQ2ovjqDkxYjeM= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 37a6brtjdy-4
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Mon, 15 Mar 2021 11:29:07 -0700
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.36.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Mon, 15 Mar 2021 11:29:07 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=frDbpfF1Z8vWHKrc7PqldurQcCW3jPIxWpgRnKdvGLJRUUKfu+V4o1X0gwHLF+B7ZhaePhCrFMxTy7d60ZgA1qFIXASGMZemDfZ5R6eQhP9w8Mss0B8hq602dyTRUBMsuliSxr6oj0/r811cxk3Ns5IuqSv+pzloemU/KbtU/OcSWJuxYnmwSVMabF2m8wbGsAtDsIjOJPdlunL1Dgq6gSHzCwqZvACVC566q6qFeATJt46kfxUaz8YYugT2ECmMESuYShX9FovKQ/BNygjSlM5ojh3znW8WC9D0p6bxJiTzSagBdt/W0HEe66iZHmtnjfRvjLa/WTe+MDIMG3m6vg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=069rUPAB9O6M50E9w+7lCX5ilSfE3GZ65X5hbGAGMmQ=;
 b=cQZ+TdyxNzNeboH28or1a+5DLXtT/ppMpeRp3oIAjYEkQnJX9p9bJbnEjRGUSDpY8dVA02vrhwtoJgUlKg+IX4m4kF94ewdsGD+JVhz7lUwgc0gzrLDj1CMm0HpIc+XBIlBVzu+5t0teZYiJXo1REomL6hPb1Qi9FXXRuJOxpfnmYcVa2+SEHgvvsNjgNY7KyOBPJil8KBjYvq7233mAgy4lQ3Oedqzv6tjhs6EVTifRFatW/APkdD783Nw9btwJuGLMTCyCURMwFXNmyCDfMP07oWxZhSC1oNKXnLJXCMeieeS6+Y8Gw0kPs4umQ4gnjP/Nr4dsNUQbDQ+Otuy8OQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from BYAPR15MB2999.namprd15.prod.outlook.com (2603:10b6:a03:fa::12)
 by BY5PR15MB3716.namprd15.prod.outlook.com (2603:10b6:a03:1b4::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3933.32; Mon, 15 Mar
 2021 18:29:03 +0000
Received: from BYAPR15MB2999.namprd15.prod.outlook.com
 ([fe80::1ce0:8b27:f740:6b60]) by BYAPR15MB2999.namprd15.prod.outlook.com
 ([fe80::1ce0:8b27:f740:6b60%4]) with mapi id 15.20.3933.032; Mon, 15 Mar 2021
 18:29:03 +0000
From:   Song Liu <songliubraving@fb.com>
To:     Andi Kleen <andi@firstfloor.org>
CC:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Kernel Team <Kernel-team@fb.com>,
        "namhyung@kernel.org" <namhyung@kernel.org>,
        "linux-perf-users@ghostprotocols.net" 
        <linux-perf-users@ghostprotocols.net>
Subject: Re: [PATCH] perf-stat: introduce bperf, share hardware PMCs with BPF
Thread-Topic: [PATCH] perf-stat: introduce bperf, share hardware PMCs with BPF
Thread-Index: AQHXFuPifzAWbJ/c0EGfxtA8c/wTpKqAaRKAgABK5YCABFdTAIAAKCsAgAAw6AA=
Date:   Mon, 15 Mar 2021 18:29:03 +0000
Message-ID: <C1E53484-7B7E-466C-A94F-3EB1E2F61198@fb.com>
References: <20210312020257.197137-1-songliubraving@fb.com>
 <YEt5o7pSTleymwy1@kernel.org> <F55800AC-73A5-46A4-9E08-1DD00691267C@fb.com>
 <YE9ctk/sO/bokBjw@kernel.org>
 <20210315153359.s47atiznpxkrc7oq@two.firstfloor.org>
In-Reply-To: <20210315153359.s47atiznpxkrc7oq@two.firstfloor.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3654.60.0.2.21)
authentication-results: firstfloor.org; dkim=none (message not signed)
 header.d=none;firstfloor.org; dmarc=none action=none header.from=fb.com;
x-originating-ip: [2620:10d:c090:400::5:17f0]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: dd8351a7-8049-4511-32b8-08d8e7e035af
x-ms-traffictypediagnostic: BY5PR15MB3716:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BY5PR15MB37166FA9A823937E7BF44277B36C9@BY5PR15MB3716.namprd15.prod.outlook.com>
x-fb-source: Internal
x-ms-oob-tlc-oobclassifiers: OLM:5516;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: U+FBw+7Q85p4emEKmVs2wcJ/lzpSlgTPfLubU+1iCrGBLulPrq7A2YVTU1ZVmiPh7PfCkn2/9GZeQzXBuc30aZaccOUAMtUGY9xw++MEaR87wyA0O77N0qM6ZtoDsHkG4zJDlWV2gbQoqAl5SHkNEY/Bz3HukgPElumxxwQqTKP0imTM4TcquvYEAwWfLVr7Wog2C5imVPM4lNz892QxgA1/mC+JFNZfoz7GHR2+hNkdMFTVHWbY6jv8JRtrd+4FXxIQxpXZ7ef64oDn1KYs1V/lVXPU3DMUcC/YaSXaZKOc2aPTO8WR0+HYxt6hn1bCUNLjQ1twv8RhewrME01XMkMmCLItpoVHrjCKIGRsz3zztPTy81+SNScJDnZ19mFCfAhp0kbaGBgouUHO0R/Qb2L5pQ8EQEBq5PzLN3zbfW2OV5LjIN93n0pgyU3Re7WjaHijq6o9j61FDC2xis652lcCTtWIvqMAsMX5tT+2CMWFVcs8Nlp1qAEDi2WebymlIq/wrlqceCXlNvct6TwnbCYVcIZezvaADkajjCi9Z/FE6iHY6Qyu9/4D58eFXwQofORyafivTxZydT7e9AKFH7+RY6X6UimRWbzogKLI7DaudVR6wE5zxvG4YiYTxDXb
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB2999.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(346002)(366004)(376002)(136003)(39860400002)(54906003)(2616005)(6506007)(8676002)(86362001)(6916009)(186003)(316002)(478600001)(8936002)(53546011)(4744005)(66476007)(66446008)(66556008)(5660300002)(64756008)(36756003)(6512007)(2906002)(91956017)(76116006)(6486002)(66946007)(71200400001)(4326008)(33656002)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?wQMBTOQC27JGuk5uEHDCmd1k/EeGzG9i4hT7EuOgmc63LBfyO1qy4+8WSZyD?=
 =?us-ascii?Q?TQLq131Dy/Q130uPth5XGx75ksZHPKyHuJ7kpy6sqj4+/fkMLvbTIOdcpWh5?=
 =?us-ascii?Q?tJMRzcXP3BwWJWwD299DHSwUdlKc3drF3BuSdRoXlcXSJwr79Wb9uBzALK3N?=
 =?us-ascii?Q?+3jiJP+51reyPlr/2BYTM8UHJwWOJ8Za84cLEdc979LBL+kxrOAhyRm06S/Y?=
 =?us-ascii?Q?mMZs/gIdPpMvK29Wz7VW0XgJnu9xL5oQXD5H2HvA3qIr2hDtBM196UgVLM5i?=
 =?us-ascii?Q?R1UnqG4D83vK25c1DvjDTeSjk9RmJtY7H/AoCbblORw//JIgt4pfpSvQ8WJc?=
 =?us-ascii?Q?cpMZhowpKktcHWkGDqNJnvGg99Hg56mBhMsZq/pAV/kZMX0cf2rkpF4w8T3H?=
 =?us-ascii?Q?+wkUvifKj0znjh0UEFz9hYV210cOcXEZjJ0ZQEhcvUqwC3aVRMInEUkH6LbR?=
 =?us-ascii?Q?ZetrUoCVl4OKLnzysrbXN9vx7CPsd2lp3hNflFnIGYLqurKi3M3c2sfYyDBD?=
 =?us-ascii?Q?o5dp4H8Hh38BAYssF8gEDq78kSM29OZoWKGNVAt1sk8IbdSBoB0SEWXindHR?=
 =?us-ascii?Q?YzA6W6mOk2ws5ivAwJmUgwvmocluDIN4p5VNbsDSUzRkOB87/YQDLNDifiNx?=
 =?us-ascii?Q?Qao73/2RlsP0elN2d3OzgagwGMOeTjU3Cus/HCA+rb4ZGc+cHkGkfQ+1ZOEd?=
 =?us-ascii?Q?y13vfz6zJJYsmNdx3oSxzuF6VrtHRVexa3K/NziYmSRIPtbBuGgczaYOXWuD?=
 =?us-ascii?Q?h0UOuC6o4UkPGddY4V8FXLhmHLbBDK0vk6smATC835tfqvnOjyd5MCI+fMzD?=
 =?us-ascii?Q?proAnQxyXEiiTP7NsEVv/jVADzw9TJlp5IYzZQEpl2+ckj8Idws1kF5JKdZU?=
 =?us-ascii?Q?GERUxdMlSEUvI5jqz3fTQczyMrKfOXpQz41cFwNfIdjBGl7vP10psxlYdrV4?=
 =?us-ascii?Q?7B2eqfjA6lS6ywUTbhRuRYKrNihQafkjx/dzMiPT5aiv5ASToZDZ6ZRIw8YP?=
 =?us-ascii?Q?P+K/zmkHtnfh4MP4mjYBmmqEti9fhw5xZYPQZK6xY8+P2ZDXwvlhoWUUC+si?=
 =?us-ascii?Q?djEEpvbdjnKGlGSGMsmZtwq6UmYCIlJ8ZnrUY77zU4rL06uVpkH3UapV52fn?=
 =?us-ascii?Q?usonPft9h1n86Gk2P4fRrNwggTuL23swOQfCrULdcz/Abzx3hKfH5WZlQz1F?=
 =?us-ascii?Q?YefIQandzXFJ7QfgYrTvWnxyn67FtJ43K51R0PwWDnIgNUqw0n47V5H6kOeG?=
 =?us-ascii?Q?mcSw9cQqMnvW/BFeRaM0LUuDdQE2H1bjm2iA0yua2kYAeWxqUSPYMJRqdz3n?=
 =?us-ascii?Q?UVHRQpRyjd722ZLuV5L3TipYlSxaoI2MIEUxwKkJGK7dGdow+SIbki3+e9jZ?=
 =?us-ascii?Q?7D6NaqY=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <7F11C52D6B2EB6459CEA403AC473B106@namprd15.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR15MB2999.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dd8351a7-8049-4511-32b8-08d8e7e035af
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Mar 2021 18:29:03.1000
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: AH//eLJq4K7lh+bVYrNK0d0qgLH5vOypcyW+Mra2bO/X9xGr/U2ASo3YvNpE+7pceBR+qN2/RDtnZmN9Smx5lA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR15MB3716
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-03-15_11:2021-03-15,2021-03-15 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 malwarescore=0
 adultscore=0 suspectscore=0 phishscore=0 mlxscore=0 mlxlogscore=892
 priorityscore=1501 lowpriorityscore=0 bulkscore=0 clxscore=1011
 spamscore=0 impostorscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2009150000 definitions=main-2103150125
X-FB-Internal: deliver
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Mar 15, 2021, at 8:34 AM, Andi Kleen <andi@firstfloor.org> wrote:
>=20
>> I still think that there is value in taking those measurements after we
>> enable the counters, as, for instance, for interval mode we want
>> measurements with the counters enabled, whatever happens before the
>> counters are enabled is just startup time, etc. Jiri, Andi?
>=20
> Yes I agree. Only the time with counters enabled matters.

I see. This change itself is a valid fix. I will create a separate patch.

Thanks,
Song
