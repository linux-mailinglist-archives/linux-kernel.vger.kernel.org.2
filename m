Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8703334075E
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Mar 2021 15:01:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231268AbhCROAw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Mar 2021 10:00:52 -0400
Received: from mail-eopbgr750043.outbound.protection.outlook.com ([40.107.75.43]:64135
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230119AbhCROAl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Mar 2021 10:00:41 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BDesDdaIw0NoxUEoWhOmNVVXeJIInHJZuXr74m09aEcsP7Hkwht91LPRVUz0Xt/jpOPZOKxze7UFEYZpRbM6fSkl3KzD/XG1e2/tFaModJxy4EC9821yOn36vAejLeHUYySANdzdAl7HADM20qxt11NMAhKC0yXxhgDplSyjLSR2D/gnB/frReqGvMTKXG536F/LpIyxNPt8s3mZnoIQxZTRo/dtjubbRkU4corIuxIiaLOtn9R9rDyFxBbeG/A8a3KiAqukeJBG8P8HdGt59uriD8O8d4L4yfGg/I9KecmSzfL8ujAAbBMN2p6ZENvZDRIBeVA2txwo9MXG7TNchw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v3WvHPZ++niBmmke5B6UfwVLfn4wbmk0qsUZvmKDkGI=;
 b=J4fKyKH0XGVoZ2L7h5frjUPu9otVIgqthnjcqFh7BftAm5HLbCqJLjR+Jk9Xqh4Zc6+bhhtVIKGhqbt8LPTnNKeqwbE6NpLldeDx4dHc37ht8wCvcLTmEiqGPOkONqcyymtG964fD1/EVkevueqcg/xBli8XnfQcvmUYUOcnHMyX31I2hTy0307CWXI5Mfcinr4DeesKY0M9QbkhtLAalHIQ+SGtaDRYVEFs3Qn+2o6QA65geafmNq+F6svmt4AM1ixplExzCutDT01r+fVvbQa5G84lUqd0pzph9nBw1EEt5M16NQyMVXguMQ2Qe3I3n7xmWyVUsVVATeSlQCYXfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v3WvHPZ++niBmmke5B6UfwVLfn4wbmk0qsUZvmKDkGI=;
 b=TCzuBOqkYKvcyvsGI/bTMD0HqZiIx0QCk5BcGPtskhQbNHU0t5eA2MQtzDA27/fJwuiE55b7ahQwhKwMb8UNud61HjMnvdKV6bmur3xCuxbFcx6N0YBD9DkNNqoitWzHNAciWnAXD9JgdTQGC12DnXYVukSv/CIAnPPSqvgSnAPRv8FhjE16XWqspK9JFGbQTJp9eNFI1Ez6/aajxQSigOwZIt8B8og9bH9KLOSVs9fYtLOM+0tFSWGduKr6Y2KjCHsrOVZaFRIngyYycnd2OkJaB65VlFwXhxW7eGYMugJRSzSQc1Z4fkJo5hqbMs5gnVQEz4cpORn1UCrkG6XN2A==
Authentication-Results: huawei.com; dkim=none (message not signed)
 header.d=none;huawei.com; dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB3823.namprd12.prod.outlook.com (2603:10b6:208:168::26)
 by MN2PR12MB4079.namprd12.prod.outlook.com (2603:10b6:208:1d5::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3955.18; Thu, 18 Mar
 2021 14:00:40 +0000
Received: from MN2PR12MB3823.namprd12.prod.outlook.com
 ([fe80::a1b1:5d8:47d7:4b60]) by MN2PR12MB3823.namprd12.prod.outlook.com
 ([fe80::a1b1:5d8:47d7:4b60%7]) with mapi id 15.20.3955.018; Thu, 18 Mar 2021
 14:00:39 +0000
From:   "Zi Yan" <ziy@nvidia.com>
To:     "Miaohe Lin" <linmiaohe@huawei.com>
Cc:     akpm@linux-foundation.org, willy@infradead.org,
        william.kucharski@oracle.com, vbabka@suse.cz, peterx@redhat.com,
        yulei.kernel@gmail.com, walken@google.com,
        aneesh.kumar@linux.ibm.com, rcampbell@nvidia.com,
        thomas_os@shipmail.org, yang.shi@linux.alibaba.com,
        richard.weiyang@linux.alibaba.com, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [PATCH v3 2/6] mm/huge_memory.c: make get_huge_zero_page() return
 bool
Date:   Thu, 18 Mar 2021 10:00:32 -0400
X-Mailer: MailMate (1.14r5757)
Message-ID: <65D8C66C-B8A7-4FC6-A658-5932097453F3@nvidia.com>
In-Reply-To: <20210318122722.13135-3-linmiaohe@huawei.com>
References: <20210318122722.13135-1-linmiaohe@huawei.com>
 <20210318122722.13135-3-linmiaohe@huawei.com>
Content-Type: multipart/signed;
 boundary="=_MailMate_17D8B763-DE2B-434A-9907-625CB52DFF3A_=";
 micalg=pgp-sha512; protocol="application/pgp-signature"
X-Originating-IP: [216.228.112.21]
X-ClientProxiedBy: BL0PR05CA0022.namprd05.prod.outlook.com
 (2603:10b6:208:91::32) To MN2PR12MB3823.namprd12.prod.outlook.com
 (2603:10b6:208:168::26)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [10.2.54.46] (216.228.112.21) by BL0PR05CA0022.namprd05.prod.outlook.com (2603:10b6:208:91::32) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.9 via Frontend Transport; Thu, 18 Mar 2021 14:00:35 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 983a40df-f8aa-4407-81f5-08d8ea163632
X-MS-TrafficTypeDiagnostic: MN2PR12MB4079:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB40792CD910651A7DAD1D9397C2699@MN2PR12MB4079.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: L4MFLM+DcP/kM2blkMxicxovuJj+GWAAB+C/HUpwYDoP0IqlMlm6nxBicgjIYYVHAQ8tPcM89B7v/qIWyTaFxgKudM3JxdQulKIhi4TyDoRZubIsQC+WRqbeS27CXg19itHiZB2QC7qR0ub3XtlMhu3lgvQCa3qdYYb2qjnKzXzhbG2+u3q9RSqcWxLwwopg3kbxpPTixOFl5SREGqoSzgbnEbx/VD77PZrlpRFixQ5o0JNAxERQvbN10sEMc7q1To4NIjKjKnQk7CZe9cSw48hvYtr27wlHOjqDu2JVcHrVpL5xh8FPoAoarlIhifC79ABYseLMtMjx3VXm5gcirRlhpNeXYzba263Hac5JjH+FzhSZrb2ezC6LM+PdVs73EQ5KFP2pYbqs8uw5ZYOknautJsbPDM028xD0nIesZEpizjZZ32OPheD11uNi+3G/21si1DDxC0ArfN+qLGiYXBzYSDt3X3I/tqRvv0hYKUk7gtoM0Gl1QIxpHNeRQMcKXrH0luL7Vftw/ykpKh+E4d+4jIYLTJJpw651v2EyOe771nPmHHfohESE/jFNIt6y6rRHO/fegM/cqR2i8RkiEjU+AWYXiiRVpqrrspwsFv52S1GjCj9AHcOXwVcP1zMMitFBjCwjYTDdVj0anmLg9KWnTyU5acSgTGBGRGRQlY6Cg0JhZadV8W7fbSUqlH7g
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB3823.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(366004)(346002)(376002)(39860400002)(396003)(4326008)(316002)(53546011)(478600001)(33964004)(66556008)(66476007)(16576012)(6916009)(33656002)(26005)(7416002)(6486002)(6666004)(66946007)(8936002)(86362001)(8676002)(235185007)(16526019)(186003)(36756003)(38100700001)(2616005)(5660300002)(83380400001)(2906002)(956004)(14583001)(45980500001)(72826003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?WGkyZmllSVR0Y1JsNkhsanFDQnVzZGwzMU12MTcvMmFmSkc4bkxEcE43RXpQ?=
 =?utf-8?B?U1Bod2NEa1BKcXB1VGt0UVM4WC9rVG5TdzI4NEZMZXJnd1U1SXBvOFc4eFdP?=
 =?utf-8?B?N3BCY3lQeFAwRUxQaDZ1bW1IRi9HNy84N3FQblRscE8yNTlENytSejVTZXNJ?=
 =?utf-8?B?SWszRktIZ1RFcUEwSXF1dy92WUZSU3FRZjd1V3pQQStYZ0VSbHRkNks4N21Z?=
 =?utf-8?B?VmI2bTRUaW85OElMMFptTkhVK2E4ZE5BYndYWXFycjFDV3JCRk1yZzczYlN6?=
 =?utf-8?B?WVZLWktqZSs0eC8ydEpKRWhibmZyQ0ZMY3NSOFoyczM5MEttbEVRWnR1VEww?=
 =?utf-8?B?VmZVek5RWFdEb1hmSGs2dFYzN1NTaGRBa0pyOW56S2wrWnFHV29TSVJjMnA5?=
 =?utf-8?B?VHlWaDVWOFpaZTFlZ0RNa0lLZUUra2xVN05qZ2dGM0hwY3BYWkFDWFp1Si9y?=
 =?utf-8?B?YUorSm1QZTB4TSt1TERPcEwyNFhHS096OFk2d3U2czNBMlJVU2t4cU80ejFC?=
 =?utf-8?B?VExkUitSb0dpdGZ2QmUzZll4RDdjcVZUWVBWd25PM3NNOWV4enY5dW5OcXhh?=
 =?utf-8?B?MnpMVnk0Q3lPMXBSYWpWbnB0VTVyRXlybUw2UHdCU1J0SERlaE4vMnRpMWw3?=
 =?utf-8?B?ejhKSDhneGNrYjY5UlF5R0dQYmZJQjgyQjZxZ3EvcFNJSEsxeWtqWEEzVG5r?=
 =?utf-8?B?cVluRS9RRFYzcVEzRlJjeG1DZVZobXFHWDVOUnM1bkVHQzhQTVk2U2Z6blRL?=
 =?utf-8?B?aWtXbXNTQmVtNVpJODlmMXJnMTdGdEY0N3JlWnhwbzBjMnQyWnlSVXdCQXR0?=
 =?utf-8?B?clFaVHZtKzVSSmtMRkZEcUNUY1E5VFM3alRtMzJCb1FPWXNtSEJZbTFOUVVn?=
 =?utf-8?B?Tk5wS0xnZ0RBeHA2T0pNbmdiUGFxNzl6eE51WXlISGJhSjcwZnBsbUVFbURR?=
 =?utf-8?B?S2VlRHg5SU9EN3NRV0czVjJERlFVYW5ETGJNcjF3N0hUZkhxbU5WK2xFZnkr?=
 =?utf-8?B?eDJ2Y1BaS1hYY1dzTi9LSW54RXYwU1FOQURBS005RHhXY1k1dHBWWWZ1bFNZ?=
 =?utf-8?B?UUpYVnVVUmVubkdtQ1djNnRqV0RlZ1ByUDZyY25tQVBMeGhxcHNNYjZNWTRz?=
 =?utf-8?B?OFFKOGNDY1pSNnhzc09vOXVPbmZIamNoK3RWQ2JUbzBDejdtUlVoTG5kV1VZ?=
 =?utf-8?B?L2s3M1VhQnFwanZZZGZtcFVyTytqaXVRT2dISzR5VlI1YkJud0VUY2dvUExP?=
 =?utf-8?B?WDk5NElSTmZXaDhibXAyaEZwdVAwaHFzNk5FNVlmQ3ZjbmgzTFJ4MVArV3h6?=
 =?utf-8?B?YlpZOHpWQTl1MUlBNlNwMEJXdGhjZGp3Z1hrUFlTd3d0cm9xY3M1MGs4YVhD?=
 =?utf-8?B?RzFYZzBzU1dQcWRjd20rVGw1bW13aEorckhRbkM5TUhHc3YwTUdjTWtseEg2?=
 =?utf-8?B?eHp5cXNVSkNJQTJtWEhTdWRwMFdRbFZCbHpnaWtzV0J2UG04VjRmYTYyVVdn?=
 =?utf-8?B?VTlFTUlJWkE0U0xZVzVzOGVZWTRHdTlWOXpoSnVPMFhtNXZPSDVrWXBuUlBM?=
 =?utf-8?B?VGttTHQxUUMzVXdqd3UxVWszTy9meVRiNEVWSTRDeHE5NDVEU3FHZVVDY01n?=
 =?utf-8?B?WUNWUG5kOG54dlY5T3RJdTdzZzBwVHI3aUhjYnNKY1ZiMVROanRxNVZNeUpx?=
 =?utf-8?B?YkdOekpQOHpsVGRxVjU3cVI2MkxOblBScXIyUTFNeWxxZlE3MTZGRHlzTlNU?=
 =?utf-8?Q?IBPekeo+cjVwWul/0J1nVXK6EcflVxL1pTRlKOl?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 983a40df-f8aa-4407-81f5-08d8ea163632
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3823.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2021 14:00:39.4953
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: o4aK9Fss5sgwUGkjyKIZ3O2L7/mFZUoIJZLHBV3iVVn67XTHgG5t7FpF7wXl93Qy
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4079
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=_MailMate_17D8B763-DE2B-434A-9907-625CB52DFF3A_=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On 18 Mar 2021, at 8:27, Miaohe Lin wrote:

> It's guaranteed that huge_zero_page will not be NULL if huge_zero_refco=
unt
> is increased successfully. When READ_ONCE(huge_zero_page) is returned,
> there must be a huge_zero_page and it can be replaced with returning 't=
rue'
> when we do not care about the value of huge_zero_page. We can thus make=
 it
> return bool to save READ_ONCE cpu cycles as the return value is just us=
ed
> to check if huge_zero_page exists.
>
> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
> ---
>  mm/huge_memory.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>
LGTM. Reviewed-by: Zi Yan <ziy@nvidia.com>

=E2=80=94
Best Regards,
Yan Zi

--=_MailMate_17D8B763-DE2B-434A-9907-625CB52DFF3A_=
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename=signature.asc
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQJDBAEBCgAtFiEEh7yFAW3gwjwQ4C9anbJR82th+ooFAmBTXQAPHHppeUBudmlk
aWEuY29tAAoJEJ2yUfNrYfqKW60QAKGA3vf9u4pWk35ElLMg48bTKWVl6b/k3RnQ
43HeWlpIqEIYMtyqmz96HNoUr8QQHICZTNl31RQ/Eh7KPAoWyn7DItRkfQw3Ml09
sSQA9/38DzCJIVvh8EZkq+Kxxc2zYLcKeUlAJDecYmwml4vVA6W1NiepKi4zqcfj
UKSaj2Y7XPT//l2CTLuvHilZ5H6DCugHHgfrlX7Kv4fz7+DUsvOHJMCVhF4YmrWF
YIqf3LKwiXvdbLaPBkZqK9A8PVb+yD9IMjr8QBOezeayDwfER7+QnNUfwP+xTM9F
HLL/Km1X9YJI4a2lMpAsHOQUDnx1IOqTsc0/h+sh86NP3yJS1WBACkBz06oKg15a
eu3OCOYkfI26w3KcWsiYuwg2iGtpf/0Q69bI9zJMxz9tshI1hEFlJ2SG7NGFv+n3
E/W85lJp3YN/hvnZoc0LS871yFFV1EiHFbIYtGNET4gTfWnbnChk8y9dVQOUVyqE
dmeUEdxLix2o+rb4PLXdJsQrSl5iixqi5UZl8hdJVmH6dMeUwGkbb5XohrQwTO9I
DUunGJfr6QDFGn8e9MzpK0jX8MbrT1WkEWmnxoaMWa/2UJMYhXHdu1OJEfV9vmz3
YZFPbIVVFUdl6Eb+sQzTzjUDFFSkwfDs4EjH7Sdrl0QaMsd2WxeMwy1xDhTjENnh
WKW6QXqk
=Gqpk
-----END PGP SIGNATURE-----

--=_MailMate_17D8B763-DE2B-434A-9907-625CB52DFF3A_=--
