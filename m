Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D6EE2318B9A
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Feb 2021 14:11:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229849AbhBKNIl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Feb 2021 08:08:41 -0500
Received: from mail-eopbgr750071.outbound.protection.outlook.com ([40.107.75.71]:36930
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230239AbhBKMqb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Feb 2021 07:46:31 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mYPhFMqYU7qkg8kaQpTd8vJr4fakgvBUyPYMCb/lj2U3IHw1lK4aJeBKH1n61DHRj+aE4EaZWbt7RAq7bVWLIgMnZPRe5cOxDuTMrcAkDbTe2FefsRNxDpkbyO9hXHuUVvU0TRJZs3gNYX+sCJFa8bnVnf94nW9KCBX7PSCwKEWE0k5jFyWzOac4vwu3LExTwffUczly7erf9ya8o9xfZYXFVYytkO80nZZoKL/i32g7lbU1jWGFPse1UylyKYhuDTdkqUI63JMvqL8DTqfqSkIFsiIi/em8f1fYMHDk6QzmOOLkbUXco6LC5otJQkQ8dpgGQt0amzQciBg5VprNlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tDkX5ieog/iB8DVOYUhtghsOmVLZvTIisa1jXCFnokY=;
 b=SL/ddYEBkJK7K12UT7PqVOP1UpH4LZr498b1tVinb/qgBZy0UvHp91Rh2CTW1hb1iShXtQq+6gGXwEm5Bowz7A+hTJcjWp7IOPqi+mhWp0H4kCfoZ8uvWe+SwZrPkoil8A6LGMAKyUUfVMgH63sy33VD52KlGf5IT57voSP25pwyTIPzo3UJRylbu1M/tFcUP9IA6n2ofyoaTNoFZargfGdcaf6Vvzr/3p08Hcf8G8YfC+fCsHaFMqNwlosJPShlcTBvpGr0D/lstNN2boAh80PVYS4Wq40IRc0nKSl3X0jnzut4x9EgNHt7pB7uSWX46XZTgsprzXX9YAW5Oa4r+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=silabs.com; dmarc=pass action=none header.from=silabs.com;
 dkim=pass header.d=silabs.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=silabs.onmicrosoft.com; s=selector2-silabs-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tDkX5ieog/iB8DVOYUhtghsOmVLZvTIisa1jXCFnokY=;
 b=jdzwxGylDD5Z0LGMqHuJJkcffeInqFxF85+/fw/ckRkf+HWWVmKtZ2LMIF6tnG8sCqbBiKQa9ar8Q7rDtWKFtjat+cZW48+Z20xWAtapzKcPpzAXeQEDZZF6yLbNNt7G+w2atJ/wU9gDQkjkRObYUvcacvAdvyWw+dUfr3hVBac=
Authentication-Results: linuxfoundation.org; dkim=none (message not signed)
 header.d=none;linuxfoundation.org; dmarc=none action=none
 header.from=silabs.com;
Received: from SN6PR11MB2718.namprd11.prod.outlook.com (2603:10b6:805:63::18)
 by SN6PR11MB2558.namprd11.prod.outlook.com (2603:10b6:805:5d::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3825.30; Thu, 11 Feb
 2021 12:45:48 +0000
Received: from SN6PR11MB2718.namprd11.prod.outlook.com
 ([fe80::a989:f850:6736:97ca]) by SN6PR11MB2718.namprd11.prod.outlook.com
 ([fe80::a989:f850:6736:97ca%5]) with mapi id 15.20.3825.030; Thu, 11 Feb 2021
 12:45:48 +0000
From:   =?ISO-8859-1?Q?J=E9r=F4me?= Pouiller <jerome.pouiller@silabs.com>
To:     gregkh@linuxfoundation.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org,
        Muhammad Usama Anjum <musamaanjum@gmail.com>
Subject: Re: [PATCH] staging: wfx: avoid defining array of flexible struct
Date:   Thu, 11 Feb 2021 13:45:43 +0100
Message-ID: <6775209.aHiZMU1OZ3@pc-42>
Organization: Silicon Labs
In-Reply-To: <20210211105026.GA45458@LEGION>
References: <20210211105026.GA45458@LEGION>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"
X-Originating-IP: [82.67.86.106]
X-ClientProxiedBy: SA9PR03CA0027.namprd03.prod.outlook.com
 (2603:10b6:806:20::32) To SN6PR11MB2718.namprd11.prod.outlook.com
 (2603:10b6:805:63::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from pc-42.localnet (82.67.86.106) by SA9PR03CA0027.namprd03.prod.outlook.com (2603:10b6:806:20::32) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3846.27 via Frontend Transport; Thu, 11 Feb 2021 12:45:47 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0b6de5d0-7124-4e4a-b199-08d8ce8af4cf
X-MS-TrafficTypeDiagnostic: SN6PR11MB2558:
X-Microsoft-Antispam-PRVS: <SN6PR11MB2558E95A28EA144E215900AA938C9@SN6PR11MB2558.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4941;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7yeqX1AmgruyvYWHHh4SskKA85z8v6a7aM4TY3Rd9KYlXs5OzjDBjJmcVXy+iQmEiA74ag++F6DZQ6ydexY9WgnyMtZ9G6wLvkQ7byGKXS5S2NrQXzPOxcYoz96QgPBYmubMjzGj1xtAfYXS4sTwmBNdrcFZWO1S6LKoc81hH1nHliOMt5XZ+ZWuP0rh77yzjHrHS+cxB3Ny2d4YpDGedASLkVz3RBUldU/tugLDYisP8hBkVpQkIwhS8trKLB0yOwc2O5Q5Y4zl4uhJi6ulJZndcorA6vHGMOvBVvFzUu0+FGJxjz/rmwhBbkZj3gW1KR9Do2jp6uJvek+LISKHmXPzETkx9LsxW9jb0+L2ntzsv2Qf/YD8vkB1CAHQxFMJtEnj0CR2bmneVjUoVdyD5bqDKMPdlr+zQPPaN/nzJmpTgGyCsG+ROenqKdW2cVFMDsDltyh8KwLJ5zCfYvqwLMi1J70we4AcvPMlvKk8QCn9QoizzVf3tkVbtr9KFH39KgU7lmqL5uvOtKHufg1qZIFtfiPpMDIF2wBKcVXdeoCYhh9814A6PEsGppe4Hhec+qgCllwgmZ1HF5eDhScSZQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR11MB2718.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(346002)(376002)(366004)(136003)(39850400004)(86362001)(33716001)(66946007)(478600001)(52116002)(66476007)(66556008)(36916002)(83380400001)(66574015)(6506007)(8936002)(26005)(16526019)(5660300002)(186003)(9686003)(316002)(6512007)(8676002)(2906002)(6666004)(956004)(6916009)(6486002)(39026012);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?iso-8859-1?Q?mpYuUrk6oz3fWaJlgzVEvM3JICrtv9U+M/dWWwFptAviTxw0ylrraWknan?=
 =?iso-8859-1?Q?AMMi7CmTRY2wsqubsW+DlInevYw3B1q6EUOndtoL2j1NUbxvXDUTzh9jUc?=
 =?iso-8859-1?Q?U5rrSer1r1u4RkqaGBk3wYbyLbEN7HLcgpyVrgc03CXA3/RA0XxKEZVlvN?=
 =?iso-8859-1?Q?xFz+3y9lGDyGRnRkCkX6Xu8GPaoO3dCUTGjlpoDg4JHIh/qmW586ensIeL?=
 =?iso-8859-1?Q?fznl5Vlj+ubBVVZOL0L1FB59gDZYrN82UKieZinASgKy7dfbc6my7v99GX?=
 =?iso-8859-1?Q?pj+fY+qn1SfKZ3lNt12LmrEjtzB/szq9H29O7l8OW6F6tIsS5feRW5SDwx?=
 =?iso-8859-1?Q?fX33qzuJ12WkNaBhexfb66h9PnvlcTL6kz2skRVNJhBIj4YaX8pUQfwDKH?=
 =?iso-8859-1?Q?F6oXfp1RuyFp0C2wPcG1yoko+5iIdAh8ht8ffZKfb8Dd5HJPVkHJ/VDho2?=
 =?iso-8859-1?Q?s/UqQkJB8sPCLotz10Pitrk+SHruqup054PyG/2POOupL9aJkRIrHzHCBY?=
 =?iso-8859-1?Q?QaxoqoMuQuX8mdPFCpsbksaP9bwQbpnY7Qd1TB8j3uzSs+oxT9TVeWxxtA?=
 =?iso-8859-1?Q?2MHwbwwrafBmZILcafZW7ceUYiHzuhVmbpu/nRVlyDl9bhb/868QW4EBFN?=
 =?iso-8859-1?Q?+QdG7+df+DTYR1NYmNqxpU0Fs81dm2sz+4oHLX2H6eXc5wPEinPgBPaeQD?=
 =?iso-8859-1?Q?GeW4sz7Mh1sokcxbJqwhhdQouABvm1Qm3CSTDVTDCOwcQWOG9ZCNUfwYN/?=
 =?iso-8859-1?Q?rNXl9Z4GIN7ctWqoDFFS/zyAdoqMIgJCpD1OSn7f/BGYRjhOk4FOzHOqt1?=
 =?iso-8859-1?Q?Qpf1sdr19cjRBDpDYYGzDn+X78fOCnnPerYNGwHxFp71YDFCqVYVqVRuDe?=
 =?iso-8859-1?Q?1e6+szHo6dF/QPNFzh5E8j9PZSHW1P1t2TYfw/yLPA1Yi25tw65YrNK09Q?=
 =?iso-8859-1?Q?RpeFcpSJ94W9VaaWoFPx3+Fnfx/zJGKXKoncRZsS9vePYT65BXJP/at3S4?=
 =?iso-8859-1?Q?3D8/6PHfqxJwjvVk1lVqb60C7hn4jhDwOamZ7ByS1AuBycaoLyRjCi9NTm?=
 =?iso-8859-1?Q?gF1dDX6kM2M4XLutGVoKppqdST7AXqaQrvrLHsoHKZzq3O/vuhIWbOLcMf?=
 =?iso-8859-1?Q?YSklQctGXc/SO8Av+J6PmiZMO67jeMEVmrgEaPrpRoGkO6CxC6qmRUQJWp?=
 =?iso-8859-1?Q?4o+xvN6R1qYD2u8xZcu3JXSig7FaMGPfRptt9PqoIVB6v5pt24N/sPTenG?=
 =?iso-8859-1?Q?ggaEcUcbUO81exaHaUyI1nwd83irONAQ571UPJU2fUmjiYdN5De9Q+OTJW?=
 =?iso-8859-1?Q?Jv2ES91GWP0LHrI1MpJ/QDx+GfkCaQE7viWn26T2RKuRKwSUMBdT8WFlFy?=
 =?iso-8859-1?Q?Qf7ZTMY5k8?=
X-OriginatorOrg: silabs.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b6de5d0-7124-4e4a-b199-08d8ce8af4cf
X-MS-Exchange-CrossTenant-AuthSource: SN6PR11MB2718.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Feb 2021 12:45:48.6203
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 54dbd822-5231-4b20-944d-6f4abcd541fb
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aTPLa4owwoE/7YNoOb5XggEDXTvD6CGyAHba1lAbjueF/+s5kyhw2YvLySQe0kEr8EybZF1RH0hrDSIxDtEfHQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR11MB2558
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 11 February 2021 11:50:26 CET Muhammad Usama Anjum wrote:
>=20
> In this particular case, the struct element is already flexible struct.
> Thus struct element ie[] is ambiguous inside another struct. The members
> of struct element ie aren't being accessed in code anywhere. The data of
> u8 type is copied in it. So it has been changed to u8 ie[] to make the
> sparse happy and code simple.

You may also mention that the driver code does not care of the type of
the ie attribute. It is only accessed from one place with memcpy().

>=20
> Warning from sparse:
> drivers/stagingwfx/hif_tx.c: note: in included file (through drivers/stag=
ingwfx/data_tx.h, drivers/staging//wfx/wfx.h):
> drivers/staging//wfx/hif_api_cmd.h:103:26: warning: array of flexible str=
uctures
>=20
> Signed-off-by: Muhammad Usama Anjum <musamaanjum@gmail.com>
> ---
>  drivers/staging/wfx/hif_api_cmd.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/staging/wfx/hif_api_cmd.h b/drivers/staging/wfx/hif_=
api_cmd.h
> index 11bc1a58edae..58c9bb036011 100644
> --- a/drivers/staging/wfx/hif_api_cmd.h
> +++ b/drivers/staging/wfx/hif_api_cmd.h
> @@ -100,7 +100,7 @@ struct hif_req_update_ie {
>         u8     reserved1:5;
>         u8     reserved2;
>         __le16 num_ies;
> -       struct element ie[];
> +       u8     ie[];
>  } __packed;
>=20
>  struct hif_cnf_update_ie {
> --
> 2.25.1
>=20
>=20

I think that "#include <linux/ieee80211.h>" is no more necessary.

Else:

Reviewed-by: J=E9r=F4me Pouiller <jerome.pouiller@silabs.com>

--=20
J=E9r=F4me Pouiller


