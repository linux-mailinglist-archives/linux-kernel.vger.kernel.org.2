Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E48C45CC6B
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Nov 2021 19:47:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233119AbhKXSuO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Nov 2021 13:50:14 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:30968 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236484AbhKXSuI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Nov 2021 13:50:08 -0500
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1AOHX1pq031529;
        Wed, 24 Nov 2021 18:46:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=ygQrIGCzIbOrgfw6OvPCu6FQlsZoOgGc6tTnKUzoqOk=;
 b=KJqpTzumOtvCBwG5D5v0Py2svKI37M1PvkyPt1DS0xqHijQFF6d64Svyc1BJUYl5qU2z
 hi63xJ9myJYu9qGUGCnl4D/YMtTzRrWfC2BA1p4/6jn/4Z5G9mJWf5nHRB/n7w3B6qby
 XS0dRI25wW3msmypvCUEUwihg2ZGJjMmX0zreFH6+4oS/7ekvtYRWtOEMEY65oV7Shbe
 +I7MVhJgA6GmrZ/2SBZKaFTuX1NrkYSTKii+lmzVyMEhqwWR3UCINKsK4Uer4C/UebVl
 diW3pansNjYHHkCBcBDKKTO2Fe09Q75vQj7SXV7qtSFWD+fbnD45CdW0qLjk4CEROAFy rQ== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 3chpeesshu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 24 Nov 2021 18:46:49 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 1AOIjIbA013403;
        Wed, 24 Nov 2021 18:46:48 GMT
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam08lp2043.outbound.protection.outlook.com [104.47.73.43])
        by userp3020.oracle.com with ESMTP id 3chtx6g6x8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 24 Nov 2021 18:46:47 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ioZQajqpqfOSD57Ea+YyVgHpW3Pp88oNj4+4zp5fMBJCZwH+Za2O10ZhxT7t09v/8n+UcwwOlaEznwGC754yT5aYw2nv2LIcQNCidMyZLb88uqyBe4ESC7aExv+a2G1Bj1bBjpuoCP8Y7dDXXcduqep4859G2f7MpM74kJJQcpce7BUYkasLeE9dunUB+/hlQypFn69/mhH0xKgRWSfmWyn8FHgfnGEgnhOuqNbZvUq/lvC40g+bfOmLJTimIQpFGeX6rdUOos3AVO/GHlY7cWkt+mKpLu+jnAOPJQ5nW0A+6JqsiONE3Y1Wu5gk2qFtjk6MwHBlarHjaD9pT6pcsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ygQrIGCzIbOrgfw6OvPCu6FQlsZoOgGc6tTnKUzoqOk=;
 b=YxGhy0jFnpjPDx5FJrN4GjlKCqo+0wW02A7R9D4muu/LypT//cc9EfYY32lNGHkbdE1KC6z30ISmTHS7+LYHHeeq97FeRIpGQMAh78HfBWcieFN2KwleM9NBc8jWWf2hhLEqwQgOAgw0mTkJE42IGhBjHnYxa+ox4ErniJLfMSJVKGgDrJlWt/iLIopVYgUqmYWSGyEOdfXaZg9QoTPBqbZvcEGEZc6TqgbH7Fhl3SKxYkUs2ad9mePifXB15pUEOOBek1mgkqpDtBhQQd6sS5qQmSZv0qlfmEbQEl03X93A0NXPsEen396MEy84JBUCZDCjWmlwr/uKL5ruvQAzGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ygQrIGCzIbOrgfw6OvPCu6FQlsZoOgGc6tTnKUzoqOk=;
 b=VwT7QYRZnlOvZKoW6TUPzMAUNExkZaQPlH8fsdPl0x2QfERL4DZyZsFZkUXHwvwsk5Ep/NeC+u4eRC+opgqTCIzn/VLRRj/j9WMiX6FF5XzF9JHmphPunHF9MMck3hP7ELUd7Izmv+DGDrHYu8hu5dieXlCrulxfUG6S9Id3Vqg=
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by BYAPR10MB3685.namprd10.prod.outlook.com (2603:10b6:a03:124::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.24; Wed, 24 Nov
 2021 18:46:45 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::b5bc:c29f:1c2d:afd7]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::b5bc:c29f:1c2d:afd7%9]) with mapi id 15.20.4713.021; Wed, 24 Nov 2021
 18:46:45 +0000
Message-ID: <f5964806-992c-d8e1-45f0-2181ee10a83f@oracle.com>
Date:   Wed, 24 Nov 2021 10:46:44 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
Subject: Re: [PATCH 1/3] mm: migrate: Fix the return value of migrate_pages()
Content-Language: en-US
To:     Baolin Wang <baolin.wang@linux.alibaba.com>,
        akpm@linux-foundation.org
Cc:     ziy@nvidia.com, shy828301@gmail.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <cover.1636275127.git.baolin.wang@linux.alibaba.com>
 <6486fabc3e8c66ff613e150af25e89b3147977a6.1636275127.git.baolin.wang@linux.alibaba.com>
 <13b2c5d1-ef3b-3e29-32fe-cb4294bb1531@oracle.com>
 <76c241cc-5de7-d083-312c-373645ee8a77@linux.alibaba.com>
From:   Mike Kravetz <mike.kravetz@oracle.com>
In-Reply-To: <76c241cc-5de7-d083-312c-373645ee8a77@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MW4PR03CA0250.namprd03.prod.outlook.com
 (2603:10b6:303:b4::15) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
Received: from [192.168.2.123] (50.38.35.18) by MW4PR03CA0250.namprd03.prod.outlook.com (2603:10b6:303:b4::15) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.21 via Frontend Transport; Wed, 24 Nov 2021 18:46:45 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 68a3a235-9f19-427a-1421-08d9af7ac3dd
X-MS-TrafficTypeDiagnostic: BYAPR10MB3685:
X-Microsoft-Antispam-PRVS: <BYAPR10MB3685C085A3CC1FD9F7985C15E2619@BYAPR10MB3685.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1923;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 42Nny3cCRuMeOxs46SL60Dfe1CCNSBtMwKxaTz+BkUaxXqz0dsMPqcMX3AnH+tq+Z3dZBiZwGRWrZgqXn3CHG8BHFuMXj+/JUfN3BznJZZBGUzT8pG/awkrCJ7HlGiNAcfPnDth0Fw/M/SrlIUhliHV2+bxaXdR0KA8HB2bYTX2lOOsefzULvaBALT6E7qfSoUZziiFnJQaCa2QOQN54a/27P1+oEeaxinFV1qtFxGeyu8a5RIUob20vqvce4xXFFfdVbFh2IzjSwKOVNATP13WTO0ToKUBFih3XOjNoCroY6LaOFNcUnDec5X14iEMMEtcAaCE+RKfZTe2C9oTAOPDjSUIYlAz3N9nECmmJfGWR7ooCJMVoBX29fbmzqsBi7wt25Irqgkz7IDSbENar+MfW6B1XHKMHE4BhZFpcRxkE8E6Is7ByNY0TYU15t/Qtr33oVzXPUoUc0JMn0r2snZMa4eTwzf7WCaLxJrbcIFhAvDHm1jd2az4BwXs4IkEbB/ToXYlKdFYGB+hY4BI1Zy2v1N18LsuVK0UEff3b0E7a5Uqh/Io1FrRicG1F9bhMWS/EPiJFPN7BKn0FEBWlboefLSXwAHuw0TVu+9AsrFCoS7/RAOocQj6vE9blwaU3Go8Ou5IMvePd05rL7kyJSPAcpmCO6aM2XFIUyEjeFJCB1v+53afi54exnv+3tcVkC4H5HOCpPVzDx/KLXGY/zutP9DnH7mL8spar+BVr24wkUceuIj48G7OEnql66gge
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(52116002)(4744005)(8676002)(26005)(316002)(508600001)(53546011)(31686004)(186003)(16576012)(956004)(2616005)(8936002)(6486002)(4326008)(5660300002)(36756003)(2906002)(31696002)(38100700002)(38350700002)(86362001)(66946007)(66476007)(66556008)(44832011)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Y0hjMCtDa1dEK1A5c1pQdFE3bUI1bjlXdFZVRjdtQW1DTTNsdXl6MVZiMk1k?=
 =?utf-8?B?OXh2RHpTYzZZaGFYTmY5ZDlZL0xRMjRkRDBIelFGUHVva25qY3BPWnliTHMv?=
 =?utf-8?B?eVhCMUMvKzBlK1JrM2xQUVRma2VaeG40a2JhdHZocWxyNEJ6WXV3US9GdjVa?=
 =?utf-8?B?YXlBbUFiTkFPYXpjbitONFBOdlhhS0d6ckdOSklxS0R2ek1sTUM5dy84TDM5?=
 =?utf-8?B?THlJS3VvUE1MdHdFYW1sbUtOOFp4aVNSSmJFa0RzM1B4MHIvZy9GS3Nwdnoy?=
 =?utf-8?B?Mmk4SnFkMEtFUDd1ajZGb3pRWk0wVUk5QnR5VWtDeDRHdFdQQWF1VUJwSW1Q?=
 =?utf-8?B?OVVEMHBobjQ1ZWxQbVRtR3BvS1ZvcUJMaFo2TlQ4NG1keUtKbFAzY2llcU1v?=
 =?utf-8?B?bzRsRXFmL2RoRkdKdmJzWGUxRDY0ZEsrdk96cmVWaVkrT1J6MWxVR3JKSzB6?=
 =?utf-8?B?bGZzb0JFQ1VNaVRZNnUyRUhmSnJQV0JKZzA4VjNaaDA0KzVjVGR0ekpGVjZs?=
 =?utf-8?B?VkUxQ0NLQnM0cHZXN1hadFJ0MW5oVGY5ZENMUDE2SXhwMXlrNFROSXlJVk9X?=
 =?utf-8?B?QkR3dVJSUGVwUWcrbk5pd01pSjBLRWdEeU4zcUpyaFhoaDJIYVZtMEFUdGpK?=
 =?utf-8?B?a1kvVkxhMWVMR1NiVGxMUFpFQ0syN3M4aXZXSmFCTXNyRlRqYjFTWThWWWpj?=
 =?utf-8?B?c05XZVg2WkxkVXN1eTBoY2kxcysvdXNidVlWdjNHTHRrSVZMM1h6T1NCNXk3?=
 =?utf-8?B?UVVIMzgvTHRIcGJ2NmZsZDBmamI4NmRxUHVaaUN0N2NSZ2ZGZWU3aUhMWS9r?=
 =?utf-8?B?V3RqVExVZHNtcUp4WGlNZWZLaldOSTRRYkkva3ZNMVRtWTJMc0Uvd0R1OE9v?=
 =?utf-8?B?dVI0UmJsdkZaMVY2UHhFY0dUcjh4TDVIQ0NjVTJLTGZ5NW4ySC80MElkL1ls?=
 =?utf-8?B?c1VTTlEvL24vYnZnbzFvV3BxdHpIZVl3NWZkZWtxZTVIWStIaDZvT0dRczBx?=
 =?utf-8?B?M1lwM25IWlBobFFOM0VoY3RkVVpVUndDdVkzMHNSQnEwQlJVOWtuRGV5MGVY?=
 =?utf-8?B?VFRLS2hOSlVUTHl4V0tvbkQwU0tucGtRZU11OEEwMG50bVJQU2FUU0FpbW1I?=
 =?utf-8?B?RnVUWDN3T1JWWm1rRVhHL0F0cURlMzFuVnZLeXBaMGozcUk2aFdMNW5mNnNk?=
 =?utf-8?B?VkNhKytlN3dmKzRGSXN1bm1mQnFrblRhMDMwOHJ4ZFBHcHhubWJlaG5lM3FH?=
 =?utf-8?B?Y1E2dzgwc2JReks1eUJzSEY4UDVna1QrWFhSTWh1SVlOL2ZLdUJrelRQUGla?=
 =?utf-8?B?U09OTU0vL2haQXJiVkpXcDdqNTVzVFdFNVI1NnlFUW9FL0Fndmp5dVJqNGE2?=
 =?utf-8?B?Q2R2YS9HVUc3WHVza0Y0MTlUK2ZJMVlVT0pWeXZ4QVBKa3MzRzUxbWQwNnZF?=
 =?utf-8?B?a3QwWnM2Z3BBenMrbXloNGQ4V1J1d2dkQklTZmRjVVI5bG5nMDFobWZCQ3dy?=
 =?utf-8?B?ZHBGb3pMSm5WZk16VzFUM1BZYjMwaGkzaXk1ZHZ5d2xhUWVubkJiOU5MWGJv?=
 =?utf-8?B?bXFrUnVRb2hoRVZSZS9hSVBkWmVpY3c5M2J5YjdsYVdsMmtNQ2MwRzJ3cUFr?=
 =?utf-8?B?RTQwS3B3TXlGWHZKaENzK0lkbm54SHM0U0d6NUxDM1ZNamRFbWNyNkUrRUpt?=
 =?utf-8?B?cTVIMzMrZGhuNGQxQTV0Wll2ejRpUm01YmZWMVpTa0p6OVJ1TnVXQzVKajZF?=
 =?utf-8?B?aFVSYmNraENvanE4ZEs1WGwzeVdtREdyYlhsdnV4OTZhNE42RXBuMnVuL05K?=
 =?utf-8?B?T0tmdk1hcEZ3K05acHdMd1RWcUVxTFR4VUZTRUlRRVkxd2lNSmZFbnpnb0N4?=
 =?utf-8?B?cERvUmpvV1QzWFNkejNZaEJPOTdLaWZtUUdHeXZKc0F3TUhObEVLcnNablJv?=
 =?utf-8?B?MjcrN3ErQU9Cc3RYOFBSOCtkcVRCSHE1dUIwNkVOcktwOWZXcTFMVEhwZ0FN?=
 =?utf-8?B?ODZOMDdoOTgyTWlvV2w3VzJXT0U1OS9keGlDL3M0clN6cXNBaUJnT0pQWTYy?=
 =?utf-8?B?cDlublVlakQ4cnVJbXRGL0I5M0xHdjFKSHVucmJQYkwyTUd3aUZXM3VxR0Zn?=
 =?utf-8?B?RUNRL21HTGRnWHVYQy9xa3k3NGpaSldZdXFWQU9JRWtYZ1V1YkRkZVIzeU0r?=
 =?utf-8?Q?1c1qSyZVWNAGPVYXSx4Upgk=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 68a3a235-9f19-427a-1421-08d9af7ac3dd
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Nov 2021 18:46:45.7896
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uNTCqWCey7WE3hA/rvY95yLqYZ7q2oLrb8LvP0BdR7cpOmBRApqYUa9ptd6c3wWDE6Wf5Am/EEBk9wN/wwC0mQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB3685
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10178 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 suspectscore=0 mlxscore=0
 bulkscore=0 malwarescore=0 phishscore=0 mlxlogscore=873 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2111240097
X-Proofpoint-GUID: Qf6UA9TwwfxOD7XqJd39UJg-NlPDo9qv
X-Proofpoint-ORIG-GUID: Qf6UA9TwwfxOD7XqJd39UJg-NlPDo9qv
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/24/21 02:30, Baolin Wang wrote:
> 
> 
> On 2021/11/24 2:46, Mike Kravetz wrote:
>> On 11/7/21 01:57, Baolin Wang wrote:
>>> @@ -1511,18 +1517,20 @@ int migrate_pages(struct list_head *from, new_page_t get_new_page,
>>>               case -ENOSYS:
>>>                   /* THP migration is unsupported */
>>>                   if (is_thp) {
>>> -                    if (!try_split_thp(page, &page2, from)) {
>>> +                    nr_thp_failed++;
>>> +                    if (!try_split_thp(page, &page2, &thp_split_pages)) {
>>
>> Does thp_split_pages need to be initialized before this call?
> 
> The declaration "LIST_HEAD(thp_split_pages);" already did list initialization, right?

Correct.  My bad!  I keep forgetting,

#define LIST_HEAD(name) \
        struct list_head name = LIST_HEAD_INIT(name)

-- 
Mike Kravetz
