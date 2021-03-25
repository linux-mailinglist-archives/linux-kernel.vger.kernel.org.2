Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 65E37349321
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Mar 2021 14:34:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230461AbhCYNeE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Mar 2021 09:34:04 -0400
Received: from mail-co1nam11on2043.outbound.protection.outlook.com ([40.107.220.43]:53632
        "EHLO NAM11-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230266AbhCYNdu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Mar 2021 09:33:50 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KYPcR7hJB5NUdVf8RI5avyU/xP+okdg74PPi2/3QUso5e4UqFhFDtyRlmooignkqJ1tG9Upy2kEZnfn7P1qb/a/KGK8lM6l/XI6NgXSdGVpAnLKIloClewd+ComWBi07tlR1Etnrb+XrCddvHxRYHzT5FfbI8/QqVCNA4Zo3gv69BgPGuiKd7K8vZYbGl9OPL6v+0kX1RKU+IWlT+He5UEF+9FUgNvmV4j2sGeiuQvGLB8O+RFSnrCDFcENnrB6M5ldfBy91psU3XvJ+kItngIqiGU9Et4perurB6dhki4K8/Re5LdHzj/HXCbrKNEpmq0rPBp9Gk/ZhEdwuv+41WQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JQtxOlF4utEJG2m6ynrCBmsNa1YpxhDBg0IecN1YEaw=;
 b=es11/38iTsYYzIydL7rdXPZqUYe9PZ+xYy4pyE3nCou8YdFs2dRcXMkAyXlWjxWOe9BLGBHeHTPuSM4/CpidT95ybzEpGtWEkkjgF3Jf6wap7s7yUrC3T2inC41LWYA7EM1Ghc1Id5lVyurIAKn+1d4OAvy1e2mAqauzCl9O987/qAcRsb/ue8WPPF2QpdX+TjEyT/UEHDG7jvjIc03+ii1pZeIrqapiddxleZ199qlNNgf4hLYp+56U1gX+1vADHkBCmHvx6NpX6a+y2OEWOjUnOhXUQuVL/0LyFb/3m09lsC88loBnweZZibR0FoHK9DjIxCVhsI6fnaXqMyD2aQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JQtxOlF4utEJG2m6ynrCBmsNa1YpxhDBg0IecN1YEaw=;
 b=I1KH15yqGGka9Ga9DTk7qenj44DpGbUXeQkfQLLmtm8hNVJYgzG1HauYVu4QrjaYBz5G5OOFrr8KTK4rulRCUSJ7yuXtDnE+1nmHHwlVsA8qahLjjt92Uh5u++s4FqiWJCt2MAfs87a9CKkq2cM7aG9BuwXDGFDc//0WwzjfYsp9cnNcgQSNluL7Uype16v5j5dUMkThRpiMiMBYIi1XwzdKfnwj0uUHfgaSnqlY1izTNE3hNmneLjjW2TseE8HVlqKT0RtAemsoopzRc9ORZZCfeupN9ls583amSdVzjx8D9AV1ywF8DZIR+HjwKJztkDwLlrX0691rrgpZCKj7tg==
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM6PR12MB4943.namprd12.prod.outlook.com (2603:10b6:5:1bc::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.25; Thu, 25 Mar
 2021 13:33:48 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1c62:7fa3:617b:ab87]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1c62:7fa3:617b:ab87%6]) with mapi id 15.20.3977.029; Thu, 25 Mar 2021
 13:33:48 +0000
Date:   Thu, 25 Mar 2021 10:33:47 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>
Cc:     Thomas =?utf-8?B?SGVsbHN0csO2bSAoSW50ZWwp?= 
        <thomas_os@shipmail.org>, David Airlie <airlied@linux.ie>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [RFC PATCH 1/2] mm,drm/ttm: Block fast GUP to TTM huge pages
Message-ID: <20210325133347.GY2356281@nvidia.com>
References: <fb74efd9-55be-9a8d-95b0-6103e263aab8@amd.com>
 <15da5784-96ca-25e5-1485-3ce387ee6695@shipmail.org>
 <20210325113023.GT2356281@nvidia.com>
 <afad3159-9aa8-e052-3bef-d00dee1ba51e@shipmail.org>
 <20210325120103.GV2356281@nvidia.com>
 <a0d0ffd7-3c34-5002-f4fe-cb9d4ba0279e@amd.com>
 <20210325124206.GA599656@nvidia.com>
 <00f79bae-75c4-d694-8dc9-35ac21cd1006@amd.com>
 <20210325131756.GX2356281@nvidia.com>
 <13227fd0-6c41-992e-63e7-877f718c1577@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <13227fd0-6c41-992e-63e7-877f718c1577@amd.com>
X-Originating-IP: [206.223.160.26]
X-ClientProxiedBy: CH2PR04CA0030.namprd04.prod.outlook.com
 (2603:10b6:610:52::40) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (206.223.160.26) by CH2PR04CA0030.namprd04.prod.outlook.com (2603:10b6:610:52::40) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.24 via Frontend Transport; Thu, 25 Mar 2021 13:33:48 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1lPQ7P-002XHF-BM; Thu, 25 Mar 2021 10:33:47 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b2d4b75f-8ec2-4307-1dbd-08d8ef929f11
X-MS-TrafficTypeDiagnostic: DM6PR12MB4943:
X-Microsoft-Antispam-PRVS: <DM6PR12MB494350D0D6804B3F90E1E39CC2629@DM6PR12MB4943.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: AntlcmxSs+2OxtBnkjXkXoALS0mq810Q3Mf9g+GTpWMSVuTC1GmtJrz/9eGvD0S6xAJaWMVy22JKkIJ8I+T3IJTnr4IBKo1LkXTvP67Hf8ZUBu/MsArKNjqqgnY5nj9UYgtPaIXFrlzINSrb8Y4KJXMZnF8CWkhPI9iJjuCffThe35ICgALI0oGtS3FmJwVjQhdBTDFdn2w+zcf462BPXmj5b+XIWN54tkypoNqVmtOuTnJr1IE0cvmJosM7JNHQwgVWvkY9E8aWFWHMv2mOpllQnjuYR7cVb4MNu+j1yveHG26ODpxZGkk+i4DhT6O932FWq3wHr/gHxHQre7T47cTm0pxq/3/fZrZuYxU3f6rfWs4SwTMYREmWkxPMI12JtX1WQZO1CT0jdnJJmUqDuPdUhi5OECfjKQqyf1lgNWWqihGHBIAkp41C45q/ZmAXm/ZqiBuyW3sMhZoNl7/cHXDRVkY+rrQFQUbrbEjC4DqrcUwpUh6Nmbhs9HmZ6zFot4xFJhMREbQ1ZA4g6dfkSCmTHeG4ReDtkMgFeBYTBniZHbeb/8rnys9XICFgcqPZdzh/t/XT+60/yhgXTM6vIgrHjER8raxRd2MkPVt0pE2LQ2GSHYtiMwLKnPGUdkM6CLZvErI0Pn41TTE2o5iUYcQPV42JwC7z6iU5UqvCmMjyBtCq8GcIDWh0vkA0hLp7
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3834.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(136003)(346002)(366004)(376002)(396003)(2616005)(4326008)(426003)(8936002)(38100700001)(8676002)(1076003)(6916009)(5660300002)(86362001)(83380400001)(9746002)(186003)(36756003)(316002)(478600001)(66556008)(66476007)(33656002)(9786002)(66946007)(2906002)(26005)(54906003)(14583001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?NGZrOHFuVm1HWlRrYlJwRngxMStXQ3orUytoQ0ZDT0FMVFlvQWtKU3pYTHk5?=
 =?utf-8?B?MzZlMkw3dkw4Z1hUZ1NBdTNyYVBTOWwvTm9Ib2FNMU5ITm1WRndqUkJxZDk0?=
 =?utf-8?B?Rkorc2wvOC9YWnBtaUlBN2lGY2F1dm9oNm1XRmJxOHN2UkMyNGZNZEFTTmdD?=
 =?utf-8?B?VDRYdDZUY212azZOMnVOc3gvN2RUQVNaemNvQVBzQjh4WHlqOGhTUWF0ODZ4?=
 =?utf-8?B?M2VKQytBTzdhR2tyQTYzQ2NNa2N2VFJVenhiOExNVlg3aHEzYkhhQlRIeVVX?=
 =?utf-8?B?bi85WnVNakJJd1JodHp1MU4yRkxsREhKL2Fsak94cStCUUtidTRvRFVtQzJt?=
 =?utf-8?B?Tm81TWlDWS80Rjlod3FZbzBKaVNRcmdGYXl3MThoWmJaZlpremNDTkU2VTht?=
 =?utf-8?B?L2t4KzJzb1pBcVFycHg3NzBOdWhoWkxyb2NDb1o5YlZ5SDArSmMyeEFTekhp?=
 =?utf-8?B?Z29ZSE9NZkxTbS9PY1liYjNuQlRmOU1EbjZYcS9rSU1GT0UxRzBRT3NjajdP?=
 =?utf-8?B?Y0Y1Q3BTc0hZM0dWY1BQMFE0ME1la0R6SkwwYkN2TmMyV09SS25iUEhKY1VS?=
 =?utf-8?B?bVovUEc5RFVhbkp3clNqK2tkN2dIeFQrc3EwdUJRVTcxMjh3N2c0UkQ0UVFP?=
 =?utf-8?B?N0JJS2lHR0l5M0sxS1ROMDJqMmVzcDM4Z2lNTEFOTG1PZ3RneGtCYWVpV3lk?=
 =?utf-8?B?eUZzUGRwTC9xc0FRQ2YxT2N1aWE0N01yRnlTU21YdkdFb2cwTEt4Qm1jM2lv?=
 =?utf-8?B?Nk9YRXl0cGNiaTJwbFpvaDA4Sm9Xb3J1cVJoYkhiTVBWdDdwdTVEQ0VCeEIr?=
 =?utf-8?B?M2FFSGQwSlk4RFNxR1BRZ00zMFlDajRVb3cydlIxQ0FYY1dBVE1rN0ZGY2M4?=
 =?utf-8?B?V0lvVFoxYjdPZFFrMkFrcVdsWXVXRFBSUzYwVWNpRjE1UlFDcm1NUUp3QUVK?=
 =?utf-8?B?bDRqT0xkZ0JYZ2UrUkpmaGNQK0k1VWlmUS8vc2ZyVngzbEx6RmZhVmNra2Jp?=
 =?utf-8?B?bXNnd3JWS2dnOGFlemdMaGQrZEo1cnZueXU2TkFsbkQzc0MrQmVYRFVSaFEv?=
 =?utf-8?B?djBRRzkwYzdIYURoc0JYa3Q0Q0pHWTNDbG5zeGo2ZGJlMDljRVlaOGo3ZFZk?=
 =?utf-8?B?OFBmRWJtWlhMR1hrYTJUVGt3dTZhWVc3bFQ4UHk5STNWYUM4dnk5clNSSHE3?=
 =?utf-8?B?akVRSGx0RVlYNGY2TVBxTEdPK3pRTXdlS0cyTHhOU0l2OWdaWGNBYlBPakJr?=
 =?utf-8?B?MXhRTEh6REN5c2szVVRUTTNFcmdOaVNwYXBEN2NQOFJEMi81VEhFUGE1bktq?=
 =?utf-8?B?SUV0WFNHMEw0SENXaUV0ZE5PalNnUDV5Zy9ITUV2R0dQVTJTRVNXb3hCRjhn?=
 =?utf-8?B?aTBFblpPclM1SnlVZWNJdUR0VjdGcTNMVTZDdjFQU2pKeE9oWm5hQXJEMDc5?=
 =?utf-8?B?VkE4czFjYityUTh0MWlUcE95ck9sNElGMDJZanBJZ3RtVXdmVFd3NGtFcEZp?=
 =?utf-8?B?YmwzeFJ3QzZzay9yYkg5TmZnbnJ1WGZWL0Z1dDlVOGw2eU9NY0NuU1lDNEhn?=
 =?utf-8?B?dkw5ZURjNldaNVZiUFZPRmNJZFlvRm91Zno1V1hPMWJ6clI5eXlLYStrc1Vx?=
 =?utf-8?B?OWJVcGxTOXBzQU5ZQzBhYVVaZHpTK1BIcDVEQUM4Nmp0V2M5SVk3ZkdHYm94?=
 =?utf-8?B?dWtSWHVqQU5VUklFMU5iSVFSOWROb3RHdEJwdlJqVzFtQXJyc2NwYklKNDRj?=
 =?utf-8?Q?rBLxsr4hqinJU77csxiRSfSWsW6TEZf9b1onGt9?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b2d4b75f-8ec2-4307-1dbd-08d8ef929f11
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3834.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Mar 2021 13:33:48.6637
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 81HYouVxalRIrPtxWTO2m7VZwMm08QV9hgCUtsI+sk4bslC1pYZd8h2MnoHKB8R8
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4943
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 25, 2021 at 02:26:50PM +0100, Christian König wrote:
> Am 25.03.21 um 14:17 schrieb Jason Gunthorpe:
> > On Thu, Mar 25, 2021 at 02:05:14PM +0100, Christian König wrote:
> > > 
> > > Am 25.03.21 um 13:42 schrieb Jason Gunthorpe:
> > > > On Thu, Mar 25, 2021 at 01:09:14PM +0100, Christian König wrote:
> > > > > Am 25.03.21 um 13:01 schrieb Jason Gunthorpe:
> > > > > > On Thu, Mar 25, 2021 at 12:53:15PM +0100, Thomas Hellström (Intel) wrote:
> > > > > > 
> > > > > > > Nope. The point here was that in this case, to make sure mmap uses the
> > > > > > > correct VA to give us a reasonable chance of alignement, the driver might
> > > > > > > need to be aware of and do trickery with the huge page-table-entry sizes
> > > > > > > anyway, although I think in most cases a standard helper for this can be
> > > > > > > supplied.
> > > > > > Of course the driver needs some way to influence the VA mmap uses,
> > > > > > gernally it should align to the natural page size of the device
> > > > > Well a mmap() needs to be aligned to the page size of the CPU, but not
> > > > > necessarily to the one of the device.
> > > > > 
> > > > > So I'm pretty sure the device driver should not be involved in any way the
> > > > > choosing of the VA for the CPU mapping.
> > > > No, if the device wants to use huge pages it must influence the mmap
> > > > VA or it can't form huge pgaes.
> > > No, that's the job of the core MM and not of the individual driver.
> > The core mm doesn't know the page size of the device, only which of
> > several page levels the arch supports. The device must be involevd
> > here.
> 
> Why? See you can have a device which has for example 256KiB pages, but it
> should perfectly work that the CPU mapping is aligned to only 4KiB.

The goal is to optimize large page size usage in the page tables.

There are three critera that impact this:
 1) The possible CPU page table sizes
 2) The useful contiguity the device can create in its iomemory
 3) The VA's alignment, as this sets an upper bound on 1 and 2

If a device has 256k pages and the arch supports 2M and 4k then the VA
should align to somewhere between 4k and 256k. The ideal alignment
would be to optimize PTE usage when stuffing 256k blocks by fully
populating PTEs and depends on the arch's # of PTE's per page.

If a device has 256k pages and the arch supports 256k pages then the
VA should align to 256k.

The device should never be touching any of this, it should simply
inform what its operating page size is and the MM should use that to
align the VA.

Jason
