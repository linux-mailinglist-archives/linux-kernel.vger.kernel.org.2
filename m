Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA57740F684
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Sep 2021 13:08:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343819AbhIQLJj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Sep 2021 07:09:39 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:55322 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233439AbhIQLJf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Sep 2021 07:09:35 -0400
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 18H9ueVl019306;
        Fri, 17 Sep 2021 11:08:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2021-07-09;
 bh=OISkejdCnUQ7n1u+9AO5cwXNSfG1nz9xfUQ6TViyWls=;
 b=q6dNdd06uponSFk5oUEggW4QAEPE3ChodP+ZMu1SSNaVbQYv12aSMvkBYflUyGDElKzb
 C3184aAtKJXyIKUOebC6phaQz6k346tQe1rZwoZPuepkK8u336L4w8sJHHlSZ9zTXFoH
 wfFBLnQXIwdKlKQx7maXZEmwCBPiileN0ItKf9Mecou1kcNFENYnqflMx2bv2jKoLayG
 tSlsz4VWMx2zJkuoHeBtmsSJAtLPXxksW39RH1+ZjmvEi6Y/Mn5XXkviFuqNh+SEVB15
 ByuZ9Rl29bLHC0KYyhNtNTIbOlh/NVcGjdVZKdcGgQXKXLKDrhfMZey5jUzd3Lx6fVyl 8w== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2020-01-29;
 bh=OISkejdCnUQ7n1u+9AO5cwXNSfG1nz9xfUQ6TViyWls=;
 b=YQkOaV+/l0WiF9orWaIH8aj5jdRh6fkAwWlNS9HiuNZOrDVRlOFyLF/IwaCUUqLAd59O
 V463o8sutz0kAQ79MOxySvIElVpaM4P1FL2qEoSEn77Ak3WIQgXU/KBSYFfBCJO8ZTXb
 seskZ5Pg/MfGW1YlBva/ARZXtZgDGz1sQTJKRtQxQ6d2YKZHVNbg2K8G35KU5PImtE64
 f5/TprvpK/Y6xBqyPsJUcD4lmpvbzWwS4z2kFvwx0OG2D/EnE4wyw8JlhMfZIWWHPGpt
 SYBRfRdFniqzL7jDKyB/g9Hb0HYWlJCBAnUDBHda1sPci4GuKgbxpk7uB3+pvdt3aOgH mw== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3b4px88n6p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 17 Sep 2021 11:08:00 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 18HB0h2Q166401;
        Fri, 17 Sep 2021 11:07:59 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2172.outbound.protection.outlook.com [104.47.55.172])
        by aserp3030.oracle.com with ESMTP id 3b0jghgrsw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 17 Sep 2021 11:07:59 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TYAbPVW8zlfjy3SGI8uM+SEEmmcip5yZhfv0gFK0GDxLoFc8QH3az7ebwnmqTveKEoXjgVyEegG4JAUjJHeKaYN5kDNlDWP/ewukNhaEPtmov0VE3cPkmE2KY0wESTZZmuECxE4DQb7zQo9rbCbf6djzWJK322iUKqGzwxI7QPu3WMdGSXZbHQX2YpSZxPqD3cuyiRwBqyI6qL0Dib/AOU6IvQ93cuMz7fBee4zsIHQDNg8wN6lkJzo8svj3rHJfU+yyOywEhuMZWhQR1T9bULlwbcwJGNQBN8tbr3kGvPmIO0XnSuk4D3Gvu3OgWXqmcHOxHT8LItv2cDp0NbeVQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=OISkejdCnUQ7n1u+9AO5cwXNSfG1nz9xfUQ6TViyWls=;
 b=FXcsO2fTXR0ZzIlXQPHDiyuhinmzIp9susYyKgjp51YPxdNO8V3oxfTz3nzGz7Xmxn5LV+9aRUUeof6qrv5rdu9JJswYwIkh7fDs5OSZd42C2mvo4/4I8VobnSGYbbgf+SxUKzP2/3yOB7YzQZOFq4yTMnARvUwj8uZpuxH94+Uoa1pN0dIfyEs5+6zg8SZSgMirKgy55MYSdCL6uHI4ZJYSFDgVJ9XsuqNVUXeNt/5yVj97Qzq8EbkNWcZCUhBLMFtXWIvQGu6+51k1kebhm97PuXo2YtCSGhFBCkLW+Q4J+UDLRe7Sa8uVtHCjWXEUb5ul8wFh9uOVjpnV4rh5zw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OISkejdCnUQ7n1u+9AO5cwXNSfG1nz9xfUQ6TViyWls=;
 b=f7EfO/pq01qEbx2YOQPPrUEkLQBFGj9LZDUbrDJ2jTCvjU7pJqFlOs0KmsVfhmgpbmNf2BJH4LgOswnrFsxzVsIoJ8PWLMSvvNPd25NYa+dyW8arX8+bE+HaXe2PbuOGYss3xJ+SsDd2D7YWo5TmBL6zD1mRjVK5QoihOW7sfKE=
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=oracle.com;
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by CO1PR10MB4466.namprd10.prod.outlook.com
 (2603:10b6:303:9b::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.14; Fri, 17 Sep
 2021 11:07:57 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::d409:11b5:5eb2:6be9]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::d409:11b5:5eb2:6be9%5]) with mapi id 15.20.4523.016; Fri, 17 Sep 2021
 11:07:57 +0000
Date:   Fri, 17 Sep 2021 14:07:39 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Pavel Skripkin <paskripkin@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        David Laight <david.Laight@aculab.com>
Subject: Re: [PATCH v7 00/19] staging: r8188eu: shorten and simplify calls
 chains
Message-ID: <20210917110739.GN2116@kadam>
References: <20210917071837.10926-1-fmdefrancesco@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210917071837.10926-1-fmdefrancesco@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: JN2P275CA0045.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:2::33)
 To MWHPR1001MB2365.namprd10.prod.outlook.com (2603:10b6:301:2d::28)
MIME-Version: 1.0
Received: from kadam (62.8.83.99) by JN2P275CA0045.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:2::33) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.14 via Frontend Transport; Fri, 17 Sep 2021 11:07:52 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b642fc37-6292-47e8-4e55-08d979cb678f
X-MS-TrafficTypeDiagnostic: CO1PR10MB4466:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CO1PR10MB446682330CE69CCC374C26FB8EDD9@CO1PR10MB4466.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2803;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 41nreljGSFL33X5RMskwnL7zBMTnoY0L7Tw9hn99kyg0BQGacE1Wb0zu+pzvl738RWDnL2ALx92R/bkihuffgfoCWIrXzL4NiO4iesOmK46XN8+OLlmW7G/aYnqMhglvPW334qZ6x3GNWnWuSDbx01rSgtOpnU4oZIy4Pkl1VPc727WXMtjQ81D6USR2Wt5NrDknsYDjJv4ZUE3yhFhix0F9XXjQxMM6QPBul27SD2P7XO9lxB2OeyQcbHoIY8ejxv/1fb1L/nTD2zS1OGpfLHBxs9ej/d7od3qpzz3MeaNNcAvW6XrTRvFRIHci7MtcUKLVF4LhpKaJjZWgptk9Dab6TXNsHAkf/kntMn3G8/u1yNjBsFcqDEXPwAASIDN0ZZw7ltR1SUcLl1xyI6NFijsHiuj8uxKhwvK+yHqnG8SMmEGDWKA3Su5f4jdSnguAhh+2FZXN2vgRuLrx/wsrgc3IlwZc5VjqUVt8w96RTG85oU1WdS430rnYyXMwP7InqRNjMlr8w2mv81QR/+orODjqXOSs+9Frxx+kbix5cIGOc4WA9F3kZ/nRTuOOn3N75twjYP7PztE2BiTUbEEtyRoAtsWhqMyttTvT36F0KvWpZIwKfg3gJwR858amziZm/5Vm3lAOC55Nk2EN1T3H9MH30Vp9KFRDF2YaEYE6GjWOeFw5vHTY1eM1VFCY1DP5E0prceVJqyiCk2b3xnwLog==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(316002)(38100700002)(1076003)(54906003)(38350700002)(8936002)(33716001)(86362001)(19618925003)(66946007)(6496006)(52116002)(66556008)(66476007)(26005)(558084003)(6666004)(5660300002)(508600001)(4326008)(9576002)(2906002)(186003)(33656002)(4270600006)(9686003)(6916009)(8676002)(44832011)(55016002)(956004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ZaoAAglXDfO8G0Fld2iZ9hUEOhwi4d4yC7XeV1bWcYFdx53YqKbaLnn9IKZm?=
 =?us-ascii?Q?YPMOoS2gQyWdgs882/uiQ7iI0Astps6mGZJUdkM2927lG4bOLMPQAdZemiNR?=
 =?us-ascii?Q?5VhCRXQ7UfjOCnLMwM73XwFql5d6HVeoR8X9r4xfAmsPdFPHFQC1PJSDzq+i?=
 =?us-ascii?Q?5DFcX7Y3GYAHOiSLtaMn7lpNJ6EErlAjkJWiiKwZFmdYdCUiEaDrXPOImyca?=
 =?us-ascii?Q?zc/rYe1RmXowdPKKTzzoREV6ufJgUr10wJHup19esKy+2CZ/+SWWaVStE+b5?=
 =?us-ascii?Q?GQaX+n1uGBq2LJxKbVhyrasE7CKhMlKeHNzeToEVLz4CCdkVg/kYZbqptwcf?=
 =?us-ascii?Q?Vb2zDCRsUSTTRV4HVfhTKkhc/0GvtA8Tc4fdPXypJ2dlIDEGBNXrB4qy6jg5?=
 =?us-ascii?Q?r34cVvLBiteMiZ8deXcVGfmEQPrdFw48UgJRuS3b0vHk+YlJkeVp7j2xGd/8?=
 =?us-ascii?Q?5hIjBvG1gsIwR9YxOOhpoDbPIWrtdHTjKATTynuZ4VnHhAJL1dPDwAO8Ryej?=
 =?us-ascii?Q?xMroFvW6lZRV5aRFx+uwVoyEG8Q1JjI3BjiJ84zdxqrY4NdsEnHF3R5CYpqo?=
 =?us-ascii?Q?ZpnahkFr5K1+ngnd73S4iAumHimGnvu2pyJlyigOOXI/hxjBb0AN8YrwvjA2?=
 =?us-ascii?Q?PfYsAbPV8Xmcr/nCkdrWtGIuom0/zQTQ0O47RjZOP5UqMz1DMv7ILjGrEc4/?=
 =?us-ascii?Q?tvAoeFArmZGAkdw0JbVsHignkyAKm9AKR48QvUXoW+dDoCPCLFoqVTH/AsS5?=
 =?us-ascii?Q?vCO71LPzNY8QEbTup51dZ/3kfO6USPvfzR2ESqGk3NQho/peFkZQrS6Adgr8?=
 =?us-ascii?Q?X79jJ6kxRDkWaZyc6OgnsUlihKsHPa8oTUK4hQyhvi2H3ZZFaCkgLCf7maNF?=
 =?us-ascii?Q?5BJ6PkGKBXegHPpA4ge/oLcJ5KZ26eMCMFdKDOiUJGy4AzcTVY+s5zww4eHP?=
 =?us-ascii?Q?X+F9yJFLvhQZQKO04kh51kSMz58uoVd+NLyQtc7StfCXG+7W2pUUNBDv5VxR?=
 =?us-ascii?Q?pIM5j00+1ss2AesSlBI/69KElojKHX402VRvEtot6MoPKv+y03qm0+7OcfDU?=
 =?us-ascii?Q?1n8FHPL9pZleJnaQvfMnwCyz3TbkdFcKo9ewEFXdcRw/hlUKcjjoostPvd6t?=
 =?us-ascii?Q?DDjUPtbadJqFIWSSBiCU+2lrXvIQuZ1DYnNkUW4d1jwHf+vbeKnQMjOoRBGG?=
 =?us-ascii?Q?QOnbSxRz9rVRVPhLmGTG3xyY13aantGW1lMP/b79YOlBvCj1CccB9P/3q/cr?=
 =?us-ascii?Q?yTb6deRxLJRTb9MsLI6I6MS74C/0J1mDNtoySGHGWU9k6BCr3NI/icaltrIE?=
 =?us-ascii?Q?FHilz5vYc7MJiuZ78LPv0f/1?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b642fc37-6292-47e8-4e55-08d979cb678f
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Sep 2021 11:07:57.3642
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fyUYdL/NmFHw1IrK32huXbsuHhCEKTQvwKTFIKVJBlkUgUL8g4IfCY1G0exYtuVOsPD9jIpUPETIGQg+3NbdDqsd8zWc503l9LQXLSLWwVg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4466
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10109 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxscore=0
 mlxlogscore=860 adultscore=0 bulkscore=0 spamscore=0 phishscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2109030001 definitions=main-2109170072
X-Proofpoint-GUID: olMfkbNN13CNJTUWk6Xnl6u-JJESV2qN
X-Proofpoint-ORIG-GUID: olMfkbNN13CNJTUWk6Xnl6u-JJESV2qN
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Looks good.  Thanks!

regards,
dan carpenter

