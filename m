Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E32B1422AD4
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Oct 2021 16:18:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235432AbhJEOUi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Oct 2021 10:20:38 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:38538 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234919AbhJEOUh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Oct 2021 10:20:37 -0400
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 195E0QJu004524;
        Tue, 5 Oct 2021 14:18:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2021-07-09;
 bh=ilc3Z2X/KIXf2RobBeNw9ru4V10fzSrNlKmGIjJB0LE=;
 b=PaaXzfWknCitfRWqEN84jm6LUAf+jHhq6Q9xPESCHszPOttffKatavuRpM5HcEhTG+Uk
 OfywvTmOsgDYHC+NZyaU+Vou3o1pxbkej/f8xwjJEKR7odhCYS1XBTafyac0oTysyoaM
 I7c15b2Lsdzqxqp6rUsUVm/5ouTxVBG3lhwLfzPX7QNL/1AOSPnZLVY+6yM+sPF5RDZn
 XoI7g+wmaTZ+UwGEDaG9k1ouaEwasOnwVZQkn6I9uJt0P+59tTk9qjN3Odx5eUDrKcbs
 jxWgMvLeqGz33w10izbl5kTp0kM0oTLq1582uzomySnOq6+k+7+nLB5wNMmPKughrqYz mg== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 3bg43dy4v7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 05 Oct 2021 14:18:29 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 195EAf8R146020;
        Tue, 5 Oct 2021 14:18:14 GMT
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam08lp2177.outbound.protection.outlook.com [104.47.73.177])
        by userp3020.oracle.com with ESMTP id 3bf16t3mk0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 05 Oct 2021 14:18:14 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=STbkhPPZi9klrCVWpEK2n1outHGeKrZ/7d0qGc/18VU39nX6uR2NQdu5t/5JSCAVgSrV8bq2VNitFQIHsbHya+a8wUaGHlXRD1TjqktpN386TxmwRG1jwoqzy11Q2E+//zGc4+RPn9MMBSyrdz2HRX+APtyP9B4fyMaTYiuzGE1Eu1PaiHiT/SbXX91jsxYrPwhlXC/ttzX1NkWADZHqVuJ4hsmFy6RmoNyCtU7UnPg98LX6e46tMm71MUVBMKTA7WsQa2xlBldKzw2aO0f7cXOV7yLYY7uJtqStWourJw4AY3JQX5SEPCArNHl5mycbzs0Q9iXDNOyG0gmPkBLE4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ilc3Z2X/KIXf2RobBeNw9ru4V10fzSrNlKmGIjJB0LE=;
 b=mz9WENSiRQVmwTJsNbOvJxKGEq9vmgR+ymTn9insMHUNhH9/o9bAzhqb6MuTTa0SYVhsDdZp3ZLCeU0GmFdVoKxxbBl94c6taoLxUHqBkaWbxOuVmxSE6DYfPPWi31C9Z5QxNn9YuJ3kdGo3Ks2y7FGEc/Kg7n1ETbgj2bcdm+Ips3Kq/NWAdMWLIRiWgFoMFPj/rBcwV3GKNrowKp4dg60rM7ocM1YIpeBRtSkb9ruYciGQCm0kVRohC2aYt5NhwC5ilmhL1sJdrkiXxQmSsTVjhRlvm2ag9wl4+6mnjOexxpaS6EDQ71cE6QTV4Ykgp4QV8MP1UuCO+KFOc8y9Hw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ilc3Z2X/KIXf2RobBeNw9ru4V10fzSrNlKmGIjJB0LE=;
 b=I5FtH+nHxK0r0r7wBTXu8xvshSZzI3pKgcW1AIH1FVS8LWvihh/22dHMaLUZvXy95H7PBwGdNXBgiHbEPs/he2E7NGZ0ly4FhzXe1Xdfi3Nn7wnBivXcNokUBARm9z5BvkagFOfAinoqVeUKGrRriyb1wO5JzkAYoe9uZllhp04=
Authentication-Results: cogentembedded.com; dkim=none (message not signed)
 header.d=none;cogentembedded.com; dmarc=none action=none
 header.from=oracle.com;
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by CO1PR10MB4724.namprd10.prod.outlook.com
 (2603:10b6:303:96::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.17; Tue, 5 Oct
 2021 14:18:12 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::d409:11b5:5eb2:6be9]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::d409:11b5:5eb2:6be9%5]) with mapi id 15.20.4566.022; Tue, 5 Oct 2021
 14:18:12 +0000
Date:   Tue, 5 Oct 2021 17:17:55 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Nikita Yushchenko <nikita.yoush@cogentembedded.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Lee Jones <lee.jones@linaro.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Christian Gromm <christian.gromm@microchip.com>
Subject: Re: [PATCH] staging: most: dim2: fix device registration
Message-ID: <20211005141754.GX2048@kadam>
References: <20210929205619.2800-1-nikita.yoush@cogentembedded.com>
 <YVwofSvwGTv3kHjh@kroah.com>
 <d309b4cf-12f5-5f49-fcbe-3141dff9e73f@cogentembedded.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d309b4cf-12f5-5f49-fcbe-3141dff9e73f@cogentembedded.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: JNAP275CA0031.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:4d::7)
 To MWHPR1001MB2365.namprd10.prod.outlook.com (2603:10b6:301:2d::28)
MIME-Version: 1.0
Received: from kadam (62.8.83.99) by JNAP275CA0031.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:4d::7) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.16 via Frontend Transport; Tue, 5 Oct 2021 14:18:07 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5efbeb50-44b6-4fcb-9086-08d9880af681
X-MS-TrafficTypeDiagnostic: CO1PR10MB4724:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CO1PR10MB47246AE43A5CA5D6F65639B58EAF9@CO1PR10MB4724.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1388;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CCwaH5qY8+StBHZ7VhlnNNmvS8dvqVAGZsG/D5n2TxhlVK48ygBZWcZDmC3aGF3C2T1Lo0dR/tDy5Kg+96eGUZmTD4c5wYo2Dx940ne9WH79zjFGogK6YaXO77qs57/CL1hZGWm8GUPfaDRmK43tgjdTUkXffKSyIvoTYfuEhrbrvyhnTvQOKB5LOn++g/Tl0827FUa21T1ijneSDKecmidVgSPPZEYKmdaiuxgAwhZzMCNCFsevSQe6vL51NjeSaXnO9Pfu/MQ5nIV/NpAALk1wEsUvJCRiAQqhMbjMFp7OhMUkIW5czhcZ1aPXd0jm+3DoMqJKUXPQwRSjLQ2FjUn/RZ/4wl8IkV+vh3QSPn9vRfstKnrwdkyL3prUy5xG4+hvShK2gbn+UlEQvDnvu4Nh3sPWB8xjFmhCAqpJMgKPAGI5vZJvFs5E5OUt9RJPWkNCKqZt71bjo6jOcdpsgHCVovxv/sGxnJ4TkW9YxYquHXjjPvRQn3Q5ZQtQVTvG44RRFECJ5HbcEbizxh9eoL4QkYP+Um3Sl7Fg+Ut9M33l6VUOMCbsP8LOBf0o9MHEh/yVEdpCWli9MR7wlBiythF77QXQsnI5bYWPnExsgxlSqre7sPimOcrRFkWMvgbdy0NWa0vDmjv5O/fiww4UFrtEDW/ul5LPNnxzlgib9nhcfAG3WRXnPwhS74ky+iXsLC6qQa10Q0r57zAk47eRWg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(55016002)(66476007)(6666004)(8676002)(66556008)(316002)(508600001)(66946007)(38350700002)(4326008)(4744005)(38100700002)(6496006)(1076003)(956004)(2906002)(86362001)(9686003)(5660300002)(33656002)(6916009)(186003)(8936002)(54906003)(44832011)(52116002)(26005)(9576002)(33716001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Gkv4K5mCC/OAbibW4My1KMdFN48gYLzjqJYTtiBjmpC3v/EnxKlefwVkBAK7?=
 =?us-ascii?Q?t3EDxjLJ7piOwdM6bjTLc/ckw1vaqiw2pP2jQyPF0uFxZPray4Hv8SlezeFn?=
 =?us-ascii?Q?sJH9ZbcEWjASKo6+gwFnrRDF0AtlaiO3ICU5vtJuc5DmX9pje9Hg9vMSxcoC?=
 =?us-ascii?Q?Psq2MswAY4S4TEFaHo1kR7lG5H3CwQ937WJU90g8kzlDUwWwQuJgtPlezGW7?=
 =?us-ascii?Q?K6JHu3PRX0wrS21za6u4tqp5/NFdQ698SixIEYFIAjViR98Cdek6OK9VEQ58?=
 =?us-ascii?Q?BDuL38yuG0bIS/s56oPbZGiWDNd+4GYE0SNO1bYtR0OBa5aExavFqt5wAMdX?=
 =?us-ascii?Q?Wds84FiL893rv1P2rHVWkGjOAkghFc9LkTRVsYgZdeUUcSv7sKQeBL26ztvL?=
 =?us-ascii?Q?MnOm4mLy6RXsSBgkmir4Rj/PBwUNZTg7Rno5PxkPIcT53qJkw3bYYX8eBnRh?=
 =?us-ascii?Q?PXdVeeNlgH0t4zEXhcakWsG5k2r5qWPvKu7Ywim0tpb12NVWFfm3BFjEyd4b?=
 =?us-ascii?Q?O8BF+dO5bwraRmA7DP91ZJzs9qrQ3qEQEsCcIDOB/vptz6puOXmHKDj4G2iY?=
 =?us-ascii?Q?L2qdb3lYCWFvz/J8rTsX7fkYZmB+mKHRoSXOz8MKxcpHjek5V0azBc847O8S?=
 =?us-ascii?Q?XjA4LH2o66UekkK4ZPk32fx/ZRdlW/OrjHGaZ8jubi5GPemxajqi8n9qZes/?=
 =?us-ascii?Q?f9FZtq/Nfa9eGFDEhguiJ4N639l1eMGcZtCZXDt/spoLuKwMj2AnXYe1whma?=
 =?us-ascii?Q?SxprS15rBv0ahZ8grH48RFeR7Uw9zhuE0hdEYZXGV2T4LV2Q5nk4Nl0E+m1i?=
 =?us-ascii?Q?2ezHihEO+N398sKMu1W+lYig62JZDCtNKr2y9HoirUyVsdipM5ldyRwWaTkk?=
 =?us-ascii?Q?nJ70z/4V1NoSCIAPDlndEDyoyMvwQ9R62KCMdFjuBL/0u+8IqgDr7KKIKg65?=
 =?us-ascii?Q?9IlL43JXO0WdsGM3Gr5ZPe2OHnwd/vDltEKwf40fbN7ZF3atOXpJKDho0RMS?=
 =?us-ascii?Q?BH2S5CYIhozv51xr5y8RXjEd0VaHnEO5X0pPUUfVbcY7Eys7EWfVC020GC5c?=
 =?us-ascii?Q?1B+0338aVEcZP/EKPPmsEH/SA1aXsoWvk7F9WZZb0gAsNKSL01g2CetZDyJE?=
 =?us-ascii?Q?79SIu7MNPdsG5oSW9LxFVTKgzZ4kF6q3ktiCzXUKb8LvfK0qxUkKNl3QI6PW?=
 =?us-ascii?Q?KbyPIL4V8m+sZy1IHVcobdhoct9/e6/vj7QVnM/mTxGWBD/1tR0dwA7eOruB?=
 =?us-ascii?Q?J5ibe3QeBTVdfDkOzIgaUMiPM41pPT6MjW4V7iKnc4MbAZ/oH/Zc+zhL8jLs?=
 =?us-ascii?Q?o+V3YsspLazt2zdpmIbdcASo?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5efbeb50-44b6-4fcb-9086-08d9880af681
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Oct 2021 14:18:12.3478
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nwJWA0wxXDOkitUN11/i6/2hESa/dpqRZwj4OWGae19vQ2vmHNEIwyEW2xQMPcTePZH30rJpH8Fx8j7ohs/YFeAltp9qiR0HmIuRl0CZ2TY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4724
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10128 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 adultscore=0
 phishscore=0 malwarescore=0 bulkscore=0 mlxlogscore=999 mlxscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2109230001 definitions=main-2110050085
X-Proofpoint-GUID: RYfalnpE8LV2I_-0oEqqNu94Vig3jOxa
X-Proofpoint-ORIG-GUID: RYfalnpE8LV2I_-0oEqqNu94Vig3jOxa
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 05, 2021 at 04:33:02PM +0300, Nikita Yushchenko wrote:
> > Also, why have you not cc:ed the original author of the commit you are
> > "fixing" here?   They are the maintainer of this code, right?
> 
> I was under impression that "git send-email" does that automatically...
> 

The ./scripts/get_maintainer.pl does try to CC them.  It's working for
me when I use the script on your patch.  I normally put the author in
the To: header so it's more likely they'll see my patch and Ack it.

regards,
dan carpenter

