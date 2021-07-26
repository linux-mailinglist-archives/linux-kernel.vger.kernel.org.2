Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A9D53D5AA9
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jul 2021 15:45:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234096AbhGZNE7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jul 2021 09:04:59 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:51268 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233937AbhGZNE4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jul 2021 09:04:56 -0400
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 16QDfkoG000895;
        Mon, 26 Jul 2021 13:45:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2021-07-09;
 bh=WcXwweTS0wFn8VxhITXxsG2FnzHnCxizm5SpFj3xXok=;
 b=rnPFMhY5r7+Tq8MHumvhHiss3dcRSUHpZgYL3+5VZKaGrzXA5XarfjzwLKGGQ3KDtnrl
 RyykRLPaVDvbb4+poMQbYXtKm9nyF9U7MLHm4vtdWCLr9NORbwA4lLxW5oanVrjIcs2Y
 KaADp9xQ3Kq+Wx7hY5PtPB+FTwhCV7yaDYCu11qqtPtqy8vQF+ZiP4o9fiANO0TGJ/TF
 J4qXbQl+xbPa2eKlOaoQqr9oFBu5XpyicdKaKJDWlCDbebtu2qaWk06eSH3XBG9zwMBr
 WW0I9uI2izvM96USv6024KxhVoe021TRtVEouqRI6bfxEuLDLBtP7kIe+zHFk0/QOSCb Kg== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2020-01-29;
 bh=WcXwweTS0wFn8VxhITXxsG2FnzHnCxizm5SpFj3xXok=;
 b=lb0YCTKdkDVg3Z2jXvkLr+i0gmjrRUcex8dC0NZqHUifKOtZx5Y5stni2umfvYQmLzrF
 F0qOnCNq/iiuwDI9XamAamzgS5tpDCO0GoXgwBqhTE+d0NbD/s6R5/f2R0Bxh+aS3EQ9
 5il74mGYFugKKXRz/kbNh3aT8jlvnLYv+dT8/oP/bpTlwyUBkNFhS4WCNY91dtmUpC6N
 kNHFWeEjYf8TAS4AqUf+KkMQ1ppyY/GxQnF7s0UhT0Yw8NoXTkMPHGg36S9eQlM630iA
 WQS4ByShMMtvSekhcXylc7NVWEsEh9Bcv+rICQWDboRcaqJWMIFrB1OnVv9VH1+uHO8D uQ== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 3a1qkqs16x-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 26 Jul 2021 13:45:20 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 16QDeiE0099500;
        Mon, 26 Jul 2021 13:45:19 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2176.outbound.protection.outlook.com [104.47.56.176])
        by userp3020.oracle.com with ESMTP id 3a0vmt0pgw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 26 Jul 2021 13:45:18 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MFhRUMM9hmxTxosdw8c1TOyHAoIpoqaPmVM4xe09oqafIexzyBLPN+g5v2F7xYnI0Qq8FJP8CT4S4GGuRF1X8OPu8wJfgme7A6bbkIRUGNAwyrPbG/J9G1LZu0XQxYBnn/o8BpxUsfAi17FC8hbZhTllN5x9wpDJHApCD7vHcMXPTdtF1OxPcwnPC69RhQruheyDl7GPUPxBwVI8qGQISYGTIOAqN5MXUd9pHtJ4qKngX0X/ch31MfEuEGPa3yfcVRT0MdaoFt/Cxwz61gJRRU2lKuXY/SaG7iLT/6JF69ec4Ah5+Y1zfO3RM5UO0LAfJtTh96K/xDcuZQfcUX/+PQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WcXwweTS0wFn8VxhITXxsG2FnzHnCxizm5SpFj3xXok=;
 b=AZRiqEPQ2BaQalt0aVFcRq90WkYaE23cp8eFhV8lddjtQ10TfnJzAPrhg7tUW/lJCpqoVYoM7x/h6dEhdujqqFDKxb8/XtwFJaGeJQXvmPNeFHA348PAQbLSngON9TdH8Ol8e3D7x9y3YeIpIWzeQCq9KSZ2m2gf97fHZqVEFhZMUYqB8dfn8ICIIs7/tHWs8XSo9mx6ksPePN6oCuOf3/5qin3T6Y2u36Kcy/63U3XusffiQingpPbbLdF3J65DhKgTf77a9zaGzR/d1ijouiqj1oR2dhN7wsrLwPIA0+auZtDkSTvfTVJ0nNxPTBG+BC5UCQo0E4yyCAz4vCBkqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WcXwweTS0wFn8VxhITXxsG2FnzHnCxizm5SpFj3xXok=;
 b=Vxu8Fpa7HFEgwEMYfgHAG78BkA7QWyQavKPTBK2NG3Wv4WwoqIvUei1+dtSQR7AxxpxArtAMLNme8yAIvuuKiXkJu3DUq8eVtc/FsiO2FO0znUgSQmZ93Df0ExBias1YXwHdHXTHRfMO3BPe/24/XF/kBKY8fg/quo6Nhqx0eBQ=
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=oracle.com;
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by CO6PR10MB5476.namprd10.prod.outlook.com
 (2603:10b6:5:35b::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4352.28; Mon, 26 Jul
 2021 13:45:16 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::5820:e42b:73d7:4268]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::5820:e42b:73d7:4268%7]) with mapi id 15.20.4352.031; Mon, 26 Jul 2021
 13:45:16 +0000
Date:   Mon, 26 Jul 2021 16:44:54 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
Cc:     Suren Baghdasaryan <surenb@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Arve =?iso-8859-1?B?SGr4bm5lduVn?= <arve@android.com>,
        Todd Kjos <tkjos@android.com>,
        Martijn Coenen <maco@android.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Christian Brauner <christian@brauner.io>,
        Hridya Valsaraju <hridya@google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-staging@lists.linux.dev
Subject: Re: [PATCH] staging: android: Remove set but unused variable in
 ashmem.c
Message-ID: <20210726134454.GJ1931@kadam>
References: <20210723200514.10139-1-fmdefrancesco@gmail.com>
 <CAJuCfpF37KXw2SG37_XoRyhGWc+uueU0NaxcEfU1=FH-rRm+bQ@mail.gmail.com>
 <13453441.4PhDYAFLLM@localhost.localdomain>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <13453441.4PhDYAFLLM@localhost.localdomain>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: JNAP275CA0021.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:4d::12)
 To MWHPR1001MB2365.namprd10.prod.outlook.com (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from kadam (102.222.70.252) by JNAP275CA0021.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:4d::12) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4352.25 via Frontend Transport; Mon, 26 Jul 2021 13:45:08 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 85feee20-063b-47c1-81a4-08d9503b9983
X-MS-TrafficTypeDiagnostic: CO6PR10MB5476:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CO6PR10MB5476314B5D828F1226C2C02F8EE89@CO6PR10MB5476.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NFunGJwxiMiFY+yxKRx4z6CKh2mlsvzO/7EFAAm0HPXN4vU4DAhJIcFQ9AKKZTWY0sNVJ1mjDoFn4eEYrLpcRQJPXgTL/vSodwJ5C/uC7kW7rFtGV14tbWxYxCro0zQIcIi/uACrL2DHP3eNRCI98VkhbMyo1ReAW3TOFU4Titt1CLVXOyd7/ZnRpSGn2wS9cnXdq72Il6xr6jE5S+eXyhRRycE6H0dBn/NeYaLqm5WIGWZTpy5d+EXY4YgxFzqGKVn1DNQF8FggtqKvre1CLOwV5a2r3S/cwKn5lHu4oikFaAX8q909/I9rzkuoGwJdvb2BmV2A02OCTtLL7wA93XgX1LYLmhWJCC6QPSANBbrMlZRpc9pPl8H/Q6ELcyjEuPXZvdmOie+0XZVkumCh+y5xv2ws2VTrLDE+0X3g5EdAdUl1Fj9NBrvEL1zIbphsTddwSgDGYQ4NvmB7BsXyjS1t/AcATYxP11o+habjF/1syUujWbiT2tp5huH0OFu2X6zKJd9ZwOuN8ix2rdl95XDMDqWTZmeMJ8DVsRJOXxtXDPoqMWpzcR/2yDvjQthClgIjwovA7yCCoMhKo+WglTrHuHSnt8oa1EYDRYB9kI3rKtBE9U16rtFnboHysce+h2IdggjUxofH3y+cT0CdKqxtR5kVU2I24bqYjaPqKkpZVxM9JRp2xQA8kV45JaNGl9HGu+MVklLpUCkJP97Qrw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(376002)(366004)(136003)(346002)(39860400002)(396003)(2906002)(316002)(9576002)(55016002)(4326008)(83380400001)(86362001)(1076003)(6916009)(5660300002)(54906003)(9686003)(44832011)(53546011)(52116002)(38100700002)(956004)(38350700002)(186003)(33716001)(8936002)(6666004)(478600001)(66946007)(8676002)(66556008)(26005)(6496006)(66476007)(7416002)(33656002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?mn4sHtDxwfBUKS8DrwtaitX3qj/yTwh9buPAspcBU+krkID2l/SSpqWUMXZv?=
 =?us-ascii?Q?/sZ+sm/U30ohHxBevg6OWTCgK3F+4WciSQRrnwbSI0X7CyYNgP2lYWkXG1/S?=
 =?us-ascii?Q?VIjiHndJT+ZBqu06GrZX50+wx0w6/tcR24hbyObEBJkvvaAm2YZd1fvD2FJF?=
 =?us-ascii?Q?cS0Q/kmSQcxQEaN+qQKbjHDirFO295Fob4/SEM4e5cIpKnAh6eFvE+jieYDU?=
 =?us-ascii?Q?r6ztOxS7qMkoqMYYZ8xbSWThDsKU1rEX/jHm3UPPsHbEk7S0W+QJuQYoqaj7?=
 =?us-ascii?Q?gNyU4tUJh0S3kOCeVV1wCaHfT4B5a1FUOC7Su/aM9Q+pght/H5v6BATchNK6?=
 =?us-ascii?Q?iVFVLmOgldUqGSX+zTlzOY9cD9uYUcchrAQbquNsglXggQSzi6hH4SNCuX6z?=
 =?us-ascii?Q?Geb5uYoC9wKPl6nwsWd1K3tFsHxJ1zdHeTeISWeJFUE8i1ly9jOWbcCwSa3p?=
 =?us-ascii?Q?vqdqV33dYHwCTZTbZS3GNMKoe3gOrXh1f93dVAhewbqrRCeu0MsJ8HQBW12B?=
 =?us-ascii?Q?GVP046bK6XP/AJolx+TCepuDxzuAxCRSpvnwknUs4t4uC2+xZUFKu4dNkwsT?=
 =?us-ascii?Q?dVjqhK2WF4OPd6AHxb8LkKtBMUsw3ggBEScOvVXacpeloGSQ6kLKOXcUoG3v?=
 =?us-ascii?Q?/hzOFZqs0/cWG2+1qFZ3joi2x5Zf+pZaYkG8UuXCsDxk8A38/JTLJykDvwU7?=
 =?us-ascii?Q?b1sn3hqQNBWIaaSnV/t0cz+4h7kdwUEREIZCpOL2VgVBKboMwhE6Qx/vKMeV?=
 =?us-ascii?Q?PbyRQ4C/G1cit0jRHOKTsDFik7hY+LeS4bsE63PJpC4b7UOeEXM0UAsfwRQt?=
 =?us-ascii?Q?tBZyt5ZR+9fg3Q37VBSXN1WOez9ul7wodP71M2OMyjVkm40VTqx1xqyTzV3t?=
 =?us-ascii?Q?l2nhJ+UAphmLRwyEvpKzyE1KJQvG8n6eqC9jyTo36BDO/ib243rqNEBnp1/6?=
 =?us-ascii?Q?vCm3/0vGF3HXA6oePmiLahvhxgUGvQ2/rSHEem5zsajYCXIuQEtPjqD9TmA1?=
 =?us-ascii?Q?v6iqi9Bjaza3NlwZIBcC5kERlF6HXI2kgmgE4ck0XWXX+2UQV40QVnrpQpSf?=
 =?us-ascii?Q?WGSenCaMcSCXZ9KT/5cFpnvecrrDygWu7B6pEUiSPAHEY66WJj2vmlpPS13g?=
 =?us-ascii?Q?1dAPyAysa6b6a8tvEetSkfyh2HhIFwxISalmqXvk1fT4d+RaLpvHbEGO6Fvw?=
 =?us-ascii?Q?aJuYlXPnuUtTRTdOlkHDDitC6mOz9qE+a7UGkLYEC49VeFteeisEWliUc/K1?=
 =?us-ascii?Q?F3l91VHoskH6FGgdjj/H9GBgxb2iSyDhEfty6ttcaf6AQwKOtmWT+dEoB9lq?=
 =?us-ascii?Q?RWWes5hfWAqcOdxRwwyWyles?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 85feee20-063b-47c1-81a4-08d9503b9983
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jul 2021 13:45:16.4137
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xbjq3V3IkNJE6FWugH/pEKy79mgSbvCA4nZCNnQLhpAoyziHCqdoqgsFi1ltgOcLqjwGrDDUXSwcMg2UZ+bwuDs7fXa4xYuJh8vnvppi4PY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR10MB5476
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10056 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 phishscore=0 suspectscore=0
 adultscore=0 malwarescore=0 spamscore=0 mlxlogscore=999 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104190000
 definitions=main-2107260077
X-Proofpoint-GUID: nTQC9_waZiRhjN1nUzKwBPTxpXEmQqRq
X-Proofpoint-ORIG-GUID: nTQC9_waZiRhjN1nUzKwBPTxpXEmQqRq
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 24, 2021 at 09:49:35AM +0200, Fabio M. De Francesco wrote:
> On Friday, July 23, 2021 10:14:46 PM CEST Suren Baghdasaryan wrote:
> > How about its usage in the above lockdep_set_class(&inode->i_rwsem,
> > ...) call? 
> 
> I'm sorry. I didn't notice that 'inode' is used soon after assignment, just in 
> the line that follows it. I was also too confident that rebuilding the driver 
> would have triggered an error if it is used somewhere else. I was obviously 
> wrong.
> 
> Furthermore, I usually automatically search with grep or other tools for other 
> occurrences of a symbol in the function and the file, but this time I must 
> have forgotten to do that.

Another trick which would have helped is to try find out which patch
forgot to remove the "inode" variale, because that developer would have
seen the warning as well.


> 
> > I'm guessing you are building with CONFIG_LOCKDEP=n.
> 
> Actually my .config sets CONFIG_LOCKDEP_SUPPORT=y. Did you refer to this? 
> There is no CONFIG_LOCKDEP in the file.

Use make nconfig and then use f8 to search for CONFIG_LOCKDEP.

regards,
dan carpenter

