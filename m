Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 50A6F366DC5
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Apr 2021 16:11:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236011AbhDUOLn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Apr 2021 10:11:43 -0400
Received: from mail-bn7nam10on2086.outbound.protection.outlook.com ([40.107.92.86]:41632
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S234800AbhDUOLl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Apr 2021 10:11:41 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O/0O5YrovRk9rj+mWdgElTpOArY+WAIyNYzey6Pssgw+nwX819gSynWGhdkTaU6tQl598UXNNWDiS1EmJZW9GLcRK0jF/AzuZDDMJzo7GB/Pjsm5hGEcedvUaSV7+9fSNTpUsOftYqoNGZSJvKmcbfsyuCQX1pIFTU1eJFa+9HHdP+1fSfikOL32qnWY37W7Bj+8YFTTH+JwAd2PRmZLaLCterkaaRZuT5KBHQVXqwAQjMybV084518P24h2qSgZjL/tNzEzjQdtPuOxoY2L8FwY39zfzc3WPJozYKhWON+W7E9oZvIb68qg2rxILTAMuic3m1sSBF5VPqW3wvvgdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HahP0bPr9Ky4GFw8v1zILE5cTV5cItF73pnzXbJkKsU=;
 b=cwtPKbHlClp7HdKDbK1OwNMkKjoeKJgaMan78/gXAPSUZ9k4QOAMO27eUDdxh2tgFLiHz5/h7Ef0PlHYS2w7tWJZubWXRYx+gRFr0owjmehMbhlEszoMEfvaMjBIJeCkIr2Y9/DQLf3d7TmjDf04K+1mythnMAwVnxMRWZ7oCxtEwdd0Zp6MHXodTYRmiWRCIn4Fdf3Wc+mn+lY3YVs+gdBmJw/dE1MQbXEci9eiluq2O61ywv+j1VWo9dIUchJSJ458JkD2CI7hg6jfC9DAu1E8dMJPor72mM0SUu/1DupudnhSSKhmKDEnzP4iHSJKj10vpyqJTdpbVSR17iUsLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HahP0bPr9Ky4GFw8v1zILE5cTV5cItF73pnzXbJkKsU=;
 b=AQ7AG+fwnyc5aBKXsXEsumYDFYi/VLHKC4Kv7qk7bw+1oU1Ly0U6wDLdIgU3k/XVzPCJKJOPqzo2oxoTw5SZe3GmHlHnHjyHUAP19OMne1Ty+3+CCFV7sHei43L0GT3USONqW8Tb8OK5/gHsXvad9iUbimW8aXKA+Wok/bg3xM6dWv2bMV9+koHfDHVzMOIYGimgpTB7OGcM2On22HQ/R8FxYQxjmdOquTmZzUV+jAHR5Hbdi+U44N4VmAOFl9Fji9tBAusuyVRCM8rNHDPlVVE0Q/bXK8+Y3mbNeFNMa0jH9fCHiO1v9Mkk0yU5KnCK6p6lBRVatvMTxNCqmmj56g==
Authentication-Results: linuxfoundation.org; dkim=none (message not signed)
 header.d=none;linuxfoundation.org; dmarc=none action=none
 header.from=nvidia.com;
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM5PR1201MB0204.namprd12.prod.outlook.com (2603:10b6:4:51::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4042.19; Wed, 21 Apr
 2021 14:11:07 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1c62:7fa3:617b:ab87]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1c62:7fa3:617b:ab87%6]) with mapi id 15.20.4042.024; Wed, 21 Apr 2021
 14:11:07 +0000
Date:   Wed, 21 Apr 2021 11:11:05 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, Aditya Pakki <pakki001@umn.edu>,
        Dennis Dalessandro <dennis.dalessandro@intel.com>
Subject: Re: [PATCH 028/190] Revert "RDMA/rvt: Fix potential memory leak
 caused by rvt_alloc_rq"
Message-ID: <20210421141105.GK1370958@nvidia.com>
References: <20210421130105.1226686-1-gregkh@linuxfoundation.org>
 <20210421130105.1226686-29-gregkh@linuxfoundation.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210421130105.1226686-29-gregkh@linuxfoundation.org>
X-Originating-IP: [142.162.115.133]
X-ClientProxiedBy: BL0PR03CA0014.namprd03.prod.outlook.com
 (2603:10b6:208:2d::27) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (142.162.115.133) by BL0PR03CA0014.namprd03.prod.outlook.com (2603:10b6:208:2d::27) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.21 via Frontend Transport; Wed, 21 Apr 2021 14:11:06 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1lZDZJ-009WPO-Fz; Wed, 21 Apr 2021 11:11:05 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4184bf55-c1c7-4bc9-b4be-08d904cf4e5c
X-MS-TrafficTypeDiagnostic: DM5PR1201MB0204:
X-Microsoft-Antispam-PRVS: <DM5PR1201MB02049F22F48932F36A63E877C2479@DM5PR1201MB0204.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: q7Khh+howWgersspYXek+xe+lfykCfE4ODg/5w9gJZLT9tJXoQmIJiUCWY5/hhqGXwiYI1TtV7TLNPQ+mEbe3Jnnz+9XKVNs0GBQ4Os4YSdSv+YUg6MAH7cpuG4CDPQCmGYLk1LdVWml8YFf33zplq2blUa8KQzR2S+NpzMZMH+GoJgxJJmyNPuzpo8uT2nBJFG/g/yAeGbuVY/iQWUcXPnbbS3rRtQAjLAw4uH81p+5OFNJ9MJfTQh+bWmarcN4HU86o9QpVsa7RqWlZGgbRQZhnVkev3bgjWsWb5BopYqaHMQkhDdI1vyOHKGmDH5DPrNqrf1ri1hNYz4O4leQJjo436ZPw47DAbYBEURGpnU+jSlBbsTx1NRKG+yIHE8ztrrL8gOKnoYhghbjGsbg0VNep1WH71fJGKuOV6YhWAwUlHsFuz9ionaX+WTHSncbS2K3LGIA3QBv6gdlrxwzSIt0xW34z8rmeuMlX1Mh/AOCMj8+Uw/oCK2Tv19c9Gp+Cu+LHd4elA7JTBMYtM0rD33bY+oyoh+ZoNv0XaR6TYNlYB84xfHK3fdrbp/bTmQUlDDLjTIMf/kZylZyWkP7qVUpnIj+3udg6wS8BDJY4qA=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3834.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(366004)(376002)(396003)(39860400002)(346002)(186003)(9786002)(33656002)(9746002)(8676002)(66946007)(36756003)(54906003)(316002)(2906002)(26005)(478600001)(83380400001)(8936002)(4326008)(2616005)(426003)(1076003)(5660300002)(38100700002)(6916009)(66476007)(66556008)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?BQcmGIccYzZXI2bR6p1Mgg7/t+YnM5IIkE55583QsPUuvtRpaFbnSgZ74n/J?=
 =?us-ascii?Q?Qftgha44sfC0f9LhvKUWRgIRk7/7rB3JI40RaKDozuddiWzRaQBxPRUfDpf3?=
 =?us-ascii?Q?n4o0SP4LwpJmORQ2yXd5O3sYGVt3h6I7faJ9G7wTCl38SlZmua2xqrpJlkLE?=
 =?us-ascii?Q?Hl1vnze1PST03kRjU3DzRRe1PlCeB5FU7Ezw0xG0joHjpUwXFwgCPqDxnFZM?=
 =?us-ascii?Q?gvmMTRWLfN1JFOTCqooA+6JgA57Ev2VdiH7gSHEbiAiKsXtDylRuHCz5aIIF?=
 =?us-ascii?Q?o0vMJzVjv8SqDt8toJzlA9JIPW8YhtU/cICT37rlv7uCs8WurmsrOGb4/AZq?=
 =?us-ascii?Q?bS1I/bIPHKySf8oifg1NPrkrvPMWjD73LRVayYuD+nImC8dN4aIg6QkVdXB9?=
 =?us-ascii?Q?obVnBov42AQ9Kflt/TLC/NNbhQmk1s6OFn9mbLimgcXYgJgb6lZbSGCiI6UH?=
 =?us-ascii?Q?xiRCQmqaB9TdpCEYBBHlYSQNGEepzj16+Vw+7OkMt2GB5Q4t7Y2+BywRtUeO?=
 =?us-ascii?Q?VOP9nrtHeHwHXrx8oV8oZoKVs1XiCimN2cPpEnhRLNWxKDS6CHHXvvlvV/4m?=
 =?us-ascii?Q?KrzFu2CkEZa355Cd9lZy0ZCJ9BMNT4proKVmNYHbmRLykZrJsi/4DGl6nejf?=
 =?us-ascii?Q?NC+2nPgv/PcYHcKRI5QCRrceefAA4KtOpb5e/tJBjVkjqai5km1N+1967mVM?=
 =?us-ascii?Q?ahirWtaFSAfirWXH3Ht9sS+lCwdtknP1hTzu4pi/3ra89mzZPlKx7y5kwze4?=
 =?us-ascii?Q?3G+lD9tz2YuVD+AZg4Zf90iuWlv2VThadGjexz4oTOKIpREI1+qgjvmM6h3r?=
 =?us-ascii?Q?KJ0sVOmgwasCxnN+EHKF9Ql10F16ZxhcHCCXA6/HtkrwePN0x9V7A8bXojGV?=
 =?us-ascii?Q?4urLTczw1Qtc0EDQXmRsaV1CEeExwRfKyLBYf0INDgKIw0wRBrtXbbnJ6fIC?=
 =?us-ascii?Q?q4MYYBZvk5CXjJoouw4sXJg2itE6qAN8YR6gAxCz+ZsNRkAOqvJL3dDjUJMJ?=
 =?us-ascii?Q?dYJgcNIOtxqPtuqQOB+pTOBwY/TWhiVY7AEW40fu/LHVF2ryVs3D8QTOi+Lf?=
 =?us-ascii?Q?VtTz3FzgjXXvrUaoQ5n9qgP70vikRBZdvyOM79iN+cXkIzoStgZCZFCGSViY?=
 =?us-ascii?Q?hz6bW6Zyz+na+SmDueODZRZSuB5RBol0fEkr/29pFJp0MSC3aEdxOe1WKlcD?=
 =?us-ascii?Q?K1teWKFuyyZWAETFkjEp9Dm5jg0G9u0eOw51BaJe4PxdTWcF9Sv3q0oBts8w?=
 =?us-ascii?Q?7OfmbfhrapoXnU6OD+V8q3n4eSUeQzDbrOEHy7DP1G7EXfsLoHBDnYcdW73R?=
 =?us-ascii?Q?ngck9bZqwN0zDqB0dAerj/D3X+/IQzYaAJV7wy2Jmi3Vkw=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4184bf55-c1c7-4bc9-b4be-08d904cf4e5c
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3834.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Apr 2021 14:11:07.0994
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xCt42mLH+4YNvf35Hus/S8hA8eNq26v++jMsROdZMa3kUCw9zvyneb66eg1/jqkc
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1201MB0204
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 21, 2021 at 02:58:23PM +0200, Greg Kroah-Hartman wrote:
> This reverts commit 90a239ee25fa3a483facec3de7c144361a3d3a51.
> 
> Commits from @umn.edu addresses have been found to be submitted in "bad
> faith" to try to test the kernel community's ability to review "known
> malicious" changes.  The result of these submissions can be found in a
> paper published at the 42nd IEEE Symposium on Security and Privacy
> entitled, "Open Source Insecurity: Stealthily Introducing
> Vulnerabilities via Hypocrite Commits" written by Qiushi Wu (University
> of Minnesota) and Kangjie Lu (University of Minnesota).
> 
> Because of this, all submissions from this group must be reverted from
> the kernel tree and will need to be re-reviewed again to determine if
> they actually are a valid fix.  Until that work is complete, remove this
> change to ensure that no problems are being introduced into the
> codebase.
> 
> Cc: https
> Cc: Aditya Pakki <pakki001@umn.edu>
> Cc: Dennis Dalessandro <dennis.dalessandro@intel.com>
> Cc: Jason Gunthorpe <jgg@mellanox.com>
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> ---
>  drivers/infiniband/sw/rdmavt/qp.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)

While I don't see anything obviously wrong here it is tricky enough
that I would revert it unless Dennis says otherwise.

Jason
