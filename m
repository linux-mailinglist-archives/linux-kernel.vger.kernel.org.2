Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 249D8361472
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Apr 2021 00:01:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236418AbhDOWCF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Apr 2021 18:02:05 -0400
Received: from mail-co1nam11on2040.outbound.protection.outlook.com ([40.107.220.40]:6777
        "EHLO NAM11-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S234777AbhDOWCD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Apr 2021 18:02:03 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GfQd/doCwe40Wfj3H8cDFDL8RTsoAAKs6cuX8rGoPdK2kTigSmgowWD0rFzhFX1vWPYuhTSCzVbUKgYBUqsK1q7vwA8jCj1YSbDajFK1RfPMD4bTXIE/jKs5seDerytwwaKZ7flhfYS4nVBx2rell1qoqw6G4jd6/Mc2Q6H6lZYs4k9tX0qVMUVGkOWvsJBUhNAoxSvQgc5FStcdqO5AadN5G26/X1LJK0V9Rmi9P/TeglK7AAgqvaIghRXDDSpWoQqWP+LsGHdk7HQlST2Py4E2NxBVmQgfgk8qmMOSK9/7Wvw3biHdlh4k8TVALedkkroCuAUaKSNluckge7e8+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c5R+U3bXL8zlVO+ZUhriF7tT3/G3OULQkOG9ZTh0WSA=;
 b=MXFW6tS3SfU6Pzv75sQX1EyjL/aHPBdcvKUDMpVdWakH2leH9+us36eSTMIjyqXApDP/oY+GoKrbZ+rmZmA5ZxGwGCsDA6mg6NB8ISJTJAzxXz1ihd1JpPTsA5IDaGLAxPn8kxYmevzgfOAqsHQuMHAX7GBqj5nMqghotxbxbpDY0VxYnHl/pl9PtZ0L6+2tU84DPNTxSXfi3x/JvZtnIzRX5PVG2dAyj72/KYtKPhsX8+k+BLpcGCjVw+DC0SfprJVafKiNwP6ggoRTOsWr6tFNbAcDDP1Yk710mAWNSEsB3Ymzt7jsPeogaOfO68M5P1KI6bw2wq4Ts1SqRCVVDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c5R+U3bXL8zlVO+ZUhriF7tT3/G3OULQkOG9ZTh0WSA=;
 b=POTWMNp6NX0rEQZp18zY8a+yUQh9ltSCHk+Qm6PVIKhrbe1gPt/OR0dNLUk+/b3035tfu0R/nU7KNOFr7UL1J7h/7+iRmC6jObZ9g3YPVTQUFRzA+UeFC/FR+qUlvJXplRKe7GiRa+eyw26bo6Rxt5W2R7eKMsE1P2+ZyWmNDIkwYA43UNnhiOW1fhUrZIZKq1ZSZAK70x2m+G8j++3N1Tfj/Snokv2GIIRFm046romLwwBZUvt1cuM/Lqro2zvi6MKvDaQQC0GsrIPAdGHZKQ65OkwaZa1hqGxXK45BfxhiPdN9oCqOa/HuRzdfNNlD9/CWhgI6NsK7402fcoowtg==
Authentication-Results: huawei.com; dkim=none (message not signed)
 header.d=none;huawei.com; dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM6PR12MB4451.namprd12.prod.outlook.com (2603:10b6:5:2ab::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4042.16; Thu, 15 Apr
 2021 22:01:39 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1c62:7fa3:617b:ab87]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1c62:7fa3:617b:ab87%6]) with mapi id 15.20.4020.024; Thu, 15 Apr 2021
 22:01:39 +0000
Date:   Thu, 15 Apr 2021 19:01:37 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Longfang Liu <liulongfang@huawei.com>
Cc:     alex.williamson@redhat.com, cohuck@redhat.com,
        linux-kernel@vger.kernel.org, linuxarm@openeuler.org
Subject: Re: [RFC PATCH 2/3] vfio/hisilicon: register the driver to vfio
Message-ID: <20210415220137.GA1672608@nvidia.com>
References: <1618284983-55581-1-git-send-email-liulongfang@huawei.com>
 <1618284983-55581-3-git-send-email-liulongfang@huawei.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1618284983-55581-3-git-send-email-liulongfang@huawei.com>
X-Originating-IP: [142.162.115.133]
X-ClientProxiedBy: MN2PR01CA0020.prod.exchangelabs.com (2603:10b6:208:10c::33)
 To DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (142.162.115.133) by MN2PR01CA0020.prod.exchangelabs.com (2603:10b6:208:10c::33) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4042.16 via Frontend Transport; Thu, 15 Apr 2021 22:01:38 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1lXA3N-0071Lc-Fi; Thu, 15 Apr 2021 19:01:37 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 452f88b8-4d91-44fb-73df-08d9005a0b4e
X-MS-TrafficTypeDiagnostic: DM6PR12MB4451:
X-Microsoft-Antispam-PRVS: <DM6PR12MB44515E6C06AAA8D79D7DF236C24D9@DM6PR12MB4451.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2887;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fPNN0rIJQ4oGrnGNya38y8CIuRiwDitTzMPImoaY1h5huG7fjktHZphTHJSkeqklt/0JmCRR0UCyXfMKTAi3iq6HtC7ytTnQuNUu14ikt6MveC0t/aCdkw/FghxFQ2QXKxUbEzSYhLgaIKOwWZFqvEkYIUq38kC05wjyIx50pUjgPo7ICxxgbM7Z3QmOzMwQUNR6lLDmDNi++Nm0HQFPXcAnGFFVVdIrCcnNaMl9GMUGNqwBxtQafhPMuNbFOtW6V5szOgFbRheCmn8gRfIYMFX4ypwhIzPExa/3ZiKF+uOEZp8g+pwpEzl+VbINACmH+XKnLVpFdU4A+O40szPzDW3HVMNOCv36c/JTKFkMWi/eWyuIRrbTaXnI1QsNn1g5Dgu2kJkg+B7XqNWfH6dPk5HPAf9cbcOWezVUEaDOla/J7m5eHQULWO0MIwHYO87G/VqIFaOVYqJBvt9/2TBBRF0xc2hqEXaexSF+d3bDTWS2H+6yrgFsDktdyGEsNz/ngzUwan0H3OlRTs0UjuLw1ubuhV2bGGt/shIxG59jQ+lkWJggOxR8Vd2s0iPj1dpZYWSCTFvzmjbpE/CRzSlYnxlJWGPOLf8wJj7Z8u9IOas=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3834.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(376002)(396003)(39860400002)(136003)(366004)(426003)(1076003)(33656002)(6916009)(66556008)(5660300002)(66946007)(86362001)(36756003)(478600001)(2616005)(66476007)(2906002)(26005)(8936002)(83380400001)(38100700002)(4326008)(9786002)(316002)(186003)(9746002)(8676002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?MoOAAA8D4D77CfS3XkooLM4J9Sh38ppW9ID3e3wDSqo2iv8dgiTM8tzzAgfJ?=
 =?us-ascii?Q?aoazjKs1s6OV7D+T90HLEaz7FztuB1UaVOmd1SJY0Hy4I7UbRsRLnyq0VP97?=
 =?us-ascii?Q?3D7EH3MIDKV3hlQZLaGwyfuIACRsIcS1FSE5AlreQXtGz5yRO5w+z4A36Kma?=
 =?us-ascii?Q?vI/8htoo95IR1tdzToFohrZqQKi8UmysSrGqpDpvFnXSWZuw6/3zAiORL8zA?=
 =?us-ascii?Q?7EGMjpId8cVq/apzD6Il7euZn5RXNu3I6Q45MCUMPwC0OkyA7/McZkIb6b9U?=
 =?us-ascii?Q?oa69TsmstGkgDaCmV0w7LxLH6mtSvXpWt6pJKRHvfGEvNJRtUV5/0cTJqSgc?=
 =?us-ascii?Q?BCmvtyT6dcSn9oUHufzCTHTV24yat0NdFOslI5+XaO/toNpdoNLgsQim5ikT?=
 =?us-ascii?Q?MVNTJmy+sGpHD0kN0xq7BRc8vOq/00yVlODe3pozVJ67jZGtdAPIVPpEV8kq?=
 =?us-ascii?Q?wqrTXbDSMJgUqRzR//SYoEllCqJkdRKU3PgpirC9i2/PTi0inEsnn9/xXei5?=
 =?us-ascii?Q?wUNiO4TvdE8I4MVC9os7SlsDO5a05xA4bJuV4vHydD3gdTf/Qy+KIbRi+P5g?=
 =?us-ascii?Q?Q5iBCnbfZOyQIN9IGpcAJESgPfhLFaXLFqunPczNRCCiZ4LZ03Aq1gu3D1Hy?=
 =?us-ascii?Q?q9+TDu7+BHMBce1sGkKRTTBis52kf/5KR4kLcxGcbALH7APlzhNFaiNKb1xo?=
 =?us-ascii?Q?ZRUSs12yfOb855adchAgdpiXutjSmVVX3FJsmvBM+SwxJDNRbk8ERyILtbis?=
 =?us-ascii?Q?T4rs3/AJAVCBMfAMwYzfA3gXuQ44Oqy4/os/Tin14TmHwWCQAmVzhEnhp+rt?=
 =?us-ascii?Q?EIi36enZy8TIjU5dF23ndK1/0/JRT3XNU/6gSVFXt9Ur8CKCTPwcMhiSV+l0?=
 =?us-ascii?Q?C7J8oEvBl/0+rKhcI/b5k9W+C8VmOSucnuWeaV6etCb7XN2CL9WCCWpqmChM?=
 =?us-ascii?Q?qQphVMryfp0t+4tn3L+OeVTEVB9eIpwk5m9EDkG21oCLajFoYiQdOuym5xjJ?=
 =?us-ascii?Q?0M+n15+fchCr4NTz3iYWQ+pCrf2dG9DJU1JwcDIGhnqfD13lJRuVyaXAiJtO?=
 =?us-ascii?Q?YCToOZi+NeplDGeiqSoTFPe5xCJnOWZTNcqpM4CAkM2SJNB2EaNRBYpc18II?=
 =?us-ascii?Q?3RC+Jx8rRlcXs5fAlyNzly3OKMZDACDJdJQkdo0NUlOAhMI2PZSDxCCCyzuW?=
 =?us-ascii?Q?p7fnTkUm3bhCuBptaGLj7dhZw7upY11SeSUt3qP6dAS91OLY0shXABwD9y4W?=
 =?us-ascii?Q?1wnlvCgu0O5Yet5Z3mTn3zuAM786CRSQnxt9weXpeF5U6Vm9pemAc9KwGwgM?=
 =?us-ascii?Q?CrDSiHigLYssoeMVfbjKMjWW?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 452f88b8-4d91-44fb-73df-08d9005a0b4e
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3834.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Apr 2021 22:01:38.9111
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uSL04nA+5BbSeZNuNOFFkM/WJURZY1ppgjpwpunLEZgSxeJz21pw77GMC5OEy0iv
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4451
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 13, 2021 at 11:36:22AM +0800, Longfang Liu wrote:
> Register the live migration driver of the accelerator module to vfio
> 
> Signed-off-by: Longfang Liu <liulongfang@huawei.com>
>  drivers/vfio/pci/vfio_pci.c         | 11 +++++++++++
>  drivers/vfio/pci/vfio_pci_private.h |  9 +++++++++
>  2 files changed, 20 insertions(+)
> 
> diff --git a/drivers/vfio/pci/vfio_pci.c b/drivers/vfio/pci/vfio_pci.c
> index 65e7e6b..e1b0e37 100644
> +++ b/drivers/vfio/pci/vfio_pci.c
> @@ -407,6 +407,17 @@ static int vfio_pci_enable(struct vfio_pci_device *vdev)
>  		}
>  	}
>  
> +	if (pdev->vendor == PCI_VENDOR_ID_HUAWEI &&
> +	    IS_ENABLED(CONFIG_VFIO_PCI_HISI_MIGRATION)) {
> +		ret = vfio_pci_hisilicon_acc_init(vdev);

This is exactly what we want to avoid with the work we are doing on
the vfio-pci modularity.

It is a complete mess to just keep adding more stuff here, and as
we've discussed to death really ugly to have such a ridiculously wide
ID match.

You should be working with us on that project and base your work on
top of Max's series.. Alex given the interest here I think we should
find some way forward while we work on completed version of the mlx5
pci vfio driver..

I'm also confused how this works securely at all, as a general rule a
VFIO PCI driver cannot access the MMIO memory of the function it is
planning to assign to the guest. There is a lot of danger that the
guest could access that MMIO space one way or another.

Here I see the driver obtaining a devm_ioremap() of the same pdev it
is going to assign (and I really wonder why pci_release_mem_regions()
exists at all..)

This is why the mlx5 RFC was showing how to juggle two PCI devices via
the aux device connector.

Jason
