Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 342F7382F9F
	for <lists+linux-kernel@lfdr.de>; Mon, 17 May 2021 16:17:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238854AbhEQOSk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 May 2021 10:18:40 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:38572 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237164AbhEQOQk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 May 2021 10:16:40 -0400
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 14HEEP76105872;
        Mon, 17 May 2021 14:15:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=gBeVUWkgY2HO921nItuNFKt635tVvUCCJ/Ouvse+aYI=;
 b=vuc9Qoul5G5GsFxY6X3KFt/LrpaXCZeFtn7Y7v+IgASbqlpT7og3qS9inAPurJ9A+99N
 5wzxOuSHSaalZ29TdVsp+8qbkpBjr5lX0ft6SBzTyggBT2ZYFEqY+pF3mTzAA/xopm+g
 nDCKDs7wnndJq4M2m0QHZj/6mB+UzyuvXnxog2JA5rQEqx5whEwZeqKNHtMvrSceVZAC
 pzW7vyPdX3MIDCsNpd28J14wZD+2nGY4ed9khLozLRIN8QjbwP+8unIfIL7GNmpH26Eo
 dSav4yDibEv1ia3wj20gCfl/WMvkrVqLTyUD2cMIIZ0/afGYyHEsX0+ooOx/oEs6mUoD Fw== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by aserp2130.oracle.com with ESMTP id 38j3tbbe9c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 17 May 2021 14:15:18 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 14HE0M4n023309;
        Mon, 17 May 2021 14:15:17 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2103.outbound.protection.outlook.com [104.47.70.103])
        by userp3020.oracle.com with ESMTP id 38kb36y12e-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 17 May 2021 14:15:17 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bKDLCv1dCXIzceBW9hoYoKnU9vZ+bFtwwaVo5mqN56OeCPfJjlT7aaGYVqEHXVeIy9bNRxLVt3OfTekR3aA5i/WWb69Iu4bt34CLMeIP/QonGn+LW5GNOdo/hSTbVKNC2JOfLsUY01wJIoGq5VSoepcL3uGLxp5RBlz5RzcnMbNDW2FBkf23o2yE8Y3Nd0X5o7xe301tQTwVTU3cFTYdn7mR+GRzOYx2H6cF6s7hzCwoCjYbwES6MjOadxscfcuU9z03P5rUAvPe9o2P5aVUXWL9ZGA3RpKIWjI685jgHCgozr84aXPj0fOdRjft6kLQknwaiwlK8xYdysAMNUcmzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gBeVUWkgY2HO921nItuNFKt635tVvUCCJ/Ouvse+aYI=;
 b=ah0VMTU8Eg2By7aVDIqhuaDDbcBvcOhJ6e/uH4pbM/oaML0YixT1LaTriOricApb3TVrK6Vxzhup7vOkW0hmw/JyKl09cQrhycsOxfvA8Lp6GeGv2dXL5aLplKKl7rrYfr9A3HzsRJwEUNZ3QFD+SlWjZnY2SOcPesojqM6o5mYM15W25MIsxGH0WwLO/GiVzelLsWxVo1MLlemfvvamy0YxIanqanJqdUL5Y3e9V7eGS1Pns7Uh89yI5xBCODj2i6neZnWr1Svb2QbseOsK0OIlzbqTD5LFr0USPzelCEmwOtkFRDJH4UOJN3I4RznHwTDLJSBBBlCUo64SzK9QSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gBeVUWkgY2HO921nItuNFKt635tVvUCCJ/Ouvse+aYI=;
 b=BL3zftPRb/ykdg5ZrDzOcDTfM0k8gH+yM7anEENu5U6sVtY6n1wQjlrqA0VmDgkwbECLYO7x49gWziHj8OIUbJWhvqfa0JRkJjBDDxDEYlFv0Ek5dss/wbw8Wi+dDNZTDG6f8KUGJJbnADvaHM9Uj/fZmZI4SLA8EyUOMI9ikxg=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=oracle.com;
Received: from BY5PR10MB3793.namprd10.prod.outlook.com (2603:10b6:a03:1f6::14)
 by BY5PR10MB3841.namprd10.prod.outlook.com (2603:10b6:a03:1f8::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4129.28; Mon, 17 May
 2021 14:15:14 +0000
Received: from BY5PR10MB3793.namprd10.prod.outlook.com
 ([fe80::61b8:e6b6:b674:5483]) by BY5PR10MB3793.namprd10.prod.outlook.com
 ([fe80::61b8:e6b6:b674:5483%5]) with mapi id 15.20.4129.031; Mon, 17 May 2021
 14:15:14 +0000
Subject: Re: [PATCH] x86/boot: Place kernel_info at a fixed offset
To:     Arvind Sankar <nivedita@alum.mit.edu>, x86@kernel.org
Cc:     linux-kernel@vger.kernel.org
References: <20200929210455.2718827-1-nivedita@alum.mit.edu>
From:   Ross Philipson <ross.philipson@oracle.com>
Message-ID: <df333bb1-4a7f-9e0c-738c-9840d7466f71@oracle.com>
Date:   Mon, 17 May 2021 10:15:12 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
In-Reply-To: <20200929210455.2718827-1-nivedita@alum.mit.edu>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [209.17.40.38]
X-ClientProxiedBy: SA0PR12CA0016.namprd12.prod.outlook.com
 (2603:10b6:806:6f::21) To BY5PR10MB3793.namprd10.prod.outlook.com
 (2603:10b6:a03:1f6::14)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [10.39.198.82] (209.17.40.38) by SA0PR12CA0016.namprd12.prod.outlook.com (2603:10b6:806:6f::21) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.25 via Frontend Transport; Mon, 17 May 2021 14:15:13 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9aa758b7-a15a-4eaf-e8a2-08d9193e30a8
X-MS-TrafficTypeDiagnostic: BY5PR10MB3841:
X-Microsoft-Antispam-PRVS: <BY5PR10MB38416F4E12600ED2AC303870E62D9@BY5PR10MB3841.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PxrfhEELwlNYTmgE99AS5E3WE7+sUlwfpfJxV8/Yk+6ZrLkpamxljuY1Q5sil3mL39zyItd6wfcNrTZr3rOisSrZWa8Zl0t0lmt85Ah0yVdH2+9RrrTszZksps4lTU+PI6MS3/1DvTWW0SgOABEICN987lvCe6swWO2b9qj0HGQl4zXYWhTGQzzQPoG6fptQ7TF/GFlyiS+XqZhP/TvX7yl8Q53mY7J00DQBam3GLtIk7mWGMaBHbfiVDNxoLwMiqUqZ1Dd6stMW7bsU2z/vZLPvaXLaNcj19T6eHWFpc8VxBZ9xcnRh/JuCAib7rE7/0mdFITELkEHEGy75tp7VXw+KpMyAlUH0ZJIIHBOKp/yqkkkcoXsT3l15kfTK9ougfjCXTnGlxClOs2M0pXgZPHMu+LLImLuwA3CQDT8OIHiA9P3f540Lc2Pv9OyhLPI+cfv+ppF1BQPr5YnY2Ld79GsMoYuguDNHLfDQ80RSfFvNQucneBs1YX/Yld2ED1RxIUKkZixk2W2dpqzl7cOeVlPvdZlRra88f9MX02aEj3dtnvXldrREw18ccCR+W8RYx/Tcxb/C5I4GJa2LaD1+Yr+fhQMikSjX4RDav9mb175yV9TVEMWQacEcrzHp2B4aMpszdc1Nh13kuA0XNstJ4UvFXt6FNWSNcTER6RGFRrGd5Rn6xYaHGY+i7xVgyoZtBnI85FDneVuqNvLxhaNODXAI6YtE9kS6RVApcPtCNedtJajuyr3ycmFufeyenGOIhzgUd+hOWMsXY38KzxJQnQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB3793.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(346002)(376002)(396003)(136003)(39860400002)(316002)(16576012)(31696002)(44832011)(53546011)(956004)(8936002)(31686004)(478600001)(8676002)(38100700002)(66476007)(6486002)(5660300002)(66556008)(66946007)(86362001)(966005)(2906002)(4326008)(16526019)(36756003)(83380400001)(186003)(2616005)(26005)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?dlQ0c2cwQUlDZ1BxZ3JYUHpsK3ByYk85d2NOQnVaMHBDQ1ozNWg2TFh2MXo2?=
 =?utf-8?B?Q3JzWVVhUHVnLzF3Nk9HQ0tkb0pRdDljeDNjV2o5Z28zblgzSTdHS2VVVHdY?=
 =?utf-8?B?STZyZ0FNR1hGdmsweEVIaUNaZ3ZpZ2ppQW56VURkU21lUWUzN0R6TFZwWm52?=
 =?utf-8?B?aTBNQWp2aVZCeU0vd3JsbFpXMUY2Q2FhVmpnT0NWK00yV3k1V3c0RzUwaUlt?=
 =?utf-8?B?eGVzSGE5Y3J4VmJDcjJkVXJpamQ4YUFQcDBPd1hUdG1PL0RnLzFuTmJTeEpR?=
 =?utf-8?B?VVFhbkUrWUpacmV1aFhUTFNBdmlGcEJlVlpOdEs0Si9XUU0wVDhkSTlLTFAy?=
 =?utf-8?B?QnBjSHBDdXJKTXh0SUFUbldMRFNhZ2NIMUFXK0VheHdvVTFUL2lIVnJvRzFC?=
 =?utf-8?B?b096NkttMHZYSTVWOXVWekdvanVDVnQ2NjJDT0E5dUI2VmxkaXltdy80eVBp?=
 =?utf-8?B?ZzJjRWdabzQxOGpvY3RNbVRUMURqVlNxTkJTa1dCOHZ0TXRrNDJUZ3R4SVVE?=
 =?utf-8?B?VjlONEFMSjdBOEJLVTlTMTVzZ3BoeGM0ODE0ZDZ6Nm9Id1gzNVNQby9ZVlZS?=
 =?utf-8?B?UThPNTJiUTErMVp2UkN3a2NlYlpGT2xicVd2enBSRlpzMXo4OEhNS3d4Zkd4?=
 =?utf-8?B?UWVxU0cySWRjVkVqQklGbUdLUWllMDFPYkxmKzMvSFphTGxMcENGME9RanBP?=
 =?utf-8?B?dGVJeEpKN3JiKy93c3Z2VnlsZEVoczVuU2N5Z2tWRGF4QlM4ZnI3bm9QKzRF?=
 =?utf-8?B?SC9CYWdjazEvUGh6OEZYYzk4TGI3VTRWZ3Y0KzNkN2tnZEdOcEJTcVJMOXUw?=
 =?utf-8?B?eWxWSkQzYWJTdExCYWpnOVk4R25zR3RlK3pVWlhtdGk2RzEzVDZRVUwyOUYr?=
 =?utf-8?B?M0hoMHhiY3lneHNLeUtPRVZmWm1YTWx6UjJnMjE0dElQS2MzeHh1REppcXRp?=
 =?utf-8?B?cVEyOFZNNE10K1BkT2kzMDRvUjUreXFFV2x3YUErV1p0QTZSelRkNGpBckFF?=
 =?utf-8?B?eDFaSlFIZUlyb25raDE3ZmIxR0pmVzdHT0FzZmhoVm1RVmViRmNKT1N6cWo3?=
 =?utf-8?B?WFZHdzlWU0UxT1RNWXBiV3E3RTJUdkptT0JNaWhYcWhKSlhUL1N2OXZGSkRl?=
 =?utf-8?B?RVJ2Rlk3NUxsZ1dFclVIeUp4QUZqZ3piZURPdG92aVB4YzZpZlovbmdhbXUr?=
 =?utf-8?B?a2R6QmRSbC9MS1lpWGxGT2ZVZGVmYWdHcFRrMlRRdEtNOWZYbXYyTkdoekd6?=
 =?utf-8?B?WEtwSHhPZCthdjlFZGU4Qzk4UjZBMDJQK2VRS2o1SXZTbVlGZTVPeFJna0xV?=
 =?utf-8?B?c3NsOGhkeC9tYldUaG8raitaazRlTnFOVTRxcFdlRzlpaGEzUVhpNDBncVlj?=
 =?utf-8?B?WFNaRmhpOHhhS1BHam5SV2V1eGxkUVVTYlJsMis1YVNmN2ZnYWEvWXdvSlNx?=
 =?utf-8?B?V3JSMVZlT3pZM3pCUUo4VlI4Y0oxL2NaZm5EenMreDhZTVlWVUpwZkFmNlBs?=
 =?utf-8?B?cmNMWUpUYlF4ZWRqRWxUUlkyMzZ2akxqaURGNzhaaW53anRqbzBDUHl1ZktW?=
 =?utf-8?B?ZnpLZkNzOEhXazhmWnJjK2JFdXhPSnd4b1d0Z2lKQy84SmRlVHVBSXVpMmR0?=
 =?utf-8?B?NDVsZFc0MXd6NjJuRkI1bmQ4RVloeHFkS1I4bFBxTW5UZkxVWHlrODRKQXlS?=
 =?utf-8?B?NFNXQ2ZnUHI4NUMybjR0c1R4WGRXVFg5L3dKOEJmQ3haTmcvL2lRKzVwWURK?=
 =?utf-8?Q?NcgG9IqJxP8BTmbXOqxQZAQhlney+Un2llT31wY?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9aa758b7-a15a-4eaf-e8a2-08d9193e30a8
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB3793.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 May 2021 14:15:14.7676
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ocwoI6kL1WJa6g/PL6s32Lu3a+qsY59lYMfjFHUauwRat/3ykQ54YRLKT7flg0NH0qk0+pWUds77G0HtD0gQWaBets3f58oyKByNOziU484=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB3841
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9986 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 malwarescore=0 mlxscore=0
 adultscore=0 spamscore=0 phishscore=0 suspectscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104190000
 definitions=main-2105170100
X-Proofpoint-ORIG-GUID: -s93DrQ0YY4deuYCt0glolwGu7fp3zPE
X-Proofpoint-GUID: -s93DrQ0YY4deuYCt0glolwGu7fp3zPE
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9986 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 lowpriorityscore=0 malwarescore=0
 spamscore=0 priorityscore=1501 suspectscore=0 mlxlogscore=999 mlxscore=0
 impostorscore=0 adultscore=0 clxscore=1011 phishscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104190000
 definitions=main-2105170101
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/29/20 5:04 PM, Arvind Sankar wrote:
> There are use cases for storing the offset of a symbol in kernel_info.
> For example, the trenchboot series [0] needs to store the offset of the
> Measured Launch Environment header in kernel_info.
> 
> Since commit (note: commit ID from tip/master)
> 
>   527afc212231 ("x86/boot: Check that there are no run-time relocations")
> 
> run-time relocations are not allowed in the compressed kernel, so simply
> using the symbol in kernel_info, as
> 
> 	.long	symbol
> 
> will cause a linker error because this is not position-independent.
> 
> With kernel_info being a separate object file and in a different section
> from startup_32, there is no way to calculate the offset of a symbol
> from the start of the image in a position-independent way.
> 
> To enable such use cases, put kernel_info into its own section which is
> placed at a predetermined offset (KERNEL_INFO_OFFSET) via the linker
> script. This will allow calculating the symbol offset in a
> position-independent way, by adding the offset from the start of
> kernel_info to KERNEL_INFO_OFFSET.
> 
> Ensure that kernel_info is aligned, and use the SYM_DATA.* macros
> instead of bare labels. This stores the size of the kernel_info
> structure in the ELF symbol table.

Arvind,

Hello. I wanted to ping you and see what the status of this patch is. It
does not look like it got accepted anywhere including in tip.git.

Thank you,
Ross Philipson

> 
> Signed-off-by: Arvind Sankar <nivedita@alum.mit.edu>
> Cc: Ross Philipson <ross.philipson@oracle.com>
> [0] https://urldefense.com/v3/__https://lore.kernel.org/lkml/1600959521-24158-8-git-send-email-ross.philipson@oracle.com/__;!!GqivPVa7Brio!JiEGSToX4gewsr8DY0iWrRR7oTzMZl1b-WBsZ1U6M7dCJXuGzIrF-5qVqN4v8LEys8M$ 
> ---
>  arch/x86/boot/compressed/kernel_info.S | 19 +++++++++++++++----
>  arch/x86/boot/compressed/kernel_info.h | 12 ++++++++++++
>  arch/x86/boot/compressed/vmlinux.lds.S |  6 ++++++
>  3 files changed, 33 insertions(+), 4 deletions(-)
>  create mode 100644 arch/x86/boot/compressed/kernel_info.h
> 
> diff --git a/arch/x86/boot/compressed/kernel_info.S b/arch/x86/boot/compressed/kernel_info.S
> index f818ee8fba38..c18f07181dd5 100644
> --- a/arch/x86/boot/compressed/kernel_info.S
> +++ b/arch/x86/boot/compressed/kernel_info.S
> @@ -1,12 +1,23 @@
>  /* SPDX-License-Identifier: GPL-2.0 */
>  
> +#include <linux/linkage.h>
>  #include <asm/bootparam.h>
> +#include "kernel_info.h"
>  
> -	.section ".rodata.kernel_info", "a"
> +/*
> + * If a field needs to hold the offset of a symbol from the start
> + * of the image, use the macro below, eg
> + *	.long	rva(symbol)
> + * This will avoid creating run-time relocations, which are not
> + * allowed in the compressed kernel.
> + */
> +
> +#define rva(X) (((X) - kernel_info) + KERNEL_INFO_OFFSET)
>  
> -	.global kernel_info
> +	.section ".rodata.kernel_info", "a"
>  
> -kernel_info:
> +	.balign	16
> +SYM_DATA_START(kernel_info)
>  	/* Header, Linux top (structure). */
>  	.ascii	"LToP"
>  	/* Size. */
> @@ -19,4 +30,4 @@ kernel_info:
>  
>  kernel_info_var_len_data:
>  	/* Empty for time being... */
> -kernel_info_end:
> +SYM_DATA_END_LABEL(kernel_info, SYM_L_LOCAL, kernel_info_end)
> diff --git a/arch/x86/boot/compressed/kernel_info.h b/arch/x86/boot/compressed/kernel_info.h
> new file mode 100644
> index 000000000000..c127f84aec63
> --- /dev/null
> +++ b/arch/x86/boot/compressed/kernel_info.h
> @@ -0,0 +1,12 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +
> +#ifndef BOOT_COMPRESSED_KERNEL_INFO_H
> +#define BOOT_COMPRESSED_KERNEL_INFO_H
> +
> +#ifdef CONFIG_X86_64
> +#define KERNEL_INFO_OFFSET 0x500
> +#else /* 32-bit */
> +#define KERNEL_INFO_OFFSET 0x100
> +#endif
> +
> +#endif /* BOOT_COMPRESSED_KERNEL_INFO_H */
> diff --git a/arch/x86/boot/compressed/vmlinux.lds.S b/arch/x86/boot/compressed/vmlinux.lds.S
> index 112b2375d021..84c7b4de489e 100644
> --- a/arch/x86/boot/compressed/vmlinux.lds.S
> +++ b/arch/x86/boot/compressed/vmlinux.lds.S
> @@ -7,6 +7,7 @@ OUTPUT_FORMAT(CONFIG_OUTPUT_FORMAT)
>  
>  #include <asm/cache.h>
>  #include <asm/page_types.h>
> +#include "kernel_info.h"
>  
>  #ifdef CONFIG_X86_64
>  OUTPUT_ARCH(i386:x86-64)
> @@ -27,6 +28,11 @@ SECTIONS
>  		HEAD_TEXT
>  		_ehead = . ;
>  	}
> +	.rodata.kernel_info KERNEL_INFO_OFFSET : {
> +		*(.rodata.kernel_info)
> +	}
> +	ASSERT(ABSOLUTE(kernel_info) == KERNEL_INFO_OFFSET, "kernel_info at bad address!")
> +
>  	.rodata..compressed : {
>  		*(.rodata..compressed)
>  	}
> 

