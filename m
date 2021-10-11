Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 60E21428D09
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Oct 2021 14:31:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236617AbhJKMdE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Oct 2021 08:33:04 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:29278 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234689AbhJKMdC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Oct 2021 08:33:02 -0400
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 19BCMPPD010472;
        Mon, 11 Oct 2021 12:30:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2021-07-09;
 bh=eatjUpetrHfdi3WTHD5gtQG6XeqdQwKr7Y9HWTZVseg=;
 b=y9nhqFgD3+AaRjFfkMVa21OO7FiEDLvZThqwdgrsGbdgX6uT+BFvT0ILaFlTQJB/VfTj
 TC9bdF8uds0LF9JzD5bN04xILiNeV3t5JFEuXwfeinQZoALnh7ATzmgcH40RagVdRByf
 g/h5wrXkUVlUqK2UjLfHHL1O8j4iCkenT8zWiKcuN8CXn+MFQFDBKjMePNTcqx6vWF6/
 6R5Z39J4N7bwMm1/zKi1Zpl0K0Xajww2sA3IHVV1DX8uNDPkigtAwCaM8EK9SFkIBOLd
 xs/qa2kgFejDsecGCXXy+8mTRCtnXYwwn9ETkjSb+8I7aZdGSG6cAu9jxgpbxcMruyOG Dg== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3bkxs5bta8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 11 Oct 2021 12:30:57 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 19BCUtij191107;
        Mon, 11 Oct 2021 12:30:56 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2107.outbound.protection.outlook.com [104.47.55.107])
        by aserp3020.oracle.com with ESMTP id 3bmadw67g2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 11 Oct 2021 12:30:56 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iHz2/kBqEAZBpjcGOem2s5ctxeFZSSzMvK5aSvS7MOlqFNx9i0Cw6LSzwqbHeBXGiGW9yVi5THlDxjzehk3tC4x+L7xT/lBmH69Yay5oOCsw5Dm1Ux4Jd/QVEQGSo2LVAkOimX1nlZIDacWg+uhhDtCzDaHMAyblJ3nRk3a0ez/w5FFF2ftFUGJ/tOng+VvilSxQMSOymIVLKV0CekWhlOkkQsIDUrPfirRGMKRiQys3cwfI+Fp9wM2FTt0MTIDandFw8oZcJfXwfj0+ICpKh+QA36MnUQSAD9bwpgzFFXdbEImSGX0ljoxRHLt9Qg4mOJ47zYtvNM9hcy4nANPxrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eatjUpetrHfdi3WTHD5gtQG6XeqdQwKr7Y9HWTZVseg=;
 b=aDWhgq72uVZM7En+Ig2sUH6r0sGa9wz4Z6Ng4AeU+ppKuC13C6AAKuYn6mxVUghkHLoHLZuIY55EcIMjMRF2xYHvX7KkmXA+/xkCr/aDmjzP9HlLDIRAf8RluF6u1nsKI2l7MTsSZUy4TAd6UPxqZCXIn/vHSBZlfhbsmVYiYYiexDiDHBSnE767chaG3nN0CK1QndKXd/BD4LkUIgHldOFoLRAxWGkBR0aCRluLB1HcwchWl4wTXPMdygo8ikVh6cIqnZi9m/7E+nu8JbMtSw34lW/GVP0yEZ1NYxO8I1FKyTGpK2kM8xzsPLnrtM74G+GlTHLv6ZmlELJhOlNf1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eatjUpetrHfdi3WTHD5gtQG6XeqdQwKr7Y9HWTZVseg=;
 b=GYD77HMvM6uhH8iGTirLC1KlIUcRtfhB+7Q0nNQL73+UzGLPv4wM9dGCWD7Q4Oya4Vc4ug5yuaqNuibSwtHI+PaKaot+1eQmCWiTNIZIM7FwrzC3C+O++NHUFysYIFDu099uGu2K9fQWXhADVCjKJXfqWfjjFCAz3SfPpBLHngQ=
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=oracle.com;
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by MWHPR10MB1773.namprd10.prod.outlook.com
 (2603:10b6:301:8::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4587.24; Mon, 11 Oct
 2021 12:30:43 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::d409:11b5:5eb2:6be9]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::d409:11b5:5eb2:6be9%5]) with mapi id 15.20.4587.026; Mon, 11 Oct 2021
 12:30:43 +0000
Date:   Mon, 11 Oct 2021 15:30:25 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Saurav Girepunje <saurav.girepunje@gmail.com>
Cc:     gregkh@linuxfoundation.org, fabioaiuto83@gmail.com,
        ross.schm.dev@gmail.com, marcocesati@gmail.com,
        insafonov@gmail.com, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org, saurav.girepunje@hotmail.com
Subject: Re: [PATCH v2] staging: rtl8723bs: os_dep: simplify the return
 statement.
Message-ID: <20211011123024.GB8429@kadam>
References: <YWJ0vSrgsiKK7suE@user>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YWJ0vSrgsiKK7suE@user>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: JNXP275CA0020.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:19::32)
 To MWHPR1001MB2365.namprd10.prod.outlook.com (2603:10b6:301:2d::28)
MIME-Version: 1.0
Received: from kadam (62.8.83.99) by JNXP275CA0020.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:19::32) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4587.25 via Frontend Transport; Mon, 11 Oct 2021 12:30:38 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3dfc38dd-228a-4ba8-a4f9-08d98cb2f166
X-MS-TrafficTypeDiagnostic: MWHPR10MB1773:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MWHPR10MB1773B047E599BB54D5493D0C8EB59@MWHPR10MB1773.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2089;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7iCIF9iTBMFxIQjJoNfhTBTsYAbcuxGgOCgGzwb2XSUNOua5/2t2YxELii+zrk1TW+2rypXdizP5h7AvtmPpM5JtKEsXnHUtnfU6IVAI6ZXY8TD8DrodUI6GY068o04cypZgCjemzhKGLJgS1N0bvXnZVl2yrDRwRV8fq9++pZ8Hl8Yn/MmF6Y4/SYFM9ApnmDuajQax+1l+/8PdAn32X70atJ+HWMvHcdxpXwqVoLTRt2AADVnxFJanz7atqWvoxYBTWc1hS5XJnb8XSqm3G7V2eYfE5CrwKmqSNN6tchAeMVEpWzQ3OlZ+I6UfrgitG7frs5uvLeYxyHiMd4I5T3R6tu3DxOuyG+TXhIEi9ay15b27XDZAEhQDHucKtoXRcOZUyleqdfwFXdksvk7tmOPqQhCI22jd/FoURMgXwJEbwdIyoa1mlhkwKuK2OUM1TcqdJ8LaCY2B3fSwAAEa3BuerGA+H1NpibyQzvt/1xAnBqMvUaRvN0LN2zhzGYjGGIdpVq4bHn4PMckwJWM7TQ2jhUVZ4wnyvmEPzySxXfiW4ok8VD5DPR0RWpQD5zk1I1mXdO4PAd5jl6JVsDQ0qgEWEnC9mKkWlpi2cVEfnozHyCUode/MWpeeuId6AIZgfuUiksePzAZOPsrA7mWFkaKDKqTeVkyQ6Qae611UcEBixnFvKau0/ivlWOOyHOgcl3Q343Nms5KrrG+o9oTT+Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(33656002)(956004)(26005)(6496006)(52116002)(508600001)(2906002)(1076003)(316002)(33716001)(6916009)(4744005)(5660300002)(38350700002)(66476007)(44832011)(66946007)(4326008)(66556008)(86362001)(6666004)(38100700002)(186003)(9686003)(55016002)(8936002)(9576002)(8676002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?vpWVCVSd5M+7NXxUobhS8XklctAG+PuTNQgxy2ahU2QRlFKBANYpsnKeuf37?=
 =?us-ascii?Q?Qr0rpFsPbJaloFr0H1+M0uy3KS3XpOkOhHhr53eqGMoFvquyhA22MqKQ7Vs9?=
 =?us-ascii?Q?MEoIseJPrjmzqTsOT+ioCefkpU1Sbs0XFrzi64akPnOH6bTit2YCKFUIwrUD?=
 =?us-ascii?Q?s2Zj1VE3wsomuBTJJVniPIzrpMC50pr1iSIIrMlhkNTQClQlfRTvs6q3A14g?=
 =?us-ascii?Q?sqarOtV3umwQ0oE1dmGnMa2SNw93QJxm32xQlPgh2P7yRgigWUi/X/t+BtvW?=
 =?us-ascii?Q?nY59NOCNPYiN67mm0RUzCWaLQFYN08MfwjuXYl1tAoTpsNZNACHyvgFn7QLR?=
 =?us-ascii?Q?E8hmGPoe2JIPh4UhF+3DoAL+PuKDQBmCIEwlZr0ANUXeRlk4RAm4UpM/+hHd?=
 =?us-ascii?Q?wYYMkHLg699Asmn4HLaulcBsTqjw0Pc7+YT2jbNUa5Q4oD5RrGVf1uG4YeIe?=
 =?us-ascii?Q?W3wB4rDFZQ4t5vjRP8nz8Ohsi8cGY3GC9dQuCQpPtUEw1FWg+rcZOXC9x9ZL?=
 =?us-ascii?Q?03ceDk9p+Ujyg5KAyjOa9FWrMh1DRf6UcH/ZaoK4xdbZ6hY8I7qDojkjYbRZ?=
 =?us-ascii?Q?72XJOsHiyd7n8sSmCSxN2UctaixD/KbzqVR+iFWbeynAzQpolMQ2ptRA9JUg?=
 =?us-ascii?Q?0svPdfB5fwvFogU3jgViAr01zD1b3mjNGRkTBe3xiB0Kkloz5vfWMTMw/lHZ?=
 =?us-ascii?Q?3TQ4fmfAb2A45gbE3zgGIloc8vRg2Wb2LVKpphK3E1QZq3l5kgBLCrhVDZp0?=
 =?us-ascii?Q?TcPf/j0lUlIwv8/vNCQS13Lje1K1E0xlMOrEmqcmooPtTwi9z2ZSNb5ZftAg?=
 =?us-ascii?Q?qFWo7cqkWcID1dBFuSvrZiHgRoqR3KPJp/OEM+ngqGIDubGhKxjJt52q9mIX?=
 =?us-ascii?Q?UOJ/j06wKp/oVt2gPiAgruDPOuInJsBYnxwch04if0YDv6fM/22YTr2rVry9?=
 =?us-ascii?Q?5yCWaNyOL0jqw2On9T0mEj9b3Pt4applDu0ohwK2XUg5BpFYv5zby7OYbJr7?=
 =?us-ascii?Q?MJFxmAzgZPIg4OqLPYygBtR9rS6FqD79MEHmVPLBcqId5E+YAkrxeRUnsBqd?=
 =?us-ascii?Q?60O+F4AuEGU5/e4DcvZ+RPvxzKFoUiLwFeSSiwSzR+FBIsXc0+UUnB8XplNK?=
 =?us-ascii?Q?rIMAzPvom9rE8/uWYdfUqF71WQnV7oVSDD8rZbaeEvLAxpZAhknB81NplDzt?=
 =?us-ascii?Q?7DnxncGdU8COrJxo+T/Wf/najyYWgejWWDau2p51ach0mbKaInAE/PcJ0asj?=
 =?us-ascii?Q?Ozjs55mu7VCSVBnrF+RPul9zfxpShMyF8MJuJoWw/jKt1pMbu/XFM0uZfK0P?=
 =?us-ascii?Q?QKekPLihNTk3vULm/GeBJ/ZQ?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3dfc38dd-228a-4ba8-a4f9-08d98cb2f166
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Oct 2021 12:30:43.3448
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vy9wUBJX3WyMCJgB9c0DGe8BYdDe6rIz9Jc2KRUxTuJI7rOQ7YF6Uutzr3v8oPHzIiPmzYu1+jggffd/0pce3WAWd8cmeXki0aP4urn+j3g=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR10MB1773
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10133 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0
 suspectscore=0 mlxlogscore=995 bulkscore=0 mlxscore=0 malwarescore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2109230001 definitions=main-2110110072
X-Proofpoint-GUID: CElkBGf0tEX9WBD215ywiHgT6W19vMUe
X-Proofpoint-ORIG-GUID: CElkBGf0tEX9WBD215ywiHgT6W19vMUe
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 10, 2021 at 10:36:05AM +0530, Saurav Girepunje wrote:
> Remove the unneeded and redundant check of variable on goto out.
> Simplify the return using multiple goto label to avoid
> unneeded check.
> 
> Signed-off-by: Saurav Girepunje <saurav.girepunje@gmail.com>

No, sorry but the goto bunny hops, the pointless do-nothing gotos, and
the come from labels are all terrible.

regards,
dan carpenter

