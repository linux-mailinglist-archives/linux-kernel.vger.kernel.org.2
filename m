Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF6D644644D
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Nov 2021 14:42:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232418AbhKENpL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Nov 2021 09:45:11 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:42164 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231933AbhKENpK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Nov 2021 09:45:10 -0400
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1A5CICNC009145;
        Fri, 5 Nov 2021 13:42:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2021-07-09;
 bh=WYWbulgls9JD/oNW4LMHq3ODYfzsS5CP4kDHZT0R0/s=;
 b=TSOv+GDiCWwUJCMY603Cbs6+fnesnpktStM++X8qZ03oI1o1LK/OqcnnHT5Cz6D53913
 HHOIJaUSUVoHNlEdqAdin9JT90wVFQtIB0D+gEYYV10h0T/jxZsOxeRjLbFNjm2BAcK1
 gBnpsSK+p/+PFFmKNCAcn90biyNBr61wqZYmT0Ng28vkPCvGchP0c6EKa0APqdjjl1LU
 vlLOre734SKIMjAMzogGZh/GFVyy77MwSyQeY+EGigFVw2DFh/5G0UcNq3cUFGB0FqNu
 qmHK+fW6DDuNEfYzFSk9t1XMtw8WS4Lh49rF34MXlT/ZNrEmAETqCJprU8LfegRfDBzG Cg== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 3c4t7htmr8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 05 Nov 2021 13:42:23 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 1A5Df9dg036503;
        Fri, 5 Nov 2021 13:42:01 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2109.outbound.protection.outlook.com [104.47.58.109])
        by userp3030.oracle.com with ESMTP id 3c4t5d04ag-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 05 Nov 2021 13:42:01 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=adxWwJdS1qpS3DnkPpCuuArbFZSDuQty1ZO1y4Ifsplc03/uBwfEq6plzdJ+n9vDd37cpubwdgLr0qKqSt/L/Mi2rXDfR/qqrmXYBfs958pb66dL927vka9WKipe5/yBjFMjRi3Y8GFzk8WbbGdH1iXF0eYfX2BSrneFIOMce8rcLdMCFjUuKuQdFjcICyPNO5aa8Ww9nlez8PGsqXcpqm154w4oRjT6Na+ll46rAoZnOwQKdWsicUnvtHwSCFEnDJ5MMHIjiEzYuXFpDJaRz2AQTZbLrIwUAV2ldI0WnV4t//4nxu52rwngHMpI28Cru36KTR7PNqFP9zxouCvnQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WYWbulgls9JD/oNW4LMHq3ODYfzsS5CP4kDHZT0R0/s=;
 b=G/nb2AMq5coqLDu1SLL1W4kDTfC4u64mnVi1GVM9XLnwfQFRyot+lV4wzcb9qSjtMg7fdQj8MZ5VChbvh8ifzv+5bOqe0uCkUM5fiUS98b40D1MfsuPrGpu1Oow5m1uqUKaj2lh4Kzg/EGZfhUwR26/G7nsiEbz7xlj6Kw7xHJbCCeFUneFjvSLC4NI8oxNxvRac23mTeRwk/36fjFn6A4+0ZYcujsWUFTWbOU2Rd3ui8wXM6V100HswjKqb6Kx7a6ieHMl4h8tHP/Jdj1Ae8HRjWuRooVekyPkIwaoMNzWxHDZTmwnIgvqLPSKCAAPY4y7gQcHExIh0Yb+JAkPjdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WYWbulgls9JD/oNW4LMHq3ODYfzsS5CP4kDHZT0R0/s=;
 b=BaLb89VA9/nIRGC3zjlFibdvmuwU2E4I88yPKsEw4QKW/842rov8l8r3bJ/QfJBkFGuotd0w5p0KAdfEwWuAOyvCu8fVwmHhUBozdqDNsiiDJfcE9CrCwnKIBqzWE250WH7JQKuivsaPqApXAPO69UlxD1bX8wkTyJlr3azjqIw=
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=oracle.com;
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by MWHPR10MB1247.namprd10.prod.outlook.com
 (2603:10b6:301:7::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4649.15; Fri, 5 Nov
 2021 13:41:58 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::d409:11b5:5eb2:6be9]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::d409:11b5:5eb2:6be9%5]) with mapi id 15.20.4669.011; Fri, 5 Nov 2021
 13:41:58 +0000
Date:   Fri, 5 Nov 2021 16:41:39 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     cgel.zte@gmail.com
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        gregkh@linuxfoundation.org, straube.linux@gmail.com,
        fmdefrancesco@gmail.com, saurav.girepunje@gmail.com,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Changcheng Deng <deng.changcheng@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
Subject: Re: [PATCH] staging: r8188eu: remove unneeded variable
Message-ID: <20211105134139.GC2001@kadam>
References: <20211102073226.7966-1-deng.changcheng@zte.com.cn>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211102073226.7966-1-deng.changcheng@zte.com.cn>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: JNAP275CA0043.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:4e::19)
 To MWHPR1001MB2365.namprd10.prod.outlook.com (2603:10b6:301:2d::28)
MIME-Version: 1.0
Received: from kadam (102.222.70.114) by JNAP275CA0043.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:4e::19) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4373.18 via Frontend Transport; Fri, 5 Nov 2021 13:41:52 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6b2ff30e-f632-4e6b-13ae-08d9a06209b2
X-MS-TrafficTypeDiagnostic: MWHPR10MB1247:
X-Microsoft-Antispam-PRVS: <MWHPR10MB1247D99EF105F31E143D4D4A8E8E9@MWHPR10MB1247.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:989;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UTjuEQL9ZOTe0Z2r+PNRHZ9/XuSoSKJaKB3/TTpNnF9V+qbrJWw7rJsUnh+XVq9f7J4a084vDJTspKC+KMVty7SguL3uuP3gbwgfvNgtbmehYnhtqQ2ukJpXxZ55qwqWwXXU1h6eTYhuT3YED51zws9fZtUC0QS1gy2yopU19wlANPse9odLlNEvCvB8Aq0FWFqJweX9iAdADNphc068HRPEJ0SZWow4lda9NM2tYS+IE0tniONd3yAP85dmvItCCcLxSlozid6HVzUMDmw3nrH8fdte+RT8/2ZIzywI6E1y8LumnXJLcIKB6/DpR1iNVBlDwSZzzgVI9tPDOMDS5Tqna1Ov23x/LvIkMBO4Pay5/gkfQ8+j+rsvcwpe+gTF+KozIYNbUafGC2tCQFT4SDIIX1R4todvTmT19QGXY0qPjE9jR03kYSBiBrV9eOKkq2cwRe7vEQJCa66PGxuvPjXJRKD2di0Xf3hMwAJ/ctLPACtLBGJ4UMsbcIbfXQLV1GkzPHxLFFwLdTnA+Ytq07T2JAroaDZ8VdLdWk7AfXwX+Xo8ErboQLUy3jeWsrTkxTqRDaYRT+EsfAwpWCCFZUqk9uCfsRuCWsBJPtuOcCn7Qv01HS74ke8PlY4hQx/p2FsYo2m/UbnQ506x2p2JJizpwkjrZZpV4N1WgZARGs9awEeVwOLFAD7RQWUZrNvYLbl9sjVWVZ99La0gjg441w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(33716001)(55016002)(66476007)(66946007)(86362001)(66556008)(52116002)(7416002)(1076003)(6666004)(33656002)(5660300002)(4326008)(9576002)(6496006)(9686003)(508600001)(186003)(26005)(956004)(4744005)(38100700002)(38350700002)(6916009)(8676002)(54906003)(8936002)(44832011)(2906002)(316002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?+rnPiqbMzYPSFnnuCxm8vyE8PWV37yyKt10d7ANpzDWq9jcaYaICXTyxirfj?=
 =?us-ascii?Q?d64vfjFEIlUFEP6sHBLX8GO70Ozzq9abUXTWmnbJgfd1rI1ITXO5Eo0DbdSr?=
 =?us-ascii?Q?xxxvzDASSu5tcrr5nJtaSpkO3LI9W5sLXU6+dSnQOoO8/Bqo5XM3oSTND0Ll?=
 =?us-ascii?Q?KbJY7fZyIHE6UIkkCkCrNrFAUDXGP6EuRDQfCszBCTGLeYJYBn09lkkWIbV0?=
 =?us-ascii?Q?kY653xrhHY+Z9CfqhUc9hdFvs0CdYgVbqDLY/FQuEeu7nqDIqYPT6VmS4N0C?=
 =?us-ascii?Q?LhppxFsmST7JCsggJVB3WfQ4dBRyg+lM6J9eXif44v5hMtNSuOAkebo5zpWn?=
 =?us-ascii?Q?ELskn/owbaxEHwKwUkNEQwxB5b9sUuLd5k314xeAoieMFvyB8GJ9Lcz3QbPq?=
 =?us-ascii?Q?Qh6qmO1QAQaReFfjapcffaTYhKFuiGqXanscq5PCGEUWP5J+arAZXpWffzM1?=
 =?us-ascii?Q?0ARzmDAHxqXWYhUERx/x6Fgce4SIVy9vk/pqh/nPQVBejaHXQZK27bio3Kpn?=
 =?us-ascii?Q?ZzUKUkiDMXdjJ3fFsRYdm0/G3nQ8FiEY9WRSz6o0vaxHJhCfx96QCRE26uFw?=
 =?us-ascii?Q?9UCz7G8RlhHohJy6qTX95RDYMLRU+wLjsBP1z3dVt9MGk9MGN+20mCS3oCfd?=
 =?us-ascii?Q?6BShYhcAngr7yow5Z4PblMqtkiNqnzRq96gpzYQq7eHEUx1eIu4yNab9CTNJ?=
 =?us-ascii?Q?RmXQlk8msSA+Btvqzy6MYv5QrMfbihUgQ49PSOvwu9frZKMB4OUOoXZtiZBC?=
 =?us-ascii?Q?oP/ukiq5zfhsnCP34kBIqnhomZCekTpzcWZo0zw1oVZkY+BMKeGM2dRO0nHU?=
 =?us-ascii?Q?THE61n3vnAElpQtO+rHq3H4EHXOofcGv6K0gJHfzLhJKHHF/Np+e6mP9FC0X?=
 =?us-ascii?Q?HvnKmPtilORLA44k+F9Jw6xqb3Bj++7oJb4GCHqalrVOv/0Np3aL0TMhYpw3?=
 =?us-ascii?Q?mijjFrctxYo947e2ITa1mciEvxRjVlxMhPgC7YXrqiUchrF9T6ET+FZ20jSx?=
 =?us-ascii?Q?PO0Hn/58Ct/iUb07f+8R1qW4I2sehal5U0XxPT8oUCasSXg4ywisDq7DP3jf?=
 =?us-ascii?Q?/WU9CDVp7yzzwvxVLsiGhFB27jIZM8bMT5Q5KSkizYFTMeHlyB+OPZarclGP?=
 =?us-ascii?Q?PuuFkJNDnK2posXK01U2QHvHCdo5QP+f1N0QileE+eYPl1E8OtvaXl4wTVKd?=
 =?us-ascii?Q?OPxQ/gmd4qyDi/PyS3iHGPJTml0TQdJSBtdaeWUvHarJhOVL7g7WU6aVy2SB?=
 =?us-ascii?Q?scJlhQ/KKWli8J1PbSAp1prRTGth/uZ1XRQQGPBMDSbRIkHg134uYCUiw7qS?=
 =?us-ascii?Q?MNrYrfZ9cPE8DcwqlSyh5xXtjETLJCX0Simw7LN6cb1pivc5fT9aMaGxpZ/e?=
 =?us-ascii?Q?hwvyAxVVC27MwUjqq/PJXKS266JI127P8/ePAcA+fVfGqft8GJrufcj5uqEt?=
 =?us-ascii?Q?i00uVWOekbxpEXtYhwpk+kHwNN9fQusG010C7QovZ/Oca6hoNr9ntWbJFLNV?=
 =?us-ascii?Q?pGITUcY7NUC1re1uZITBrTqdEScp0SO1OPOieDvx90WhYle567KJsJi+/Uoj?=
 =?us-ascii?Q?y1Q2X33MrqCGx1BeueDR95pznIy9hCrR+efk1jbfZm/a6Q3oEunI2X2ERB5X?=
 =?us-ascii?Q?ZPle38CUxUY21q7xGYs1EpI1/zxycE6UFwrEo1YRmsJAPvChUrD1OacOmk/k?=
 =?us-ascii?Q?4ofKBTUp3gCoCBGkyQd12YB6NKE=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b2ff30e-f632-4e6b-13ae-08d9a06209b2
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2021 13:41:58.3438
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /AZT63SJPQlvLKvhBPSuhMXv+giiFnFY1Ff26uppavblBGSXI2buaU23FCSE7Qori1ojHNdsjzJpF52O0GpDh2yxE8ETE4M4eJNek0m0Hks=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR10MB1247
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10158 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=863 adultscore=0
 suspectscore=0 mlxscore=0 spamscore=0 bulkscore=0 malwarescore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2111050079
X-Proofpoint-GUID: gi8C2F-iyNVTgMgQvcN7GGSs33ae-0n3
X-Proofpoint-ORIG-GUID: gi8C2F-iyNVTgMgQvcN7GGSs33ae-0n3
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 02, 2021 at 07:32:26AM +0000, cgel.zte@gmail.com wrote:
> @@ -1611,7 +1610,6 @@ unsigned int OnAtim(struct adapter *padapter, struct recv_frame *precv_frame)
>  
>  unsigned int on_action_spct(struct adapter *padapter, struct recv_frame *precv_frame)
>  {
> -	unsigned int ret = _FAIL;
>  	struct sta_info *psta = NULL;
>  	struct sta_priv *pstapriv = &padapter->stapriv;
>  	u8 *pframe = precv_frame->rx_data;
> @@ -1644,7 +1642,7 @@ unsigned int on_action_spct(struct adapter *padapter, struct recv_frame *precv_f
>  	}
>  
>  exit:
> -	return ret;
> +	return _FAIL;
>  }

Heh...  Let's make it return success on the success path.  The other
implementation of this in rtl8723bs/ is wrong too.

No one ever checks, but it's called as a function pointer so we can't
make it void without changing a bunch of other code.

regards,
dan carpenter

