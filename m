Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B6D29366D99
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Apr 2021 16:06:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243303AbhDUOGb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Apr 2021 10:06:31 -0400
Received: from mail-eopbgr700042.outbound.protection.outlook.com ([40.107.70.42]:24673
        "EHLO NAM04-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S243275AbhDUOG3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Apr 2021 10:06:29 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WpDxo4nEeRvrzY1sHNvQb4QeY0qlWNX82mEyh0rBOmonkbKVGkxlaLggeQRmiw9n6WdlhlbyWwiDu2OkTlfg+oO0CGNi2OKCIPIg26d+qE2JdZDIZasSsyH4ATA8yFyEY/RUrkOXoJ4OuWOmOQ8ZOV6cLHihomNwgLEvN4HHGmgXbU3vZPfdeTz3bEzlV2DeUBXuox3nQ3VPtmatN3ZUGJaWYr3cpxtIbpKcSbG4saj/jYIyUpQCDMrTLbfo7cgEyMXdFso8/QHrkvcu2cKp7DPMljAQz6IpKGeygBp20UJDtR5i/Zb5K5j7a3Iis35ZWe0JMUrGqeR1irxWS13y7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wX1YJQinYoocCQvxUnR/mpHh1+dv792GYF5fU5D0iAA=;
 b=oHo4fJlRuSJJk+nYhm9A4aUyzqEwOnVStRG2i5Ds2uK9nPwiF4hhOHfEMZxfe06EiryFaXyltqKlepMyaTMrq/nhQWCQ4P+qkK8HSQyaZ0JzEISYWWVoflTfBT/nJztXkynSGEzuiLr+1FyvkWi0+qT58tqvfZU1I8JNBOHJiCZJbKkvidwfhchcb+VaDciu1IF9K3ockYiFuPzbYPk/MzuyZ9KEGK15Nnm1eYihijyHtC2l/ksy4GAy/PLG3e1Bw0CuVIN7oEIRBuktwoF4TLdpLInDzEt9KNxRmpArw8vzRzBHoV2TSXwkILsjb3iFT7CQDcqOjYubfFr3IVshZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wX1YJQinYoocCQvxUnR/mpHh1+dv792GYF5fU5D0iAA=;
 b=f7ai4a9U+WvJhsPg+xMgXK24fxmT1ZwrGX/kvCxo3ut75hDhu3QL5oKvdines6WcrMzJKVC6NyENHf8uFxXYUusQzAjfS0np+K3smSrBVFfWYAV6LOfZUgk91GLBZOGn+yPvLHfNBckEkeMEauR1J3GUINzBb9N/CrvnRx8vnJUQMxz77xdYiwYGB1EbuwLwzsuxbcl/iXOGdjN7GaikF2TAW25O/vcfqZGtXftaYgp9m8WlQAwuqZsbeqMylxK8I4zjA+QdAOzZDCTiDyCv32nfWC2A+z/9zuF7gArTP5irjXWaOlcGgbjo06IDgYhd7GuQaBTUY5mCuDCZvgIoew==
Authentication-Results: linuxfoundation.org; dkim=none (message not signed)
 header.d=none;linuxfoundation.org; dmarc=none action=none
 header.from=nvidia.com;
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM6PR12MB4513.namprd12.prod.outlook.com (2603:10b6:5:2ad::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.20; Wed, 21 Apr
 2021 14:05:55 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1c62:7fa3:617b:ab87]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1c62:7fa3:617b:ab87%6]) with mapi id 15.20.4042.024; Wed, 21 Apr 2021
 14:05:55 +0000
Date:   Wed, 21 Apr 2021 11:05:53 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, Aditya Pakki <pakki001@umn.edu>,
        Bart Van Assche <bvanassche@acm.org>
Subject: Re: [PATCH 059/190] Revert "RDMA/srpt: Remove unnecessary assertion
 in srpt_queue_response"
Message-ID: <20210421140553.GA2268573@nvidia.com>
References: <20210421130105.1226686-1-gregkh@linuxfoundation.org>
 <20210421130105.1226686-60-gregkh@linuxfoundation.org>
 <20210421140247.GG1370958@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210421140247.GG1370958@nvidia.com>
X-Originating-IP: [142.162.115.133]
X-ClientProxiedBy: YTXPR0101CA0038.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:1::15) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (142.162.115.133) by YTXPR0101CA0038.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00:1::15) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4042.19 via Frontend Transport; Wed, 21 Apr 2021 14:05:55 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1lZDUH-009WAs-Oo; Wed, 21 Apr 2021 11:05:53 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c7326429-36af-4c21-d33d-08d904ce94ad
X-MS-TrafficTypeDiagnostic: DM6PR12MB4513:
X-Microsoft-Antispam-PRVS: <DM6PR12MB4513AB29C21373730C9B6363C2479@DM6PR12MB4513.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:635;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OdOIGoxAgZakbuysOaDbXll1FbzrkKLBsQnzPqi1M2Hv/sMlJfeim6yNLgTXCWb14niKUQzUO0SPsD3n+VIgs3tmCsRLG87l/Zlijfffkt35SdLHtFLwX1/8erx/Pt7lmfI4oiMojlLDseK8hK8r6k6Pt0wxjTzFRPbWW7hr3/5jbXUOluBOb/YdFPjTmS/hXuK7/Qozei0Jy9z2OWpdQnP0NjK+8i/MGkxdqXe8NGgus89egSeUM3AJCnYyQX7KzELgGWCElGaxEgISADGI6LMhbCAGlHPmhSsy8yHbbZPj7EnBZbRSuxLMdQoCiNe+dho430AXt+ogXLfRvEFcneHEXOLAfXMeFVIjvjswEQgK/LOeSPZrVIyf6Oksm2fXb4aSd5a7OupIOZNf/m65XKXhrxz/MN6KCujfkWiycJZwEDKFTzbGYNu4B44VIyoffSedYrcibtWcdNKsGSWmohEhP07E+n5Gof4yNoEsBje6HWLEx4U59JNt8XBRY43nVvIASKpmInQqHOcqeDnO+xa3MVQzSYFqcjrYk0NPCbOMFnRGuS4AJuXi32KMHEWCyhf6CPKuUjEnWXIGt5Kfajs9GzHMt+eF/XjTX39BnDU=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3834.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(136003)(376002)(396003)(39860400002)(346002)(2906002)(316002)(26005)(1076003)(478600001)(6916009)(54906003)(2616005)(8936002)(5660300002)(66946007)(38100700002)(66556008)(66476007)(4326008)(86362001)(186003)(9746002)(9786002)(83380400001)(426003)(33656002)(36756003)(8676002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?QLe9hlQ641DognC80ILwlCf3QT5ceBGUy5Ylaw32Ty92GDkdJ6ZpDB9vCP72?=
 =?us-ascii?Q?iOhGRZl1ZJy6xDeHluFkb0ZxHQoYqzyWAxQ5iO5jVH44AotZOCBU/Gta+N3D?=
 =?us-ascii?Q?h8opZy0YCjwoioUrm7La2pKCAl9ErJq6AqFTKnVVq86GDNtKfmQfPthA2nCE?=
 =?us-ascii?Q?AdFVbQwtw+sHrU5JNizWluByj/iDa4h4WG3T465IY2gPBKdc/TlGaS/WbQLq?=
 =?us-ascii?Q?Q1ByyRGZ4JbcgkNlxdyS1O5k3W61zUVTq4KIXE+vaqnUPeFljv/Kogra9HgD?=
 =?us-ascii?Q?PxRLZyKsxyA2qMyIGrU4GTxldEEnwxUel6R8byjp2daMLse58ZiwlJ/CBNyb?=
 =?us-ascii?Q?f3xRGvXzuLds/MKs1GBj9yvo5CLxu+0apoksQV/woxKkxveDx5zQtnOMLfyg?=
 =?us-ascii?Q?9Tbb32Cjf/ZtA92QTuX9obzWwvwdFO6vko5b44qXvKB/fkBrILHGN1qeST9o?=
 =?us-ascii?Q?ChjYIFIG5efroOQKPKiyUsDw6gjPhH29wsw3e7jDpM5SjyeZwyfdb+dbs4vo?=
 =?us-ascii?Q?eObwWYozIg7WtvRZxIpgfc6HMzQ/tgAkpNMY8IcO7Ccs5aeZ9zs3ujj08bUe?=
 =?us-ascii?Q?tmF/HP1i4LuHeRldnjV0TKZkGGj04k9U4t/l/rgyWMElXLvGM8Z6oSdZ3fd0?=
 =?us-ascii?Q?0DcAWeS13T0+hkPKBr4JK/NjwJdXam6Fxy6N+kjCJFjJ6ZIMZcyyJf2+Qmb6?=
 =?us-ascii?Q?BirNI1EHEuUN5VINRuPJsrqlATsZwXW4+RNjCSyXnyYXodQ9CCBkKBQrUXy4?=
 =?us-ascii?Q?VGCxMzTpUZLwxGL76aEpvBGkJWZ9H8hoTSlhcRZAwkl1AMVQjL6IhnI7quVG?=
 =?us-ascii?Q?FpW7sj0g/a1CeGksajhhwYEhf2pp6QvRovS6ZFH4zHixVXSiKMNbtwaNKTbW?=
 =?us-ascii?Q?v2PhFRCIlW87RdF91ubg50RE4mXu3PlboYdq/F+oXFsghZu1V6uU2wg/yHk/?=
 =?us-ascii?Q?zeNkGxn10wOigpuWsKnq2JsX0azA3d21NPaqF1HQBkh3WPWqfH4RukFH6ySC?=
 =?us-ascii?Q?6JKNHOCZg6sF9N2FeOdV5YArXg3HWCBrPstBc/NQ81+1gOB8mq09z6d+Psed?=
 =?us-ascii?Q?l0yq0e++KZ1JDPJ3p3idN1MtsyscXzxlOX0wN6r1LzKNb1lvYH7+o9epWmoe?=
 =?us-ascii?Q?P0wT+bd9//do+t7uWeUq1iyR8LZJsoXPPxEh5J89EYowYTKnGpcSXECDbSoa?=
 =?us-ascii?Q?NhfbfUZ9OIe1jA3wLRUfO6pybHeRbpowePB6DktPOhqy7lXDV7T9G4SRKObb?=
 =?us-ascii?Q?e/nTGWGC5aP58bAC3ZnIpsSvjXzrf2L6ymHCXU0iidAWah3D0yjxnELP/eXY?=
 =?us-ascii?Q?KAq5k3sDfRugAm5G8pQIxsb+9/4nhm4kpcFQFuS+rfUsag=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c7326429-36af-4c21-d33d-08d904ce94ad
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3834.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Apr 2021 14:05:55.5628
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6UKwU/sAYaBhOGW/QHzjYxR0jvwQy0S0GvDS+V03qR6J5na7s5hM/ltMs6sKbV1u
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4513
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 21, 2021 at 11:02:47AM -0300, Jason Gunthorpe wrote:
> On Wed, Apr 21, 2021 at 02:58:54PM +0200, Greg Kroah-Hartman wrote:
> > This reverts commit 9f48db0d4a08624bb9ba847ea40c8abad753b396.
> > 
> > Commits from @umn.edu addresses have been found to be submitted in "bad
> > faith" to try to test the kernel community's ability to review "known
> > malicious" changes.  The result of these submissions can be found in a
> > paper published at the 42nd IEEE Symposium on Security and Privacy
> > entitled, "Open Source Insecurity: Stealthily Introducing
> > Vulnerabilities via Hypocrite Commits" written by Qiushi Wu (University
> > of Minnesota) and Kangjie Lu (University of Minnesota).
> > 
> > Because of this, all submissions from this group must be reverted from
> > the kernel tree and will need to be re-reviewed again to determine if
> > they actually are a valid fix.  Until that work is complete, remove this
> > change to ensure that no problems are being introduced into the
> > codebase.
> > 
> > Cc: https
> > Cc: Aditya Pakki <pakki001@umn.edu>
> > Cc: Bart Van Assche <bvanassche@acm.org>
> > Cc: Jason Gunthorpe <jgg@mellanox.com>
> > Cc: Jason Gunthorpe <jgg@mellanox.com>
> > Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> >  drivers/infiniband/ulp/srpt/ib_srpt.c | 2 ++
> >  1 file changed, 2 insertions(+)
> 
> I think this one is fine

Sorry, I realize that is unclear. I mean I don't see a reason to
revert this patch.

Jason
