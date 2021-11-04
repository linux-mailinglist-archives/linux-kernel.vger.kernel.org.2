Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE7234451FC
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Nov 2021 12:09:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231332AbhKDLMS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Nov 2021 07:12:18 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:61094 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231237AbhKDLMQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Nov 2021 07:12:16 -0400
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1A49tLh7030842;
        Thu, 4 Nov 2021 11:09:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2021-07-09;
 bh=nUv0M88ILtbehO1U5RSPg6MhYhSwplvp5zxM/NhWH3g=;
 b=NOKJixEahE3xI6/gbr4PwtK11N6/AxC1XIv/DJw+1vwValOWDXg57iHTa53xpGkpQNWL
 dU6RAMR3aHUw2EfIYJXmQldA3pbyHy8RNM9HBEOd0zjGTzGeKi3RIOyNtM1g83kBFFz2
 AXQKpQZ6kmUFr2oskTELOt1/11y5rmCJxrcmfUjf70ppILS4/gP0OTzzD+TWLlDcodBw
 KatojiIYlkq2zVNCxFU0iPnIi1cFktmN5zTRJdCFiIxMjQADDBkDCHwByAblhoTFJMVb
 EAkMT8x+gle5pOdgvIK/9uiNgG2ypxuu4cG0pMzqKWxYWmVxxY0xVd69CYooXNvsuYoM dQ== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3c3q1newwt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 04 Nov 2021 11:09:24 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 1A4B5hnK151621;
        Thu, 4 Nov 2021 11:09:23 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2171.outbound.protection.outlook.com [104.47.55.171])
        by aserp3030.oracle.com with ESMTP id 3c3pg01qjp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 04 Nov 2021 11:09:23 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kCVhaQUN0YxMOu4oeG6Wq+4QmltGYTyibY75G0dRo8l/gHR/Dsd2+7pgLBl3k0eCSBmDrICYfzIHrvo0grEf1nhN2Np1KWu1j47fU8/Bfo+BV+ts7kr3zVDOQxQeTY0WksU+6is78YolqS1NlJdtwQjgnKwqR0P3rioN5vD6h2BY1qgis4TZkpqasbejQ/S9OEvxoWnswiAWM9+fMMUHcm0oBwyWiObiTqFZo6DF3Waxjg7U98MydxxNPr35yvIXY+OdP+Z8959HosWb3G2JF7DQ2NVJ8/Kiu5du5B09hNMONzzLP34QsBnapHFnf5KEch+3QL2YywnyMx2mSyiFmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nUv0M88ILtbehO1U5RSPg6MhYhSwplvp5zxM/NhWH3g=;
 b=krS0fzSZmku0Q83w9l98sNe+W41cnYJHrqNTd4AUrut//euyoIAkJD3slS/LW7hkd3OI+GFF3xsU/mQ6Ji9oH5xuvsocT02vmdB9y8i6dfzxcl1kRd3OS5pEo08mwnsct+zYcbh1Vvu7wMtN3zuV4+oFK6Sc3gsFEOTlhE9MfY2iw9FGEEn4uBT6Omu+fG3si9GjNSWQn/T6JrUT4ILgEE+mr5uQWPIhyC8/pxHL00vV47ZXsl3zUbKC6lEUWrXCdeoHVyHDK9z4lQx4W0RVlFTw+bdVtlVeOf0eDxSsx96PeeGsH6ec6SgMHg5oMakRprDqHu+XmknZ3D4aQZVP8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nUv0M88ILtbehO1U5RSPg6MhYhSwplvp5zxM/NhWH3g=;
 b=BW+9fuI10MbWtob/rwqJIiRb0JAPj5QJPKw39Oo4c0821hdHrZz+hI/vQP/O5E7/ZsDygbuXbJhCY4rVpp3xzB+rF1VhE2JHUuyOOdRekALXExZcXbpQDXsKwNIyRJp1dlXb6QxeCOypBZTuQ5FlauOTgeyDFKlTTJ8RfvUSRiE=
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=oracle.com;
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by MW4PR10MB5679.namprd10.prod.outlook.com
 (2603:10b6:303:18d::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4669.10; Thu, 4 Nov
 2021 11:09:22 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::d409:11b5:5eb2:6be9]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::d409:11b5:5eb2:6be9%5]) with mapi id 15.20.4669.011; Thu, 4 Nov 2021
 11:09:21 +0000
Date:   Thu, 4 Nov 2021 14:09:00 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     davidcomponentone@gmail.com
Cc:     zbr@ioremap.net, gregkh@linuxfoundation.org,
        ivan.zaentsev@wirenboard.ru, yangyingliang@huawei.com,
        unixbhaskar@gmail.com, yang.guang5@zte.com.cn,
        linux-kernel@vger.kernel.org, Zeal Robot <zealci@zte.com.cn>
Subject: Re: [PATCH] w1: w1_therm: use swap() to make code cleaner
Message-ID: <20211104110900.GB3164@kadam>
References: <20211104011123.1027524-1-yang.guang5@zte.com.cn>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211104011123.1027524-1-yang.guang5@zte.com.cn>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: JNAP275CA0072.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:4f::23)
 To MWHPR1001MB2365.namprd10.prod.outlook.com (2603:10b6:301:2d::28)
MIME-Version: 1.0
Received: from kadam (102.222.70.114) by JNAP275CA0072.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:4f::23) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4669.10 via Frontend Transport; Thu, 4 Nov 2021 11:09:15 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d3ea5eae-bbdf-4d3d-2aad-08d99f838dc0
X-MS-TrafficTypeDiagnostic: MW4PR10MB5679:
X-Microsoft-Antispam-PRVS: <MW4PR10MB5679678316A383BBC37231D78E8D9@MW4PR10MB5679.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3383;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tNZ0Im438PPCzWtTsXxltrD1jbvP14iSo+W2q3s/gbwBmXyoUVXH4nh22k7iqpnMBBmqZ2mhcLLuHI/NTCqJlQYyYwepY0efSPkXHFV+0FkHxKa0BsZxQIJzDCXzDqjx4W4AqDWz4aToH1D6vRT0tZfdM3meOii4V86FbWrcuF7vpxCkm8dJwK3jTY5Ppuze6ymnTsXL2C9PRHdvb9HrUybiZG7wqczyND396vAiLJR8PRe6cwTwzXoSi+Xh4YCyABcXWdnBXt2xAvt/wmb1dDQW/wwQX+8eXlzpnWEshfLQGRmDEvSZbsvlRMNl27c2LxfZKBuXxrFnH/kKHDrOF1Ip/hob5HICJLWU9BXDcZFRwjajtwX0FKfQIf5gHp09QBGZe2Sz0lUoFEihT/LixjgkagMdZut+u2GyZ+3CFUk1U2zBBZi2aYBOlC+QVspy1qxKbWx419PpCqTLdxrT6aJCnA3777bPCkO7p/iyBIqJOM+q735PgdUv7IkKDnEbpvfqYMfzAiiorsJJOhtyxkU9nNENyMg8n8Fzzm/j8m/V1b2YJxufbLO+Afrh1iO2kegHKJLzvsY3QVvGuoKBcKiH3VjZEIt0Jq5giN2AnRZK8eAS7BuravfhBltkI5ZXyI/PUHOKCAA7EflOnOng94Zz0ARREDtwe04VSYoSYSzeHpq024QJzpquE9GuhaW50BnGYbt5yLd40iTM1A5p3w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(956004)(508600001)(6666004)(55016002)(26005)(4744005)(9686003)(5660300002)(8676002)(86362001)(38350700002)(52116002)(1076003)(316002)(186003)(66556008)(83380400001)(66946007)(33716001)(33656002)(4326008)(6916009)(66476007)(8936002)(44832011)(38100700002)(6496006)(2906002)(9576002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?aPhzKudKdjpJoJ7yYDmhFB7yNajnaJLTWcnWlvvQ2QuLzyxQHrdprf11RINX?=
 =?us-ascii?Q?ABGUqfXZk5v10u/V9i/v2Y8z8exHm50xWOA41l3A5+olgkYD9IhIYIWedPQ4?=
 =?us-ascii?Q?/GnnMTfZnkT1D+4f/32q7syWDXM5WFE1OUgUXyNn91peHz+oTqxuXu94f9E0?=
 =?us-ascii?Q?7JlO+YY0DGhhhA9xNzVDo1DDq0vJ8C7w6v40HCv4cf2Ar4wmO2TOXsocqWgn?=
 =?us-ascii?Q?mQGUJtWnjZuWO/rsHTpjSAuwQ7XjjyZdVZ7kNB6CCOJPKigDB7jrGZ1KaVg9?=
 =?us-ascii?Q?jfeXThlMZwHLGKv99En9fPpGttBFto+Mo17m8LBohvS5Kf6lwYiuBncq45Tg?=
 =?us-ascii?Q?FkcPLq4xWWD9fI73HZW1d4WT0cEnKyKCZjGGDX4vlb5CxHPuyUQCj9/8IxM1?=
 =?us-ascii?Q?fu7cs/hf695Jh9wjVgg9jyxGCW4JpEX0vK+JVf239b++JmZGJnXuM3BadPHR?=
 =?us-ascii?Q?S2lNyqMgZ2sou8ZQgs4fHdwl99mtxypputbWjIMUSDUT7mv8p48VASLEA/JI?=
 =?us-ascii?Q?KqDBSF2ceijZq1p4StHxV10XuAcE2NFdqlJrSOEkNoxQSuw2Uf18bs+2oEeB?=
 =?us-ascii?Q?u8q85tEmJ2i8akdxu51rhm5DNVFe891Dbsa9jX/HDaZbDB6TuMlltgwmYVxt?=
 =?us-ascii?Q?WBnLbe/l5GDx7IoH/vJ1eHzgE+V3luinT57oxMu26INtR4rX+PKmdwTFAmIE?=
 =?us-ascii?Q?oWEfYmzguctDoDjv/CK4F/Dyv8G6Ov8cClhNawV222O2yFmZCEgwgy5pdtJo?=
 =?us-ascii?Q?hECPQbUudYJwXjw89jPfMeURmbY/i+U3E+Y3/bUuCuC006WB1b2S85eloZsV?=
 =?us-ascii?Q?E334d29cisrGW1cSV61tFNsjkIpGF1iiEmtAYjYcnnoThZDw6zyBroDfTzHV?=
 =?us-ascii?Q?FqdENZvpwhwXHxkcGZT6UwBwNX8kFREQ3KCy68Of8QVHc+e4V5RJ+67xLDqc?=
 =?us-ascii?Q?QWyq9eTMW5GMziaNdK7AtXWnlIfqv6lpNeS+IS0w6MGj5CLohsdvRHknsofo?=
 =?us-ascii?Q?vLtl4suylUd/5VbSCJBCpBPwQOLsh/lXh2Sol428g8oLKI8gdmR9SqZECPUr?=
 =?us-ascii?Q?+C+a/UD/5XGWtoi69BqDCXQ+EckMXdOO54swSiDvnBiQLm9+wGgCCdD55pZK?=
 =?us-ascii?Q?/1CRYc9e9db5v8jXClUEwI8bYOJCK17AOu90NTWCBPrCXuP+icQtyZCmwA+g?=
 =?us-ascii?Q?ufbyHC+rZc2BYVSvK+zZzDnMAKCE2CD3ijRT+pa+vtxk19e6coQG3spLQCra?=
 =?us-ascii?Q?gQTe1Khtsb8FXqn25vqq8F7c8vphGBOkKdZvaumziT3y2uV+OA6APQQtjo9y?=
 =?us-ascii?Q?PCrhwtR4St7UMMZNi8M9vuWW+chyGBVXhhnwLxoYcgvK0cp9CCRr4RP1KMkO?=
 =?us-ascii?Q?yy5ZFQ65p+DsNf5z8ag2qlk+oMgP3wyC1mfJBsCB+0MIgCQl5y0prA+B62Bp?=
 =?us-ascii?Q?D24Tt6lI33qS3w039/yIqbQ/p43UEGTbYtJmtZi+AEw1OJhyCuwpKvAN0B6T?=
 =?us-ascii?Q?be+y3X1SGdXADm3u/obGghPbpJf50giGSK6pWwgoyzoghYYiCajdgLpwGkCp?=
 =?us-ascii?Q?9Hc46V11VqR8P9vEGqXBVgM0GFUKEq2sz+FEA+SSFcXy9tWGrkSMkoqctvXh?=
 =?us-ascii?Q?oKlG9RLwyYXXpot1N1nlfnJkk4Y15U9C0M2kno9STHlLcyJVldV/frr2n37e?=
 =?us-ascii?Q?r3+xPD3jPr45lIiwg/e6kLTOtA8=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d3ea5eae-bbdf-4d3d-2aad-08d99f838dc0
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2021 11:09:21.8796
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wqf83A22nzG+brmnfNQ1YjnUHPkkhZIz/V8U8GfuLEq0OKqDhCXK7xVmWTE/Zec+amc32AE+e6I+nlINYdtrQx9arI2NHHXTvEU8dAQ7EVI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR10MB5679
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10157 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 suspectscore=0
 malwarescore=0 bulkscore=0 spamscore=0 adultscore=0 mlxlogscore=396
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2111040046
X-Proofpoint-ORIG-GUID: Ni4YN6IkffVbSNgEUeI0pIQFMT59ggRs
X-Proofpoint-GUID: Ni4YN6IkffVbSNgEUeI0pIQFMT59ggRs
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 04, 2021 at 09:11:23AM +0800, davidcomponentone@gmail.com wrote:
> From: Yang Guang <yang.guang5@zte.com.cn>
> 
> Use the macro 'swap()' defined in 'include/linux/minmax.h' to avoid
> opencoding it.
> 
> Reported-by: Zeal Robot <zealci@zte.com.cn>
> Signed-off-by: Yang Guang <yang.guang5@zte.com.cn>
> ---

I'm confused by the signed-off-by list.  Are you Yang Guang and David is
your "English name"?  If so then this is fine, but if you are different
people then everyone who handles the patch needs to add their own
signed-off-by.


> @@ -1837,7 +1837,7 @@ static ssize_t alarms_store(struct device *device,
>  
>  	/* Reorder if required th and tl */
>  	if (tl > th) {
> -		tt = tl; tl = th; th = tt;
> +		swap(tl, th);
>  	}

Remove the curly {} braces as well because they are no longer required.

regards,
dan carpenter

