Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1402A410467
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Sep 2021 08:30:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237074AbhIRGbW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Sep 2021 02:31:22 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:6146 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229476AbhIRGbS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Sep 2021 02:31:18 -0400
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 18I3TPfZ018458;
        Sat, 18 Sep 2021 06:29:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2021-07-09;
 bh=hJAzp45UMi211H22imJ9M7j/XUvEyr+PZ9IVqh50k/Y=;
 b=WI/tf3BwKQEE/yd/TaqXxHXNAaxeC3hWNBNwt3F6ViumXX2AQpuhWehlggD/gqgpE6r1
 tJKJQNtKdo8/dUZR6NFXNqcOB5brkAfAvKdnNUmkkiyf1OVBqU1bh4EZC4Cxg3YwNB/B
 jOwHG5upKegNa2GO+W4TOQl5s90zC6EcgeyQVCICh4B+qForCijyZ0fevZC/ClFJvlS4
 8SmtSCVIe78nX7lRX0bHsGrZjx5p02dkP/+CWCSd7aIYXG8ljeyJAI6XiEtGDA2OApfv
 vZZkx91DsqJXaUj3fsbBDVys6aRXD7U0+KJCHhus1I2aZ4P8Ty5TJOlBNEYCXpoThymw aw== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2020-01-29;
 bh=hJAzp45UMi211H22imJ9M7j/XUvEyr+PZ9IVqh50k/Y=;
 b=LuTLv19Dnzyum1xk3JPT5FJcBatC/5nIk0lx2RTqLevTVFfRD5l8EsYIaJ6srtwktJQj
 XlFAchRaoSAf9qGrAdYxQDokdNjqQT+6ke6ZUCuVQQEaGVvEDIJjoApU4YddlN80K66U
 0nB3Bqek+/Nkrs7rTj4MSY8bapHcVhYh4VoAzPPfnQ1jPPlt/6Kt+ViEJd5r97tuYH07
 uxUVqMt19pMHbwjt0UjXdkEO30Qz1nVpVOvhNafCL4D31xaLLu0+wNgHzzeElbgI2rx9
 vrIO047CvxbnQYusdtI6EWKDa8FuX4/ZvVKuww673pU3ZfcbmDtSW3nh5+gz/HDxl5Gs Gw== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 3b5809r7x8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 18 Sep 2021 06:29:43 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 18I6PMIf018780;
        Sat, 18 Sep 2021 06:29:42 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2169.outbound.protection.outlook.com [104.47.59.169])
        by userp3030.oracle.com with ESMTP id 3b557tg7qv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 18 Sep 2021 06:29:41 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YTq85vAbA/bbQ6UIhchi41CwQuUozkOPR8HbDbI+h3Oy//lo8hVY5k9Kiz7JvmgkDEd8a0cQ7Zg0FE4E0/gJLhronfpLMB/j3Yhz1bgk58PpvzGJsyzdprd+5vuX6tEp8XL/BYG1tKEcq3J1xJA9AlBSUcMULs0WUM/CVzjebcexJd8i1EngiEqm7/O+bVyOpYb4JLR5Boco7aGt7ymj0zLkoPgkl1uHYiQhdQ5XJkqXBOKtZw6onTRD4cV3NxhRCLFGCb7Wx9gSP5IHTNobeERmbvkbTfgQhR9Qt5dIty2I4opU924v/kTHLMvJUtD+lNyrHJGi0JUcLzUY+qSumA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=hJAzp45UMi211H22imJ9M7j/XUvEyr+PZ9IVqh50k/Y=;
 b=lt+8kdiHB1L+K/USONkFk6nUVqBz5HreuJDH3V6aSO/r6aZ4lrOZffKU3TygY60HRdxJxMhHRBIMvD8Js+nKRRhrOIiMypss+hesLoOd2IMWuWTWrXfxotESiFdcuFfXlk1Sb37nD8urGcd5cJPb1+ayKlsWGLW00VdJTF/3ecW9TVmGnV40T1jaxGFE90vQbcPT2rH0WdiES9tJ8OY+c/xMFIkQbZ+abTNGtlSC72g8pe5+pV22m+aThoP8luA2oZc4OQxo+yBKgmCgon1d9e7e09QKcrJhP0J5UUp4Rtx/whdDNLMuccNzO8IbBV6asextE7ruLVj/zfk7QEb42Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hJAzp45UMi211H22imJ9M7j/XUvEyr+PZ9IVqh50k/Y=;
 b=pKi2X7FAPRVq06FC1owzjJOBy5VTKYW+FoyfGmr/FugO1QW818XVsvY0YHqvKQ14aDp6AAPmoXiEpnmKPHygzsmFOdJCzTFRjOaLua3iZtY0rOMrFf3xk3l/YZxwHQqkzY6ymsgq16jrA/obeOjNMFOD5CLivK8T1JV1WnhXGR4=
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=oracle.com;
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by MWHPR10MB1245.namprd10.prod.outlook.com
 (2603:10b6:301:9::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.14; Sat, 18 Sep
 2021 06:29:38 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::d409:11b5:5eb2:6be9]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::d409:11b5:5eb2:6be9%5]) with mapi id 15.20.4523.016; Sat, 18 Sep 2021
 06:29:38 +0000
Date:   Sat, 18 Sep 2021 09:29:20 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     cgel.zte@gmail.com
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        gregkh@linuxfoundation.org, straube.linux@gmail.com,
        fmdefrancesco@gmail.com, martin@kaiser.cx,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Changcheng Deng <deng.changcheng@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
Subject: Re: [PATCH V2] staging: r8188eu: Use kzalloc() instead of
 kmalloc()+memset()
Message-ID: <20210918062920.GP2116@kadam>
References: <20210918035141.237455-1-deng.changcheng@zte.com.cn>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210918035141.237455-1-deng.changcheng@zte.com.cn>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: JNXP275CA0042.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:18::30)
 To MWHPR1001MB2365.namprd10.prod.outlook.com (2603:10b6:301:2d::28)
MIME-Version: 1.0
Received: from kadam (62.8.83.99) by JNXP275CA0042.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:18::30) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.14 via Frontend Transport; Sat, 18 Sep 2021 06:29:32 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0bfb946a-c92e-45e9-97ac-08d97a6db0d2
X-MS-TrafficTypeDiagnostic: MWHPR10MB1245:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MWHPR10MB124518420239EAF5034A74E38EDE9@MWHPR10MB1245.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:826;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fnbT2+Uh0xElkii2PquXcvWch3StRtCIfkrpn2xeAqtRQbdZ0X/o0nDG1YjICRwanNCRuK7tHoYUw5F5hdJcD3O8McH7o+z+UGdMtG1/KVe4rsYM6MJUwAxogyIfl3m/FTDt8wzPmYMEA+2F5kcpLSop3OSCjCnx6drTqFwAx5Jc2+E6Mewxcagp97RcWRP1FuMIeELPtQwkxhgklJtaL1XlD6vYs5KG0hXt2MX8i8ASgrze09cqV65xdBpP/Q6IPQe+B0E5TiZ/X2prasEMITggu6GhLridmzMzSh9finna0dq+NABF1P/3aqqmNLUDPMJ19AdKMVdzmkhyPI0ChVDVNySA/mGOBzlJv6r85qidveN3PrXUP3LyITYAKjmqHgrYrCbDPfRY2h+qKMTphPkG8n5LfaFrph8YlEaW6Kgf+HUKGWCiiYI7ZPFDEGwMRDSO99RVutasbwIFFy3spLBOXOoN7ZxgXNxAmRB6KRg7TfDC2hOVymW2dq/NrxpKkTC+1RREovMhlrqfsr6aq+9bSvPO7cOgL+PBNtd3nBPSr/phFFE06VGVSHdLP+p4S1VbZjcpgifihAs8Do76pd2f2+tHqpawYWAubQtuF0KsVUb9Xo52GOQAKoqSfaN80+N3EdPNBwL1S5H7N9TxbpkJffsbqRXSSlf4Y0WKT3FHNXRBWiwTnV5ZhMRRbe7Ru0YybryK+0btvuwx+FebaQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(136003)(346002)(396003)(376002)(39860400002)(33656002)(26005)(4326008)(186003)(55016002)(6496006)(86362001)(9576002)(6666004)(316002)(7416002)(8936002)(1076003)(5660300002)(66946007)(478600001)(2906002)(6916009)(4744005)(9686003)(66556008)(52116002)(33716001)(956004)(38350700002)(66476007)(44832011)(8676002)(38100700002)(54906003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Vc4Z9N/q4OmkZo40UyT7/FWZYY9pRYcnSaUZgwprpkixYG6lDuU6PfnLR8S5?=
 =?us-ascii?Q?ygAYxwDJUcsUW2GzSwMuIjFbrWzxsrSHbp/JItfeOMtwpA2kXlBFc9D23PbJ?=
 =?us-ascii?Q?TpIkIvnjbiIqUHwixE5SV0Ty9ZRjbAOvFwaN+ZCCPPoUfIP+yDV6HpxdEM2N?=
 =?us-ascii?Q?YntEyLAt8/4icNKKeZaxapSK7jFrXPXUjnuFmzBYO+I31HDoZ8vnVALRH94I?=
 =?us-ascii?Q?kzz+/VyjzhmIEFLOZa5PVNR7tEqeHW3lzkSrSS+MwmnKQ7AHemJuQchnsagY?=
 =?us-ascii?Q?G/SWw2lXcfUnENd6tYUbccQpWb4Y2HhNLX8mlOnQ29w7E20GfRwOqmGsYwcd?=
 =?us-ascii?Q?S6cUt8IwrObXJnyqLD97oHF5IZK7zzrzzIEYDqCqKE66SgMoZetQXUwm4/jy?=
 =?us-ascii?Q?amNSSh5r3ViyHeYZYkB+WdQ03GdHF6muuSjCF/cRUomoAN/KqE+xcGq2cPU/?=
 =?us-ascii?Q?vx44CWfljnicmpGRK1N5X8V7aLTDMyDAoUSo2MRBfWLYEUn30QPdu3feFG9D?=
 =?us-ascii?Q?RYneID49Gxc34L8+MLdDKXMZi3gLza2sgIQKc63TYUddlHwjod07ARYvIUrq?=
 =?us-ascii?Q?rO6Aj0CZh9JiFo//v9KtzEPHoy25VyOOq3KrrRIbV2hqtGrC3aDxHJzpAE5w?=
 =?us-ascii?Q?SGbRaumbzStTsZ9LFC0sxp90NNutVRAIqs9ujQB9pVt4DCQ8iNf7LpyMKpQc?=
 =?us-ascii?Q?t0cyh12F84Kvmc0i6XYqymxgwWaB2Ng3Qp5zPcWoHi8I/TXL2uu2gT7DvkEi?=
 =?us-ascii?Q?BPab2uN7lONYgp9YMVSZbfYMyezfZ/C7SQRP7YrIsQbZtp9oa8AolhneGuYv?=
 =?us-ascii?Q?eNjs2VxwUGunu4T3ptPDGjubMbVuyvLNdeRptBdawE+LqSJ4Z0MZHzCMvBbu?=
 =?us-ascii?Q?6KSZqIpdktVphLsrqA6WqS39ynVKegk/e8a27quuq10LFUM9uunEBzDDMCSW?=
 =?us-ascii?Q?KYVhc3Q9MdtzQpKl55vPINMmQPThRJI3gnBbz9V2TWbr9AWA8omvLeMraTHL?=
 =?us-ascii?Q?FS10vswTqDWw8Gjlh9BNPuArDL4ZM61jYOevBvVU2WJU2Lxq1dfCtj8kPGQ/?=
 =?us-ascii?Q?Quo5GL5YWt4F/wLlhPXjUHE33StOA002HSik9JGk0IYVoi2RRRRwiQP83Gv+?=
 =?us-ascii?Q?SE+Yqfr3VGcy/G70nDINXDMT1rDBOcRdez5PcRDtZ5KZXsPEAvWLfIC4yOu/?=
 =?us-ascii?Q?JfUkE8dePO0SAZcKj8dYBDyouoFR8OPwf91UuPmnUsbR49/G7PwyEr66/aEl?=
 =?us-ascii?Q?Hk50RczwjFk1rV/WEVvEf0QFjG5pBzuJtJHu4NhPpHyD9OV74aOBkZmXmGFL?=
 =?us-ascii?Q?t+PfanYvgDPAJJVHn0nW7qN3?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0bfb946a-c92e-45e9-97ac-08d97a6db0d2
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2021 06:29:38.7420
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: amRUiDdAlFPm6qQ6TpKFay9wOpFF1OyMsId36lv5R/IjA9qZ+fnGgfHETHohkqixysv6X9B+tHv4+Gz3nEADGVY21FtrBGqES33Oa3wqMJ8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR10MB1245
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10110 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 suspectscore=0 spamscore=0
 bulkscore=0 adultscore=0 mlxlogscore=999 malwarescore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2109030001
 definitions=main-2109180043
X-Proofpoint-GUID: B0awYx4fXTmUj9CidBSG7TtA4wv2EMJ9
X-Proofpoint-ORIG-GUID: B0awYx4fXTmUj9CidBSG7TtA4wv2EMJ9
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 18, 2021 at 03:51:41AM +0000, cgel.zte@gmail.com wrote:
> From: Changcheng Deng <deng.changcheng@zte.com.cn>
> 
> This place can use kzalloc() directly instead of calling kmalloc() then
> memset(). Replace them.
> At the same time,error code that is "ret = -ENOMEM;" should be added
> here.
> 
> Reported-by: Zeal Robot <zealci@zte.com.cn>
> Signed-off-by: Changcheng Deng <deng.changcheng@zte.com.cn>
> ---

Thanks!

Reviewed-by: Dan Carpenter <dan.carpenter@oracle.com>

regards,
dan carpenter

