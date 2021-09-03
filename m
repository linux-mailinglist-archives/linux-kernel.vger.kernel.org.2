Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DAC3C3FFB98
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Sep 2021 10:12:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348160AbhICINI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Sep 2021 04:13:08 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:17054 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1348135AbhICINH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Sep 2021 04:13:07 -0400
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1837gshA017054;
        Fri, 3 Sep 2021 08:12:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2021-07-09;
 bh=xLOC77fpq4pFaHvmpA+rwVtblUF/DLkN6iem/gf2SH0=;
 b=nEiNVuC1erafLQKxcGbxdvhAcsgu42ZBclI3S85MoUirzptGNsz7H9tzX8Fk0j+wRmi6
 NvH+D07N/vyLkUhrXi7vfmIs5Ce9lCmuQR1WaGPnFlybdKL/WmBNNGknJRw1+ZeH1KW6
 DcDI/0ehPqy+voQHXPpHuqcEmYN3+14mFGfGh/v00GJxW5C4WHruHTMZ3o7cjQCSVzkF
 WO4rigldZfLsmVDVMJ76WuJqZE3jlfFW4ApXYRCor4LieuNCZeaIOT2bcxvcnJwSTjNi
 sf/AmdwrV6m36ukyIDLUG5UamqXAA3EbKPJuRe+UkVZz+oGTAhYy1CnwqyG7R90Rs6ov yA== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2020-01-29;
 bh=xLOC77fpq4pFaHvmpA+rwVtblUF/DLkN6iem/gf2SH0=;
 b=wDLOuM2gRjXPWNdLyUUTLiu6PGghI4j8Jarhcuzr4J5WH3i9OAQ81zM+sXY95KZQ2tgU
 5RjFvFE1U6HzU0LHm4KmKDNsPXdiZc9IMYWxnOLHIds/LKMT1PvGKbm34HswQFSjMQch
 36WQFUTVWOY7+JLp9xi2toNLEeWFHkDDOiA8whGaKpPepgWfnym4fxAbV3yIYL14/g/l
 1v0SSLLbiH7wqxjhIDPPDiZGRnp0hlRA48dJIh8ZYgG7VbpQ2xcdUMXUxF94yBFCC5IL
 AOiYgMEYEJraclL9pN4eToIsOljbwuOjAwp45k7xYnf0xxlImI5HTFoARWaMw+lWJt9K KA== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3aufj782ff-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 03 Sep 2021 08:12:03 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 18389jrh122082;
        Fri, 3 Sep 2021 08:12:02 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2100.outbound.protection.outlook.com [104.47.70.100])
        by aserp3020.oracle.com with ESMTP id 3aufp30m3b-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 03 Sep 2021 08:12:02 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ilVHxkagyWkeCQOkqnnhhMGvXZN77O+ldf5/NNsSXcOqhYmTzM+qqvLb7P68sjdGllO1iB5mdLuL6E1cDmqDhkrRzuIc/x1eTPeIgAB6hcg2OMEE6fWacpfz2fHjmwCPXEUjGzLuTNUCiUHIvDKO7Va89HP2SSQSs8miugHOT0d8sa96YqI3vNageTsF1ylq0X8R5ZkpNhk7UfcAwmS8XYGa/stv8x1pZHSeiQne4YHElq9lhAle32HbR8mQh3TJM4Nd2w2AoUrzFYjaIuA1nej06c1gq9aWxSWvhLYD15iahdwtAuJXxTUqfUCVEms3JY6FdbT07pVjrMFWlp3tOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=xLOC77fpq4pFaHvmpA+rwVtblUF/DLkN6iem/gf2SH0=;
 b=Coh6m5rMHjdZED7FYhhGG7gQbe+6UHW5bCpEqgv2aQkUYHlErL5lGB54Il97ozkXy7LLr9tOA/fgViNYNSxO4lhhkirRh96GHe+VgAq1ufMvZsD+DeBnlRRqfL+lk6w4wYKxnhfd8aBlgA/SpptHGIeakL9GtlJoQT8imXe5PuI8mxIHhlfHDFS1ijUGNsbNeEvXnX8ASJAc3X+lTQJGdd5BMFU2Cl35+FSrleLrR5fnDaiAzxCxLlB6tHXfmfF8LKWoi0t+5EyM/eOFuXDYjY36A2W5ECPZn7636/eoYFmI6XrN5HqJM6maNedq0MK6HLZ8Rrw3gZtFWiFyA6MGkg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xLOC77fpq4pFaHvmpA+rwVtblUF/DLkN6iem/gf2SH0=;
 b=Bg6mhxRiMF8FVkPhdVK6knvgbTIqT+f1sUVOrrPvJOSwLrjcFKpq1dhxP6QJ5ftTl7MdSuGmbeqRrY6ibb4gMtLk+USbLwUdhf21UiEAoCAYgyaCZIBhFB0z1qxro9I1BI33YOhTivPfn0TC08z0Ssz1sDmS/WQt1klNw5u9bLI=
Authentication-Results: linuxfoundation.org; dkim=none (message not signed)
 header.d=none;linuxfoundation.org; dmarc=none action=none
 header.from=oracle.com;
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by MWHPR10MB1245.namprd10.prod.outlook.com
 (2603:10b6:301:9::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4478.19; Fri, 3 Sep
 2021 08:12:00 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::5820:e42b:73d7:4268]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::5820:e42b:73d7:4268%7]) with mapi id 15.20.4478.022; Fri, 3 Sep 2021
 08:12:00 +0000
Date:   Fri, 3 Sep 2021 11:11:43 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Aakash Hemadri <aakashhemadri123@gmail.com>,
        Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 3/3] staging: r8188eu: incorrect type in assignment
Message-ID: <20210903074517.GG2151@kadam>
References: <cover.1630148641.git.aakashhemadri123@gmail.com>
 <74c156553614f44a900e987f1185f3388dd740f6.1630148641.git.aakashhemadri123@gmail.com>
 <YTCZTY1WsHhTBjUE@kroah.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YTCZTY1WsHhTBjUE@kroah.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: JNXP275CA0012.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:19::24)
 To MWHPR1001MB2365.namprd10.prod.outlook.com (2603:10b6:301:2d::28)
MIME-Version: 1.0
Received: from kadam (62.8.83.99) by JNXP275CA0012.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:19::24) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4478.19 via Frontend Transport; Fri, 3 Sep 2021 08:11:57 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8655f84e-b328-4629-07db-08d96eb28178
X-MS-TrafficTypeDiagnostic: MWHPR10MB1245:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MWHPR10MB1245E210EB762B311FAD14158ECF9@MWHPR10MB1245.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: W76H792l0Feh7Z/b4pDO2pAC5TLn+3hJykBObHXon0HMhR0dYDHmbetFuWwgeE6BEftapYFnFM45XFOtpCvmFQHDQIhNsUBC5XjoxoCKK+V3jFAx5XOEwx6MSHgX68i5GWd9SMTJFPPQyLGWdgld4+OjYbGWKeqdJGHnuyr+pT1RJNfxyPwXPX+bv3zArHqShOCPd9b93NOoE+mmzUEuqQWsI56BPYXBZDix5BDSCGCeyuR2ja6KSZTOPTBv1pPtUJZRWgDISb23AaJhZ7DLjz0JnWElNnvmA7ipVYg0uYPfHqqPgUO/TO6heE9TdnYoXLt5fCRyLx6dne5esmPFO8vnh3KChMtsv9yBzEVrAN+ikliFcX/O/cGeCv7VIGjlsji1Hi8kzckk7/NFG0c+CxkK++p/kLvt63VHw3nq+1b/ku5ld90T5KbwYJs/p5KtzoUHnd9e0F0nHmefPik/sUo8w3iihxwAsiNEyxIrdmdCP3dfWjveh7FE0SxmRfNXfOHiF/G4bi1R3MKoqxp+2cscQn4J1b4W+px/Z7BwFf7gWn7QDe1b2DK8xz4jR06RuhNiPwXE7bwgJCCn2GOBAfxjz+lMQGDXMF+NYHuGTAxSAbbLLyLfbq8AHR3XXE4mLpsR6juWdc04VchMItlplprZcF64W3O+PeoAt5U0pf5YsIxXS1dTPlgkeP5i8/OEZE+ozr2DHLhIxS6IOkzDBw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(346002)(376002)(136003)(366004)(39860400002)(54906003)(38350700002)(9686003)(44832011)(4744005)(55016002)(1076003)(26005)(86362001)(478600001)(2906002)(9576002)(186003)(8936002)(6496006)(33656002)(38100700002)(6916009)(8676002)(52116002)(33716001)(6666004)(66946007)(316002)(5660300002)(66556008)(4326008)(956004)(66476007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ip94hTu1AGPq9+T4UhGQuUph/+UE2hjD+P7Kqz6zY9ndqYtQ7LOdnUW4SBpz?=
 =?us-ascii?Q?OgOFjcdcZ2N8V7/gdZBg0+0fyurAzWbIG8v8CctO5OrMsjVM3crjTmdCaUfn?=
 =?us-ascii?Q?peZPKPO2YemYIeB6e6b3d2Whfq18xk7r7DseJd3BjtX3vTUpEE6Q/5j6Cv+1?=
 =?us-ascii?Q?HR2WCvrH7DH9LG+xpevueOBywZgyGoMU3n+kFpM/Yj9dd/OkpSx51sjm0NQ4?=
 =?us-ascii?Q?o7vZtJv8ge6h9VRLn+rl7xnMDsvEKVBJ+RvZJErsMTd9tS6QuA9SxZQeDxc6?=
 =?us-ascii?Q?icw8zrupfkrkyuwtJEtUcxGqHmlUhNtd94ol9AETydUSusBvkR39xgGizxnv?=
 =?us-ascii?Q?8EaN3KeYXaam1THUP2OUzCuBwFGsxBkYWs9tHYGKgz+4fdVGGQXKx9yUNynb?=
 =?us-ascii?Q?72Vc2exZ1lJ5rHFBD4xM+mFkh43UXCDm7wJR1KRv5nOi3mqtWgwbF+vGMktO?=
 =?us-ascii?Q?vAwbRzPRJhoN8+ulJqx1vJ3+Sjpmcxk4zrVoIba5h1zBVWW9vQgOvmhwDP6u?=
 =?us-ascii?Q?Kvu44Ow1SdRb1CnMQKi+J+lLoy9BQZAME5EmhNR2dKPqYiOcM0pyKFCuQqFZ?=
 =?us-ascii?Q?7cZx0DPsIJe8MzbLcSn0CtWOEIgqZCbBL/idNVG230tm2WeLI3w0F3TvzHnf?=
 =?us-ascii?Q?QhB/kCvOTTXWcYLeliUczyc6wZA2ACZI9rjOiId+Mr4cDPKJm/F2ICpjLe71?=
 =?us-ascii?Q?eJGFJ3qP8r+mE+aO0MIOW5MWDc9LNZ8RXUt1V5f0TE6LrR+bkk4E/88uR7cF?=
 =?us-ascii?Q?QXgYDaDicm+wMLDBt3KcitRjhfGe1tciyTSwTYihS0e97gwD20PuNLMqSjG1?=
 =?us-ascii?Q?531+vV4SDnIWloPuU2NXxKonaLBMIS0HB3PH/RAZGbRzPXmm7qspkmUhs9P9?=
 =?us-ascii?Q?Yo+T5X8qJ0Y3u/AFNJ3wXaWocK2y5eNPLf6yn6DSBdS1VSVfApvS/7Bfny6o?=
 =?us-ascii?Q?QQGbS6ojOFsAeVyFEgX+HnmCsHtViVCma49tJAITiInzIeeQYgFSccMJK1g3?=
 =?us-ascii?Q?A22xiIJPLWbLcAU0fSVRY9PMjKRV4eUT7FsAr5tvu6nrcExrk8nI8aPALTeK?=
 =?us-ascii?Q?SJAWoBwRt3jzOAdOdOj5bRw3gv6i9BiBaJQW1RdVbrKYvqYlPG6oxxs04bLb?=
 =?us-ascii?Q?qVkuxbaFoxaeQG50BJ+KctUC2KpsCekXKyXOvQef6DiCQhB1z8J+K23KhrwV?=
 =?us-ascii?Q?VpLndtsYO0f2F8IJaDf0KSJDyfQQUZmxtdKWEiFSAmlVahNxUeBGpuz5PqJn?=
 =?us-ascii?Q?pyGYLB+cDJ1yVLsCcOV4mz2+OimLzDvO5kC60dPC6/Dyfwbe1gFFoS+ItpsK?=
 =?us-ascii?Q?Bz8mIVRDqQyJjEy6PYjHQv04?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8655f84e-b328-4629-07db-08d96eb28178
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Sep 2021 08:12:00.6935
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ry8GYDT7Jzqri+iuOIq0c4A7jqJVgCC2MjK52kyfj6BSb66+jHQz4K1Uh9jY78DcQQVXv/LG1vh2thL2uC54d7xrDNfR7GUtTqPibt3tExg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR10MB1245
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10095 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 phishscore=0 suspectscore=0
 malwarescore=0 mlxscore=0 mlxlogscore=999 bulkscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2108310000
 definitions=main-2109030049
X-Proofpoint-ORIG-GUID: 67EWmgM9l_AnnILfVdx36aTftkW3imHS
X-Proofpoint-GUID: 67EWmgM9l_AnnILfVdx36aTftkW3imHS
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 02, 2021 at 11:28:45AM +0200, Greg Kroah-Hartman wrote:
> On Sat, Aug 28, 2021 at 04:40:46PM +0530, Aakash Hemadri wrote:
> > @@ -512,7 +512,7 @@ int nat25_db_handle(struct adapter *priv, struct sk_buff *skb, int method)
> >  						tag->tag_len = htons(MAGIC_CODE_LEN+RTL_RELAY_TAG_LEN+old_tag_len);
> >  
> >  						/*  insert the magic_code+client mac in relay tag */
> > -						pMagic = (unsigned short *)tag->tag_data;
> > +						pMagic = (__be16 *)tag->tag_data;
> 
> Is this whole function ever actually called?
> 
> Can someone run a ftrace on the driver to see if this function ever
> runs, and if not, remove it?
> 

Yeah.  That was my thinking when reviewing this patchset is that the NAT
stuff is probably not well tested.  It's only used for WIFI_STATION_STATE
or WIFI_ADHOC_STATE.

I don't think it's dead code but having NAT code in the driver is the
wrong layer probably?

regards,
dan carpenter


