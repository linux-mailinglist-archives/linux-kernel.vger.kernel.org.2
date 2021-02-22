Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 70E723219CB
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Feb 2021 15:10:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231131AbhBVOIj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Feb 2021 09:08:39 -0500
Received: from hqnvemgate26.nvidia.com ([216.228.121.65]:5216 "EHLO
        hqnvemgate26.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231332AbhBVN1U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Feb 2021 08:27:20 -0500
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate26.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B6033b1080000>; Mon, 22 Feb 2021 05:26:32 -0800
Received: from HQMAIL109.nvidia.com (172.20.187.15) by HQMAIL109.nvidia.com
 (172.20.187.15) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Mon, 22 Feb
 2021 13:26:26 +0000
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (104.47.56.40) by
 HQMAIL109.nvidia.com (172.20.187.15) with Microsoft SMTP Server (TLS) id
 15.0.1497.2 via Frontend Transport; Mon, 22 Feb 2021 13:26:26 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VbQvwfxYfI7YLxXNxMdqo5I4KMwMZlpqBtMflkNSzvQlSRox8AzCzWWYtA1szHK3BReMDXRgDNRmTtsREm2D2H5KO0gR+pMX0tExEWEUPzY4aaywew1H5GoRa9G/GZvzdnCiSwZpAXJLn+84pPhL9WRKpA/5hUFamHVQ1Yz2KP24PFaivIuQgCgp1aQTuJG8Kc7sgNHup6KwE7ZYWaC9IL4xAnUhUe0N4QnXxy1vkk70RkNPpx8Kwkwm0yCNqWudz3QAz5xpXZlHVtQU6P04lpf12pcI4p+4ozX0zHSR14QQqAK+0F08Ts0IjETtzp7kU75ZlO5g9ltpZMwVxFA29A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gKVNIA5SF9NJvdc3VvrRpfn/Q2rekyOJcd7uM+hu6As=;
 b=g/Qh17IYrSdqfpyYBrvVMOhWiNh+exkqqO84Xao9oq5bk8dCtY9QtvWNkxvsQ2a7D02WKP6shhqY9a48LAw1GPAtG98w22SQcX2LqT0aDi9cj/cjOgqEm+natSUUARamac5R0MSIOYOGFHFcbNpxB37+718vvNGIkHKFabJKY+EraSV63YyTCQK3A6Kdj5LItzJ7hF9zI4mSMiFXMITKiL3bMkEoRerE2iHl0hLatXkwjeLU12wGLZF5zKEVWmmTmKUwgRLa+9U4IMXKbWbftzvEzKwpc79+2l4xJLNgfJKdfcLm1y+QxL4mG8R8V9k3Nc71nguDZBP8QBvqlI2GLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM6PR12MB4250.namprd12.prod.outlook.com (2603:10b6:5:21a::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3868.32; Mon, 22 Feb
 2021 13:26:26 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::d6b:736:fa28:5e4]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::d6b:736:fa28:5e4%7]) with mapi id 15.20.3846.045; Mon, 22 Feb 2021
 13:26:26 +0000
Date:   Mon, 22 Feb 2021 09:26:24 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     kernel test robot <oliver.sang@intel.com>
CC:     Bob Pearson <rpearsonhpe@gmail.com>,
        Bob Pearson <rpearson@hpe.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        <lkp@lists.01.org>, <lkp@intel.com>
Subject: Re: [RDMA/rxe]  899aba891c:
 WARNING:at_drivers/infiniband/sw/rxe/rxe_comp.c:#rxe_completer[rdma_rxe]
Message-ID: <20210222132624.GH4247@nvidia.com>
References: <20210216125413.GD24557@xsang-OptiPlex-9020>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20210216125413.GD24557@xsang-OptiPlex-9020>
X-ClientProxiedBy: MN2PR15CA0002.namprd15.prod.outlook.com
 (2603:10b6:208:1b4::15) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (142.162.115.133) by MN2PR15CA0002.namprd15.prod.outlook.com (2603:10b6:208:1b4::15) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3868.27 via Frontend Transport; Mon, 22 Feb 2021 13:26:25 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1lEBEG-00ECbJ-SN; Mon, 22 Feb 2021 09:26:24 -0400
X-Header: ProcessedBy-CMR-outbound
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1614000392; bh=gKVNIA5SF9NJvdc3VvrRpfn/Q2rekyOJcd7uM+hu6As=;
        h=ARC-Seal:ARC-Message-Signature:ARC-Authentication-Results:Date:
         From:To:CC:Subject:Message-ID:References:Content-Type:
         Content-Disposition:In-Reply-To:X-ClientProxiedBy:MIME-Version:
         X-MS-Exchange-MessageSentRepresentingType:X-Header;
        b=AqJF03xsz9C9L7A/vzyXytImk8huwLBENDrW+nAhXHcnIqrCnLzoOxuMeZD6frc2w
         GdtaghqlazUd6CuEAaXfYye3HLJfyAtCsfhxfRENTMKP7jiynhyv5UJqEKkbcgrTw+
         UirNEXkwDs4UijeXn2HxEwM8L54L+fY3elt7ELhqxpMqNFjU+7kjifAJQrhn64DI1U
         S5cRIJbxozmFnafSaV2s8VbKM7hUy1GBqPjaHzDx1dNZaXcwkMVvthjlgH1sBe02+4
         dWCO0DH8hdrmeShLrKSy78w+QiWXJ2N0tgVQkQiBfZxD2so7jHamAzH3iTP3qR05OW
         bZHKX5vbv4xJw==
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 16, 2021 at 08:54:13PM +0800, kernel test robot wrote:
> 
> Greeting,
> 
> FYI, we noticed the following commit (built with gcc-9):
> 
> commit: 899aba891cab1555c9ca16a558769efb177baf44 ("RDMA/rxe: Fix FIXME in rxe_udp_encap_recv()")
> https://git.kernel.org/cgit/linux/kernel/git/next/linux-next.git master
> 
> 
> in testcase: blktests
> version: blktests-x86_64-a210761-1_20210124
> with following parameters:
> 
> 	test: srp-group-00
> 	ucode: 0xe2

Bob?

Jason
