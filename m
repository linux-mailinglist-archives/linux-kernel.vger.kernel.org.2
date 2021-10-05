Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 46E07423304
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Oct 2021 23:46:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236093AbhJEVsI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Oct 2021 17:48:08 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:20152 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229974AbhJEVsG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Oct 2021 17:48:06 -0400
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 195L3L3s029400;
        Tue, 5 Oct 2021 21:46:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=KXy6Njslj2jLbQ8En8Z1gjGWGAfzFmzPR3s2QI+n6og=;
 b=K+GNfbUTkoXVlheSsA0IefNcxmyS/EDilFGj/xHVxfxqHRhR2XV9aFOGuXO1mGJH8wsq
 5EvM40+8uB4uLQe9DbOd6rYlikFb8jp7hcGph7jsJNmTklAKEwPdFcKRqUyoLRHlLFMa
 gMOfQ0Tt+6bHWJwxuKVgnbt64WJxndHfH9PuC8PD9vF7yxvFrvL5IULmxLguqPbvb2FT
 CHqEE1K6gNMh6RLNYHsv9fTYYDR0vt3KGkGFbC75xFc3rf/s3l+TS05/vs6BxWTNMLgQ
 n27LTMX3Q1j0TFPWrhlpfoYqgfVM3mVAu0xzOxkLGOr3blPWnhVA4ZAKi7f1b7onn6AR aw== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 3bg42kuepu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 05 Oct 2021 21:46:13 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 195Lj0EG179428;
        Tue, 5 Oct 2021 21:46:12 GMT
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam08lp2040.outbound.protection.outlook.com [104.47.73.40])
        by userp3030.oracle.com with ESMTP id 3bf0s78e64-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 05 Oct 2021 21:46:11 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EiAjbN3x3dWikj60VuA85XNwks0nqE88KHOyiAPMZsFfGoIAo2XArAAGxcqI4eggdZd1Q3fsL71Ocm7Xy9/sAqb4tP4foQ3mUKyhyjgvvrtbJiuZvDNVGiD4Ve9xYgfbAaaGWbskYrdteGOc5LiQKRZCB3NmVypoyYKTDsaDgffqcGt+jI/nIpksBLkZFjkA1uk0CRVhP0XesAe+k+Pst9l6mO7mE6BfkpGq3MQMEcaZ7pZZ+jaVvDvhVbRgIjueAAgYvdpibWcUlULVy14pwxHHz+FZTSHUhZLDl20N6akrrjbmzkEfYbRFuIgAjyW/LgM0CwaieI72gMxq82BWgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KXy6Njslj2jLbQ8En8Z1gjGWGAfzFmzPR3s2QI+n6og=;
 b=bxlTig03TUbXRVKl/c6KT+O7NiE3VJty10kwcplGg+exV7Tsi2D7MkJMYg/bZ8h11O0Bb0vL0Ea8jqAlFrnv5ThlLU/63wk0SviGOtUXDsdoEp4LNO3tvplr9AsAraaVsgF21YN0fcSUTCsjyQXEYrZb9FNPZC2ys21ojanUIyjtEVHtm9AgvzMeXIga00sKUFNpcOy0MCoKDb3+GT+b15GtI4FxXI1BpkGp9VJPoXvlRcm9FZR/Cc8Q7jLmZdyDFU0M8a2/Ptq1J238KUV2vjXzz5GBhdWH8576bke5FpElYgsr9mHtzLS2eCoQaY7ycmBVfbHHkiBSi/YBnT3AzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KXy6Njslj2jLbQ8En8Z1gjGWGAfzFmzPR3s2QI+n6og=;
 b=GI7YGA+O50YT2yXzIRfJda86P2Hw04wgMSVcXUE7PylrB2FHjsJ8dpzJmSAZsL+mA0ced37IKXK4N/msP7i6UphOBUc/Lvv0DWRl3+pn3+GlMIx5ZAuuHkQeiYX9DA0nApFH2tHfNvW0G0vWVyudtm3QX/JLgZ6vWF3Zt1qAkMs=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=oracle.com;
Received: from CO1PR10MB4468.namprd10.prod.outlook.com (2603:10b6:303:6c::24)
 by MWHPR10MB1357.namprd10.prod.outlook.com (2603:10b6:300:21::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.19; Tue, 5 Oct
 2021 21:46:10 +0000
Received: from CO1PR10MB4468.namprd10.prod.outlook.com
 ([fe80::103f:cb46:49fe:de12]) by CO1PR10MB4468.namprd10.prod.outlook.com
 ([fe80::103f:cb46:49fe:de12%6]) with mapi id 15.20.4566.022; Tue, 5 Oct 2021
 21:46:10 +0000
Subject: Re: [RFC PATCH] workqueue: Introduce __show_worker_pool_state and
 __show_workqueue_state.
To:     Tejun Heo <tj@kernel.org>
Cc:     jiangshanlai@gmail.com, linux-kernel@vger.kernel.org
References: <20210928103106.391694-1-imran.f.khan@oracle.com>
 <YVsvAQ94ucYdGNVM@slm.duckdns.org>
 <447be1eb-87df-6941-1e5c-db79918dc77b@oracle.com>
 <YVx4s1GOIhisEc8N@slm.duckdns.org>
From:   imran.f.khan@oracle.com
Message-ID: <7cd4939c-9c06-b02e-b5ce-c3f677c2e3cf@oracle.com>
Date:   Wed, 6 Oct 2021 08:46:03 +1100
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.14.0
In-Reply-To: <YVx4s1GOIhisEc8N@slm.duckdns.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SY2PR01CA0014.ausprd01.prod.outlook.com
 (2603:10c6:1:14::26) To CO1PR10MB4468.namprd10.prod.outlook.com
 (2603:10b6:303:6c::24)
MIME-Version: 1.0
Received: from [192.168.0.2] (110.33.47.182) by SY2PR01CA0014.ausprd01.prod.outlook.com (2603:10c6:1:14::26) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.17 via Frontend Transport; Tue, 5 Oct 2021 21:46:08 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a078e13d-7d8a-4bf5-d3d5-08d988498b27
X-MS-TrafficTypeDiagnostic: MWHPR10MB1357:
X-Microsoft-Antispam-PRVS: <MWHPR10MB1357367923772E14E80731EAB0AF9@MWHPR10MB1357.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yfe8ADE6tzjETXr+WhM/Ls3138g+A8IiguYqgoI/aF6IX/x+tGqVslEPa6WGlfQxMxxoERBtpuWL7DLj/ZJlwY6hRLDAOZJZKh+aztP5EKmsxINTNetUhoNmmmMNm7+Mj0jEoXSUukbK551pYMe/MWJWNbQ7oj1uaPD1S4RNDb5NXOmwi2+HfY7P9orkqrWHOvC9cya/wEvQ1z+9WgsNjzlR3FdIrm4bz52qCO2q+J44J23NkqGZxmK69K70uX1dgAQxAOY+dNVBtsVDx9X1uPR/u+NVwEJk4zo+8B+SpOQ8f2a228c1zW/fdvlBFKrCK0XOPGx5sv8hSixhD1D1UjDHM5sYevmxU+cMf/OE9USpVDbQ0ezs03lbTQJRB2VlVozNsKvOhpB4IaGuHBR03Duv+/EcuLFLCKqz5nAX1DKBYiBqIm8iIWCs36GI1FePzvRQTnOnusX7lh36y7zJCzI43R9jKnLGkXpVtJBKp/sv75Ge5iK9aWGr9p3YpQBw8ROch4GlSlQN+TpEyWdNwESBx4ZIrKoiR7Ad/7oJu7FxuNvkRYQyTQfdwKkamMPWGoimeRNXOBKKFZR1sUfc94xUqdOK2owyyFy7uROp49g+vEGBfdKYzMDfCucxlJv39LSQx5n+jfSUkL6igN2UZnw4XaC8xYw0DD41rrb4qIpIDwyQyjUxX7TvZ94NT0qU51PDusI00MUND8GDYjV+gi58pChY2pPNC6CUfRtQqVT723ox3DYW8dnEkg6czKImyR6+2QrN4wSp/braSZD3KtD4ctbswFO2VZU6q9VuUw8=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR10MB4468.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(53546011)(8936002)(66556008)(8676002)(316002)(66946007)(16576012)(26005)(966005)(186003)(36756003)(2906002)(6916009)(956004)(31686004)(9686003)(2616005)(86362001)(5660300002)(66476007)(38100700002)(4326008)(6486002)(508600001)(6666004)(31696002)(83380400001)(4744005)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NTk5djFUUk95ZzJKTENOSFF0aW5EcFpZbmFsUDJaRk43clhlbUVsWjdOa09t?=
 =?utf-8?B?ejBwdmlmWDkyaVlTZWpOUmtrYTM0UW5TMHZlQmJBTU1JMWpWUVdVVERobU10?=
 =?utf-8?B?Lzk0UnIweGNyVVhtQlI2azByenk0WHJQYkE4RVErdHNnUEdEdjRETDh4dERU?=
 =?utf-8?B?bW1JZytTL1FXZUtGVDdQSWIvZXg2Smg0RHdGcUd3Vldtc2Fla01Fd3RQN0VH?=
 =?utf-8?B?aG1rUmxIa21ReHFacEI2Nmk1dHp6TW1wLys4UmV1OG9KamRZaGxYVmdJYUU2?=
 =?utf-8?B?N3pub3pNQmdnU1g3dU02a2tab2NrUkVBTEkxRFF4dlpNNmNiUWoxeW9mMDZK?=
 =?utf-8?B?U1RMaTJmQ0I0b0puWlJ0eGFVekFkN1hPbm5ZeTVvRDdVOHVsTjhSUE9QMTlE?=
 =?utf-8?B?dkdpcjYyVWhFM25say9wTGs4eGNkUWY4VnZyYkpFRDh5WVY5SjFlUDJKVUFZ?=
 =?utf-8?B?SzcxRnp4Z0ZQa1VmYWc1OE9LQk1SbkE3dlkzZlZidnpTZ3ZlTFRkSE5Ic3N4?=
 =?utf-8?B?NnZsNU41YmJHZE9JVXJ2Sm5OTWVDQmsydmZ1aXp4aEM2b0F3d2kvOHhMcDYv?=
 =?utf-8?B?U1AzN09iUkFWR0NGRnBPMndwRHgxTFFpVXV5aGJQVTBpdVJ3US9WY0ZSb3lP?=
 =?utf-8?B?ZjZYRlNUNkhnc2FaZUVnM0FTYlRxT2h1VERIT0ltY0RXZ3JNTTFjVzZ2cjBa?=
 =?utf-8?B?SXRJYUx0czJRSDZZdnQxK3BVWDBwbnVhSzB3dEtzcjlWTjhhMXBTaFJ4SS90?=
 =?utf-8?B?OFRvK3JQT29RK0wvelk1TGsySGM0Q2ljdzJjeml0c0tQNVc1Q04wZDNaRExn?=
 =?utf-8?B?T21RL0xzOThvSXJScVBocFZIVURUUVl4bThtamp4RWNzQlNkbDRBZ2hRdzdv?=
 =?utf-8?B?Ny91UWF4Y0RuQm5RT1ZYcS8wL0JDSEV6QkxOaDhGeGdFRlg0amUyejN5OFJx?=
 =?utf-8?B?bDhTSnpqZXpaSDdBazkzcFVIV0VuQVU3V2YrSlE0MlFCNXFMeHJsOFN5REIz?=
 =?utf-8?B?NlNsSUlyUUdWRXU3UEhPa1NnY0ZmaU5SeUdVMmh6R2xzWWhtV1M1MGlvLy8x?=
 =?utf-8?B?Qk84cU9yRmdlRDJ0K3pOSmVwR0c5V2c1SVRYc3FWQkpDaEFXM1ZxWUJQd1hi?=
 =?utf-8?B?R1VWTHFoRFBGbU95MHVrc3d5bWNSWlBpejdFWHJ6WHBIRVhDRVJsbG5lVzZy?=
 =?utf-8?B?T1RKTzArWEJKbmhWU2JUVzdYQUNEUjRqbmpVUVZGN29NR05MWmFVMU5udSt6?=
 =?utf-8?B?eTU5eWNpQjhpd1JPZzBhMlRselRhSnZYZFA2dU0vaDNUM3RMWFYwRXY5cXVv?=
 =?utf-8?B?eFVXc0N3d3ZZS1JSRDV1YkprYksybmVlTDludFpJM0FoNFczRkJwMHljeXI5?=
 =?utf-8?B?L3pnMlFLQVFtM2JBOTR0V212Um12ZXltOEFqWnhyZk43Y21IRWltL0h3Q2FT?=
 =?utf-8?B?OEZXV3FkL1NLZUJYK2M2ZGExeGtnY1JwTjNVU3RBTjUrb1FsRnJ5MDN2NnQ0?=
 =?utf-8?B?bjhqOEw0QUw0VVF3b0dFdzZUMnN3WTkrZlFWa2QrUWZRemJFT251WmQ4d3dq?=
 =?utf-8?B?a0dGUEVBTmMzamRBcThmSC83ZG5JdVhVVExEVEtROEhNTEE1VlErc0w3ZzBi?=
 =?utf-8?B?dkZVUktBTlFWTzAvdVVOanlxN3B0NXpqa0llYnF0dTU0S3RRenVWTlZVNDNl?=
 =?utf-8?B?RGJsWVpMdEZISlR0Mlg1SWh6blh5NkxBN05vMnN5S0RJTmRHSmt5QWZOOGZK?=
 =?utf-8?Q?wnCVl9X7bl5JngK0piRQykj3AzWvUyhNxMgTf7y?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a078e13d-7d8a-4bf5-d3d5-08d988498b27
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB4468.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Oct 2021 21:46:09.9702
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IML1BjbM6KX9A9S1APl6WwMWr4+sHyiyflrOmsHTZmfwop8VI2hkzN03aoNDO+EyAxlfE80afnpbMeCtwTaJ5A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR10MB1357
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10128 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 suspectscore=0 adultscore=0
 mlxscore=0 phishscore=0 bulkscore=0 mlxlogscore=999 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2109230001
 definitions=main-2110050127
X-Proofpoint-GUID: kRBn53aQg14eCwb0-ASq2ej18Wnj3S5_
X-Proofpoint-ORIG-GUID: kRBn53aQg14eCwb0-ASq2ej18Wnj3S5_
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tejun,

On 6/10/21 3:09 am, Tejun Heo wrote:
> Hello,
> 
> On Tue, Oct 05, 2021 at 08:55:47PM +1100, imran.f.khan@oracle.com wrote:
>> Please let me know if I am missing some information that may be helpful here
>> and can be obtained only by dumping the states of other workqueues.
>>
>> Then while going through the code, it seemed better to break
>> show_workqueue_state into more granular entities which can be used later for
>> cases such as one mentioned above.
> 
> Both sound reasonable to me. Do you mind updating the description?
> 
I have updated the description in v2 of patch [1].

[1] 
https://lore.kernel.org/lkml/20211005213841.736834-1-imran.f.khan@oracle.com/

Thanks,
Imran

> Thanks.
> 
