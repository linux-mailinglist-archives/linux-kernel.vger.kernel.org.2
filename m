Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AEF2E40C6C0
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Sep 2021 15:53:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237369AbhIONyx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Sep 2021 09:54:53 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:22060 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236606AbhIONyw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Sep 2021 09:54:52 -0400
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 18FD2JIG026050;
        Wed, 15 Sep 2021 13:53:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2021-07-09;
 bh=YnbG1q64I00Yt+zitcev7MttHcLjJRi4TFzXe6+uku4=;
 b=rqsXKG0m5p5q3kEUQq0SEvKFY2qfnQttu50Ofwh4CNPD+j68zIzj/G7kx1XMwGByfyN6
 v3WDBfNnPn4ke64yMsKzlK29gwi5dQa1FoGhSAR9rei0cMGpmgff3ENb9JGvtazxOg3g
 LN5UDJkiaHqtY0sh+NrH0q4tk9iRXBOcr6AJ18upniN/bmYR0g+BzZuHo2PLsWHTfslU
 JDgaJAVs+iLHmmLadFRp9/tf/RvUBA3QAs26BP5OLeCmdFuKe4Fgi0CcUSoeyMoFKbug
 JLhh4P2eVB6GZTarjXfrMNcodUUoEEbB388FjUKoP7oLGfov3QEhQxKV0IMfQw8jCnFm Eg== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2020-01-29;
 bh=YnbG1q64I00Yt+zitcev7MttHcLjJRi4TFzXe6+uku4=;
 b=ycdMh4PFqvs1kkHRsUCKASwE4NAw8lwO6a7XflFu5oXrdAWe5xhe+ph/2E7Bm8AxLU8O
 oqb0dmgjVgWu5jxu3HYNJ9hO6B0fIGa8C+HsIGpSY7IM3rB+GQkjQ+rJyou1MS4jctBZ
 rnuZzNONOnkVPWEhCikYYpKsAVv980XpYeJv/O00ebRVHaAOke6Wh61XLvGL+a1d2WZ6
 8XEFGwt0OTiar0cDv/A6xCKVGUdbVsBeajvhqddanwjEW80HWkLeSOTzqwXFe9tFwpLu
 UqbTMkKRE97LS4A1FPW+SCcmXkmdXG87YaSTVgP0sHY29WmxHXnirFFuqDzR+2hGg43x tg== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3b2j4sde11-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 15 Sep 2021 13:53:19 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 18FDobWc165439;
        Wed, 15 Sep 2021 13:53:18 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2177.outbound.protection.outlook.com [104.47.55.177])
        by aserp3030.oracle.com with ESMTP id 3b0jgenrms-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 15 Sep 2021 13:53:18 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=M2JlWfJ/Enmr5PbSJ7oOnXqRm+Wnx6g3uAhnhiCIlS2jzi0drhBwFNe7fCvYgl0/YM6Cdga/lZvdf1Ium3qrS5Jty26Gk8LJIDmn4zCkOdxAAJa8aMIfY6D/k7Py48vtBsZ73FehKl04mcFlP7XQsgpxx4xzYQA7fZDWwoh90jA2+rdM/grcljQRVCcFN7wT49CXewP6mNLFLKbZ5Kze5Ohhqb1dutcg0hFm5YGXct5gAhJwoZlLR3QQSG22PuNpF8gn/OvqpM5AyRMnpszNKNJF8tqQ/pGTfWNWT6tIKzfNbyA8bRvU+c9dyqQLtmpeslgvktsfu4lMC3tIEviccw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=YnbG1q64I00Yt+zitcev7MttHcLjJRi4TFzXe6+uku4=;
 b=iNMHDyhkm9W9QGxRUpVPFzue+Lyutund9EsPra4+4cp6Nsvm01Fb0xefGmB5LE7b7ROnsPo9ZhyNlDV4hhNPMmovdt6JRXcx+y0kWG7OefoS+yjVmh6c9hVNlrmUIdVYFY673aJGmikH8zohmo14cqu1wqO3CIfiG1XDAa+t2NOynzX9PsaXxV9Q3gqwfykobi2+z2i/RhaDPP1CfSLAvnm1I4myH9mQhFEayTxszv/CDearPpck4UX0cZLYvtlvGdkDbtX4Touc8/np+Tne5NKjclCrjBMXAIBvQjVffHUlWMHoMWUoAFiEGAaLYXXFx4WNSbJhHNITsIsh4vLUBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YnbG1q64I00Yt+zitcev7MttHcLjJRi4TFzXe6+uku4=;
 b=XXk1o897WZ2x+qQ1b3PKFWB32FPu23lr+EBEABaZ/ER9Ecl9d98vOGkURoKNybvY8JNUJ4zwI63JuxnAXT0YlFmULSfl0uOT0SL+qaEECUjc3Lt2KaJV1YQ6udp2IhjQv19xoGfLj2eYHugr5OxBXwO6PsVpgW1aiEVwd2Pi8h8=
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=oracle.com;
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by CO1PR10MB4513.namprd10.prod.outlook.com
 (2603:10b6:303:93::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.14; Wed, 15 Sep
 2021 13:53:16 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::5820:e42b:73d7:4268]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::5820:e42b:73d7:4268%7]) with mapi id 15.20.4500.019; Wed, 15 Sep 2021
 13:53:16 +0000
Date:   Wed, 15 Sep 2021 16:53:01 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Philip Potter <phil@philpotter.co.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Pavel Skripkin <paskripkin@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        David Laight <david.Laight@aculab.com>
Subject: Re: [PATCH v5 15/19] staging: r8188eu: hal: Clean up
 usbctrl_vendorreq()
Message-ID: <20210915135301.GF2088@kadam>
References: <20210915124149.27543-1-fmdefrancesco@gmail.com>
 <20210915124149.27543-16-fmdefrancesco@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210915124149.27543-16-fmdefrancesco@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: JNAP275CA0066.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:4f::10)
 To MWHPR1001MB2365.namprd10.prod.outlook.com (2603:10b6:301:2d::28)
MIME-Version: 1.0
Received: from kadam (62.8.83.99) by JNAP275CA0066.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:4f::10) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.14 via Frontend Transport; Wed, 15 Sep 2021 13:53:11 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 75590605-ed7e-469a-ab5f-08d978502aaa
X-MS-TrafficTypeDiagnostic: CO1PR10MB4513:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CO1PR10MB4513A6285F2289681F6D59638EDB9@CO1PR10MB4513.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fAXpJUQrvI+ToU0nr7xR5xLbZkxZWhdUtzAzYadUr/dxIPFqP5lKPfjLFlQoDbIHWjPEebY0W8K7B+OXZxGuHhVW0QucTQO4v1J7/c6LwPLZYUZDYxFZjinoEVj+kPW/G4t+upXk/bmrbHOaUss2J1bwXnw9wkZfEgs9cY+fepQJbhpEzH9/gOrhfEsogWfzW04kUGf4HmA7259ThvQ480RDLpOVG7Bfe1M2/j3C6HA5CLHGHPtXgP9UyOIIne+4TMohWRBS0UXvdOVPWHV+lewrp/+AFovCSbAIs5VVCC0l7te4W6Kn3mMtEnYJWkCtbIj3odS2kwC4C4k8Lv7CZ+U/4JQWg7B5bzyLjdhX+fu2H31+w+tbO2xqzC328wX9G7IQU1ja58tfMJstVc5/RIYnEONOBgiJUFWTF52IZqf5IbttYhxIpV5sZAxpF+lEKWomZdk18HMNQJbuUcpnTCRfE/S5cYkflV1ShAJ1g7J1DTddORCjXQaA2XVF9gPQXqobWV3I1dc7disTIvongKpSK0kUXi3AaJRBSkfgtLbLOUF3I/aoVvYOQOMd5z9emRN4YG0Wjc6JAYn0KmJkm4tgiIw9vAB/f6ZSTF+5VEtaOv4HlYFiHA5uhBjL/v5a2Vy9aCPb5Tj1hfDtW6rq7dBs59dnxcg8snzbl7xxYHo1wTL5QPLPi5t9mzS8fHw8zKxppAvhT7Jm16NUzHnFLw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(396003)(346002)(376002)(39860400002)(366004)(8936002)(26005)(9686003)(5660300002)(478600001)(55016002)(186003)(44832011)(6496006)(9576002)(66556008)(66476007)(52116002)(83380400001)(66946007)(1076003)(6916009)(956004)(4326008)(54906003)(6666004)(8676002)(33716001)(86362001)(38100700002)(33656002)(38350700002)(2906002)(316002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?7q6ldlDvutR3mSKhdsIpk59ONLFa0u+HS6P6UmElmLUA0vXaryz+psWlsspl?=
 =?us-ascii?Q?yS4aOY3jh1Un4NP98zUaeSzmzaNAShEjVsB1T1wwKMvGVe4othZEsULjxfm5?=
 =?us-ascii?Q?Zdmywdvgf1LDf6V5Hy+CdeHsCoDhLZHkOi/F8wLfuuf46C/scGTurAu4orlw?=
 =?us-ascii?Q?AdpAXiYgrQFqXTTfJCE2kbBBUJ1CUXcATej5Hx5pwVeUSMwbpUTBQcmcWEt5?=
 =?us-ascii?Q?gVzoJGXZFJwFTOxMeWFcX3ryX1nKm2aUMWeC8J9PJbCZ93/p/BPPyqx6/TZW?=
 =?us-ascii?Q?pk7AnRM+bamu4+3UMOb9yG8HNbDuCGdo85jDgVawRogmjcm7LXqS5dTZXUpE?=
 =?us-ascii?Q?nhDLW+mfNKS0P7/KOm4M5VaqhweRtl6BAEdvP31cvEpYW2VdfXy/rTGddpGI?=
 =?us-ascii?Q?KPcLxbhgAM8oU4FimHbfFvE1PdzYwX4gB0Qf7i3n4B36XMoGkzPQS30eHEJm?=
 =?us-ascii?Q?XNQ0TK4hu4xTUdnTZL3eFJxBxSjAM1k84wfSdWb41WsYWGiXn5pLR70gQR+f?=
 =?us-ascii?Q?c+UrTuyBAew0HNAn8Yw193Qn9P9eEjZmh9Clcc4a95qNZTgGlIE0oWBfyNa0?=
 =?us-ascii?Q?j8iLfDSADtz2zjuuKAsKwz32OX8CB2NBd0Ib7cUeTxvFU+SEbrSjoeTQxNWa?=
 =?us-ascii?Q?+ZIfZPhC/7CAkl0UXVcVm4wgqnoiRmz0zfW9GhNGRhrE3KMkq+D1Zivxxk6q?=
 =?us-ascii?Q?P/Gi94HxOYXEHUvAz/tyzXVeLeN0ngAI90PXw+O8ycW58TyB0+B3XsP3fBjm?=
 =?us-ascii?Q?aDEQsDoCuClFnE6fLnmhEHnm05Xegy+J3Ff5f8+aAqW4EeOWsg+W4tOhjMc3?=
 =?us-ascii?Q?FLP2jUuOIhd+/tXdsfA8YMGDLpNBRCz/AUOjdly0JYJq/cNR8WpBIWM6C0ZP?=
 =?us-ascii?Q?cv+FjYAqSl0JvUInnb4VCkZvX3inoSuSqZz85xk2oIL9YxNQvSz/Eo8QKsO9?=
 =?us-ascii?Q?fVttoxSXvTzxQPtU0FPg/72znbxikIgaqbpmfmUaVkwN0bMTcql11HS+DgOk?=
 =?us-ascii?Q?xFCpm/lgJhj96giAl4O2nVLsADG58pPd6vP+OQtNXAiHeNTuGw3PR595+dIx?=
 =?us-ascii?Q?6K6QUKww3ClPQdL3/WkRhv6a9zQlmUhZ6Hb/TTUGRxYVeSvcj11gMyqHAYpI?=
 =?us-ascii?Q?rp0pJqzwjKjUSK4EjPRKQ5hWBb9Qhj2HzofzeNBBC5osdRrvqMuQRzzQEvti?=
 =?us-ascii?Q?YoYqmPLBqCMMpj9SakRe+A6DzrmjmRCD3cjtzgdG6yRG4I/i38ayI/Re5WwW?=
 =?us-ascii?Q?DmFjCaoApQ38x6oHycjz+MR3N5hArFpXgzIXkwquRTien3w0RHYjCphLroaP?=
 =?us-ascii?Q?BTl9DiVLbLZ5ujYnHOs0Kh5k?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 75590605-ed7e-469a-ab5f-08d978502aaa
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2021 13:53:16.3327
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XmggGou8+YD4JBp4/vOO1acwrUfudqQdUIMBuyXUDuaxQqEdUP2KPBdRQVul1tKSN0u8BbMz/DN57YKJTdS8EXMcDFonCiEZRypw6XY4x1g=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4513
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10107 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxscore=0
 mlxlogscore=999 adultscore=0 bulkscore=0 spamscore=0 phishscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2109030001 definitions=main-2109150090
X-Proofpoint-ORIG-GUID: M8RIRtdxM2IfkIVSjHm6gplxy2taXykq
X-Proofpoint-GUID: M8RIRtdxM2IfkIVSjHm6gplxy2taXykq
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 15, 2021 at 02:41:45PM +0200, Fabio M. De Francesco wrote:
> Clean up usbctrl_vendoreq () in usb_ops_linux.c. Eventually this function
> will be deleted but some of the code will be reused later. This cleanup
> makes code reuse easier.
>

Thanks for removing the URL.  This commit message is no longer bad to
the point where it has to be redone but it's still not great.

I explicitly told you to leave the irrelevant information out.  I'm
trying to help you and it's frustrating that you're not listening.  I
wish that you had just copy and pasted the commit message which I sent.

This relates the discussion we had about reviewing patches one at a time
in the order they arrive.  Every patch should be self contained.  It
should not refer to the past except in the case of explaining the Fixes
tag and it should not refer to the future except in the case where it
needs to excuse adding unused infrastructure.  Reviewing is stateless.
We don't want to know about your plans.

On the other hand, the commit message doesn't list the changes the
commit makes as part of the clean up process.  That would have been
helpful information for me as a reviewer.

*Sigh*  Whatever...  I would have allowed this commit message but there
is a bug in the code.

> +				memcpy(data, io_buf,  len);
> +		} else {
> +			/* errors */
>  			if (status < 0) {
> -				if (status == (-ESHUTDOWN) || status == -ENODEV) {
> +				if (status == (-ESHUTDOWN || -ENODEV)) {

This is a bug so you'll have to redo the patch.

regards,
dan carpenter
