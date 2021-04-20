Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CFE1436626D
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Apr 2021 01:18:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234381AbhDTXTJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Apr 2021 19:19:09 -0400
Received: from mail-bn8nam12on2059.outbound.protection.outlook.com ([40.107.237.59]:19425
        "EHLO NAM12-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233964AbhDTXTG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Apr 2021 19:19:06 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hA90E/E3CjVmkSVDi0IGHmq7Pm3ft/535TAuuS7x5auJAahxkFixWiEN+RaMCbsJCidLCwBlpQHUqemMNn1VIAWJxBos6xvPN4DGyCgWHvWZGn7IjPd21J7NONBsEfzZqM6Cd8DtsLqKyBd2t1xCpC4UryxbnZGEgeyeEHdpmxDPWN8+pxNZB0oPLBr2pkrsIDhn2lbNFqQ4yuL6pxoBHzW8vyg6j68sqlWchiE39u/XlrdsGo/DEJDYWeOc4GCpOruaHa1ffxh/2x0IMEagQhUqlCJnJkRbHJ39PJo5HnU8qtLw55ldZ6rm+iMxA6wlzUyQb/Kc0gH9thPsRQj4IA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zFwTuCgk6W2ycCiH3+0t1hGsbEm4qYurCuMHIUiPFfM=;
 b=kNS/JrPT7WEPDO6NxIhnj0nAnG92XFuFw+vJF+Kl8RpsgZH23UOCFdoP5/cq+I8jO2TJu6siioE/pSV7Tg4xRZ4bVaPUfNkg9sOrGiZo+L9b2Jz43O2H7oeyF5RXZTac3auCJS4GRPB0iGK7hg2Ynfkwv3DMNV8IuhUDqeOYJ+8c9/t9NRZGmeoP63drtBnjekMYzNr0uyiBia3+IgD+YJcT7ozBZWDh6YgAjRjoLJX2ZYPCMPo25MvR5+3kADWeLXPOQD5bpYcDPIze7+ZgccgxGIUYffEm1qUUdDpc9IFOa8aiSSDyc0Xk9Ga270s2p3Ad0fjECHaj+BXPLGN+qA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zFwTuCgk6W2ycCiH3+0t1hGsbEm4qYurCuMHIUiPFfM=;
 b=j10Wk19e/qsQgxkVgTp3S25m0Srr76ztLLfscFzrjm7+IOy0U8SbXM6MjrUVSx6JY/nIZ/RDIPeCtSsIcv/f4Imhizmp7mRxYzMrj6FMWpzK4nDrvoEb2TqO3f1w6EYa0iM0B/48ogrGxqRqdZS1adKvD/RTHQj0GO5kn0oT0mZfY4yKRhheavuY86+66ngTsMsGWN68KqdBNiR9JhKW9i83UcClCjv2c9CyLSe6jhFyfj4tBzlq1qZPwfG+jCB8JiROX7m3ZXsYcicxEOdhlXtGn4C4E72w/9VcW41Tho4byOtfyFB8G8B5SXxYzuapZ6HtJTWw9CSFcATuDu4IaA==
Authentication-Results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM6PR12MB3402.namprd12.prod.outlook.com (2603:10b6:5:3b::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4042.24; Tue, 20 Apr
 2021 23:18:32 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1c62:7fa3:617b:ab87]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1c62:7fa3:617b:ab87%6]) with mapi id 15.20.4042.024; Tue, 20 Apr 2021
 23:18:32 +0000
Date:   Tue, 20 Apr 2021 20:18:30 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Alex Williamson <alex.williamson@redhat.com>
Cc:     liulongfang <liulongfang@huawei.com>, cohuck@redhat.com,
        linux-kernel@vger.kernel.org, linuxarm@openeuler.org
Subject: Re: [RFC PATCH 2/3] vfio/hisilicon: register the driver to vfio
Message-ID: <20210420231830.GD1370958@nvidia.com>
References: <1618284983-55581-1-git-send-email-liulongfang@huawei.com>
 <1618284983-55581-3-git-send-email-liulongfang@huawei.com>
 <20210415220137.GA1672608@nvidia.com>
 <10d53c5d-e6d5-a165-84b2-eaf8a3b7dcce@huawei.com>
 <20210419123314.GT1370958@nvidia.com>
 <00c4fa43-21fa-a48b-b95d-a2310ffab725@huawei.com>
 <20210420125957.GA1370958@nvidia.com>
 <20210420160457.6b91850a@x1.home.shazbot.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210420160457.6b91850a@x1.home.shazbot.org>
X-Originating-IP: [142.162.115.133]
X-ClientProxiedBy: BL1PR13CA0183.namprd13.prod.outlook.com
 (2603:10b6:208:2be::8) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (142.162.115.133) by BL1PR13CA0183.namprd13.prod.outlook.com (2603:10b6:208:2be::8) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.6 via Frontend Transport; Tue, 20 Apr 2021 23:18:32 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1lYzdW-009HTe-Ut; Tue, 20 Apr 2021 20:18:30 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e553d706-df6c-484a-97c9-08d904529d34
X-MS-TrafficTypeDiagnostic: DM6PR12MB3402:
X-Microsoft-Antispam-PRVS: <DM6PR12MB34027F29FC3A7BD87946CFC2C2489@DM6PR12MB3402.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: iv8ZNwj15NGBau7vjIQXV8wvx1U5Ly2XeBfEulgyPg+/tO9mns3ld4/tX8owhj8Tj7wvuyQFME6LaxSC/einWyz5ZBiFjIAr7TTF7KmswzzWZ1wkGM5a7NGXU7D8FxjoilQo0or6zqMstE4IRQoLzveJa8snb17fRKQv5LoylxhsFpa3EOzv+ogU/ROu2EiBMyWPiANd5LaaOL1g5RVlpMtEoda2eA1QLhFPi6yQzXymvnMDN17fbXAReQPWDTucrb+4LyA8mqX673uQXvTklvu9228nBAs0hTMxKWeZDDcRG/wAzNkSrQiDUl+QPslEyEtnSl9/2f/8QLGkOgyYXyKgxecg9aN5a3e7ZEiXPnsCrd+UFBZs+r6qaDi9FR32aabrvTF+8BLh9m9MQPjjKbfKYWVoMAjhoNY/mjCCjf2wu75whX17mA1Oz5Bw2m4QxJ18wLVqJl2yfr1BHJffsQ7sVvT1eJkpbMM0dbiVg78DFxfliH0DOamLiBlq8cQHFMYNR3TeiZb1UW6LPSjzYuR0pFr8o35zMBBfHibH8MffySPfgVOFtpEFPap0H62hgJcGmg7Z080ojItrpRBicXdCjo5TCFqXyxeQnk+8wss=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3834.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(366004)(346002)(39860400002)(396003)(376002)(86362001)(8676002)(5660300002)(426003)(38100700002)(478600001)(316002)(66476007)(66556008)(6916009)(33656002)(66946007)(83380400001)(36756003)(9746002)(26005)(9786002)(186003)(1076003)(4326008)(8936002)(2906002)(2616005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?eIv39XSXaKZJucdYCEs8tlDKLPmcJYzOkxIODRcM2FjP08WiWUDE7SdccOIM?=
 =?us-ascii?Q?pfirUMv6bWi2GQvlduB+pRHeI0LZ0Z8cW0Jr7gEKxZw2L8859p+YfKiS/waC?=
 =?us-ascii?Q?KvMUIEO8/oQroh3cpH6XDIY6lvRv8ciQBB3iCeNIj7CfM1o8nkKC+2fIbDKS?=
 =?us-ascii?Q?JxvtdVjgtXuRGpMjsnEkhOgHOxE+dZiG+QKAXPSe2dGfCeN+iLSburU8wkNy?=
 =?us-ascii?Q?rHaC41QbmNR4uNZbtV9dP2X9XBm0NhiVZQPMFPwcYl1xfL9/eI6yzptOo8Iv?=
 =?us-ascii?Q?53RJvabl1yYIegQLEUkGwASETB+qClJdzMiv9EOllOhnJj6ZeEXGji+2dNTb?=
 =?us-ascii?Q?hlIzZRdTberD/r+DI3jz+ENbqLlW1epGE86Gg3w41umqeZ/fmTG6AERUi0Jx?=
 =?us-ascii?Q?LESDEO4fDyB/TPzshQzrGYqTC8jDnAGxZPPTyo/VeaA9JV84aPQSjh6b78ac?=
 =?us-ascii?Q?X9eK9hbRpoVJnkB2Z8l/3S8Km/MOzHxqiy/9O6yNgISElEgr8EE8vNr0FHVJ?=
 =?us-ascii?Q?ZXmbV2h/yv4IRVq5lkn9cqDlmms3WOScltm9q/tPvp1Kv2kCFA6pNFnyOFtq?=
 =?us-ascii?Q?N6Nzhk4ZjG3vfLa00VZev6QJ5BWPiaJhzGMKpMwd1kPjdNLstFCtOqq/XWTh?=
 =?us-ascii?Q?jSI1tE0gZPtISCQFFShwqwFQyJFOwNkM8lnPMrROH3c7W2d7FYLRq96HGZ8j?=
 =?us-ascii?Q?MOFhTv1Yx3b6gwRo93Wt84WLuCwFQibljRBS7Xv1ukYpZda6nVw+eJeUw3+x?=
 =?us-ascii?Q?jhUCvNZXcIgrySWyw1AYBhFjkuI0OldaMFEimy8pADMlLz6GLe4E3Jw+/AjX?=
 =?us-ascii?Q?+4FlNR4yh8Ji9cpmsOpmlLXj/Y8MCmi4jnLbOjkMHw+sYT/2DlrwO32tTP0d?=
 =?us-ascii?Q?6+u3fLWCPAV73W4IXt8Yt0nL0DPapAwY3GCJtaUWp7TTVsfIJR07Jfd9WiqT?=
 =?us-ascii?Q?58SrRBokrHXkUsxWHZPCaMXW9VkbOu8Sg42dwcD5XvkooAvImRqnu9kX7XSJ?=
 =?us-ascii?Q?ffuQvDhaWlIpHedBrWaSS9YphKT26kfhyKJNa247tIsqzzQUahGf2UrR+S29?=
 =?us-ascii?Q?0e+s7PvtNQstiKMyNxCVt4OBMI6dvwJ2zkr4q6aeoejzE6EQUfARTG+fqN3q?=
 =?us-ascii?Q?MhsTonID7SZQPKIDZ7ae2mDSEqQdHYAzmCUuGWFlhoVnKcdlu3Li3Y9fb+W8?=
 =?us-ascii?Q?0+lqqjaUx6iBHR1RLw2jWVRBQWy2hkBIpnHtvsMVgpzN42D+QiaAQ6dT3oR7?=
 =?us-ascii?Q?YJSkmPL6s43MjItIc1chMBf2CaopCy+xSN6mC0lqDaPFpxwu7M0yYMo5yN/d?=
 =?us-ascii?Q?CYE1txUsaN8CTucghC9jwtJc?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e553d706-df6c-484a-97c9-08d904529d34
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3834.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Apr 2021 23:18:32.4652
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EbX9vXermgIgsAjqV8zFeVF2t3HuXDpgNvEpDnQihTsKV7e5PAb6IUeUgOxVOhHc
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3402
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 20, 2021 at 04:04:57PM -0600, Alex Williamson wrote:

> > The migration control registers must be on a different VF from the VF
> > being plugged into a guest and the two VFs have to be in different
> > IOMMU groups to ensure they are isolated from each other.
> 
> I think that's a solution, I don't know if it's the only solution.

Maybe, but that approach does offer DMA access for the migration. For
instance to implement something that needs a lot of data like
migrating a complicated device state, or dirty page tracking or
whatver.

This driver seems very simple - it has only 17 state elements - and
doesn't use DMA.

I can't quite tell, but does this pass the hypervisor BAR into the
guest anyhow? That would certainly be an adquate statement that it is
safe, assuming someone did a good security analysis.

> ways and it's not very interesting.  If the user can manipulate device
> state in order to trigger an exploit of the host-side kernel driver,
> that's obviously more of a problem.

Well, for instance, we have an implementation of
(VFIO_DEVICE_STATE_SAVING | VFIO_DEVICE_STATE_RUNNING) which means the
guest CPUs are still running and a hostile guest can be manipulating
the device.

But this driver is running code, like vf_qm_state_pre_save() in this
state. Looks very suspicious.

One quick attack I can imagine is to use the guest CPU to DOS the
migration and permanently block it, eg by causing qm_mb() or other
looping functions to fail.

There may be worse things possible, it is a bit hard to tell just from
the code.

.. also drivers should not be open coding ARM assembly as in
qm_mb_write()

.. and also, code can not randomly call pci_get_drvdata() on a struct
device it isn't attached to haven't verified the right driver is
bound, or locked correctly.

> manipulate the BAR size to expose only the operational portion of MMIO
> to the VM and use the remainder to support migration itself.  I'm
> afraid that just like mdev, the vfio migration uAPI is going to be used
> as an excuse to create kernel drivers simply to be able to make use of
> that uAPI.

I thought that is the general direction people had agreed on during
the IDXD mdev discussion?

People want the IOCTLs from VFIO to be the single API to program all
the VMMs to and to not implement user space drivers..

This actually seems like a great candidate for a userspace driver.

I would like to know we are still settled on this direction as the
mlx5 drivers we are working on also have some complicated option to be
user space only.

Jason
