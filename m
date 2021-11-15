Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 62CCA4508DA
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Nov 2021 16:46:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236633AbhKOPss (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Nov 2021 10:48:48 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:30212 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232412AbhKOPsT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Nov 2021 10:48:19 -0500
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1AFErPkW005202;
        Mon, 15 Nov 2021 15:44:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2021-07-09;
 bh=NjDarmpmA/1Ag9CPixYPa4TxvXbcYwxVGVzhc6/vHJM=;
 b=kbTQjciFVOe/btCXTZOCKre3HJ/ZFSJiA/SkYUsYn1TszySyfsFwbUMDPhiV/3lfZZYT
 Fm0MCqiRnvC885KKvMOnjd9Of1/yiObzwSs6C7yoilT6rkNR2Ebs3OTz/+EepHLxtA8E
 AhxijTVhzkMYykh1KU8fp6wOyZoRHSwythDSRVmw9K2n+AUc63R1gQTnfN9TgHgx88L2
 MqVcaHBEMn6VrIKu7q7ppONpAKfiltDs26JIqF/C2TxdtvaWBzq3/5dqF4+AS70Kb8uZ
 tD306WIxsKxDAcMO9NFb7NfGmLQJnSql3pz5nvwlaKof5R7id6VYQExrC4J+9T4Ep27G FA== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 3cbfjxkd94-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 15 Nov 2021 15:44:46 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 1AFFUGBi063238;
        Mon, 15 Nov 2021 15:43:55 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2049.outbound.protection.outlook.com [104.47.66.49])
        by userp3030.oracle.com with ESMTP id 3ca2furdym-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 15 Nov 2021 15:43:55 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HyNclwSiQ9YC+g/Ge+QdPIH29mPridgfK7dHwkJUltRHZbZ7fo+F6kH8G1uNoBV1SIyPe4j6VGsz1lYLnlbUQrnKfgvSTeHWLOZlpM2oAtFAj5OwXvEVyrgNMPsXkmGWcnYwfK1q5wFGb4jG+hsDYNarpLJmfIwS37y5/+rfzz49u7vsb9GKLSLOH6LkltoIFc0Tx6e2Wv7lj0Wyb0lb3WmEhpV2NHVhmlZQ7fvFfhEDWHYPUd8ENV8OrIYXFR9rqODaSILWJru4hF0qXsWqwbZDgAKy7PvBUcqWgGZdqOIxDTbD5ov0EpuHzeZzEWTfmhfoHwkT+sXj4sUiNJLGxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NjDarmpmA/1Ag9CPixYPa4TxvXbcYwxVGVzhc6/vHJM=;
 b=APmmGTP8o/MHZCTuyyGVpZvxi+40hud/bz7RhH/ACnvenIwwkAaN3AFlWkvrUY4MzZYDx7LXBW7Je28wRRVzjO1wZKimhQ7Im1rZdgdVrQSqkcsObiesO99Wsgd87esmyoEfP1Pxpu+fUA8q/tHAxZEiOQRStf4KhPph7uHmRkqFTbjSt9bBsEb+ERBta1U9VZUQM+JeTyVsqg+KcSU3VZO8MSM7aAr/nhXRdw0LbrLCzacb1hKRjCFVuiFO+aayNN56kpGpN2MPb4se4+uaPw/vJSOhEy2FK4h86dnbh2mlP1Mo7sbt8TF0FPDOP6zFuoFzfSVMo7uRUuk3fPdyzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NjDarmpmA/1Ag9CPixYPa4TxvXbcYwxVGVzhc6/vHJM=;
 b=bm0Ts4QeyIgulPijwuYYHZyGbqmgm3+YsQDLBSOg5EIfMIgGqgGGJFUxHyQryYvgp91KnLaffXzjEMkXek+7FW1WzB53BBJ9Rkb7R3WpaYOMGA3bZlWLpFGaMQMrcbYV5ma2OUSLYdNZXKgcclIZaDYH7HOhtnCBulXvkyigUzU=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by MWHPR10MB1296.namprd10.prod.outlook.com
 (2603:10b6:300:1f::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4690.26; Mon, 15 Nov
 2021 15:43:53 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::d409:11b5:5eb2:6be9]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::d409:11b5:5eb2:6be9%5]) with mapi id 15.20.4690.016; Mon, 15 Nov 2021
 15:43:53 +0000
Date:   Mon, 15 Nov 2021 18:43:26 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Martin Kaiser <martin@kaiser.cx>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Michael Straube <straube.linux@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 03/15] staging: r8188eu: remove test code for efuse
 shadow map
Message-ID: <20211115154326.GF27562@kadam>
References: <20211113185518.23941-1-martin@kaiser.cx>
 <20211113185518.23941-4-martin@kaiser.cx>
 <20211115112748.GC26989@kadam>
 <20211115135044.zzudkdypmgivfnko@viti.kaiser.cx>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211115135044.zzudkdypmgivfnko@viti.kaiser.cx>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: JNAP275CA0035.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:4d::19)
 To MWHPR1001MB2365.namprd10.prod.outlook.com (2603:10b6:301:2d::28)
MIME-Version: 1.0
Received: from kadam (102.222.70.114) by JNAP275CA0035.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:4d::19) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4690.15 via Frontend Transport; Mon, 15 Nov 2021 15:43:47 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2251117c-af1f-40b5-8519-08d9a84eb9ed
X-MS-TrafficTypeDiagnostic: MWHPR10MB1296:
X-Microsoft-Antispam-PRVS: <MWHPR10MB12964F92D0E15DB735B853488E989@MWHPR10MB1296.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mXdHSTW3ALQKsVRwbwHvSiDJTgRef8hdVmjwyoYCvbkeSMfF/iHYUE9xodxbR7WA/4SKTmp4Sg0qQPQw6qVpBWwGeduddtqCMg4N7AjidjW480Ioec343FIbNvBbqLtnJTr1w2ljamDueK4zFjOsTJOmt8J/oOyrpRtowRNeATYvJkMI7Ps7KVqNhNUL59lnHI1/fjhYn7Mlol4fV2GuIWu+gW2fxXzFZmbP/C7NMx1K2+ViX90AF4X4NugOKHtLrT4iqnsJS5XQrHjKqc3YbpbSuVjHswsaftbw/NVsXtN2Gr2Wt5f1YwKMN1FdxSFxpG42ANqXpd51VxDCc3J1QG9MpC4VN3E0QZgbEO3/GLpOxl8zFfLDRks1LB814drqaidkA/lNIidLp0ucAguh1i63WXqFU1Qvwhs9bBZdHrSHjDtey08cdycB81JwCsWZ0ftdGyILxAPKZuuRXsyiDlbVK90ueX6iIQ/n00fu2m9fieteAOi7PJRb033d0hgOU+1kFfB7LI5pH53KtLeqWwnrPus8rpQ5Quu7zNJMmsqla+n/SG0N/Dq10ITT05IUgJ87WVwP/EZBAz8W4iEPiy1xpSGVbFWuHJ5LpONpj1JMTxSWlbwg9QAs5WMEpsXKnDE6IXmNcQPEGFucu4ZltP7e0j/AZyjsRbcOQ8fDSQjiEbwjQl3VbQl5h5t3TObTdWWd4MRInKebgMnUzzR67g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(6496006)(52116002)(44832011)(55016002)(8936002)(66476007)(86362001)(508600001)(316002)(186003)(26005)(9686003)(4326008)(2906002)(6666004)(956004)(8676002)(5660300002)(38350700002)(38100700002)(1076003)(33656002)(19627235002)(54906003)(66946007)(33716001)(9576002)(66556008)(6916009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?JoG6w+Ty1IyFiropmMXZdsEiciIi5cpSnmEjeMNE+PzS7ir1EdWbLxs/zzjk?=
 =?us-ascii?Q?iTTs/oZsE25ltZnwbAMS3sEWAYpMw2OP0D+ZUtRCmSOq4OKUyEQxVjXv64As?=
 =?us-ascii?Q?mFmkGUdzGtfnYVZ0W2ghqGLlRoekE0Xgj5bPMjumKZoH3JjlKVUtGxQ2+r/V?=
 =?us-ascii?Q?ZZUKprfnUDCa0FZwoF9vxeuox/1+/ytKO1NgfQXkKa7Ghjyu1AdpOB9wT+dc?=
 =?us-ascii?Q?2WAEsPgkEe2gWWrDH+7p7eLBcQrIJp8j14T71ttlbM1KrSX/VhxBqVDEB/iz?=
 =?us-ascii?Q?Zh9KzQEMJGWLesoQOqZ0GvlyGwZShUG0nP/kIlTOMHlooHeqY6oHevaEObMZ?=
 =?us-ascii?Q?I4N7jimTuSyDzbPl5L9RmNGD6z0MhrInpCEtAXSTzmyc275iKY3pn3zoDiKF?=
 =?us-ascii?Q?VSvjqGZo6KrQzcMBBeFjWqQqkIZaX5wVwwlBm58PbR4XpXAj/ke8WxtRZa3f?=
 =?us-ascii?Q?d8WvUio1gbfPqf1BfhUZdQ+4u1pmuRuOZBAgSkGTdzHQJmmxmV3+P28yRhTn?=
 =?us-ascii?Q?WymdK/IYHxBIVqNAITdJgTiZwUywvMZH9AwdoHtNiLWSNZs0RygDQn7OzPDI?=
 =?us-ascii?Q?RcaN8wH2PIpipr3R8/xnGov2GKn0sYgQxmfrSC3jxvz3rd1MnhuLo43YKJZQ?=
 =?us-ascii?Q?x+Y03q8Y6enaKgcXSBoT4pA0+NdLzODZ/McW2r+iFmTtTcvgKuyGqi53hjel?=
 =?us-ascii?Q?rqMF8qiASocX4wiSVfjM5xUBf1mHbXR8Fuf5GiS3drOM/UaXwSG5oct7/NDw?=
 =?us-ascii?Q?0i433J2IrGsjJoWIn0MrjTeojS/QE769uoooFD3ewV6Lo0fHibFHwkXNUyGP?=
 =?us-ascii?Q?MA3sJHD552tqwC4cJkkXBWeDBJ0QE9PNa5hQ8nbLIDPIrnIM727v3HDkyyrG?=
 =?us-ascii?Q?97BzgdZT/GDgM6L5x1A9cet5VcLUQo4duxBGasXL+DFrdXPEvZi61polqOAR?=
 =?us-ascii?Q?1L+5yIUQ3spj9ylOmPqj7vXIiLV95GVoHNJBlxiCqLWOEJt6/2gTxSQ7cVfi?=
 =?us-ascii?Q?xSN0MrhdDQgShgsZmIYaAR/MAEgoQqXCWNTLYXDN1vm0kHsQlRfcGPMkvFfn?=
 =?us-ascii?Q?tTfEzaoDuTMak6+BF3f8WCqbf2FfUiAU5r4+zs4Uho9FaO/yJ4VAXGyxQk02?=
 =?us-ascii?Q?hT0zvCkIN785l7oqya0wJOPuX6zj2ThyOIL36ull8IIiR/LFDjSZeTASIu+z?=
 =?us-ascii?Q?64dQQn2HXz4sI+p4nl0uilCSmFxCFlzBVv3+5BqUJiUgFbgg78UcvlIbpMS0?=
 =?us-ascii?Q?f+2wN/QMMVSbg5bd3LG1QNGxEBEOb7dsZdcVHJkoh1xA2CrFTk7NH6l/fLgq?=
 =?us-ascii?Q?Z+yaCfMYsiN2k6zJ+UmUozDN/woyrFvnYWkC9U/zzHw4XxItPQmY3tZJNHJR?=
 =?us-ascii?Q?bNduXH4bkzqUTBte2B5qXPmdcFQBc/hjvDqdAbZE6LabcZx/4FRIaaN+q+ET?=
 =?us-ascii?Q?35s2jU/JSH7OBb97Cid+2kgEwdsaKDMIjxOYQfJgsJ8f7/6LQ22iSBUYPa0d?=
 =?us-ascii?Q?kEyhHuVEdRk8Sn0LeKBMIMpX7kB/mwItgc0TM54QjIRk/PinfTJ0W3IRwrPc?=
 =?us-ascii?Q?RSWUorjk91Jc/WHAp+YaWCIt0LnT3VXX7KEEA5FQwaIlwc0t3me3tNuq2Sxw?=
 =?us-ascii?Q?kpWyQ57Hnw0fKO1oyx1beCkG5x03PAdZxZmvZ+jiQRWeclt5Rt8fyXtFQ/yX?=
 =?us-ascii?Q?rWEdQbk8DdHKXQNlGYuZIy7CKQk=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2251117c-af1f-40b5-8519-08d9a84eb9ed
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Nov 2021 15:43:53.1941
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RPTjrY/atH0lpxrtbzVcKrQK+L3h43N+DeIBc8eYTyCPpKUIUPwHnoHoi4VLfXmlsZUUylcmBGcDDG4VV7fHVYmMlm/PYfGgIK4goEUkq4s=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR10MB1296
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10169 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 phishscore=0 bulkscore=0
 adultscore=0 mlxlogscore=999 malwarescore=0 mlxscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2111150082
X-Proofpoint-ORIG-GUID: Tn36FnYER4Q7UV7D-SUfe84blk8Q5iRa
X-Proofpoint-GUID: Tn36FnYER4Q7UV7D-SUfe84blk8Q5iRa
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 15, 2021 at 02:50:44PM +0100, Martin Kaiser wrote:
> Hi Dan,
> 
> Thus wrote Dan Carpenter (dan.carpenter@oracle.com):
> 
> > On Sat, Nov 13, 2021 at 07:55:06PM +0100, Martin Kaiser wrote:
> 
> > > -			if (_SUCCESS == ret)
> > > -				goto exit;
> > > -		}
> > > +		if (_SUCCESS == ret)
> > > +			return;
> > >  	}
> > > -	Hal_EfuseReadEFuse88E(Adapter, _offset, _size_byte, pbuf, bPseudoTest);
> 
> > It looks like this changes how the code works here.  Originally we
> > called Hal_EfuseReadEFuse88E() fir rtw_IOL_applied() was false or if
> > iol_read_efuse() failed.
> 
> the call to Hal_EfuseReadEFuse88E is still there, it's below the part
> that you quoted:
> 
> -       Hal_EfuseReadEFuse88E(Adapter, _offset, _size_byte, pbuf, bPseudoTest);
> -
> -exit:
> -       return;
> -}
>  
> -static void ReadEFuse_Pseudo(struct adapter *Adapter, u16 _offset, u16 _size_byte, u8 *pbuf, bool bPseudoTest)
> -{
> -       Hal_EfuseReadEFuse88E(Adapter, _offset, _size_byte, pbuf, bPseudoTest);
> +       Hal_EfuseReadEFuse88E(Adapter, _offset, _size_byte, pbuf);
>  }
> 
> The removal of ReadEFuse_Pseudo makes the diff a bit confusing. When I
> checked the patches before posting, I stumbled across this part as well.

Oh...  Sorry.  I should have seen that.  Thanks!

regards,
dan carpenter

