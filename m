Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3AB2B3F87FA
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Aug 2021 14:51:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242493AbhHZMvl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Aug 2021 08:51:41 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:20888 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S240886AbhHZMvf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Aug 2021 08:51:35 -0400
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.0.43) with SMTP id 17QBNhgv006459;
        Thu, 26 Aug 2021 12:50:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2021-07-09;
 bh=+0TSdD0FWtXwvWgCxRytKk29AKQMl5Gxi+QsUQwBLC0=;
 b=iDTlMGS2wUG9RIVw1FTTZYlOoc1SASPh5jiew7YrexTyRN2r3JlP5Fn9uxtRHj7idg2f
 m1UOugAIIrfRLNsigc+gqzGKD/N+PWVBFKea7bCH6+y+v1O5mbrg2DL0cBR/ssBefzj9
 YM6s9F68GCPHSuyn3EqjM1s1gU1ovJCaK95YnViajOmaZTQvHx4atfQFYT7OAGGwGI43
 2JJbOl5J9FHeXV8Ug9tHRm9HAYvl664AMxmjViwEK7jq0L8+vL/C/UdjJ02HdUwP2bpG
 BjV++OLxYTkwatixzziKV8v64v2ydqWoh4VoUmrSESDIosBEA0JV6ZsB7h4EUwJhPHx7 bA== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2020-01-29;
 bh=+0TSdD0FWtXwvWgCxRytKk29AKQMl5Gxi+QsUQwBLC0=;
 b=fA6wbVLginKpxngrdfbYwRKJywCQZMzcR39uurS1uTSOfIom3CeBRRFfAP4Fa5vuiZtv
 GMQlaN5NmXyIsaoJksU/hKaqlCcaa9ZIitwCRVQ1HT05qjEX6jdEg3Nb4AKzbyUr5JEV
 sUlIocr4syeRl8o2P+sop/4I1aBblmf/8lju05wfSbzp+uagWbld83AYdhnPm1gBRu6s
 67+tt9IjkB9X43sk5UiOdpfR3c1Rw3hWmP8ClvHTQxRCreKdsQbsHzSEgHBrslaZl6p+
 DBAgO0+BvzzG6HbXIGXkUUob133h3rdOBSSkJ8bKWeEabRLRv3tsO66DpLy2L8rtrjXX Sg== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3ap1r5h4h9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 26 Aug 2021 12:50:45 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 17QCjV4I124252;
        Thu, 26 Aug 2021 12:50:44 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2173.outbound.protection.outlook.com [104.47.56.173])
        by aserp3030.oracle.com with ESMTP id 3ajqhjhuem-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 26 Aug 2021 12:50:44 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bCPyLTIiBhi8tK9hFu5s3MWBfcEgop/GhgHeXrWYophNtj+jPnmrlZbwEShRUoazvXTyfe9Wq4nGlZELLGvn4euRHtDfe1WLJGuttKQif9BSM77GtS4kSwuU6j8Gv088m2DT/VBfj3UE4uyCH27NJCjGJ73TaGgKK5Qv6SRgKoijkg+8yYoelo3uCBPpVFALj0ufIlMH9RTjhgwpTTXkL6ltyO8WerjwBzORHg2Gc2BS8ZIsBxRtGwhsKde3EuTiRpeME4C+qtHBXxNzxUEoYpBx+xOH1vmF1BAqIi8FVhpEA/zKwM0wesVl4BAo7N+9SPalmUErpYGz5Bi+CfZGjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+0TSdD0FWtXwvWgCxRytKk29AKQMl5Gxi+QsUQwBLC0=;
 b=abcsBhiSqbl2FSKBF7T0HZT+uQUi4GTyw55RO3fQXUiuYPibq2L+ukJqS3tp4Zb8tgY6kJD2RsUe4SOu84ROohcaDTacsEOPDHhpem+5dCQ7UojhHD+vAKH7Z8C7iOVUmcFmmdpfmlbDT7cV24aWWwLoNKYePpT/kUsBthf9zCXTTtBc9h5O4yEJweX+Q/fpCfWHT9ZP9illX28qeC3WopGxJNemet2FApa+Z3OkH4RCHymEnrzNPCaLvC/QuR/87xH7Qn35A/mG8DfJxLTNMadd+2f7QYP2CgUeNaiVdG6ElZtUDHkUZloCCPtwUMoDGqmZdTWCqVfnZy8rlo5yEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+0TSdD0FWtXwvWgCxRytKk29AKQMl5Gxi+QsUQwBLC0=;
 b=q5I/BzWAqW+knberRD0IIL+eG3YSxZNL8/kL/wpOOHSW1Yw+BvEXv/8bnqtCQJQF1kxlLowdnmnWey6ImqrqzK34m85zb9h/b85RLJm/OXKqNW5MjkNq2yQf94BesnOUVyYkpyABsw73xlgNTWgq/auXVO6zcSMgvjic+KCQj4c=
Authentication-Results: lists.01.org; dkim=none (message not signed)
 header.d=none;lists.01.org; dmarc=none action=none header.from=oracle.com;
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by CO1PR10MB4738.namprd10.prod.outlook.com
 (2603:10b6:303:93::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.22; Thu, 26 Aug
 2021 12:50:42 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::5820:e42b:73d7:4268]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::5820:e42b:73d7:4268%7]) with mapi id 15.20.4457.019; Thu, 26 Aug 2021
 12:50:42 +0000
Date:   Thu, 26 Aug 2021 15:50:21 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     kbuild@lists.01.org, Dan Williams <dan.j.williams@intel.com>
Cc:     lkp@intel.com, kbuild-all@lists.01.org,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Ben Widawsky <ben.widawsky@intel.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [cxl-cxl:pending 39/40] drivers/cxl/core/bus.c:501
 devm_cxl_add_decoder() warn: variable dereferenced before check 'cxld' (see
 line 497)
Message-ID: <20210826125020.GA7722@kadam>
References: <202108250714.GDy2jUg2-lkp@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202108250714.GDy2jUg2-lkp@intel.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: JNAP275CA0032.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:4d::9)
 To MWHPR1001MB2365.namprd10.prod.outlook.com (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from kadam (62.8.83.99) by JNAP275CA0032.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:4d::9) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4457.20 via Frontend Transport; Thu, 26 Aug 2021 12:50:36 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b2212a60-e8dc-4e0b-7c37-08d968901d47
X-MS-TrafficTypeDiagnostic: CO1PR10MB4738:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CO1PR10MB4738113A7D7A38B0497574ED8EC79@CO1PR10MB4738.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OG6o0cFC924LWNquykQYhdNQURxEG2FLanp26xM3rKOatSJAIfEGoT8cVDeqJZP5sIt/897AToBqyflpJYtEUIVOiZ73U1XayGpLVTBjESkEFOICd+MSBPYXpUFLORAWAduQOTsuVe+u+jEfPF0B39fv72loM1gt/wO5Q/Ot9xz5pkzH4h75Oa0ZNQxajdNiCRJz/bwH0LioBwhUWhRoYPLypU9Oe9iCY9yLd8Roby5mcZn7Lj2bgoZMFYhWLlfwBI2aCoKupmzx0cq5Ijg2985xEyLzK35tUqSMlOpUddPC5sIfc3q/T65BCj7tD4FcN2CLk2FfPS/EzxITnAd7Yg/in9O/IY1MRfCdw4O33BoMbyg46PmgLBqkeBtaq5z7h87x1O955EGZNFT4NtXs+wu3JJTVc09wxL/4u3h8wUOWRy+A9csfmETC2TvTJcfpnu0kMkoHNWVn03zqC4vdyFsKfuxsJGVenVSG0Oy8E35SnQZkklr6iQcO26Ij4U2i01LWODq+8cFfsalUu03+rQfzS1Gl2+vT6f5urKeQzErLaIYSMxA0yrJYDJ0p9fz4sHSv3RPmFIZSqc3TAU163TCp6rlQU7WciGBNW7LFelVfQFYpF+sdqFUG51pvborNK6UKckvD7IKr/Y71C666MoinRIkxj6Vtw4MAR4kKgc7/t7mSlq05IjZoXCLr49tJyBjnSGXaEkbKQPSRDOrp/g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(346002)(39860400002)(376002)(366004)(136003)(396003)(55016002)(54906003)(4326008)(186003)(9686003)(1076003)(2906002)(38100700002)(44832011)(38350700002)(26005)(8676002)(6666004)(33656002)(33716001)(956004)(6496006)(478600001)(66556008)(66946007)(8936002)(6916009)(66476007)(52116002)(9576002)(316002)(83380400001)(5660300002)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?+CPTHwpFUc68bayrpbxsH+hIJZxcnQ517F9PTXcKegzm6UuSSTjo8lp01m7W?=
 =?us-ascii?Q?efH2au4iwGVElw8OzzoplypCYMCAKgI2ynDHKFruJI0iTaGtGtACqeufjSAi?=
 =?us-ascii?Q?GFbUAjQA4NhAAFOGO5jTDwnm93yrOhCWcA2UQhch46g5hJzAxJZUBtD+EW0o?=
 =?us-ascii?Q?4RZsl1chj7zRh22Kt99GnOLno1/ztY0dZVk30d+o71UdLGdZrZVaJRW2LH+G?=
 =?us-ascii?Q?Jz1RLM3qLadR3fY+DXrEYAgWHeYFDFDOBp5SrWhcm6BRKXBqIMNXeSthMCRE?=
 =?us-ascii?Q?YqsGgBybMmEeKx3ojMISvN9az0Gpu6QNEgUmaw8qB0IzMBm7TVPEZ09376L2?=
 =?us-ascii?Q?XIGyOmcP+ZhS8XqJHUkDLTWQ6/9aXhDWjuRbE2EYKC6zKayKy5tIakHcrJMi?=
 =?us-ascii?Q?fe7jfpr0thv3rf1fYKM/jbQ0nitk4nvw0S0t6fazgjwOxiYJCN4JElxRJf/e?=
 =?us-ascii?Q?VSyDBKgwYwmeKGpQBaUwBtI76s4+4gh8x3cmTLJjaF2N2ENebruhEjwBpMMv?=
 =?us-ascii?Q?5MPtXbiprrhg217JQ8ZmM2EYH/6ER4BFH285ORFMRNglUqdkujlWI8ONzx7q?=
 =?us-ascii?Q?BHIeYOVbo5BDwQTf6jhlFaiUlI9cKc6SI0/MhQFi1/10VN2VZQNakvtg2GCY?=
 =?us-ascii?Q?mVlesz9Z+blWA5bSYhLGtsgG7f+R3XkQos8oUZgygcXgJa0uPTAAHUEhlpGV?=
 =?us-ascii?Q?Rfwxul9pDsX5Vwbod1QWhJWTU1G6ib8Z2/YB8/GcTHMUUgXVQN2LYvuU9DCA?=
 =?us-ascii?Q?gKjn13h0Rx7wv6laN3AohbuOAgpBfO8oosM+1BmD9sYZuXVRtfoCNnL6lTPg?=
 =?us-ascii?Q?zTnUR9M0O1SHlmqzbUQhL31es9M5knV8Kod7tBipLsmpW1d8qKRlKN7m1iYR?=
 =?us-ascii?Q?KhjfYEccf83bI+SOtK6DV24/ctuB2wKAmSI7+0hO/+4K8to/zDltgoe5AYAu?=
 =?us-ascii?Q?s+J9S8lGLiQ3VlzvxrrPzZRvj93oZnsNQWO3L5Grs1UkREhgEQGynaKNJgdg?=
 =?us-ascii?Q?SscT+8qC/p2X/0ZqcTFGCc9KeQcRCkZG1MaNqIlGsFllJeb720v3UDGm2P2y?=
 =?us-ascii?Q?xAh4XC9TQDyjbIjFMf9jVIhKBDYjGlB63d4j4huXKHDOuc63fG6tGuVUps50?=
 =?us-ascii?Q?DuBKDWLTJYBCskIlmaPcNQUtVAvvnU/tzBqezrU4/YWDp0vWRLxASxlnbhTR?=
 =?us-ascii?Q?A2EB1qHoCAu7w3a4tqlb6x/NJDGoE3jOIdFoP9yQe10X+WjJBgFjo49QG8Hf?=
 =?us-ascii?Q?VSHIQyuXh0qmX8/eSy2axuPBcmA3cPr017ogTF2Lmsda/4e4uuN1zKE9mmmM?=
 =?us-ascii?Q?2sbcg0/Sl17NFh76KAtocgpQ?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b2212a60-e8dc-4e0b-7c37-08d968901d47
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2021 12:50:42.7131
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oyTcueLBmnbMz4VhsffYtVUCXgAg+YkIW4j51+Vgi3iOV5KSoT9U0w0xDyMAY1GdHqhlrBxfBDM9jwO7mqwZwUmhuoASz/w62ExQSuu2Clo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4738
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10087 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0 malwarescore=0
 spamscore=0 adultscore=0 mlxlogscore=999 suspectscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2107140000
 definitions=main-2108260078
X-Proofpoint-GUID: TpbNw2xKuC2T4yaA8Hg9v0vDvcElpxLH
X-Proofpoint-ORIG-GUID: TpbNw2xKuC2T4yaA8Hg9v0vDvcElpxLH
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 25, 2021 at 10:12:32AM +0300, Dan Carpenter wrote:
> b7ca54b6255144 drivers/cxl/core/bus.c Dan Williams 2021-08-24  494  int devm_cxl_add_decoder(struct device *host, struct cxl_decoder *cxld,
> 574d46ed53b527 drivers/cxl/core/bus.c Dan Williams 2021-08-24  495  			 int *target_map)
> 40ba17afdfabb0 drivers/cxl/core.c     Dan Williams 2021-06-09  496  {
> b7ca54b6255144 drivers/cxl/core/bus.c Dan Williams 2021-08-24 @497  	struct cxl_port *port = to_cxl_port(cxld->dev.parent);
>                                                                                                             ^^^^^^^^^^^^^^^^
> Dereference
> 
> 40ba17afdfabb0 drivers/cxl/core.c     Dan Williams 2021-06-09  498  	struct device *dev;
> b7ca54b6255144 drivers/cxl/core/bus.c Dan Williams 2021-08-24  499  	int rc = 0, i;
> 40ba17afdfabb0 drivers/cxl/core.c     Dan Williams 2021-06-09  500  
> b7ca54b6255144 drivers/cxl/core/bus.c Dan Williams 2021-08-24 @501  	if (!cxld)
>                                                                             ^^^^^
> Checked too late.
> 
> b7ca54b6255144 drivers/cxl/core/bus.c Dan Williams 2021-08-24  502  		return -EINVAL;
> 574d46ed53b527 drivers/cxl/core/bus.c Dan Williams 2021-08-24  503  
> 40ba17afdfabb0 drivers/cxl/core.c     Dan Williams 2021-06-09  504  	if (IS_ERR(cxld))
> b7ca54b6255144 drivers/cxl/core/bus.c Dan Williams 2021-08-24  505  		return PTR_ERR(cxld);
> b7ca54b6255144 drivers/cxl/core/bus.c Dan Williams 2021-08-24  506  
> b7ca54b6255144 drivers/cxl/core/bus.c Dan Williams 2021-08-24  507  	if (cxld->interleave_ways < 1) {
> b7ca54b6255144 drivers/cxl/core/bus.c Dan Williams 2021-08-24  508  		rc = -EINVAL;
> b7ca54b6255144 drivers/cxl/core/bus.c Dan Williams 2021-08-24  509  		goto err;
> 
> "dev" not initialized at this point.
> 
> b7ca54b6255144 drivers/cxl/core/bus.c Dan Williams 2021-08-24  510  	}
> b7ca54b6255144 drivers/cxl/core/bus.c Dan Williams 2021-08-24  511  
> b7ca54b6255144 drivers/cxl/core/bus.c Dan Williams 2021-08-24  512  	device_lock(&port->dev);
> b7ca54b6255144 drivers/cxl/core/bus.c Dan Williams 2021-08-24  513  	if (list_empty(&port->dports))
> b7ca54b6255144 drivers/cxl/core/bus.c Dan Williams 2021-08-24  514  		rc = -EINVAL;
> b7ca54b6255144 drivers/cxl/core/bus.c Dan Williams 2021-08-24  515  
> b7ca54b6255144 drivers/cxl/core/bus.c Dan Williams 2021-08-24  516  	for (i = 0; rc == 0 && target_map && i < cxld->nr_targets; i++) {
> b7ca54b6255144 drivers/cxl/core/bus.c Dan Williams 2021-08-24  517  		struct cxl_dport *dport = find_dport(port, target_map[i]);
> b7ca54b6255144 drivers/cxl/core/bus.c Dan Williams 2021-08-24  518  
> b7ca54b6255144 drivers/cxl/core/bus.c Dan Williams 2021-08-24  519  		if (!dport) {
> b7ca54b6255144 drivers/cxl/core/bus.c Dan Williams 2021-08-24  520  			rc = -ENXIO;
> b7ca54b6255144 drivers/cxl/core/bus.c Dan Williams 2021-08-24  521  			break;
> b7ca54b6255144 drivers/cxl/core/bus.c Dan Williams 2021-08-24  522  		}
> b7ca54b6255144 drivers/cxl/core/bus.c Dan Williams 2021-08-24  523  		dev_dbg(host, "%s: target: %d\n", dev_name(dport->dport), i);
> b7ca54b6255144 drivers/cxl/core/bus.c Dan Williams 2021-08-24  524  		cxld->target[i] = dport;
> b7ca54b6255144 drivers/cxl/core/bus.c Dan Williams 2021-08-24  525  	}
> b7ca54b6255144 drivers/cxl/core/bus.c Dan Williams 2021-08-24  526  	device_unlock(&port->dev);
> b7ca54b6255144 drivers/cxl/core/bus.c Dan Williams 2021-08-24  527  	if (rc)
> b7ca54b6255144 drivers/cxl/core/bus.c Dan Williams 2021-08-24  528  		goto err;
> 40ba17afdfabb0 drivers/cxl/core.c     Dan Williams 2021-06-09  529  
> 40ba17afdfabb0 drivers/cxl/core.c     Dan Williams 2021-06-09  530  	dev = &cxld->dev;
> 40ba17afdfabb0 drivers/cxl/core.c     Dan Williams 2021-06-09  531  	rc = dev_set_name(dev, "decoder%d.%d", port->id, cxld->id);
> 40ba17afdfabb0 drivers/cxl/core.c     Dan Williams 2021-06-09  532  	if (rc)
> 40ba17afdfabb0 drivers/cxl/core.c     Dan Williams 2021-06-09  533  		goto err;
> 40ba17afdfabb0 drivers/cxl/core.c     Dan Williams 2021-06-09  534  
> 40ba17afdfabb0 drivers/cxl/core.c     Dan Williams 2021-06-09  535  	rc = device_add(dev);
> 40ba17afdfabb0 drivers/cxl/core.c     Dan Williams 2021-06-09  536  	if (rc)
> 40ba17afdfabb0 drivers/cxl/core.c     Dan Williams 2021-06-09  537  		goto err;
> 40ba17afdfabb0 drivers/cxl/core.c     Dan Williams 2021-06-09  538  
> b7ca54b6255144 drivers/cxl/core/bus.c Dan Williams 2021-08-24  539  	return devm_add_action_or_reset(host, unregister_cxl_dev, dev);
> 40ba17afdfabb0 drivers/cxl/core.c     Dan Williams 2021-06-09  540  err:
> 40ba17afdfabb0 drivers/cxl/core.c     Dan Williams 2021-06-09 @541  	put_device(dev);
> 
> Should be:
> 
> 	put_device(&cxld->dev);
> 
> But it feels like a layering violation to drop a reference that was
> aquired by the caller.

This code hit linux-next yesterday so I reviewed it in context.  The
put_device() should just be removed.  It leads to a use after free.

regards,
dan carpenter

