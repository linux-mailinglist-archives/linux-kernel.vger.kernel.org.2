Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B3277305C47
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jan 2021 13:59:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238139AbhA0M6i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jan 2021 07:58:38 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:35094 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237868AbhA0M4E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jan 2021 07:56:04 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 10RCrrAf179790;
        Wed, 27 Jan 2021 12:54:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2020-01-29;
 bh=I8nloEIM2eeDdksqKS81N36dIN3RwKcITDznPxVWb7g=;
 b=T74jCrT7VD6AFjQmN8J174tSoKU8XAuYTajqd9cl2BCBD2Uuvxfum2AUDSyTTQ/p+dRk
 8S3F8oAmlo4DKTxH8SVYdeIEzzuqmH28z+Bryd9B6yOF0rN4KQATUmF2fTTJ5ZE7gUii
 OY4p6cBXjopplj6F0UdP/TZh04WGeo0/TgOVOwFRdM2U3Lpp/1/cTC86YzSobGsWsDha
 OW4ShfaKyqvxgj3VNl8mH5Ixrz0Siu+nrdsv9+3NgTUZiv/mTuf2bpPiNEDSNmrzb4Rc
 ZjeZ8Bbs1sY+BnOccufe+LU1VyEMyOHwCEUr9/zLb2tgfEE5d9gwGlrDqZIsRl9SVkQd vA== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2130.oracle.com with ESMTP id 368b7qxw32-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 27 Jan 2021 12:54:50 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 10RCUPXr192505;
        Wed, 27 Jan 2021 12:54:50 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2171.outbound.protection.outlook.com [104.47.59.171])
        by userp3030.oracle.com with ESMTP id 368wqxteya-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 27 Jan 2021 12:54:50 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ni6OCLDaevTCp3U9Dyb+vk0upY+1EJB93MBKldENgzQWXvtSleoI/BP6n+w0wYDnoeT/rIv4NGQh0bLABqszGiFiaqFhb7+OdvCU5UGNyzaxHtmtWZMDisF6H1Nh0mWfTyJx2m6eLfSwQUH24qkSG/iaa9ASsMI4u3HVQoIUS1YZeHUo3cytwksklcTns8vi4qoNG9+OBlLRwBQMBUpKgmYZy42Xa4tJUyWJkekTnuG+SSyOABTqEB09P56G4oU8psPNUK7boGvlK3cbnW01HC+yPFBilzH09p2HVnqwoqK+YXSFbaD3tbe3RlAK5mbyw8/Iex4G+W7SJ7fRUDq4mQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I8nloEIM2eeDdksqKS81N36dIN3RwKcITDznPxVWb7g=;
 b=OTdKz4RYYNbVR0Kwvb5CXcWINSPyk0tGkAx1X4GDHlcezZQDbi44mA82VF394ODflCpox5vRdaDxfULpfOrXj5TkEeKDfJ0x6Oz7fsTEfDE4zVveMthhxC9nZkN/aCEMHkw9NL5VDP3LNB6UdnZS3+Ukq40Ik5UWpVKiC8xXBu+z2Mb/gPga2K5WWnFFfGB2RRsJo5+EMDm6aA2qxJRloY5XEwBN1fg2UT2YtTkGfBGYhD3gtOAhKm8caW+4wWPahUkTMZb2+JppYrZph/XygvKnCnA6Ba4ip2PGlroyYTItdg/wDpNU3P4d7Yj+zqkUDO8tpOxm50poBJLQhRr15A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I8nloEIM2eeDdksqKS81N36dIN3RwKcITDznPxVWb7g=;
 b=XeWY0JiJKgBNDVkZeyt8c+gl+lBZEsP30UbaoTg+qgHZwMkr3/W6h9Zse+RIgpxtvBn9IyQX6Ps0bkD6nWsE1VcLZ4Vogqd645BeIDhYMJkg8M63Kkgyn/Kvn/Ihzxs+3TlTShP2R080SM39j+IIH9BZjCLsxq80d1x2+uvHhic=
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=oracle.com;
Received: from BN6PR1001MB2228.namprd10.prod.outlook.com
 (2603:10b6:405:2e::38) by BN0PR10MB5062.namprd10.prod.outlook.com
 (2603:10b6:408:12c::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3784.15; Wed, 27 Jan
 2021 12:54:48 +0000
Received: from BN6PR1001MB2228.namprd10.prod.outlook.com
 ([fe80::cd38:2bd0:a5a8:64f2]) by BN6PR1001MB2228.namprd10.prod.outlook.com
 ([fe80::cd38:2bd0:a5a8:64f2%6]) with mapi id 15.20.3742.014; Wed, 27 Jan 2021
 12:54:48 +0000
Date:   Wed, 27 Jan 2021 13:54:40 +0100
From:   Daniel Kiper <daniel.kiper@oracle.com>
To:     Cao jin <jojing64@gmail.com>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, hpa@zytor.com, corbet@lwn.net
Subject: Re: [PATCH] Documentation/x86/boot.rst: Correct the example of
 SETUP_INDIRECT
Message-ID: <20210127125440.ma4ir6w7gqahbxbz@tomti.i.net-space.pl>
References: <20210127084911.63438-1-jojing64@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210127084911.63438-1-jojing64@gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
X-Originating-IP: [84.10.22.86]
X-ClientProxiedBy: AM6PR04CA0062.eurprd04.prod.outlook.com
 (2603:10a6:20b:f0::39) To BN6PR1001MB2228.namprd10.prod.outlook.com
 (2603:10b6:405:2e::38)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from tomti.i.net-space.pl (84.10.22.86) by AM6PR04CA0062.eurprd04.prod.outlook.com (2603:10a6:20b:f0::39) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3805.16 via Frontend Transport; Wed, 27 Jan 2021 12:54:46 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 44ab91fb-8de8-45c2-9044-08d8c2c2ba88
X-MS-TrafficTypeDiagnostic: BN0PR10MB5062:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BN0PR10MB5062FDCAF10ACFC90A880B40E3BB9@BN0PR10MB5062.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1850;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lT0yRfZUhw6+71YIPWKrAPEp6goJLxbfE6Chce9mTkXzkbZt6JXepeEy7ivwuPcwnOJnk1lRwf4N8DDfXsWLGhpqBoZWOAjfz0DPnVnBOH73ateiixYjOUjFUbIvcLEK63y4BloM71XU8vMFUjTA7yblN1986iB+gVfOgTR4d4hif5HCXtmCXoikU1enigjKwVrsPuwIN/rxc5ktvGnHkjRUykHDtjwWC7X+y/rlB45GDQIvodWOCD1WRCZmiH4WkF+0R7cLrmEN6F2Gw0t19IdlFxBBvIfr9JRHSvilUZ6dSuznNgoRZsq61FXsooUrjgxR89RU9oxqO3VxjltG/g+dtdA04Hg4/EsT21krjjVjx2xZrkXSVgNwDOZup9oNrfrimsEMB4quguPah7szwgec/ZzklHjJJ2CReeMQ5mo2ZKbiIXhZcdC99zjCw0CcwM/eXExeC2S34diz3SSl6sCkj1DcTrRXhnMvxbS5FUC5kqWN5DLwwXsfF4S0WMv+6qEg9PIXZNEiyiGolg6Z5g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN6PR1001MB2228.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(136003)(39860400002)(346002)(376002)(396003)(44832011)(6916009)(8936002)(8676002)(6666004)(66476007)(7696005)(9686003)(6506007)(5660300002)(52116002)(86362001)(558084003)(4326008)(55016002)(186003)(2906002)(1076003)(16526019)(316002)(26005)(478600001)(66946007)(956004)(66556008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?G561ZYG9iXQm2E9wg7sN5Jj2ccIIHqpSvitEuhpqgkWsbXVqjTi2sDyq352n?=
 =?us-ascii?Q?AsPYS6AOXGMBb/ur4+RcdXT982cBl/H5mKt/TPa4Jbb3IwhsAyINs1/WR7Zn?=
 =?us-ascii?Q?j+q4ny1qyY5Q48QvdQQeqx8DKiGQcvGXvu1TEobmOrvxbm9U8f3eASTTG+cK?=
 =?us-ascii?Q?Pulekej0G5CdBoczGcLmgleRE3HPRKcMojcA6dSG6oezChluFbCd4fFDHkUa?=
 =?us-ascii?Q?MOXi21Ep4H4PqzImqDV8VQTZrtKkYP0A6GJ4WZY7OlA0QPX2vEUbM1cdnBG4?=
 =?us-ascii?Q?RygMgrvSx6Tii7o6jam0GrKsZY8IZgWc2G6vpyVHn0d44U70xzckqywFKnI0?=
 =?us-ascii?Q?SrgD3zfA7x2IuH7Y+Y+bPI6/0HPYwVkUEz2gMJ2l+8/zYtbEtRks+OBYJkYQ?=
 =?us-ascii?Q?KL/5C5gPKKGVGc0TTNS153/8fSvxCa4NJHfy3uPitqKscGWX4UfBX+Zh6VGc?=
 =?us-ascii?Q?g6xb49dDgIo+LqAVL5fn1tOkCZEIN9bDiJxd6xELK4T6o6e9Dhw/8kt7HbMW?=
 =?us-ascii?Q?ULy/CG+5WRBbZzwEAvB0LmGILN2WPsGqd4onCOFfgmwLwQ/Q2F2JNlR4vzGF?=
 =?us-ascii?Q?UFzPCrL8RoGMd9JN75BMNgfLK8ihj3VJcJ4/G4wqxNq1+sAyB4ZX87slU7BW?=
 =?us-ascii?Q?wko7cemyFeklVUymzqJ5S9HEG9MtOQk4bgOZMOYYGDrVRPL7rC9kPCKLSUah?=
 =?us-ascii?Q?Z2WdiGCi8xRr/A4QKOkGar1Q2i7Qotzt9/1aBCoqyNsjIdX9yaAQwWkQ3LRf?=
 =?us-ascii?Q?DaPSfgDFNYjXU/ExExD5CbViol5oTfhj7zotcOXQDqpXT/gofmIb28yN51b+?=
 =?us-ascii?Q?8TbMGI06LW4HAomixPAPrL1bsw18Cu7ZakcTB6CH3aKyEIx6s/nkfbQJ+Hf7?=
 =?us-ascii?Q?bZBv1Rg/F7tstlZ/9RPBw53nodmvgvb5TL2fN7NM9ocYXQXflmN7PyiwOMxX?=
 =?us-ascii?Q?XX5U2/FNuX1+sAfjfb42zLTfy/JJhcYUTnPteb4WoExeG9blVfrnO058dgXj?=
 =?us-ascii?Q?8E/GydYtNWJ+M8yql35EGjK7VLDLZ1m9xAbyYykBlXifCpdb/g+SysdDqHkc?=
 =?us-ascii?Q?pSyO+cYQ?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 44ab91fb-8de8-45c2-9044-08d8c2c2ba88
X-MS-Exchange-CrossTenant-AuthSource: BN6PR1001MB2228.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jan 2021 12:54:48.3780
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: skg2Vda+c9ZmGVq0RQtmVOZj6iCGx3YWUE/wwGjvhjiMKN2YrVBEWxdE7dllksJsbZsFDOutVrWZF0IAWcgBvg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR10MB5062
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9876 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 spamscore=0 phishscore=0
 adultscore=0 mlxlogscore=999 malwarescore=0 suspectscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2101270069
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9876 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 spamscore=0 phishscore=0
 adultscore=0 impostorscore=0 malwarescore=0 lowpriorityscore=0 bulkscore=0
 priorityscore=1501 mlxscore=0 clxscore=1011 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2101270070
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 27, 2021 at 04:49:11PM +0800, Cao jin wrote:
> struct setup_data.len is the length of data field. In case of
> SETUP_INDIRECT, it should be sizeof(setup_indirect).
>
> Signed-off-by: Cao jin <jojing64@gmail.com>

Reviewed-by: Daniel Kiper <daniel.kiper@oracle.com>

Daniel
