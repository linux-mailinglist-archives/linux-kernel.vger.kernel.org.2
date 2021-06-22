Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 35C873AFAF7
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jun 2021 04:16:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231346AbhFVCSn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Jun 2021 22:18:43 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:26340 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230312AbhFVCSl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jun 2021 22:18:41 -0400
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 15M2CQR9002131;
        Tue, 22 Jun 2021 02:16:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=LfbUHGN2ELZAlGbw/jUYGv49sCeobL3jmICi0zONRRI=;
 b=OkOGTBuhf22ao6tlQRUc242TfUGssSSngZ1zWfVhib8KZ9CND9yfkjdRHciYnt+pn90T
 b5UoGvsWVscRSOSjzBp/ikzkTu1OVSbBTN1uRY07venSI3/TAWp1glLGdcrn0D8hPDSn
 SzQWB1Qj2H0fVsOUlE59LoeBLWWqj88sWIO8x/ngeP5lSN0c8T0DByBqq8TQAh9oPYtn
 ljBx3/gjkYBzuNWeJRHmL2jM81VrYtnJhSXik0k4WalZN46BIPh9rswynHb6U4lCnri/
 vWF5J8neW26Baks59W79GRCsVXdm5GCz1p8L4Jn6QRKK4EF/5yWFPJVckSFj+I27pcVB Dg== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 39acyqanf7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 22 Jun 2021 02:16:14 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 15M29aWa033458;
        Tue, 22 Jun 2021 02:16:13 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2106.outbound.protection.outlook.com [104.47.58.106])
        by aserp3030.oracle.com with ESMTP id 3996mcqpgs-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 22 Jun 2021 02:16:13 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MP0gkmAQHKQmCPIRNzVskmGGgagdXVcCNntvpNDM4mCpQYdohQembHU+Pzg+rptfFRLsO1zMDcJ2H3nGADQ08394vJIhOf1FTzRmOSerr8sLchck+PACQuF/Yg6Qr2FNaflIIxc80zhWZCFs8nCK5JkgirqhAqS+Yy+J0+oZkYvNs3uouSnads/kP1V3MBGZp1shuCmblDDWGsyNKacNEQdrnLSbtQ0uR+WfbTycXlRqd7ItCJv3wGG7FHZzRtxt9u1pYGfcgAWboQpWleOmGqQSaWoSrBJfkvklqo8oujsyNYhmC/t5xWGzw3G372b+l5sQhVV5srj6VZ8YRGQAzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LfbUHGN2ELZAlGbw/jUYGv49sCeobL3jmICi0zONRRI=;
 b=biVDHXUzTllCvvbeMyF68MwTKPbg3aSNyq3bUkFw2lqMhYmW4jGOOSfR0Ya6zXx7fSpTXN1Asghg515e+SFsc40AfyeWCO0uEZjreMud5bmc48U1Mv28t7L0//WqMZHXV8QDKNc3F4MH6wrHhXgWBn691nQpRRI5ctLZU5xtJGWULHG6yDleSMFStPwTP2RJvRffpidozprXOFa0b9OYWhc6PpmgEx1wzmiA5i4+Ys45bUekNY51ZHFhkIdbTkbBdzLEsWVRBJy7+YoEjuab9zlGA9fXYB/O0WCZLncVJ/vx2GcoWtvHP1VYak/FKRHgzhnoU45TvAFoskM3RwcAAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LfbUHGN2ELZAlGbw/jUYGv49sCeobL3jmICi0zONRRI=;
 b=Vq4sUqtGtuzEj7rtDY8+oqkF9PbutgXEo5A5GziuWAqtDP+UabT+ChXZTnEzzdMoSW0PJQe9Y81w0q7OM7yrqNGOp4nUdCbGSfDBMiRbp8k+ZM7prDYOFMdQG6E0J0CwnaC1ajN74RXp7xEECknmuOs6DfAs1VZhbYXFuj5BrGw=
Authentication-Results: linux-foundation.org; dkim=none (message not signed)
 header.d=none;linux-foundation.org; dmarc=none action=none
 header.from=oracle.com;
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by BY5PR10MB4114.namprd10.prod.outlook.com (2603:10b6:a03:211::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.19; Tue, 22 Jun
 2021 02:16:10 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::5d11:ae6d:24b6:e838]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::5d11:ae6d:24b6:e838%4]) with mapi id 15.20.4242.023; Tue, 22 Jun 2021
 02:16:10 +0000
Subject: Re: [PATCH 0/2] Fix prep_compound_gigantic_page ref count adjustment
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     Jann Horn <jannh@google.com>,
        Youquan Song <youquan.song@intel.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Jan Kara <jack@suse.cz>, John Hubbard <jhubbard@nvidia.com>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Matthew Wilcox <willy@infradead.org>,
        Michal Hocko <mhocko@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
References: <20210622021423.154662-1-mike.kravetz@oracle.com>
From:   Mike Kravetz <mike.kravetz@oracle.com>
Message-ID: <cc803eec-9405-73ef-57b8-d1826cf2ab64@oracle.com>
Date:   Mon, 21 Jun 2021 19:16:07 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
In-Reply-To: <20210622021423.154662-1-mike.kravetz@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [50.38.35.18]
X-ClientProxiedBy: MW4PR04CA0071.namprd04.prod.outlook.com
 (2603:10b6:303:6b::16) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.2.112] (50.38.35.18) by MW4PR04CA0071.namprd04.prod.outlook.com (2603:10b6:303:6b::16) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.21 via Frontend Transport; Tue, 22 Jun 2021 02:16:10 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e2009d97-9338-4e08-fa92-08d93523b3ae
X-MS-TrafficTypeDiagnostic: BY5PR10MB4114:
X-Microsoft-Antispam-PRVS: <BY5PR10MB41148D7591363E74B67DB570E2099@BY5PR10MB4114.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4125;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QfpIZSxWw5SFTz0DKqSdk1dLKsCj9HObGCw2kzX//WyWD3MGtQSauOh9pndEHqRR8oKoFlcGAyl/PIpbzvWT5w1GvlIEeXQC2EQLITfJrARgOPz3hj7FLssTZftESPEZDgjumHa8j04tsOGXy1b9LB8GkAsyZLH9WZe4lcw4HuLEzRyZktoo+CUSe0IadGjnAahMckyORTlzRQFL5NL2EClsyZNYwPoCZ/77fVzgCfZ1wtiYAtKx4/MnQ+9ZQaNwYej8C0lVMeOEw4uNQ+x2ZxXAekvqzWenmstaAfGhJJtty9FKZjtNhL9MNesgDPaM/IcJw0F7SzGNRM1VYpkH6q13YV11NHIVqBfzkJl0ZKURszX2/jCdiB2AotR1Oh37cm4Wxfogv7YC10f1rdd/0xAkP4EG48tvwZglRIc4DOx5VDrmPGIPbgXFrvR7tfdDfI9C+/TrdzcaiTt8ultirQ9b7Q6LcTuwAAULvx6155EWlQPVVPHvVlaP/R2bcQnIbIosM61ExqX/52NuT3e6kgNR9jAfg1M8jvcBCvxz8+jYjGsq5RAD4zqC9lpO2eEz/fg4zjRZkRTDKf3VZYy24XT1l7E1z1JTialtwfdUMpdSFURor0frRDlLJ3AsyG7uDeFtmNU4WmDuFXBElUeHBrY4QkXaN2DMniFC3IvaO5WANDkxgCh37NHQTZp9lwBr6pW5A467E6B023enHhCl82NZW7UUWmZM00P3EXyl8GI59i4UnI6r7hW+ZdoouNXYnFDRUCgILWcxMnxt+ynr+o4SMPUkaM2e93DfqKhBhTD0WYdqNK2isJRCilCsERhCaYnStfsGnyubzjnjSAFK8Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(346002)(366004)(376002)(39860400002)(396003)(136003)(2616005)(956004)(54906003)(53546011)(52116002)(44832011)(478600001)(8936002)(966005)(66946007)(66556008)(66476007)(316002)(36756003)(16576012)(5660300002)(6666004)(186003)(16526019)(31686004)(8676002)(7416002)(6486002)(31696002)(2906002)(86362001)(4744005)(26005)(4326008)(38100700002)(38350700002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?V3FTSVZtQTJZMFRVS1ZjdVY3RlRWdXFEQmM3Z3FBTFJjbzJST0hDenAzK2Q4?=
 =?utf-8?B?NDROWm9aa1pzL0N0UmM0QXFNdy9TWmtDb2pkN21uVUFiU2thL29JSnpsNFYy?=
 =?utf-8?B?UWdoZ3BUWVVDb0lFelZ5SUYxOHVpK1V4SWIvWjJMbXVCdHkyNXVwYjRENDhm?=
 =?utf-8?B?M1I4TEd1c25HRlpFTDVhZUh4b2t3ckk4T3JtdkxHRWF2bS9pVitnV0syRlUv?=
 =?utf-8?B?akduZXkxNmF2Z0t1ZVdXZm5Sc0I3dWhwdDZHSTloZ1JTalowbWpXc09JNmF0?=
 =?utf-8?B?eFFFVWNPcVRSSjd3aVVINEZmQnR1cGhzWUZVSWVxOGExb0h3Y1o0UmNkZ1dK?=
 =?utf-8?B?OTBlcnJTNHdHM1VBOXROdnlscDZKVXRUbTFUR3lPWXpwLzdncHF4RU9reGMr?=
 =?utf-8?B?REhNT1hoN3R5OU5MRE1Xc0VPYTZXR0tJcXVFM3d3U1g5d3ZDQkhLWk9EUmtJ?=
 =?utf-8?B?NWlPNVpGYUszcFFMcHAzNHZ6OTFPSCtFWEFYV1l0WXpNT1BnWFU5dit3dUJu?=
 =?utf-8?B?TGVpZjVLZkYrM1N5d0RBUkh2NEFEWjQ2dlkwRXY2M280b2hUenE3d0lLYlRi?=
 =?utf-8?B?NWsyNFEvdlQrZUY2elkxMHQxcm5qRy9yZ1d6dUYwTDdVaFBsaDRibFgvbmM2?=
 =?utf-8?B?d294anRodUpMT0R2V1ZSRHdmZkkzN0FYREV5MkIyb1NHTnZwM1FjMlg2M3BF?=
 =?utf-8?B?dHZXSE1IVEk1MTZsSmhEbGNUcVVLbnBnV2I2cW1mY284N1ZMTXBmYjFXMC9R?=
 =?utf-8?B?a3JwUjAvNUZmMnpUVk1nUVNmVXdlSGlUeDF6clYrM0FXNTU4eklUYXVTOUdV?=
 =?utf-8?B?SzIwTStxT2Y3bG1LT2xGRUFFWEhzSGYxcmN2V01Ic1FGZTFKVFgwd3NwQW9W?=
 =?utf-8?B?OXUyY1hKcEo5OGNENmREU1pYR3J0aGpzSjJKdk0rOVg1dFkwVTdsNnB0SGpm?=
 =?utf-8?B?cTV1Z1VwZTRXT1JzTGt1UjVMb0ZObmg3V05sL0NEWXhMR3plWkVtTHhPQ1Fh?=
 =?utf-8?B?T0dtZ1BXc3ZGZTMyN3NNeWRlb2lVRDhyY3pLSWcxVHBua091UnR2d2hjbEEr?=
 =?utf-8?B?QnkyU0tMbFNuQ0N4R1c1YVRxMDRWS3czdkp4TU9aT2lITTQzMmx1SDhnRHNt?=
 =?utf-8?B?d0VCazdqQ1pxUGZZVmJzMHB4Yk04ajg1c095MWtzVysvd2YzN0gvbkpEbWtL?=
 =?utf-8?B?QmxvTGR2U3V3b3QzRHpURmlFaVFmSWE0c0VnTFRDUU1ZdjhxSDViQVZkVEtr?=
 =?utf-8?B?ZkNzOHB1VUdIYk5nOHFoTlFnYUF5NzA2UkJiREgzdE02c0p6ekxBZlFreFBl?=
 =?utf-8?B?bzdWTjFoODBuNjZQbE80YzYyM2JTOFZHOWlVSVJJWGNRYmZ0ek40TS9nVGdU?=
 =?utf-8?B?V2hSbStFSzhjT1I0ZGt2ZndhK21hcnhNY21WeTczUy93cnVXeFVNUEhXUmls?=
 =?utf-8?B?MUh0N1RkOFNiQm10MGdQdWlLUW5ROWlaMis2Ti9WNStubll3d0Ryd3JsaXY0?=
 =?utf-8?B?N2RlTXNveS9Xc01VbnYvdzFoOVFRdFFMU2tha3E5bjBOTFZyQU8yS2VaM09M?=
 =?utf-8?B?bjBTK2N3cFlqdjJueGE0T3lleURzNm9uMm90emkwWnJzN1B5dzl2R1RnZVRG?=
 =?utf-8?B?L2xjeWJMcWpDSFZKaHU0WWg4U1F0NFRhMitEbHhXUHdQbTJWRTU0UVVSeEpw?=
 =?utf-8?B?U3VwRDdjbVhaNW8wUDhxMlF6RUpOTlpycFVibkV2dzh3QUhuR25CbXpIcUky?=
 =?utf-8?Q?UYmR47ohkEDSrHhsobsO3wmb85SXYTVU2d4ReaC?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e2009d97-9338-4e08-fa92-08d93523b3ae
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jun 2021 02:16:10.5577
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: I55jUaFO+iGJ3kYDs4pZ3jQ1T4zGTr0vem98sIQ6VdbkbFucrk/iMMYgQiN34PaTQLlRfPzJ05lJkcuUbwzqdg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB4114
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10022 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 mlxscore=0 mlxlogscore=999 adultscore=0 phishscore=0 spamscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2106220012
X-Proofpoint-GUID: 9yhZfAZ3wpyEiYtWQQUB0CJRTDK8Rpoh
X-Proofpoint-ORIG-GUID: 9yhZfAZ3wpyEiYtWQQUB0CJRTDK8Rpoh
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/21/21 7:14 PM, Mike Kravetz wrote:
> These patches address the possible race between prep_compound_gigantic_page
> and __page_cache_add_speculative as described by Jann Horn in [1].

Oops,

[1] https://lore.kernel.org/linux-mm/CAG48ez23q0Jy9cuVnwAe7t_fdhMk2S7N5Hdi-GLcCeq5bsfLxw@mail.gmail.com/

-- 
Mike Kravetz
