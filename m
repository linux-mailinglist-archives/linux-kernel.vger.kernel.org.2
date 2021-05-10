Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E3C15379AD5
	for <lists+linux-kernel@lfdr.de>; Tue, 11 May 2021 01:37:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230080AbhEJXi6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 May 2021 19:38:58 -0400
Received: from mail-mw2nam10on2065.outbound.protection.outlook.com ([40.107.94.65]:28225
        "EHLO NAM10-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229807AbhEJXi5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 May 2021 19:38:57 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IDDHNixxmbJ3eayt/xo1JSY74DmOj8Gn6bOfSPkFGgSm2c17gNxwqk51yw/GH9+v2Hye3uyfTvhkDPliGoaVHg/UQta5l3E4+v2MpdGZ+Ef4ce49un5gLv45C5NbKtu8S6TB1TJHnHXE37AJp/L4nPFNuZ7sXN4pniz3sRmJdWN+VyLMqcFxGJNyhkQmD5et9FQUDaMh5jCz1qgUhlezFAXyAETyxJDfDwZcrSksBVmnUGjJn2CnsK95ktFe53HAX5AQWKawY3i42xgtsdNmP1bRaCSIZUkiT9Qdl4CBFhOo0QQrc/2/l00IcL96BNkbFSxZOaWFENI2wbzzlw/2zw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cblVwsImx1hzRvOTWzY1SXFxUniUag82fEnedoc0nXk=;
 b=jRBSfF13pldtSTQ89Ha+nIFwt8hHWkIvOhp7ENrrrSM4xOUc+jPubij08gP8KSuQqK7c0j9a4PUpRFCnh96CtuxqrbukDOIAVnvfD/3l7mgX+cXpvdMeacqUginEIKhYAtVEqUgS5zzQo+Wb4MXVm4axrXtALJjTcPdZBfxQfBu5Pu/8TWV6EAEOn38ueyVKa07SPZ/9KiUulIOj5DGxuLD9MVqDK1KWAfXktxlD4y+lJCS4Jtp2AqLBgxIrEfr6VQtqIeg0ZQVOdFsVSRyUASD8J7Pr0PU/MUg9TqVuTyIo2otOvqyP6wx3Np6yp7F6iYMo9ciz0sajSQ5NDuNuKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cblVwsImx1hzRvOTWzY1SXFxUniUag82fEnedoc0nXk=;
 b=Crhy2vIsEqdeBOg3OcEUCsIaQp+ZzOge7IziiKU4wJzsGh05MoYNOlDDRC+t4V0ZFn3D5+KebkZQvLVVM5yxj+4XvfEp7nQCTwZTmaytUV2jiIX97NOv7BORojloLTQY+YtYvGkPRBk7WwVW4HdfI6qs561oyGqxvW1hChQsnJ2kJzh1kNeWgODSxdTbype3ZTFMyOHfJHwaz7tMGRd+f2Sb/kp8QaoUK87/1c0/47qrDJ5eE0eoOm95u7kfwnuJr7oH9GZ04BPtZ1Z3OPRYFohBKjSwLBQywP7XS/+tmAum/aNd4CIHLDBOWpBvkKc0nIL+U/NDo9Wg3EYxLmJaYg==
Authentication-Results: linux.intel.com; dkim=none (message not signed)
 header.d=none;linux.intel.com; dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM5PR12MB1435.namprd12.prod.outlook.com (2603:10b6:3:7a::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.26; Mon, 10 May
 2021 23:37:51 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::ddb4:2cbb:4589:f039]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::ddb4:2cbb:4589:f039%4]) with mapi id 15.20.4108.031; Mon, 10 May 2021
 23:37:51 +0000
Date:   Mon, 10 May 2021 20:37:49 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Jacob Pan <jacob.jun.pan@linux.intel.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        iommu@lists.linux-foundation.org, Joerg Roedel <joro@8bytes.org>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.com>,
        Christoph Hellwig <hch@infradead.org>,
        Yi Liu <yi.l.liu@intel.com>, Raj Ashok <ashok.raj@intel.com>,
        "Tian, Kevin" <kevin.tian@intel.com>,
        Dave Jiang <dave.jiang@intel.com>, wangzhou1@hisilicon.com,
        zhangfei.gao@linaro.org, vkoul@kernel.org
Subject: Re: [PATCH v4 1/2] iommu/sva: Tighten SVA bind API with explicit
 flags
Message-ID: <20210510233749.GG1002214@nvidia.com>
References: <1620653108-44901-1-git-send-email-jacob.jun.pan@linux.intel.com>
 <1620653108-44901-2-git-send-email-jacob.jun.pan@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1620653108-44901-2-git-send-email-jacob.jun.pan@linux.intel.com>
X-Originating-IP: [47.55.113.94]
X-ClientProxiedBy: MN2PR15CA0038.namprd15.prod.outlook.com
 (2603:10b6:208:237::7) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (47.55.113.94) by MN2PR15CA0038.namprd15.prod.outlook.com (2603:10b6:208:237::7) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.24 via Frontend Transport; Mon, 10 May 2021 23:37:50 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1lgFTB-004yge-0w; Mon, 10 May 2021 20:37:49 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9bde8ccb-029a-4d9f-7a9c-08d9140ca013
X-MS-TrafficTypeDiagnostic: DM5PR12MB1435:
X-Microsoft-Antispam-PRVS: <DM5PR12MB1435FD0257161490C18B32B9C2549@DM5PR12MB1435.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5236;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Ku8PCPPusA4/xW1QsD2GEgXFDfQeNNVEQ3VwLK4r18e92CY+W6tjtjmR5THP7G6beXBTMq+Aex8OENFiV6tFDj1elhPiA7VBf/KeaSMNE+Zav/tLg+UxurN5NDHGrzsSOOsW5HlCeAlJ3Pxkjn4bYhZ11ooJpgLbcScAxnJZZilMPiSw9i/7uadaohP000+xX4dS8jxVqrv8B5xduEWlG956WQ1Fs1JXMZD4zIzaNcX1XgnRomnqt2Cjy0czVfMKAQXAQwM5OGwmPHFCRv+AXe2KpM3F42f6Qru6jfX3eHmOXC4V25vOOaWjyyC2bY0yFb26USqQmBMmjaQR/9lJ8xTXjVcZ1WlniLW/V8chslWt5j3Rj1nyb+36DSWbPf9GzTxgk05NXOGQjSw0okaaHZavZMl0f8AEfooPTnS5nKtEsX+FFJ6doatjSnjAiR8WAdzNBs6Vp44RmLV6r5QnuHecwzKDPRDo+NYdxU8Q+y5G0VwQ6RZiPsIxfowpyZeiWS+h5wmoSMFpsfqwAbyO/nTyIn/JEPUM9owuKbjkvRWMg3ZFs51IXAGYDu5AubzYMzyqaJduPbSzuB1cuc1Z1TNu/kzx1ZyLGHsmKIdwMIk=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3834.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(136003)(366004)(376002)(39860400002)(346002)(8676002)(83380400001)(36756003)(316002)(478600001)(5660300002)(7416002)(2906002)(54906003)(8936002)(4744005)(86362001)(66556008)(66946007)(33656002)(426003)(4326008)(38100700002)(66476007)(9786002)(9746002)(26005)(186003)(6916009)(2616005)(1076003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?Y2ZxK3A2aGZPdzd3YU1KK1E5N2I5a0EzWnBHbjJLaktFWjJEMXJtSHlnOGht?=
 =?utf-8?B?SXZhMFo5ZXdreGxDbktCWC9GTXhQcTZjZ2Fvc0FtRkxZM2FVUmdmbld5R1lJ?=
 =?utf-8?B?YlpCbDh2YTRuaHg4VjJIa1B4bEVWakhOODFyR0NDYXM1OVVhV2t4QS9ob2dE?=
 =?utf-8?B?L1k4bGYraCtsSkJOYmhwZURybmZheFF6RFV3eExSZVR3Z3FkMDlCcThwTEJB?=
 =?utf-8?B?QzlGL0RUUEpUU3dtWHFCcUR1OTRETTdlbGtEZkxYNWRJMjBPTm53ZUZtUVJF?=
 =?utf-8?B?N004U0VQZGc0VWR3NDV0T2FiQ2x2TlNJVk01Q3d1enhFOHlKR3ZBQkhqbUtM?=
 =?utf-8?B?SnJFNmJUdW1xbG1lSDNud0p1VXZ5WnUrSEZqSVRCWmRtblgxak1FQlk2MS9Z?=
 =?utf-8?B?SDV5Z056c01BanYrRjF1aCtaN1pvRlVOVmQxOFlYbzlKZ2UyWnFBSGVtRVFv?=
 =?utf-8?B?RDNsNWNvZlIzRndHdEQwZTZYNFhPZS9uczV2d01TZytnRC94VHZVMDgwM05L?=
 =?utf-8?B?NlN2VnZTN2R2bDl1TnZMS0VSK3pHcnZzUUZOTlFSVXlTQWFkeDFiS1djRTQ1?=
 =?utf-8?B?MEd3WWZ2QTB6eVZiK1Q2ZEY1UjJNVFR5T0dTUWFpdTArUkN2RDZzQkFRUUUv?=
 =?utf-8?B?ZTRmYzc1RUhkVGlMTG5DMldYWHEzUmhnV0tBaFd3RzYzcHlKVjRxOStlN21T?=
 =?utf-8?B?cThtS3d2M2hhekJ2d3FnY2E4aGpzb3ljcG8veFBXSGp5dzUxVllFTlJ2NGl4?=
 =?utf-8?B?c1Jrc3JqL0lJdXpXUXk2QjVCTm1HcVZlOXRpU0VkOE04d3E0dzVOSWFzR0xH?=
 =?utf-8?B?eit5UHA5a25BQ2xxa1BVOXladEVHYTltMWNWRXIrQWowV1Mxc01rVXVjTE91?=
 =?utf-8?B?aXZZTEFVVGlDSFdOTnZId0xYc0c0SVdiYzVLRlF6TzJMT3FwbzVSZGplTjdY?=
 =?utf-8?B?WmJ1K0VmK2gwa1l0cHliVVI1V3RrL1BpVVVwQ1NjYkRSSjV4SGlPSzBnQmVp?=
 =?utf-8?B?MTVQOFJpVkRjRXBJWSsxQUMzUVNVVEdIeThyYUx2ZlJsQ1IybDA3bjFiaGNS?=
 =?utf-8?B?VXRhSHVHcHN5S24zLytJVFA2OTNUajFjYm5FTjdEc1hCYXRjemRYZ0s3WlhM?=
 =?utf-8?B?blBSLzdnMW5QRmxFdjI3czZPMGNIQjRJMGV6dWxSL1p3R1AxT2RmaEtDSEs0?=
 =?utf-8?B?R0d2OW5zd2twKzM2eEM0QkM0NHVFNktIankxOHpXbXYxcU9BWFB3V3BmTC84?=
 =?utf-8?B?RUFUQURoVVhxdzFrRjFKeXB3SE9UcnErT1k5NE9tMjhYeEVRc1QwcDA0SjlC?=
 =?utf-8?B?UmoyMGFkeXI5MEJqL1Q2aVB3ZDc0RzVNUDNvV3pORFRYcU53cGpHR0czRzgx?=
 =?utf-8?B?Nlpac3JzMHBVMEdybzFONUpGVWdpRDZwbDExM0FtY2oxRE1vQk1uZ2FycldS?=
 =?utf-8?B?bEVQbEpURzFZWnE1bFhnb2plbWNGQVFjYUF6eTg5eUFUYUZVc3FYQ29kaGZT?=
 =?utf-8?B?dDV1U3hMY2FyMFZsL0kyN21GZGlWY2xzbFZwZVRWS2o3MGwxdHNXRFNzczF4?=
 =?utf-8?B?dzhjSEQwUVJRMkdpcnQwWkREVER3a2xPTEt0OWdiTXQ0cEtWVjhjYno2UHZD?=
 =?utf-8?B?M05Ia2pxVnBTT2ZjK3ZDM0FjWWdRdmZGcmpDZm9xYW5TUHNEaU9RdlE2SGJ0?=
 =?utf-8?B?VnE4WFF5ajlCc3NJdmVVUFN4dEFEOFlMekV0SEJySUNPV1lkRHFXbWtJU3NN?=
 =?utf-8?Q?UYK3qPMhnHJDFz0PaAF5Z6/1xio7P1Lcp6QrXnC?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9bde8ccb-029a-4d9f-7a9c-08d9140ca013
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3834.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 May 2021 23:37:50.8309
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Zr8W75SAARW3PxM7deYfO4OCD3GyOi5Y8r2xoM3nwaY2Ei3gM8Ha/05Ht4Cot3IX
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1435
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 10, 2021 at 06:25:07AM -0700, Jacob Pan wrote:

> +/*
> + * The IOMMU_SVA_BIND_SUPERVISOR flag requests a PASID which can be used only
> + * for access to kernel addresses. No IOTLB flushes are automatically done
> + * for kernel mappings; it is valid only for access to the kernel's static
> + * 1:1 mapping of physical memory — not to vmalloc or even module mappings.
> + * A future API addition may permit the use of such ranges, by means of an
> + * explicit IOTLB flush call (akin to the DMA API's unmap method).
> + *
> + * It is unlikely that we will ever hook into flush_tlb_kernel_range() to
> + * do such IOTLB flushes automatically.
> + */
> +#define IOMMU_SVA_BIND_SUPERVISOR       BIT(0)

Huh? That isn't really SVA, can you call it something saner please?

Is it really a PASID that always has all of physical memory mapped
into it? Sounds dangerous. What is it for?

Jason
