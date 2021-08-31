Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 460053FCD0B
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Aug 2021 20:47:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238533AbhHaSqt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Aug 2021 14:46:49 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:37082 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229483AbhHaSqs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Aug 2021 14:46:48 -0400
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 17VIiRQf002296;
        Tue, 31 Aug 2021 18:45:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : content-type : mime-version; s=corp-2021-07-09;
 bh=BSvHvR5q5iA37bGWLXXQEu/JO4PNfaV24hu2BsrMkAg=;
 b=wvyNI7+jFfkIqbVDG5EIVAdZc7f1EKsIFpayXCVfhLXlZWDcp2r3P0QEcdgOIcrrTcX7
 MNw0b/KnwbDYXOq7PzKgoH3vx6NoYrMQ8a8Kk87yZzwhwi04wN8/okDYgqC7SUR3l2ES
 mDqTar6r0uL5MvmrEDoK6c5IABZZ0RZCIkqCRM+jYS23rRGrvLFmpeR9TWuiIRimReHs
 sKTk55ss95GZStQMxnBCviVK/p5ogZm7Wh0ynVo2dzGDS3VjpjZGGwm5yX/cxESUo837
 l0OxaB5DQHFjhHuWBBNJPd7hew+sOG9/544CPYIFfcNOQt0j/BpsjBZE0q3fEH0X9svF 6w== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : content-type : mime-version; s=corp-2020-01-29;
 bh=BSvHvR5q5iA37bGWLXXQEu/JO4PNfaV24hu2BsrMkAg=;
 b=Vmuni6XS70lyvXWPOyECmQJPNLMoP4F5ZcTBcUUyZX1ktAG+rBhkO7UzxepEvAAOgEn1
 iWQC2JQ2EJhcuUlaFNJZbo91ZoS3DjZJnmj46hUTTgOj+z+h8ioiaSSisF+aodv37uAV
 NMZSARPU8izZ1BOWP3o1wy0WOdj6gGyJTGMygRoOhxl+8VkuJMjYegwhaFfXbXx21m8D
 LzAC1bCjzt+1oTKhwYZqcCKAyyIEaI7ftkMBTsXmDAp/osoeBfsFdlvDjrJ9CrBVJ525
 JBzWUfXo94ufrbTHr330BY+uKoIGEd/PoEzMEzPNyJUwwBIL1Z/5zh8t+8S9jKIxE6iI Yg== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3asf2mhydp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 31 Aug 2021 18:45:30 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 17VIflYZ076682;
        Tue, 31 Aug 2021 18:45:30 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2171.outbound.protection.outlook.com [104.47.57.171])
        by aserp3030.oracle.com with ESMTP id 3aqb6eca9w-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 31 Aug 2021 18:45:30 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=drw6YdeLGHR9X/83mzdHvseIyxp6NVlnBka8uYg3fd2dZ+DKBdIKYc3f+H3ghTtFCsQLk2MvJzGbK1oLWMcuF8hkgZE48DDLkgxdnSsKMKYAV7U0SGR7eXyA1t127hU8U5TftzLy7XoWJxAl43IJPxoDf7BEEWv7UsYnsKg/SW+TOzVJNDPwus6Y7bvlEzHYSMSokWiNJe6VGKwI4tUCW8iQZRfwF4PTh0VPqg4IkA93K8sleD/08nW9bEcQlimOatgWy5P++msKLXEJ7rc1Dj8oqolpG9qxsQqW+gImOswUmKgPVxjqP470MffpyhjHJnx74D3iCQ2bT07b0L0KGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BSvHvR5q5iA37bGWLXXQEu/JO4PNfaV24hu2BsrMkAg=;
 b=cdVrVwnXk9rxGBQhuOHLCRkoazMe9C51RDzn71pcuNEZeZi0/CT1u0oPGeN8y1TpfjFBSaGRAcs/XZGFEvgT2E5N69h0mGoGMXgnU7sCt9f+kHyZfdL7VdlR1M3dooaC7dgCqvkqqfynaIqOJHXhfPQG1jGxGX25BQPrw627yc3InTKWX8i/x9fAWINrieq2k8I7/kqolpR+CiVagJ689E9X+LScjDKjn0czOxt6TC2brJAqRhw2sZegOHydYn4P77R/+D6mxcjdpb0Rh+UFx6fOx7ySDCbrpe138xyfSdy7rrSwltGEgup4lUNCx6ouJUr8mXnZGq/zM5R5Am/gVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BSvHvR5q5iA37bGWLXXQEu/JO4PNfaV24hu2BsrMkAg=;
 b=Oj76UBzNHjsX5qm75Hm2pFd+L16aGvGoXdsCDlGf2X4w7l5+G61akDV1TV68Hb10DcyhhY9eqjvF1JrXs42OG8OaZTao89fYrIIU+iI9CnxLa2an6u8bWKEj0zW1ekEEDF8XiMhGCibZAjwW9+hJGu86BKRtx2+IG6je4XYifK4=
Authentication-Results: lists.01.org; dkim=none (message not signed)
 header.d=none;lists.01.org; dmarc=none action=none header.from=oracle.com;
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by CO1PR10MB4689.namprd10.prod.outlook.com
 (2603:10b6:303:98::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4457.23; Tue, 31 Aug
 2021 18:45:28 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::5820:e42b:73d7:4268]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::5820:e42b:73d7:4268%7]) with mapi id 15.20.4478.019; Tue, 31 Aug 2021
 18:45:27 +0000
Date:   Tue, 31 Aug 2021 21:45:11 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     kbuild@lists.01.org, Masami Hiramatsu <mhiramat@kernel.org>
Cc:     lkp@intel.com, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org,
        "Steven Rostedt (VMware)" <rostedt@goodmis.org>
Subject: [kbuild] [trace:ftrace/core 35/39] kernel/trace/trace_boot.c:420
 trace_boot_init_histograms() warn: curly braces intended?
Message-ID: <202109010207.nUISBZUN-lkp@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Message-ID-Hash: KDNC5BHGJUD3JYD4H6RFQU45LWMG6UKD
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: JNXP275CA0021.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:19::33)
 To MWHPR1001MB2365.namprd10.prod.outlook.com (2603:10b6:301:2d::28)
MIME-Version: 1.0
Received: from kadam (62.8.83.99) by JNXP275CA0021.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:19::33) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4478.17 via Frontend Transport; Tue, 31 Aug 2021 18:45:24 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: fdbf5d66-0ff9-4936-0a30-08d96caf8038
X-MS-TrafficTypeDiagnostic: CO1PR10MB4689:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CO1PR10MB46894FB6CB20C3F1512660D28ECC9@CO1PR10MB4689.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:39;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /SU7JRQrlEOnoPacqq7NzITC6nmPc3uLbMITohgorIF33UCotWw8HEA3BC9RvNAiUbZZft7llEzVoV9ipRsltI/ZTstb0WwffFgobMDoBn1ZTCnKo97jvzB8JiQm1lIpNr3uA5gFZ4Zbyq3qsghnY15hUAJ8n5bAYwq0Ej27tGYHKXuVyNBI/MtBMxu5Ih7R8OkGEBwg41IE1qLjRJEGF0w556e/hGsGuOtUryS+DMs1jgG6sjPkTHVwhdyjksev+fDcNXUrcW7O8UW17q46HAsJlbrT/38iKKR0HYN5Em98kMOZ9CJbdN3YC2G/m2Sx9mIlQpM7yubn9OVd+fWJYTGNcJnGn9VUo+Z7Ocw41SFJxEOX/d9epfqQLqWpd1bWDuUEAGaVbSR00QmopUTkymz3fuDkzxbrM/U4AXSbCdc0Vdwrf/Bm4mvoJiQiuuSFlO0/u0XZf60Pd/BlQPKUpdnXEEFTmS+TRZ9ZqLVN6+6CORQ7bD2pBjXT8XipEMFx+eBnAYxMbtpohaboXEn33iXqPKa1cwzub/bfz3MwvZM2pLNkOoSD4/vp+BTf8sTyyrG54cl2vdNqgkDyFl6fHOKIdtq60v4/LsqgwrxTW8U4biEZ9D3mDDMe1uGrYXAeWtr7PPtiYEUHQqy9f++dKQuo+XIrbVok4+lzUTsf/amAZ4q3UEXOVlNLk7AfVs8hedC8AM4WOmBMFo2X4OELGPUt/j/pHbjH0mn1xsE2L3GgLtzczuMrL9N6XJoIE6LyGn9tWv8RsvG2mExg2KDgcpqyy3IgNZJRSE5BcCcaLbALCtwsA8tCNkaw8XwQsyK1hHFY4czpXFQsDCyjgea/PQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(136003)(346002)(396003)(39860400002)(376002)(86362001)(316002)(38350700002)(44832011)(6496006)(956004)(5660300002)(66476007)(66556008)(8936002)(9686003)(8676002)(52116002)(6486002)(6666004)(1076003)(38100700002)(83380400001)(478600001)(2906002)(6916009)(36756003)(4326008)(66946007)(966005)(186003)(26005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?N4om7HitPLbawFeXYQDKmP8k8VZIsT5Ja5ZAKSbtEgxE43VZNGNr5q6DJn7w?=
 =?us-ascii?Q?FkqUAUjldsVNNnxsLqUgFo5QHIrD+bCI6mDiycvhCLIZRMidniVpoe3OmRIk?=
 =?us-ascii?Q?BMxzRUGqoheuNPZenjxja5yDSsKmiITV6a7J9Rx1t+Ox5CVb4hdNSlhPGq1U?=
 =?us-ascii?Q?mFP225SkfGsqfF5SmmBot9nbju3RObTGjAKhueWPQh9/DrFmjcGVi19DkjF+?=
 =?us-ascii?Q?foCw3KtS4OLNO1vrSIFcTtajagfTlGOlOrwzBNJrELAp/6dlB2RbSARm8GOB?=
 =?us-ascii?Q?44sOSkXdL8GgEBHWSsRveuuGp2C0xiGSL62GJBYxv7M3NC1MjZbvAy6H6/bq?=
 =?us-ascii?Q?ldq+GUWfTljVYm7UNVbxz+B3RVmHMVTJAdO9IFQIqCVCTTAWMqCt2f72feGB?=
 =?us-ascii?Q?N+Rvatb7yYvO3nY52qcUJaKQJQlzkW19SZIC/WyPYp6DN3K/n58oih9Uu9Sx?=
 =?us-ascii?Q?KM9HinZeo40Bv11GDa1QvNcB/AFesNp2qPBRHOgSE8PjaQOYTfD7VfDTxaKG?=
 =?us-ascii?Q?cyxP+Q1FThpBOh3mFI29zsOwZmLdl/n+9eXZBdxA7gant39VM3jUqO2XZ2m+?=
 =?us-ascii?Q?QklfIK3pgkvJCCcBwnv/GD3mA7uRD10SwXwuX1BxeEoAiklAb6J/uJXSLVNw?=
 =?us-ascii?Q?UuW/qD9PW561NnsiNzI7I2eGGymtZAXZRknaqgC2Xc++DnnTyks2MEhPH7l0?=
 =?us-ascii?Q?7bTsf+tPmnvK/8jWO+XG8bjymE1ib79YsSwJRpY/ZrEncbk01jo8hXawUTik?=
 =?us-ascii?Q?8oWwIueCenuKzYDACaMZMQz6X371/NzYkFe9xA5rEboehQTxiBmpP4T+jTSM?=
 =?us-ascii?Q?6WmbLvw4iWXX2qWjsd1P3yVVbWtRV6f4yoLwy7CY30mvzmA5Rr+DCIY+SwDL?=
 =?us-ascii?Q?kKiTAxlIckS/ibPDkIKYBymPOk+YAv93MclJVaB+0zexUvLt+2Cse9L8Q1zz?=
 =?us-ascii?Q?Z156tcXhzUkzI1H+P5Eua/qTfZSs6snVKW3P19Qcx9Xq2aOfhNVZzPWgCYi/?=
 =?us-ascii?Q?5gg1pjw1/3VPy7/NbuELF8v/VbOu11j0SzgvSMr7YzWeqLg34JFntRBs3lza?=
 =?us-ascii?Q?ptYSc1jWOrdcJLYwHqc/fWCc6pKgsDfA+Tam7g6JniyaLP//u811ssJTSU5t?=
 =?us-ascii?Q?PnkuDKT/DrKNCrsknbleWSzZwav/M3h44J1kwcwJaZMDnUSUC17YV+DooiTg?=
 =?us-ascii?Q?uGzZhU/BfUzhcE7C5g09sTaGh84nJifz1bROT8aN2asxRPnOEOXL6ME6bFUJ?=
 =?us-ascii?Q?h8QqcXLudaFdBKkInIH093OLlJCY5WwxSb6dKQa7ddmMReeprYIduWtLT09J?=
 =?us-ascii?Q?4EoRxVMuSEAneGsFnHr1Y/Ks?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fdbf5d66-0ff9-4936-0a30-08d96caf8038
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2021 18:45:27.8377
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6HGtxvBU40OPyOZGCSjLmZRLrSZYhS0QGdkHervYVUDHJbMOV+H2qQnPn5LOl36aPuFpo81C38TN63xxmeybtXJ2UD7LxZF9AzcGo79N3Qo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4689
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10093 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 phishscore=0 suspectscore=0
 adultscore=0 mlxscore=0 mlxlogscore=999 malwarescore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2107140000
 definitions=main-2108310103
X-Proofpoint-GUID: Iip70a9b7zO5aD698y54hg4JjG5qkv3z
X-Proofpoint-ORIG-GUID: Iip70a9b7zO5aD698y54hg4JjG5qkv3z
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/rostedt/linux-trace.git  ftrace/core
head:   3dc65994e3c1c999be3d991cdc96705e167cb3b1
commit: 5d4648a0415efc239ffb377bce1d389723eda25d [35/39] tracing/boot: Show correct histogram error command
config: x86_64-randconfig-m001-20210831 (attached as .config)
compiler: gcc-9 (Debian 9.3.0-22) 9.3.0

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>

smatch warnings:
kernel/trace/trace_boot.c:420 trace_boot_init_histograms() warn: curly braces intended?
kernel/trace/trace_boot.c:421 trace_boot_init_histograms() error: uninitialized symbol 'tmp'.
kernel/trace/trace_boot.c:421 trace_boot_init_histograms() warn: passing freed memory 'tmp'
kernel/trace/trace_boot.c:422 trace_boot_init_histograms() error: double free of 'tmp'

vim +420 kernel/trace/trace_boot.c

30cb856e3067e5d Masami Hiramatsu 2021-08-06  396  static void __init
30cb856e3067e5d Masami Hiramatsu 2021-08-06  397  trace_boot_init_histograms(struct trace_event_file *file,
30cb856e3067e5d Masami Hiramatsu 2021-08-06  398  			   struct xbc_node *hnode, char *buf, size_t size)
30cb856e3067e5d Masami Hiramatsu 2021-08-06  399  {
30cb856e3067e5d Masami Hiramatsu 2021-08-06  400  	struct xbc_node *node;
30cb856e3067e5d Masami Hiramatsu 2021-08-06  401  	const char *p;
5d4648a0415efc2 Masami Hiramatsu 2021-08-06  402  	char *tmp;
30cb856e3067e5d Masami Hiramatsu 2021-08-06  403  
30cb856e3067e5d Masami Hiramatsu 2021-08-06  404  	xbc_node_for_each_subkey(hnode, node) {
30cb856e3067e5d Masami Hiramatsu 2021-08-06  405  		p = xbc_node_get_data(node);
30cb856e3067e5d Masami Hiramatsu 2021-08-06  406  		if (!isdigit(p[0]))
30cb856e3067e5d Masami Hiramatsu 2021-08-06  407  			continue;
30cb856e3067e5d Masami Hiramatsu 2021-08-06  408  		/* All digit started node should be instances. */
30cb856e3067e5d Masami Hiramatsu 2021-08-06  409  		if (trace_boot_compose_hist_cmd(node, buf, size) == 0) {
5d4648a0415efc2 Masami Hiramatsu 2021-08-06  410  			tmp = kstrdup(buf, GFP_KERNEL);
30cb856e3067e5d Masami Hiramatsu 2021-08-06  411  			if (trigger_process_regex(file, buf) < 0)
5d4648a0415efc2 Masami Hiramatsu 2021-08-06  412  				pr_err("Failed to apply hist trigger: %s\n", tmp);
5d4648a0415efc2 Masami Hiramatsu 2021-08-06  413  			kfree(tmp);
30cb856e3067e5d Masami Hiramatsu 2021-08-06  414  		}
30cb856e3067e5d Masami Hiramatsu 2021-08-06  415  	}
30cb856e3067e5d Masami Hiramatsu 2021-08-06  416  
30cb856e3067e5d Masami Hiramatsu 2021-08-06  417  	if (xbc_node_find_child(hnode, "keys")) {
30cb856e3067e5d Masami Hiramatsu 2021-08-06  418  		if (trace_boot_compose_hist_cmd(hnode, buf, size) == 0)

The missing curly braces here trigger a ball of static checker warnings.
I'm so happy about that.  :)

5d4648a0415efc2 Masami Hiramatsu 2021-08-06  419  			tmp = kstrdup(buf, GFP_KERNEL);
30cb856e3067e5d Masami Hiramatsu 2021-08-06 @420  			if (trigger_process_regex(file, buf) < 0)
5d4648a0415efc2 Masami Hiramatsu 2021-08-06 @421  				pr_err("Failed to apply hist trigger: %s\n", tmp);
5d4648a0415efc2 Masami Hiramatsu 2021-08-06 @422  			kfree(tmp);
30cb856e3067e5d Masami Hiramatsu 2021-08-06  423  	}

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org 

_______________________________________________
kbuild mailing list -- kbuild@lists.01.org
To unsubscribe send an email to kbuild-leave@lists.01.org

