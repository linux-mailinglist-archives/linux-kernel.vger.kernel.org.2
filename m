Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D74E39223D
	for <lists+linux-kernel@lfdr.de>; Wed, 26 May 2021 23:43:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233973AbhEZVpK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 May 2021 17:45:10 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:56088 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232976AbhEZVpD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 May 2021 17:45:03 -0400
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 14QLa3jX082235;
        Wed, 26 May 2021 21:43:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=q+uUwWNMDI7Y0XRW3srx0IjOom7qvC0Pvaslq7Qdz9w=;
 b=t8GCO0xnV3kvHRK1Jsg44vI5+pJjv0GBTPqbaggrMVLpacSGwucj0ToJxDpehyS5KFIv
 kg8kCXPe1HSLF9evGu6MkBf1xqKGbm5OcHvJCnasFAAUZF0fy8SwROlMQyTE3DtLunFT
 FtQR6r04727mUIb5YkhJi+/z08nr9SFIw9XurkLvyBGKly69hwtA+SO9HbyDNlZGkiQb
 VWeEtuyLasdsFZSxm8vT6m17mY2Lwb71RFA4B0FULx1ZaF8cKwKrYksoiSKVxMUq4wAz
 xJOqHqBw9OJ79/FdkUSmQue8rWQ99q4IyWkA5Jz39xBeNiY0C+pWBibRqroBCcm29uzI GQ== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by aserp2130.oracle.com with ESMTP id 38pqfcjfjw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 26 May 2021 21:43:11 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 14QLeGCF093951;
        Wed, 26 May 2021 21:43:10 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2103.outbound.protection.outlook.com [104.47.70.103])
        by userp3020.oracle.com with ESMTP id 38qbqtpqet-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 26 May 2021 21:43:09 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bu0vr36hs0RtG8OuhRJcgd7G0AP9oile1Ts1tyKK6C+PTqhkhcFrb/isufoBwAxCMto+UJ5gDvqYpJHyqvZSlmMhHSQIOMs6qYCmzJyozAebyhKn7M4+08+i77LD4In8bVi8XU8LzhqyzbSXC2U/Jyo7SohwPSRV7TSn/MtDJzlrAFlsk6xi5V1eNYgj6OeUEQOtnffTt/zcyjcWO3MF30K/pqc2CwNCefjrLEP/jben9q6O4GfFkqIRFVP+vPSZXIsphYrYUYanK9zCx5hRFCPIiWF/PhZLwa0YelBADl2gTDvVUS12uQ5OpBcGWc8mhPZ/pCuvD0QsHHR0xs2hiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q+uUwWNMDI7Y0XRW3srx0IjOom7qvC0Pvaslq7Qdz9w=;
 b=RMuBLSCuxfzI/q3XAvI0E80ql/fsj2lN9+Mj9WWuzU97WxTrR8FehvB4RmraSwUmM0bJTDjm7GDPiQynkX44QRvzuh+7z38vnxuKrfMzHvEmtT/FhiMS/C7y7PN2UnpVu/6GnM7+NZ7R54LxzTwdDMhYtXZnne6YOuLzCecV2+ap9nS0J5mv4SzngIJ0qDgGDSuOALJ1iSpF3O4OKlrTl1CEogwrnECrPDGNXHN2Yxi86cvAy96pts9YOz8a+McmulNU8SS2MzHAmt10vfVWxrV63Id7yjkgYPfnQ+zEP5k1KTKT6pUr8Riq+0fpCs51GM7k1nXgu+coTt/15lBXLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q+uUwWNMDI7Y0XRW3srx0IjOom7qvC0Pvaslq7Qdz9w=;
 b=inBw1rvbJ6A7xIUEVKAIOCEQdCZVHIzSX2A41Ul2oCp+XtSnQPFxu4qDROHg5ta07dF0cRJbZ9VJvKwpKpy8jLsZdp1wsycq3/RbxCZPhZzcy9Meyn5+rS+2RdZmmg7CaR0XakkmxDwnozvzI6y9ayDqqGC0ngX3O7NmQnVd5/E=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=oracle.com;
Received: from CO1PR10MB4705.namprd10.prod.outlook.com (2603:10b6:303:96::11)
 by MWHPR10MB1552.namprd10.prod.outlook.com (2603:10b6:300:24::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.20; Wed, 26 May
 2021 21:43:06 +0000
Received: from CO1PR10MB4705.namprd10.prod.outlook.com
 ([fe80::9db4:4706:8a20:f069]) by CO1PR10MB4705.namprd10.prod.outlook.com
 ([fe80::9db4:4706:8a20:f069%7]) with mapi id 15.20.4173.020; Wed, 26 May 2021
 21:43:06 +0000
Subject: Re: [PATCH] Documentation: Add usecases, design and interface for
 core scheduling
To:     "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        linux-kernel@vger.kernel.org
Cc:     Josh Don <joshdon@google.com>, mingo@kernel.org,
        peterz@infradead.org, Jonathan Corbet <corbet@lwn.net>,
        linux-doc@vger.kernel.org
References: <20210526175623.34781-1-joel@joelfernandes.org>
From:   Chris Hyser <chris.hyser@oracle.com>
Message-ID: <cc52ec64-62df-34ed-3aee-c149b165b1df@oracle.com>
Date:   Wed, 26 May 2021 17:43:01 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
In-Reply-To: <20210526175623.34781-1-joel@joelfernandes.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [67.242.218.156]
X-ClientProxiedBy: CH2PR19CA0027.namprd19.prod.outlook.com
 (2603:10b6:610:4d::37) To CO1PR10MB4705.namprd10.prod.outlook.com
 (2603:10b6:303:96::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.0.193] (67.242.218.156) by CH2PR19CA0027.namprd19.prod.outlook.com (2603:10b6:610:4d::37) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.20 via Frontend Transport; Wed, 26 May 2021 21:43:05 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e93e6989-1d2e-4b77-0331-08d9208f3f3d
X-MS-TrafficTypeDiagnostic: MWHPR10MB1552:
X-Microsoft-Antispam-PRVS: <MWHPR10MB155232814C5CC283C8161FB59B249@MWHPR10MB1552.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ur1ygrFiejg4CJgs2Ew+8NZjQKBespfIj2fwSS2rojxJsoYIBSpRJKuLY+9knOsf5PwRdEZqreHTJRRzVzlHW0iw0PHExKzyJfrsWFEyNs+5S5LYQms8c+DrX/oN8MenvIWl685x3WbEX0qNYQw8WOvNL/iXBz52DCUQqvDPEHq9Cjr4ZlrnQlL9vZMhWJ44nIezsowBfCMs9J/1GAgMaoVNKIrOU2bxSTsOE6UQgwp1+2YI0EaFp7JV8EQ3hB/6v4kgtZi+7GTnjnmGpr45ia2O8dZtHusWhpX4wj3MR6yoQ44E7Ohu7md7taODec5H74E6raETNuw3DfkDaR1kPlPYU+exZrvHlHNFWNQUH/LLZGntMXSRuOQPE6agrVqrbUp8O6SXOwOvdOpN0+t0KlyBzIH0eelwkLpTBEr2nIAKXrCtnDRssrtYBArVLzm1ykLnUUg/4TbEMGfys/jQJg5zgFvVTPlLYJUh+BDddKfM8OHmiggdDniq/Sk4hSPWjynIjh/ntsb04a/ClYTiZIxKw3oFZOVfdOKAxXPnVGBFU88PdMV5K8ugKqapZ0D52ahzJN6m7+hrjFCbrDXU+gLW/PQkH+abaLxNwYZkjYoIKUaUujX9MGe8bqDX77XWq/YN6pAw7DFviiKqoehzY4qhbAxo20wtlqq/RFtFyukD7X+X/78qSbuNruy7jvQbjwh9OSdO5qJrbU5OnZssog==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR10MB4705.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(39860400002)(396003)(366004)(136003)(376002)(346002)(38100700002)(2906002)(478600001)(5660300002)(38350700002)(30864003)(186003)(36756003)(16526019)(956004)(26005)(6666004)(44832011)(52116002)(66556008)(2616005)(66946007)(66476007)(53546011)(16576012)(316002)(4326008)(6486002)(54906003)(8936002)(86362001)(31686004)(31696002)(83380400001)(8676002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?K1BmWGoxbnBVWS9NeGx0VzR3bCtSaHBhSFQ0SExoZ3p6VFN0RmFJRGRHdFBQ?=
 =?utf-8?B?MXlIcTNqc21nSnRTZEhVMkF4NmtzS0V2L1hwY3VnNmE4QldyT1RsWGZMaVJn?=
 =?utf-8?B?ZEhGNnh1NGxtRjdaTTVuazE1V0RaTy9KQ1E3S0JPbkl4Q29EdGp4Q1A2VGd5?=
 =?utf-8?B?R21HeE5vR0lLbkRDNlhSMi93NXZXK3dJRmZrOXlhelUwdlcyQjJKOEdSR2l0?=
 =?utf-8?B?Y2kvVythUU9EYlduRzNrS3lpWDhvN2YzWWwvdUVjeWRJSWs5Y3pnYTU5cEhr?=
 =?utf-8?B?RDhOWk1RZkFBV1ZZY1VaZVVHMjVTUXBoUUcrcjhveWhDNWdEbFE3TlBNU0xr?=
 =?utf-8?B?TWl3cHNnM29wQis3TEdyMzhRYjdiZ1Vyd3REb0VOek9iMnFSeW85OS9RNlJO?=
 =?utf-8?B?LytWZEl5eU5zdGp6OUFRWU1GaG0vVEgzTWk5TmJzM21udEQrQzV0ZFQ3SWdN?=
 =?utf-8?B?RFpQOHFMTmJaT2EwSDBYZU05WmVTV1NJeis3UysxNjBBQktrMDVOY3RzTkxi?=
 =?utf-8?B?ekVKK0pDbUg5dzZhTkdtUkdkVmlCL1FSLzd6TzFMR2wwY25zSUlrM0o4VkFP?=
 =?utf-8?B?ZzlSaklLSmJaaG5lZitGckVHLzgvQ1BTMm9DUlFTd2dGTE1tb3FheWRFZTdM?=
 =?utf-8?B?TEpKcHhGQzA4YlNGWEdPNkZPeTU2UjBRbGJXbjdwR0ZyNXVJRnR6bENFR2hn?=
 =?utf-8?B?cGdEOXRDUUx6R0pDUHo0aWxXYkRUblhwVnN3d1QxcWUzOHZjUjlEQ3BzLzNJ?=
 =?utf-8?B?UkpZYUtUa0E5QVEvU2JmNGlTaEtQYUtzeEN0UDFUN3o5L0ExWkQ3c240YnNu?=
 =?utf-8?B?RGFPT3BoVmlMazR1d3JIVS9MU0R6OFQrbmY4eExja3VXWUY5a01Pb3pQelVW?=
 =?utf-8?B?SFhsTzFGN25hdmVzZGRTRVMvQVlzMmU2cTJUUU5qS2JobGhZeFFaY1hqOFlx?=
 =?utf-8?B?dkNYMUQvTDBHdHljR21NMWpIaXJXNUVtMTJKUExVT3N0MEcvYjl1d0c5V2di?=
 =?utf-8?B?ZWhIWTZoNy95SUFyaHRXR05Vc1J2dzNHYk1GUGVJc2pqSGpPbjFLL0Y5Yk5Z?=
 =?utf-8?B?RmcrU0ZJTnd5dWRFM3p4Q3BGU01VdjVZZzR2U2tLYUZqZklxTXJkL1B2T3R2?=
 =?utf-8?B?cElORzhmbmU3ZktuV2l5NXppOW50YXkxY09iU296NUlQWEpEbE9nU0VqdThS?=
 =?utf-8?B?NWxMZUcrTWx1aGhEaWN3ajBRM0hEY3BLa3hzUENjaFAraHluRDJtbXNQS1A4?=
 =?utf-8?B?OUkzRnNJamxyaHlLZlFwbkpYcEhDdmlOVnk3SUFxNkZBNzBQKzVDc1Y2UnU3?=
 =?utf-8?B?WjVSdi9mMHdJQnZqYjdDbmFuNUxkUldHYVJoYWtrRTUyUEorREJlVEtkdTNw?=
 =?utf-8?B?V1ZicWhtV25TbWFWQkFCUlVWVUxTbWVBSldLM0JlV1gxckRoK0dha0JJdHhn?=
 =?utf-8?B?M0FaT09qNWlaQ0Z1d3REMlIwcnBFOVhzZGZWRmdFeGZpY2ptcThuQWhFVkdZ?=
 =?utf-8?B?aFNmL3BqTjY5emlBSDc2ZW01cWdXb3pnQzRSU29hbU9rdTZ0aGRsUXN6UmV4?=
 =?utf-8?B?SmRKV1BUc1FNbUVOMTBtWk0wM25jS0NKSnJ2eDlPUmttREhsSUVpTzB1Z1lh?=
 =?utf-8?B?djFPRDBHSU1Qc0t2QUg3dmZydWNnSVp4NlE4djhIVEgzVEhUMjhTOFdmdFZL?=
 =?utf-8?B?N0NzdWJHc0RsZ1h4WHEwNjBjMmxDWXNnK1ZpeDBsMzhRYWFoT3NNZjlCSnBh?=
 =?utf-8?Q?Tmw29IJam4+t769iJPb9vnuolXQmV7kcLmWc5gl?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e93e6989-1d2e-4b77-0331-08d9208f3f3d
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB4705.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 May 2021 21:43:06.5082
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oO2kCz0KVhy5qfK5z13HEReeSJuiuM5SSAkEUlpqiHLmpAbWr5YFcBasRQAWjb24tF+dku42ZYcvqzSlQsDafg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR10MB1552
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9996 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 phishscore=0 bulkscore=0
 mlxlogscore=999 malwarescore=0 spamscore=0 suspectscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104190000
 definitions=main-2105260146
X-Proofpoint-ORIG-GUID: j7tAGjx49ebkQUruwMVP0SCzkww6nRdf
X-Proofpoint-GUID: j7tAGjx49ebkQUruwMVP0SCzkww6nRdf
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9996 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 spamscore=0 mlxscore=0
 malwarescore=0 mlxlogscore=999 lowpriorityscore=0 impostorscore=0
 adultscore=0 phishscore=0 priorityscore=1501 clxscore=1011 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104190000
 definitions=main-2105260145
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/26/21 1:56 PM, Joel Fernandes (Google) wrote:
> Now that core scheduling is merged, update the documentation.
> 
> Co-developed-by: Chris Hyser <chris.hyser@oracle.com>
> Signed-off-by: Chris Hyser <chris.hyser@oracle.com>
> Co-developed-by: Josh Don <joshdon@google.com>
> Signed-off-by: Josh Don <joshdon@google.com>
> Cc: mingo@kernel.org
> Cc: peterz@infradead.org
> Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> 
> ---
>   .../admin-guide/hw-vuln/core-scheduling.rst   | 211 ++++++++++++++++++
>   Documentation/admin-guide/hw-vuln/index.rst   |   1 +
>   2 files changed, 212 insertions(+)
>   create mode 100644 Documentation/admin-guide/hw-vuln/core-scheduling.rst
> 
> diff --git a/Documentation/admin-guide/hw-vuln/core-scheduling.rst b/Documentation/admin-guide/hw-vuln/core-scheduling.rst
> new file mode 100644
> index 000000000000..585edf16183b
> --- /dev/null
> +++ b/Documentation/admin-guide/hw-vuln/core-scheduling.rst
> @@ -0,0 +1,211 @@
> +.. SPDX-License-Identifier: GPL-2.0
> +
> +Core Scheduling
> +***************
> +Core scheduling support allows userspace to define groups of tasks that can
> +share a core. These groups can be specified either for security usecases (one
> +group of tasks don't trust another), or for performance usecases (some
> +workloads may benefit from running on the same core as they don't need the same
> +hardware resources of the shared core, or may prefer different cores if they
> +do share hardware resource needs). This document only describes the security
> +usecase.
> +
> +Security usecase
> +----------------
> +A cross-HT attack involves the attacker and victim running on different Hyper
> +Threads of the same core. MDS and L1TF are examples of such attacks.  The only
> +full mitigation of cross-HT attacks is to disable Hyper Threading (HT). Core
> +scheduling is a scheduler feature that can mitigate some (not all) cross-HT
> +attacks. It allows HT to be turned on safely by ensuring that tasks in a
> +user-designated trusted group can share a core. This increase in core sharing
> +can also improve performance, however it is not guaranteed that performance
> +will always improve, though that is seen to be the case with a number of real
> +world workloads. In theory, core scheduling aims to perform at least as good as
> +when Hyper Threading is disabled. In practice, this is mostly the case though
> +not always: as synchronizing scheduling decisions across 2 or more CPUs in a
> +core involves additional overhead - especially when the system is lightly
> +loaded. When ``total_threads <= N_CPUS/2``, the extra overhead may cause core
> +scheduling to perform more poorly compared to SMT-disabled, where N_CPUS is the
> +total number of CPUs. Please measure the performance of your workloads always.
> +
> +Usage
> +-----
> +Core scheduling support is enabled via the ``CONFIG_SCHED_CORE`` config option.
> +Using this feature, userspace defines groups of tasks that can be co-scheduled
> +on the same core. The core scheduler uses this information to make sure that
> +tasks that are not in the same group never run simultaneously on a core, while
> +doing its best to satisfy the system's scheduling requirements.
> +
> +Core scheduling can be enabled via the ``PR_SCHED_CORE`` prctl interface.
> +This interface provides support for the creation of core scheduling groups, as
> +well as admission and removal of tasks from created groups.
> +
> +::
> +
> +    #include <sys/prctl.h>
> +
> +    int prctl(int option, unsigned long arg2, unsigned long arg3,
> +            unsigned long arg4, unsigned long arg5);
> +
> +option:
> +    ``PR_SCHED_CORE``
> +
> +arg2:
> +    Command for operation, must be one off:
> +    - ``PR_SCHED_CORE_GET              0  -- get core_sched cookie of ``pid``.
> +    - ``PR_SCHED_CORE_CREATE           1  -- create a new unique cookie for ``pid``.
> +    - ``PR_SCHED_CORE_SHARE_TO         2  -- push core_sched cookie to ``pid``.
> +    - ``PR_SCHED_CORE_SHARE_FROM       3  -- pull core_sched cookie from ``pid``.
> +
> +arg3:
> +    ``pid`` of the task for which the operation applies.
> +
> +arg4:
> +    ``pid_type`` for which the operation applies. It is of type ``enum pid_type``.
> +    For example, if arg4 is ``PIDTYPE_TGID``, then the operation of this command
> +    will be performed for all tasks in the task group of ``pid``.
> +
> +arg5:
> +    userspace pointer to an unsigned long for storing the cookie returned by
> +    ``PR_SCHED_CORE_GET`` command. Should be 0 for all other commands.

Thanks Joel.

In terms of using the prctl() interface to achieve what was once done with cgroups, we might want to add some text 
somewhere in here along the lines of say:

-----------

The simplest way to build hierarchies of threads/processes which share a cookie and thus a core is to rely on the fact 
that the core-sched cookie is inherited across forks/clones and execs, thus setting a cookie for the 'initial' 
script/executable/daemon will place every spawned child in the same core-sched group. The prctl() API is useful for 
verification or making more specific or elaborate changes. Clearing a cookie can be done with PR_SCHED_CORE_SHARE_* 
involving a task w/o a cookie presumably owned by root or other secure user.



> +
> +Cookie Transferral
> +~~~~~~~~~~~~~~~~~~
> +Transferring a cookie between the current and other tasks is possible using
> +PR_SCHED_CORE_SHARE_FROM and PR_SCHED_CORE_SHARE_TO to inherit a cookie from a
> +specified task or a share a cookie with a task. In combination this allows a
> +simple helper program to pull a cookie from a task in an existing core
> +scheduling group and share it with already running tasks.
> +
> +Design/Implementation
> +---------------------
> +Each task that is tagged is assigned a cookie internally in the kernel. As
> +mentioned in `Usage`_, tasks with the same cookie value are assumed to trust
> +each other and share a core.
> +
> +The basic idea is that, every schedule event tries to select tasks for all the
> +siblings of a core such that all the selected tasks running on a core are
> +trusted (same cookie) at any point in time. Kernel threads are assumed trusted.
> +The idle task is considered special, as it trusts everything and everything
> +trusts it.
> +
> +During a schedule() event on any sibling of a core, the highest priority task on
> +the sibling's core is picked and assigned to the sibling calling schedule(), if
> +the sibling has the task enqueued. For rest of the siblings in the core,
> +highest priority task with the same cookie is selected if there is one runnable
> +in their individual run queues. If a task with same cookie is not available,
> +the idle task is selected.  Idle task is globally trusted.
> +
> +Once a task has been selected for all the siblings in the core, an IPI is sent to
> +siblings for whom a new task was selected. Siblings on receiving the IPI will
> +switch to the new task immediately. If an idle task is selected for a sibling,
> +then the sibling is considered to be in a `forced idle` state. I.e., it may
> +have tasks on its on runqueue to run, however it will still have to run idle.
> +More on this in the next section.
> +
> +Forced-idling of tasks
> +----------------------
> +The scheduler tries its best to find tasks that trust each other such that all
> +tasks selected to be scheduled are of the highest priority in a core.  However,
> +it is possible that some runqueues had tasks that were incompatible with the
> +highest priority ones in the core. Favoring security over fairness, one or more
> +siblings could be forced to select a lower priority task if the highest
> +priority task is not trusted with respect to the core wide highest priority
> +task.  If a sibling does not have a trusted task to run, it will be forced idle
> +by the scheduler (idle thread is scheduled to run).
> +
> +When the highest priority task is selected to run, a reschedule-IPI is sent to
> +the sibling to force it into idle. This results in 4 cases which need to be
> +considered depending on whether a VM or a regular usermode process was running
> +on either HT::
> +
> +          HT1 (attack)            HT2 (victim)
> +   A      idle -> user space      user space -> idle
> +   B      idle -> user space      guest -> idle
> +   C      idle -> guest           user space -> idle
> +   D      idle -> guest           guest -> idle
> +
> +Note that for better performance, we do not wait for the destination CPU
> +(victim) to enter idle mode. This is because the sending of the IPI would bring
> +the destination CPU immediately into kernel mode from user space, or VMEXIT
> +in the case of guests. At best, this would only leak some scheduler metadata
> +which may not be worth protecting. It is also possible that the IPI is received
> +too late on some architectures, but this has not been observed in the case of
> +x86.
> +
> +Trust model
> +-----------
> +Core scheduling maintains trust relationships amongst groups of tasks by
> +assigning them a tag that is the same cookie value.
> +When a system with core scheduling boots, all tasks are considered to trust
> +each other. This is because the core scheduler does not have information about
> +trust relationships until userspace uses the above mentioned interfaces, to
> +communicate them. In other words, all tasks have a default cookie value of 0.
> +and are considered system-wide trusted. The stunning of siblings running
> +cookie-0 tasks is also avoided.
> +
> +Once userspace uses the above mentioned interfaces to group sets of tasks, tasks
> +within such groups are considered to trust each other, but do not trust those
> +outside. Tasks outside the group also don't trust tasks within.
> +
> +Limitations of core-scheduling
> +------------------------------
> +Core scheduling tries to guarantee that only trusted tasks run concurrently on a
> +core. But there could be small window of time during which untrusted tasks run
> +concurrently or kernel could be running concurrently with a task not trusted by
> +kernel.
> +
> +1. IPI processing delays
> +########################
> +Core scheduling selects only trusted tasks to run together. IPI is used to notify
> +the siblings to switch to the new task. But there could be hardware delays in
> +receiving of the IPI on some arch (on x86, this has not been observed). This may
> +cause an attacker task to start running on a CPU before its siblings receive the
> +IPI. Even though cache is flushed on entry to user mode, victim tasks on siblings
> +may populate data in the cache and micro architectural buffers after the attacker
> +starts to run and this is a possibility for data leak.
> +
> +Open cross-HT issues that core scheduling does not solve
> +--------------------------------------------------------
> +1. For MDS
> +##########
> +Core scheduling cannot protect against MDS attacks between an HT running in
> +user mode and another running in kernel mode. Even though both HTs run tasks
> +which trust each other, kernel memory is still considered untrusted. Such
> +attacks are possible for any combination of sibling CPU modes (host or guest mode).
> +
> +2. For L1TF
> +###########
> +Core scheduling cannot protect against an L1TF guest attacker exploiting a
> +guest or host victim. This is because the guest attacker can craft invalid
> +PTEs which are not inverted due to a vulnerable guest kernel. The only
> +solution is to disable EPT (Extended Page Tables).
> +
> +For both MDS and L1TF, if the guest vCPU is configured to not trust each
> +other (by tagging separately), then the guest to guest attacks would go away.
> +Or it could be a system admin policy which considers guest to guest attacks as
> +a guest problem.
> +
> +Another approach to resolve these would be to make every untrusted task on the
> +system to not trust every other untrusted task. While this could reduce
> +parallelism of the untrusted tasks, it would still solve the above issues while
> +allowing system processes (trusted tasks) to share a core.
> +
> +3. Protecting the kernel (IRQ, syscall, VMEXIT)
> +###############################################
> +Unfortunately, core scheduling does not protect kernel contexts running on
> +sibling hyperthreads from one another. Prototypes of mitigations have been posted
> +to LKML to solve this, but it is debatable whether such windows are practically
> +exploitable, and whether the performance overhead of the prototypes are worth
> +it (not to mention, the added code complexity).
> +
> +Other Use cases
> +---------------
> +The main use case for Core scheduling is mitigating the cross-HT vulnerabilities
> +with SMT enabled. There are other use cases where this feature could be used:
> +
> +- Isolating tasks that needs a whole core: Examples include realtime tasks, tasks
> +  that uses SIMD instructions etc.
> +- Gang scheduling: Requirements for a group of tasks that needs to be scheduled
> +  together could also be realized using core scheduling. One example is vCPUs of
> +  a VM.
> diff --git a/Documentation/admin-guide/hw-vuln/index.rst b/Documentation/admin-guide/hw-vuln/index.rst
> index ca4dbdd9016d..f12cda55538b 100644
> --- a/Documentation/admin-guide/hw-vuln/index.rst
> +++ b/Documentation/admin-guide/hw-vuln/index.rst
> @@ -15,3 +15,4 @@ are configurable at compile, boot or run time.
>      tsx_async_abort
>      multihit.rst
>      special-register-buffer-data-sampling.rst
> +   core-scheduling.rst
> 
