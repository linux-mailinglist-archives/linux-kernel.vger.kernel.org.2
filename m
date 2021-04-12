Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A60435D061
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Apr 2021 20:30:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243609AbhDLSak (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Apr 2021 14:30:40 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:32840 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236924AbhDLSai (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Apr 2021 14:30:38 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 13CIFlKb094124;
        Mon, 12 Apr 2021 18:30:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=JchVi1Vs76nXE+Gp3rQZUGQte82VXlq0nDlAHivZqJk=;
 b=P3l2vG6bJwFqLTqn7UB1cGCywUwnFx22klDU8DZkiQt+RlwAZ67qtBjLmgb3TLJY6LND
 nE4MyHHWtEKMHH/mMsXZ6JrBBl/Gy6UKw3rxn0yTuu6nKp7Zl9IkyeucP4SM3lRJd+kk
 dxllGf4f8LxbD8YuFboqoEWILYXH8Fwd2pejvTl3+NtmXcX/wXD2ReHyJ1QKlTLiMYYu
 L97joeXP9b4H7G3PT6AkPmdhlrHBaGSMYncPS6GFO5RWO93A0gB60D05vvAhK6XLpI8h
 FHyyCMOXld6u+4A92PR2/Qgr/5ob+5O6sBRmVkdgKxhVJ9yx5R4K4i2WE7Ht7MDk4J3u 5g== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2130.oracle.com with ESMTP id 37u3ercqp1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 12 Apr 2021 18:30:12 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 13CIFcvW003427;
        Mon, 12 Apr 2021 18:30:11 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2107.outbound.protection.outlook.com [104.47.55.107])
        by aserp3020.oracle.com with ESMTP id 37unwxqecv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 12 Apr 2021 18:30:11 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gESGXDrCj7/FUw5K5hgqMjdo5A4W3JIM3+vzN07XzFvPALmK1BFl8m7IXkaqAnXZP2lN9yvGAsGElT0D9IVRpwheuQn43HSInaHKIoE8pFhthyNKJba40iqGIdVHihRum03SAfJk2H51nvpYYdxFphqEelZyB6dzr6gCt9fLTpZ4ktAjHQCCi5ceDfjA74t/gKcxeVCp1jj5agXcxY7+FKZVmBv3oVwVEa1wb5Yy91AaamLYNXdOvgUVra0f1biPFoa2Ir2tBf8hMpwI+xi7TtWy96s5cKQG4k6J8ShZrZsPAH2X16M82w7ZXW187KkVtna3vVOUC8o6eXi61vvIIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JchVi1Vs76nXE+Gp3rQZUGQte82VXlq0nDlAHivZqJk=;
 b=C9dD22TAPbaRRi7TcrG2yA9dvIJvWNcCrS3RyYKhnBxtH9kDTAmAXQxdSZ5ZtANeL473czMChC2vquE/iVjjKkLNXFzaMeGw4FJK5qVeAzSNz7VIkRm8I8z8YH6RQsdVz1BHzqIqR3rhHXwaK2+SYUq2Jw6W/7wLBGXxHAVw5eGBsnNiK+QWDYM45TOArb+fleLygRxAz97rdyGxF9lAA6MgiCGg4S97ANKXGy7tXxt2U+gGdBLX9WPZ2dpzc0u0/dTU3KqORurb9tNvP1hQbnQpRmqyB4D9Qe0P4iOzj8Cep5/SUwumFPxa/vpp6xjxUmLIypU2lcwIqXmEdQ6+iA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JchVi1Vs76nXE+Gp3rQZUGQte82VXlq0nDlAHivZqJk=;
 b=ClhKkhWUdHEb3gDx79bXE0fRTD9p7T6mQwEKR/bWxof+NlasscXiF7jTu4hToSTJRsJ/7ZZpP8Ix8LFRqwfKIx8OWbYFgfy/0sMChGj6uvMAzLs7GCMEP051dhxYKowCba9kYsBx+8Gk3MAx4AOdv6Rn+kVbRrQ2FBOrSvH9OG0=
Authentication-Results: huawei.com; dkim=none (message not signed)
 header.d=none;huawei.com; dmarc=none action=none header.from=oracle.com;
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by BY5PR10MB4273.namprd10.prod.outlook.com (2603:10b6:a03:205::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4020.17; Mon, 12 Apr
 2021 18:30:09 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::980e:61ba:57d2:47ee]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::980e:61ba:57d2:47ee%7]) with mapi id 15.20.4020.022; Mon, 12 Apr 2021
 18:30:08 +0000
Subject: Re: [PATCH v2 4/5] mm/hugeltb: handle the error case in
 hugetlb_fix_reserve_counts()
To:     Miaohe Lin <linmiaohe@huawei.com>, akpm@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linfeilong@huawei.com
References: <20210410072348.20437-1-linmiaohe@huawei.com>
 <20210410072348.20437-5-linmiaohe@huawei.com>
From:   Mike Kravetz <mike.kravetz@oracle.com>
Message-ID: <4d5afe5b-54ba-a99c-3614-bb01d5da2b12@oracle.com>
Date:   Mon, 12 Apr 2021 11:30:06 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
In-Reply-To: <20210410072348.20437-5-linmiaohe@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [50.38.35.18]
X-ClientProxiedBy: CO2PR04CA0200.namprd04.prod.outlook.com
 (2603:10b6:104:5::30) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.2.112] (50.38.35.18) by CO2PR04CA0200.namprd04.prod.outlook.com (2603:10b6:104:5::30) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4020.16 via Frontend Transport; Mon, 12 Apr 2021 18:30:08 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f7c1fe85-4ad7-4809-4729-08d8fde10051
X-MS-TrafficTypeDiagnostic: BY5PR10MB4273:
X-Microsoft-Antispam-PRVS: <BY5PR10MB42737B0242C720E754FA7E93E2709@BY5PR10MB4273.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3276;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dV/ltHFmj9siILwDZy+hHcx9+18c8cIHBL3d44XfmhK6ysl0Ss8QFqNFnZ3efF9phdNaBtTevKV0/t/KpimB0VSCbwSxKEH5/xpkqMdYQ2U9VB/FYI3SfYRkab8zlxfuXfxFhLaHh3jAJnkx2oTtQqaDqjR7NCJ/OT8qaY1vy0M5ooG6xa321V9QFXq9GzTbd8p5vlD0kNd6vQPeza8PVE0QI+wG+qW9+hp2s0EFxehOHpblvZ92RLHdi1821DZQjm2Ox8vyPB7Jc8x+YkP/EjYOKWMGjL5ZqVUH95qdjjBtrjC4TLn6ZjoNtXHpsBzK9Qu0WRr5dzOmqWajuKKsdFzs22J0dEkerFp5L4bJaxnkiiLHZr4GsegrKj6/1bMfiaKmLLA8brGAyuAzWVRWSHMUNlZFH8mY3wo0W6wEMFZsYh+It4q3n602tVLflDV49n8cTzxFbrfT+YbOKY73qDOQ90lK7UuOmczoAPzX5Xz9yKqT45NXd2uEK+QjgFN+sU8bJN/NflE4u9UzdOMJmfQMO3N8dj3HgYEE7XCJjGCAsI9hW0h1J85V71Pi3II7i7EFzi5WLBJDAyLegRo5P78AliixrpWjY1koveQFB2aA3VoVoKl4qw6VQEss/P2rdsSFB0oQQde/SLoLh0TZyUMGogFhbPDPCOtQeofTo4mwbNaWpu02gmmaXYFQ6dc/GdYJ/v/vGFDSFtLvwkUWiw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(366004)(346002)(136003)(39860400002)(376002)(8936002)(44832011)(31686004)(2906002)(478600001)(6486002)(2616005)(16526019)(36756003)(4326008)(53546011)(66946007)(4744005)(66476007)(5660300002)(16576012)(52116002)(186003)(31696002)(86362001)(8676002)(38100700002)(38350700002)(956004)(66556008)(26005)(316002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?ZXN3ekdRTWlUMUxlUnZuVzU2ZEhyS2ZaejRIRFRGT0crUGNLeitvK2ZCVVlS?=
 =?utf-8?B?ZTZYRVNnY2E0dTRqaU5tZnpaVHRzVEhPNDhXQTdiS2R0RU9GaEw0RkNBTndE?=
 =?utf-8?B?S1RxY0QxcEFvM1pxMEM3OWZ0SGREVC9xb0pYaldiczJ4N2FyakN2d1NneFFJ?=
 =?utf-8?B?MFhTakh6MmdVUU0rRC9rU0FvcnVXVUEwZm5PZTJOSERMWW1kOXN4c1MzR1Nx?=
 =?utf-8?B?YXYwZ2FFRVd6MEQ5MGZSeGlGRmRTZDBkRXRjeXF2ZVQ5WEZIeTlMeXVNQ3dW?=
 =?utf-8?B?UmlnYzRnWUNhckhNU1kwbTVtU2Npd3JKYkFWekNydlJZZk9Zd2JJeG4rcTlY?=
 =?utf-8?B?QlFPeGVvRG9QR2p2aTk2Z2JhVmdDQVUyeTRrb1F4SGZCQ3R4VVVlZnord2h5?=
 =?utf-8?B?bmxmOC9yUmRNQzYvN2krd3BjZGoyZ0tiYktyeFplcmpZZmlqRVVTR0Q5cE44?=
 =?utf-8?B?czJaanIzSytsVHlCR3lrZi9wSlJSbUc3UXNjdjAybXNqemg0aW1jTnBNeER4?=
 =?utf-8?B?WHFLNkUvdUxaeVE1OUYxNTlyRGpvaWpFcFFnbml2d0VIeWZzUm5EaXM1SlhI?=
 =?utf-8?B?YTJDWk9iOEliNllMUDF4dzhMRzhSUmc5YjB3eUpESUhaTVdZLzBLdU5xdDB0?=
 =?utf-8?B?TG1Eb05DeE43aU0wSUUwQ3JmMklmOVNmRXV2WVRRajJ3TlREbGx4SGRWbHo1?=
 =?utf-8?B?T3IraXRsYkJaNjZmbDQwOVNieU9BTmFqcEY5am90YWlmekFKZ2t4TFdza0FU?=
 =?utf-8?B?eXhvUnNKY0tpSWNBYTYyV3JwTWEvUkFsMW1SS1VUK0Z3cFkxNERBbGdxTTNr?=
 =?utf-8?B?WE9qRGxYMFFQcFlVbGhkQWd0NnQ0cjF4UURwRDIyVVpNWkZzUHE3d2Z0MkYy?=
 =?utf-8?B?VWFPd1dublA4TXc0MFYxKzVkZEtqdllxVXZtQVRUcDRDNnZYQlRZMWdoRHVi?=
 =?utf-8?B?SEFwTjV0aU93MTVSNW5vK0paWGxXRURwYmJkNzdOTFZoZi9aZFV5RUsvTjFC?=
 =?utf-8?B?Y2ZucExPTVlPeGdkaWk2L2VjSDNPaUxoRjI5RGVUR1l5R255NzZDajlsUi9p?=
 =?utf-8?B?N0YrQi9JL2UrWWNIVnVCbkR6TkswbXdyL2JEUFZkVmx3N2hhNFpSbFZneUts?=
 =?utf-8?B?aUtMbnBYODUyVVVUaFNsWjFuaDJPaTU0c0hSUHRGdld3MVljTjFNZEpBYTIz?=
 =?utf-8?B?ZjRhRjJ4ZHhjemwzWG1xWFFuVVJ1cnFWUitwQUZOT05rOWxkcUs4YmQrUVlL?=
 =?utf-8?B?Z2ZNNHliLy84MkhZS1pybkthV3Mwdk9tVUJmUGFVRm02TjdDTnBJNFYxczRp?=
 =?utf-8?B?aEhvOWZKeHFmL2F2NzFXMGkwM2lpUFRpMWVuTk92eWhDazlHVThZQ1N3Ykxa?=
 =?utf-8?B?NlIvWGZ0a3p6Um84ejN6RHNnaTBBeTBRaE4rOXlnNlNQZW95NVJoclcvNTJo?=
 =?utf-8?B?M1V0K3YyalFHUmZJdWVBSmRvMmV0RTVHVGdXMnBldzZ5M0U4M3JZTXFyakxu?=
 =?utf-8?B?QXJFbWdaRUx6dEdyVFl0bm1ReVNIRnBENXQyNlRaek4rdDNoRjVqU3NKVnhL?=
 =?utf-8?B?L3MvRnBvZG8wT2FGNm5NM09tN1V4WFJpR3Z5SkhUdFZqK0ZyK1dDNUFxZGtq?=
 =?utf-8?B?aWF3N2tscWIxQWt2ZU5EaU0rditLQTVLN3d2SjRSQkdWVmRhWVZ6VFNmVFZI?=
 =?utf-8?B?dUpYdWxEZ0xkVUt3RnEwMzdDOW5GWWxmK0hieXpGTVVHWjJwdUVCL1lqODY3?=
 =?utf-8?Q?BmLz3uQ/xctwVkGnVywin5FcSijrakG25J2DpSb?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f7c1fe85-4ad7-4809-4729-08d8fde10051
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Apr 2021 18:30:08.9497
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BK+OOkfmYIT4Eqac9P48cfqF5JYEeRDArWDPv1acvaEaqrgcwok1tkUMycvZucXBELi3zm1Wod11wSFv6GgdTQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB4273
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9952 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 suspectscore=0
 mlxscore=0 malwarescore=0 adultscore=0 bulkscore=0 spamscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104060000 definitions=main-2104120117
X-Proofpoint-ORIG-GUID: _wrduLgGvuJvb74Kp4jFw4tqzngrSBb-
X-Proofpoint-GUID: _wrduLgGvuJvb74Kp4jFw4tqzngrSBb-
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9952 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 clxscore=1015
 adultscore=0 mlxlogscore=999 bulkscore=0 malwarescore=0 spamscore=0
 impostorscore=0 suspectscore=0 mlxscore=0 phishscore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104060000
 definitions=main-2104120117
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/10/21 12:23 AM, Miaohe Lin wrote:
> A rare out of memory error would prevent removal of the reserve map region
> for a page. hugetlb_fix_reserve_counts() handles this rare case to avoid
> dangling with incorrect counts. Unfortunately, hugepage_subpool_get_pages
> and hugetlb_acct_memory could possibly fail too. We should correctly handle
> these cases.
> 
> Fixes: b5cec28d36f5 ("hugetlbfs: truncate_hugepages() takes a range of pages")
> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>

Thanks,

Reviewed-by: Mike Kravetz <mike.kravetz@oracle.com>
-- 
Mike Kravetz
