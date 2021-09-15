Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A7D2A40CB4C
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Sep 2021 18:57:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229738AbhIOQ67 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Sep 2021 12:58:59 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:41538 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229465AbhIOQ64 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Sep 2021 12:58:56 -0400
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 18FGocS7009448;
        Wed, 15 Sep 2021 16:57:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=BjV2BQDA+q+4RCG/9wdxIfbhXGEbox83MHKC8exhv38=;
 b=q2YMxpg5uPDOdwm4A3S3XDBNyGck7CTz1BnxjVZxiUnc33y3cDArw5c8BikQT6QgMx1J
 vydvntD3dx197SQclRmvARdfFm3bSYnrZg36gWncdyxUIB0aOrBp3cF8mjWBhnQD97us
 DW/VsCgEZuZeoqOtNMYnGCPyBaGbN8LVba0bGiR5ktWcSnCH4g4cZXXO1pcR6GoVU+5f
 3y9Bc3T6ubFT5/VEcQp2s6D3Ry2RGGuDaln3euD+kwWhSDcg6D3zxN+3G6nne2B63boD
 kUPMNfYrO51lZJc4xBXtv7FZq8Sdz9tkWhJkg+xifmtCinkVWv8dP425V1MjXTM3zM15 HA== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=BjV2BQDA+q+4RCG/9wdxIfbhXGEbox83MHKC8exhv38=;
 b=VAtvxbPZLZqnqjw2zK+yxDHJJwVpEAYur2qmtSNr40kaDwTllXX3NFGCOyrNiyKE0q0t
 n2GPqGgZTJuCwVHpp873l3spLvANSeH3url3xZjVuUmInoDLlQbqni4hc1AOVWqVMiNY
 kL7oNNPHRDLSlAJoA2ifI0qmS6CFMSmJ0CUaldLiKWyqcmgRf1KJnviMB8QDXbdYws1i
 dRsKUfl2aLkVo1qnig34+VN/8snQRrtPR9cpaJV2MlT1KRU7Vpr68+Q5w7nILBjQL413
 bJnIgRe+Ay/Re0BsJUS/I6FVqBmQz8oWoRD93XYlxeeeLQyRyNlrZCZyVvO4e4bDS9x2 dQ== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3b3jy7gf18-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 15 Sep 2021 16:57:22 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 18FGnu7c105482;
        Wed, 15 Sep 2021 16:57:21 GMT
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam07lp2041.outbound.protection.outlook.com [104.47.56.41])
        by aserp3020.oracle.com with ESMTP id 3b0m984fen-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 15 Sep 2021 16:57:20 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CveBr0sfoIxjMR29hKn7jZbJj5abaqr72ANEMWPVb9UYz7DW2cyICY6az+6p0pFGv8c9Dltff3ltqWCYH7WVmtef91C/7n3mg5azFQX6lXPuy+Xd+CLbG+aIfWUI9t2cLUqApn13SJfKZwmJez2KREblXdL1AdGeeIkV2wC9U/nqQkPluvgbQevcuPVZ1+0tesu0oGnHZt/K8/XHn13uHoiUQWMoRi3SdVmjhNic1jIGGH9b10mwHHWOXy7ytuAHZM7auEl1x2FPtbSgbHm5yU/bszN8PnkkyI1GqOUnXUWIPD0ueJ/0GrA9dTtqjuVmXaNevMVWAXSmPLsEOx930g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=BjV2BQDA+q+4RCG/9wdxIfbhXGEbox83MHKC8exhv38=;
 b=LhmAN1+a8RDDVf8mO6XalzlVCEHs7O6wuvDOZcLnLTHGPrwXjU31Ue0J/l8SbWZkNQwuJ0k0FWvj7eB3EPKD24Z45mI85CiH2K7tm6XfYVcXOk9BuCT/+DH+KT1AeKWjNfJd9gqoTJwdWbmp2xYMsFEwOj0HZNrTxakhMcgN07NvcSijgx8ZDLx5BJGXWrjNIH7uxSYtRMLih+mg3qM28nJEl2bDmgcW0GbxjxxinSojxxxh1UbV7vWaSbdgsFVH0duoEH9A9UTnJ+h43uXqiGFJru5Q09rnSkD8RkdeeksLwV8GSSCduNjW2NTnu2kI2ViXtgrY2owQszh63tfODg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BjV2BQDA+q+4RCG/9wdxIfbhXGEbox83MHKC8exhv38=;
 b=zqzh7dOsaQyW4zPs+LRh53jNfBg0OMikw5YUHVmGvJTIkBmpau4hDtnkzDZaS1BUWwGCfXMxHEGDxqEPNTrFV01cL0D8h9dyTQWmwXoZtjCPlOiCu6eNKy2YqcFC1HDl/GaKewj+7znSR5C2AUTqV14m3zqEzQ7sEMoCOy5W3qI=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=oracle.com;
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by BYAPR10MB2552.namprd10.prod.outlook.com (2603:10b6:a02:ad::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.14; Wed, 15 Sep
 2021 16:57:19 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::a4a2:56de:e8db:9f2b]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::a4a2:56de:e8db:9f2b%9]) with mapi id 15.20.4523.014; Wed, 15 Sep 2021
 16:57:19 +0000
Subject: Re: [PATCH RESEND 0/8] hugetlb: add demote/split page functionality
To:     Michal Hocko <mhocko@suse.com>
Cc:     Vlastimil Babka <vbabka@suse.cz>, Hillf Danton <hdanton@sina.com>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <efcf6049-6110-d516-b21f-41bb8775f042@suse.cz>
 <2d826470-d345-0196-1359-b79ed08dfc66@oracle.com>
 <b3b334ea-0e6f-ced9-e444-df4ec49455a0@suse.cz>
 <02a1a50f-4e7c-4eb7-519c-35b26ec2c6af@oracle.com>
 <20210907085001.3773-1-hdanton@sina.com>
 <6c42bed7-d4dd-e5eb-5a74-24cf64bf52d3@oracle.com>
 <YTn196em42sDsXs+@dhcp22.suse.cz>
 <71f855ac-ff61-1eed-454f-909c0e4210b2@suse.cz>
 <YTsVT74kAgpAD17s@dhcp22.suse.cz>
 <2519e0f8-98ee-6bad-3895-ac733635e5b0@oracle.com>
 <YT9zUaPofENSMQHg@dhcp22.suse.cz>
From:   Mike Kravetz <mike.kravetz@oracle.com>
Message-ID: <b053cb84-67d3-d5c7-fbb6-c9041116f707@oracle.com>
Date:   Wed, 15 Sep 2021 09:57:15 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
In-Reply-To: <YT9zUaPofENSMQHg@dhcp22.suse.cz>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0168.namprd03.prod.outlook.com
 (2603:10b6:303:8d::23) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
Received: from [192.168.2.123] (50.38.35.18) by MW4PR03CA0168.namprd03.prod.outlook.com (2603:10b6:303:8d::23) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.14 via Frontend Transport; Wed, 15 Sep 2021 16:57:18 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 332eeb54-4f74-4561-402b-08d97869e0d4
X-MS-TrafficTypeDiagnostic: BYAPR10MB2552:
X-Microsoft-Antispam-PRVS: <BYAPR10MB255202D81C67E884CEFE1647E2DB9@BYAPR10MB2552.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Lt94ge3mV1pnRGJidVtvZ+jb1vZ0fKOihwgMT8zkzcELFFrDWJXJtyullKom10DoWsSBWbDGY2b+6hel0OczDBBqnKfPpWDs+MY06Ko1A7tOYogH6hjaKNhHw3OBLt/rLzl00l6A3ekNgD+RqFO2hU7ZO82HCGKMdeNz0ZVZuYqEyHpdfcXl4NuAT/dYxGJMRMF+DUUJDXX2vgUUJeGxfddkwlEtDgUihhxoa6g51cjQ6EWOvAaZQuZw24jFLgB3NA99iZYBjfb9Pcc+ZHxrLX5ez3cbyvwMxNwpBSMq/5r5DXch88id0zokOMpHvWNQ5TTpAhXg5RebIAd5/pE5IeKW1C8gT8M0YqXaQWvinRHFfqC6gXn0wt4Aq9gOeEk3g7q09NvblFfF88pTvYzdNoZTMhINqK5jYRyGRoHyXo1WfW6WJGZy70ZJYXOzWfadQeLmLOZlsUkZs8+yMfSdDDXdDrB/MXuqfY/5Hh1QzASokOAC5rpPEH40zcxgUenVqE3cGubE/X6bcXOIe2zsDZshK0MLz2IcToT8cKDEVy1MTHfaKVJYWepo6U2w+8lc+0olZIyzEBuPkgmQ1O8jHTDbzK3L11s4BXX5mksggVERBj98Adekur9ZoGCdl4To82TkSJoc1a0DKWwMxHyb4MzyZpn9Y5i+qQCjv9LDDgjp9/ihzZE1v+T8ZQgjWgGVisO41/tLRwKEc5xbumGvIc7ox4FbcgWW2Ywy/UoYfwod8SD05fK2UNMBWGXPUGriyCXWv9h3LYsR3C08ST3VGw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(346002)(376002)(396003)(39860400002)(366004)(6916009)(31686004)(38350700002)(36756003)(31696002)(26005)(6486002)(38100700002)(53546011)(956004)(186003)(478600001)(2906002)(4326008)(5660300002)(6666004)(44832011)(86362001)(83380400001)(52116002)(66946007)(2616005)(54906003)(16576012)(66556008)(66476007)(316002)(8676002)(8936002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cmRCY0NzSHI0WGw0cVZtc2QxZVZaQm43Q3EyNWJlSUtmbDRNckJVMGk0bUZN?=
 =?utf-8?B?eVloZGpSQWJxOU9DMU5taU9Ha1ZZTkFNdjlTWnovUE41dFYxQmxpZ2EyeVFv?=
 =?utf-8?B?V3VRNlpWVTN1UjR1M1hYTDZPYlMxeUJvT2FyeWRHRVJXVkNxTFhNd2dHZEF1?=
 =?utf-8?B?RlhZQkxnTUtYaWdMU0krVDZ0emp1bEtJdExzUUptRThCZjBCVnl4WVAwbEU4?=
 =?utf-8?B?ZkI0SjYzQXFFNVpQbnMwVnpXSGd0aFJpUVVJR0dwQ1lpOWRJbkRCZDhVRUxJ?=
 =?utf-8?B?Vk14VnZKMzFqTERIOVIxTHJvRU9GWWl2aUFLZ294ZVJCcVhIVmNtQ3J2OGJq?=
 =?utf-8?B?RmZRRTdSRnBsWUFpZG9qelhGRmhiM0ZEUUdQUGVmOElkbmdGNHNwWXdlMGhy?=
 =?utf-8?B?N2xGdjdyZkZmcFk5RHJZTmxWVXFLRkZzUEk2NGxwQ3QrZlg0L1QyaG5XZFVL?=
 =?utf-8?B?QjRkaTlrU0FFMUNFT0RmZVIvWUNQcm5JZ01SdFVyZVVxWjhLRjh1dDB6bWNl?=
 =?utf-8?B?RGgrWW1GZDZycndOL2ZIaGovUzhQUGR3eWs4RHMyWVpUYlkyNnpFVHQvaENw?=
 =?utf-8?B?c0F0cXM0MnR6VFlqZklrQXFkSWtHTFJ2WGFMNC9GaTNWdnlEUDFrdGRKMXl0?=
 =?utf-8?B?TFVhWUgzR0VMTThGRHcxdkNoQXA5QzhTNHN1cS9tY3F0YWMvbTB4bjFMQjNu?=
 =?utf-8?B?SnpLRWNwVm9va1JMTUZkQ3NoZ1E5V0w2TDVMVGVQWTV2cUZ2UmhiUGpLSmdI?=
 =?utf-8?B?eFRwL0t4SjYvV1Z5MHBENDhpdFNGL3oyZk10QWFDeWpZREY5MTBCcG8vWGRa?=
 =?utf-8?B?S0xyRjk0Z1BuWjR6cExMYW5vT3pGVGtaK0dWZkRkZVFQSnBxZU5xRkpYZzRq?=
 =?utf-8?B?cWVaWkt2TENMaENET3FsN2NKNUJ5UiszYm9XTTdQdGZNOENwUnFXVkZadFhQ?=
 =?utf-8?B?QVViQ2lvMU9TR0twVERIcW91WjUvQjd0eTJOeXdtSEEzTnBIdVU2ZUFyNHlv?=
 =?utf-8?B?aHFPV1hSWnhGb2FGZlZWMGtUN3hTeHkxbkVMNzlTQTE2WlJqRGNDdXYzRGR6?=
 =?utf-8?B?WXhRVkdQZ2o2ZVdwcThScmJEVVZseEdiV1ZRd0VuOEV6VXR2SGxKMHJ0eG1l?=
 =?utf-8?B?TnNhSUZQUnJUS2xwaDdnOFJOWEQxSUhGa0NRL2FYdEkwWjhzNXk3YVlXTWox?=
 =?utf-8?B?OFpWVC9UeitzeU5JQ0RWVlNwUVZJNWpXeVpUNFJVYkVYNDcyL0FPVjlEeTEy?=
 =?utf-8?B?Z0Z5N2lhaitQS2pMNEdHS00rTTdoampTcGNnNXdVZFE5S0hxVDg3ditJc01T?=
 =?utf-8?B?WnRZVU5QSWZIODlGVHdlZHZ2WjhkT0dOV01SZjVabXM3MXlwdjNZYk1Bd2o2?=
 =?utf-8?B?Z01xY2NlYmhwSkUwdlhCY3FoOTBHNFBUc01qYkMrVStSVzlaQ0VrMy9Uenp2?=
 =?utf-8?B?K01UaDRMdVljZ1VPWEdBNXk5ZEY3WTc3aFpIZTlSa2RDQUFUOHJDcUJBNXNj?=
 =?utf-8?B?Y0ZYRzFrVWtmZ2FnWnNMWlJvV0Q3dGx1ZXE0ajNWMVRrY0wxOWt4MEJQdFBI?=
 =?utf-8?B?ZFViSmJFcmRmQlVldGZqcm95aTFucE1jVTNVMjB4cEM0TkdQRE9LRkNGWTRs?=
 =?utf-8?B?YWIvbGQrL0dNQW9qWkQxdGlxKzYyTUREUkhlMk9LRmlYY1RERjZZVVpFM1VW?=
 =?utf-8?B?b1FpM2FnYm5lT3daWGVmVEJ6UVo1VDhtUWpEUjFLKzU5MTNaajcrZnd3UHYy?=
 =?utf-8?Q?tfsN1dR+Nak+59SvnyzU9SJK/pAMVeaZO9upBgU?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 332eeb54-4f74-4561-402b-08d97869e0d4
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2021 16:57:19.0423
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0MM75dl2X1Rq9oAHC6vW5tPrWwMVunuS7ab5EnSNrqq1ZGfW+lcQTZccnqtJqlCgeVGjM6vKkDdBYwovhI3VZA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB2552
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10108 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 phishscore=0 malwarescore=0
 adultscore=0 mlxscore=0 mlxlogscore=999 suspectscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2109030001
 definitions=main-2109150102
X-Proofpoint-GUID: K80w4SY2sGqRtQREeahMrKV05Ew6lj3n
X-Proofpoint-ORIG-GUID: K80w4SY2sGqRtQREeahMrKV05Ew6lj3n
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/13/21 8:50 AM, Michal Hocko wrote:
> On Fri 10-09-21 17:11:05, Mike Kravetz wrote:
> [...]
>> @@ -5064,8 +5068,18 @@ bool gfp_pfmemalloc_allowed(gfp_t gfp_mask)
>>  	if (did_some_progress > 0 &&
>>  			should_compact_retry(ac, order, alloc_flags,
>>  				compact_result, &compact_priority,
>> -				&compaction_retries))
>> +				&compaction_retries)) {
>> +		/*
>> +		 * In one pathological case, pages can be stolen immediately
>> +		 * after reclaimed.  It looks like we are making progress, and
>> +		 * compaction_retries is not incremented.  This could cause
>> +		 * an indefinite number of retries.  Cap the number of retries
>> +		 * for costly orders.
>> +		 */
>> +		if (max_tries && tries > max_tries)
>> +			goto nopage;
>>  		goto retry;
>> +	}
> 
> I do not think this is a good approach. We do not want to play with
> retries numbers. If we want to go with a minimal change for now then the
> compaction feedback mechanism should track the number of reclaimed pages
> to satisfy watermarks and if that grows beyond reasonable (proportionaly
> to the request size) then simply give up rather than keep trying again
> and again.

I am experimenting with code similar to the patch below.  The idea is to
key off of 'COMPACT_SKIPPED' being returned.  This implies that not enough
pages are available for compaction.  One of the values in this calculation
is compact_gap() which is scaled based on allocation order.  The simple
patch is to give up if number of reclaimed pages is greater than
compact_gap().  The thought is that this implies pages are being stolen
before compaction.

Such a patch does help in my specific test.  However, the concern is
that giving up earlier may regress some workloads.  One could of course
come up with a scenario where one more retry would result in success.

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index eeb3a9c..f8e3b0e 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -4413,6 +4413,7 @@ void warn_alloc(gfp_t gfp_mask, nodemask_t *nodemask, const char *fmt, ...)
 
 static inline bool
 should_compact_retry(struct alloc_context *ac, int order, int alloc_flags,
+		     unsigned long nr_reclaimed,
 		     enum compact_result compact_result,
 		     enum compact_priority *compact_priority,
 		     int *compaction_retries)
@@ -4445,7 +4446,16 @@ void warn_alloc(gfp_t gfp_mask, nodemask_t *nodemask, const char *fmt, ...)
 	 * to work with, so we retry only if it looks like reclaim can help.
 	 */
 	if (compaction_needs_reclaim(compact_result)) {
-		ret = compaction_zonelist_suitable(ac, order, alloc_flags);
+		/*
+		 * If we reclaimed enough pages, but they are not available
+		 * now, this implies they were stolen.  Do not reclaim again
+		 * as this could go on indefinitely.
+		 */
+		if (nr_reclaimed > compact_gap(order))
+			ret = false;
+		else
+			ret = compaction_zonelist_suitable(ac, order,
+								alloc_flags);
 		goto out;
 	}
 
@@ -4504,6 +4514,7 @@ void warn_alloc(gfp_t gfp_mask, nodemask_t *nodemask, const char *fmt, ...)
 static inline bool
 should_compact_retry(struct alloc_context *ac, unsigned int order, int alloc_flags,
 		     enum compact_result compact_result,
+		     unsigned long nr_reclaimed,
 		     enum compact_priority *compact_priority,
 		     int *compaction_retries)
 {
@@ -4890,6 +4901,7 @@ bool gfp_pfmemalloc_allowed(gfp_t gfp_mask)
 	struct page *page = NULL;
 	unsigned int alloc_flags;
 	unsigned long did_some_progress;
+	unsigned long nr_reclaimed;
 	enum compact_priority compact_priority;
 	enum compact_result compact_result;
 	int compaction_retries;
@@ -5033,6 +5045,7 @@ bool gfp_pfmemalloc_allowed(gfp_t gfp_mask)
 							&did_some_progress);
 	if (page)
 		goto got_pg;
+	nr_reclaimed = did_some_progress;
 
 	/* Try direct compaction and then allocating */
 	page = __alloc_pages_direct_compact(gfp_mask, order, alloc_flags, ac,
@@ -5063,7 +5076,7 @@ bool gfp_pfmemalloc_allowed(gfp_t gfp_mask)
 	 */
 	if (did_some_progress > 0 &&
 			should_compact_retry(ac, order, alloc_flags,
-				compact_result, &compact_priority,
+				nr_reclaimed, compact_result, &compact_priority,
 				&compaction_retries))
 		goto retry;
 
diff --git a/mm/vmscan.c b/mm/vmscan.c
index eeae2f6..d40eca5 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -2819,10 +2819,18 @@ static inline bool should_continue_reclaim(struct pglist_data *pgdat,
 	}
 
 	/*
+	 * If we have reclaimed enough pages for compaction, and compaction
+	 * is not ready, this implies pages are being stolen as they are being
+	 * reclaimed.  Quit now instead of continual retrying.
+	 */
+	pages_for_compaction = compact_gap(sc->order);
+	if (!current_is_kswapd() && sc->nr_reclaimed > pages_for_compaction)
+		return false;
+
+	/*
 	 * If we have not reclaimed enough pages for compaction and the
 	 * inactive lists are large enough, continue reclaiming
 	 */
-	pages_for_compaction = compact_gap(sc->order);
 	inactive_lru_pages = node_page_state(pgdat, NR_INACTIVE_FILE);
 	if (get_nr_swap_pages() > 0)
 		inactive_lru_pages += node_page_state(pgdat, NR_INACTIVE_ANON);


-- 
Mike Kravetz
