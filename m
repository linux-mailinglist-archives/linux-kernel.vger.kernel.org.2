Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 91BC73689A7
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Apr 2021 02:09:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239819AbhDWAJ3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Apr 2021 20:09:29 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:51290 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231605AbhDWAJ1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Apr 2021 20:09:27 -0400
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 13N06vo0003773;
        Fri, 23 Apr 2021 00:08:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=jWXhTXf3jUHK2cx/906pZsneKsx+dYqvjiqKOK0KI5k=;
 b=FlSWOOzgexUNJgSgEeozFIsj/rbFmuyvsB/dThLup6kUWigvEDmoddG6iXvdE2LRIJjz
 JsakagmLAE8F5x6OCxnEkaC/9I70dyNfFj2YxgkppxKTpRotihvvx8/QS4R32H2b9Q7W
 FYFPRuuN7v/ZHkrSSzxKTq4bBCCGfpRde673qgjlfrJpppuZWdFM9Hg9A8PtWV4xTmuG
 BDQvs1+2JENEdbKa6Ww7b1htVk1N4qxVJ1aMS2lVNe02n2H6ZKFby25r62XsVuDI76xx
 uEFJ5TabYenE8OL5LU85E5KGmLGHNtLDQMKmHuvdv6OaTJg7dV8xOlNdDQnCsrdjz8jN 8w== 
Received: from oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 383duh83nq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 23 Apr 2021 00:08:41 +0000
Received: from userp3030.oracle.com (userp3030.oracle.com [127.0.0.1])
        by pps.podrdrct (8.16.0.36/8.16.0.36) with SMTP id 13N08dfT068941;
        Fri, 23 Apr 2021 00:08:39 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2171.outbound.protection.outlook.com [104.47.59.171])
        by userp3030.oracle.com with ESMTP id 383cds8twa-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 23 Apr 2021 00:08:39 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Z9cTerLoskbZKHBGQWugMu4BXCjUSjeOSrG1xw+IdMJ5FIjN+hSXOZ071xBc9PD+kEDQCL8/pXZjBQlfUSxabBUdOVFV7axD7CR8OIaPfFYuvSMUt5gS8QylouG2slVsG91OG2kBa9LqwC/Si7vUY8S8pOoJJ+4dDXCgnRWRv6qY/7C0HprYyjpGt7A095zaidvuxDQZwZVLcVgWg8xvllkyxlF4jkj7WeIyqTa5WQInoaCyctix/tkEqtHxBLWjEnHNaCYr+bviL3GwmHQUkL1FEP2DpyzhhSpXZ2AseS66VUXaO/MHDPV6Zy4dY+0XdU6qo6Czkamnwq4dCmX5UQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jWXhTXf3jUHK2cx/906pZsneKsx+dYqvjiqKOK0KI5k=;
 b=b8KX4JmSxkgMqB+J0kPPIuyhQ6pMeIE7zaeoD8JMs0g3hObjr1oxa/JGGHuuf1OFdAD844cHwpplWWkhZVfOHOyaKzLukyPCFkkZE7Qm8dEiCFY/Hjs6hMDi9agLtoYPIx6YI4YABnY6SWSIugXx0attKiFWRBkhkx3BQLVgTuCt0vYHOtLzGyzCxFFrPiMBomrtcZv+6oF47OKTDG0ahBuUvf01/y3UB8XZD2UFDl/OkynINr2FHfpVMfuvJZIjJ/gEKmwQMGVACKXoG7lwTuuXvXlypwTPMuazNskjam5N96QtnODn98Xkwut0cEna+uHd90L5sNuJsu6l7IrHeQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jWXhTXf3jUHK2cx/906pZsneKsx+dYqvjiqKOK0KI5k=;
 b=q+VmirbJ0nNBFQ6KbL7OBInljCJdRkDimBoDLAgPnJtg+GKlvMxBoyXdzpP91Z96BZ2GKi1qqzB+3HEzgbouxdnUNTHBx9nWXQEMiQLvvOZIcruMjW8hvqVqod0fSe/QFkN4vTMukuHKbwuenj/qirkhw7z9LM1IY5PwM4vFoC0=
Authentication-Results: infradead.org; dkim=none (message not signed)
 header.d=none;infradead.org; dmarc=none action=none header.from=oracle.com;
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by BYAPR10MB2550.namprd10.prod.outlook.com (2603:10b6:a02:b1::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.20; Fri, 23 Apr
 2021 00:08:37 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::980e:61ba:57d2:47ee]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::980e:61ba:57d2:47ee%7]) with mapi id 15.20.4042.024; Fri, 23 Apr 2021
 00:08:37 +0000
Subject: Re: [PATCH 20/23] hugetlb/userfaultfd: Allow wr-protect none ptes
To:     Peter Xu <peterx@redhat.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Cc:     Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        Jerome Glisse <jglisse@redhat.com>,
        Hugh Dickins <hughd@google.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Matthew Wilcox <willy@infradead.org>
References: <20210323004912.35132-1-peterx@redhat.com>
 <20210323005052.35916-1-peterx@redhat.com>
From:   Mike Kravetz <mike.kravetz@oracle.com>
Message-ID: <8e32ade9-c8ef-3d35-34b9-1e4acbc14f00@oracle.com>
Date:   Thu, 22 Apr 2021 17:08:34 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
In-Reply-To: <20210323005052.35916-1-peterx@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [50.38.35.18]
X-ClientProxiedBy: MWHPR11CA0001.namprd11.prod.outlook.com
 (2603:10b6:301:1::11) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.2.112] (50.38.35.18) by MWHPR11CA0001.namprd11.prod.outlook.com (2603:10b6:301:1::11) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.21 via Frontend Transport; Fri, 23 Apr 2021 00:08:36 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b800cdc5-351b-441e-1ea8-08d905ebf112
X-MS-TrafficTypeDiagnostic: BYAPR10MB2550:
X-Microsoft-Antispam-PRVS: <BYAPR10MB2550E9EBB841AA87A8EB598FE2459@BYAPR10MB2550.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pbzd21Dyc3+GyNzIApJXr/i5p4Nk00X1Ugv+KBQWvAJH0mhqvyho9Q3/Gdoo5XNTuzsuqwu5vr6YLzuKL6L1vvUXfaz6jEeduJAm4xdVtqqliPajhyxFvCAbemjqWtESaqxhOk63tH+xgsnMDqMCuIt7T2XgN7jzoC9Ck0xDJlyJ0GDyIXIVNcQUFvmmQ5gKCTcd0WDwOMdAk2ScD4Gun5SDAemmjdUjq2GvwNpJXvR0PdcWnZcvF0BRlNR+9rj6V3amh96U2sICXh+wL4JtTxPcUGtQ54izoSF8zBWVB8+5uDswAqUdQI6BE695NJtT007c+087tX6JX2YS4jV7/D5EOdeMdJhs7IFu9KGs2N0x4pLrWXpsRgIPgWiI2ygox/TeNbfQuod4nd1cPp8U/yhklmIncbetTuAm10xOBGTVpo7vdNFTNTVswDNh0zwKQSYmN7AvqsW/wtMJAevhrf5xJJ8u6+yEud6xjLKa+wpEoxYvcqlDz56v4Pes1KvF/ySCAJu6Pbirb2POK6qpfErBk++8tK36ghqtnA+siReFaxeBBsmbjYhkL7PAuBKi8B0+SpaHrOLIRPsjMbBOdlPfvgBv90kFPQVZB7036DgZYgvIjUDsOaEwU1+VDLX19F3Eo0moEBtdvEj0qgcts5/r7TigjAEuXjm4kEBSh0Ip6SjB/BynZW/dpbO+GrmoPx2YTQ35ZN9Xnc4Xu/JkCe5FVp2p5dgJ0SoEzLvC2zo=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(136003)(396003)(39860400002)(376002)(346002)(31686004)(83380400001)(16576012)(86362001)(38350700002)(316002)(7416002)(66946007)(66476007)(4326008)(2906002)(66556008)(38100700002)(956004)(44832011)(52116002)(26005)(31696002)(4744005)(54906003)(186003)(2616005)(53546011)(8676002)(16526019)(6486002)(478600001)(8936002)(5660300002)(36756003)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?bGRLbmZiQUhkY0ZhWGxTNm9BcEtNRUNPcUNhNFh4R1JuL0JiVENab2F1REdk?=
 =?utf-8?B?K2JsYW5PNGhnSXIvMGdEWHdTdU01d1BydzNkcTZsbnVTSWhBVVpWK1FDbDFT?=
 =?utf-8?B?cjl5OTE5R09CNCtGbjN5QzMvNG5scXZkSGFqUDYvNUYrNUx1SllxaEx3dVBx?=
 =?utf-8?B?cjdRZ0VxdUJrdDFQSGFqRUpYK0Fkb1htVWpWTnc0WjZjVkFXL0tVZUtZRlM3?=
 =?utf-8?B?bi9ZQisrTGdSUS9aN3krQ0VSTzdEMVlZa0hFVm85a1ljaVM5TVhZa2dsNThV?=
 =?utf-8?B?ZVMvaFZPUkkxTlg0SEw4dWFibW5MODJXalo3cEdLN2NHNTJMaFYremlXMVU4?=
 =?utf-8?B?SGpubVVxM2tlNWRsRzErbzNLSEJleERzdFFnOVZBNGdXL2NIT2lOMEllL0RL?=
 =?utf-8?B?c2NYbUFud1FFaWYxUlBaRFk4ZWdFRSs2RXozWnEzUWphT0Fud01zdFFoVjVF?=
 =?utf-8?B?YmYwM05YYytxenJMQy9qQ3VIZjY3OURYb0grMTc3M2orb29lNU1VMERzUi91?=
 =?utf-8?B?eHord2h3RERRckV3b1ZJL2M0Z2QreVhsUkVuTE1SbVhmWEtiNzFadng4bGhz?=
 =?utf-8?B?aTZoelhqTmV0UTA0bDl5SjJoUFJVa29GeWYwRWRHY3JzMVM0em93ZjN0U0pu?=
 =?utf-8?B?R01yd2tCQnFVMjBoVXMxT0pjeGw2M3hRTFM3Zy8vYnc4QiswWjlhWC9Gb2NW?=
 =?utf-8?B?bkYrWm9ydkVyMk40ckFOd3BGOG1OTXhOaUdqVXRXUDFsOEJWL1Y5elkrUnRF?=
 =?utf-8?B?cGprQzA4b1pCRUxZUk5aUzlsUHVkMzhTUkhNbXl6aTlYZjFvZ1VmUHN0T0M1?=
 =?utf-8?B?d0s2eWRGN2hQSUx4bkhyMjduNnZVZ3ZvTjZxNEtIRzExL0hkSG9CelY1M0tE?=
 =?utf-8?B?ZVBkdUUwSUFJZmZjMFh5bE0weE11L1JjYlFseElxRWY5dTJVZTFMVnpWV0ww?=
 =?utf-8?B?NkN1WHg1U1R5SUY4Yjd5ZTJieHpvRlBpNWhQZ2wrdTk2Qm5KN3JUNXFIYUFD?=
 =?utf-8?B?ZnhrejMzcWU2cDNEVmNHc2RZam5MMUFMU2E3TGV0SVFhZFJ0UkZHTTFkSnV3?=
 =?utf-8?B?SCs1bGFBa00xRzNxQzV5czZtbmdpaVRmSW1jRWFOM3BnbVdmTUpjY2VuZVNv?=
 =?utf-8?B?VklheUZDOW9QejZjNEl4Nng1M1FBczFyd3BOeGtFU1NFSDZ1dDBGb3FmMjBp?=
 =?utf-8?B?WFBqNms1UU1aa1FralQvWmxkaU5hL2xTa3UyQWYxalZRL1k4anlQZG1nRS8y?=
 =?utf-8?B?UTY3a1RxWm1WRkFJb1pueEpQM256MFUwR0J6TWx3Q1JVZUg3Y3QyclNmY1k2?=
 =?utf-8?B?elczVUljSXpmRWlQV2dBZlczcGVsKzhwV2R6NnlwOG9kVDJrQlJMcVIwb0Qx?=
 =?utf-8?B?eXVleGxDaDg2M0pDMm1MamF0cWdpVnIvRVpPYU1SVUErNlhpbnpER08ydllw?=
 =?utf-8?B?NW9IRldPb3hmY0V1dU1WbktjdFh1WFFxdTVUTlQ2WHVWSEVTbC9GdS9IbVdn?=
 =?utf-8?B?eVpmS3UwbTJnVXljRjFwL2ljVTJ1M2FrRURFL2ZQWE5haHVnUjFJWHZaNXYx?=
 =?utf-8?B?dmlsM2RaSXRacnBPSGVCekpWclJzbzRNd2w4WDM1TlhyNVF3OGFXNXB1TkNY?=
 =?utf-8?B?RmJwVWdscjZ3TUlEYlJ2NmpvREpSRHc5Z3Vhdnd6QUJlclhDK0g5Ni9HOXVZ?=
 =?utf-8?B?anR0NlhJT29CbGtkVkh4eGhsNG9YTTR1cHN4V1FVakgvK3RRbml2TXZqdllW?=
 =?utf-8?Q?8CvT/2H33QCGcG/mgvUKq/F7N7S08KpJdJ3BsJt?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b800cdc5-351b-441e-1ea8-08d905ebf112
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Apr 2021 00:08:37.3269
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KoLVQHF+eFy/R3Ty+382c4Kl7Cbw7VrXDdNNs76b1ewddOEGqVLapxE59jJU6QpXtfLZWfSVAzn/jWnuh4niSg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB2550
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9962 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 spamscore=0 bulkscore=0
 suspectscore=0 mlxscore=0 malwarescore=0 mlxlogscore=999 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104060000
 definitions=main-2104220177
X-Proofpoint-ORIG-GUID: 4I1pish4kLGxi_yNBiZc1AH51gjMb-Tn
X-Proofpoint-GUID: 4I1pish4kLGxi_yNBiZc1AH51gjMb-Tn
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/22/21 5:50 PM, Peter Xu wrote:
> Teach hugetlbfs code to wr-protect none ptes just in case the page cache
> existed for that pte.  Meanwhile we also need to be able to recognize a uffd-wp
> marker pte and remove it for uffd_wp_resolve.
> 
> Since at it, introduce a variable "psize" to replace all references to the huge
> page size fetcher.

Introducing psize may have caused most changes. :)  I like it.

> 
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>  mm/hugetlb.c | 29 +++++++++++++++++++++++++----
>  1 file changed, 25 insertions(+), 4 deletions(-)

Reviewed-by: Mike Kravetz <mike.kravetz@oracle.com>
-- 
Mike Kravetz
