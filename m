Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 187B5391DB5
	for <lists+linux-kernel@lfdr.de>; Wed, 26 May 2021 19:17:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234341AbhEZRS4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 May 2021 13:18:56 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:49052 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234273AbhEZRSx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 May 2021 13:18:53 -0400
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 14QHAeJO158045;
        Wed, 26 May 2021 17:17:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=1Q3k2EpB5/EjH3jCbZD+pPvbGuw5H2N2nJf/9G0NASw=;
 b=i8iVSFA0nEyPjGp35liHLRhKQo2gBu8T9DgtfaCkK2ZDoCofKmb7SboKMhrgzsOBy+Oc
 5gfGzGK5JAt2ZLciu6JWZgkLCvoWAHkLuVrmUk0d0RRqbH1QiNDy0DClVxZQFTuIJJRa
 5GIPhu1eMoY+wI6o+R1j5V5dUzTGYKwmxxTOaWfVI6TqLCT6zmG2Z6MfIW8tFsX3LGt/
 mrsuDnv/JCljPrH9V+MuZz3urkQZoJa/qLuYP6igz15L5jWAMhonKbkACKboMco+fEB8
 azXHHWZsM3JWBRqJd4WbCHH/EhRN9Eo/sJIdKg7Q0c2Razh+CQWHG1vAD2dqkS4RclTr rg== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by aserp2130.oracle.com with ESMTP id 38pqfchwmj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 26 May 2021 17:17:12 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 14QHAG7W175864;
        Wed, 26 May 2021 17:17:11 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2174.outbound.protection.outlook.com [104.47.55.174])
        by userp3020.oracle.com with ESMTP id 38qbqtghd4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 26 May 2021 17:17:11 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aNHdXnq0tycb/2bQ5l/DynYX+Ez7CPTDKh288YQIvLWBGwpsmV5e+MQ3kS0KU6HvyeOQpTORRcoyoUC4J9RM0fHXyUz439Csi0iS+VFR8TNQN8QFRhN/U8wzDgty46ehbL4YMF76JElaNbbqet9j+m29BDHAOlU8mI8ypEWBSSW5lT8KQprpz8ZTG+uysInYjiUb/imSEuIAg8XiQdUkpp/3gTBTXpdDt78yHOHl7isuXUoIkYdBPBqKjC+KLYZW4ixfrOWzA6vjzKEO1jjCp5H43JmHX7CYlUVDb7XXNGIRh6tLwqE8Vbl7Y+JSKhXUfMBgFzBLO2BUL8QxIu/Upw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1Q3k2EpB5/EjH3jCbZD+pPvbGuw5H2N2nJf/9G0NASw=;
 b=gQuMU3jGrUKKqYBRgporVMmm2gDFumoPzoHc0FpA29/9zzHioxSv4bmuxA8G/mrqxD2bHM11pewiKdEy7RGnGmEXzWIdQROhcB8BTEN62j1F5Vs9l4tpRbLEToxcl+wKnkStmP0pVJHQIPmuR2pdsZ94IQnikHPiT2tnRWYl3zsrs5FV7gJ45F9gMHVDZpt3wLjEHTZYuzU8VF83HpBdHqFsZeiiCpu9PFtO0x+N6ywLL02JCPCeTg88hz5tkah6M4YHEefxNCqbR+i8yvHUJE1uRn2Vv/c6GfKti5hE0ho7uxn1P9JAfPtBetjBgPc4nahmQo5UHpu2S/idgfUTNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1Q3k2EpB5/EjH3jCbZD+pPvbGuw5H2N2nJf/9G0NASw=;
 b=RsMyYCmQIfpIgmOiZ6uMUQf6L3FHRPx8ke/ErR5yEc97R4fns+jzqZYKJWHOK+xv55dRb4WxjXeIzqmexEi8xNERL8cwUNLIg5/MDxlE+fVpxISmVPlwYcJGKxu32FQ1Q7nrWX1Ee/pOrSWGXQibQI8d4bYU3k8v8qOiwNFrJUc=
Authentication-Results: linux-foundation.org; dkim=none (message not signed)
 header.d=none;linux-foundation.org; dmarc=none action=none
 header.from=oracle.com;
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by BY5PR10MB3970.namprd10.prod.outlook.com (2603:10b6:a03:1ff::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.22; Wed, 26 May
 2021 17:17:09 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::4407:2ff6:c0a:5d90]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::4407:2ff6:c0a:5d90%8]) with mapi id 15.20.4173.021; Wed, 26 May 2021
 17:17:08 +0000
Subject: Re: [External] [PATCH 0/2] Track reserve map changes to restore on
 error
To:     Muchun Song <songmuchun@bytedance.com>
Cc:     Mina Almasry <almasrymina@google.com>,
        Linux-MM <linux-mm@kvack.org>,
        open list <linux-kernel@vger.kernel.org>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Peter Xu <peterx@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>
References: <78359cf0-6e28-2aaa-d17e-6519b117b3db@oracle.com>
 <20210525233134.246444-1-mike.kravetz@oracle.com>
 <CAMZfGtVUvtCCEHN_V8iE4m9FAmiz9e5Z1CNNvnetXsrEwAVzgQ@mail.gmail.com>
From:   Mike Kravetz <mike.kravetz@oracle.com>
Message-ID: <1485e64d-e794-c24e-9688-51b0c1bc1340@oracle.com>
Date:   Wed, 26 May 2021 10:17:05 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
In-Reply-To: <CAMZfGtVUvtCCEHN_V8iE4m9FAmiz9e5Z1CNNvnetXsrEwAVzgQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [50.38.35.18]
X-ClientProxiedBy: MW4PR03CA0141.namprd03.prod.outlook.com
 (2603:10b6:303:8c::26) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.2.112] (50.38.35.18) by MW4PR03CA0141.namprd03.prod.outlook.com (2603:10b6:303:8c::26) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.20 via Frontend Transport; Wed, 26 May 2021 17:17:08 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 56b5d2f6-a097-4c62-56e2-08d9206a1794
X-MS-TrafficTypeDiagnostic: BY5PR10MB3970:
X-Microsoft-Antispam-PRVS: <BY5PR10MB3970CDCEA32D06FF427C74E7E2249@BY5PR10MB3970.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UvBHhxT8jYfhGlL3TrzxPwq+umFX378PH5RLKIBVN1EY0SAeQIZE+VuOCD4pY2lb3wby9UljGeG+VN4pMpu8caGL/RKiNBWR9uf5CcaELDKVThFNfYK6dj+0Rl61+HGAdUcen81m9pbkL56E120dhhNKwaQnbSzJjAPTQJ1cOxJMIgTjom03LmDU5y5t9kgLy3uLkXNB/Yi8KNTDcWLkc8FH4NzXTSKLOHLyp9UQQ+rCzqJoup/NVDwG1wpTrT+fPcm1z2EOWzglVAJZjKY2Ya9ve81IJUS+uEWVSYh9oZJRorOaClSIUgH/Y6juuM9Q9cgtJtqqGfQ/cd0O4C9rZjJRjvZLwsWX4cAVAg8l8qQKwS+js2/9PKYEiZEcA/YB7haI32Lkkucwfae9GaAVbAG6/PLezhgZY1JifL3RO4MyjFVpGzGW0NtpHEMOocQOimaOx42hfOissqqHNsuAO8akdsxkdQv4YnwcLTw+lg//XqAUnlBwmj29lL/kXJvBvdT9Oz0WEI81dm84BL0l171SSv3xXvSFJn/y6M4TwojRwmyIq2NoqJjzmWuFrrkywuqskPw/BCMcoFIHFLEyWkDVjnX9UGmjXgXotxgJ3cvcBiZZgYInH2zpEV0RM37MgAhznaJr33Nsf0KuQlTGhXvgvzUWoZj1lNDXGKa2arH8MaQFAjztbadc0nwnq6XbqiqDuCPWgBrnichP/UF3/w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(376002)(136003)(39860400002)(366004)(396003)(346002)(44832011)(66556008)(66476007)(31686004)(6916009)(8936002)(38100700002)(38350700002)(26005)(8676002)(16576012)(2906002)(66946007)(6666004)(5660300002)(36756003)(316002)(54906003)(31696002)(83380400001)(86362001)(52116002)(478600001)(16526019)(186003)(2616005)(53546011)(956004)(6486002)(4326008)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?R091cHFBU2hQcGpUUGpFbjhBOGFBRjhUWXUxREROckkzbzR0QXZob2hEY0h0?=
 =?utf-8?B?d04zVGxtbENMWFhjc2dQcEp4SnhxcExaOU9NcE5GUzIwSDhhN0UrYnM4Y0Rr?=
 =?utf-8?B?VTgwZnNVa0VYMHRxVEkrdVE2bGY5a3VsSDAxYVJsWkpMMEhrQ3k0YTE3OURi?=
 =?utf-8?B?cjFndVpEbytsQzB2S3VSb1g2cWxNQUdvUTdwRmFOYVhVVTlFZEJHZnFQRWVz?=
 =?utf-8?B?bFduY0V3cGhzaFdPM1Uwa093Mzljem85WXZTRzFBVTNRcDRpQTk1dy83OWxY?=
 =?utf-8?B?cmpYTWN0YVp5b25YRm1Kb2lEN21OZ2MzRjIzeGNMakpZQi85aHJuR3RpWGlU?=
 =?utf-8?B?d1V1SU5yN1pDVEJuK04yMU1DcEhGS3VuajA0emZWTmoxMk0xUnpSdTBSSmJG?=
 =?utf-8?B?MWVHYVdlRFZjUitERHE0T09XaVRHSkNRdTg4S1VOWVp0eGorWHdtUDV0Z01T?=
 =?utf-8?B?MW4yVHNub29WQVM1S0E5bWQwdGpZczNjRXN5bEVvZENxbHlYcjk1MkZtZVEz?=
 =?utf-8?B?aUNKdnVTWWU0ZkVnMkFLYXhYZHpGSFY5ZXJ3dE1zR0oxWkNFNS9Oek5sYXhO?=
 =?utf-8?B?WHFyd0FLWnNGODdCUUVscGZHbWhIb1pIekNRMlNaRVh6UmFqb05Ld3NiZW9r?=
 =?utf-8?B?ekxIRXlJRDVialpVZjlvWWJMNHJjMlRnVzJLZEFzRE9IOVBMOEZGN0lJSGJy?=
 =?utf-8?B?WTF0VDZJRm9RaTIydExOdFpQY1ZpZGhrRlYwb3dRSkJyNDVhSEQ1NXNHVkd5?=
 =?utf-8?B?TFI0bE9BOVlrN1BoZVRHQ1V3d0hRV1VFQzlVQ3BiN1ZnK3BQekdvUXdvN0pn?=
 =?utf-8?B?SE1zV2d6R2twRVo3Y2dZNjJ5WlZkZHpUOGJWSXFHLys3SER3NUVaak9iejhU?=
 =?utf-8?B?MW5tMDJmL0dEdkJQS3l5SXk5SXpONGR6bzBpTUdoSWpDbnl5b21EMWJNcFp5?=
 =?utf-8?B?akRDMGVtVWFBU01mZ29tN3djVGdLcU1UdGttRllHL1Myb1NEYlhUejFtd1ds?=
 =?utf-8?B?Zm4ydFZyNjREWCtOZlZjVGNmWjNhRTNzMUZQZEp1aU8ydWc2RUZQa2JmSGti?=
 =?utf-8?B?OXpobHlzaGdPZ0RhK0YyKzdObjRTb2tQQUJZWGpIWkFTa2VoZ1Ixc082NkpR?=
 =?utf-8?B?V2kyWWFYNkpvSjl0ekdEeFZ2SGtYSnVMeG9mcXpqTXljZytLaEs1MUtrZXM1?=
 =?utf-8?B?QUxOYU95NWVHa1V5WExCWUZEbyt1UkRiUmpPdVVvdnFnRDNyOGNKRUQwOGto?=
 =?utf-8?B?czJDRC9lYzZSdlRWU2hXUU9UZmFCZzdZaGRsa3VVTmJLemwzL3U3NXpjY0Ev?=
 =?utf-8?B?bXdmNno2ZWpSTytFVEx4UVlSYW1WTDBEZURodVZPc25NeENnOGxkVWxNd1Bt?=
 =?utf-8?B?RkQ1cWdWMXd0UGQ3dU9VRU9ac0g3RHhqZTFMS05TQ1QxVTRVUDJNbk8yWDE4?=
 =?utf-8?B?LzJaMk9DcmhrQ0t5dHFnQnowc1FCak5LcGFlTUlGMzdJU3lVaDF0VlQvdHh3?=
 =?utf-8?B?KysveFF4TE9CTDFtQytXUE5zZnNtSFdtQlh4OVVaMXdZSUV0eDhjNnM4SFFw?=
 =?utf-8?B?S09hMFJ3YncvSng3V2o3ZWlSRUJNMEt6MnRMWXRMYmErV0FxSjR2Z1h1MzZK?=
 =?utf-8?B?MHFJS2o1YWtMOGtmVzdtRlNQVGRSdkFoNmpwa3pnNkhySm43RmRKOEhmakNp?=
 =?utf-8?B?Q2tkM2plWi9rei9JSmZMaWpGVUxaMlF5U2FLa05ZTXc3VGY2bEJqZFN2dlJ0?=
 =?utf-8?Q?MDo3hYkEdjAIAhvSHGj86dNJc0vbFQ5uKJAyqf0?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 56b5d2f6-a097-4c62-56e2-08d9206a1794
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 May 2021 17:17:08.5896
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jWtc1dNkIU2+TwrwVtEKqRuZM8lVI0W8RjpplHxJx21glToduXPO7+GT7sRvrqYEsF8Q+eIBNUWN6OCbx2O2/w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB3970
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9996 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 phishscore=0 bulkscore=0
 mlxlogscore=999 malwarescore=0 spamscore=0 suspectscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104190000
 definitions=main-2105260116
X-Proofpoint-ORIG-GUID: J6sKkBpUaqhGjZn1faZPZ5tsRtlJcisu
X-Proofpoint-GUID: J6sKkBpUaqhGjZn1faZPZ5tsRtlJcisu
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9996 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 spamscore=0 mlxscore=0
 malwarescore=0 mlxlogscore=999 lowpriorityscore=0 impostorscore=0
 adultscore=0 phishscore=0 priorityscore=1501 clxscore=1015 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104190000
 definitions=main-2105260116
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/25/21 8:19 PM, Muchun Song wrote:
> On Wed, May 26, 2021 at 7:31 AM Mike Kravetz <mike.kravetz@oracle.com> wrote:
>>
>> Here is a modification to the reservation tracking for fixup on errors.
>> It is a more general change, but should work for the hugetlb_mcopy_pte_atomic
>> case as well.
>>
>> Perhaps use this as a prerequisite for your fix(es)?  Pretty sure this
>> will eliminate the need for the call to hugetlb_unreserve_pages.
> 
> Hi Mike,
> 
> It seems like someone is fixing a bug, right? Maybe a link should be
> placed in the cover letter so that someone can know what issue
> we are facing.
> 

Thanks Muchun,

I wanted to first see if these patches would work in the code Mina is
modifying.  If this works for Mina, then a more formal patch and request
for inclusion will be sent.

I believe this issue has existed since the introduction of hugetlb
reservations in v2.6.18.  Since the bug only shows up when we take error
paths, the issue may not have been observed.  Mina found a similar issue
in an error path which could also expose this issue.
-- 
Mike Kravetz
