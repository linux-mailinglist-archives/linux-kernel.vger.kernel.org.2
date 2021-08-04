Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9EE7E3E0394
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Aug 2021 16:43:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238313AbhHDOnU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Aug 2021 10:43:20 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:61320 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238191AbhHDOnT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Aug 2021 10:43:19 -0400
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 174EfRMO010227;
        Wed, 4 Aug 2021 14:43:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type :
 content-transfer-encoding : in-reply-to : mime-version; s=corp-2021-07-09;
 bh=qYg8zkd8Xg5bjc/tQVEj6DGlPDxldqbQaX2xp6z8q6U=;
 b=YZNA5Rcid+pZvOt4HYvsQWpYtxZ9yjpl22TkkgCFLOv4mEUwXyr06wiqXfFA5e0IxaZ7
 vKdoNkitYuMywbLS1kOP6LWwnauuDFHiXXYh8GT63Z39T3xkDLAEKKich2qBaY9YswrO
 Kxgc+vWv1rmi/YPmGFgbthCFWzCU4wv4kfhEyK1hWeD2mm3r1m0MkFcw36SOb/abDUsW
 ZsyVoCDCCPPOTfG56HH8FLV7Qs3SaafbYzVrLz7k1FW4At1WN2kzfwzaJhM7wjYSp6A4
 JupgTWOCq5ArBMj/g3ieDDMVCZVIrVCKR/y0Mt7Ob7MbBd3QXSPnpx7wyqc18iL4MEi5 hQ== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type :
 content-transfer-encoding : in-reply-to : mime-version; s=corp-2020-01-29;
 bh=qYg8zkd8Xg5bjc/tQVEj6DGlPDxldqbQaX2xp6z8q6U=;
 b=W1R3ObTx8jiQfl/G7N5rsNQ9D5Zy6PQes2mU1C7cSgKCzYqzks8Hi+Nm8FIs3nDpPGTo
 AQuYv23/VmpVwWYViDFDOZ1sG6tymYxt0OUzRutwIkvXYfjliJgkbhrynl0tYyYmao45
 YIKTGL3Ubothlux8AJdagxfz1auNtt7pIpIQOxFthsU65Ynci+4iHYzUoKrqK33MIxUv
 sGPdbwJZTQtfhJEOiCrdPF5Oh22CQmAK2vMzmIMJMTf+Xx1CcN6BsRHJWVlm/P0Ih+uj
 hv4qDUtEg2jMxqNx3JU7s+IMX42M+ixVtK77/oOeIkFnQFd6yQGj/Da48KejdwWNqJ9q zQ== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3a6fxhe5v1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 04 Aug 2021 14:43:02 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 174Ee1Wx076259;
        Wed, 4 Aug 2021 14:43:01 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2101.outbound.protection.outlook.com [104.47.58.101])
        by aserp3020.oracle.com with ESMTP id 3a7r47xjsm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 04 Aug 2021 14:43:01 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XuogZwvmwQZQdpQ5rHCfif6GhhmLoOVi7q1R7tU28/yJLVRb43jBunadGbqHTCk6+LNC9XffUf7DCI/eTnggbT2lthus6ER6uBa9sZZ9qY4RiI7fqJhId14tm4fLBH4yT+tHhkgS7ndj8qcBY1/gSAN90erZ0D00VtXNbkHLnSuxzZhrylZDGTKoksbx7tkXi+IkSiJbrXSYjwCstR0n9RNUO5WE8e+6tad0OOfaF3YnwJG4t98mub0uGkdZVPWrVgfHQaX1GcudHx1ywy5l0EY2/4HxXOimBPH3ALU8spqiy0CtLhuBTWlxlr+/LSqdXYF8gSyFcPmAg1odZUey3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qYg8zkd8Xg5bjc/tQVEj6DGlPDxldqbQaX2xp6z8q6U=;
 b=cvkeK1sjEyjI/xA4tpDY/VUap3b3qUPEyzSW2Z98ccFhvU1O68x7hrhnyvsa/3aCtUzTTkL4pJw9ZCp4/358OnwCFryC8lx6PJH7bQTbqaZCdufLbrMEOQnmp0+AuFTw0KQvlpdcasEXrLEDL8RMuSWNp8eBz/FvUPcT1NxmriNfa0NXccZWggGU8/FlD/wLFWyWLlOTyYPTHBTVUT5A5ki2KjTChEav7kSn2Hn7gbuf9cEdDj+rWKCsUum9LRdgAcuGdIFcjzJlRY6mzKuKSbP03hbXTzNaGKL8U+JhNoDYLef/qIxJ/r4FE6GZttyTdFldQP8J86AJ/RrFCLEbGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qYg8zkd8Xg5bjc/tQVEj6DGlPDxldqbQaX2xp6z8q6U=;
 b=quMiWxSg84/CNEvXsVz0Nntfl6jxI0N9D0Th6+bGBope1/MlC8zG2s8EJ51tbXenr2xoY/HA+4MuoEUT6oIagTWF4J7/CD8s9slhbi68gwjKmL0HoeHM7jBRGqbmOafNIDzluLhdzVbV8fzCjRrUINbCqfLgqQZmIrH90Re8Xbw=
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=oracle.com;
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by CO6PR10MB5411.namprd10.prod.outlook.com
 (2603:10b6:5:35e::5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4394.15; Wed, 4 Aug
 2021 14:43:00 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::5820:e42b:73d7:4268]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::5820:e42b:73d7:4268%7]) with mapi id 15.20.4373.026; Wed, 4 Aug 2021
 14:43:00 +0000
Date:   Wed, 4 Aug 2021 17:42:41 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Larry Finger <Larry.Finger@lwfinger.net>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] staging: r8188eu: Fix cast between incompatible
 function type
Message-ID: <20210804144241.GN1931@kadam>
References: <20210804143218.13665-1-fmdefrancesco@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210804143218.13665-1-fmdefrancesco@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: JNAP275CA0006.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:4c::11)
 To MWHPR1001MB2365.namprd10.prod.outlook.com (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from kadam (102.222.70.252) by JNAP275CA0006.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:4c::11) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4394.15 via Frontend Transport; Wed, 4 Aug 2021 14:42:55 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 44131b0b-73d9-446f-c634-08d957562830
X-MS-TrafficTypeDiagnostic: CO6PR10MB5411:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CO6PR10MB5411308CF54A8399F31F7A028EF19@CO6PR10MB5411.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1388;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VXdiosPWx/BjhW/rBI/6ANBKFDHhiycqYx1H9m9erCT8zRyruZM4M0YrEMbatAuCHKgnU22fhpQfI8Y0TGIq5xis1w10Mum8ykHv7AhvRdz7WIgqtnVPu1QFaKOn86v00JP9tpOEbPnyRKosevm7eMNJ//F7WYIP7fvJ98yha0CCLtvBopGjULKBCVco+m+ekYr6jmV/jbE4Ixor3ZchKR6HFy659r5GhLM6YzxsuQbC0jiOSHU55JNU2ByBKrNcJzj9UjmkfwyJo+ecKRMx/tAFBSfdjmCg/dG4Ar3gKwBGUnhYPpW62UeYv1YEdSGqJYLf9CIitYBAsXkHTxmzBidQtwOsisKzMkl9zOqeMUfqQioIYrzTRpL3c0ZkkAmU2aH/3p8yfCBUZoUn1Ygz0rMaPDRBJR/mroZP3SmwpbSTe0lZ+kD9z9BVoA6SUuM9R5S97J9Ly2rVnIiQ8rPHnT0RuTDWH63NBGUohwz1ZY4sHI2+rqWl2y8lUqvSBNtDgLFCIwoBLwK3lseaTeTza8EHO6EM/SbubRjtkJ36R6YON4Yw/6GAOxzDBHVEFzDVegrs4NwYKmioQsYvQZ+PdPimUiUU2Y68g/+eUF/wIAc1j6E7BYma2u5Dr6aESxoJBxqcE+fxAoZi6P00IepFzMTMbEvRFA5XatETaIGpU1/jnRVWygCpnBsl7rboCn6+CRBy6NuoTEZ1drRk5nq5IA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(39860400002)(366004)(396003)(376002)(136003)(346002)(8676002)(55016002)(9686003)(38100700002)(54906003)(86362001)(9576002)(33716001)(38350700002)(316002)(478600001)(8936002)(52116002)(186003)(4744005)(4326008)(6666004)(83380400001)(1076003)(5660300002)(44832011)(26005)(6916009)(6496006)(66946007)(66556008)(66476007)(33656002)(2906002)(956004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?b2d1L2pHalRad1BZTzd4RFBzeVFETXUxWnE4bXduUFEzMmh5OFFYWnViZ2VQ?=
 =?utf-8?B?UEVPdGRiWmk0ZGJDVUN3WHFvaTZXcnlqQjcrMTlEYmJZVDF6cFVuaW8wOHh6?=
 =?utf-8?B?ZlEvUW56b3VMQnowOTBHK3BjVXJOK3ptSUc3WFpxb29YY2dtbWo0ejg4WXky?=
 =?utf-8?B?d2xtZngycHh2NmRDWTVDZkRoc3l6SnJwKzkrWjBrMVVpZ0t3MThpdmJSM09m?=
 =?utf-8?B?d0hnb3BNNjlPdThIcEZUbCtBUW1MMzRTY09qNWMzbFU4NUFLRDFpRjdUKzUz?=
 =?utf-8?B?SFVyUnc0YXlZUWUyQ3dlVTNyV1dLZ1l3c3BFSFhYcG5aY1NOM3dtQXdYME1Y?=
 =?utf-8?B?Q1Uzd1M1YTY3bHZvYm5DYTZwVlN4bmFXcC83bXoxa0ZVUno2OGl4NTBQOUUx?=
 =?utf-8?B?dWRlT2l2WDFzazlTWWFxZStlM1YrNktIRklxM3pkUjhqV1FKUUlONDcvZ0Fh?=
 =?utf-8?B?WXAxOER5cnRPTUJ3bDVoM0lhQ0t4ek9tUndDZW1XT3NQSnZCNlVsMjRHQmx6?=
 =?utf-8?B?aitiZk82ZW91OWpQandXd0hOMTBlK3VkU1VUV25YaHlmdGtENi9xeGJyTEk1?=
 =?utf-8?B?RWdJd25VbzNzays1OGl6dHF4YjlKLzhOUitQdzdwcW5hNExZMDhESWhvL3Vx?=
 =?utf-8?B?S3FzNWRLMG81MTlYVWFPZzJqeGI1UWVkb1NnQjV5S1VqN2tJeDN6NnNEdlg1?=
 =?utf-8?B?OHdhcnlicWhWQUp6OTZBSlF5b0FUc20yTjFqUjA2b1hzVHVjR0l0eWY3R0hv?=
 =?utf-8?B?bDlrK0dIY21iYkV4a1NoNEZIckRjTXZVb2U3S0M4WmlOVHZnTWpDQzBPS0NY?=
 =?utf-8?B?eHJtcXd5NzFpbUxCMTJNM0xGNFQ4YnFGQ3p0YjZTRXdYUXh1T1JZK0YzUUNz?=
 =?utf-8?B?ZSt5S1I3ekl5eVNaRUMxbXJ3K1ZCbUVhUlpWTzZ1ZnVqRHczOHVoQWlsOUlv?=
 =?utf-8?B?RHNVUWNHVkhBM0NpYnlnc2lhSzJEL1B5VjVxcUIwMUtFR0hVOUNsQ2pTZjN5?=
 =?utf-8?B?Qk5sYkhvN1NGNmpVNHZNQ2orSWJ5QWV1U012YVpZVFJhNi9aMkNmMGw0VEd4?=
 =?utf-8?B?a1gvcFd5RlhiOVZBeVFvdnUyL1ZLcVc5cFJJb1N0dTQwZjFMV0R0NVFYTFlp?=
 =?utf-8?B?bG1rcFRmTFZzQjdGMnNsUkJJbndJK0dGQTByV3djN2d3TStudjBPMU5CSzFh?=
 =?utf-8?B?aVE1Z3dtNG5ybHhkK256VmxCRi9aOHNyeFlFOXVoNnBITUNyajhSdlpHNkNj?=
 =?utf-8?B?THJkN1lLUXNVRVJNUVZhQmNhakpvQU9VTkJIZ0RWYitIQkpub3ZueHdiWG5p?=
 =?utf-8?B?WVlyN2l4dXpYU1BWZlpqRkZpZFc3dkxjbzIxRTh5cDZDZUY2UmNTTE8vallM?=
 =?utf-8?B?d0Y1c1RvYVpyYmh1MkhjS0d0cDBMSTJWMzRTK0lyOCt3SXpGSHp2a2gvN3lm?=
 =?utf-8?B?K1M5UCtoQVY2TTd3M28zSXpIZTNpdlY2dk90all0VEo3Z2ZNOFVsZittWEg4?=
 =?utf-8?B?V0JVS2tmazRVU2tBaUt1c0xYQTl4QnhRVkpLZ1VrZ0tReHNjbThtYkxZUFdu?=
 =?utf-8?B?V2ZtcUg0SjF2b0VTaVNrczdSSEI0R3REeHZFUGN5cTMzMVVnVjNBazllcWtP?=
 =?utf-8?B?UTJpb3NjV0JSYUl4SlIveEI1ZndnWGJwNm40MXBkMEhRWTJEVjlmejl2RnFw?=
 =?utf-8?B?ODk0RE92VW02ZDRyU1lWTkQ2Sy9nS2pLQlBQQlpndGxOYmZEY1JxT0prUXBT?=
 =?utf-8?Q?TBcLrwghxxQQN4qLy63WItQnOEGlxRZF8bp0uV8?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 44131b0b-73d9-446f-c634-08d957562830
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Aug 2021 14:43:00.4064
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CZ/SX1Y2QSKcypozbxSFfac48/A3CsynrO9EfogEb6LGwM1TmZNCeyRPsmR3kE6Tq8+J5c8/mbMgBKFToiAp/PJ+O8S7movq2t5K1arvxtY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR10MB5411
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10065 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 malwarescore=0 adultscore=0
 suspectscore=0 mlxlogscore=999 phishscore=0 spamscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2107140000
 definitions=main-2108040082
X-Proofpoint-GUID: HNNvIexQcQisF_7VFugUXbkBLLs2b59j
X-Proofpoint-ORIG-GUID: HNNvIexQcQisF_7VFugUXbkBLLs2b59j
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 04, 2021 at 04:32:18PM +0200, Fabio M. De Francesco wrote:
> Fix sparse warnings of casts between incompatible function
> types from ‘void (*)(void *)’ to ‘void (*)(long unsigned int)’
> [-Wcast-function-type].
> 
> Suggested-by: Dan Carpenter <dan.carpenter@oracle.com>
> Signed-off-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>

Thanks!

Reviewed-by: Dan Carpenter <dan.carpenter@oracle.com>

regards,
dan carpenter

