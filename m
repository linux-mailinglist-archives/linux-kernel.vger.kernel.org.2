Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 33451452B09
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Nov 2021 07:35:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233828AbhKPGgr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Nov 2021 01:36:47 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:47428 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233041AbhKPGeZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Nov 2021 01:34:25 -0500
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1AG5MKjY007670;
        Tue, 16 Nov 2021 06:31:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2021-07-09;
 bh=yrHd0ae0zzzIQ9ZNqweCi9mowWIxnD6huGFAhZNXiTs=;
 b=py5G+tieo1srxKO6B9nh8enKrt/Rx1RULt17I+m4orwvuNbQ6Fkw1i63Q0H/RQjpKpzD
 Qvc1VEoD/xWBZI5mlbFl4dREYuBmUSvxI/X8u7rVufjxS8gWjBTd3OVZSQRd/fLw/WBp
 dXnSRMNBisCGNr1eX+lrVVH9Iw/OmFc9pzGGyikS1a3gQAlRDfeyMOUBcJa+qyY7y5rB
 ZavayXuPqeNqlWap8ACyVa3dTTa5nBCX6Jf6px4mkSFahk11XEmVaa+C70kMNLw/5lK/
 s80/fyRi0v0ESeGeBAKRGHUBNB8ELnuHuir4J/8KuSRCOjL2cvA+JUDBSLrwHi2+Sjvm HA== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3cbhv57f5h-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 16 Nov 2021 06:31:21 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 1AG6Qdmg022799;
        Tue, 16 Nov 2021 06:31:20 GMT
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam08lp2043.outbound.protection.outlook.com [104.47.73.43])
        by aserp3020.oracle.com with ESMTP id 3ca564ygkq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 16 Nov 2021 06:31:20 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Dk1abB2jTB3gPqsCqbAfKJMbIJeF/x+NJwD4BCsztaKnP+yh+nx/fh2faJRq/yXDLSYS2n3mImKpN9xZGxA08T0jj3H5Ix5eN5aeT2W6T4YQ4oYGU9oWtTFbBAgzKfcOM8pXFeP0xGSYZicSSiL6u8WEajFJFdvxC3MqKxvevch55e833WMEMhbLt0ksfIahNr53vqbdmvaf8MiA4bmCcGWVWo2tHXSigNh6c0MYpanpNPBO5sHYC1wWITNanp1hbVAGm7cTfKpIbfxN0ES6xftpS9779WC8uquBXwEXYMEpJDVLCZRi4YO4xAsKGVWVNyfQn9+oGAt5ZnXc3RIM1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yrHd0ae0zzzIQ9ZNqweCi9mowWIxnD6huGFAhZNXiTs=;
 b=DYZOEn4kVpIs9BHTLnKXsC9N+qBRUQp12gfytvXElVWsVkt1J3yj0JucXv+y+iVms9gviVrsUR900t5jHQKNt+2raNN9GBeDpPcyAuBGoBukMlPRZBbcf+yFFW2whu1lW7AgR5VAfQ0T3RjZfeG+XyTVzE8GxAJHir8fbwSbodKOLTCmfVJb0gKKp1TiuVzg3Yuv95OGeUbg4bYynBQKSk51SFgzhVJrNnZj9WEfHLTOa752Wj/9NnKlAuz5A/r8DilcKKwLz7C/l4Jmh+VQBHj20HGHNfm9dgXDL1/ZjuNSfMXAGwK6YAnCK2bH4y8OusD1Feokkj//Lbuqd1igkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yrHd0ae0zzzIQ9ZNqweCi9mowWIxnD6huGFAhZNXiTs=;
 b=GK/11nshlMlnMFnGN8WQb6OukvmoY1tCjKesBzlA/ydw6oB/Fr/Fwcj9ZAY2mOB11tmVIa6UxxF8SvXiMSpiIgWrgDgm2x7svze7GU/6DTxGjp9Xn/ISYTfXmRW6uazARexV/ajt0VhCJRbTBwd3PFYsOO/nMGSqgx+B7A/hNp0=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by CO1PR10MB4546.namprd10.prod.outlook.com
 (2603:10b6:303:6e::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.19; Tue, 16 Nov
 2021 06:31:18 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::d409:11b5:5eb2:6be9]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::d409:11b5:5eb2:6be9%5]) with mapi id 15.20.4690.016; Tue, 16 Nov 2021
 06:31:18 +0000
Date:   Tue, 16 Nov 2021 09:30:59 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Ansuel Smith <ansuelsmth@gmail.com>
Cc:     kbuild@lists.01.org, kernel test robot <lkp@intel.com>,
        kbuild-all@lists.01.org, open list <linux-kernel@vger.kernel.org>
Subject: Re: drivers/net/dsa/qca8k.c:944 qca8k_parse_port_config() error:
 testing array offset 'cpu_port_index' after use.
Message-ID: <20211116063058.GH27562@kadam>
References: <202111120534.jZEya5QR-lkp@intel.com>
 <CA+_ehUyjDVdEe=64WbBihqSQrHeKSHx_8C3pcHctgvWy4dvnJQ@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+_ehUyjDVdEe=64WbBihqSQrHeKSHx_8C3pcHctgvWy4dvnJQ@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: JNXP275CA0010.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:19::22)
 To MWHPR1001MB2365.namprd10.prod.outlook.com (2603:10b6:301:2d::28)
MIME-Version: 1.0
Received: from kadam (102.222.70.114) by JNXP275CA0010.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:19::22) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4690.26 via Frontend Transport; Tue, 16 Nov 2021 06:31:13 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e46c28b3-943e-4699-f8b4-08d9a8cab262
X-MS-TrafficTypeDiagnostic: CO1PR10MB4546:
X-Microsoft-Antispam-PRVS: <CO1PR10MB4546839C40E039BD742824088E999@CO1PR10MB4546.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3383;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ejm+InFMr1rIMouXqcjr/JzWNEFQP95rHejCvUQvMI+bDOwEGu57RMJqWLFAEIkYQpCQmmlGKiPhcEOJyuoy0BzaVTxZsnQII3JK47uDhiYe1zKu8x/VO3rumvAiU+OuUhlQXbTKAGkP/7bN5uHuSo5bh8BNnLxaD2zSkc+qZ1J+ZEc/wK3+iKe2tWOFoSoUbQ08CXCjCCm1uPyjWITXRpQMl7haE/OyHZ/0J8oiuh843rxsFf9aQn8J/bMhPsggSLM7MdRugYcDwtYRzgVYdCwSzSYp2Indo39kjm0UgpgxZ+WhJUk5ZuF16vNdx2u/UyRx8FRq7t+dtXhCV4cGT7aWg7/Vt4FqpcagVrKWwGqqAp2rKmrIybDv92011G7omTyTdsUfJw1TWLHN9kfNVOp4GOBPW0wIGMCgrhWqWAnN7R92e8cVqKXxkQ5xd/pYNhDT+LUKjPLvLgRVTObODylnSvOQjACt5CRWyGsOLm0HdrpE1X8A4vnldSMMaUjntqNgoQKK5llTMTEAw+WcTIUSCg+/PG4e0fKvUt7ST9v4y4lyNuUz7/X9FappBf8ut+PbN8zsApIwpv8kQ15OUxUoqNz9AwTyD6hvKQgntRRTRo+QFzwNDBe7tRS/O49Id1ZrTZOC7sKHwhCQjB/bmtP9ia48tUsfsS6m+F9EhoX25MiBpz3Geb2nWQdEToNL1aWK/n73WkQI7Ii32Nlr4usipGzK6oZD7X9F5h3VQH//mnY+qtovpFP57sga4rs789nW+CizoMcrbLI2j5GHXG5gbuQC40G1y3m69iIShcJKZP5njSVPqWoFnU/vZLpXYG7istJWH6+AnQbqWclykQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(52116002)(6496006)(4001150100001)(966005)(8936002)(9686003)(8676002)(6666004)(55016002)(66476007)(66946007)(9576002)(38100700002)(956004)(66556008)(33656002)(38350700002)(54906003)(186003)(86362001)(508600001)(44832011)(2906002)(1076003)(316002)(26005)(33716001)(83380400001)(5660300002)(4326008)(6916009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?kfX6Ip7fqOwUqbZSVxOyRs5k8MzqmVqkpaohCs0ypDr0hI73nedOREPB2l3m?=
 =?us-ascii?Q?oXZepznauWoP8mpiNxZVLXGltuU3BYRzyrIVtiVjNJElqfbKtvRs5cg27EGa?=
 =?us-ascii?Q?1Rfrso7oGqCf0TjK5xnaNrmqjuzPbtYzw2HIOxhEECPUUwB4yQyvXcA0eqrI?=
 =?us-ascii?Q?x3Hb5NltGP+NtAMRLZE3Dj52iip8xceZPxE/gXfzk5DruTGbchbbj21Gr3yX?=
 =?us-ascii?Q?bVZQjDN9k/+i756hdtPGNus7TfyHVNB/la0RC+yEdGSJIrnH52CeeNk3xzhm?=
 =?us-ascii?Q?WLyzaxnxfF24g/v8j5iSshcyyjRUCFGO6WG5s+pEceZtC7VnFBHjfyxgm3BF?=
 =?us-ascii?Q?HWEwsS8otiKgPU6bQMq2+GzkiCm2PvjSwRCV1qgYVR2YiZA41JXxU2v9be7F?=
 =?us-ascii?Q?FsQL7cQTMjssMx+xNlo1Eo1U3IUmN73LVMkis7vZZvlxotpPxEjQOT2pEwTe?=
 =?us-ascii?Q?jWbjk8ODmvXdufUTKL08ByQGzK/OGjBykMtPW1i5U1xw/ogT5TXMof1c+hGG?=
 =?us-ascii?Q?cm0VMW0m6ihesEfB5DDJeaUd5+gonHConb2F5csbKZFQjIIWxDu3VFvjnlg6?=
 =?us-ascii?Q?2DDED6TaoFke5dEGg3duYBdrX+50oA9PTuFwjqU3XOqaxx3sWHm4Cd5MuHSe?=
 =?us-ascii?Q?8L2oy0Wpnd0QoqdHPHg/J7STXnlfN4cFLgihpFfX9wG6CqAzWkh0sOjg/ZJt?=
 =?us-ascii?Q?TzGC/ojDGpyp3q6XOOIJsIK69pC0V2uMLCM2rXv3jdKE/BNdVxCqr2FMlNYV?=
 =?us-ascii?Q?P9CIoEP6+OZC7aQJOBCRF+JrTLiMDT9kl3K/iW5J4ysrtDytLuVrU3ZTw8+X?=
 =?us-ascii?Q?JqubK1aR52o63+Ld+Xud4/VUM7cKcfrWSY8EsMPjUj1cJIdVwWWirtf8zQUy?=
 =?us-ascii?Q?uQAj/kLWuGvg9BRtGt0ie/T0urzeIT/7al2/joOFNz7dyOXPGqbkb6itdcw8?=
 =?us-ascii?Q?W4CbmJjWyf+cxv6HCX3fHafAE4MGGOoKixm17kZw4vq2AH2OMcwSmZo5z+C2?=
 =?us-ascii?Q?L9sYYjZ7G3snQagzsDcWQpHt6QelDBR3jdm7YfpJv76J2VBkYi/nqqH+Yiai?=
 =?us-ascii?Q?Mx8Vx9m6RwmSENwG19whL77y86hf0reSaLBfHccXXwWI7mtUtp6w2RKzJ/cK?=
 =?us-ascii?Q?disRpPCYxd0U3YPwncpUCIUsxS/wQFIlmtDNizD0g3kANDaE+1FWNN+x46Ga?=
 =?us-ascii?Q?WSp0kD7e9Ik0+XaMjncgm24qB/qqh/6l3vTCl8MagaNjtQgOnqsYFpsd771g?=
 =?us-ascii?Q?C8Yk29IquNL1mRCizpuH3GlA951phNtFQgJQDE4ZGNg1YuGHCDhZFIZS09TL?=
 =?us-ascii?Q?S6eNgC/lt/dVSHvCYyIyxNHthvQTwf1brocYym+nNm9W4yQOgpZ7H8EM4+aP?=
 =?us-ascii?Q?tiMDjqrd7Gc1B+tBB6Z+JVqtVKL4WtqPHL+Uu6aW0QpIC6Kv7DL/nXrFQve1?=
 =?us-ascii?Q?gWmlhOfVDKM3AjiEcLIf1PbdB3uFCPrdh3hZ3PwgLa3TWg9DeBSJGqZV3G5F?=
 =?us-ascii?Q?g52dnJnr67IKma+2FxnU3Q1bhRy6f1cK2mWKiRiR0wRldsi5IR57cNIGr/j/?=
 =?us-ascii?Q?Cgtw7tHrHUzxytVL7bJkAbFMzpIb5FjyNf63h/d9Uj3gKPGAJYjO7RK+C7/r?=
 =?us-ascii?Q?4rmgxFRcfkyYH9kD7XWWf1k5pL2lnYbg67OdeMM746HPMA0EO1nb0k6R98qW?=
 =?us-ascii?Q?U+gKUHRZIS31BeoeiWbth2Mcuzk=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e46c28b3-943e-4699-f8b4-08d9a8cab262
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Nov 2021 06:31:18.4463
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AksLNXVNQLEywwFEAbhUpdGXKm+sG1k64xJIZUbsOouOhsDQydwIGfaWCSgybCyKGAbkB8+pa4ZMGOMFAhSeHCI2FlWG/BsxmOV7Buqo0vc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4546
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10169 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0 mlxscore=0
 spamscore=0 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2111160034
X-Proofpoint-ORIG-GUID: u0xbqUKxgqUvM-BkhPZaCF2qltxdPu08
X-Proofpoint-GUID: u0xbqUKxgqUvM-BkhPZaCF2qltxdPu08
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 15, 2021 at 07:08:30PM +0100, Ansuel Smith wrote:
> > tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git  master
> > head:   debe436e77c72fcee804fb867f275e6d31aa999c
> > commit: 5654ec78dd7e64b1e04777b24007344329e6a63b net: dsa: qca8k: rework rgmii delay logic and scan for cpu port 6
> > config: i386-randconfig-m021-20211025 (attached as .config)
> > compiler: gcc-9 (Debian 9.3.0-22) 9.3.0
> >
> > If you fix the issue, kindly add following tag as appropriate
> > Reported-by: kernel test robot <lkp@intel.com>
> > Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
> >
> 
> This should already be fixed by 06dd34a628ae5b6a839b757e746de165d6789ca8
> Can you confirm this?
> 

No, it doesn't fix the problem.  The check is either useless and should
be removed or there is an out of bounds bug.  Checking for an out of
bounds *after* you've already written to the memory is *never* useful.

regards,
dan carpenter

> > smatch warnings:
> > drivers/net/dsa/qca8k.c:944 qca8k_parse_port_config() error: testing array offset 'cpu_port_index' after use.
> >
> > vim +/cpu_port_index +944 drivers/net/dsa/qca8k.c
> >
> > 6c43809bf1bee7 Ansuel Smith 2021-10-14   934  static int
> > 6c43809bf1bee7 Ansuel Smith 2021-10-14   935  qca8k_parse_port_config(struct qca8k_priv *priv)
> > 6c43809bf1bee7 Ansuel Smith 2021-10-14   936  {
> > 5654ec78dd7e64 Ansuel Smith 2021-10-14   937    int port, cpu_port_index = 0, ret;
> > 6c43809bf1bee7 Ansuel Smith 2021-10-14   938    struct device_node *port_dn;
> > 6c43809bf1bee7 Ansuel Smith 2021-10-14   939    phy_interface_t mode;
> > 6c43809bf1bee7 Ansuel Smith 2021-10-14   940    struct dsa_port *dp;
> > 5654ec78dd7e64 Ansuel Smith 2021-10-14   941    u32 delay;
> > 6c43809bf1bee7 Ansuel Smith 2021-10-14   942
> > 6c43809bf1bee7 Ansuel Smith 2021-10-14   943    /* We have 2 CPU port. Check them */
> > 5654ec78dd7e64 Ansuel Smith 2021-10-14  @944    for (port = 0; port < QCA8K_NUM_PORTS && cpu_port_index < QCA8K_NUM_CPU_PORTS; port++) {
> >                                                                                          ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> > Assume cpu_port_index = QCA8K_NUM_CPU_PORTS - 1;
> >
> >
> > 6c43809bf1bee7 Ansuel Smith 2021-10-14   945            /* Skip every other port */
> > 6c43809bf1bee7 Ansuel Smith 2021-10-14   946            if (port != 0 && port != 6)
> > 6c43809bf1bee7 Ansuel Smith 2021-10-14   947                    continue;
> > 6c43809bf1bee7 Ansuel Smith 2021-10-14   948
> > 6c43809bf1bee7 Ansuel Smith 2021-10-14   949            dp = dsa_to_port(priv->ds, port);
> > 6c43809bf1bee7 Ansuel Smith 2021-10-14   950            port_dn = dp->dn;
> > 5654ec78dd7e64 Ansuel Smith 2021-10-14   951            cpu_port_index++;
> >                                                         ^^^^^^^^^^^^^^^^^
> > cpu_port_index is now out of bounds.
> >
> > 6c43809bf1bee7 Ansuel Smith 2021-10-14   952
> > 6c43809bf1bee7 Ansuel Smith 2021-10-14   953            if (!of_device_is_available(port_dn))
> > 6c43809bf1bee7 Ansuel Smith 2021-10-14   954                    continue;
> > 6c43809bf1bee7 Ansuel Smith 2021-10-14   955
> > 6c43809bf1bee7 Ansuel Smith 2021-10-14   956            ret = of_get_phy_mode(port_dn, &mode);
> > 6c43809bf1bee7 Ansuel Smith 2021-10-14   957            if (ret)
> > 6c43809bf1bee7 Ansuel Smith 2021-10-14   958                    continue;
> > 6c43809bf1bee7 Ansuel Smith 2021-10-14   959
> > 5654ec78dd7e64 Ansuel Smith 2021-10-14   960            switch (mode) {
> > 5654ec78dd7e64 Ansuel Smith 2021-10-14   961            case PHY_INTERFACE_MODE_RGMII:
> > 5654ec78dd7e64 Ansuel Smith 2021-10-14   962            case PHY_INTERFACE_MODE_RGMII_ID:
> > 5654ec78dd7e64 Ansuel Smith 2021-10-14   963            case PHY_INTERFACE_MODE_RGMII_TXID:
> > 5654ec78dd7e64 Ansuel Smith 2021-10-14   964            case PHY_INTERFACE_MODE_RGMII_RXID:
> > 5654ec78dd7e64 Ansuel Smith 2021-10-14   965                    delay = 0;
> > 5654ec78dd7e64 Ansuel Smith 2021-10-14   966
> > 5654ec78dd7e64 Ansuel Smith 2021-10-14   967                    if (!of_property_read_u32(port_dn, "tx-internal-delay-ps", &delay))
> > 5654ec78dd7e64 Ansuel Smith 2021-10-14   968                            /* Switch regs accept value in ns, convert ps to ns */
> > 5654ec78dd7e64 Ansuel Smith 2021-10-14   969                            delay = delay / 1000;
> > 5654ec78dd7e64 Ansuel Smith 2021-10-14   970                    else if (mode == PHY_INTERFACE_MODE_RGMII_ID ||
> > 5654ec78dd7e64 Ansuel Smith 2021-10-14   971                             mode == PHY_INTERFACE_MODE_RGMII_TXID)
> > 5654ec78dd7e64 Ansuel Smith 2021-10-14   972                            delay = 1;
> > 5654ec78dd7e64 Ansuel Smith 2021-10-14   973
> > 5654ec78dd7e64 Ansuel Smith 2021-10-14   974                    if (delay > QCA8K_MAX_DELAY) {
> > 5654ec78dd7e64 Ansuel Smith 2021-10-14   975                            dev_err(priv->dev, "rgmii tx delay is limited to a max value of 3ns, setting to the max value");
> > 5654ec78dd7e64 Ansuel Smith 2021-10-14   976                            delay = 3;
> > 5654ec78dd7e64 Ansuel Smith 2021-10-14   977                    }
> > 5654ec78dd7e64 Ansuel Smith 2021-10-14   978
> > 5654ec78dd7e64 Ansuel Smith 2021-10-14   979                    priv->rgmii_tx_delay[cpu_port_index] = delay;
> >                                                                 ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> > Out of bounds
> >
> > 5654ec78dd7e64 Ansuel Smith 2021-10-14   980
> > 5654ec78dd7e64 Ansuel Smith 2021-10-14   981                    delay = 0;
> > 5654ec78dd7e64 Ansuel Smith 2021-10-14   982
> > 5654ec78dd7e64 Ansuel Smith 2021-10-14   983                    if (!of_property_read_u32(port_dn, "rx-internal-delay-ps", &delay))
> > 5654ec78dd7e64 Ansuel Smith 2021-10-14   984                            /* Switch regs accept value in ns, convert ps to ns */
> > 5654ec78dd7e64 Ansuel Smith 2021-10-14   985                            delay = delay / 1000;
> > 5654ec78dd7e64 Ansuel Smith 2021-10-14   986                    else if (mode == PHY_INTERFACE_MODE_RGMII_ID ||
> > 5654ec78dd7e64 Ansuel Smith 2021-10-14   987                             mode == PHY_INTERFACE_MODE_RGMII_RXID)
> > 5654ec78dd7e64 Ansuel Smith 2021-10-14   988                            delay = 2;
> > 5654ec78dd7e64 Ansuel Smith 2021-10-14   989
> > 5654ec78dd7e64 Ansuel Smith 2021-10-14   990                    if (delay > QCA8K_MAX_DELAY) {
> > 5654ec78dd7e64 Ansuel Smith 2021-10-14   991                            dev_err(priv->dev, "rgmii rx delay is limited to a max value of 3ns, setting to the max value");
> > 5654ec78dd7e64 Ansuel Smith 2021-10-14   992                            delay = 3;
> > 5654ec78dd7e64 Ansuel Smith 2021-10-14   993                    }
> > 5654ec78dd7e64 Ansuel Smith 2021-10-14   994
> > 5654ec78dd7e64 Ansuel Smith 2021-10-14   995                    priv->rgmii_rx_delay[cpu_port_index] = delay;
> >                                                                 ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> > Out of bounds
> >
> > 5654ec78dd7e64 Ansuel Smith 2021-10-14   996
> > 5654ec78dd7e64 Ansuel Smith 2021-10-14   997                    break;
> > 5654ec78dd7e64 Ansuel Smith 2021-10-14   998            case PHY_INTERFACE_MODE_SGMII:
> > 6c43809bf1bee7 Ansuel Smith 2021-10-14   999                    if (of_property_read_bool(port_dn, "qca,sgmii-txclk-falling-edge"))
> > 6c43809bf1bee7 Ansuel Smith 2021-10-14  1000                            priv->sgmii_tx_clk_falling_edge = true;
> > 6c43809bf1bee7 Ansuel Smith 2021-10-14  1001
> > 6c43809bf1bee7 Ansuel Smith 2021-10-14  1002                    if (of_property_read_bool(port_dn, "qca,sgmii-rxclk-falling-edge"))
> > 6c43809bf1bee7 Ansuel Smith 2021-10-14  1003                            priv->sgmii_rx_clk_falling_edge = true;
> > 5654ec78dd7e64 Ansuel Smith 2021-10-14  1004
> > 5654ec78dd7e64 Ansuel Smith 2021-10-14  1005                    break;
> > 5654ec78dd7e64 Ansuel Smith 2021-10-14  1006            default:
> > 5654ec78dd7e64 Ansuel Smith 2021-10-14  1007                    continue;
> > 6c43809bf1bee7 Ansuel Smith 2021-10-14  1008            }
> > 6c43809bf1bee7 Ansuel Smith 2021-10-14  1009    }
> > 6c43809bf1bee7 Ansuel Smith 2021-10-14  1010
> > 6c43809bf1bee7 Ansuel Smith 2021-10-14  1011    return 0;
> > 6c43809bf1bee7 Ansuel Smith 2021-10-14  1012  }
> >
> > ---
> > 0-DAY CI Kernel Test Service, Intel Corporation
> > https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org 
> >
