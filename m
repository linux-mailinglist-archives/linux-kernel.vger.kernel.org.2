Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5CE214113D7
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Sep 2021 13:57:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237382AbhITL6y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Sep 2021 07:58:54 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:18330 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232033AbhITL6x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Sep 2021 07:58:53 -0400
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 18KBOS9Q012290;
        Mon, 20 Sep 2021 11:57:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2021-07-09;
 bh=GgU67NeXCiYHn8vaZ1N7w+r5CWTvLKj0OQAKJQgiDfM=;
 b=07NKwacehyITpbK/4QUPXrzgtwsN+VliKki/urQS2e7QwhYIt8M7DrsHkgkoA+g61EI6
 t02NN/BiHYzKgNuMHR+jXKC9eAfpEFyalgMrQAj8eZ7d7nUHZnxPB+tdrcRDNb8dignk
 Eb+GXjKltdbTTXTb6wKVUHyeyQzf3f9BHHw9RlwbSM9bPE55YpeS+5i3fvPOaO7VKLt/
 ddprkU5xRH8xS0yUvilAj1fZ8TQgAQacX5i2REtuRBIo6S6rpd/rVz+8lJHOAjrKF4CL
 mbBdZwUYtaub9Zmi57tRZC0nLeYfMNXbj6sPy3KL64QXlm/t+APrOiLm/rwpMcXzgg8m IQ== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2020-01-29;
 bh=GgU67NeXCiYHn8vaZ1N7w+r5CWTvLKj0OQAKJQgiDfM=;
 b=vZpGyct1tfzzax9N8I5INij9J7OM1bjVi3nFsUpLAXbrHot2zAOvetdQuydFTS7w3eue
 Ak+B0e3vjjdpIDhnmgk4Dkpd8ZJS4FcfB+fqhZ2HrdYhod3pOy2ylq/+MrcGvVMCnwGH
 wT8oArRrBIbwsjYQL/ZUcfuGfE2X6RYuTYY6sZtl4UDklGmk9rqlvosyxOLIdrpW+Rec
 qLYr27rNhDKxhZT/9KGxCa//MIKYZMypbFc5g6DiOCwVpp+Sl/nYKkJE7/umenpsCCBo
 Fk36HGbn4WUYlXRiz6ieNatFIc82+WOlgOJnFAfn/9PxtbsgnS7Bd8evrRW3S0Q0W9rY VQ== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3b66wn25pd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 20 Sep 2021 11:57:09 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 18KBuhtX046483;
        Mon, 20 Sep 2021 11:57:08 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2177.outbound.protection.outlook.com [104.47.57.177])
        by aserp3020.oracle.com with ESMTP id 3b57x3x4ku-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 20 Sep 2021 11:57:07 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=B8FD6U0OiqeCJVBRKaAzPGhFQEXq5hLNluAkyzZ/HK9WsGSfW1gSUEj+RGgIwPtdkNGh1wgt7dWyotJlKqm0uLyQhodI5HQoHZ/ys8uLwMxOnnY0s2sJTniWpgmUUAP1BJs0MyG8AuA68Ota/2kW0SJ9pC3cmtKpmHsj2nH64Dn3rNF/AGc/nb9m6vssi2ZxIdryBUp0fKcQR6fwpB/sw3+faJVkMr+anlWtFMEINzqImIfolN7gpEcy12rufwLrLbVsCnI1jEqNZDxElRJkj3708NSS+ntT1ixZvcmoXRUCujKJVnKIlL2unBqXQdBfe0ffs6HGn9ZJyHkt8DbjEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=GgU67NeXCiYHn8vaZ1N7w+r5CWTvLKj0OQAKJQgiDfM=;
 b=bd+gUYxJ1jW/eLpb2SkL2lYBXos046Y6qlBMeRCK4tGzvGlP/Pz/C2VoaL0CNXATWCP/tHdfOmrJ1Z9JJpvkvvUttK7SC6rSrQ0yp/eiUBbhJuIGSj5WoJRbwtweLs/QpFxtk0PjhT+/6xmL3XHAFEwwRRoO6aXtszB3m7q++DdgmUoNKqqy1uQVZvVM4/aCdJBWt3VokOx1hInPHZB9PPfSv1P66T5s3lwTYxSPWl7+NSHwng3oeJMBePUX3IsiH430el3+bR1iaQtrdEgZSCRts/EIxH9TVj8YzdxSn36QN7pjtkx8rTWXq5fjn/w6ZVZTj3lANYSFKUWy8LHeTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GgU67NeXCiYHn8vaZ1N7w+r5CWTvLKj0OQAKJQgiDfM=;
 b=riWFQiThhnh1rWZIY5fUmcWiBA+VzNd9EoBa1MCb2V6jbtOa7xROxTudGO07i9v+4w7gfJISH7J1D11PL6RMGfnElA5lL3wAgGfKouH5I5I2hXhjA4O/WLihDd2u+NDv6od6a83XWEjS74L1OlPy1601JhiSgYzfNyE/CsK7xT4=
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=oracle.com;
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by MWHPR1001MB2093.namprd10.prod.outlook.com
 (2603:10b6:301:36::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.16; Mon, 20 Sep
 2021 11:57:06 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::d409:11b5:5eb2:6be9]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::d409:11b5:5eb2:6be9%5]) with mapi id 15.20.4523.018; Mon, 20 Sep 2021
 11:57:06 +0000
Date:   Mon, 20 Sep 2021 14:56:47 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Pavel Skripkin <paskripkin@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        David Laight <david.Laight@aculab.com>,
        Martin Kaiser <martin@kaiser.cx>
Subject: Re: [PATCH v8 15/19] staging: r8188eu: change the type of a variable
 in rtw_read16()
Message-ID: <20210920115647.GR2116@kadam>
References: <20210919235356.4151-1-fmdefrancesco@gmail.com>
 <20210919235356.4151-16-fmdefrancesco@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210919235356.4151-16-fmdefrancesco@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: JN2P275CA0037.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:2::25)
 To MWHPR1001MB2365.namprd10.prod.outlook.com (2603:10b6:301:2d::28)
MIME-Version: 1.0
Received: from kadam (62.8.83.99) by JN2P275CA0037.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:2::25) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.14 via Frontend Transport; Mon, 20 Sep 2021 11:57:00 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e4a331f5-c089-4cce-43fe-08d97c2dc465
X-MS-TrafficTypeDiagnostic: MWHPR1001MB2093:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MWHPR1001MB20937D170CB42EE3C1FAB0D38EA09@MWHPR1001MB2093.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:514;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: C3p4RdEJqrXOPeRfOyz99Pqbj2HrY05ztPPqbuHpZBtgkHXqeU4R7XGRgfZzjAfbzI7uNjKdK+/IBCHK3Kqrei8+FTVcmstpKq8ZcLWjxUXt7vKrXzDUaVZ37dEsDH99u2FdNcLx4BN8sH5uyoXyvWpHjXiXT7g1GXmZjLusp1qvlH1sW3shlzhPIzcUnW4OyS3YFo7dIPPcJTdvXWIpRsSK+KY/M/B+MCoE12+1rU46fnTQnSaMdhlb6qilQ4/YzQCzInAoTUl9J1BLp9+RFU8KePVaEzit7QOt5zGsiJlEjWvWWjxUW503RPcja12Ch0aFsEUXLRZEl8FE/Xd0sRSR9NWkIsqmCa/o6TW99IvhgDxF8/3lT6eem3y8KJcldTOH9XZVB9oTQmwfPq5NOHswbYdy/k5TnYovwA6McYejyvAR8nFSsHJ0476dn3KACIQZ8OklbrdcJ8lcddFJBxZIT/NubiohFv1czcxgCeTEr9k1xhVJgtCldc9wPGhWhhotqYUChADqc/Pvqrys4I94EBktJgl7Om8D0O4PsNnjC47XYPu7IyTS4k/4Ij9sElWOlKKLQvyrODCSWq4sMsT5c72+/+PQmWjCb6jjzs0EhcYw1EkyLZpbgIRHY+vMcKqr1BZ5jZ3TEUKAb1Pb7kjiOQfvf9roV20VjOQc39NlZnhCK/nhruaLCzYwD/AQghSRLplmO8kDx0nk5UpMIw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(366004)(39860400002)(376002)(396003)(346002)(26005)(8676002)(4326008)(316002)(4744005)(8936002)(44832011)(38350700002)(5660300002)(86362001)(478600001)(9576002)(55016002)(6666004)(54906003)(52116002)(6496006)(956004)(2906002)(186003)(66556008)(66476007)(6916009)(66946007)(33656002)(83380400001)(9686003)(38100700002)(33716001)(1076003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?8dq8WVtWzRZZHQVBz4ookmR+Z7pY7F/DSzpkQa+f/0FYVODSWjONk3cQ24zr?=
 =?us-ascii?Q?NTeCrbcx5Q7CqWcT2bco4XsrmOxXD2CJmKuTZ8TS5wZeTEfi3oez7hSCpmKH?=
 =?us-ascii?Q?fkEo1QPYZuxD5nzFG2ffDSeW/ciX1kwUp2nCldtTxfHFqPdYJZIKNJLWUz9f?=
 =?us-ascii?Q?I2bPlmKdAaIcRchzAc69Eth0juLiTFxJelPgQt8BRwbev3lMbpKHntOmSxfM?=
 =?us-ascii?Q?330jJ4TaexXd9Ro+gSZedOXNk3b65GyuwTjKgWnq2k3zShmkeEA8Ypwt5kf7?=
 =?us-ascii?Q?Cwj0vfj2S1PZ+M0+NmDW8nViDhn3NQyUjPfnIF+FTNFeDHQmaFO+juryysmI?=
 =?us-ascii?Q?nJpSSrLVehtZfh7M4/evfkERYxNSgeHrHaDOrfh2bzTWG/fZ/nlAPnTH+kwn?=
 =?us-ascii?Q?mnSsF4BxlVzKDixgNgYycfUOljnABiGdozu02HA279DMxHbbvVqIwpYGAQlp?=
 =?us-ascii?Q?0SFWBdOrqMHLo2uuC3lhdOCEAa0kzBjnlcf9osR+5OTyN9xYyGi1u390Ul0/?=
 =?us-ascii?Q?iOwFs9zKYou7/B0FVJ5ox15w9n7+CcRRJjAALTgd3tm30cyrFO0Tw5S9ZIwU?=
 =?us-ascii?Q?xZFm7ukGHX1+Ak9um0FxMqzxP3ADH9yVKbelBeLuCJLH21430IU0c/gO2xS8?=
 =?us-ascii?Q?duOi7gwYS50N1T3Q4zbC5cksEHlwt5C95Qp301pRbidjfyfY/PozsgQSEXsi?=
 =?us-ascii?Q?Kq/ekll5XwSGFoPcCyDCSSlisQk7ZGRjiV1mQd05oqxniV7ka3QZtD2aT9AF?=
 =?us-ascii?Q?0iNyjodcm+hLjyZtTqvWsazqSuHUy8nkwtf5uaH1Td7ge6cHuPOJZraTV7sO?=
 =?us-ascii?Q?CX2JdxrU3BfPKD/G7xwTz3EaBKegIWuoqmGMpFZPHs4pFAy1dYAPevKCkO58?=
 =?us-ascii?Q?ZIWBcBvmi5tFnBIE1VBL5WIIAfpUNRjAzZPGiTaXe0f3esvWaP3BRHR8tw9f?=
 =?us-ascii?Q?Ddt3p2N8PBxkAYuX/obftDxMua1DLu8kIdd5o7eG39d0cUXbxu+DWCVVw02X?=
 =?us-ascii?Q?NXppYlHC7txlzGExZBvy7NHfBNsd1WKXgtd+hTVR1Ccwe/C51IQXuUoAlRQp?=
 =?us-ascii?Q?NFMG/hBXxRnqKI0MrIlLcd+eg1SNMkLnZFa0fEe+dV0I8F4CkVhRdRsRtT8v?=
 =?us-ascii?Q?Hpt7ahgcA/vjJhqS0WmlavZykwt2I4KT9Kpcdkfc9MigO4J4mL+X83AFgycD?=
 =?us-ascii?Q?Nyf9NYIc43OZVvb44q2QbxC6yWAg7tsdbHdsVG34vrtkLFd8HTmCdACaLQC5?=
 =?us-ascii?Q?sGJLKHFEAwNxzuoRTd/qd7qXYd04bLBlGlbA05D0kQUpLECZvxK2yOPTSBg3?=
 =?us-ascii?Q?tslgKnIhU1p8PlmXpAubd4qP?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e4a331f5-c089-4cce-43fe-08d97c2dc465
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Sep 2021 11:57:06.1468
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0UyetgeGgYkz2JJ+alFH+xtTIXb5f8bhoEninyPPICZZSe1O5VIHDj7WXS114N02PjfN95LD3VUYTLRYOqZej8K4Da77bTObLfwF6A7eFHk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR1001MB2093
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10112 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxscore=0 adultscore=0
 phishscore=0 spamscore=0 bulkscore=0 mlxlogscore=999 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2109030001
 definitions=main-2109200076
X-Proofpoint-GUID: F_EwgnfPS7aQ8WRog84nGw_g5GevGO56
X-Proofpoint-ORIG-GUID: F_EwgnfPS7aQ8WRog84nGw_g5GevGO56
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 20, 2021 at 01:53:52AM +0200, Fabio M. De Francesco wrote:
> Change the type of "data" from __le32 to __le16.
> 

You should note in the commit message that:

The last two bytes of "data" are not initialized so the le32_to_cpu(data)
technically reads uninitialized data.  This can likely be detected by
the KASan checker as reading uninitialized data.  But because the bytes
are discarded in the end so this will not affect runtime.

regards,
dan carpenter

