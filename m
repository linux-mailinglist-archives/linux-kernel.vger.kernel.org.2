Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 71FDE3F96A3
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Aug 2021 11:07:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232958AbhH0JIW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Aug 2021 05:08:22 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:58740 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232048AbhH0JIU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Aug 2021 05:08:20 -0400
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.0.43) with SMTP id 17R6Ih0u015020;
        Fri, 27 Aug 2021 09:07:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2021-07-09;
 bh=1NlA62nxTuhcwvEY2cAfwLS0IHS+WNovlyzXRJv3EJ0=;
 b=Zpoa/FaQFKPWVBPrRFspLwgPtv2iKxQY95lzrZIruGP3hazW6ps7utEDDI282loFYJsC
 0FzPnmNGhNxFVJcnaxADBef6D51/oCjCXGP5rwu0jbTkIS1ArHGx7AW8JjRcWCTA3eJN
 lzfSq6WQCRF59lXxVQwg7JjEWM+11O0cEQmczP6rkGa9MKvC1+yU7d+9LP+c05J29l+O
 SZWvQRZIcPuFCfuotWHrxRuvRXUGhwhVg+pVxrVH7UVlOiX0gdXDu7lWafh2r7ClECSY
 kH6EVWXjNKsusAeJpxkN0A1fkyMKM/wXibTFliZJMBaDpdCizNAs4dp/EEQgYTH0JP+J kg== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2020-01-29;
 bh=1NlA62nxTuhcwvEY2cAfwLS0IHS+WNovlyzXRJv3EJ0=;
 b=g+F1JjJF71TP3vGvIgjFF99wucd+RLaohL6da8Cf8W1IiHnMBhK+BE/xMiF0pmcC0zV0
 fIR9o0mvQr4WC9j3PmosvsBdq6ubWM7VvKbyk50Tep4mIT7uyWzX4Jvx3f8ydjv5PG1C
 XQpFk//hMEXdBpbkxmbojihgNLVdFfOYBkbsaMunwpbkBDn/mdRucpnlzIYiSTKjvC38
 PIBg10Wm8wUoVw+XRVGetXjw9a5FyKMGga8UtVE227yO5THNhhADiClqA57QntfqEdvg
 IIGd2QhFM8sOJUfb8DNvrf9fRJNdi/mjN9noYrcHZvdUmbm7tCa3YWTNWcL/25EG2x0J Ng== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 3ap4xv3286-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 27 Aug 2021 09:07:27 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 17R8tc04017522;
        Fri, 27 Aug 2021 09:07:26 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2177.outbound.protection.outlook.com [104.47.57.177])
        by userp3020.oracle.com with ESMTP id 3akb91rx9f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 27 Aug 2021 09:07:26 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZXPKV5lLJ9PHBOdYD7ec21GCC+1F68L9FkGleFS2AwEbUOZnBq0oaSQQVZDxjm/mD2PTXAdSILxwKKs1yA/Su00q7vEKG/4aEGLZ//YIKHJ7f0m9g5mjcKk/21Xdjmh6laE4h3n1V7MwREqC9a/9QbsAGHksw5AkasK/lgynyGne79rsV8kPN+bEbxCuCWJwQcewP0sZsBma9Eb10KvwNU3o07s4Q/K1pmulbuEYT5JsuixxbTD0mHQjMq+sUUxl6A/DIx1sFcaZFAtb6W/pMdM/z64pDD5PC/V39WMoMEkx7BkJDwtiqoxpds2ANMJKBZyT8RyfpyY/rPI+/I5m0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1NlA62nxTuhcwvEY2cAfwLS0IHS+WNovlyzXRJv3EJ0=;
 b=L8k6XJ16fwJIAfq9cFhQIfCxlSBrN2ec5nppdzgLydgq0KF3+wrzHOPXMX6Sy+CyH+iprcM+BwFJ7eyewWSR0XtuWNPuBs6agdD44VBaAilvsoJSDvxvr4z5axBhi5PQ+GnogYnajKMx9cnl57y0EdXq6teXDJadWAAwxisr775mmsOeZ5o6mGZpiqMF6mD9IxawhcrApLM9550xK1Mh8vmzkYFMswi1gyJpM4MhLqN5JIjpxo1iz84nCJKq7ZxGAG+w/EZ+6Ee4hRdGspNUbU/L+RoebqgIeVdPcoz15w+87QpF91RD/ESwNUAVJgDL0BnAKWyuPKi3xjUjJcCYQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1NlA62nxTuhcwvEY2cAfwLS0IHS+WNovlyzXRJv3EJ0=;
 b=YXthpoq0pCidpfKhlhkKubxMvZi/1Q8wmy+iVPkfKU/dfWQKUwTDZTgD3pi52fVSdxeetVgHQQVrFIsVEM2jfJ9S/eq2e5WojfaWqiLoABLGoPXyLKB8Orj+t4vTWQ0AnWuZm6hG1O88lRtG945JXF1WwOPE+ChQx0+pDh9bXDw=
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=oracle.com;
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by CO6PR10MB5569.namprd10.prod.outlook.com
 (2603:10b6:303:144::5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.22; Fri, 27 Aug
 2021 09:07:24 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::5820:e42b:73d7:4268]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::5820:e42b:73d7:4268%7]) with mapi id 15.20.4457.019; Fri, 27 Aug 2021
 09:07:24 +0000
Date:   Fri, 27 Aug 2021 12:07:06 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Pavel Skripkin <paskripkin@gmail.com>
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        gregkh@linuxfoundation.org, straube.linux@gmail.com,
        fmdefrancesco@gmail.com, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 3/6] staging: r8188eu: add error handling of rtw_read8
Message-ID: <20210827090706.GA12231@kadam>
References: <cover.1629789580.git.paskripkin@gmail.com>
 <c59d5d850bf9aab208704182c83086609289cb9c.1629789580.git.paskripkin@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c59d5d850bf9aab208704182c83086609289cb9c.1629789580.git.paskripkin@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: JNAP275CA0058.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:4f::6)
 To MWHPR1001MB2365.namprd10.prod.outlook.com (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from kadam (62.8.83.99) by JNAP275CA0058.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:4f::6) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4457.22 via Frontend Transport; Fri, 27 Aug 2021 09:07:19 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7a7686cb-4487-449d-388a-08d9693a155e
X-MS-TrafficTypeDiagnostic: CO6PR10MB5569:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CO6PR10MB55691F7F0875147B6A91EC438EC89@CO6PR10MB5569.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4941;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 893YXZdZn17aKqSlaVY2aTIvZz7OUaDQ6/RSqYcmYuB1uCTIX3jyN75TeV/8VPy/RWzltLZ5plroVIb9QUOKLr9UqjgyTSrC5EFSpDsUR8+UDwIfcS5VyFOVWN0+6Wp/pkkEmTW8P/dgENpOqaJu0xwpLgdkVMEyBrTH6OyT8K9UP72gsTu6TnlnEdjxVXlVi56baQpKonqGFsHDDp+BIFvN1R7JwkR3Smdfa6g+grDP/u/0ZJ0D+FLpsbA4NX75fBRuU2VN0KRDKYP314tfWHbgoTMEaRrX9rVf0nAT+uHKapBOrwW4hEiWyboCMerX0Y+qyyQMn7mkEX9T9iK36jfzywx+re31ATO87dCflOr46dJBbLsop3Li93AT2OY15a5a5+oOMmPmx6ZQgEIJeB8jkV2ANLybpSODIlGxKTP+JjSetWbT765gfNIEU6WHH46rA5SLfDYpOZB8/qWqrxdUG1zsVgqeUVqK7vPM8InGszbpFhZd4BxHQsQlHhbufHLdEwizS0g26kFpw8nP/R/kNyZGZQkxnKMXUrF/IWm/pSuukEBN4xSIsC04mr40hbMyIPZRH2WC7wjRkobt3lR4FqzipIp7ndRFUpRiCP4Ui3hTy4DYBVakVjkYJJD0kPlweHJWpxTXYVPWbWbXNyJBgLaeAuejyENa3P8QosTWneehluHCTh2vpFgrTVO4No5g7U+WMhbzDcsJbZXvOw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(346002)(39860400002)(376002)(136003)(366004)(396003)(44832011)(4744005)(86362001)(33716001)(186003)(6916009)(38100700002)(478600001)(5660300002)(83380400001)(38350700002)(1076003)(9686003)(33656002)(66946007)(55016002)(66476007)(956004)(6666004)(8676002)(26005)(8936002)(2906002)(52116002)(316002)(4326008)(66556008)(9576002)(6496006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?y1yxvHPMvsCGw5QTmO4LZYYdNNNsfx4PP/VX1NJZgKANM9neQEK9qpGcSf8/?=
 =?us-ascii?Q?Qmka8Ca9k11MTNmonxfhcEE300S3Gty8wdW6Hjqtup7G/oBtwxc/muDDd+0d?=
 =?us-ascii?Q?CQbDruMJtu7mKS+1A+P6XFgbYBS0KOp4RvnI9tJsZ1RTDSoMWe+saR59uA1y?=
 =?us-ascii?Q?OQFrRbvgSNdTjaCuYhWrC7UAgansgh6AH2jv3NpHXIEAAr9ORZJ85iG4qcqC?=
 =?us-ascii?Q?wjQ6qTX80knks1v8FbQjW7ubSXrcSfW+kKmwsuAHLVlKT89UcCWwPzz94oMR?=
 =?us-ascii?Q?Cvi9Z8FCNn25QPvJAJpUpU4rVVeTb71LR2Qfet2zupFEqjbuDYWgwftNhIm+?=
 =?us-ascii?Q?bIn5RU2Hzo2pxVn0k85+JVtbXf++kZtHgF+0T8t877p0Qhl8J9qB1KnohQZW?=
 =?us-ascii?Q?xb+497ov/qVOEwITbEYBK4JNsU7HONjbbQQlgkmfyEULp6qrIvbjZ+SAxV6O?=
 =?us-ascii?Q?UCbwVCE6ker0/6YeUDC+ZRp+r3gTuYZSe2tA9PBjX7XjaJYGJbHHJSOdjNy4?=
 =?us-ascii?Q?cP7oVT6041F3+ylafueNZYXy9kzVlxkJhjL5xuYtkyAPfEeHGt+nVYJFRUHI?=
 =?us-ascii?Q?kRrsFHzL47pU6dTt8lQTrkt8Dvnu8jSTlBKPszMWCtXFK5UHSc1opeYGtHV3?=
 =?us-ascii?Q?bHkedcD47At0B7KO5Uc/92CCLN++ufKvavHkcXDo4Q4pBg8fc8qmo8pfiZxf?=
 =?us-ascii?Q?bkEpsan5oTFgqCRIDeKqHqaIQXKbonPnEe5y7mFoNPKMcpc6lPRyz8MBq8k9?=
 =?us-ascii?Q?Akp5iyIbE2IygxIHLsoLRwPc/cRCV7GSWorQwl50gDmgpUNPrMaW6hul9wVM?=
 =?us-ascii?Q?WNeE49+Cp6S9L1KJ4RKocfJqqbsXu45g6ETkT3PtANesX2VkSg56z5fyWzHf?=
 =?us-ascii?Q?YXIzK3Eel6MT8brsfiHEdzwdWqfpmw0zp76UnwZJjptsDGjlWFB4/ri0lbQl?=
 =?us-ascii?Q?AJnGCzfdu8guuAD6N1v75/FE22siZdeagy2kST2OJBpCfbdgCVvNd3kUOPNy?=
 =?us-ascii?Q?Z31E1Srrza/XDKcPeSpvrpcjufn8EnIv4jGu6AP4kNvFsDIb4MklENYwIvSp?=
 =?us-ascii?Q?nVzo5B8sYR0/Ww2SHyOjUPEFEi3NJj13eEPbf5GhUUu9rnPIfrOBZFAStNVU?=
 =?us-ascii?Q?SI6UJ0CLgNS7DOQ1VBL31Jp+ZYyg5MyHpPUl3F0chhT60qCPDIkYKoOlmf64?=
 =?us-ascii?Q?BnUxj4hrOsZjdHf/SapzpVp2DA7JKavL9gU4uxPYYMBYYjcyaWPexp0i/WuZ?=
 =?us-ascii?Q?g7udLSTXjdthLoLY83psNjom14OQwglfqBOI1GIk9O9zhpBgmRKHK2tW7fMO?=
 =?us-ascii?Q?jbpNeUgR715IQeBtBD4y0g1A?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a7686cb-4487-449d-388a-08d9693a155e
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2021 09:07:24.2821
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RVrwv11p5qD9vd605oVekMsxyy7mTJv2W69cqNpFU7nYDpMZcOD1mr5NzO82f1hBNNMX/ravRA0dj3Ttdj6eusBgSG1+IUYabSCwXYkw64g=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR10MB5569
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10088 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 phishscore=0 spamscore=0
 bulkscore=0 mlxlogscore=999 malwarescore=0 adultscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2107140000
 definitions=main-2108270058
X-Proofpoint-ORIG-GUID: ui6U8y5XmsbmO8eMx42dl9_T798nSgZa
X-Proofpoint-GUID: ui6U8y5XmsbmO8eMx42dl9_T798nSgZa
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 24, 2021 at 10:27:27AM +0300, Pavel Skripkin wrote:
> @@ -83,7 +83,12 @@ int proc_get_read_reg(char *page, char **start,
>  
>  	switch (proc_get_read_len) {
>  	case 1:
> -		len += snprintf(page + len, count - len, "rtw_read8(0x%x)=0x%x\n", proc_get_read_addr, rtw_read8(padapter, proc_get_read_addr));
> +		error = rtw_read8(padapter, proc_get_read_addr, (u8 *) &tmp);
> +		if (error)
> +			return len;
> +
> +		len += snprintf(page + len, count - len, "rtw_read8(0x%x)=0x%x\n",
> +				proc_get_read_addr, (u8) tmp);
>  		break;

Oh my goodness...  :P

If you look at what proc_get_read_addr is, it turns out it's a 32bit
address which is controlled by the user in proc_set_read_reg().  LOL!
Just a giant security hole.

My advise is just delete this dead code.  No one is using it so how
necessary can it be?

regards,
dan carpenter

