Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B896394352
	for <lists+linux-kernel@lfdr.de>; Fri, 28 May 2021 15:18:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235974AbhE1NTg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 May 2021 09:19:36 -0400
Received: from mx0b-0064b401.pphosted.com ([205.220.178.238]:61544 "EHLO
        mx0b-0064b401.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233711AbhE1NTe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 May 2021 09:19:34 -0400
Received: from pps.filterd (m0250811.ppops.net [127.0.0.1])
        by mx0a-0064b401.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 14SDA6li012756;
        Fri, 28 May 2021 13:17:29 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2175.outbound.protection.outlook.com [104.47.55.175])
        by mx0a-0064b401.pphosted.com with ESMTP id 38thqe8pbn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 28 May 2021 13:17:29 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oW23k8rewqMbJ1poOfUnGIfSCfxiPdBe/VzsVzvl2YAUwQRQMFyv3feHXCGpcHGAIq6CVrQevDezfWUDPxpnN5XO/JE5YYdeGOR1iZphdSimqSjm3YI7b1tzMS1wF3TN60kM4VEfJtQgRY08fLb0Zv5EELcKMWlbN9WJIj693/bnNXnR1CMmgeoHB6Lmy1lm08hV4AimApdKYkWRIgZV3FOmQ+HkYfvHTbovQBmUKHL6C8uOYHCzCyCNKSXJVgwalWsV3nghGelf+qurJggIWTTOxFko8270PzFJCUK744ianG4APKTpriDFdCqfCBrAh1auIbawPkXRqb2b8aN2Pg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SnQiGXDaFEdNrHwld5Hj/HAUaMS9N2bo/2ySeRm6C1c=;
 b=Juruf7tGhz4ER4X4F20XoKvTkeNgsV7kP9MYLTEmrgkyu4cTO5573LeSGPga3SpzMwNO1MZjPIpT0pS65Dx4qfKVJm34je6dHnSxBDy2GGwb/2VfFN6ItSobPaCnnS+UWFcp4aXTx9EfaTW5lhypgS+vSGoxE4pOVh279fnPzaX907PqVWlUrX/1poOU8N3IVU4QiLYrH3ij52Hxt2k6ks4fzTFCCH2fE6Q6OWVZnlcACF86EckJXPnkGA/E2UgsRYM1EGUDyeOpO3NzWKwNL/k/boDRS7fzXZsaeFZbNZsjqK/Gg+/bdoeZ9dhOE9C6MzhC8eUIswQdZYXU+G0M7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=windriversystems.onmicrosoft.com;
 s=selector2-windriversystems-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SnQiGXDaFEdNrHwld5Hj/HAUaMS9N2bo/2ySeRm6C1c=;
 b=YxeztlWn33GrabTaVRUZRFlyuSNOvKKq6wmltPUuH2ymSwgONPmL7oqhsFlBomfHOx6Prl1RxU4Ivm3hgDfja+fQJsODh5PGAyupv5iI+MjBMWeT1DJnUaRs4QnPW7Chnv+RwVh5smnw7ZA86AuOS5OGO0tkY1yXgeN7+xw5DPI=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none
 header.from=windriver.com;
Received: from BY5PR11MB4241.namprd11.prod.outlook.com (2603:10b6:a03:1ca::13)
 by BY5PR11MB3976.namprd11.prod.outlook.com (2603:10b6:a03:187::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.24; Fri, 28 May
 2021 13:17:26 +0000
Received: from BY5PR11MB4241.namprd11.prod.outlook.com
 ([fe80::34b3:17c2:b1ad:286c]) by BY5PR11MB4241.namprd11.prod.outlook.com
 ([fe80::34b3:17c2:b1ad:286c%5]) with mapi id 15.20.4173.026; Fri, 28 May 2021
 13:17:26 +0000
Subject: Re: [PATCH v2 5/6] ARM: use "* SZ_1M" rather than "<< 20"
To:     "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
Cc:     rppt@kernel.org, ardb@kernel.org, linus.walleij@linaro.org,
        akpm@linux-foundation.org, carver4lio@163.com,
        tiantao6@hisilicon.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <20210518120633.GW12395@shell.armlinux.org.uk>
 <E1lmZT6-0005U2-8e@rmk-PC.armlinux.org.uk>
From:   "Xu, Yanfei" <yanfei.xu@windriver.com>
Message-ID: <c14e1ed0-a337-f7aa-eb46-7286faf3a586@windriver.com>
Date:   Fri, 28 May 2021 21:17:17 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <E1lmZT6-0005U2-8e@rmk-PC.armlinux.org.uk>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [60.247.85.82]
X-ClientProxiedBy: HK2PR04CA0072.apcprd04.prod.outlook.com
 (2603:1096:202:15::16) To BY5PR11MB4241.namprd11.prod.outlook.com
 (2603:10b6:a03:1ca::13)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [128.224.162.160] (60.247.85.82) by HK2PR04CA0072.apcprd04.prod.outlook.com (2603:1096:202:15::16) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.20 via Frontend Transport; Fri, 28 May 2021 13:17:23 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d97c658f-6275-4a20-f2a8-08d921daefcf
X-MS-TrafficTypeDiagnostic: BY5PR11MB3976:
X-Microsoft-Antispam-PRVS: <BY5PR11MB3976D610BAA35B0FC465620BE4229@BY5PR11MB3976.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:626;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: s+bb7/hr4OxYuYOxD1S0fBsPiuwjg9e7fVAGcb9VNDVLFYL3Azc2nqzpWCqYJSJXks2zg4p5n6+W5Sck2BRnV+s6diOwI1E0saWekjksNyrU1yt6Df7V6C5L/8gLw9ZdQB06lPMxB9dOEwMZ99Ufn+vCXKp+L+RwiHGKuEsZGhnuE13rI2khDUisqIg7HaMWgasYs0cxDssgctjiPYoEB3a03Ml0Kgjg6d4OS2oS3N/WLBZO75j5hJe2q8cneZdOp4w6H4ztE3vjKG7GPc9q1COt4ld7WMKQGIxo70PFsCFTm4jXMFlCQ3e8tIaje4xD1ZNgh2n2WcNchaZiTIFLNEjzRQdC3V/MtLDHRnMJtf6Rr2n/pEP49qwX9ZDI+pgChNuMn+Ls/Su0tPBMwp8zx5919jVEunyMseCzoNEMM5j7fWTRa+n9y5166XCTUgrq0CoxShgJX4o/bXvoDlONwgUdeDFbA+QDDIrU+Q6uwxEJeFXA04i5h7EJLaBD64+Nqn8VLv3TEwI89/XEUqK79Gi5/Lv2eBT9Sub9KJ1Wg+FX64f3VxDS/UOaPd50J5vEH2fINPdTuaDMSmJJEGDIz+RUq+UO27bEd4Wa/cbZTDs+uG5OEcNaxCK9C3qD0ULZsetOfOMBp9N2jgOESnKWzgBqX0qb9x+ZrOQ0qbUy+O8JBh5JY74FL73FjRXBkP+kgCyLvfW0vZgK3butL/thqPyzvaBKp6FEj2vbl/lwO4E=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR11MB4241.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(39840400004)(376002)(346002)(366004)(136003)(6666004)(16526019)(186003)(4326008)(956004)(2616005)(66556008)(478600001)(16576012)(66476007)(6486002)(66946007)(316002)(8676002)(4744005)(31686004)(5660300002)(53546011)(52116002)(2906002)(8936002)(6706004)(31696002)(38100700002)(38350700002)(36756003)(26005)(86362001)(78286007)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?UmZqV0dRaS9UeGg0emt4bURvK3F5cVdBOGFDdlVYSTRwQmlKTlJTWFN4MlNu?=
 =?utf-8?B?R0pKNXRlVm00c24xbUlTVVZmOHV3U1VXQ3Q2SVoxdkhoVHNGQlVZdmdrd2lG?=
 =?utf-8?B?Um9nQ25RRVJ1amlBd2svWjc5SGNaUDBFNzBmN2FreFo3MkpMVzY2cXdYWkE4?=
 =?utf-8?B?ajhuT2hFWHViUUpibmhwb0d0RkVtV040NUw1VFYxbnRNNEtxdEk1TVdqUUlj?=
 =?utf-8?B?MEdNSXlGTEsxaVBKbDdFRnBCK3dZSE0ydjgvZmU3cTFMdW5GZjJkOGNsRnNw?=
 =?utf-8?B?OTg0bHhOWjk5WDhuREpiczNjMHlDM3Evd1d3cWdoRFcrQ0pvV1RObHo3dU53?=
 =?utf-8?B?RExBSUI4TEVOY3pvVEQvSHpHdGVCV2VrZ2w0cFBFYktONWhTR0VpMXVTTHUy?=
 =?utf-8?B?aCs0bVZKMndjQ3UvdlB4ZldweTVONXVndEhPVTFFcG93RG5UcXp4VXZLdUxq?=
 =?utf-8?B?aG5LSUxVT0ZXYjVHSmc1K3dSeFZyaU4wK0IrOUE4ajA1SWVPK20rdlhVTy9n?=
 =?utf-8?B?enYvVDFnZ1U3enYxelJSMHBmRXpmUm50L3k4d0JUbnpRTXVORmZaR3lPczM5?=
 =?utf-8?B?SnNEUE1HQm5XN1JtQmlaR3g3OUxTUStVZTdmVXp3bTNpRG9aRDk2L3lGZU5D?=
 =?utf-8?B?ZCtLNEllM2FsYWNYcCtkL1lxeG5MWTBtY0ZQbWNVVS9rSnk2VWgrQzNsZEhw?=
 =?utf-8?B?dkFIckhWaWhFRkFuWlJaQkhYZlcyRFJJZW1MSnRQYUlnYStkaFQ5WjBEYWdE?=
 =?utf-8?B?Zm01Q3VrNnRwdDVqaklQNnR5bEhLSUpQRjNQVmw5YXlCMTFJdEMyVkJXRS8w?=
 =?utf-8?B?bDdXRjI2Qlh4UERlNzNJbDZ3S2hNMWJ5L3ZEbFk5VVlRZm9SY3N1TWFEbVo0?=
 =?utf-8?B?UUFMck5LS1VyZE52a2lJR2pveDhxSFY3TDMxUVVuUFF2c2xqajZuL2xFRHdt?=
 =?utf-8?B?cnJxZzdYWGxscWZzSjEyeE1sS3NaNVJqVkh4SlNtT0JSUU9abWhnalMzWWNR?=
 =?utf-8?B?K2E5Qmk3Snd1ZmRGbHJhTytaN0t1c0s5ckthR1lWdkM4UGU1d0l2Sm1JeGoz?=
 =?utf-8?B?eTRyT29OWHJ5Ynd2QjlHTEJvQ1o5bXRnZGdxc0JCSGRnME9KWVFxK2dqNVhU?=
 =?utf-8?B?elg1WmtWVXd1OHkzNkdxSjBSRWszUnlaK0ZGRmFRMnVTSUFIWWJ0NnQ0UTZs?=
 =?utf-8?B?Qm45d0NlVzBxaWZobkRIRnZ5aVhlSWY1VGR6YW9RU2pzNXJqTHdNVU54Y0w2?=
 =?utf-8?B?c2FQdm1RYkZ4REpMMTVnRXg2VVZtSWNwa2ZScnBtQVB0MzNocU9ucGVGajV3?=
 =?utf-8?B?TWpZV3dMUGdDc0gwRW8rMlV5cFU5RlEvQk4yKzdFb1RQQnpXUC83cmN0ekJV?=
 =?utf-8?B?SWFqeEUyM3lPaDFPWE4rQVJBY2g5ekZ0eGJqZ3VIb3JpQS9kcWROVnRQRHRO?=
 =?utf-8?B?ZmpIenB3NTZVU1BKNGpmV29YV2FMck5lalpmcG85UnRFbXNBWnJPN21NWlR5?=
 =?utf-8?B?WGE1VWJPTTl6RHpOUzVDSC9ZZ201VnQzUHJxNTJYOWwrSXMvMktuRlNSMndD?=
 =?utf-8?B?dGtLd1R2N2dnNHNzVkpRUWEwVWhZS2lhZXRIZUU3MUhOanhOeFBHb0dHWG5G?=
 =?utf-8?B?aDBzQVM3a0pUc2lVK2lJVXlENDhEa2RiVDdnelp0THJJemJpSytET2dnZmEw?=
 =?utf-8?B?a1JtQnJhWjlXYnRWQStobUFYdVNCM1ZzamtWMEZFVVBWRi85WXFwbjY4eVMy?=
 =?utf-8?Q?XIUzZD9qlHlwfZu/DGy+3VHvNcnj9BfPLvqIaZk?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d97c658f-6275-4a20-f2a8-08d921daefcf
X-MS-Exchange-CrossTenant-AuthSource: BY5PR11MB4241.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2021 13:17:26.0884
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MOcJDtOEOMLNpgyvSIvZtkXzyRchiZ2Fi9h2pLmFS++/QN7sKYfqwOrYNco9X/ezb4GFkK9V8L8xRXDkhZrJzw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR11MB3976
X-Proofpoint-GUID: QBFBYoejWQn0v2hdgZYBNEusoeRJcjXO
X-Proofpoint-ORIG-GUID: QBFBYoejWQn0v2hdgZYBNEusoeRJcjXO
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-05-28_04:2021-05-27,2021-05-28 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 suspectscore=0 lowpriorityscore=0 adultscore=0 mlxlogscore=732
 phishscore=0 mlxscore=0 impostorscore=0 malwarescore=0 bulkscore=0
 clxscore=1015 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2105280088
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5/28/21 6:11 PM, Russell King (Oracle) wrote:
> Make the default vmalloc size clearer by using a more natural
> multiplication by SZ_1M rather than a shift left by 20 bits.
> 
> Signed-off-by: Russell King (Oracle)<rmk+kernel@armlinux.org.uk>

Reviewed-by: Yanfei Xu <yanfei.xu@windriver.com>

Regards,
Yanfei

> ---
