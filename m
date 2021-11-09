Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 10F8E44AD66
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Nov 2021 13:19:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235061AbhKIMVo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Nov 2021 07:21:44 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:46940 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230463AbhKIMVm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Nov 2021 07:21:42 -0500
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1A9BpOfk017302;
        Tue, 9 Nov 2021 12:18:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2021-07-09;
 bh=Rfa64ZWkTAg2vTXReUA+awQtFJFTMKp4CcS+I+T78lA=;
 b=CQ3D12JcGKDeO2JFLATmKVXLamkxhv6wrDBBo7j57V73vhvsaSmnuRtVjw46kIt6XtEQ
 JeFiQ63jP8qRYjl8t1fZ7RHIyxsg9rsGMOZfsGFnJMQ6HWX8KgX5E76Q42LnGWUpfpZu
 u0WnidvHTq49zhGj9bTS6BVvfjFa9Pp0sTM+Uw2kY/qjibziYAcTS8UnRycXsfUpX/dZ
 TOi7DvOpPFmKly1+ooX4MJyi2QOBnQZmpcXakE2TQkzlf7KV82R+z1fNzW7LT0zq/UsW
 r+Cb0NaN+rWIcJi0c2PrjV4b0qmQ3sDupM5pgF6h05skfPbTsXJIgW2gv739dzbEgzTe SA== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 3c6sbka2qg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 09 Nov 2021 12:18:51 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 1A9CFNwn094164;
        Tue, 9 Nov 2021 12:18:50 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2169.outbound.protection.outlook.com [104.47.59.169])
        by userp3030.oracle.com with ESMTP id 3c5etvhs9q-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 09 Nov 2021 12:18:50 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HbaHzOhZrFpvg4nBrVu1u8lJbdqRnV6cmJP5xGsJTfMKQhSipPve3VidB199xiGvRg0dDgd/zF0WxYLc4GdTK2l/GqX4JVJ/9X88GZrgPjMjqJNeIm0X1K4fqdPOsIc5WVNlBYNOS1KbQz/ZpJbswBV6PZVJT9iQfTJqe35XHj6ZzTIlL3jxj4aVOKuk0Gd4+aNF5JAijkbii30epI/U6HC98z3UVrckqyrZ0R4wXWrNc5L6siT3JWDS2xLURPnLmxM5CiW+Vm2hw4VW6/yxlb0sL2fRgHWgH+52JgmLcXTh5sIJbUyS2GhzfXz/uQyxYowwixZjl1F26Hi+RarAPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Rfa64ZWkTAg2vTXReUA+awQtFJFTMKp4CcS+I+T78lA=;
 b=Ra7H5eiI0Th6byLFm8/GjGElFK/Jbsszu8JGFz7Bgj0H6yWZXvcNFkuVOYk9i7Hb+lEprkXE2IO9abxlcRLhiQ1Ob4PTKGyOpBtopkvdZoyeKnqhCTpO4ZaGlU2bKJL4bJqxteTj6pBqd5VnyQwccNm8eGkPJ/ldU2QiCKU2tctrr1b9nL5QteVnqzfAHqovW5krdi4kyfqL0us8oAObh84e8P01sZvtj4jGE89tCpHc82PR11orEiQotZbyziqz/Q/47HeX0ApqdVEKwUviCguj3+OR+JB9GwxEJsPNQDT1J+h8HcGq5Z9r2Cv9iXRt1u2WvtiKd+1dZeBE2pDhRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Rfa64ZWkTAg2vTXReUA+awQtFJFTMKp4CcS+I+T78lA=;
 b=A0WqRDudt7b/MhRaCLPI7PqTbMXLpNxC3Zh6juWfrmDeV2K20zKXn1+X1u3qUClz0QlOGSGdl97C23fu40G9ABiI0al4/Cv8ZQO38AyMN/JvZOO4UscmM7tbXN1XGf2dHJpw9re9CWYeu2HkUZbyCRRiEtxSjKYdjLLErAUgIv0=
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=oracle.com;
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by MWHPR1001MB2095.namprd10.prod.outlook.com
 (2603:10b6:301:32::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4669.16; Tue, 9 Nov
 2021 12:18:46 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::d409:11b5:5eb2:6be9]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::d409:11b5:5eb2:6be9%5]) with mapi id 15.20.4690.015; Tue, 9 Nov 2021
 12:18:46 +0000
Date:   Tue, 9 Nov 2021 15:18:24 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Pavel Skripkin <paskripkin@gmail.com>
Cc:     cgel.zte@gmail.com, Larry.Finger@lwfinger.net,
        phil@philpotter.co.uk, gregkh@linuxfoundation.org,
        straube.linux@gmail.com, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Changcheng Deng <deng.changcheng@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
Subject: Re: [PATCH] staging: r8188eu: remove unneeded variable
Message-ID: <20211109121823.GJ2001@kadam>
References: <20211109115307.133100-1-deng.changcheng@zte.com.cn>
 <c2c36a95-be34-bcaf-0224-a513e33a902e@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c2c36a95-be34-bcaf-0224-a513e33a902e@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: JNAP275CA0024.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:4d::15)
 To MWHPR1001MB2365.namprd10.prod.outlook.com (2603:10b6:301:2d::28)
MIME-Version: 1.0
Received: from kadam (102.222.70.114) by JNAP275CA0024.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:4d::15) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4669.11 via Frontend Transport; Tue, 9 Nov 2021 12:18:39 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: daf6f80f-4e21-465e-c926-08d9a37b13bd
X-MS-TrafficTypeDiagnostic: MWHPR1001MB2095:
X-Microsoft-Antispam-PRVS: <MWHPR1001MB209558109C67FF670D310C7B8E929@MWHPR1001MB2095.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: C2swS2KL2XY0j3u9jOC2254+HJ75tuezm0vzr6YpouG9HXaEGvpHocaYbo/RuC3UGLnpNlPyAuqHgbUa4r/D8LEQgI8z/Xv4euCHXv3Q27IUqKK4uhPRNjE5MqTnehhDDxGAWeTnAR0sgIEQcl4I+qAmQ2+OssxRWoo///KPthUojYaw4y4674TKfqr9ZHUnanlNw031FZI6uAqxoOLYxdF1566U4+WROdbqbVhSPiGbGXcaznhFb8xNZhffgJ4jjFQesxr8y9IJlTF2NeZXaJCcn2PBbqKSy5njuewrl0jDvhdO82Xd0/UQuT8LawCOVWjTbP5Vbl0MwkYwnJW+VlOSYPEfbqNYMhKNBYtm6uxZAVL+nNgGv0q5AuUEM1U7YDN8UMwFLWKREDQo/feAGgDHRKu195Voi8J1J6ba/srN/QLjBbtbJXWKxBAtZWl0Zs05PiQHZ8d7TLm3YURz84tV/9J5vOl5oM09R9hP3R3ETbYrGDj9dyuGGOl1fqntA5RJY0Rkj73JD+2LkU7dR748fKRg4NbTvr1hvpXCSXWcMLZ764gORA3NZuDeIY4SFZzXAL7TeJAZzkQ/A4wftImwgAMm14XA0INlDmXgwNECzxszMTPuMmsV7kXEVbL+sIJbRTJOFY08KvxNIGIdyPYHrT+PJs5NPbmtSxC+Vo+w6vSPBBj52CfSIixYhxPy2wud101JgXjS8XlVLLKjQQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(6666004)(9686003)(38350700002)(55016002)(8936002)(33656002)(52116002)(186003)(508600001)(1076003)(44832011)(33716001)(956004)(83380400001)(6496006)(316002)(66556008)(66476007)(26005)(86362001)(7416002)(9576002)(53546011)(54906003)(8676002)(5660300002)(66946007)(2906002)(38100700002)(6916009)(4326008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?/+qtEoie6CsCRktAjdLydqosY0aB+rqexyWnOMmiNz4zMo2tKt82K0R6kxQK?=
 =?us-ascii?Q?j4LC5kb8T1f4dJGO55032ERU2CygWxOrwTDCEl3dGvKQV9luP3UbkC7XGwNm?=
 =?us-ascii?Q?gYwDUJsYtc26mcJP6Gl6Q0QUmM0OrLEJxmziQi+0s8L8zc2FZwBAT86R7bs+?=
 =?us-ascii?Q?oN7yLwNRmDx0d8vLWUsMO4hqN5ewI4GZuNE87zTidEzFLlCDTQA3fZeXGuzN?=
 =?us-ascii?Q?B7z0qbM6n4Lzrm6AWOWm03sb+iaC1Kd/nRE7PUhffuyhdcdV0bMP6CytGQmK?=
 =?us-ascii?Q?qKVy7u6wulgZXAFz5j4+eRzdUXKVt92u6YaUxUXcvJ89ZbzalyV0lZNkEhhe?=
 =?us-ascii?Q?RrAswPQG3+XVGjmHCLAULg6uwoNAcZj0pErq1QAbD9nhxI6YtkWPBfmONsH9?=
 =?us-ascii?Q?vPCzyO9RBPAXfcZo3jGn5W941/I96x74iYT9K0E5Or5Cm22QjY8da5BoWEm1?=
 =?us-ascii?Q?XywEOZ3GdZjuOJXQOhiGz29T/RhWm609AyTgY1CREu56MRSm+ZEU897uc+ls?=
 =?us-ascii?Q?F4NOV6Gn2bX40zQ8t4rkdcNBmdQUHrKnQl9fwCEd2BbXOe5uEJSisEC2ZCSS?=
 =?us-ascii?Q?vwF/8VaMTA6md1nzS5Iy8tTu/OKf83olDYB5xhtpP3M7diijIpGxfT3hVbtq?=
 =?us-ascii?Q?FlgPA4aGOn/XWE9Zg+lNJ+6Y0kHFZQayXcW3ZL/eYXGXuJEOFlC4VYH7UUs5?=
 =?us-ascii?Q?8yjdhKFB8NrWKChcLliM/DN38N84hypY5ABHL36DNwXjO96y0kvl9BAFWjIu?=
 =?us-ascii?Q?eYS94dQwaV9T7hGshi9pAZV2kN9T/Gq/w6OOH+QIpon5ZiKNXZcaUOYAz7ol?=
 =?us-ascii?Q?KiAdGdwYUWkKxr3ETUuH+L4G4RfLWBE0oC0Xd/R+V0gnk5LSnMDmzLmNP/wB?=
 =?us-ascii?Q?YppDPP2UzLcT2jIGPzODD5E4sE7LNkhnIpyHB3Dwb9X+Gcy53xLOxFt0mEie?=
 =?us-ascii?Q?A/44FcrgnW83UpAt8XLHQmQ44obPOZXSqk1beaC9uVrPu3YCxoqyETwCuOO5?=
 =?us-ascii?Q?TR26vc2FNynTBo+NSWNT2OVa/6q6t/DF0eue9pIbOT38OULXuyKNUl5OPH+g?=
 =?us-ascii?Q?LttHdoVIzOMN+V/k2wJJl3UuzUDaYG/u9WTNYROE195IeWZ5PcIVM2vrp6Hu?=
 =?us-ascii?Q?7eY05LIa+YIuu2U4nIZ5PZY1pKbAU4HzBMHQKA/y9smX7StJ0bW9g+kBpRI0?=
 =?us-ascii?Q?hkKtp8xgwZ+x65+IcGuDSSzOycT0XTUk/ktqdBBocOgxntG3MXFami340gqw?=
 =?us-ascii?Q?3I3zZGbfxcuMY8kIHDGvT//UL1/Yrajq74oBwYKbi5/AHdbVrj738wV4YHkN?=
 =?us-ascii?Q?gWUARp5o+NPMTZX9NfId62koBPE+Twq8BdWNoF7qmdwMh1YVmJ9lRpqBzOWv?=
 =?us-ascii?Q?YMM3bZhEsfV8ftkUQANoVdcV/mPM3PO1/WDNBFFCOog2JwzgsI4hdxGvvDHr?=
 =?us-ascii?Q?qo1+8Z9CuDNMoEHJeKz7YooxSg7J62UAk4+4b7OnnAzK/vbPmgl3gdpuQ841?=
 =?us-ascii?Q?GkJ/OMQNtLcyGw4K3QEVrSD17ZEuwvOt8CBusZjKPGQsw+7iy8hAb2tYj83g?=
 =?us-ascii?Q?ACLBPDWr9HyLi7vGrU20f9W67rMU53QUtVHYvQmiTx4WHfB0HwuNAjq7fLrX?=
 =?us-ascii?Q?FkSEI7Ds+BhSCjvuwxASPF0NEI+It+4cWG7lwyOWe0+xvM+XdGz/ck7zXM66?=
 =?us-ascii?Q?B3njCzjzmK8yW0938devk1EK5dY=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: daf6f80f-4e21-465e-c926-08d9a37b13bd
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Nov 2021 12:18:46.0643
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oDq3oDExvPAAwP7ZGN9Q/RYSBvbGUxR18WImbOHIaso0EwstXDFPVnxA2ReRUzl++8xzg9HJOO+X9dUEwQF8pcvFy9hdwuFjLA98sALy+Vo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR1001MB2095
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10162 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 adultscore=0
 mlxlogscore=999 malwarescore=0 phishscore=0 mlxscore=0 suspectscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2111090075
X-Proofpoint-GUID: yHJ4cHaZbS4VrDNurQPPCGy9sER50hOR
X-Proofpoint-ORIG-GUID: yHJ4cHaZbS4VrDNurQPPCGy9sER50hOR
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 09, 2021 at 03:09:21PM +0300, Pavel Skripkin wrote:
> On 11/9/21 14:53, cgel.zte@gmail.com wrote:
> > From: Changcheng Deng <deng.changcheng@zte.com.cn>
> > 
> > Fix the following coccicheck review:
> > ./drivers/staging/r8188eu/core/rtw_cmd.c: 66: 5-8: Unneeded variable
> > 
> > Remove unneeded variable used to store return value.
> > 
> > Reported-by: Zeal Robot <zealci@zte.com.cn>
> > Signed-off-by: Changcheng Deng <deng.changcheng@zte.com.cn>
> > ---
> >   drivers/staging/r8188eu/core/rtw_cmd.c | 4 +---
> >   1 file changed, 1 insertion(+), 3 deletions(-)
> > 
> > diff --git a/drivers/staging/r8188eu/core/rtw_cmd.c b/drivers/staging/r8188eu/core/rtw_cmd.c
> > index e17332677daa..1b1c47f4a34e 100644
> > --- a/drivers/staging/r8188eu/core/rtw_cmd.c
> > +++ b/drivers/staging/r8188eu/core/rtw_cmd.c
> > @@ -62,8 +62,6 @@ static void c2h_wk_callback(struct work_struct *work);
> >   static int _rtw_init_evt_priv(struct evt_priv *pevtpriv)
> >   {
> > -	int res = _SUCCESS;
> > -
> >   	/* allocate DMA-able/Non-Page memory for cmd_buf and rsp_buf */
> >   	atomic_set(&pevtpriv->event_seq, 0);
> >   	pevtpriv->evt_done_cnt = 0;
> > @@ -72,7 +70,7 @@ static int _rtw_init_evt_priv(struct evt_priv *pevtpriv)
> >   	pevtpriv->c2h_wk_alive = false;
> >   	pevtpriv->c2h_queue = rtw_cbuf_alloc(C2H_QUEUE_MAX_LEN + 1);
> > -	return res;
> > +	return _SUCCESS;
> >   }
> 
> Shouldn't it return just void then?
> 

There is only one caller.  It should be folded into the caller and
deleted.  Then the caller could be made void.

regards,
dan carpenter

