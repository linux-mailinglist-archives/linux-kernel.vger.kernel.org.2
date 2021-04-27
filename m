Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2483336C91B
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Apr 2021 18:16:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237394AbhD0QQn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Apr 2021 12:16:43 -0400
Received: from mail-mw2nam08on2051.outbound.protection.outlook.com ([40.107.101.51]:2543
        "EHLO NAM04-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S237459AbhD0QOK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Apr 2021 12:14:10 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MDhtyXIMDjkMwBllkM4ldj0orGaOmEOR8dRWcBNc0zqt1FnY7v1r2yFUiaqBZozvr6bwRvsnR+NEx6Hrf14rWYmXgzdy/HVzvrhygRtb4aJCaKGciWPwHEQkgNZ15OIF5+/cqyFUJ80rvpm9JAdm4Ui+ryCVWyRoVBVUKfXxJM4e8q6AqUiPYpOTSKxOHvSVaLSLUnP6oLsUZFDKYVEcK18WaDDa+ph4hQczNYlIMLwE2sBdCEoQIF3iA02lmywS04ZpOSYVgoZ4quH23afPg3mawudCofg/mMChlr579hk0yLqD4osNTd7ETUoXAezhn0/OKtY8wTLIrbE5qMdBoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hFKjg6+c2u/KTzfdTRCo6KteVHbhLl5qKgUXVPnc03c=;
 b=lpA+m9QIui2KC19irJALyR2O8fFj2KTJb7it2bLRwT1boIkxwskP0a6keRphvDjlT82BA4FPemPzsHAtmQqKpptfdfLQ4tkvG5EnOKkwNHdy2b22MaWrxy3v4M2nKoz7Rdr7hx9Omm2TG4JkHqg/IqlY+uHjPHPzA6mNhldDYpVagGBlh9xayIqL5g+VS3fTEZ0R517yorf5cjHd+PE1dZnwQNzDYmQXKWd25//3DLRHvLkYzWNEtjBaRK6wAqbZUq491TxFR20tNSqo3HEO0eMMisjpxTDign7AtkKzqGNVVbL94cyJ5711NGxVwQd841ekq8B6pF/lXWUYflqukg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hFKjg6+c2u/KTzfdTRCo6KteVHbhLl5qKgUXVPnc03c=;
 b=dJOv0AZtJwO++LFIJ40hE9FpkpeUYSd6Dz+RxKFRoeHn/uwwR5Ml5Z4BTfft2VPIeJP7wuP1nuVk1XHLELKwddfDUnAWZNiZ/2e4PBdWR2ldacjuAp0eY3uJpFIvfP3jQePo0l0JlTAoNealHp/irZo6JWBGecjPwuovNgdSf28e4YylNRLYleflmZui4zj7UWnqZgAbjRkLvQFbhFTh0Qa0xm7V6zj3Ay6aarVT+E+NVtz6W/7+BgXHrNqyQrcUP66LEwmnFvbvT+fRF8xGIC7WZkkXxsR+TNNbpXnq615CL3GNlmFiky/xs+7//yV9quYQ7ewci1AG3Ad9hlqnxA==
Authentication-Results: linuxfoundation.org; dkim=none (message not signed)
 header.d=none;linuxfoundation.org; dmarc=none action=none
 header.from=nvidia.com;
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM5PR12MB1433.namprd12.prod.outlook.com (2603:10b6:3:73::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.21; Tue, 27 Apr
 2021 16:12:37 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1c62:7fa3:617b:ab87]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1c62:7fa3:617b:ab87%6]) with mapi id 15.20.4065.027; Tue, 27 Apr 2021
 16:12:37 +0000
Date:   Tue, 27 Apr 2021 13:12:35 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, Qiushi Wu <wu000273@umn.edu>
Subject: Re: [PATCH 037/190] Revert "RDMA/core: Fix several reference count
 leaks."
Message-ID: <20210427161235.GB1370958@nvidia.com>
References: <20210421130105.1226686-1-gregkh@linuxfoundation.org>
 <20210421130105.1226686-38-gregkh@linuxfoundation.org>
 <20210421141444.GL1370958@nvidia.com>
 <YIgfbZDo9eQ2tKvc@kroah.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YIgfbZDo9eQ2tKvc@kroah.com>
X-Originating-IP: [206.223.160.26]
X-ClientProxiedBy: CH2PR17CA0008.namprd17.prod.outlook.com
 (2603:10b6:610:53::18) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (206.223.160.26) by CH2PR17CA0008.namprd17.prod.outlook.com (2603:10b6:610:53::18) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4087.25 via Frontend Transport; Tue, 27 Apr 2021 16:12:37 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1lbQKB-00DZ95-1x; Tue, 27 Apr 2021 13:12:35 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: faf81b7b-e0ff-46cb-8ce5-08d909974625
X-MS-TrafficTypeDiagnostic: DM5PR12MB1433:
X-Microsoft-Antispam-PRVS: <DM5PR12MB143345EB03184B565E824B06C2419@DM5PR12MB1433.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3276;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XXHIRswqEXqoNtPtPOgnjZSlF0tYpQzdK3kROZu4+Aggj2RLEbQdEGf3JDW4tUE0mr4hCYHOpP1LuoEu97ZFPwQJ4R7C5mEZPgNjes4910/N80g13bPP3JvBuyF3yTx2puFx8n1IuYgKlW6roEjJkUIe0yHXreW0klFGgDeIoDHAzOi25F3wP++Lsyn95CUOtuWecFJQ0Hm6DGXgjOqXfksy7X9f/nhgZAjD32QhZYcKRLOlv18nWfoo1YKxGTcFWO/IafGIE8sEFrHIRmuf9OthfcWwqDSznVQnJ2B0zVWFRp9N9SFE9g5hK79VnpNf8qwyGB0AoM0xgcPFaj1flO5MaR7iDD1U/kctoj9C71o9KenF/GpTN/faa50hvEX4abTAckLK6jrQkMAF09x0wu3+9tyNZIMA9kFmoF6KOlOIPRxLlElEJ/JhzCd1P2eo5yCflnnchYQjOu4NhA+C1ahi+Q3dsrRSILCgk9FGMELgSnL6HgP83A7xSkb8uCNRDYzBz3qEolkAZzJ23rCC8YU4SINvet1O3g5ko3cNf32HMrgcPzDCK9ttk7Q52i6ah5PxqdND6TAJzsqMb6AaOTolgHFsqEk3loRYpdfrPQiMpI/j3taye/PCASFom8/rPG+/UhNpgfB00OO5naUgUS/rYxDgRGjSjaBGlXrR0GeIpWfd07qO8hU4Zu0mBf9Z
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3834.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(396003)(136003)(346002)(366004)(376002)(33656002)(478600001)(2906002)(38100700002)(66476007)(66946007)(5660300002)(66556008)(426003)(8936002)(186003)(36756003)(8676002)(9746002)(26005)(9786002)(86362001)(6916009)(2616005)(4326008)(966005)(83380400001)(1076003)(316002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?0f526J2YK+dmghWKS3eeWLYP8OqibIYvHCKr53/O7ZxbniWl8HOAZFElefga?=
 =?us-ascii?Q?nt15ec22skHLzHVzMstf1q5dQxd+pfwXtiib+sbQNaaNVaIHFG0dZX+SFDwg?=
 =?us-ascii?Q?r7QWJyNj1maieQ2SCyiMKfxhG71bVMHBI1qk6ybyb41xXdPGFHYdsUggLspp?=
 =?us-ascii?Q?3IRz93xQq6eewMT3bs6L5cH86l1HxzZy5aolWrtiwMEaw75XvpNGCr2x64if?=
 =?us-ascii?Q?pWQ7S2zCvVf1UirZG9pkAcEOlyfRamTftB0pG+Rcl3lWmLsazoLyo+zKVKsP?=
 =?us-ascii?Q?IZZjQhWxxKY50KW6888iWUhTZz1QSkMx5t8XfIUXdD0OgDWNV1YRl5RAfVPZ?=
 =?us-ascii?Q?FQmXXhoF/0APa0EEM9JWEupJb/kGBBVViVK8QQptGyKqMa7mAxt2L/tTfxAS?=
 =?us-ascii?Q?T6XMidjgUzCNpMVUODhDED7OapNn2JyHwHrWmHieRTnW7MK4dWmre8j8OrFY?=
 =?us-ascii?Q?ZaY0Md/c7+XfJ8dhCLVd9v+M3ju+ai2DY3MWXa75tNYZtA4f7veSaLDaxxMQ?=
 =?us-ascii?Q?WGO2dA5M6udJLBGsseBNRDGSyOdhihUtk38Vc/gOIxTgV1A4cgjmUpNfT6s+?=
 =?us-ascii?Q?DqLHcKfrPFT/lL+PBRHUMX2aPYwQt4GQ7wtgPm5q/1jxPQYeaxCMM0LISP2A?=
 =?us-ascii?Q?41IUhscVqANYOhOl1F5vb3cBV7XjlCaZccDPgtFcKhHMPd2+VRUDmFGRcjVl?=
 =?us-ascii?Q?R1daADmtDIXxLblRPRoYszdvdyOWM5T6DShbIVV82UqYUvix81LAC/hHQ6J2?=
 =?us-ascii?Q?eUHr6o5HH3+T4fdJoQg5E9Xu1BvahuYeDgj9Z6YRxkbS0HK5V9KsAy62z/Mx?=
 =?us-ascii?Q?4oeFzLYKhGYXqJAO8X6w4UDE+kRAuevMNoC5dRt/ZWZNcbMmY8QNove+aYKh?=
 =?us-ascii?Q?5lcJ6drqU2rUI5wwli61ibn44VUmCRhAvsFbnJTEWw4ItKaR+vinMWHLsSQH?=
 =?us-ascii?Q?z8+4gye0SXsAswG20uOmPdTArMrELLZWYSgwySbOFfgqs0bjidLNtzYvBopg?=
 =?us-ascii?Q?uW9G+WtKSTDb87IQmDut31udQFD8kz2iIzeijZfh7rUjEQhLg5eFmtFRnNpA?=
 =?us-ascii?Q?yYkFNfu3fQ4Oz1eNg4EMb9+Z2rwuLk51J2ATsaJ6k54F+bWbqQgzjuNhfGsP?=
 =?us-ascii?Q?eBrix4YZIX1PB7pp3fxPU8mVwQPlcmMZj9dWbCer+STl//f7SNV4ohdUGbxX?=
 =?us-ascii?Q?a7ss5uvY09CMUbkjj64hnbMxmabyZslxjRb4Gp/2xEl7RSARRNjXNAc2Y0mu?=
 =?us-ascii?Q?v7imtva2R5LkYx6D0+dlH3vfCm+XMpXmTWYARtNv+FWckQUlSEPQmhKDcsRN?=
 =?us-ascii?Q?LPrDo3lX9qDGq7W1DYWvA6MH?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: faf81b7b-e0ff-46cb-8ce5-08d909974625
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3834.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Apr 2021 16:12:37.3022
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: S7EQDGpiInBaP3urssAK/jiNbfFf36+VwkkOr2rECclK7OC5IWzOBp3VP5oEC9qw
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1433
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 27, 2021 at 04:27:57PM +0200, Greg Kroah-Hartman wrote:
> On Wed, Apr 21, 2021 at 11:14:44AM -0300, Jason Gunthorpe wrote:
> > On Wed, Apr 21, 2021 at 02:58:32PM +0200, Greg Kroah-Hartman wrote:
> > > This reverts commit 0b8e125e213204508e1b3c4bdfe69713280b7abd.
> > > 
> > > Commits from @umn.edu addresses have been found to be submitted in "bad
> > > faith" to try to test the kernel community's ability to review "known
> > > malicious" changes.  The result of these submissions can be found in a
> > > paper published at the 42nd IEEE Symposium on Security and Privacy
> > > entitled, "Open Source Insecurity: Stealthily Introducing
> > > Vulnerabilities via Hypocrite Commits" written by Qiushi Wu (University
> > > of Minnesota) and Kangjie Lu (University of Minnesota).
> > > 
> > > Because of this, all submissions from this group must be reverted from
> > > the kernel tree and will need to be re-reviewed again to determine if
> > > they actually are a valid fix.  Until that work is complete, remove this
> > > change to ensure that no problems are being introduced into the
> > > codebase.
> > > 
> > > Cc: https
> > > Cc: Qiushi Wu <wu000273@umn.edu>
> > > Cc: Jason Gunthorpe <jgg@mellanox.com>
> > > Cc: Jason Gunthorpe <jgg@mellanox.com>
> > > Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > >  drivers/infiniband/core/sysfs.c | 10 +++++-----
> > >  1 file changed, 5 insertions(+), 5 deletions(-)
> > 
> > The original commit is certainly moving things closer to being correct
> > but I'm concerned the entire area is still not bug free, it will take
> > me some time to check the whole code. Reverting seems reasonable for
> > now
> 
> I just re-reviewed it, and it looks like the original commit is ok, so I
> will drop this.

This was what I thought too when I originally applied it..

> But ugh, this is horrid code, you should NOT be dealing with "raw"
> kobjects here at all, just to try to make a subdirectory tree.  That
> causes a total mess as this function shows and probably should be
> cleaned up sometime as obviously userspace tools are not properly seeing
> the objects you are creating here (hint, you can not put a kobject below
> a 'struct device' in the device tree and have udev and others see it
> properly...)

We've talked about this specifically before:

http://lore.kernel.org/r/20210331170720.GY2710221@ziepe.ca

I still don't understand what you mean by "udev sees it properly", as
above, all the tests I thought of look OK.

It is uABI at this point that real userspace software relies on, so we
can't change the sysfs paths. If there is a more right way to code it
then let me know I can have a go - Kees also recently found some bad
stuff here I hope to get to soon.

Jason
