Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8DBD9340785
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Mar 2021 15:13:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231548AbhCROMy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Mar 2021 10:12:54 -0400
Received: from mail-bn7nam10on2078.outbound.protection.outlook.com ([40.107.92.78]:2342
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230448AbhCROMj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Mar 2021 10:12:39 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QHRNz5dMG0yGaEiL8bWLGVPXuzfdcMWT6R4qQ4+Lyw+cT9/A53LkPcuFsnwyIjMcpjKyFblRHcJ46JsNlRPmZm3yKUVykMsDoK5UGsoqFi34FUnS6PUI46gr2iB952VxbU4TfuVHsnRdcZDOl5aedFAkk1DvgliH3enzGMJrpZukXFNQLbbpong5JpCKL9roSNcchs91QrCpj+T0XF0qrar+/HzKhvnHiY+Oknndt16pX/8X2YbhXP3HNk3LYTcWcBTU285xK5cMwv2QJQJdG5/LF4MRVs+eeMgEGF8ykRtuIp3SIyX1S+BmrSyExZd5QM8pI5udTeDhfCnA6YrOiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EtCLUQQFxD/SHFXFTYmWfQkvrTTLU/jWDVFJjM2VyB8=;
 b=bkKT4ffQJqv0B1VzibhtFZzewCFGvdmdCeQMdaCCZAzwteJS/QgStiGb9hm8wo8hJdSR0rzsw6OGRqaxx/PrYT8knj41fSms3BCb+193eAUS1di4Ny4n3YYhIQrhUVouPXPf1FbY1M3AKvQBfybJ2k248OlFzsE+SGPqCaW5f2FFflcZlTQmRUpdB59/MsVIi3+Rk4WjM+SDC5fPQj3WFFLlU4sYhAJ4vaMaghuaOU4dYpIvGrz9jvRK3hUCb1uZs3g+rQfYimNmcw4QcwkQPiDSJrm6V4I3qBbY2LxfSIlKqmKWwgdlUH/IqU4UYCp5sUWYsrrRgGyKKZ6NBhNqMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EtCLUQQFxD/SHFXFTYmWfQkvrTTLU/jWDVFJjM2VyB8=;
 b=JM9mO6jPOFNYfVSutONF8WR30A4Ln1eo9dvV7NCvcyO0xmAQf04wFgtrt25nLbI+OxOPX6hpFNISK+dndlZ2CgZf6hTSG04NyxmF2pp1OVWEs+GY6R4fQOhVovmeu1VNDYLAoDtJZ67V03bBW9/qyqcn7TGAwUcUwkit/jViv0J4AwKQA444EiqF74k3jpGV/viRfzX6z8mx43IpkB4462VtJkylQ4UuBTGfq0OJ5NtXnZ6yTGrDiXuEn/huV96GubJFoTflzH6vrxKadf+yUwkrWOXCJq3mF1So404mNpOTPEkAtOrmlfhA7W+iVLGDrYYtN8sRFWzGs5UHolLZuA==
Authentication-Results: huawei.com; dkim=none (message not signed)
 header.d=none;huawei.com; dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB3823.namprd12.prod.outlook.com (2603:10b6:208:168::26)
 by BL0PR12MB4721.namprd12.prod.outlook.com (2603:10b6:208:8e::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3955.18; Thu, 18 Mar
 2021 14:12:37 +0000
Received: from MN2PR12MB3823.namprd12.prod.outlook.com
 ([fe80::a1b1:5d8:47d7:4b60]) by MN2PR12MB3823.namprd12.prod.outlook.com
 ([fe80::a1b1:5d8:47d7:4b60%7]) with mapi id 15.20.3955.018; Thu, 18 Mar 2021
 14:12:37 +0000
From:   "Zi Yan" <ziy@nvidia.com>
To:     "Miaohe Lin" <linmiaohe@huawei.com>
Cc:     akpm@linux-foundation.org, willy@infradead.org,
        william.kucharski@oracle.com, vbabka@suse.cz, peterx@redhat.com,
        yulei.kernel@gmail.com, walken@google.com,
        aneesh.kumar@linux.ibm.com, rcampbell@nvidia.com,
        thomas_os@shipmail.org, yang.shi@linux.alibaba.com,
        richard.weiyang@linux.alibaba.com, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [PATCH v3 5/6] mm/huge_memory.c: remove unused macro
 TRANSPARENT_HUGEPAGE_DEBUG_COW_FLAG
Date:   Thu, 18 Mar 2021 10:12:30 -0400
X-Mailer: MailMate (1.14r5757)
Message-ID: <65A90582-1A54-45DA-BF22-A9E0FC612CC7@nvidia.com>
In-Reply-To: <20210318122722.13135-6-linmiaohe@huawei.com>
References: <20210318122722.13135-1-linmiaohe@huawei.com>
 <20210318122722.13135-6-linmiaohe@huawei.com>
Content-Type: multipart/signed;
 boundary="=_MailMate_2BDB6A74-BE34-4B5E-8077-5762AAA82290_=";
 micalg=pgp-sha512; protocol="application/pgp-signature"
X-Originating-IP: [216.228.112.21]
X-ClientProxiedBy: MN2PR08CA0017.namprd08.prod.outlook.com
 (2603:10b6:208:239::22) To MN2PR12MB3823.namprd12.prod.outlook.com
 (2603:10b6:208:168::26)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [10.2.54.46] (216.228.112.21) by MN2PR08CA0017.namprd08.prod.outlook.com (2603:10b6:208:239::22) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3955.18 via Frontend Transport; Thu, 18 Mar 2021 14:12:33 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d9bbf67f-cd49-465b-2add-08d8ea17e254
X-MS-TrafficTypeDiagnostic: BL0PR12MB4721:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BL0PR12MB47210C21DD854AB04FA01995C2699@BL0PR12MB4721.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:144;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LuNjPl51KadvbiY/WURgCh+9bun+ht8MbhPSeW+2G0EAzblnJbmsRU7NkQ8kYWZTPP9wj4rxAfzJehlERyruO9sgeKDbUfzIaKTBRWrqWrdN3J2NE0RhpxEiQBKeLakWwE9IPM/XoCvamwUFNYxmUf7yUQQ2/hTtYlogIg94lcj+7M7nh8FU5xtwufoQlMj095USRcBvrt3VittoVNvvGzS7FXNrcaI17rCGz8Sr/4ZGXYJICNf+YzppT9JKrAHTu5btbM33WsRIsA1BbD7F1QaJz6eJvmJoOFHCHiVrmPu44LJKHlLpTv8f2TT604jsD67JrhvK/NEfc6sNDVozqS/kXYtVrdWXiDVKgA7STmJ1UGE+CL49Xq/3wgtw3DMSd65z27+gxRCc+ggR2LeLuCr3qZzkPKey3I7mY5bPDOidVDyswLjwfx9GpBzGVh7qXqsTc9nSGvGneAif9HQZNCYchQV+ylvATDhn38v1I2OArTidbVJinB36E0lz/llzVhdEsGyUdppHgV6/E4hE8iUGxTmsfV7mjuxxhyuehtqSRXFq8ThgH2CuJK7rKqi/qDO6qPHUF/Yzy9mWnb/+JHEqBK9q8Pw2P17efpunA1H7bifDiuIESHGIk3Xs7T0q2Mv4g2YmdXWrjEVaoDWpusFBt+SgB7vRVMXn4xQ6P/fjWRkcXNcAJ6okzw6Etkgc
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB3823.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(396003)(136003)(366004)(39860400002)(346002)(16526019)(33656002)(53546011)(36756003)(6916009)(8936002)(6486002)(8676002)(2906002)(186003)(2616005)(83380400001)(7416002)(38100700001)(86362001)(316002)(26005)(66476007)(478600001)(4326008)(66556008)(66946007)(235185007)(5660300002)(956004)(33964004)(16576012)(14583001)(45980500001)(72826003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?QmNkY1kvTmFmczNYYTV4TUFuSlF2aGFTR2g0dlkvci9OTnBtTm1zYkxiVnhZ?=
 =?utf-8?B?Zy8zNXJBUHc4V09OMVcyQ1FMRzd0MDBFVjNjV2xjQjh4cjU2aHRVd1FRSUxN?=
 =?utf-8?B?cXhiem81MTExR0VBWHZ0bk4xNFRub0RxTUtSMmU2WFZkR25VclVpYjkxd2ZT?=
 =?utf-8?B?d3pHY3BDNVp5SnR0cmtHcG5Zc3FNZmFRb1ZpaW5ybzdvNFJDOTNDVlZLWlBM?=
 =?utf-8?B?WXhHRzZzUmp0N0ljeXd5THZxeDd2RWtLeVdSVC9DQXV1QjV0M29sdzdNYXRG?=
 =?utf-8?B?N0hEb2I5eXZQS2M0RlhXT0FkSGNpcDNzSk13WEJGc3M2Zk15YkFwNytvZGFR?=
 =?utf-8?B?a0Q2YjlmL2cxMjR2c21QZ0pYQW5QNUlZMWdicXQ1MEREdVhyN1R1dTlTMnZt?=
 =?utf-8?B?SmQ1ak9ZVWJLQ0pBSkpqQUVyeUFJcjcrOGIyaW9DZ0dFREFTMHNqd01HeGow?=
 =?utf-8?B?aXlvY3hZeUl6RUtqcVpRQk4rZFA5Ukc5REtKUVBiMTBZMnZyOWFsYkZhQzh5?=
 =?utf-8?B?dGVVNzZMM0NSVUY1cUlibzJPMGRNYVI2ZzVRSDRYUFN3U296V0pFc3cxNmpG?=
 =?utf-8?B?UmdkQkNQVjN0bW8xRDNxaFA2K3BVNjZEV2NVMXlPRy9yZ09odmhEdDZUQ1lF?=
 =?utf-8?B?OGpSOW9TZnhJN2owK2JxbnFPdEdPejFKMzc0Um4zcE5TdkhSWFBPbWhnZVN6?=
 =?utf-8?B?MzFQVHVVS1RsUUZnNjF5eW5JbzN6S3QvRFJrNlRvcWUwTlhYREprTFlrWFRH?=
 =?utf-8?B?RERwcXlKYXNQMTRIM0c2ZktKUTlNSUxub0VEYXViQldJRXlXSkZHdzc4SXdu?=
 =?utf-8?B?d2xuY2lkbnhGYVgxQkdsK1Q3dkVHSGE4KzJlU1FoZG9YbWZwMHU5bGJMRE1B?=
 =?utf-8?B?MTNiUXdlMEY1UStUNGVobHJpL0I3WEVwMUN4VGpYQ1J4OU82b3NJeXUvR0FJ?=
 =?utf-8?B?WUdjUEhnMTNCWUFJOFI1dDdyT2NrNGZUSnRIMmNTM3YzOHlDRTlWS1pJNlI1?=
 =?utf-8?B?VE56TFVSc1JabGd1anAzaVZQcXhSS2FqNkJubHRaQkd1QmJ4QnBhUmpDc2po?=
 =?utf-8?B?YTltUUVKejJvYldSbzVJb3ozNnVLc1ViOGViV1F2amlwYldlSkU2cWFuY2hG?=
 =?utf-8?B?ZmN0YW1PN1psa0wzRHMrL0pQOXlSWUw3ZTAwQVFxK0VkMFd6S3BteEo1elRn?=
 =?utf-8?B?Z3Z5UExwdzdXM0laUGtLUGRacXRka1B0SkkyMU9JaWZSVVdPV2JzckZKQlVS?=
 =?utf-8?B?ZVlRNndZSWQ0aHhtdCtzSU4xUFRRNjVXeUhhTnBWUXpyTTRDTG4xTGJsWHpP?=
 =?utf-8?B?bGZCVkJFZjlHSkk1OFdXU0VnMGpDR0RCdVlVa3ZHaDVSZ3ZLQ3NNUUlSNDJC?=
 =?utf-8?B?YjkxaU8ySEhmRklnUWZIcEV6ZlZ4bDJHMVNaYmQ1citXYVpkaHFlbTd1cVUr?=
 =?utf-8?B?TUlsU2xhY01acFFRYU5nU1RkNUlVQTBvaXVyN0hLdTlORW5KeVBTVzZ4bDcz?=
 =?utf-8?B?SWNPbFdTcjNnYUFISDZBam00eGl0NGplZjRCdFZmK2JDejlBa0NLbmtvcWt0?=
 =?utf-8?B?V0pDdHNOL2hNNERFbWNqVVQ5MCtVL3dZMDQxekNGK2kxSldLSjlvakdyQmY1?=
 =?utf-8?B?eE83N3YwN3ZIKzNSbmVrSTNyeVVLdEVwb2ZGSWp5UTE5Um9uVFNXK1NuamdI?=
 =?utf-8?B?UitmQXZHcmVrdWh6UEN6ZGQ0UkxNQlBSMEZuTkpEYzdjMEtDR2lwemtaOFd5?=
 =?utf-8?Q?lFFLywlw8A7RnLJEHQjfIe7VJe2Co4nmGJ41XCJ?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d9bbf67f-cd49-465b-2add-08d8ea17e254
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3823.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2021 14:12:37.7867
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JCg8DzQIdOMZh80/fXd38AwDCnToqTJPzRL//fcWDVk6GG1RIyw1WZaickkmLf/I
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB4721
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=_MailMate_2BDB6A74-BE34-4B5E-8077-5762AAA82290_=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On 18 Mar 2021, at 8:27, Miaohe Lin wrote:

> The commit 4958e4d86ecb ("mm: thp: remove debug_cow switch") forgot to
> remove TRANSPARENT_HUGEPAGE_DEBUG_COW_FLAG macro. Remove it here.
>
> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
> ---
>  include/linux/huge_mm.h | 3 ---
>  1 file changed, 3 deletions(-)

LGTM. Zi Yan <ziy@nvidia.com>

=E2=80=94
Best Regards,
Yan Zi

--=_MailMate_2BDB6A74-BE34-4B5E-8077-5762AAA82290_=
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename=signature.asc
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQJDBAEBCgAtFiEEh7yFAW3gwjwQ4C9anbJR82th+ooFAmBTX84PHHppeUBudmlk
aWEuY29tAAoJEJ2yUfNrYfqKVDQP/2k+/vJxBtnAHUZsEx5lxIlCRQ1TMwdZfQcq
6RJP+YRhxMehLUNMy/sPmNY0zq587NH8YuPChOm5Mt0TopdiZu4qAcgEu9ouuZDB
knsS5HBDOWn8xU8elJECoDIwWUm/Ilc3YcC4eQCGiOGBN/kN2PPr387p6o60JWea
AN+qVnDJp9dzer3EbtuMKgLkhpd4h5/oTGGBQ/Ji5mmvE8IXD0gPHuydxALmOVIc
e6EE4NZPCKUCqSeRlE3VHDfBHNF7g1ORm32/++v5FpjdhfSRq/eJytlHwWcDQOHz
fMQTEg9iqfDTeY2Lbg1q+OdWtfvOIykRiZkc6BI8L+oW1DrkDhIyTbYUh/U7+mnp
A3LiyADrT46Vu541pNsZFmbSwxZUBdNDUGzvi302WRuwwa/xz5zPGvKVy3a3HecW
PDFc9qvSLevBDfLWaygvvMDqY1x4mZq5cDS/ebIlVMeHqoeDZWYKtDpazmFDZv60
mEmWKQckmhX9bzTxjxV/s6ydYvp08YchdHb5Jmjsni815ss3JOEjgGWOrGncst8l
jOz5RAHWMtWvz1AcD42WUWIV/fjW1YEjhjYF6UVP6yn1Y5UW+o9wNxHso7uvqQFR
zrYiddrlOY6ufFH+gXxKiXSbCT6NhaKtT2e++U7MQREjw7Sgy3fH7ObclNndfbXM
MHkDsExu
=zcYX
-----END PGP SIGNATURE-----

--=_MailMate_2BDB6A74-BE34-4B5E-8077-5762AAA82290_=--
