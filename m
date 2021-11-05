Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CFC12446179
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Nov 2021 10:40:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232818AbhKEJm4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Nov 2021 05:42:56 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:16918 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230175AbhKEJmz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Nov 2021 05:42:55 -0400
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1A58jCK3013055;
        Fri, 5 Nov 2021 09:40:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : content-type : mime-version; s=corp-2021-07-09;
 bh=sTPglh/QoVFSJFjfGXOLJFdRhFJSIJ/zsQup8h/aicM=;
 b=HgRn1W1QNwWQCp1nQy+JQpvbiH5JRW/f39I/HejpepT4n4xjS/pVGiSDvIyliAyW94+z
 Wj0gxARt3IbMe/YeOz305rHshxJCl/UamNIux9ObL1UykvraM/1IsCwVit5t63O4kk2v
 XGxxOvRczgDdVZcS6cFJxdDjJQkCknqDo45dLNq6jP2wXVowLHxRIpx7tNF+o7NigB2v
 NbmUtu3jxGQNMEIHiFyHYKBtphdvJIS1o8Jv/Bw7Q7N7ozRLVXNvkozE+cD116GQklBY
 xc2zhr3Dr9DkCJQzWZUdWeDxC1HUk81oChb7fnisYZAHK+aPsgWUdoFz1OQFzYDh+0GE uQ== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 3c4t7f1m3t-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 05 Nov 2021 09:40:12 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 1A59UgnQ027967;
        Fri, 5 Nov 2021 09:40:11 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2102.outbound.protection.outlook.com [104.47.58.102])
        by userp3020.oracle.com with ESMTP id 3c4t610n01-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 05 Nov 2021 09:40:11 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=K2aC0qmTuHUWiRGDt/rv8LjRMy9/CVXZZCXr5/nF5JnODJ4sU68QzsPFZTn96Snko3EnmkyIjX9ih0ers5nvP+S06f3COp48PxHCpIkNUi7fFQMZSy5rW/RH/TkhXtZQZAF97lK3KlU43kHsFG0BIRWejUrV8SHmc/0kFpqOI/MqALbDc4hwl6ngZdzWSD0Os9QtVs4xfK0oZR2yGLpSRa0WmOvxT9QivSfv12ft6bEnSFHb+zD601eCyrF2VJtcXTtAvDlDEKea/5wxez2usto2hHkWpSACmAvJbNRDbASM2tS6YTM70c0RWEg1TxCkv4YRSOKaOXPVfFkIjOC9dQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sTPglh/QoVFSJFjfGXOLJFdRhFJSIJ/zsQup8h/aicM=;
 b=L3YWigd5BVg2pH3IhuOD7F5SrBYyIBIToaGGfWNOPSoRv2oaxa1sO8dsJBqVDQAsUjKIlVTCpw+STWy8G9f3ngu8/vFPpgO+Ip2URvBFuVA139pIqkQQ8FdHhzxuUhz+zryj0f3Q5AdYD9vcAOszWmGoQyinV5yErtgQ1v14Myocuqt8nZbY1v2/0BRILblzW6XNba8p836ffZisDVm7ZFOHaV9y73cBYJoHdqzvXTrUQxgLK7aT/839IKBUrnZF1syjzJ9AY8rlTpoA/XzVsYkBaIZvP7u1wyeVWeGVISN3aijsam2B0YYLQTZhg34Q7lM5WHxUldfSOZYh/ONWKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sTPglh/QoVFSJFjfGXOLJFdRhFJSIJ/zsQup8h/aicM=;
 b=DImIzeGoFXOYxW2gqWauVLdUJD8PF8J9AocFIqfwBv9G0hvL6cDJOn0KnrIWm8XpMbpOL/mjzDqUuWq0cT5h+G7R0W/U8p5bwfjLRJ1w+9xi4IrHG9D827GD74u6ZsjdmbnuK2sb5808ilN5WKC1DxQVYCdndvLNOmmqBLKsFis=
Authentication-Results: lists.01.org; dkim=none (message not signed)
 header.d=none;lists.01.org; dmarc=none action=none header.from=oracle.com;
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by CO6PR10MB5553.namprd10.prod.outlook.com
 (2603:10b6:303:140::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4669.10; Fri, 5 Nov
 2021 09:40:09 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::d409:11b5:5eb2:6be9]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::d409:11b5:5eb2:6be9%5]) with mapi id 15.20.4669.011; Fri, 5 Nov 2021
 09:40:09 +0000
Date:   Fri, 5 Nov 2021 12:39:47 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     kbuild@lists.01.org, Liu Yi L <yi.l.liu@intel.com>
Cc:     lkp@intel.com, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: [luxis1999-dev-iommu:iommufd-vfio-v5.16-rc1 21/32]
 drivers/iommufd/iommufd.c:163 iommufd_ioas_alloc() error: dereferencing
 freed memory 'ioas'
Message-ID: <202111050902.NYoMqWB7-lkp@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: ZRAP278CA0009.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:10::19) To MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28)
MIME-Version: 1.0
Received: from kadam (102.222.70.114) by ZRAP278CA0009.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:10::19) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4669.11 via Frontend Transport; Fri, 5 Nov 2021 09:40:06 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 08c9e0c2-d07f-4bde-6795-08d9a040417e
X-MS-TrafficTypeDiagnostic: CO6PR10MB5553:
X-Microsoft-Antispam-PRVS: <CO6PR10MB5553B978272D6D03A9E8A1518E8E9@CO6PR10MB5553.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:229;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pqu2zyIOTMkBD8Q2Ouw4v4jF8UB8BDL3FwMuFtV4c1wsgKD+wQc4U+lL5Ry5W567OuMcdvuZeC1VS73ekz+UpiDX3fsxR7t0jK6rlkss0cdxqT4OjRO2Ooa529e/v7yc+9gWrHBeM76rseQmYSKvcEF9AX0Twz94C8PzFINcS2y1utFoTA1pkBCJMCOHLl0wReOTw73vNSOUQqTXfgcd3aU1A2/94vOc+ww6k5EGWE+teYHLdGuJpnsoOYVDKOpWEOPbM1ANQVY+1wGJzjV+qP7lNlm5ES8HOOA4/fnqbr22XcwGcAsMWatlqHzLIzpmrBFzupu90pLoNSBcyRxA0DDHJij5QO+UnC5YUi9JqDghcRwipFW+CBGRFXeNyR84iOKA1A3CBzKWJVLc2PjhGgOoaUNNB7tzKOFpslqC37bYbkITDqIiW/FkxtD463btaCbOtVIENR/7WkAL6YHdOrrzb3l0YFQVV0WCJvVRl65W1TUVbhjXzcPOxgv68yJjWXfAxVPPZr5c5xM3XxHmp0NPV7Bcbp6L6YE5l5dhO5VeAD6Yewdcz2fSmZEfsqidAFuZ6BlFrF5dUZFtDkCJmwC57C/IQ5PWhlXOMpq6gsOwYAwNZXNTDasMqUC4Jx6IjZj47nXG5B0/4ybPkMkOjUafrhE2F2/TID8Mu3hMIzhjDhQt9WcSfSDnn9pLD0FWQ+13hlIdfXdPrv05lRh3zcrSHS4iLn0WAaOvRR0OPz7moFDTgsymmCjrhLE11usrxkym3AzqSKWjo5Piq0i362/3UMk72zP6ELyHIAuvI8ThQQEB5zv+LD+gI8e7qDFfo0ngXhar+VzFK7rbBx4M6A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(66556008)(6496006)(1076003)(956004)(5660300002)(66476007)(8676002)(4001150100001)(38100700002)(186003)(6666004)(36756003)(38350700002)(966005)(83380400001)(508600001)(4326008)(26005)(6916009)(6486002)(2906002)(316002)(52116002)(86362001)(66946007)(44832011)(37006003)(9686003)(8936002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?NsaIR9mZJURpmXtVTgW5eUbkTCb93r8ifx6EceABCmo87ub0UB1tU/9PUhKT?=
 =?us-ascii?Q?yy+d75kdwg3BrTh3n58/xEqNlg/Z1mC5YFl3EcAr9urhT7qKC8LB5Iwunl81?=
 =?us-ascii?Q?ZqXV3rVgOrUlIVXzEs4DlTnMKvJNoC6DlLNhKnH3kO9z/SHvouQ4zxMs1e0B?=
 =?us-ascii?Q?On202IB7E0tAXpL7D3iOLNzeL5PiJXkaJ/XdjAaoIjY8y5YukqWGUN4swhnZ?=
 =?us-ascii?Q?jhw0bygc9OzWXGfvzf3CuUV1UPqMruqZfdl8W9cfkqibHlE5GEBUOdfX59nY?=
 =?us-ascii?Q?u9lHfstw8b2DkOSwIBYwp2duQzV0YpKa0d3xrim1WW2NLxyR+PNgingVrfII?=
 =?us-ascii?Q?q+VDPzm4X9vCG79hCedU/z5vJj9k7oYBpteDyrjYwp/hzml/zUq8brU9i6+M?=
 =?us-ascii?Q?rlIU48lWRV/x1Aq9s0QWqrjcOYpLK3TeFNETN1N0A/dAF4z90KD4tzUF2CSo?=
 =?us-ascii?Q?dmIzzFe7BztKLi8C2/L7TE12gefi0dqk2NaGqDOvQXcuyDP2QGPnVlBBzPTe?=
 =?us-ascii?Q?m4/kb3XLhwEvQ8ouQrfFzjOlaJFngUahMR4f6nwhj6DFY7Caq+lhVeng1jXd?=
 =?us-ascii?Q?ciUQEouq6fAtGZaY8d7G+76ETO8vN4VAdfYETkGi1lD+aw0Rg1Bw4foSwlvl?=
 =?us-ascii?Q?4x7Rpbd0sT9YLM5esW68Wwl9zZPoccucKEqqyPteBlBJmnASldRcXBhRDbpO?=
 =?us-ascii?Q?umrNQd4VUtZW0MemAHV7GItO01/w2TkTtNYuO2AIiUgPMiiR8Jd8XmoEwrEg?=
 =?us-ascii?Q?iYdjpXmZJU9xcRMcFOvx0zRXjVfKGSHEvZ8mc4QLvD6a7Jz44tTbWoJSLLnX?=
 =?us-ascii?Q?pBTemvdxtiV2YHqbaLp2KqBaKDQJpm6N4UKys/TwOijPzvWPlKEDM2ZimGvE?=
 =?us-ascii?Q?/v8QQxda8tjuf++p53tjxZ2HsErDN0RXFf6LBQRIoSfhJG03C00hUoErl5/4?=
 =?us-ascii?Q?AnwBFFWLf9R1YpFAfRX4QshlmDDLD3vRkRugi2G1Yh1XNoZ2C/eFLlDzYOY3?=
 =?us-ascii?Q?/0l1StcW71LWJDP2q85n4d/Ogo/C+GsLn8fCu9ZWrNDJ5T/usA8AF1rDjWm/?=
 =?us-ascii?Q?BBbTpmNqel2qsmShwu97cFG/d9bkqlRHaASqt3s0Dqo2+pDa5+I7U9YHb0o9?=
 =?us-ascii?Q?TtC/Ptqi+CVgmAguesv7Vfsh/5r70R+u0V5VDjCcTwUGzXnS8X+iYMRDCpLT?=
 =?us-ascii?Q?ju2H9oqdDTfPn9ZsrkeYzWzUcxGBQJtvSfFsT7Qa4ex2lhSt2g3Pl9fLFkCO?=
 =?us-ascii?Q?dIthuMUOxA774Co8JK1DxSdO/k/+KT3f+ZrwnsaYorcalGGeKW5hcmI6hyuu?=
 =?us-ascii?Q?sYOjWC0Ha2e8JlKh6JcDIe17GYaUbkx+U46xWjwAY64d6/rmM+hVoKa9/pk8?=
 =?us-ascii?Q?yGQQ7Fajcq6qh4ydmVxX0IieIPRnMXD9MECtzatYel1RRc6qvRIzEroRJUCS?=
 =?us-ascii?Q?RPYiHLYCeexrbuceKZle7MyBQqdpcb2JwSDuxLOQ/Hkqicw3iRuMW7Nylil+?=
 =?us-ascii?Q?GyppnV/kmYC4q65tShUBxnEtonYQ6Oarwp0Qj8c+93VlxRrJBtv0p7m5cSI8?=
 =?us-ascii?Q?2PGzHD15CUtU+GDwuSSFeuqJJ2pC4nIee0itzED38TixQVgg2pykqyQ4sqo9?=
 =?us-ascii?Q?LqfQjauarcbuSOmDzuNfEefcS/OsjYVyPuV65A1ETEQhDUYWu3bHfp6PQY7G?=
 =?us-ascii?Q?96Cay+iqXISMrbYSexSP2y+oGtg=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 08c9e0c2-d07f-4bde-6795-08d9a040417e
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2021 09:40:09.0014
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1o2nrftIJRXzj5GYtLH3iviAlHHV6/Z+0b5CoSCHQe8PwI7kwkUqcYa0Butci00LrtH+XF3sSta9QIwrRpmMnu+mq3qZ/YQN3oJGbJsDoPc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR10MB5553
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10158 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 adultscore=0 mlxscore=0
 spamscore=0 malwarescore=0 bulkscore=0 mlxlogscore=999 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2111050055
X-Proofpoint-ORIG-GUID: qlQFqCFGRV5wBpRvZU1_dmnQ5l-JigV8
X-Proofpoint-GUID: qlQFqCFGRV5wBpRvZU1_dmnQ5l-JigV8
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/luxis1999/dev-iommu iommufd-vfio-v5.16-rc1
head:   0c6c7bdb5b3f7d4c8e6b03d34a59ac6bf3d02539
commit: a13cbd0a0fca96a74a170239e2e88e68940331c3 [21/32] iommufd: Add IOMMU_IOAS_ALLOC/FREE
config: x86_64-randconfig-m001-20211105 (attached as .config)
compiler: gcc-9 (Debian 9.3.0-22) 9.3.0

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>

smatch warnings:
drivers/iommufd/iommufd.c:163 iommufd_ioas_alloc() error: dereferencing freed memory 'ioas'

vim +/ioas +163 drivers/iommufd/iommufd.c

a13cbd0a0fca96 Liu Yi L 2021-10-31  126  static int iommufd_ioas_alloc(struct iommufd_ctx *ictx, unsigned long arg)
a13cbd0a0fca96 Liu Yi L 2021-10-31  127  {
a13cbd0a0fca96 Liu Yi L 2021-10-31  128  	struct iommu_ioas_alloc req;
a13cbd0a0fca96 Liu Yi L 2021-10-31  129  	struct iommufd_ioas *ioas;
a13cbd0a0fca96 Liu Yi L 2021-10-31  130  	unsigned long minsz;
a13cbd0a0fca96 Liu Yi L 2021-10-31  131  	int ret;
a13cbd0a0fca96 Liu Yi L 2021-10-31  132  
a13cbd0a0fca96 Liu Yi L 2021-10-31  133  	minsz = offsetofend(struct iommu_ioas_alloc, addr_width);
a13cbd0a0fca96 Liu Yi L 2021-10-31  134  
a13cbd0a0fca96 Liu Yi L 2021-10-31  135  	if (copy_from_user(&req, (void __user *)arg, minsz))
a13cbd0a0fca96 Liu Yi L 2021-10-31  136  		return -EFAULT;
a13cbd0a0fca96 Liu Yi L 2021-10-31  137  
a13cbd0a0fca96 Liu Yi L 2021-10-31  138  	if (req.argsz < minsz || !req.addr_width ||
a13cbd0a0fca96 Liu Yi L 2021-10-31  139  	    req.flags != IOMMU_IOAS_ENFORCE_SNOOP ||
a13cbd0a0fca96 Liu Yi L 2021-10-31  140  	    req.type != IOMMU_IOAS_TYPE_KERNEL_TYPE1V2)
a13cbd0a0fca96 Liu Yi L 2021-10-31  141  		return -EINVAL;
a13cbd0a0fca96 Liu Yi L 2021-10-31  142  
a13cbd0a0fca96 Liu Yi L 2021-10-31  143  	ioas = kzalloc(sizeof(*ioas), GFP_KERNEL);
a13cbd0a0fca96 Liu Yi L 2021-10-31  144  	if (!ioas)
a13cbd0a0fca96 Liu Yi L 2021-10-31  145  		return -ENOMEM;
a13cbd0a0fca96 Liu Yi L 2021-10-31  146  
a13cbd0a0fca96 Liu Yi L 2021-10-31  147  	/* only supports kernel managed I/O page table so far */
a13cbd0a0fca96 Liu Yi L 2021-10-31  148  	ioas->type = IOMMU_IOAS_TYPE_KERNEL_TYPE1V2;
a13cbd0a0fca96 Liu Yi L 2021-10-31  149  	ioas->addr_width = req.addr_width;
a13cbd0a0fca96 Liu Yi L 2021-10-31  150  	/* only supports enforce snoop today */
a13cbd0a0fca96 Liu Yi L 2021-10-31  151  	ioas->enforce_snoop = true;
a13cbd0a0fca96 Liu Yi L 2021-10-31  152  	ioas->ictx = ictx;
a13cbd0a0fca96 Liu Yi L 2021-10-31  153  
a13cbd0a0fca96 Liu Yi L 2021-10-31  154  	refcount_set(&ioas->refs, 1);
a13cbd0a0fca96 Liu Yi L 2021-10-31  155  
a13cbd0a0fca96 Liu Yi L 2021-10-31  156  	ret = xa_alloc(&ictx->ioas_xa, &ioas->ioas_id, ioas,
a13cbd0a0fca96 Liu Yi L 2021-10-31  157  		       xa_limit_32b, GFP_KERNEL);
a13cbd0a0fca96 Liu Yi L 2021-10-31  158  	if (ret)
a13cbd0a0fca96 Liu Yi L 2021-10-31  159  		kfree(ioas);

Needs to return -ENOMEM here.

a13cbd0a0fca96 Liu Yi L 2021-10-31  160  
a13cbd0a0fca96 Liu Yi L 2021-10-31  161  	if (copy_to_user((void __user *)arg + minsz,
a13cbd0a0fca96 Liu Yi L 2021-10-31  162  			 &ioas->ioas_id, sizeof(ioas->ioas_id))) {
                                                                  ^^^^^^^^^^^^^
Already freed.

a13cbd0a0fca96 Liu Yi L 2021-10-31 @163  		xa_erase(&ictx->ioas_xa, ioas->ioas_id);
a13cbd0a0fca96 Liu Yi L 2021-10-31  164  		kfree(ioas);
a13cbd0a0fca96 Liu Yi L 2021-10-31  165  		ret = -EFAULT;
a13cbd0a0fca96 Liu Yi L 2021-10-31  166  	}
a13cbd0a0fca96 Liu Yi L 2021-10-31  167  
a13cbd0a0fca96 Liu Yi L 2021-10-31  168  	return ret;
a13cbd0a0fca96 Liu Yi L 2021-10-31  169  }

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

