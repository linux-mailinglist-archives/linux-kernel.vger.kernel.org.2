Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7DBE044C53E
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Nov 2021 17:43:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231441AbhKJQpr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Nov 2021 11:45:47 -0500
Received: from mail-bn7nam10on2088.outbound.protection.outlook.com ([40.107.92.88]:10721
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229995AbhKJQpq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Nov 2021 11:45:46 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=C0VcdD2p81tKg4epBZv/uXa+9MTPLBjBuUlltFN/EHLXYdRGThUyPOpa2b+oGN/ec6kglez+j76RJzHcS14BwFFqFyKEtuEI4DHANYMtxXBkLrXO0heiSIepMfHAiYUvUGrckz+7GzEhIt/tmkdGNlHbirYMwNcxzWKWq/UJjT7haI28S3PajaPJa0R4gCVzdyj5zh4Qr6m29BVt1CgWwaauzMGj4gacDUimwAO8Ts3+OJ8p7vqjbRNyosh51RaM2SAPUO0RL92Z/sXy/ECofx/c0CGTPZFRb44Mq8CnBzBp2X/tFMoI80qJd9FUV4kSiFY6ktjrheZNPUTkm78ABA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bLSH6xX9WwW//zFFJFHlnIXpCAzifd3UWeEPnPK5mvE=;
 b=CH6PF6IHZdTe8VpM5XNPZBTPJ9+TfQlnCI8XDwvDCrul1/15BDr0yfWu1CQdAUx4e2vtDbk64iE6/EIrx3ILVdzlmcYu9mimcMO7rXSK/QkyRt25VIMKZBu0fznfU2PJDn9Yn7hdu/9UgNrosm/ItbmvR3XpwfGqTx6rHSu2ZjhO0jiwPbvUFfciSQEs++hc41gu+S+vQdcTatyaDEP1lmaQ2VXterOr+AdoKc89pcj27eDiLQP/8PnLj1/JWmgiItKIBaT4ozUWHeRiDRhJpZ/zT6IYeMGxKnKpi8x+tcylJqnuNYQqSHkWyP9HGgnpjjimV8W3Vy1+6cRwz4WY2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bLSH6xX9WwW//zFFJFHlnIXpCAzifd3UWeEPnPK5mvE=;
 b=tW3QQGK6CT63QtfQL36O172yp2kjN6sE3qBq+WFrAscfLoC14QAucwdfZF38wzbvFuM0nrgNYQZz4T5E18z/BRCRfwhszTOXwMAGtfXIsSIMNyY7n4l7pEYYysDgITVLd+ZQtYgcP1pJLzPMLY6rvQ4g5FlONf14ghG9NE2ok82zOuCVxuImBAfPyDTTHf/Sa1w6kgRwNjF5fO9y+1Ugoxzb7c7WUCjsaOWfRo3LOs28fEQzhOC8rq3b/CWv9dGsww5ERI5L08eN9EOUgdGfMc54LIlWU7SKSmKM78IR+SPjl9zmYqSQs/L5eYsySr3tUEz9MqmyW62tUq4LJb8cWw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB5506.namprd12.prod.outlook.com (2603:10b6:208:1cb::22)
 by BL1PR12MB5364.namprd12.prod.outlook.com (2603:10b6:208:314::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4690.16; Wed, 10 Nov
 2021 16:42:57 +0000
Received: from BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::5897:83b2:a704:7909]) by BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::5897:83b2:a704:7909%7]) with mapi id 15.20.4669.016; Wed, 10 Nov 2021
 16:42:57 +0000
Date:   Wed, 10 Nov 2021 12:42:56 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     kernel test robot <lkp@intel.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Alex Williamson <alex.williamson@redhat.com>,
        Eric Auger <eric.auger@redhat.com>
Subject: Re: drivers/vfio/vfio.c:293: warning: expecting prototype for
 Container objects(). Prototype was for vfio_container_get() instead
Message-ID: <20211110164256.GY1740502@nvidia.com>
References: <202111102328.WDUm0Bl7-lkp@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202111102328.WDUm0Bl7-lkp@intel.com>
X-ClientProxiedBy: YT1PR01CA0065.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2e::34) To BL0PR12MB5506.namprd12.prod.outlook.com
 (2603:10b6:208:1cb::22)
MIME-Version: 1.0
Received: from mlx.ziepe.ca (206.223.160.26) by YT1PR01CA0065.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:2e::34) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4669.11 via Frontend Transport; Wed, 10 Nov 2021 16:42:57 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1mkqga-0086AO-2w; Wed, 10 Nov 2021 12:42:56 -0400
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 94244115-33f6-4df3-b782-08d9a4692699
X-MS-TrafficTypeDiagnostic: BL1PR12MB5364:
X-Microsoft-Antispam-PRVS: <BL1PR12MB5364053B344928FFD6A49892C2939@BL1PR12MB5364.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9Eo6zcveNMZ9YoWGeByVl8p5DoORj3kQjjZwdc2BCVSQOvRIfYrZfwrgrjtx5MeCNjsaoluTx9aMGujv/yDti8Ssw0AfpNUdeaZnEBqhQtQoLsZB1FjzUiJOxdNzv4dNtBCSxBYI4N8n8y2vU8sJ1ayVazv9NK8iqKE6hGqWa3JTr9wjprx4LH2CGF9Lq30Xf4lg3SNKb0OymshHCQSEtqXEnJQEH5fOBYhEV1axDrK8nN0xoBM9pnivwpIBwdjA1yjDqjFBiw1jV7r7KwzxHIwEqeriZi/DzA5hML4+T04iSuOm9QzDyrPe3Hu+pXpf47tll8DK+NBTVNm6zZPtvQiM6rzLJ/5bw6n0kXWE6edzaZz+aZQkFDYuTKh2ihD7sO7TxEXTjoG+yKzlIIXERwKydwJ9fH0b38/jJe134HwnmxxQQP5dk8q+cUemSBE94+JlFNMBbYn8fKj0D3CqRAx8uUlQeIiHFbIsI2RkJWpAulkALf2Xk4DUvL6bTo9wjsDa5nGPyRvSN9qy7kf+IcX/0loPG7KHnj6WL9/1dDO3yeWKNylv44wa3R+XOEYjZHJEDfveMe79t/VYEbdbw/08pJe0l5S+SwXA4NPM2bxPHZbL794meFT/xv/otGb5KgMCp7u3+hcROXk4nSeTgA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB5506.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(6916009)(86362001)(1076003)(26005)(426003)(9746002)(66946007)(8676002)(66556008)(9786002)(38100700002)(66476007)(83380400001)(36756003)(8936002)(5660300002)(4744005)(2906002)(186003)(33656002)(2616005)(4326008)(316002)(508600001)(54906003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?vZeTEsetxnCTJLGCF44AJoyjxmKrAsctiJkhh308pTYhocstJgRxta4Df0RG?=
 =?us-ascii?Q?kvylY4+DPiymJeT6N3iMLJxkoh98AR7j/llPy1I3/1tuNjd9ygcL0iat3eFq?=
 =?us-ascii?Q?dDAudgOW3LfLRU4dTO6HabbREjrRfFywS6PPU62yQGnkb5oqJ9PACXZyCGoS?=
 =?us-ascii?Q?jmqZt0xC1fZjgNQ9XfSytqznPH94ZDcfIOPAR7P4aUGJ9qNImuyqKx9SzzjU?=
 =?us-ascii?Q?6RKd8EIpxjOhc+WjvGZOzzhKe8MuhQWUQWV3FTrNELoTuWiPGIEBOQNp0A4U?=
 =?us-ascii?Q?2z7BbZrOZ67TVPYukIaBds/k8mdq6AyKVa1MfAzdOe+dWSHg2845vkRG+Kkj?=
 =?us-ascii?Q?PIwr/ErtnHLsznKqvYSDfq2t2JqcZE7ywIH4swQ6erwGKxXd22+/yfVvBNGg?=
 =?us-ascii?Q?3YsMej/hPINtQBUJD1gxkrvEnbzKxa1wSG6WND/IHYhVsCNGJm0DRNtWG0ac?=
 =?us-ascii?Q?qf9BfINBxIV29ZNwP8TpGlt0qlg3DR5tGY7IDSb5n/FiwtAj5y4Cjw+cL7sq?=
 =?us-ascii?Q?+aa9QrL2LUvM7w84SFSBsG7N4qxUnxEN/cJ/yCH1ZEsxkIrohZPWLYvEZXK/?=
 =?us-ascii?Q?9zc/DGoDTn3G8F3lUyxrMx3DtdtfzQxNRMiFoqRddgY5OcgGcxJkqOfB+zeR?=
 =?us-ascii?Q?7WixVgGQDLgziEoxgZ2Nu+LucuUKj7mlHQOSMJp6rjYXBzjGuViWqiJnGEUR?=
 =?us-ascii?Q?KxQi4h5Odmj/Ux2SXmakmPeOI4mCV2sNs4/DaYFEj02LnyBpVR5GyLa1KJNO?=
 =?us-ascii?Q?AGKKEPhbs83r+b/jlqWKMERbnLNBN6wNCNgH6joQpSxgaxduhK1SM9XzGcGf?=
 =?us-ascii?Q?2D5K6Q1rgMVrs9rBcGR6htX2XJ7NR101Kwr4ZNCdYzYHEhPlrqG9O0I5hyOC?=
 =?us-ascii?Q?yHwqDreJ03dx/IJjkgu/2EmFI376DhXAZPOWLFmd7seb34TF1jx7k7xUV8Bb?=
 =?us-ascii?Q?+2VejuGcVTX78ZNjC9Qh6CMLyYA/LQz1M6hWluIflInNay2BUEty7TAbvH0G?=
 =?us-ascii?Q?k5bwndyXigdw5B83HSsehSGSAaeXp1qqJq0+X1wZ426GUgvKzZoJK+MGActb?=
 =?us-ascii?Q?aKhaYWob5S3YFm1sMAaA4tvs7aKVDjeBQ1DENqIyn97jpNTPbRMtPxyaBNpF?=
 =?us-ascii?Q?fRr85ADjMuPtKC4j3sUBczYck081no+nmMaRMNBlozuR9Ww4PI5Q/9iIkdSR?=
 =?us-ascii?Q?urXjVls8gwsyYN/CHpfOsd6G93WOyRoaDGAfkQp/zFkhdJJ8Cwjsn5zGbEcS?=
 =?us-ascii?Q?+1DzBM9ET4FC+PxLAWt5I1BTeIRS53C1uF28/9bUc186xAxFbeu6TQyXcpce?=
 =?us-ascii?Q?2O7dVvdIw41UgY4jlO7IJ9Yso9RrQem6Woim5+LYw+KntkYtfd7IO2cQz7yw?=
 =?us-ascii?Q?ZcfsKGG1zo9+BscJb0CyaZmctzOJ3RifIQ2X4xMKtPLUeBcX9GJKtnD4+21a?=
 =?us-ascii?Q?bSccfSntdKYCu8SyCxdINP51LDls7Mwfz7ECLuKjx67EdvmrDCPRq2yzfumb?=
 =?us-ascii?Q?bflQw4LZmpYiILf3W0FZYY/HrkRzmLd+VuQM/VbWbN4TRG1hf6+teGjZYGOr?=
 =?us-ascii?Q?stCRVPRBiI27a/CMsLM=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 94244115-33f6-4df3-b782-08d9a4692699
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB5506.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2021 16:42:57.6780
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rEO7Liq7VogqtYKaGkpmV5axM99pYC69Q676PWU4hubI2c/HMbwu/Rt1tRRqyqko
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5364
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 10, 2021 at 11:12:39PM +0800, kernel test robot wrote:
> Hi Jason,
> 
> FYI, the error/warning still remains.

This is just a long standing kdoc misuse. 

vfio is not W=1 kdoc clean.

Until someone takes a project to fix this comprehensively there is not
much point in reporting new complaints related the existing mis-use..

Jason
