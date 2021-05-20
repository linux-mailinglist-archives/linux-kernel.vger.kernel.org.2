Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 56A54389BE9
	for <lists+linux-kernel@lfdr.de>; Thu, 20 May 2021 05:34:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230295AbhETDgQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 May 2021 23:36:16 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:51098 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229531AbhETDgP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 May 2021 23:36:15 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 14K3UUbS100736;
        Thu, 20 May 2021 03:34:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=02Ptgzu1dHKq4lMAgHL30SwjUGIsHlwPWSMRtRTZXHg=;
 b=SbKPXCPr0mkIIP/zm50F3aAfqzqIi2h1Vxxz9uMs3e5YU5nhfVVX2aDvRaPnxNmsC1Zj
 LPJbS/19JAAWnQ0+YrC/fahhvhF/MPPwsZiH1Z5lQbv5rmdcQqPQaooVNQer6fgh+e//
 tmrlucpvRF56gHxMef4/BEnU0sNYgVg6Le00Q96HSJKOWvMds5/eg9rdazre/Y4AGtJY
 QPaqM+jhmpa5UTXlFuRgizC6fRZVf/FmblGVyRo3JDA4mMRBBqmLoO7IvrkULCNMqirJ
 ybSSAGUDOlB0uoVAZGziP8qN5UsVRteuCWiQw/N2WArwEh7R/dB/tyZacklywbF/KjHA hA== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2130.oracle.com with ESMTP id 38j5qrbcwv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 20 May 2021 03:34:07 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 14K3Q43O019674;
        Thu, 20 May 2021 03:34:06 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2101.outbound.protection.outlook.com [104.47.55.101])
        by aserp3020.oracle.com with ESMTP id 38mecm2wpc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 20 May 2021 03:34:06 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fwlV1Dh98okinT/UWgrlvdYzRYrMH8sWjTN7zz/fQDpDr68YtUu4uADU0zY5e8LGJK2jMVm8DTdt9qjacoBEsCkoaW8AD+NqNOxoiHKzUQCrT4RMx2D+NGfD8GYlcMyHOcs88rYSCMX+3lVYosN+Z+XypzQP6xN1FlltUQ/wrKdkmAqL2czm7o0xQ7166B1HpGF8X7am3ugUKtYlV9YzM5UbtBHa1eNq7vaGBUv9ykKwxVDayQuGo9T6Y1n80WaTldQB9WPEkqZvES2xJvlLJ9ywC3Z+M9YKNltW0nQO73M8f/TiqXfoRHAWDqG9V4AKnDggetHlts9DBO96TYtdDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=02Ptgzu1dHKq4lMAgHL30SwjUGIsHlwPWSMRtRTZXHg=;
 b=i6JQAI6teSXCjjOS5Z0XB3U123WDKp8jeLrvXWyh7E1w87qP7fMhvOv+2f5Orc48rHmFOeCrT9UpsAzeo6XIftGT4YQAiAnBy92ky5PTDQEOlt38+bMPO/s0g59WE57I1O0/de4gIVuEHu2q8BbO4AQukisLq8Q333nIgtBtIqezvvEpqhttXPkIqib+u7Ma+RpPF+wbTy+l0+vN1F2bytOho6uaMzipBHagpZdoDB9bLVfJ5LgjmzzC15t4GDobHmKClKFzMpr+OVnxW1pSkxplLdlxz+TqLkJjuxhScEogD0KkW/XxvR9fPbE6VuprY5jJD6cFzUZbvVlwHuj9pw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=02Ptgzu1dHKq4lMAgHL30SwjUGIsHlwPWSMRtRTZXHg=;
 b=hpy6JP0emJutEg2OgJSlr3aJS8u2C/PUnIBLsFaI9W/KDTGCE/BbXIb3aNPMqRQVHAjik1W5bjFgWmh5oxlnoTt8cR29w9rpSNyN/LHuYWXQKdFxr8soBRM33p68ewlcFXHczJ0zjMO6yBHsUJF/3/Lj0WAcMMWSCe9BrexPNsI=
Authentication-Results: arm.com; dkim=none (message not signed)
 header.d=none;arm.com; dmarc=none action=none header.from=oracle.com;
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by BY5PR10MB4276.namprd10.prod.outlook.com (2603:10b6:a03:201::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4129.28; Thu, 20 May
 2021 03:34:04 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::4407:2ff6:c0a:5d90]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::4407:2ff6:c0a:5d90%8]) with mapi id 15.20.4129.033; Thu, 20 May 2021
 03:34:04 +0000
Subject: Re: [PATCH] mm: migrate: fix missing update page_private to
 hugetlb_page_subpool
To:     Muchun Song <songmuchun@bytedance.com>, akpm@linux-foundation.org,
        osalvador@suse.de, mhocko@suse.com, david@redhat.com,
        willy@infradead.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        duanxiongchun@bytedance.com, zhengqi.arch@bytedance.com,
        fam.zheng@bytedance.com,
        Anshuman Khandual <anshuman.khandual@arm.com>
References: <20210520025949.1866-1-songmuchun@bytedance.com>
From:   Mike Kravetz <mike.kravetz@oracle.com>
Message-ID: <60ba549e-3337-6415-cbd4-1311069756d0@oracle.com>
Date:   Wed, 19 May 2021 20:34:01 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
In-Reply-To: <20210520025949.1866-1-songmuchun@bytedance.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [50.38.35.18]
X-ClientProxiedBy: CO2PR04CA0134.namprd04.prod.outlook.com (2603:10b6:104::12)
 To BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.2.112] (50.38.35.18) by CO2PR04CA0134.namprd04.prod.outlook.com (2603:10b6:104::12) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4129.25 via Frontend Transport; Thu, 20 May 2021 03:34:03 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a68a996a-fefa-4753-efa6-08d91b401da0
X-MS-TrafficTypeDiagnostic: BY5PR10MB4276:
X-Microsoft-Antispam-PRVS: <BY5PR10MB4276747D8D788463F2CFAD1BE22A9@BY5PR10MB4276.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:862;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NAF18t73e5hVzwHMN5AFCNi8SMfZPdWPgogjiqb9dSQpWM2dxfD4Pj/G4V6x5nknVv5yLj/bWW/20HbtOvk/V5wlsCKlMbSLrc07Mr5TXLu/Ph0v/clS9MocTUfQ516a5R3JAFK1dM2zRpNPLw/0DDmFTZmnlxpbfBM910xl2pu0LOj6lJyO7PVdJ8hqwP+l5INBtZ10btAYSldbX7IQIjKTKJ7Kn3CmMjtqhbj810/9tnfgb7bmYPqBZLqA4l5RY2wpui3fek1UQJNgR0Kmg9xToEl/fZ1OlXHas0kFtgzJqWyYQvJkwl5dx4P20iJwhIeIXAW6wIPbsVKqqZPuJ5vrWfGlsNDBsvWMHLx9aoedifv2xGlHo+1T7A64dblnZ5s9MzSiixBWHu1u73G08RghziLupjikyS7Jgc8t/Z81mJG3Jp4AM8sLmrANB8kSQjzxO3cUVGKPivVYeQodQQBO6sRn/mexBTKRNpAxo+EhFv+aunojERG7V+FV6O4AUO8t9z/+NcqfvuwxT+fh0i/xnIARPyVwAes9M93RxDSNeN0dNkpEYOJ+hKE/t3qzb8p/5mFJ8XfSgATmbcJ5FCdjqbN4kUN9maYonN+8bMN5holFudk4FtOS1GStdQE05l3QKEPJK+5TcEr376uC33aJKuWqOLTV2E6jJAmjJcONlCShNwDmMnYG7JSJ+wIn5jmBT53CTY8reYLgc4ZL5A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(366004)(39860400002)(346002)(396003)(376002)(186003)(16526019)(66556008)(478600001)(52116002)(31696002)(6486002)(8676002)(2906002)(956004)(36756003)(66476007)(7416002)(86362001)(2616005)(53546011)(4326008)(16576012)(44832011)(26005)(83380400001)(15650500001)(38350700002)(8936002)(38100700002)(4744005)(31686004)(66946007)(5660300002)(316002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?NEVWWTQwdml6cUs0ZExYTUhYR2hEZ0s4QldpVjhsaXcrNkxmUFBROGVib3VH?=
 =?utf-8?B?ZWxyOGI5R0lpb3hmdGZvVjFGLzdPWG95dVVJUXlELzlkUFczYTFHL1Z4d005?=
 =?utf-8?B?T0xrQnQ0MHU4M1V6RFRDZTc2RUxIYlNPdEdmTm5SMDVlWHNvNk1BcUFNTjhJ?=
 =?utf-8?B?aWtxOHpVRWR3VjNIS2ZCK2R3RkNNYWFGeGZDV0hJRkhWQ0tsZHpsOXdXam5I?=
 =?utf-8?B?NWh4U1krbDdtdXF3ZXovM1RJZHB5NG5yeXVHN2liYzh3TzhLVWNUZkxPMnZT?=
 =?utf-8?B?ak5lWUZ4OWlmeEN5d05ndWEyU05KRUF0a09lZTdzUUw1bGhadFUxUFhFSzU3?=
 =?utf-8?B?SklUUmNxRXNNWWU0NFlFVHd0V3JzNXJ3ekZLVUJNZDl4Z08ydDFWbkhTZ3Rl?=
 =?utf-8?B?UmJtL2RZT2tQUjVTVXp4VFNVNXE4czdRRzNaSVl4WWhrakdILzZtL3FJMXhj?=
 =?utf-8?B?RXA0MTlMM0ZTYUpWSFQ4aFllL0RRV1VuMUpkUWJhNFdmTm52Rk9ZQlZ0cmxI?=
 =?utf-8?B?TDZVNXVWRlVqNlArTGY4aWRrOHJPWWJuSVNxaXl3VW8yM2U2VUVwU1AySlpu?=
 =?utf-8?B?dUtKa3RaUk83NlBROXBZTDRXTldYdWxUNFlPSmhkZnJ0ajZhQnVaUU1YZlIv?=
 =?utf-8?B?bm1RVlY4MXZQS1g0V3kxVDY2SnFkRitjbVpTc2szYW1ScDRBYk5tclJUOVov?=
 =?utf-8?B?RHNwNXA3ejNSajdHcCtValozMHNwdXRBaUpLOUZ1RXhkcDZPaE9BQ3ZNck4v?=
 =?utf-8?B?MWlxU1RwSzkyL2JNMGVHdExFVmpMbkpnRHh4NGdkb3Uxc2QvTXVoWUU5bEw3?=
 =?utf-8?B?eVFFMnY0bEQ1QVRiU2wybWxQYXlDYys1NDNVaXh2NS9RSXhKck9pb2dtd3V6?=
 =?utf-8?B?ZHpiQjlTaGgwQW83L3VUZXgxd005Z0hZaUw1b1k1UVlWRENaa3ZHdStjaWR6?=
 =?utf-8?B?Ujl4cGsxazk5bFN5czhmZmtqdmtia0dDclVzOXdETlR0ZjZMVjB1eDlTWTds?=
 =?utf-8?B?ajVPbFBNRkp1cW45L0Uybm93eFlLOHNyVi9zTXpnSkl5YUxRNHIvSDNTcWtK?=
 =?utf-8?B?TjdYQmo0T0J6WUF2ejAxUEZTbnR6TUpGSHlKeGM2UXJwSWxJS1ZZOFhlNlRF?=
 =?utf-8?B?OUNuVzdFWDdiQXpRTHk2TzRVMGNPOE1Sc1dXa2FJQVlibFRkUE53emduRE9w?=
 =?utf-8?B?eGZvRHY1MStaZHJWb0JWM0ZPdnIxSC9ubEE4Qmw2YUU4bStuOG9KWFA5enFO?=
 =?utf-8?B?Vmg3NEJEK282YUxNeTF1SnZvWllMa3luOWNvTFFMTksvdnYrR1FMTThwcTdo?=
 =?utf-8?B?eGh3QmNCL0taRmNWYUE5V1R1bHBRcUNNR01SaUFCTHowQXArQWFXdE5qdEV3?=
 =?utf-8?B?YkFYYTlCYjc0YXBpckUvYktIbkVTN2NiOHFpN280clNCQkdvVXdhVllqS3lm?=
 =?utf-8?B?Mmo4ckxTWi9zWjR3VTg0S2JZbkVsWHpMR3RNNk1UVFBLOERicnpKNVoyZTY4?=
 =?utf-8?B?bFk4OThsYjY5Vmd5a0ltWFREdW5odStxZmF4YkVveVg0RlJtTzJ0WVVUQXc1?=
 =?utf-8?B?V0JXaXRGZWZWdUM1ZkloU2JaVjFHR0k0cFlpSS9aUEpHRkhLWWFlUjRPSVEr?=
 =?utf-8?B?RlZNQnJoaWcrdW12ZmhVcGdkam5lZmswQWdsa1RiL1ExSzR2Um9hWmNwNDMz?=
 =?utf-8?B?V2M4MlBGNkZIL3lrSC95VkM1dnEwRzZmRmdhMllPUzY3MWlPRHZ4Qi9Wa3ZN?=
 =?utf-8?Q?eDG8p6ZbC25usmKEns+IzLU6gK3wa9j5T14Ccjw?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a68a996a-fefa-4753-efa6-08d91b401da0
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 May 2021 03:34:03.9933
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dCIvVVpnEbK/BT1urpvFNHVMZOKRxmOX5KtOhXEqCDcDUAybZHM2t8BtQgUR8tbo7ic7r7Ap+K1g/JCYbjQWVg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB4276
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9989 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 bulkscore=0 mlxlogscore=999
 phishscore=0 suspectscore=0 malwarescore=0 adultscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104190000
 definitions=main-2105200025
X-Proofpoint-GUID: Nh85F5u-KwKn-MsWrpkuk0a65Ib8sdt0
X-Proofpoint-ORIG-GUID: Nh85F5u-KwKn-MsWrpkuk0a65Ib8sdt0
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9989 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 clxscore=1015 impostorscore=0
 mlxscore=0 lowpriorityscore=0 malwarescore=0 mlxlogscore=999
 suspectscore=0 adultscore=0 priorityscore=1501 spamscore=0 phishscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2105200025
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/19/21 7:59 PM, Muchun Song wrote:
> Since commit d6995da31122 ("hugetlb: use page.private for hugetlb specific
> page flags") converts page.private for hugetlb specific page flags. We
> should use hugetlb_page_subpool() to get the subpool pointer instead of
> page_private(). The commit forgot to update it in the page migration
> routine. So fix it.
> 
> Fixes: d6995da31122 ("hugetlb: use page.private for hugetlb specific page flags")
> Reported-by: Anshuman Khandual <anshuman.khandual@arm.com>
> Signed-off-by: Muchun Song <songmuchun@bytedance.com>
> ---
>  mm/migrate.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Thank you Muchun!

Reviewed-by: Mike Kravetz <mike.kravetz@oracle.com>
-- 
Mike Kravetz
