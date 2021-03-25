Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F8D83485D9
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Mar 2021 01:29:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239237AbhCYA1f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Mar 2021 20:27:35 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:51528 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239254AbhCYA1J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Mar 2021 20:27:09 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 12P0O6Kr143456;
        Thu, 25 Mar 2021 00:27:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=lrLkTnNnl3P0syRqJXnR7FaZ32fUWcf26XmQ5WPi8KU=;
 b=IPYoAsAxezUytn+rUVtAW0/WMSnF9Y5snHuwgmtMtZ4iy66pIUNBY7ZF2KdMX4H7fRhS
 +emdK6o8NSmZ2GrDK8axUlA20mZM45IJu/IBsiPgv4VKcfNxxPiBEsFg1X8Py2nbP8Hg
 pp5wiPuVSpB0ENSM0WaEWt0FiwbrwZqhD70mvsQBFYvtGy2nz+bHraxmdGR8Al7vBArO
 tnZDgJzaYm61fuFA1y2pGlTi7ek5ZUDa+m8JbuqVq1NFYQjrFW0qXoGoxvUdYPR2QW56
 zHqlJ9MFphBMNSjsusiluyERklJaM66qFFNk9KvauuASKbwldrLIDqH3JLy3G27udcfF rw== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2120.oracle.com with ESMTP id 37d9pn4k56-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 25 Mar 2021 00:27:03 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 12P0PEh2162573;
        Thu, 25 Mar 2021 00:27:02 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2103.outbound.protection.outlook.com [104.47.58.103])
        by aserp3030.oracle.com with ESMTP id 37dtmrgnu4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 25 Mar 2021 00:27:02 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dfThCZ12DwBjGaoIaLy1FDgKSw+JbkcEUMi0IJiz/KgBqNRJ9v0rfJcDXsvlo+/uNDYSuLaVVBhc7om6GeRPf2tlpOoZVUfF/Q1OSR3a1oYrEcKjVi7puGZm5ItQBuBVkDX9x5SuTELvOdTL/b88JeaUsXE8lDwdl549fBzFh0Orhu14WJriHEtjX3EnpU+1Y1HEFSgglbZVjqLeS4sMPDvGosCST6AQZRtFnt6zwH3hvoz1UvYmALh3GYvNTSW76h2DK1be1xEaAJqj7Ag2B1VoJnNMw6tryfzNFVVvvicfu43d8ebiNYec5WhdJvE2fb7W05KS5lPV11p/9UIsWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lrLkTnNnl3P0syRqJXnR7FaZ32fUWcf26XmQ5WPi8KU=;
 b=LE/D6RLjUljUDmSUXugT9t2wEEjpmnHgnJQlUNFSn5qpuFKr5zPjREjOda5e5TBgzuGoIuKRMQsoOV4E73YFiknn9g/Up7wgJ1Vh9sxTWw4GZxFSu8ypLJfnw4F0BzNnBQtuLysqlnHlVpvP4nFUfBMwXcYjsRT9gr7nIAK0AwygSWKNBo+Ji5xXt3EzdJBcOV8SSv2J5dMAKTmQkEkPudCtVp3ckAwv/Uo8fPoRmJPpoPZlwkY111f4nbwoYZQPPhPe/dN7J6daAqyVFtsfXVFNz+O4LUDHj3VvUr+irMXga65nPEVJw9QsUg28hq3azU0J7SXSnrDK0vsJj+byzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lrLkTnNnl3P0syRqJXnR7FaZ32fUWcf26XmQ5WPi8KU=;
 b=sMERrCXT526KJ2CyBkVy9Y0ThGBDrPUIoy8rd8+rc+R7N3bEHCCzII2DnnBuylufU2oh0vEK9uFoBoho8Y0A1kLqmFcX7kg1u4xEJ24+CM8C37W5FYM/636Y3mJg9oOfdw2g9Ppfyf2Gw9ua3pisbAly5+g5pTxYEL7c5l+UdDg=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=oracle.com;
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by SJ0PR10MB4462.namprd10.prod.outlook.com (2603:10b6:a03:2d7::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.25; Thu, 25 Mar
 2021 00:27:00 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::980e:61ba:57d2:47ee]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::980e:61ba:57d2:47ee%6]) with mapi id 15.20.3955.027; Thu, 25 Mar 2021
 00:27:00 +0000
Subject: Re: [RFC PATCH 7/8] hugetlb: add update_and_free_page_no_sleep for
 irq context
To:     Hillf Danton <hdanton@sina.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20210319224209.150047-1-mike.kravetz@oracle.com>
 <20210320011857.2004-1-hdanton@sina.com>
From:   Mike Kravetz <mike.kravetz@oracle.com>
Message-ID: <196eb572-df9f-aa30-40b0-9a15b5522470@oracle.com>
Date:   Wed, 24 Mar 2021 17:26:58 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
In-Reply-To: <20210320011857.2004-1-hdanton@sina.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [50.38.35.18]
X-ClientProxiedBy: MWHPR07CA0019.namprd07.prod.outlook.com
 (2603:10b6:300:116::29) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.2.112] (50.38.35.18) by MWHPR07CA0019.namprd07.prod.outlook.com (2603:10b6:300:116::29) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.24 via Frontend Transport; Thu, 25 Mar 2021 00:26:59 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8019acbd-c4d0-41b7-f42b-08d8ef24b486
X-MS-TrafficTypeDiagnostic: SJ0PR10MB4462:
X-Microsoft-Antispam-PRVS: <SJ0PR10MB44624A2081BB67A8F421F87AE2629@SJ0PR10MB4462.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Lnhof/iJjc2vZuMujhiIvX1+0/TgvkQbiPpmDiLOYv20QU+H5kM8rlLod5Y/9aBUcdt6pNsT3No6mUqDiMAK0Wn1bN0w/WvZq6Pc+SLfeOTyKC+vfW829Zi35V5okgUOAMgLyyeMot47ofADmqILYCLsbCgQo5nNN/IPEU4wZfzdmjUH2Qe7MAYvFmCwXAnaDjJWn45Z5iwG4xiGs4gQOK6zKgI1X3sXDkwgIdewTlw+YfB1x0NmJ9PdI5b0VDc1cKC5FKOcr//AlrmvHowE/0cZ+pbOCUobLrwuQ1jIwb3Q5DgLN5EWQWUha5u7QpxPGdDXQw19q0TRBcgEYA89MudFBBaDneyw+hg3zPAVoEvlJdxtYSn4zoBN81D1tioPn3UauZ0yl4ITexIOJT082/1ffQdy9DXEgr2l/bo8lo3ApJ3y9a51ykqqGc85xJ8e/nEJATRCBi9OwCQlVIqsCWKw8+W/o4GHAq+Hc8gXjARDZpHSodR9XoSoKLRsQnvuQMuZ27cK7g/aBnFvFweGp0Vskvm9b8bNRgBbuC/4WgaYE2u26Q5bpOvi+xmc7kvH/WBTRz3s/Do0ON+wiyyw9oDrJoSLegj/qKncCqgnoByvKvArBU54uMkE7tD8Tg5Ds/lGvwiy9twmD8uVWN5tqVzCOsfdZr73oZnaGiV98y6H9DpmvnULHXXnDbbnlcYw4eIDK3Lp8ANg3napi496KA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(346002)(136003)(396003)(376002)(39860400002)(8676002)(66476007)(66556008)(86362001)(4326008)(66946007)(6916009)(956004)(8936002)(31696002)(36756003)(44832011)(5660300002)(4744005)(2616005)(316002)(16576012)(38100700001)(26005)(478600001)(186003)(83380400001)(2906002)(53546011)(6486002)(52116002)(16526019)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?SkxIVVByUUhtRW1tNll6K2NWcWZ6SS9LR0ZjMTVpbGdFSzQzMWNCVWxFWmtD?=
 =?utf-8?B?LytnTmZ4eXpSR0tPTWF0T3JDV1pzdHdYaUt2N3ZrbmtIN3lGRDU3THlSeEtI?=
 =?utf-8?B?Z21sT2JiT2MxdGc1blpIOEdWTGFaT3FqaS93NXRTcWFYVXUzVFVVajNFVFM4?=
 =?utf-8?B?QWJSa3dPZFpmTVpHdHZwQzhwblFNdm8rTlFWVFovSGtXZExhSzhKS2lyS0wv?=
 =?utf-8?B?aFI2Nkl3c1FIQ2tEYUJIaUZrYVZlbnRHcllnMEs5VGtxejlEbTVueUNsM1hy?=
 =?utf-8?B?YmVPNTh6bEpnQ0pHYU90Smg5MWpYS2JkQnUvM29CZDlNRHJZQ081WDFQblJj?=
 =?utf-8?B?ZC80d0xzUDQ5RFdId1pnK1h2eTNQNlVXS2pEZDlGMXhPV0xqaEYzaHdCV1No?=
 =?utf-8?B?TCtWNDlZOWVQVFNVdVhzZERTVjl5dmtJR2hsKytnSFk4TkFoYkVXWHBHeWFE?=
 =?utf-8?B?SXV6Qms5dUdickRvM1lwcjY3UFAzZTVxNkNJanJERFhvU0RHeFRpL0tCY0NJ?=
 =?utf-8?B?WElKMUxDU0lvOHV6ZmZhU3M5SUtRWTVvZHU4L2xmOEVlYSs0eEhZdXViUlVu?=
 =?utf-8?B?VWo4V1BZT0pNeHY1TzIyN1E3YTAvOHZDTUU0TjB1WVlYR2JJaXhRZndJWStH?=
 =?utf-8?B?VkNhamZjZHRVYUdCU0YwTEs3Mk4xMGg0TTh4Y3Z5RXNDdVQ0UEN4dkc5MlVl?=
 =?utf-8?B?YUtqVWlSbjdGTFdhZWNwZHpSNlc4UnJ2SGlaRGk0QTh5TG05d3UzcmFKWUF6?=
 =?utf-8?B?T2pFNWNWRXBCT0pldy8rMU1NWk1aSmduUkl5b29FMXhVVTJoV05YS21qbmox?=
 =?utf-8?B?RzZLaENiMFR6SVBPbTlVYXFSTXlRTUc2UUtWUUROeEFkOFdSbWoyd0dsVkJ5?=
 =?utf-8?B?WXBmTnU2RXNCN1Q2Q0J5c05iYlRNbU5QcHpraWozZ2JGSkJsZVZKYXpKTmEx?=
 =?utf-8?B?ckVRbGgxQ1hFc0k3UVZuaExPejNTdTBSZThiaXM3cVJBeFhIT29iVmxIdHoz?=
 =?utf-8?B?Vmp3RXJpT3RoV0NTMEVrQys0Rmo3NXQ1bUwvNGxueDlKVGkvdTdJcDQ1VGND?=
 =?utf-8?B?bC9vaWF2NXhXT0lGN0RLNHRDemNPb3dscUNadUFYamdHTHVKNmJxLy9MbFhI?=
 =?utf-8?B?dXhBU0ExWlFCYllZZFNIQ0dJVlVWWG9ITUQ5ZGtDclBHRnRGOGRubWVlR2x0?=
 =?utf-8?B?ZkkxUitOYWhyK3d4dWh1QVpndllmVG8yMXEwcDZUMW03dEgrUXAzYWxaR0ZV?=
 =?utf-8?B?eitDL0x6RlhKdUEwNWt6alhkRCtqNmVwVGxDMFhSMEQ2c3ZjL2hVM0tEOEpy?=
 =?utf-8?B?amZDcDVERlNlZWdDQWZuZm9uUFdUL3dtd2wzM1A0QmZvY2YxQXN1QWdBYTZF?=
 =?utf-8?B?aG5JaEprbDJvekZpL3RETHdFVElsNFlZWE1ONnJiTElYM1p6Vi9kSGQ2MWNo?=
 =?utf-8?B?ZHp3Ukt6ZzRwNUMvaDJRRFhXK2ZGVmhaNThaMW5wWGQrWFF4NlZyT1VxQzJM?=
 =?utf-8?B?MjlVcVYrcGhkWEZmajM3V0k4d1FGZFIzUHpKUzlqck1iS2JJdDZLRiswVmZ0?=
 =?utf-8?B?M0pEWXdMSC8zb2xNQ0Zia0dLOVlpN2lDa0JmaTU5d2tOckRKbHJDenUrS1Ey?=
 =?utf-8?B?c1hObThFYTdoanNGMkxXT01GSzJxNGZmSStkSmt4eERRZEFBc0VEMm9nMlI3?=
 =?utf-8?B?S1NoMExxd2IxSmNKbFBpckJOZThxeU5ZOUlqdHpHYTZiODFLMG9FcWZXNWho?=
 =?utf-8?Q?BiPbT3qXELBHAqpVENNas6rppZ4+knn//2hOpr4?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8019acbd-c4d0-41b7-f42b-08d8ef24b486
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Mar 2021 00:27:00.3711
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7dBbOPkkRkW4uyeQlHuXC6gfEPoQv3GlayWxOnRkcrKpfMUidhGWzd0eMYGrpmoeFxSIEO4x/RuOiWWoi9BihA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4462
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9933 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxscore=0 phishscore=0
 bulkscore=0 suspectscore=0 malwarescore=0 mlxlogscore=999 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2103250000
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9933 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 lowpriorityscore=0 phishscore=0
 mlxlogscore=999 priorityscore=1501 impostorscore=0 bulkscore=0 spamscore=0
 adultscore=0 clxscore=1011 malwarescore=0 mlxscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2103250000
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/19/21 6:18 PM, Hillf Danton wrote:
> On Fri, 19 Mar 2021 15:42:08 -0700  Mike Kravetz wrote:
>> +
>> +	if (!can_sleep && free_page_may_sleep(h, page)) {
>> +		/*
>> +		 * Send page freeing to workqueue
>> +		 *
>> +		 * Only call schedule_work() if hpage_freelist is previously
>> +		 * empty. Otherwise, schedule_work() had been called but the
>> +		 * workfn hasn't retrieved the list yet.
>> +		 */
>> +		if (llist_add((struct llist_node *)&page->mapping,
>> +					&hpage_freelist))
>> +			schedule_work(&free_hpage_work);
>> +		return;
>> +	}
> 
> Queue work on system_unbound_wq instead of system_wq because of blocking work.
> 

Thanks Hillf,

I am dropping this patch and going with Roman's patches to create an
version of cma_release that will not sleep.  A workqueue handoff like
this may be needed in the vmemmap reduction series, so will keep this in
mind.
-- 
Mike Kravetz
