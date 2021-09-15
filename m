Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA81240CA1B
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Sep 2021 18:29:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229758AbhIOQbI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Sep 2021 12:31:08 -0400
Received: from mail-mw2nam12on2041.outbound.protection.outlook.com ([40.107.244.41]:47968
        "EHLO NAM12-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229652AbhIOQbH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Sep 2021 12:31:07 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hlvDGfe4ylnwsMkqGqYLckxzOJYBGth5/3RF8qmBRwmrteXonIKQmrp+KLjN0ulVGPM9Sz5CqNKESOrAEahzMD/xMOlvDfjuLRerQMs0C7QdHh/WgQeKZ5AkEdrLE2/9SpZ4ZJl7kOayFbVsoGsR06iWXTttT1xDz6OJ+dSmvqaL+LQKC8kx94cWUZxXcHbOhZo1z+JUM9V4LjpfULYAUScxh1Mt9/BfHA4fR62eda8FwIL5QkIfbd2L86ac/9909DZoVw+d+IocFk6fjp4rJzUJ9eOQAaKJpwBuwdmy++0gfCnwiagybhlhdK797YkPlIxL3G4wVrcixhaNAzcnCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=e6u2WVQNOEsTCkRCzVjwvzNrs2oTsNXa+J7fZtcPEgc=;
 b=M0lOjxM+2nbZx7yBZ3b7nU+PS/gMpACq+nHVKsSoZEXSnfdLPsfvqMSvFT63h45fBPLZrFoEByMeBowQsKVY/o70Z3f3/y9inHSNFNTxrT5auT269rUAKg9TV3XSiyhx33PJJ2cJPZwcfozggIla3yBlQFMY2a8SbXxWBwhK4nXNu6jvfxe36CR788n1kUx32BWTalINMFmvKz2T4+pGzZocG07PZ8oDFl5osgwmAe7ahbNVyWBcSDWDjh1bRYZJv8vGqMfyPASIjNRmcc9adVz0k9gseHtzww7ctlWrTsl9A8sS6ZM74FJ6rgCIUB63GJs1ROlBVm3HvNlvCxanZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e6u2WVQNOEsTCkRCzVjwvzNrs2oTsNXa+J7fZtcPEgc=;
 b=VYYCgwUW5qvxJ3AqbgNDe8aNYcJDxgz42UTcgEyR65xoozhqvK3MetDA2qpEFkNGCQhfr3PdhcbICN4b1SOurzwiJyuYSkeT2kdvh50Lu3RxuG46e2UG7kl4LTcz4b8jyJm87yNa0v6Bp8Syrbpdy3ZmpZNF8w7kpvrW2gT5ByBzv0ePHEq1LzhbhJycU39V5ULPfKwAffRlhDWEByXSFrDMc6f/BR4QhOMDOO3UF/5xvRPtbZEuQ1PVP7CjLx+Cuea9iWNTxdeejjGuJ2SnSvq+9SXlf2wZL4SFlJZufBY5fYzF23LYGoEJxI1EWY6KDYtldkvy39Nc8cm/L4SHrQ==
Authentication-Results: oracle.com; dkim=none (message not signed)
 header.d=none;oracle.com; dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB5506.namprd12.prod.outlook.com (2603:10b6:208:1cb::22)
 by BL1PR12MB5158.namprd12.prod.outlook.com (2603:10b6:208:31c::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.14; Wed, 15 Sep
 2021 16:29:46 +0000
Received: from BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::e8af:232:915e:2f95]) by BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::e8af:232:915e:2f95%8]) with mapi id 15.20.4523.014; Wed, 15 Sep 2021
 16:29:46 +0000
Date:   Wed, 15 Sep 2021 13:29:44 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     kbuild@lists.01.org, lkp@intel.com, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: Re: [jgunthorpe:vfio_ccw 7/12] drivers/vfio/mdev/mdev_core.c:319
 mdev_device_create() warn: variable dereferenced before check 'drv' (see
 line 272)
Message-ID: <20210915162944.GM4065468@nvidia.com>
References: <202109150907.zXy9cIVX-lkp@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202109150907.zXy9cIVX-lkp@intel.com>
X-ClientProxiedBy: CH2PR20CA0012.namprd20.prod.outlook.com
 (2603:10b6:610:58::22) To BL0PR12MB5506.namprd12.prod.outlook.com
 (2603:10b6:208:1cb::22)
MIME-Version: 1.0
Received: from mlx.ziepe.ca (206.223.160.26) by CH2PR20CA0012.namprd20.prod.outlook.com (2603:10b6:610:58::22) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.14 via Frontend Transport; Wed, 15 Sep 2021 16:29:46 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1mQXn6-0013HX-9h; Wed, 15 Sep 2021 13:29:44 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: eaa69732-1b58-4004-261f-08d9786607c8
X-MS-TrafficTypeDiagnostic: BL1PR12MB5158:
X-Microsoft-Antispam-PRVS: <BL1PR12MB51586E76FA41B9C1855E349BC2DB9@BL1PR12MB5158.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:250;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zfq+KC1bj8289zZMwXDcf42KHDIoYh/39tRjSjsAV0YQpeQZ200whmdaeatW5Y8X2NPxB/vZ1xycgjhE1v9NGUwTAuUi0tYQnUwaI0mrP77M2+YF5xG9xXM6Kl7tVAT2abkZT+KeDZOVbTK303gf/RP1G6C3eQAnZQVQy9s9FRLPBmIG2S817J1SQY3GwUa3AqkHSr9UwL5aKufE7Y/WJCfqLuWn22v4VZ2go0m9ZQXLZaV+hTrWChSR5QwKhtOC4Hti0ZucoqDFe3hYjm2VHeGpH8spp4zE1/1O8rWaq8kBB4jLyKeJrgjnPfeZlrZ+Ml4zPGnnuXvvzy7kYHqTrt1CGhKXkJZwVWjuOolBLy6lG68X8ZcQ9+BLARBB6jZOPlFhFV9MsbM9vsgLtQMvLhD6iNML+z/aWvDVCgNfeBQv7OVisT2NLdOeWuvZIEIIJyASwyV8L5S35UXECPQ5kBOuuzLfZ5htKa3q9nd/IQy1EzrnEcrKkQIlKhh/lcANekmjpw+An8xVbkrEknjSjbHBfua8ZV+/sdudu89uKKv0dpSyW0Lza0uFMhSv9kB1KuNIqZq8krRctwNMhmfbrzLmUoVUB9DQcfdqTKNFZI6oU717EA+7SJcc2NHHwVWGd2qzQmz6Yl/WNPHbYNBTtJTWNssGrFL+xPmPpQJxGR+6KCQUu6h1TaYZ6RljqT6wPrHCZttbFCsTtaMDenR19wxDHELaoX8bt6oqLmwwKzw=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB5506.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(39860400002)(346002)(366004)(136003)(396003)(316002)(66946007)(66556008)(8936002)(66476007)(966005)(1076003)(38100700002)(2906002)(33656002)(426003)(2616005)(8676002)(4001150100001)(36756003)(186003)(9786002)(83380400001)(9746002)(5660300002)(26005)(4326008)(6916009)(478600001)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?LjFzRCe/kr5RQtqDK/KgGpZspSGxF5n0C3RR0SZsZb/EzG9Ff5KFdg9rD9C0?=
 =?us-ascii?Q?R7atsgTKqEh66M3ZXJ7b37ceK1mQ0qc/1iewu1cTq9WqjMV8vmcPw00EHXRk?=
 =?us-ascii?Q?KovZJP/qzLLkksghIv1t1AME+Flydjd/crUVaeZykvDd5cii+L1tTc79b8sE?=
 =?us-ascii?Q?7arAPE3Ffg5IrVeeZc2XpTOh94tVVhwrJSBwP3pC0G2y/5PECySFLUrf2s2g?=
 =?us-ascii?Q?t+sex+gB94dOE7y18pqsSQPkIOGpYPLrItdCOiPS1HJbfbHvFRcTirZ4P5+T?=
 =?us-ascii?Q?KhxVEleG1kyJH+GT8gmA7uarDVtMscSuBdRtrI/AM55rBcH0hHG/c6ph8H1M?=
 =?us-ascii?Q?8IutzrT6AZGtYl9VnKfKeBxqNPcwEL3VndabydpT976SbNg9HBe/LlyY9gy6?=
 =?us-ascii?Q?Ze6hSH/zI54Io7OJ1i4eRaD9HdyxkZZPqnN8ziGpqWdPEvH/QzlHbq+qtx9r?=
 =?us-ascii?Q?zCHCR3sttAlG+hN8ta0NRtraLu3hPvL6d/TFx1m5YyqT+eaB6HMq5g1Q6BMT?=
 =?us-ascii?Q?eqNWx0JeANajzIHZpjGtGvhS1gAx/qE7Kob6g2fEL737ITRwiDlqjej0WTjN?=
 =?us-ascii?Q?WYtwYitBwBlKXo2EfXdhaBzH7eQ4wa/2NdL3GU+p+Es7H3fMc7XWdsbmsaxo?=
 =?us-ascii?Q?9Rypr7WYUZvPqNMaPeZetvIibJKKUX8D0ZUChaD1+ombKSpR5DTkeEsNoKUL?=
 =?us-ascii?Q?Ahycs5+Yq6B6hgAlsfyZvavATB02jzzcrfNSVqZKI7TkQ02fyf1aPXUIn4BT?=
 =?us-ascii?Q?ppmVg22sHsZyH+8+3YOqfufJV4gwQCh6hjHD1FPf92Qf8+VT2TIKG7Hs5VER?=
 =?us-ascii?Q?DW7H8rb8dqWVSA2YFihsgfahkFqsXUvWTX2wA9SIjKmsF+VW9XhuYtRNLI0G?=
 =?us-ascii?Q?jdI+6AsoRsGRRAL2d51IxnUhrZ1gQy/Jj0ItjDDqfvjomwcMV7vAbpl4Hg6g?=
 =?us-ascii?Q?l+/KwbASi9i0iYGvS8crueNcxd+lKoKh6H93UjMQQvjurilhcZXQs1wroq8g?=
 =?us-ascii?Q?QzH691xuybruYHENyhxQm9Z0zv9TEqoIlEMk6H4TCP9exTnowC21LwHGnzhs?=
 =?us-ascii?Q?0h0n90la4nGgev6wvTyOKaAxUZCKl1DRmaS3IlWs8UD7Ax5/PiCPx7puitVD?=
 =?us-ascii?Q?gTqpGnCjd0aOiW6uTyXcuAkVcyHYe9UnPRUjABLGFkYYtlKruXrhmq3gzikv?=
 =?us-ascii?Q?Dt/XNRLDQMntZHhI/jg2K7x387hGF4Ail174gHAKncb9fR2AwAVK/h71eXzB?=
 =?us-ascii?Q?eR55tCBPP963ypgFMh5q0GnOJg0552yTeDkm3KPXSOgyAPV4QR5m8HCvxM6l?=
 =?us-ascii?Q?8HTJC7ku2CRJcv5r2g1+jKyO?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eaa69732-1b58-4004-261f-08d9786607c8
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB5506.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2021 16:29:46.4938
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hyOnliNVexEPRqhWs/o/0Q4FkzOJisovjzkKrSS8jtgYhh+SNI/foqdUkrtI3mMb
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5158
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 15, 2021 at 10:58:31AM +0300, Dan Carpenter wrote:
> tree:   https://github.com/jgunthorpe/linux vfio_ccw
> head:   d0d01fdc87368c19ee6cac8e7ab2c0ef7ab33efb
> commit: c7863bcc74538df3d39bd9407ae77f6ef778f7b3 [7/12] vfio/mdev: Add mdev available instance checking to the core
> config: x86_64-randconfig-m001-20210914 (attached as .config)
> compiler: gcc-9 (Debian 9.3.0-22) 9.3.0
> 
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
> Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
> 
> smatch warnings:
> drivers/vfio/mdev/mdev_core.c:319 mdev_device_create() warn: variable dereferenced before check 'drv' (see line 272)
> 
> vim +/drv +319 drivers/vfio/mdev/mdev_core.c
> 
> 417fd5bf242d76 Jason Gunthorpe 2021-04-06  255  int mdev_device_create(struct mdev_type *type, const guid_t *uuid)
> 7b96953bc640b6 Kirti Wankhede  2016-11-17  256  {
> 7b96953bc640b6 Kirti Wankhede  2016-11-17  257  	int ret;
> 002fe996f67f4f Alex Williamson 2018-05-15  258  	struct mdev_device *mdev, *tmp;
> a9f8111d0b5f44 Jason Gunthorpe 2021-04-06  259  	struct mdev_parent *parent = type->parent;
> 88a21f265ce50a Jason Gunthorpe 2021-06-17  260  	struct mdev_driver *drv = parent->ops->device_driver;
> 7b96953bc640b6 Kirti Wankhede  2016-11-17  261  
> 002fe996f67f4f Alex Williamson 2018-05-15  262  	mutex_lock(&mdev_list_lock);
> 7b96953bc640b6 Kirti Wankhede  2016-11-17  263  
> 7b96953bc640b6 Kirti Wankhede  2016-11-17  264  	/* Check for duplicate */
> 002fe996f67f4f Alex Williamson 2018-05-15  265  	list_for_each_entry(tmp, &mdev_list, next) {
> 278bca7f318e6a Andy Shevchenko 2019-01-10  266  		if (guid_equal(&tmp->uuid, uuid)) {
> 002fe996f67f4f Alex Williamson 2018-05-15  267  			mutex_unlock(&mdev_list_lock);
> fbd0e2b0c3d0b2 Jason Gunthorpe 2021-04-06  268  			return -EEXIST;
> 002fe996f67f4f Alex Williamson 2018-05-15  269  		}
> 7b96953bc640b6 Kirti Wankhede  2016-11-17  270  	}
> 7b96953bc640b6 Kirti Wankhede  2016-11-17  271  
> c7863bcc74538d Jason Gunthorpe 2021-09-07 @272  	if (drv->get_available) {
>                                                             ^^^^^^^^^^^^^^^^^^
> Dereference

woops, got it, thanks Dan

Jason
