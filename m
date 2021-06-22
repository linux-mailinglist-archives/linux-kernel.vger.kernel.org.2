Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D99253AFDAD
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jun 2021 09:14:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230072AbhFVHQy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Jun 2021 03:16:54 -0400
Received: from mx0a-0064b401.pphosted.com ([205.220.166.238]:13736 "EHLO
        mx0a-0064b401.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229490AbhFVHQx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jun 2021 03:16:53 -0400
Received: from pps.filterd (m0250809.ppops.net [127.0.0.1])
        by mx0a-0064b401.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 15M7DAuc024574;
        Tue, 22 Jun 2021 00:14:23 -0700
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2105.outbound.protection.outlook.com [104.47.70.105])
        by mx0a-0064b401.pphosted.com with ESMTP id 39b47h86tb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 22 Jun 2021 00:14:23 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Q1/wGO8STeQ7ahSeiGRytB9ZAfK0z48nhsBrMtwxlGMh2xKXPFQ2o39IhRcOP5yq8CVkY2UzlbVeK5P6zpyXd8ZvuFBpKfThbsHdsFWVhcKoXGckXjXJu3TsJcT1vNl6IFsZts5ffAuqbsJ7ZsC1xWaN93tDyr8SwAGNSbxeTH2JJWRzA5Y7bgwWsNSJbO6Amho/b+/4fPJKTL0hjMQunHEa098D0MVC1DwZ88r1Rzp5xCniRl5vit1VrWXPnew7F+yoYOaojP1rsh8ekDK2uom1wMIrI6mnlBt6pDWr/Kl8kR21+wRs9WZfQKz29utIcqtM9BneePrE1YaxovPnyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wnyiOUTN27qCLp1aUm8KLk/Lt0Lbl+f50lhM7gkMFvk=;
 b=FjWJu+Rj3UP0tWyE9821o7Z99X8dUDiJVUkJJRXSAxxndi3tAmoJMyPSOpMeIZfb+VASj1cXbHbWVrioF4Bst/BGjVUqPxWIVToOp7LVDFeu6tY0SmuPsNoOB0sXv6CF5Hzc0/HrHji9bCz2zfBluMXYwWKmF3CqJADQn/0jd90nkmkpaY/hL7kWVH91iAx8qbe3oCdFXOseVI6F3QgkoR/0CmoJYGul5AOvHkQjijO9sUx1y/f2XSxynq+dRf1We8MgFrPxtaF15YdsQoAXwG8XZVY0KY/1rf5g6QmOdjqadtB9vq1bXG7RRK06ick1wJL/33mF1PoacfUddrsiPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=windriversystems.onmicrosoft.com;
 s=selector2-windriversystems-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wnyiOUTN27qCLp1aUm8KLk/Lt0Lbl+f50lhM7gkMFvk=;
 b=NqS69aBaFYEwgDbygL23SHzT68su4w3unMzFhY2scmFofLrVaJwYsqcXomQN0qujZhvtBXHkv66IRfMy7aGLTJr+ACBVcn+Pp25rW0ACAmtaN71IGsv/NbqnZqarJamrfVHL89N8Q/8Edg/9V3TsEQcpu/anmQePbj3V7veMAgA=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none
 header.from=windriver.com;
Received: from CY4PR11MB0071.namprd11.prod.outlook.com (2603:10b6:910:7a::30)
 by CY4PR11MB1830.namprd11.prod.outlook.com (2603:10b6:903:125::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.21; Tue, 22 Jun
 2021 07:14:19 +0000
Received: from CY4PR11MB0071.namprd11.prod.outlook.com
 ([fe80::40e4:b9:53a1:de74]) by CY4PR11MB0071.namprd11.prod.outlook.com
 ([fe80::40e4:b9:53a1:de74%6]) with mapi id 15.20.4242.023; Tue, 22 Jun 2021
 07:14:19 +0000
Subject: Re: [PATCH v2] clk: zynqmp: fix compile testing without
 ZYNQMP_FIRMWARE
To:     Michal Simek <michal.simek@xilinx.com>,
        linux-kernel@vger.kernel.org, monstr@monstr.eu, git@xilinx.com
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Michael Turquette <mturquette@baylibre.com>,
        Punit Agrawal <punit1.agrawal@toshiba.co.jp>,
        Stephen Boyd <sboyd@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org
References: <fdee3a286defb103aa07b5493b805d1987885165.1624281224.git.michal.simek@xilinx.com>
From:   "quanyang.wang" <quanyang.wang@windriver.com>
Message-ID: <81e67a24-0076-cbbb-4af4-04dc9f3edfc9@windriver.com>
Date:   Tue, 22 Jun 2021 15:12:46 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
In-Reply-To: <fdee3a286defb103aa07b5493b805d1987885165.1624281224.git.michal.simek@xilinx.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [60.247.85.82]
X-ClientProxiedBy: HKAPR03CA0020.apcprd03.prod.outlook.com
 (2603:1096:203:c9::7) To CY4PR11MB0071.namprd11.prod.outlook.com
 (2603:10b6:910:7a::30)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [128.224.162.199] (60.247.85.82) by HKAPR03CA0020.apcprd03.prod.outlook.com (2603:1096:203:c9::7) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4264.7 via Frontend Transport; Tue, 22 Jun 2021 07:14:14 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 73eef260-eaf5-42a8-6f31-08d9354d5920
X-MS-TrafficTypeDiagnostic: CY4PR11MB1830:
X-Microsoft-Antispam-PRVS: <CY4PR11MB1830A5F754DC7370A1615652F0099@CY4PR11MB1830.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1169;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dR7tXDMsjHg9Y7oTj1zyfj2UQJtEuuPxfFdYhsil1W2/WYTiWm00ZE7kwU4f5IpCJPNdQ7hozcjQ4lhSi7ydFC6zUH8JOrnJwDuv9bOWNB6Fpi1K6tfKMOwOjayxpYdUZBMqMpVM0yTLBzV+NS25speKPx9zSv2keShos7xBlD18HE2hLgz1OGOZpRo+e0UZN/QFrFNb+3DtS3Rmbr3qvMa4v+BIubL1qa7vWMyp0ZGT+qU6V9GJNiMqKPDY38f7c9tmZyXo0fI/zC11kQbLC5PFRRNR1PmyfckQmaifzZj7kcMAtPyzjIySXPW6wKGUcI2GgqNGW/QPt5yklcZUdnUzyVgXYl+XITY4su7IKAgOvOdwx+fUVcxPLtWOYmfxb4EYRHjG0bbvlQuD2PBCMVTW9a/JzOw0vMbDq6w787eFW/ZL3dZkLHfYr8hP/+qW5Nu0P9pQacxuuJr6836f0cf1Tq4A0aOFThNwTopYfF3a3E0u1KjoPxIVAyQwmyLyLD0GHfpXTKjXaOu0wz4NXCTiELkbKCllvJSxBaiPbiXWLko+6meU2L4exRS6i589anC3r196AHOxZpnxDdcfFxxj/GYDVTmRJmCmdA4FCVkW0jgQwhkRRct7DslorxgVJIAybnbCy2KDjZDJCAM67KMXHBawVlayp8yff4WBCW4VT8DQ/+XcWKPddjkyXCWSJYDcpDrpWNgPt6Al4a7VPQ4N+fyfOm0e5O6VmJNzVO9NAE6F1pYRjBmgc9FiBvSa9m/DaX6XuvIX96JbDH8ZONkSZs9Y8A/mqfqYIaWqA/PyofwadxI2QWfmaCt3sIRlMZtD1aOPAHe33urJ6E/cdZhaX1JHNuFS1IobM4Sk0Q4=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR11MB0071.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(346002)(136003)(39850400004)(366004)(396003)(6486002)(83380400001)(186003)(66946007)(26005)(38350700002)(16526019)(478600001)(7416002)(38100700002)(36756003)(86362001)(8676002)(956004)(4326008)(2616005)(66476007)(16576012)(66556008)(52116002)(6666004)(5660300002)(54906003)(966005)(8936002)(31686004)(31696002)(6706004)(53546011)(316002)(2906002)(78286007)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dG5RMEQ3UklraUZpTm5VbTN2OFJ4WEFSTTIwaUI5Z0lRU1pBVkQrcDhRVFFj?=
 =?utf-8?B?SkYrZGFOd2JBVVpBSW02UDBPa0w3ck9kL2VtRCt5TW5hcnNaTmp4VWZzQjlt?=
 =?utf-8?B?WWRaZlFNcVZjZ1IwZzh1TERQeU1aWFVQQ1AzZWZEeE9HNmM2dWNVN0Y5QWFX?=
 =?utf-8?B?MzhHY1YyZms5VFFOajNDRVNlcVRLRURRQjNDTUs1cm9sUm5pdzlnZjh1SkJK?=
 =?utf-8?B?T01XTWQwUVZSb01rSFZBK0JXOFpOQy9DVW1nR2xvZnFObHRjOCtwSlptZExh?=
 =?utf-8?B?c2ZvMzZrOVFWZkZtUUV5cTFrUGxrS3c3ZFRlYnlnby9QREZLYlVQb0RBQVlQ?=
 =?utf-8?B?RXUxWG9xL2VpZVN6THkveWgvY0ozYmYvYXMycHRKTXc5UzQ0S0FQTzBqVnl6?=
 =?utf-8?B?eEtZZzNYZm1GVEZVN016b0hOdGFzRjRJaGxQWURzSm5adTFYbHRkeVEzWmQv?=
 =?utf-8?B?Z3g5d1gvM2dwSW4vRks1MHNqaHlQb0xIalFaNzNMYmRKbkxFd21VRkZmMWtU?=
 =?utf-8?B?OC9vSElLNnBTb3ArbXAwcHp0TW1JQzc1VW1LOHpvc1ZtWFJXS29PQ2RlY29o?=
 =?utf-8?B?K3lWcTVDM3hmdGQwT05HU095dFFNVE8wQWEzSXlyWlRXVXh3NTZSQXRwcE5O?=
 =?utf-8?B?VkgxMWFUazQzczdOcVBRdEdSMmI0U0JvWGVZdUhiM2FjQ0VxU2J5TWJjL3ky?=
 =?utf-8?B?dVJUaFFFK2pWNHFmb0kwanNYZW9LVUFVcUN5R1FkUnp4ZWRhNzRDRmtqUWNa?=
 =?utf-8?B?TDdzYXdBck92aVZUaFVHMHdpREdKbkFhUllrOXFSOVN6dEJhUnNkQUJBR09s?=
 =?utf-8?B?Z0s1WG9BdUkxcm1ZRjNiQTlaTlNLaGVzTlh0Ymp0dDVUNDloRlZpbElZdmxI?=
 =?utf-8?B?NjgzR1ZRSkVZNmpWUVVYMmh2M1lsUytrOXRBTzIxZUVoOTNBZ0Y1RDg1VWgw?=
 =?utf-8?B?UGY4T01vL3RqdHJDcVMxNS9VR0RDekVEVXI4MElkZnpzMFVQQ2lyV2RncEM5?=
 =?utf-8?B?ZGhkdnUyNHUwd3UxNU1oQmRWUWl0UDUyb3FmUXcvVTB2SFA3RG9Hb3pIVWZX?=
 =?utf-8?B?blkzdmpCdDdDQnQ4NFREalNxaGpxWkJGcEliTnNQL3FQOVZ2TEVxMlFxZkFy?=
 =?utf-8?B?eDhiSEltbDgycWxJQzNuNVZDSXhEWG1VSnlvalYwTDFDMklBczR4M29KTmFy?=
 =?utf-8?B?VjBQNjBpZXhhL1JDSThreHIyalBBS3hwNk8rZ2M2bHl5OGcrQ0NhNGdqQ05S?=
 =?utf-8?B?MERrbnBZR3UrV1JJTExaZlJBNmFvOVY4cWVxUnJpWnB5TGpsMmQzdHdaczEv?=
 =?utf-8?B?T1ZUdjdGTUx4b0VicEZIQTNXRlJnNUcweVFqR2VUYm5DVy9nN3BFR3hKVnZQ?=
 =?utf-8?B?VEJJMk9JSkRRcjR3aTBhdXZmWGN5THJDQjdpSjU4TmtvcUo3MXZhUG9rVWhD?=
 =?utf-8?B?YnV2U0JwZ0JjODdlT0g0ZVJycjJSZ20rd0lNRlVvaXdQRVpyZ1hCTDlVMjB6?=
 =?utf-8?B?YXYxWjZuWWF5U3cwdENOZXl3RE1PKzRVdjJiR2hwNEgvamQ1d01JZGhFZVVu?=
 =?utf-8?B?NlhJelR3VkQ2cVNybFF4WU9rODZCbUJtYld6UUpTeHliZ2x6RnRYK3pNdGo1?=
 =?utf-8?B?Ui9sTW5zVHZRNWVZRnpHRkpQTjlPckczWEFIS1BJOWVjQXZxcnVKMm1NNnRV?=
 =?utf-8?B?cjVlbzQ1NmRrTWRwc0tOdEJ0SkhreWdmSElkRjRkUUR6Q2NmNEtLVFUrdUY0?=
 =?utf-8?Q?LCGVMBwr3+jrBBz/RPA2m8l9VNsBFKr3no9meEU?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 73eef260-eaf5-42a8-6f31-08d9354d5920
X-MS-Exchange-CrossTenant-AuthSource: CY4PR11MB0071.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jun 2021 07:14:19.3905
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mYKJgrTiuE8iuJvTflqo6NJsgoWb0tUiI7GE2jiMUNN45UGpXHcoWdbj6HF8Z4JqT2e/EL78O5PVTs9StA5tBiplSl5smptq99wLqPvI1v8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR11MB1830
X-Proofpoint-GUID: 6rr7es3CinAuO4qJI3-18h39PgFemc4P
X-Proofpoint-ORIG-GUID: 6rr7es3CinAuO4qJI3-18h39PgFemc4P
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-06-22_04:2021-06-21,2021-06-22 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0
 priorityscore=1501 bulkscore=0 mlxscore=0 suspectscore=0 adultscore=0
 impostorscore=0 spamscore=0 mlxlogscore=999 clxscore=1011 malwarescore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2106220045
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Michal & Arnd,

On 6/21/21 9:13 PM, Michal Simek wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> When the firmware code is disabled, the incomplete error handling
> in the clk driver causes compile-time warnings:
> 
> drivers/clk/zynqmp/pll.c: In function 'zynqmp_pll_recalc_rate':
> drivers/clk/zynqmp/pll.c:147:29: error: 'fbdiv' is used uninitialized [-Werror=uninitialized]
>    147 |         rate =  parent_rate * fbdiv;
>        |                 ~~~~~~~~~~~~^~~~~~~
> In function 'zynqmp_pll_get_mode',
>      inlined from 'zynqmp_pll_recalc_rate' at drivers/clk/zynqmp/pll.c:148:6:
> drivers/clk/zynqmp/pll.c:61:27: error: 'ret_payload' is used uninitialized [-Werror=uninitialized]
>     61 |         return ret_payload[1];
>        |                ~~~~~~~~~~~^~~
> drivers/clk/zynqmp/pll.c: In function 'zynqmp_pll_recalc_rate':
> drivers/clk/zynqmp/pll.c:53:13: note: 'ret_payload' declared here
>     53 |         u32 ret_payload[PAYLOAD_ARG_CNT];
>        |             ^~~~~~~~~~~
> drivers/clk/zynqmp/clk-mux-zynqmp.c: In function 'zynqmp_clk_mux_get_parent':
> drivers/clk/zynqmp/clk-mux-zynqmp.c:57:16: error: 'val' is used uninitialized [-Werror=uninitialized]
>     57 |         return val;
>        |                ^~~
> 
> As it was apparently intentional to support this for compile testing
> purposes, change the code to have just enough error handling for the
> compiler to not notice the remaining bugs.
> 
> Fixes: 21f237534661 ("clk: zynqmp: Drop dependency on ARCH_ZYNQMP")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> Signed-off-by: Michal Simek <michal.simek@xilinx.com>
> ---
> 
> Changes in v2:
> Based on discussion here
> Link: https://lore.kernel.org/r/20210421134844.3297838-1-arnd@kernel.org
> I have updated error return value which I got from clock core based on
> error cases.
> 
> zynqmp_clk_mux_get_parent() should return num_parents() as error defined in
> clk_core_get_parent_by_index() where num_parents is incorrect index.
> 
> Extend zynqmp_pll_get_mode() with PLL_MODE_ERROR to handle error case.
> 
> zynqmp_pll_recalc_rate() returns 0 because __clk_core_init() consider 0 as
> default rate. But maybe -1ul which was used by Arnd is also good option.
> 
> ---
>   drivers/clk/zynqmp/clk-mux-zynqmp.c | 10 ++++++++--
>   drivers/clk/zynqmp/pll.c            | 15 ++++++++++-----
>   2 files changed, 18 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/clk/zynqmp/clk-mux-zynqmp.c b/drivers/clk/zynqmp/clk-mux-zynqmp.c
> index 06194149be83..d576c900dee0 100644
> --- a/drivers/clk/zynqmp/clk-mux-zynqmp.c
> +++ b/drivers/clk/zynqmp/clk-mux-zynqmp.c
> @@ -38,7 +38,7 @@ struct zynqmp_clk_mux {
>    * zynqmp_clk_mux_get_parent() - Get parent of clock
>    * @hw:		handle between common and hardware-specific interfaces
>    *
> - * Return: Parent index
> + * Return: Parent index on success or number of parents in case of error
>    */
>   static u8 zynqmp_clk_mux_get_parent(struct clk_hw *hw)
>   {
> @@ -50,9 +50,15 @@ static u8 zynqmp_clk_mux_get_parent(struct clk_hw *hw)
>   
>   	ret = zynqmp_pm_clock_getparent(clk_id, &val);
>   
> -	if (ret)
> +	if (ret) {
>   		pr_warn_once("%s() getparent failed for clock: %s, ret = %d\n",
>   			     __func__, clk_name, ret);
> +		/*
> +		 * clk_core_get_parent_by_index() takes num_parents as incorrect
> +		 * index which is exactly what I want to return here
> +		 */
> +		return clk_hw_get_num_parents(hw);
> +	}
>   
>   	return val;
>   }
> diff --git a/drivers/clk/zynqmp/pll.c b/drivers/clk/zynqmp/pll.c
> index abe6afbf3407..3fe4d21227d0 100644
> --- a/drivers/clk/zynqmp/pll.c
> +++ b/drivers/clk/zynqmp/pll.c
> @@ -31,8 +31,9 @@ struct zynqmp_pll {
>   #define PS_PLL_VCO_MAX 3000000000UL
>   
>   enum pll_mode {
> -	PLL_MODE_INT,
> -	PLL_MODE_FRAC,
> +	PLL_MODE_INT = 0,
> +	PLL_MODE_FRAC = 1,
> +	PLL_MODE_ERROR = 2,
>   };
>   
>   #define FRAC_OFFSET 0x8
> @@ -54,9 +55,11 @@ static inline enum pll_mode zynqmp_pll_get_mode(struct clk_hw *hw)
>   	int ret;
>   
>   	ret = zynqmp_pm_get_pll_frac_mode(clk_id, ret_payload);
> -	if (ret)
> +	if (ret) {
>   		pr_warn_once("%s() PLL get frac mode failed for %s, ret = %d\n",
>   			     __func__, clk_name, ret);
> +		return PLL_MODE_ERROR;
> +	}
>   
>   	return ret_payload[1];
>   }
> @@ -126,7 +129,7 @@ static long zynqmp_pll_round_rate(struct clk_hw *hw, unsigned long rate,
>    * @hw:			Handle between common and hardware-specific interfaces
>    * @parent_rate:	Clock frequency of parent clock
>    *
> - * Return: Current clock frequency
> + * Return: Current clock frequency or 0 in case of error
>    */
>   static unsigned long zynqmp_pll_recalc_rate(struct clk_hw *hw,
>   					    unsigned long parent_rate)
> @@ -140,9 +143,11 @@ static unsigned long zynqmp_pll_recalc_rate(struct clk_hw *hw,
>   	int ret;
>   
>   	ret = zynqmp_pm_clock_getdivider(clk_id, &fbdiv);
> -	if (ret)
> +	if (ret) {
>   		pr_warn_once("%s() get divider failed for %s, ret = %d\n",
>   			     __func__, clk_name, ret);
> +		return 0ul;
> +	}
>   
Since zynqmp_pll_get_mode may return err now, maybe here should add a 
condition check for PLL_MODE_ERR:
	if (zynqmp_pll_get_mode(hw) == PLL_MODE_ERR)
		return 0ul;

Thanks,
Quanyang
>   	rate =  parent_rate * fbdiv;
>   	if (zynqmp_pll_get_mode(hw) == PLL_MODE_FRAC) {
> 
