Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C39935A870
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Apr 2021 23:43:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234713AbhDIVnu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Apr 2021 17:43:50 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:45284 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234079AbhDIVnt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Apr 2021 17:43:49 -0400
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 139LUkmP005929;
        Fri, 9 Apr 2021 14:43:14 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=SY92cRgJHj/M1AiBnFCA77q1Ov/n/xkpuj1LpjnCUW4=;
 b=qyy/DNztyEy6D+IRo8CUhBiXEKIdza1Zv4lP5MZRo3NevAMLs7SMji/2vxAbcrnCKfXr
 +1ZTND73dWwu+xIdqVKj4sVH0ThEQHo3yZpMJXCpZH6hG3ualreZTxLme5vK39JKFrfF
 JPIwxW4B5qjNKGp99CkfkHopvgjtECbYGHg= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 37ts7qjfxs-10
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Fri, 09 Apr 2021 14:43:14 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Fri, 9 Apr 2021 14:42:31 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=I8bWrj1UOblsFBBS8Ilm9u0PuIaLA5sieRACeTmTHNSHezN2D+6qX2twLKOrV+sy0dIEYCwTjLexFxLMpowVZ+CG1LYEfZ2UN/buhUAuUVlkOUblA+Fa6fdbCqsr02ftrJKMF3ZCcD40B63SxBpLxtwXljibz567rPBVA8BtnrJNn3IAcH0+zd9S6hccrXbqpHNvDwtyilsmu5y9gFfakWmjFdeQpoS5vrHyWx2/PVMTa2DQ9TsLOY4zi1vo0XA9uusT0Q8s39RxnlGJxl4FEvu8N32uJ+hJXSK5fzbMWLw5KzZ9rRYpe2O13x6HdEnNEobeqCJa9UPGhM1XciBhWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SY92cRgJHj/M1AiBnFCA77q1Ov/n/xkpuj1LpjnCUW4=;
 b=kmcs04pbI0+tw8pgsUU1BOaDWoDd7No1UTpfP/luF8T6WeH6AAfRaho5a/L6daHvofPkfvw51sWfgvV0R36SzOhkpuiVsU5tED9a0xY8BC7EVmrEaAfS4IrfW3ar68VGhSdMGAPZUS5dAjnCo+No8nNDwmWnhBCswFgTitahmAWRPbDIhZWQwgVHAB20US7lyUF/mjG+fWplDq162AFjzf2h/rt5c86U8cGFzmacbioZcSf3twVCC3jawDhzBEM796k2wDSh60qGquReOXueww2QlBO4Zo7N7pFWmMqPetMUv+oWjG2Bn9SKeLudglJ+mQfyZ8U0oWhNVmMfdp3TAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from CH2PR15MB3672.namprd15.prod.outlook.com (2603:10b6:610:5::14)
 by CH2PR15MB3558.namprd15.prod.outlook.com (2603:10b6:610:4::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3999.32; Fri, 9 Apr
 2021 21:42:30 +0000
Received: from CH2PR15MB3672.namprd15.prod.outlook.com
 ([fe80::85ce:d2bb:e13e:49ef]) by CH2PR15MB3672.namprd15.prod.outlook.com
 ([fe80::85ce:d2bb:e13e:49ef%3]) with mapi id 15.20.3999.034; Fri, 9 Apr 2021
 21:42:30 +0000
From:   Nick Terrell <terrelln@fb.com>
To:     Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
CC:     Nick Desaulniers <ndesaulniers@google.com>,
        Zhao Xuehui <zhaoxuehui1@huawei.com>,
        "Gustavo A . R . Silva" <gustavoars@kernel.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Miguel Ojeda <ojeda@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "yangjihong1@huawei.com" <yangjihong1@huawei.com>,
        "zhangjinhao2@huawei.com" <zhangjinhao2@huawei.com>
Subject: Re: [PATCH -next] lib: zstd: Make symbol 'HUF_compressWeights_wksp'
 static
Thread-Topic: [PATCH -next] lib: zstd: Make symbol 'HUF_compressWeights_wksp'
 static
Thread-Index: AQHXLNYxYdv3ceUNTE2Bn9xmcPR1Yaqrgb8AgAE3DQA=
Date:   Fri, 9 Apr 2021 21:42:29 +0000
Message-ID: <17D84680-A287-468A-B4EA-E8E037B587D8@fb.com>
References: <20210408125429.199592-1-zhaoxuehui1@huawei.com>
 <CAKwvOd=4ebTNPMOD5K_tUDOY6jx-VT29kUNv=d8ZLxG+1bv6=w@mail.gmail.com>
 <CANiq72k-X2WPfi7B2sNYMUqAEPjZq5yp4R+j5V6gxMx+AiOq_w@mail.gmail.com>
In-Reply-To: <CANiq72k-X2WPfi7B2sNYMUqAEPjZq5yp4R+j5V6gxMx+AiOq_w@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=fb.com;
x-originating-ip: [2620:10d:c090:400::5:49a8]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 90e3f24c-1efa-4788-a297-08d8fba06035
x-ms-traffictypediagnostic: CH2PR15MB3558:
x-microsoft-antispam-prvs: <CH2PR15MB3558B641EB4AD0E8B1781BBFAB739@CH2PR15MB3558.namprd15.prod.outlook.com>
x-fb-source: Internal
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 5ti7/5PBLwBJWxJx/qobEOf1ghjrG+UIqZ8QVYCLV3SvhrLM1+nrYgasiOShOA705jd61rp0A/ih3h2+GhJyTILa23Jw2Shb6qXn8b3WmaaQT2R5pXyzkDDl59QNDULKfNhSWxJF5taTtQHxEIHuPqNxWh4hRtCnsnOO6pBgdCRbmCOkp4fjkwZvhgpHNtxTjGrVW6N4o1YGPDafJpxQDvMi5A1A9a/KgNRpdRoZG8CT70QjcW35N9Xtdjb/6w/4aT92mXc30eWgSExgl+fIYpf8m2o6i4NfcjxMOoTJJMZH7sS0ZM15R1H3BSau+YmEP+MNU5UuIqyZ0PKUQUJgMnufpSuemLN2ykDob+t4/wbtU/bNttW00X2x0IZFmpkuTVZJfP2IlXWRL4kb1YF43bupI0KNKypKU0CRah17omg3MSwkF98oAB3plYCFe9fBFSTi2Seeam0fPEXbVgqytDvf3cFi62R2cfbEfDqvIbmz7W9UDX1mX07bmjBGMP4P2GJaLhBRiWnZu/g2psY2aFQNULx/RHcMRCZ2sxnbM77L6BOyaSFrwHW9BcoSu76YhzYV16f40YlkCfMPBjQBIqIs6iO6VO/bye4inirn3qqLBsQK3FxEsAY6pq5gQ9uoYWs2emOF11M3qa4pBhtwEm7LdP9jW/bBxvJ2+BmIJw3b4zL6LHkIviOhDeLjCYSKRif+YPvaRMv8F/s2NS32WsF2NIgJew1M5g86gabguKAri4ap6MVRcO7jlJlCY/VlDU8RK4/uK5YbBCjucqMk/UrjlPKGCjtzFHkN1/VNVuM=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR15MB3672.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(346002)(376002)(366004)(39860400002)(396003)(136003)(76116006)(86362001)(66446008)(53546011)(36756003)(6506007)(66946007)(316002)(6486002)(66476007)(66556008)(4326008)(91956017)(38100700001)(71200400001)(5660300002)(7416002)(64756008)(6916009)(54906003)(8936002)(8676002)(966005)(186003)(6512007)(478600001)(33656002)(83380400001)(2616005)(2906002)(16393002)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?5nbf/wNDEJvmOPUehM9cb2AITYoys9zGCAK9xVi/kpJpSjWa/nXnXsxYR8Py?=
 =?us-ascii?Q?fRfGQ0wvBhaAPDST237IXutG4i1oqKoKef/3Q25t6ULWreVRzOsxpuIi+8bb?=
 =?us-ascii?Q?d46HPJPNQkCLxU8VnTv8MhzGCFk2Z9zzFGNfEll+IidqnBXu3cZgylmxFyCS?=
 =?us-ascii?Q?CTiFnVpo1qin1HP9WetbzfnEXw14XcvpYCr7S9c8Z8T7t3AFNevKgWgzR6Z2?=
 =?us-ascii?Q?JFy0xgwj8W+lEVm6wZitZ74OTHdt2VNdxDxHMLH2njdzr0j4MwixrY6NhQBt?=
 =?us-ascii?Q?szVs6geLRD2exuPjJDqsc0Bp0tCI9JFgcEOQNLtHLDlOnkfU5DAzVnCHisOV?=
 =?us-ascii?Q?hhbf3beBD5OcSXuNWKQT589GLCTqPDkS9zTENNhPCA16kbIWNnTJSHsdR3rm?=
 =?us-ascii?Q?YPbPvfq6YYSvs6tw2NHcbajim2/EvDnjR2AIneccgLnri2KoCeWbSO9nyQYL?=
 =?us-ascii?Q?cyAIFjdnqJ4T+ELuIb6tteCSzjJADY2mDFyha2XKozx/Po4KmyIi57WAxvyZ?=
 =?us-ascii?Q?qGN5K2optFCj5IHiCQQvfw+OK9czP8MAgriA7R/6S2jesOgrPH21Bd+divnP?=
 =?us-ascii?Q?77Ql+3hkS5WzOAHYvCgqcLkv209VOEnjxLgKoE+4kSLgveEHqBek/DS3PdGT?=
 =?us-ascii?Q?4pK4zDHBcZYiu6cJinOjEQTzy6hX27wlXTNSq/1S8crl3jZTxsTGZBOHBJH2?=
 =?us-ascii?Q?hMBfUs9YFn55kKyTkJxec42Nw/RdRxFzYE9srqFpiw9T5KPShQeVrAqcQn2x?=
 =?us-ascii?Q?lynhWCvlwsZIoeAa4XYGsB4Xo2CAP/2qTMq9O65RltUqUaghvOzK+Qtn2KcF?=
 =?us-ascii?Q?EcxFZrQ3Oi0EMVbMXxg/Oca9eOGKRTVz2JhGd5jSUZ+MH1XwcNcze6IQ0VPW?=
 =?us-ascii?Q?rCnexetdGiJUmJdBOP0QNMw2sEKI6U0hF0YYBsgBhjkASr5YDWX3hMgdCv1W?=
 =?us-ascii?Q?TS6DAYozwqOc+m/qqJSmSZdmbbkOr3/3YrQYczLnzMRxq76sg6knKtRK/E7d?=
 =?us-ascii?Q?r5d16CZjRFEURp3fy/oiYldEt2QvmgIg4oJH+uh+S+e6AOjjkJOt11pdgbKo?=
 =?us-ascii?Q?7uFUJOfS1SXs1+dufOs3w2upPV7Qtqs441k2QDmx9mnNOpIbqIchSPvr6vB3?=
 =?us-ascii?Q?orftwwDOcvtZyMswkHMVkvgojBJNFZtZGhgWF3aCimIVWOYlhqV7RLMJkHxx?=
 =?us-ascii?Q?MZTwkvzbvtlUVAxwMk66jWXLcT7rYpQ1faho7h4cpJ6p5yFxk2tFAjIzHnFH?=
 =?us-ascii?Q?kPAqucZjLCiokaiptgCh4x8g1mIRiwv/3A3kyrbxWG7ME4GQ6YafUChd9Lr3?=
 =?us-ascii?Q?5fUhZ5yItGd0/M9njV7o+Q/8VZLMlFGVN1/q5+L5ubIs8dQWnJsag5N/mbPj?=
 =?us-ascii?Q?b74DtiA=3D?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <4A532488E7918B44A5EBF9FFE8FB79C2@namprd15.prod.outlook.com>
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH2PR15MB3672.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 90e3f24c-1efa-4788-a297-08d8fba06035
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2021 21:42:29.8723
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: i9sMna5I/cFUZdQVV+rRDD/qc4eWLI9oXfLw1jNEjg6XwoM90zG5KT97mrlH/2Ru
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR15MB3558
X-OriginatorOrg: fb.com
X-Proofpoint-GUID: Hqfc0t5zslAw7SmqsnRbjtMQ_5Z_PmPd
X-Proofpoint-ORIG-GUID: Hqfc0t5zslAw7SmqsnRbjtMQ_5Z_PmPd
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-04-09_08:2021-04-09,2021-04-09 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 phishscore=0
 mlxlogscore=950 suspectscore=0 clxscore=1011 malwarescore=0 spamscore=0
 impostorscore=0 lowpriorityscore=0 priorityscore=1501 mlxscore=0
 bulkscore=0 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104060000 definitions=main-2104090157
X-FB-Internal: deliver
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Apr 8, 2021, at 8:09 PM, Miguel Ojeda <miguel.ojeda.sandonis@gmail.com=
> wrote:
>=20
> On Fri, Apr 9, 2021 at 2:20 AM Nick Desaulniers <ndesaulniers@google.com>=
 wrote:
>>=20
>> Quite a few other functions are declared in a header, but I don't see
>> any existing callers in tree.  I wonder if the maintainer could
>> consider cleaning these up so that we don't retain them in binaries
>> without dead code elimination enabled, or if there's a need to keep
>> this code in line with an external upstream codebase?
>=20
> Yeah, the equivalent cleanup was done upstream by Nick in 2018 [1],
> but there has been no major update to lib/zstd since 2017.
>=20
> Thus a cleanup would actually make it closer to upstream, which is the
> best case scenario :)
>=20
>    Reviewed-by: Miguel Ojeda <ojeda@kernel.org>
>=20
> [1] https://github.com/facebook/zstd/commit/f2d6db45cd28457fa08467416e853=
5985f062859

This looks good to me as well. I have a patchset up to use upstream zstd di=
rectly in the kernel [0].
That will allow us to keep zstd up to date. And after that lands, I hope to=
 set up a zstd linux tree
to make merging patches into lib/zstd easier, since over the years quite a =
few have been ignored.

[0] https://www.mail-archive.com/linux-kernel@vger.kernel.org/msg2532407.ht=
ml

Best,
Nick Terrell

> Cheers,
> Miguel

