Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D77DB35E480
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Apr 2021 19:01:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346997AbhDMRBL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Apr 2021 13:01:11 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:36076 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229463AbhDMRBJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Apr 2021 13:01:09 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 13DH0ZYP008980;
        Tue, 13 Apr 2021 17:00:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=5Znld77solH7YsmVV+4GZ4sDJy0jxtdU7IXG0Q91LEQ=;
 b=RRcjvqpZBwe8zEaJH5ojQvRvl8xUoPTPfSCAsC1mQryKWDnZ0F2HSXmnLmfdNFA18oBz
 ACXjxl3TLwdESI3jpNbv/97FNO5Z+HwM6PLHrk2f9/9G+ef3QU17chb3lHAzb27lpDh3
 cLjAyBBEorJfuEsFcNLXWuMCteDMo1zACTFRMTYSRX2p5Dj4xCAZQOmlCthxNpmVOIYi
 1CUbkFP0xTCcLyBXDCuI8ZTCNThV1FTVc0QySj45Ttcmf7t8I3eLXYLCf111XEmcakOR
 K6hu4/IVt5JIz9Hv4zdjNwY77e51BQnUnD9mjd8sYrrahKehZtseIWy14WZY/ZJHS88Z Bw== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by aserp2120.oracle.com with ESMTP id 37u3ymfsdy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 13 Apr 2021 17:00:41 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 13DH0WUF154831;
        Tue, 13 Apr 2021 17:00:40 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2108.outbound.protection.outlook.com [104.47.55.108])
        by aserp3030.oracle.com with ESMTP id 37unkpsjuu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 13 Apr 2021 17:00:40 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=U3EGuDjHPHYdxQkNvQ74qAthEKt4Pj1qoPeeMqyaDNWOFa9MAvqpSgPJeqx3sUHPQrdEpFOijVfX0ZZ6OD1ZZ8Ykk2OniSb6q7MNoeyhqoBCO3kmReT2Dk85eoYEmWxsn8cc7Anf1W3F1MCq6AFm6scwiUj47Ma9MmVzFmsqup/jsGcen6uZzjr3JXZI8NG9SJ01Pl247D8O2ueyCSdJ/HK9b0xw3/7wvD+vsg9IotXWdNKFPUMIXVaCYN3s3Wz+iHJnSkDuiP7/d3cwaexk49W/FZmBq+s7PcyeD9zTgTyxu0gsjvahgZPCKb8IhdENuH0dAMoGu0N6gaoA++O4Vg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5Znld77solH7YsmVV+4GZ4sDJy0jxtdU7IXG0Q91LEQ=;
 b=aYPGCLSufP46u6FS3kwqjm2XAgB5Lm6qsAof8Dq/9ZWpgMzRr/VgjlxcSyj06jGKiFxa0z1deGX2Ji4H/YtuwpXgCYTEeE8Xocg3g8sHXAMGNCMDBE8JyUhuI83rI/TQREshckwCl02o9HMLDyvzNtyvY59neh0+6zRCPzL45RUJwqtOV4MWaagrYTXAsIgvts3N6WMky18b/8VmnZ2dIANX0rN0l6UYZdtcM3cofsilvGsf0WrYtG6Xr5NWlSTtqH5b6ywdcDz07eUc/1xfK2XwCc9hl+r5LSfaIdFODASN7vS7qIiZwccTtDk7gZQ2VtiUu1/98jgGW2oIDDASmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5Znld77solH7YsmVV+4GZ4sDJy0jxtdU7IXG0Q91LEQ=;
 b=l1WK5dcSrIk1LRsfrRV31cKHYxZMA9icv60RhOgJFfRSkraSSfFbWIGAMLQC8J/NWSzU1DqXnuJcyigUvn7uvVCCnMMd8klyzilXfB070jQXjDxhm1IM/C1s357yoFpFYZzK2n3MQ+5PxnFfjHLgV+fkkCSlFufIFdluFsWWRsY=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=oracle.com;
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by BYAPR10MB3400.namprd10.prod.outlook.com (2603:10b6:a03:14e::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4020.22; Tue, 13 Apr
 2021 17:00:35 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::980e:61ba:57d2:47ee]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::980e:61ba:57d2:47ee%7]) with mapi id 15.20.4020.022; Tue, 13 Apr 2021
 17:00:35 +0000
Subject: Re: [PATCH v7 1/7] mm,page_alloc: Bail out earlier on -ENOMEM in
 alloc_contig_migrate_range
To:     Oscar Salvador <osalvador@suse.de>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Vlastimil Babka <vbabka@suse.cz>,
        David Hildenbrand <david@redhat.com>,
        Michal Hocko <mhocko@kernel.org>,
        Muchun Song <songmuchun@bytedance.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <20210413104747.12177-1-osalvador@suse.de>
 <20210413104747.12177-2-osalvador@suse.de>
From:   Mike Kravetz <mike.kravetz@oracle.com>
Message-ID: <fca31c2f-4cde-8329-f302-1cf005087bc0@oracle.com>
Date:   Tue, 13 Apr 2021 10:00:33 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
In-Reply-To: <20210413104747.12177-2-osalvador@suse.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [50.38.35.18]
X-ClientProxiedBy: MW4PR04CA0183.namprd04.prod.outlook.com
 (2603:10b6:303:86::8) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.2.112] (50.38.35.18) by MW4PR04CA0183.namprd04.prod.outlook.com (2603:10b6:303:86::8) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4020.17 via Frontend Transport; Tue, 13 Apr 2021 17:00:35 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: fb3a5b41-bd16-430a-5a9c-08d8fe9da7fd
X-MS-TrafficTypeDiagnostic: BYAPR10MB3400:
X-Microsoft-Antispam-PRVS: <BYAPR10MB3400583544D2FF14B6C60A1BE24F9@BYAPR10MB3400.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1013;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tQYaKD1FZQ0MrqS3DRekHUKuNZemLs+nRtMuQPoBzKe8fzExkHxIJlUMl1w78yiDesMFv9l9H8j5sb9MSqUu5TMpyJAR8Y/97MRRC8yo9dgsOehMyEXMoHgT6+/Z+9a/MPuz2CmzTWDf6+V6nUREyqgq9I88Ghf5PEk10NnVTISTZXp90utZ/Mes4CEeUqXrA/ySAlcOo1znS4mBncgmrQG+ZBXCjTXfoYvsbYzZlc+rVEfc7RO//BJOOFEgamqbb0GDZ8qMsWGCymw4P9sGM/tnJ8XkKjWgdIcueVqb8B5h9vcpDmf0ysRGJeN57ZgmcnQHHmmbCqsKnbF7Y6gRnGaaHveQjNUI5v9p2RnDxAnJ6INKUADcOf5d2ru+BVSVmw2VFlJsItruknU01ggg5YkGez6LgHdY1+ohfyYGZ0dhX/WnOOEykqAsZQ/YSWmRABLs2ZlsT65fkBl5/pLBGfakMAAuhNk4+VIr0ircN+PTtYzBKBHsRpAOXXjLVuuFbSidLKEOlcUujg5WUH1JsOgY1XP2IozpBVwKUhOyPC80wq8WHfkXiwYk1BM5jdmPJQLpc9t9YdfZGQDOOClbLoaZ0Qy5koqrABdDIR4GEVhh+FV5ICXfbOiIg+7WlDxZY6g7eq5qh830YtMfcOs2+F5ulmRblud5jlxIG0KpA6fSUJ0FwinPZ2Y/f5WFdsvs2uuI0G3SPdyNDyKgD6Zuhw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(376002)(366004)(136003)(39860400002)(396003)(346002)(36756003)(478600001)(5660300002)(66556008)(186003)(2616005)(52116002)(66946007)(110136005)(16526019)(956004)(53546011)(6486002)(4326008)(38350700002)(2906002)(66476007)(31686004)(86362001)(8936002)(8676002)(16576012)(31696002)(26005)(54906003)(44832011)(4744005)(316002)(38100700002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?RDQ0anRyODh3VTc0blZLaGNma2l3NG1YZ1ZIYkJVdGFRUjJEVDgyYVg4eUVt?=
 =?utf-8?B?R1dzQkNObCtkZWtOc2dVSUowVDR2akE0Q3hSL28wN21VWHR0cTdsVlljTzFC?=
 =?utf-8?B?aWJQL1BGZmltMitXVzJJZzk0bWJQSXNhVHBFcitZc0pLMGhNT2JqUTNrb1ZJ?=
 =?utf-8?B?OXpMd0RIMGZ4Z0Y4djVqc294OU1Oak1IekRlajUzaS9ScmswOTBCMmlRRU9h?=
 =?utf-8?B?cmpPbVI0ZWtUdGJ5SnVxZWFSQ01ZY09CTUdRYmg1U2FTV3pJZmJGTGd6WWNm?=
 =?utf-8?B?TXE5QTJxU1dlUGtlaFpuN0xvK2d2ckM3Tk1ibHliWk5ZY0R6ZWplNGJ6Z0JN?=
 =?utf-8?B?NlVQNkV1WDZJd3dqeE9aenpKaUpWR3UvVytEWERMYXljeC9zNnl6TXpSNkVk?=
 =?utf-8?B?Uk15TWp6eVU5anpXSmhva2g4VzIwY1lpQzdCOGxSSGpkdWtoYjVUMGdOa2Vx?=
 =?utf-8?B?Z1Y4Z0p0dmttMlgwNXI5cnpsV1IrZTVoQmVTUHFjVnF1Um91RXRrdTJBSmhO?=
 =?utf-8?B?R1cxekRGZnhPalQ0VDA0c2RGUzYyc2xvVXA1QURqczJSdUlhRFl4d2NYSDE0?=
 =?utf-8?B?L3RUTDFqWE1CbVBlUlJaL2ZoN3ZpRlZGb0NYRzB5blhoSU5BbXkzOXVkRHNE?=
 =?utf-8?B?WHhSc0Jmb2Uwb3hXZFA5ZStmSytGWGJiWWloZVR4UkcydHh6UTdhNno5TFVi?=
 =?utf-8?B?WXA2NDZGcjdIUzJHd1FEby9zR1g5WW5IWnpXVXdkd0VuZk9rMDEyR054V3po?=
 =?utf-8?B?dkt3Sy9zRndlY1daU2NDTWRnUVFqblh2T0JPWEVYR0VWL2NZdE0xay83bTJB?=
 =?utf-8?B?eGk0TjFBMDh5QWlPYWV0WXY0cllQclZTOEZ2a2cvTHF1a3gwZGh1MEI0NjVi?=
 =?utf-8?B?REl4T2pOUjBuYU1tdm11VzBqTmljdXRURzE2a2lKenQxNDhjV3ppbG45V1R2?=
 =?utf-8?B?aTVyekNnSFRuRXJwY3JOcU85SW9HOWUraFdoVVJmNEZvaXdiM3czZ2FYMEk1?=
 =?utf-8?B?TVpXenBjTmhodklhUWt6bnE2bmFoU2JZQlBHd0lzc2lYNGFOZlZ3VDczTnJH?=
 =?utf-8?B?ZWNlUDVvUUxsT0ZKc0NJQWpDOEVVRU0wNXMxbkRBMlQ4ZTlqV3JaNGpoekR6?=
 =?utf-8?B?alNQUExub2RSTTdYTXgwQlRlN3BQWEVtT21yeTY4RExpNnJMemlmQ2hxaFBq?=
 =?utf-8?B?TG1qV1ZiNlN2cGh4emNYUzBlRlh1bkxjWllOOHdjRkhkSWRrZCt6bENtT29Q?=
 =?utf-8?B?dXFmbjFrQUcxb3RuWmZXdTREL2FyZDRlc3ZXdVZ6dVR2Q1NESFdFTHdXZS9L?=
 =?utf-8?B?S0xSbzltK3V3RFIycnB1UmQrRnd4QzNhMUphT0lqRE8yZ3pIOFhqTG9JT0Jy?=
 =?utf-8?B?OHJkaUdhY09XT1ZMbFBEdGVQd29OZ3ZzRmo2ZjlsbDRPcW93Z0N2aGJmMlY1?=
 =?utf-8?B?Y2VMcDIyTEpabGJHbXhHM1JnZTlqVEEvNEZHMW1NZURzdWgyclhMRXZsUjBN?=
 =?utf-8?B?SXA3Vm5WdHk5Vm80VkMyU2xVN0NXVzB2VUgvTHkwa3FuS1VNcnk3MHc3Z0pw?=
 =?utf-8?B?VzduYzg0UTVNSTNnUVlMUkpvQ3ROdW5lb3RGN2V4KzlLUTlnOWpxMkErd1ho?=
 =?utf-8?B?K05HeEt0dU4wQTVCdk1mVWRBdG9NRzZ1NTk4bEp0c3gwcEczOW53N0Y2Unps?=
 =?utf-8?B?VjZndjIwZVVQSzhGTTBmQ0N2WjVEWGpmS2w2VGVhM2FSVHlLeEY5b043bytK?=
 =?utf-8?Q?abg7asDGRh5K4fYA1cDQvI6OGcLB5/vQPPjjsX2?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fb3a5b41-bd16-430a-5a9c-08d8fe9da7fd
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Apr 2021 17:00:35.8044
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: p8oO3OO6IkwDNEYitH0h6PZCzJbKtTE0UZVB1fLWEj1fbnaupyNb/ZE1nBRFEDHR0sQDZBqrnxLPecp+P1xcqA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB3400
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9953 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=999
 adultscore=0 phishscore=0 malwarescore=0 mlxscore=0 bulkscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104060000 definitions=main-2104130115
X-Proofpoint-GUID: rd-LIMdVcaafDTLcFjUpDuwqdpJoWAlp
X-Proofpoint-ORIG-GUID: rd-LIMdVcaafDTLcFjUpDuwqdpJoWAlp
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9953 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 mlxlogscore=999 spamscore=0
 impostorscore=0 priorityscore=1501 lowpriorityscore=0 adultscore=0
 bulkscore=0 phishscore=0 suspectscore=0 malwarescore=0 clxscore=1011
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104060000
 definitions=main-2104130115
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/13/21 3:47 AM, Oscar Salvador wrote:
> Currently, __alloc_contig_migrate_range can generate -EINTR, -ENOMEM or -EBUSY,
> and report them down the chain.
> The problem is that when migrate_pages() reports -ENOMEM, we keep going till we
> exhaust all the try-attempts (5 at the moment) instead of bailing out.
> 
> migrate_pages() bails out right away on -ENOMEM because it is considered a fatal
> error. Do the same here instead of keep going and retrying.
> Note that this is not fixing a real issue, just a cosmetic change. Although we
> can save some cycles by backing off ealier
> 
> Signed-off-by: Oscar Salvador <osalvador@suse.de>
> Acked-by: Vlastimil Babka <vbabka@suse.cz>
> Reviewed-by: David Hildenbrand <david@redhat.com>
> Acked-by: Michal Hocko <mhocko@suse.com>

Acked-by: Mike Kravetz <mike.kravetz@oracle.com>

-- 
Mike Kravetz
