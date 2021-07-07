Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C6583BE7AC
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jul 2021 14:15:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231464AbhGGMSc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jul 2021 08:18:32 -0400
Received: from mail-dm6nam10on2050.outbound.protection.outlook.com ([40.107.93.50]:40288
        "EHLO NAM10-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231358AbhGGMSb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jul 2021 08:18:31 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mUsf+Kv8CCblDi4rBDRDwQitR5WlYl1vt0fwlSfGCRQGRmqJHr97DXPofzYPEDP00K12MCbr/L4kQ7ksudPFl5dIXqDN0RMh00ETZmwcT3L1Oc0HbXFn8Y6qqnpqL+Q/YYqMYHzSFzG+kBnUaKWA/vWN7DmIoBAvtaYUrzR6/mD1lYjs9BWZHVIIIBm8GOYK++Y6e98HW9a5C5ih1va6KSEQngk8LrmnygVIVXTWmJbkOQWeZN8uKBwXFIUqIJlWel8FpLoMYPhAqGM5MbgrrY1KT5y86SbxtbcH8kx67VZFas1tQeklLSkAxp6+lrOenfZcWOaRyKHn7HD7SR9+4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BalVX45RZRrVN6z7FSUNZ8WUAX+JBZQrLyJ9vqDzksM=;
 b=jloIfwlP49c5W2muhjNzQsDQCIXLPGJVeHt0QQV05N4DD3XhnMBT7bQm1PA/dVtXvBe90CXGSho8rDA6qB3Tmdvy9RVuKlWpsLZUmVjrD7xWxcmKLAEbbrhFxYnukuT/ytkDW5DLjV78jXRW4XldZXjeQFbw6Y2tEQ4v0Z+EtcU8EtuvD+qAb0CCkrSy7d6VnmnpGUPVVcvabC3WsEipvKmx1NKf0Ni7pO88aq+7NIYo3w9YpRCrAlYvoULtx3vR6xziF1sukWmwvtRTQeSedWRV+jgWnIucFG4U36uWheYq6nPWe3r5cn82P7TYgW6DKwf5fgS8pq4OzLLZERjAFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BalVX45RZRrVN6z7FSUNZ8WUAX+JBZQrLyJ9vqDzksM=;
 b=KG7uGjfdJOvu5zcMxPL11u55Sky3sTYw1OGnv1OfIYwDZqlIjP4KjlGGBVSRavGQAbXGtCOynHUDWHHpafLW94e0WRyJP2m+8mh1CtBjRaGqeVxWuypuFWh5qvjzR5vZXtk95Q0M6BGGDemA/lk8NQh1PbEApB6Y3EHi8v9/SxOXCPE0aUbsZ6FSZBc8Z0PqgnzBlmaM9ZAFvcogO1fTZdPveos6Dwb7eJP+2JVilbSKujXw7XL/5HeLzusxKKG/zruInwWp0oDrM4wT/uYKVtaopxcheMlogrcuuA67ucbsZRUV/9TXorcwGvbh5JOxIYg6HDPKNrjljEsOTiJ7Iw==
Authentication-Results: linutronix.de; dkim=none (message not signed)
 header.d=none;linutronix.de; dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB5506.namprd12.prod.outlook.com (2603:10b6:208:1cb::22)
 by BL1PR12MB5335.namprd12.prod.outlook.com (2603:10b6:208:317::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4308.20; Wed, 7 Jul
 2021 12:15:49 +0000
Received: from BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::d017:af2f:7049:5482]) by BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::d017:af2f:7049:5482%4]) with mapi id 15.20.4308.021; Wed, 7 Jul 2021
 12:15:49 +0000
Date:   Wed, 7 Jul 2021 09:15:48 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     "Dey, Megha" <megha.dey@intel.com>, linux-kernel@vger.kernel.org,
        "Raj, Ashok" <ashok.raj@intel.com>,
        "Jiang, Dave" <dave.jiang@intel.com>,
        "Tian, Kevin" <kevin.tian@intel.com>,
        "Pan, Jacob jun" <jacob.jun.pan@intel.com>,
        "Liu, Yi L" <yi.l.liu@intel.com>,
        "Kumar, Sanjay K" <sanjay.k.kumar@intel.com>,
        "Van De Ven, Arjan" <arjan.van.de.ven@intel.com>,
        "Williams, Dan J" <dan.j.williams@intel.com>,
        "Shankar, Ravi V" <ravi.v.shankar@intel.com>
Subject: Re: Programming PASID in IMS entries
Message-ID: <20210707121548.GA4459@nvidia.com>
References: <bd509e3d-f59d-1200-44ce-93cf9132bd8c@intel.com>
 <87k0m2qzgz.ffs@nanos.tec.linutronix.de>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87k0m2qzgz.ffs@nanos.tec.linutronix.de>
X-ClientProxiedBy: CH0PR04CA0106.namprd04.prod.outlook.com
 (2603:10b6:610:75::21) To BL0PR12MB5506.namprd12.prod.outlook.com
 (2603:10b6:208:1cb::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (206.223.160.26) by CH0PR04CA0106.namprd04.prod.outlook.com (2603:10b6:610:75::21) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4308.20 via Frontend Transport; Wed, 7 Jul 2021 12:15:49 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1m16Sy-005UDL-1d; Wed, 07 Jul 2021 09:15:48 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3900d539-2ab7-4c89-c95b-08d94140f4ea
X-MS-TrafficTypeDiagnostic: BL1PR12MB5335:
X-Microsoft-Antispam-PRVS: <BL1PR12MB53352C29A6C9F48400154F7EC21A9@BL1PR12MB5335.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: oj8+klKOd0DxAmAc29/QPmdZcqkjbkt1bSHEKqRWqk4jlNKSZo8ibqgiNbujz7wHFSLIGtGW3gHzdaX0YwhwKNl0kIaSbU5nSb7Cn7aQtuGjbUWrwyQX8hsSCW5pM1GL6RFcRR2UzwKU/Iz0edzUsrxuwblb8Z0GyJJjfkXPkxxHtdQvO0Hg3iQRoq7zBA7xAb6H//j3AWPYxnLkLzm1aH9/3bVWlZMzr/aR42rgAPfDakftUHoxSjvxDcKdDJhMbuuwnPG/mRFrs8uU7A0r+W2e3X9Y1JSwNRXLOkm77yYOzoiWNFzLRMJ45r65jHKfntDY+bA21ln3cnm4T7LEbyB+riPfEDxk9hq80wkTa5X92I5ePFVZVA1XmN57cMV6uKZbGUTZ2OI3nJwOTHMsatI8vmjC12Goixs2WNF47NhMGBwUfICO3mVv4PbCwItwXbwum/RtcBD9GdqRkkmUAIKr/HQBtpohHsldYT4ASfcm3z68zVsDmr165ddnnnz0SMDAsi0ztdUONrR0IZpLyuX+DvKiF6zvmNg4VlShC5wgk8GI5C7TlKyKNR85VE9ib88sZUQfxouCrGsAwsIt0/BFNFcKaHmYybVTat3crrZQCb9mHBrSPRAqsQP1eS5Jr+KxqPnKtLUayCxGPKIiSA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB5506.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(366004)(396003)(136003)(376002)(346002)(66946007)(38100700002)(8936002)(66556008)(26005)(66476007)(2616005)(7416002)(6916009)(426003)(186003)(5660300002)(83380400001)(33656002)(8676002)(478600001)(316002)(9786002)(9746002)(4326008)(2906002)(86362001)(1076003)(54906003)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Dtz0FE6xRA90H68SpbUeFwfpsldnyy+u5YkaTScphUd7uEWnBFJ7Y6DyvRY0?=
 =?us-ascii?Q?brLCihbOoY6d7V+/N5keaHutM62mcEm8FXLmejvmLqfwj1gsL0f9fGeAclJu?=
 =?us-ascii?Q?OOe4OSV51pMrkj5r6P9UFG5sWJ03M4XDUg9w+2AIJQMfYTKBQdLk6B95gmG0?=
 =?us-ascii?Q?xRPzQRG7sADZewuJuan6Kr3FYuPKFWQEpIv6QqkRbCoVCIz/8dm//uIRre3O?=
 =?us-ascii?Q?VXQnrkk6egUK8WnF4MJ3vCusE9ZEwCVEvypQWoOcq0RhlJEYg6WBtTIu4hda?=
 =?us-ascii?Q?w37MjfgnWr7L+hqDS7dflhGI65FgCpRlkvBIsTUGx4nr+xCRYm5mIZfIly3O?=
 =?us-ascii?Q?tMXk2fNDnpEcoT9rQ26HBnBMc9vAhqPKPAnL1JDDQDQ8Sc0EDvv+t4zop8OZ?=
 =?us-ascii?Q?0HzMHCEl11aDuow0VNUo3sOntNTwYPQJ6hm/0MdcvgUdM1oq4DDpZjAbBni1?=
 =?us-ascii?Q?dfFTNQw0DkaGJRL8x9iMrBPtMraHc5vYErO92arSVWBSXsN5t8zyaFnrePpk?=
 =?us-ascii?Q?0Mso8sKgdG4Q5qN7uU/7nsJCm8VHUqTq0DwBF14cC65Ijt5m+MhrlZPhf6AK?=
 =?us-ascii?Q?dH0D/IB+J2LNgueQKymHU4d1lzsdsavXdxNy1Li4TzUY/t2VNZ0X0vrQOH33?=
 =?us-ascii?Q?LvpVQd6g6uBF73FpFmHPqVWbNzebfy7sWd4+TE5iloHCvhpZ62PzWqHG0Ayb?=
 =?us-ascii?Q?BtFRasHRY1ka84BSZXabSRbAj9jnXCWbZPyg00boaPZ7mgzTLrJcj8/jykKY?=
 =?us-ascii?Q?Q8cRXfXRTGispHIPK1lUIvmav6AW6/3N/IOTgP3W625EXgkNFZ53ll4evI8H?=
 =?us-ascii?Q?1AyOSnjsH96a+no186DDwPg+oANq2u794FvgRuaAwTMIzSA32FqkTdl1Si/g?=
 =?us-ascii?Q?eVoY2h7Twr08FAux0p/xiJhZIfMleVu4lYsSCiXd4DZ48pTvOumLeLyPMivl?=
 =?us-ascii?Q?n4yF1jEyJv7Iv2JyfALE+RYGegu2GILN28fERt/8D2VQaLyea8Gimb7g3vTi?=
 =?us-ascii?Q?i1A1W5qGPYgo2WjwshjK2J2DZOeVdy02n3lkWXQFzjokrAbdiRu6fNT+Vj7I?=
 =?us-ascii?Q?d6/wwoz3eWBjzCWjGT8KDqB49QrDZWRrPlFIfrhfc4PehtsgODwKRZFkOwLv?=
 =?us-ascii?Q?mlHsA4QPl54fLr4Zg77KxcV0FEOmVWdn4DscIEHZ9TyAqEcjDudocFdnFUqk?=
 =?us-ascii?Q?ULxUm6DhUEuN7eDtuX2zRTvHeve7Jd/8eKIxt+QEmaG0MabPMlQKz/UnabqU?=
 =?us-ascii?Q?MBeBFdXJAp1v1LTayDbTM3yMmyqOkqpuVRyT1PHOj+OrvVVPueW2jEuNPSFF?=
 =?us-ascii?Q?c30bDnq2ZUs0fi8jf8toie/L?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3900d539-2ab7-4c89-c95b-08d94140f4ea
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB5506.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2021 12:15:49.6338
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UZ0Jyny1kEjDJxouCvdMp2objt5LbF5RCiqjo6OUciZre77nQvFzYC2tG1ciLcEo
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5335
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 07, 2021 at 10:50:52AM +0200, Thomas Gleixner wrote:
> Megha,
> 
> On Wed, Jul 07 2021 at 09:49, Megha Dey wrote:
> > Per your suggestions during the last meeting, we wanted to confirm the 
> > sequence to program the PASID into the IMS entries:
> >
> > 1. Add a PASID member to struct msi_desc (Add as part of a union. Other 
> > source-id's such as Jason's vm-id can be added to it)
> 
> Yes. Though we also discussed storing the default PASID in struct device
> to begin with which is then copied to the msi_desc entries during
> allocation.

This seems like a pretty good idea, though it requires that the
device's IRQ code cast the struct device to some driver specific
subtype, like mdev in this case.

> > 2. Create an API which device drivers can call, to program the PASID 
> > (PASID provided by the driver) on a per-irq basis. This API is to be 
> > called after msi_domain_alloc_irqs and will write to the corresponding 
> > msi_desc->pasid entry. (Assumption: For now, all devices will have the 
> > same IMS format). for e.g:
> >
> > msi_desc_set_pasid (irq, pasid) {
> >
> > struct msi_desc *desc = irq_get_msi_desc(irq);
> >
> > desc->pasid = pasid;
> >
> > }
> 
> That interface should be opaque probably with an u64 argument so it can
> be reused for Jason's VM-id. Jason?

Well, I certainly wouldn't put any IDXD specific words like PASID in
the general API. The comingling of PASID with the rest of the IRQ
registers is entirely a device specific choice.

Most likely something like mlx5 is going to want to associate a
pointer with the irq, and I believe it could use a struct device just
fine.

Jason
