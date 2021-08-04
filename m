Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 16F0F3E0190
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Aug 2021 15:02:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237701AbhHDNC6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Aug 2021 09:02:58 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:1480 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237364AbhHDNCl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Aug 2021 09:02:41 -0400
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 174D204O031926;
        Wed, 4 Aug 2021 13:02:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2021-07-09;
 bh=lN+CpVeXknnoHcK7KFyja73T4+CoW3lR6Mi4otX8z5s=;
 b=voeGw118xqcyCfc6juKb/tyNFm0Sx0VtWzsqy9PI+VVcqXWlocmk0XPrmS5OGaKAucSs
 kf8FxejXWfm23y8HSpMh3VzmWQf1mfUpTWLMPnH6bq2sX8ROuKcIAD+Gb2defTTeW4ZS
 ksWCvVWDTna7rP7iLO7MSa6TUVs3v8dD2F9vixXAuBas14DQ91K+SGdyKOrgpiDhee5u
 GSaUC2RFRJ9HBm6PZWLJ716Q3PgWzxZZVRE2R9Inwkq3vaeSUwAsC6CkJY6jN3XDv5PN
 BDtEnEkw27tA3QC2/m2IGKxRFFVHOCrfR6mrt0vDjE5HiC6/2w1z0GuPG+9sZAddCI/S Kg== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2020-01-29;
 bh=lN+CpVeXknnoHcK7KFyja73T4+CoW3lR6Mi4otX8z5s=;
 b=KqG0ijsHP+5O4tM8haF+cxtJRlotbc2uXaC38TCwPKOTPdNHnAJv8SmuwyCkEz2YC3JD
 Xh5+jjK+PNBehBOaWMl5KW6Y6X8QiNtEvGIe4c2RL+v4Y2h9YeVtgKkCB7b5X7CAHUh2
 GFe8tD4ZKlOMqtQF269r+51xGjNDqFv2GmaW+L+kqC75kwCbS2iWDiK0nvWlH92XLzGv
 wes30UJ4upIjB7maxIl7XgsF1iKStEi3GYXqUMFkxzL79lg8FRDtyZujiXcJhA5u7W1r
 dNFxLZutYxiA0lBHy+lV7p92pFQ7vBNpaZrBCXfluRCpbeKn1cdjFgMOaDdnZNkyEMR1 +w== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 3a6cntpavt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 04 Aug 2021 13:02:04 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 174D1pxP006122;
        Wed, 4 Aug 2021 13:02:03 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2100.outbound.protection.outlook.com [104.47.55.100])
        by userp3020.oracle.com with ESMTP id 3a5g9x4pjw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 04 Aug 2021 13:02:03 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=l07hk4YZ/gJDuaRud23T50ZVbhaZ3myS5cGVmg8HbknoCbOkYflO+kYMQ7E4edrYdpbRKuBpwammqWWcL4WEGpfEKaX6XsmSNIALPsoDnJjLiEBN7loysUKhBKNCWk6CCMASdrTBg540b5eQCUq5Gu0/PhZdgR0btCxNOW8EPK6V7FC2eC8nYGo73UpHVqyI6xqFlV/onRZl6yZxQq2ozuE+dYuU52hJDyuWtLjhO7KZF1vM/JAIdP1jI9vkMxDNxKUGoejAtGNDqX05Kqfz+MSYzNb9JmBaVQ9eFbTpg8FNkCqZMh4My7od4+FGaYwN5a2n/ctUOpOyyDJA2Se9LA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lN+CpVeXknnoHcK7KFyja73T4+CoW3lR6Mi4otX8z5s=;
 b=R0Fsweq/jUFRNxvpLrPAdB3xUX8VjOel5ItylB+cVPNDAb/2KJUJ0uBd2/jnKKM1k73HCAEmsxdvxxK78+MUtWXbxH4YL1wZRN4AD02JSuHRCPGZjeCt+V/Xk0rfCr/+q0yHIFtIj3WEQIjIlOTZt9/GvKrFpVzm9fLslTtUgQ1d2NV8Htvx3nO+wX7lYNuQPuGOdkHkLJFpY7ol/AobJcJoKfxoonvyLFdr16oD/mgGRo9FvwV9oJpp1JBUeg3yoTXKBGT9KkL87F1aOduL8DoOycTd4Zd6rMpbQXXM66Gpv6+3FASE1+MzVwPhQGsdc2kkwtTO9JqBLJB1Go5ozA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lN+CpVeXknnoHcK7KFyja73T4+CoW3lR6Mi4otX8z5s=;
 b=UK6gwDCHj50XVptOwqP8imJr7WP1JM9iU35GjMNZSaWTAmiHuGUMPiPuPn8FC3aMfCQ6KY6U9IbqyB1No+END3d6pcYfsCLeIRnjWjXbSEdk4oOCwef9sdQiQNIYATYK6MVgpLq30W4tbonOGYTWH6xaPpOfy7VbY7+CJK5O1iA=
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=oracle.com;
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by CO1PR10MB4641.namprd10.prod.outlook.com
 (2603:10b6:303:6d::5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4373.18; Wed, 4 Aug
 2021 13:01:55 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::5820:e42b:73d7:4268]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::5820:e42b:73d7:4268%7]) with mapi id 15.20.4373.026; Wed, 4 Aug 2021
 13:01:55 +0000
Date:   Wed, 4 Aug 2021 16:01:36 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Larry Finger <Larry.Finger@lwfinger.net>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: r8188eu: core: Remove rtw_mfree_all_stainfo()
Message-ID: <20210804130136.GJ1931@kadam>
References: <20210802005517.12815-1-fmdefrancesco@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210802005517.12815-1-fmdefrancesco@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: JN2P275CA0046.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:2::34)
 To MWHPR1001MB2365.namprd10.prod.outlook.com (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from kadam (102.222.70.252) by JN2P275CA0046.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:2::34) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4394.15 via Frontend Transport; Wed, 4 Aug 2021 13:01:50 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: fad5fb1c-8b30-4954-2860-08d9574808ff
X-MS-TrafficTypeDiagnostic: CO1PR10MB4641:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CO1PR10MB4641EA1416B51B4A0DD2673C8EF19@CO1PR10MB4641.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3173;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: AjWeRMEYept2lLYJNv6GMKnYHprrdtj3BU4y812QZ4CZcZzrZ6o69u01oNh4h4XHmWJzmBVb94aorqQdTzZ/6TdONbbbRzx2eDIPLHFn0r3uuHL+Ig63GjmnxWn94LXLvQm+NsjzN76Et1tlDnSQlt9MXuqbINQ5jv/Bpg7QQnslLqBvNVV5sTVZKMfSIf9DKqhJYDA1NeAqr/iMQ9KFUyEgM52boNSA/OcXQIR0sljkvCEfKGsp91U+EbyLKBiTuDsPAvD0Yhts9/hBQgKqIqhG4W2sAxfXCdgJgOflfd74evjDmqBl0LVAel1SR05rU5o5aZjIQ3w6EvdLoFbpL4x3gS6AiObJMnxX7E2d8YyKdGGoc2t3hTMgR/MQAz3vaW3RNS/sYHRxlR6xv8itI3fLRb+iu00b7uJdtKRHIysqL8VJwE/z3/gQgPKgxmDyaHuiibwAZ4N6YHFF8YxRjYVdKB/TCZkyTWAADFhp+y/RPZWq4J9NX+uC81FPZRXeCxWwfVKQ1P9d1Z+wEdienqU13VnQcYS2esibWzUj1kqAi3XtJzKG15DWxcALLXOS5VVduo1x5tcNpDbe8rWNd45Jj40FuF+ER+y7moHwFmNhWt4FppaNQ/Q4+6XGmFqZP/HfCyuzD75pK0x+luocP56jhgXrxsLVZyro0cPQH4csud7M9ruPZqCrWuUeMnt5aA9Og+wVpIDxo1xM78ekhy495Fqid3tJCncnOfbOGYg=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(396003)(346002)(376002)(136003)(39860400002)(33716001)(5660300002)(44832011)(6916009)(6666004)(26005)(4326008)(2906002)(956004)(83380400001)(4744005)(186003)(86362001)(1076003)(66556008)(66476007)(8676002)(6496006)(478600001)(316002)(9576002)(52116002)(66946007)(54906003)(8936002)(9686003)(38350700002)(55016002)(38100700002)(33656002)(3714002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?tJO7oTim7y+ygyDcoMQJgnDzMceKokxF62n3fF6JyEXaQoviMlGQC3Y3Sjt8?=
 =?us-ascii?Q?H2qCDOGNDQgCpFmZDpnPUBX6MvdfaWqrRjhqmZMwxVsVL8aDYOEHlkuObBk7?=
 =?us-ascii?Q?D5KVRigeBFgL4frAK+cXPn7elW+/Ua6h7U1koSmPwlrmNHDQWESmKAS0uFSR?=
 =?us-ascii?Q?Jmkew3tZV//desq1vYKNgVZuORiZU8jxBgoa2W76gtevLwSNjPRy7jBIIzIS?=
 =?us-ascii?Q?MQygQ9N1bSBf6mLjZQxjLy042KV2rLZExKXDgz8s2ESfe5oLTIxMuyEU5M4L?=
 =?us-ascii?Q?LeZk0VBgdXwWZLGv9BUmRda/YwNE8n+Xios5aDK/wzdmnqCHsXv09ExEzMNW?=
 =?us-ascii?Q?uxLKpAn322CgiNXuAjhNu7c4KTntkBCKa2Qa8yv8DtvO5btkRCN+wNJF3UcN?=
 =?us-ascii?Q?pFN7unkXVbwTxU+bL+PhazS94HHLTUfY00L1IOssGDc+fCv4SrlSl6pyxi8S?=
 =?us-ascii?Q?MBnDIIIebXPSmG1fJ2vRRorXQmLC0CKYFNG892re5kXzH8WDJGylndMLapye?=
 =?us-ascii?Q?6FKPNOEZ+AX3YVP9IljvPI2bREe3mYk1q4wW0PGngmHQRooKnUr1IMaRoJbA?=
 =?us-ascii?Q?Yaw56TfXOG5MofG8Pxgcr530XQ37KXxaHA5KVFCrJtHZCxrwsCoYZJhNu6w4?=
 =?us-ascii?Q?5vge6FfeIbjsfdByngGjiAZuZ9KE1pKQb5P2CZsvEe9awssVBt6dg3p7Hmmz?=
 =?us-ascii?Q?zXd3Mz/iMQcAsKfU2bsiZ6BvLGKmosTLJT5QnO7rwP2hCQxXuwykhlBVCOPA?=
 =?us-ascii?Q?y/zOao7ineJ7SFQB62bWq8woEe07sPcOdoCU+Y7//kPZnNx9haXzvnHCl53f?=
 =?us-ascii?Q?npajhLA2WWotZniZMOBF64A5eY1PkSIi/1cn8RS+0962VjSIWOKfCTWESs+C?=
 =?us-ascii?Q?MUHRbmZR1xl0X+Q5jPVLNvtv6gTnqUNv69F2WBCrD0t3yAs2H9zJrinsL1Af?=
 =?us-ascii?Q?ViKkV3BtejvlQUj72MG8Zt2THa7ubosYyGXLJb2Kx7VNecJ8xNOiTJAr6hp/?=
 =?us-ascii?Q?W3XQ5044jbHbPdyTNQHb5yUr/+hpsZ8WMkxGO1w78+q2nvLFaGlrQ9eCqDLg?=
 =?us-ascii?Q?XtuCeqUiN2gfceEweCAIMt6wHCsMQ2eiTeRDazJnTqgP7ITYIzbVxZfqzNAr?=
 =?us-ascii?Q?59FhxYrNx9GyXC2wIbQcU5wExvrPLUbphnmUYFFvGr0K4I0b+fzYe+i5kafn?=
 =?us-ascii?Q?jzcRS/sA+NdphKKhGnFlnzWLioQqF28OPRbOMN5hjY2fxA5HzrzOU/hq4ylT?=
 =?us-ascii?Q?0IkjS2n5Lul78WbdWSkzlXcCxyWu0c0F0VvArmxeyT8ykSm7k+vSLI+vS1Yd?=
 =?us-ascii?Q?L+OI+eNWVAbRAExp/66zhceo?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fad5fb1c-8b30-4954-2860-08d9574808ff
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Aug 2021 13:01:55.1346
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UU4B2436AjzRM9UD6j6wpubFrfoovJP1B3PFCIn+dCsJc26zCvehYiKGhPPs9UHzqwa82jqXOtcXL/DuQI3NuJQrpBU82i2V4DqIE64ohfY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4641
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10065 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 malwarescore=0 phishscore=0
 spamscore=0 adultscore=0 suspectscore=0 mlxlogscore=999 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2107140000
 definitions=main-2108040069
X-Proofpoint-ORIG-GUID: 9U7eheLOP2a5IkLm3CNbwH7BWb9kZRUy
X-Proofpoint-GUID: 9U7eheLOP2a5IkLm3CNbwH7BWb9kZRUy
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 02, 2021 at 02:55:17AM +0200, Fabio M. De Francesco wrote:
> Remove rtw_mfree_all_stainfo() and the only line of code that calls
> it. This function simply takes a spinlock and iterates over a list 
> with no purpose. That iteration has no side effects.
> 

I mean, it's pretty clearly supposed to free all the items on the list.

regards,
dan carpenter

