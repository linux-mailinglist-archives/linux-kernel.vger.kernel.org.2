Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 89E6039E87B
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Jun 2021 22:32:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231392AbhFGUeg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Jun 2021 16:34:36 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:33554 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230436AbhFGUef (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jun 2021 16:34:35 -0400
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 157KU2Jn139426;
        Mon, 7 Jun 2021 20:32:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=DH66veHEuLypxxfH+GeymZYgPpW4QmS7uC3JWD4nyfo=;
 b=KWVvRi3RSMAfvn+QsWlv/pbZokG5W+KwHCoTH5rbsE9n+a0xZg2TPDPt7BEUtu4sHXQv
 VneXqrWagwi+iPdfC0u3ULifjlBP/yjN0NvZXNmKc33Dww3CmlAWMhumLeOv2eRKFKE+
 UDWPu/ZwZq84yyYG9ZghZljJ1eULHulPnvjTr1UFUbYekDvfhpLyjWnZitOSk07KB7ya
 cr2d317wh8ns7BfrfZC1TqFHKWz3VGJpLXw7e6CdhVkirRZ4lh3yYMncZBvuybi11Q/4
 CessSTAsORnY9LyvfWg8SmIYMUsnB2tp0GePDmpDWKJv7CJj6XGMlqW5lGlbkCZ/UiqU TQ== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by aserp2130.oracle.com with ESMTP id 38yxscc5a6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 07 Jun 2021 20:32:37 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 157KUxng043950;
        Mon, 7 Jun 2021 20:32:36 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2104.outbound.protection.outlook.com [104.47.58.104])
        by userp3020.oracle.com with ESMTP id 390k1qd319-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 07 Jun 2021 20:32:36 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=M+NY2xt6Y9GKZpheziyM/+MwT7J3zIE7TUFhPXf2UiqZB5POAoP+qqxeI9lqaRNTHrsheHTwAMtYXkTXNMyD2TreTeNconxVlm79BCUlNj7h/1D1U6BynIbU3ALmlfzWAV1xaejLrtWqbs+L1uXn52J5oGaKeknwDipHkoA7QUYBDx/2nDgBI70QTc3eqQAF6ULxbBJtnb4f57B5wSZmL+Rne83QXwEqMVEVWj68rN7HG008QGhLBuqDt4FzwCjJ9Pq1tAYzo98b4DnDDkGCscAgFnpsafgPwBa6Apuwy0JvFhXZnpzpekeURmc/VCUBVJYVgPcliNMuNe4UephLwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DH66veHEuLypxxfH+GeymZYgPpW4QmS7uC3JWD4nyfo=;
 b=m+qDiUd7H85zZoW02aMvxJptgqC4POUdvaeTSwGgXwD9qtidbpdqz5eBXDWePR4/Aowp2GSMMsOviyKEe1AA0jgNRlAoQtXHPnk0jBM9orkDNUsLjLv/MN8/C1OqDB4aoctztZ66UwhHya/mFe8RjlXQ/ry/9FsSMwa+0eKpbzfUIA0KztcHWI3EdwM5eJ7b0rqSqqI+nOldVzuzXyT6MJjQSlnlQGlyl5+DNKxTa+8lQCzYX/vrT5BtjYvz3L0i4JLoMaCl+/hyiVTbHfNRxUxnNS436sF7PnXkGcpfJlrsG1uPt8ThjYvFEH8OzKon68TuLzV5GZYJG8rP9D6T4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DH66veHEuLypxxfH+GeymZYgPpW4QmS7uC3JWD4nyfo=;
 b=wHzLtcapa/YIQO9PRPRtRlKekSuEY6QOxRjqLJjnOQZlW4niIDIxfEofRq6wcwasDJzVadYChzQsd4l3cb8DlBmmVnUiviK2CRNvuars2Dfdjon6qOB8PV+V/wNNVi4ITdQu0mQRM6ICVyvIUfny6jqcO1FPTGDdQo3u23O4yv0=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=oracle.com;
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by BYAPR10MB3206.namprd10.prod.outlook.com (2603:10b6:a03:155::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.20; Mon, 7 Jun
 2021 20:32:34 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::4407:2ff6:c0a:5d90]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::4407:2ff6:c0a:5d90%9]) with mapi id 15.20.4195.030; Mon, 7 Jun 2021
 20:32:34 +0000
Subject: Re: [PATCH] mm, hugetlb: fix allocation error check and copy func
 name
To:     Mina Almasry <almasrymina@google.com>
Cc:     linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org
References: <1fd32aad-c99d-e89a-cdb1-05843f568f0c@oracle.com>
 <20210605010626.1459873-1-almasrymina@google.com>
From:   Mike Kravetz <mike.kravetz@oracle.com>
Message-ID: <82674cdb-2b1e-cd12-5e60-8b19f596bf99@oracle.com>
Date:   Mon, 7 Jun 2021 13:32:32 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
In-Reply-To: <20210605010626.1459873-1-almasrymina@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [50.38.35.18]
X-ClientProxiedBy: MWHPR13CA0016.namprd13.prod.outlook.com
 (2603:10b6:300:16::26) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.2.112] (50.38.35.18) by MWHPR13CA0016.namprd13.prod.outlook.com (2603:10b6:300:16::26) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.12 via Frontend Transport; Mon, 7 Jun 2021 20:32:34 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8e66316e-8f1c-4f55-74a2-08d929f361b1
X-MS-TrafficTypeDiagnostic: BYAPR10MB3206:
X-Microsoft-Antispam-PRVS: <BYAPR10MB32068824ADAF113FCC125A52E2389@BYAPR10MB3206.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4714;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 58QldSAbwzBPi1zBUpy3GHdpYRALXFkZpwb5eIRFFoANU7kTGXsFzlJO2wyEF6mn0+k0IEmX5mFLKpzD/61gT/8ihJVylPc/cXccex455bIk2PfxgCw10DRIyXfUqkT5mjghHg9P/FuLBm1zokrpZVd4oHGtK35ihQnRfH6xLj8T+wbvPCbtLyE1Mv5kRQKP1uR+FaXdJXYNfBg8Ogk2odBkiTHznDpw2LqXKYJytMByOwmOH853i2uFkpfWufIH4/oGz/JfnoiEdZxxjNL2973HxAP8cP7MLVujKmPdlL82W2y5vrgm7D0EoDX6R3h2yVEKw4MvSV32nVdsOW7lP7+8Q9JelJO6iXrWTUnXpfGRMopsOjIx2nVRoHXwkix2+oSSbMRlz7jWrrhuEna+J83rXtHPcHpKigJhYdwhrPvr2nAq+UpdrxwLNX9cqSziicVgJjTY2C0dWCXsUrwb+B7gnBulq1QkOSzHvv0AQHRLm8phVuSbEgJYMc2YQb5VG8BC+tR7a22gLxe0UXRofwVRmz381ycJfhkbuvMrBm2t6rGkr5iXqDAEGCbVxgaj0jh/hrH5DpCbebSiNecweDAflfrlT4b95CaNMIB9ejRDfiUxs48rR5ECuR/eyhyQxSJGMGILJ5bY6csALsW7CHuf8c454u3XE+x3QqePbtUNfZcxx6Y+putGef0iBABtoRae9Qak33qBDG4Lu+ZlijMWZFMNENtEy8fMktRz/QQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(376002)(366004)(39860400002)(346002)(396003)(136003)(4326008)(83380400001)(8676002)(6486002)(36756003)(26005)(8936002)(2906002)(16526019)(956004)(478600001)(2616005)(31696002)(44832011)(38100700002)(38350700002)(66946007)(316002)(86362001)(6916009)(16576012)(52116002)(66476007)(53546011)(31686004)(186003)(5660300002)(66556008)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?M0hTWGJMMmpLcVBGcWIvNnBEbUpvdDNqd0VnWUJTQjgwakh3MVF4T0lESGcw?=
 =?utf-8?B?b3JuV1JjenRyS3J6UFNva1dydmxRY0V1bDNEUk5WaU5ZN1prTXplbHpPRWM2?=
 =?utf-8?B?amlLeDI0NHpoRDNFRy9IOWFoc2V5dUhWTVc3QzBMbVB5V1czdjNEc210ZjlJ?=
 =?utf-8?B?M1hSdm9EZkZrQjFBSXNvNlZnN0dGclJuVnJ3a1YvTFg4ZldPcURKZklWNVE3?=
 =?utf-8?B?SkJERjROYis0OU52Q0dZVzBOOE5uc0NGQm9vTW92T0NHNWhpTzV6RCt2MHBW?=
 =?utf-8?B?TVJ5cjVFdEk3bGpPdmNnWEJZRHZuOVd0aHlQd2d6Y2hrdTRNV2N6eUVOdWhD?=
 =?utf-8?B?Sndiek8vOTFZVEhhTURzNG5aZGRFY0V3Sk9SS1QybXhuNGFTcnFHNFZMU1Y0?=
 =?utf-8?B?Y2lCWm4rUkZWeGJiK2tMWjYyZnc2RE8yN1d4MXE1K2VlWjI1V3gxZFlJZita?=
 =?utf-8?B?c1loK0U4Z3hLa1V5U0c5VEZEcXJTenFoU1JFZUg5Rmdxd1VQdGpNU252VkdS?=
 =?utf-8?B?R2dKYTZZbk0yYXBONHA3NUUxTlBzWjdWVTk0RUdwS0N2a1k0ZDZtRitXZ1lY?=
 =?utf-8?B?SXhraDdrMXJjcXBnaEhvRmhDalFBaVBUekdEQ2J3Vml2V09hMzgwMTRuQkFz?=
 =?utf-8?B?TlBveENJY0ZFYTVoeHp3SDBwaVdKd3JkMklyd3RHMjNDTnJ4ZGZxTityTk51?=
 =?utf-8?B?ME9kdmpydEkySzRsak9pVTIwcTRFYkZuSDJjRlY0UDE4M09jYW92UkNwa2hv?=
 =?utf-8?B?djVoMVVmQk9WNlpZNnVVb2lrNXJMOS9TcGdzZGorVXVzcXUvamV1OVF4RzZZ?=
 =?utf-8?B?NHNQelVDYy9aZ0RjdmNYVkRkWDJ0SU5leExVYWh0d01oT1h3bHM1aTAvWGh3?=
 =?utf-8?B?aHN3bDNkVmVYNEpQZkpia0dvSStwVHZQczhLZWpQcmlKTVIyVXIrNkIyYk4x?=
 =?utf-8?B?dTBIWFkweHRwSXM1QW1BdUs1cTY5eEJqOFdxcldCTVhkdEl3cktDZ08yaldW?=
 =?utf-8?B?aVV2TWw3N2ovOVVwa0hzRnZydjFhOFV2QmlWNmJycEl3UTYyeDJkQlJWVTdX?=
 =?utf-8?B?cWZwbUxrMTAyQ2M2eWxydVhqUUcxUzhnckF2bVRJT21DZmpTbzI3MXdWU0sv?=
 =?utf-8?B?eGtSVkdacHRWbm52NTVlWGhEcTlFRWd5MVhZNGdraC90US9RR016dGRNblJ3?=
 =?utf-8?B?N01rQnpBMjc1Y3Rna2E2QTEvNFk2eS96RHdHTllPaVBMcGdKd2ZQaTVma1lr?=
 =?utf-8?B?OE5rQ0ZaTWphOUxndTdFVTQ4M0hJMnhZZmJ3YnlZUXd3MlNERkVEMURRY2NR?=
 =?utf-8?B?ZlBHMGxZQ1RKeERPQnEzVmVGZEZyeUQxR2czMTNvbTZMQktGbTRZYzh6NVJ6?=
 =?utf-8?B?SGRGOUhJRFVFVmwzUXVmSWcrbkJnaWh2RUIyNDFvbGVEYkM1am9hQkVkV2di?=
 =?utf-8?B?a0Y0eXJyWVNtbHlSemRpK2NwOU01T2JUeXl0a1k0bFNTMDVBWnZCYmIvQ0lB?=
 =?utf-8?B?ZjdvdGhkaS9LSVRBd0hkQmZaRktVT2VWWGwxV2RUY3poMlVUK1hBUStubFls?=
 =?utf-8?B?cE9SQVc1MDdhekNwaFNLcDlna05ycWdqa25EMEFOTnk2ckl4UU9ueDZsQ1V0?=
 =?utf-8?B?U1grdEtiTEoreVpaS2llb1Y4S2laQW4wRDFXeGl1QlNlc0NCOWlrUEYwYk12?=
 =?utf-8?B?SkVwMHRlZW5uZkRDb3lPZ3NzZnpFc0NZb2pzRHFVdW9CWkNkUFVkMG96VDUz?=
 =?utf-8?Q?5Q3FgdvTfnPf6IBxssue5T2Z8VfkTe0b5/cbFgi?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e66316e-8f1c-4f55-74a2-08d929f361b1
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jun 2021 20:32:34.6449
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JiErmRBqkZSzJJgFmYqjp8LRz0UMBINzpdW3bVhxpYOxzSOmzFb1cKw8gytsLBMeFeTBDAAIJTTKP2r3l0FCXA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB3206
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10008 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxscore=0 adultscore=0
 malwarescore=0 phishscore=0 mlxlogscore=999 suspectscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104190000
 definitions=main-2106070138
X-Proofpoint-ORIG-GUID: _br-_WCNf7plLbpJCM96GKljoB3-uf4A
X-Proofpoint-GUID: _br-_WCNf7plLbpJCM96GKljoB3-uf4A
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10008 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 impostorscore=0 lowpriorityscore=0
 phishscore=0 suspectscore=0 bulkscore=0 spamscore=0 priorityscore=1501
 mlxscore=0 malwarescore=0 mlxlogscore=999 clxscore=1015 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104190000
 definitions=main-2106070138
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/4/21 6:06 PM, Mina Almasry wrote:
> The alloc_huge_page_vma() doesn't return error pointers, it returns
> NULL.
> 
> There is an existing migrate_page_copy() which not only copies the page
> contents, but also page state/metadata.  People could get confused that
> 'migrate_page_copy' and 'migrate_copy_huge_page' do not have the same
> functionality.  Rename to 'copy_huge_page()' to make it less likely
> folks get confused.
> 
> Fixes: 6a0badc266df ("mm, hugetlb: fix racy resv_huge_pages underflow on
> UFFDIO_COPY")
> 
> Signed-off-by: Mina Almasry <almasrymina@google.com>
> Cc: linux-mm@kvack.org
> Cc: Mike Kravetz <mike.kravetz@oracle.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: linux-kernel@vger.kernel.org
> 
> ---
>  include/linux/migrate.h | 4 ++--
>  mm/hugetlb.c            | 4 ++--
>  mm/migrate.c            | 4 ++--
>  3 files changed, 6 insertions(+), 6 deletions(-)

As mentioned by Muchun, Andrew should squash this and original patch.
With the combined patches,

Reviewed-by: Mike Kravetz <mike.kravetz@oracle.com>
-- 
Mike Kravetz
