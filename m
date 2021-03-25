Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E285F3490A2
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Mar 2021 12:38:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231807AbhCYLgq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Mar 2021 07:36:46 -0400
Received: from mail-bn7nam10on2070.outbound.protection.outlook.com ([40.107.92.70]:40736
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230213AbhCYLa2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Mar 2021 07:30:28 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Gkb2QIPAHZ47Qy5z7ubNXZyDZcdbt9e/fB9YjDeV+7rHB4lcTgLG3xXL/LFiuANaV1Hsl9DynowCbn1x60C1YJKJsawIhvKRdlvpcl1P/Q8HSnHRHTUBQkST6x8Q8Db3h/KD0jyls/+Eapfb9n7/Mp2ZbGjlqmzuTNawS4BiQfS8ZCTMxGAsjVHzfIOQCMEr57QleTMkoyelsZW+BRbzoz/XdCjNhfmw5si+zj3eZXRDisoLXbVMplXq4JTEQfu2vJQhRFHHNOAztG//LAtfdmPNdWGI5rZK4wGtCoKS/KGDAqRJnPlsClvQmmH5y37dUEXf7N8f+ad0QJgPrveSGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v9xKUBao1hNAUyqmItUyabsMUHquzCGLrTYbNOd7mOE=;
 b=Sv0uTbK0GOm4xYAeO7geG+rE4hCAY4YGrN7rpTx6nWa++0+RmKw4jMCYFbqHS+6Ac0+3VRXeB/w5gqAGO1owHU6tmVZz+0KmJ05zBwstLQHieL70WYwGEUGWEIFfA5FLe9UO1bsQUkNM8N472IpukrYSoH9OeThmJ71dK3JJ9Gebah3V92/y9yHomHkV47E2kElkrPfQ0PwrFTH5Xr0at0rqDAYh2dGQ5oGER5Oy6Uhmztxqshw+xVZ5OzEWAVxfnGaGL/SS7YCNhbND8CWnFACRvWop2XoAnW3rezqY7CmcZNWUW0IrFVMn2tzCR9oHEGFpBJj6r6z+gPTEHX66PA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v9xKUBao1hNAUyqmItUyabsMUHquzCGLrTYbNOd7mOE=;
 b=oc4wDinH3YTzD0A24g/KQ7Dmmq/lXChkC1YocvyuPTPf/+7stFWtW2GShlyI+2oPzeOQZDdzTS0TR1/hOIFdzclE5MvoKA+mBSEpMLnoWjnYv8tHXr0YE7M0q7utP/vqdZ1q/Bwt4W8mdqCVba00Ad3krh3rPiEvpHU5VGadT//yw/paSyRFXgyKPndaDMAv3h7J7Ww6cT09U5R5WmTgrDc35EPCoFIm6PPVX5lELCAyUrhR+n+iAXk7LVFOZD0DB4YAB9Fw7Ako+x86mZjuqTopmqlbSBSP4tmvbibZO/JuxzYZ4z2aRWzyVQovLrjFUSgzJpQwJvgOC1msm5PRVA==
Authentication-Results: shipmail.org; dkim=none (message not signed)
 header.d=none;shipmail.org; dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM5PR12MB1753.namprd12.prod.outlook.com (2603:10b6:3:10d::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.26; Thu, 25 Mar
 2021 11:30:25 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1c62:7fa3:617b:ab87]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1c62:7fa3:617b:ab87%6]) with mapi id 15.20.3977.029; Thu, 25 Mar 2021
 11:30:25 +0000
Date:   Thu, 25 Mar 2021 08:30:23 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Thomas =?utf-8?B?SGVsbHN0csO2bSAoSW50ZWwp?= 
        <thomas_os@shipmail.org>
Cc:     Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>,
        David Airlie <airlied@linux.ie>, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [RFC PATCH 1/2] mm,drm/ttm: Block fast GUP to TTM huge pages
Message-ID: <20210325113023.GT2356281@nvidia.com>
References: <6c9acb90-8e91-d8af-7abd-e762d9a901aa@shipmail.org>
 <20210324134833.GE2356281@nvidia.com>
 <0b984f96-00fb-5410-bb16-02e12b2cc024@shipmail.org>
 <20210324163812.GJ2356281@nvidia.com>
 <08f19e80-d6cb-8858-0c5d-67d2e2723f72@amd.com>
 <730eb2ff-ba98-2393-6d42-61735e3c6b83@shipmail.org>
 <20210324231419.GR2356281@nvidia.com>
 <607ecbeb-e8a5-66e9-6fe2-9a8d22f12bc2@shipmail.org>
 <fb74efd9-55be-9a8d-95b0-6103e263aab8@amd.com>
 <15da5784-96ca-25e5-1485-3ce387ee6695@shipmail.org>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <15da5784-96ca-25e5-1485-3ce387ee6695@shipmail.org>
X-Originating-IP: [206.223.160.26]
X-ClientProxiedBy: YT1PR01CA0090.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2d::29) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (206.223.160.26) by YT1PR01CA0090.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:2d::29) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3955.24 via Frontend Transport; Thu, 25 Mar 2021 11:30:25 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1lPOBz-002UD2-SU; Thu, 25 Mar 2021 08:30:23 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e9775d30-4b3e-4dda-1384-08d8ef816260
X-MS-TrafficTypeDiagnostic: DM5PR12MB1753:
X-Microsoft-Antispam-PRVS: <DM5PR12MB1753C9559B04448BB6033C9CC2629@DM5PR12MB1753.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: O+QJ3UfsGyQSFec7PQgJUcCRzA7hEZBAp82alGrob56nM/3/3HAYFiwPiaklsgECsVbD6FRman4LHT3yUBuefQLeiNdb+7I/eB9ELKPttgU6qweWnZgcmGyJBgxRnu9IMSJPZ+SSs0F1QmgxQjFEQnk/EoKy8k5n0A/TZbU8Ybf0HCWlK40dPBQsO5M2iDXtfC8+P6zspL5APTMkkexBB6+OYO25JbJohtE8mCJUWcJhXwWa/gEwv7qoop1c0uWdVohCtwix8iAuyx8KZIXLhYC0Wfo5dQRSg7zVC9if6zezU3t1k8hRsQY5wbyPpauiGlFQkHBey09ZXRE/Td0tTg4GjwCRyoyycDSysJZCRwyV7AQ88b/JcG3tH+5dhWlxcljexI7SmUv/5PG31G8T6Dhl4531dydy+DsZp85aZjCfM/1E9ADG/wi6ekUVbqF3ZMzYnLE14uI2plpkaauvYMTgOx4Pm2FyhPMC1eVb0c1wiBmCOeQxdc6nmPCgMWr+Hr76JSU4s0Bwyh3RVI/rzRRpLeAqi+gY+C+QOdYltcfyN6rnoOy4mK8Czyv4K353bxQ+HMKLGheShg/J+0MwAT68eWsSz/dPE6G23TkjkNR/VtTw9ahXCK2vPJC1b2/Dlh//FEwSghR4fNKhRwRFCdU4qQZAR9C+VlDRCCCNxvUl2LSUZmKZ/us2ht2YzOiJ
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3834.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(136003)(346002)(366004)(39860400002)(376002)(186003)(6916009)(33656002)(26005)(38100700001)(54906003)(66946007)(316002)(66556008)(36756003)(4326008)(66574015)(83380400001)(66476007)(5660300002)(8676002)(8936002)(9786002)(478600001)(9746002)(2616005)(86362001)(2906002)(426003)(1076003)(14583001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?enIxZGszQ2dCN0VwTGFZUzRROFVwYU4xVkIwVXg2bUhHWnN0blJHWFgrTjV5?=
 =?utf-8?B?WktNeG9pdU5YdjBrUW1YdlhZM2lZenBHN0dPdDFQOWN3Rmw2Z3JwN3JoYy85?=
 =?utf-8?B?WHRwTit2SFVoQ3dOclNSY1hla0RDUVZPZTRlT0w3bW0xU0ZMSHpqcW9YUUlV?=
 =?utf-8?B?UGxNTXZoQkZlaTE5TGtxZjZpUTBCZStGQWticjhkMkVkQ0NSMkZsYmkrWnJr?=
 =?utf-8?B?VHhnQ1YzQThqRENESzhkZ0xucUhqeTZGRmpnb2ttUWJBY2ZkR0VCZURZdFp2?=
 =?utf-8?B?L1oxVkJVd2s0eWJNYzJiTU1DUzdPSlI2WXZaVVNQaVRjR0hLaFVkbDVPb1NB?=
 =?utf-8?B?bTVFMjlYQWtpaitJRzIvRTZrazJ2TkRZOXVLNHdmc3MrcE0vNEQvd2NNTUh5?=
 =?utf-8?B?NUZTd0ZSSlBuQ2M5SnFPM0owUURCNyttdFJlKy85a1d1R3NucUR2cm94L3E3?=
 =?utf-8?B?UWZoTTJhSHNIbkhmbzFoTXhMNlpGb1dNaXZLcVpyU3dGOUo3aXFrTDRkbi96?=
 =?utf-8?B?U0wvRmhqanltY1JXZHdLTnVRczBIaEhmSlhlbW1IbVNyZzlQd2Jsd1FqaE5H?=
 =?utf-8?B?YkxnVXQ1alVOa2VUb2V4dVkzNnNtRUx6enNHbEJxNlRXNjhiMFJJS0M5RXpp?=
 =?utf-8?B?ZE9YQ3RCT0NXcm9Tb3BQQUVEbld0QnQ3eEJlcjNXZUlzclM1UkFRcGFMcU5x?=
 =?utf-8?B?NjFIVDlUT21xRXE3bUVNNmtqa2hoN2JVRzVEU0swNzFjMGFCbDBTNktOMTFC?=
 =?utf-8?B?Q2JqRkdid2hNcE4yTHcvVE9nV0RkNU1qdzhWYkdzWVNuMUJ0bUFDd2VRWFN3?=
 =?utf-8?B?K0tZM3o1Z2t5bXgxQUV0ZFd5WGFhOWp0ZVQzSkpGL1NHZU95SUpzTWlOcWg4?=
 =?utf-8?B?M1B3dEdLLzVSbnQwWGZtOVMweFZ0anN5aWh5UWc5YUJtL1BUUEdVZ1dQVEcr?=
 =?utf-8?B?aysyUTV6MFlFMkF0YkRUczlJTzhpRXRIZEt5NzFQVHBWYTF1TmQ3WHhrUE9B?=
 =?utf-8?B?WTVYNUVOd2krMUo4ZzdPa094eC92Rm1qN1ZKako0eGh3aW9UMXpqMFljMXB4?=
 =?utf-8?B?aWpWZjhRN0NobDI4cEsxODJMUDg4Z1ZmWCtwTDZlRmhtaysvTHZUOFl1TjRn?=
 =?utf-8?B?N0E1QS80SC8zTkUrVFJ1WGFVK3JFL2FxWDZQWTE2a210a2hNZjR5VTArU2c5?=
 =?utf-8?B?RUVHSXNNYjdNakY2TXcwcVZJSW10cncyOXQzR21JUTRqRXg3NGRGd3owaWFO?=
 =?utf-8?B?M3FiSEc2aTBBdWZFUTR5NnV1czBIVTdNT2pOK2ZpMk1Sd0Q3dzFJeEM5Z0ZG?=
 =?utf-8?B?ZzB0T3hqcERlaFRYb2xsVW4yYXJMRC9XYXA2YzFpYld1L29URk8yWFhvcytR?=
 =?utf-8?B?cmllU204SitWMDd0RmdzcWpiSEw0YllXM2JMaHA5UHdkajRESUUvK1ZEYW9a?=
 =?utf-8?B?cjNVMG01dnFrRm5memU3SWVRbXpaY2NDT09WV3h2bys2Q0VkejBoTGNzY3ls?=
 =?utf-8?B?cXRUV2hFVUo5MGYwTWsxV0xoS08wYno5eHRuQjZjMDZKZTA3R1FWd29RVk9S?=
 =?utf-8?B?MEd6QXY1ZUptMGRraSt1K1NSWktIK2RReC9SU3EvcTJVVklqZTV3Z2lkbTFv?=
 =?utf-8?B?WFMyb1NBcUNJV2M5Y1N6RWZvQXlaT1lzM0F3TTRNY29jdmovK3NJcjYvYmpy?=
 =?utf-8?B?NGZ5eHNBT0pOanZ4TDlOSGplWE1hc0tTa3pJbHA5b1YyWVR3OWkzWWZSbTRO?=
 =?utf-8?Q?wRB1ut4VyAHH2jWiAPDXBz469e5I+CL792xKusN?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e9775d30-4b3e-4dda-1384-08d8ef816260
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3834.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Mar 2021 11:30:25.5207
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4Bhd5AMwKeYC/lHg/PjFxhdXzj2L6IE395NRxM0MhPOZTT0L6Y/IKMMShdluVugm
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1753
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 25, 2021 at 10:51:35AM +0100, Thomas Hellström (Intel) wrote:

> > Please explain that further. Why do we need the mmap lock to insert PMDs
> > but not when insert PTEs?
> 
> We don't. But once you've inserted a PMD directory you can't remove it
> unless you have the mmap lock (and probably also the i_mmap_lock in write
> mode). That for example means that if you have a VRAM region mapped with
> huge PMDs, and then it gets evicted, and you happen to read a byte from it
> when it's evicted and therefore populate the full region with PTEs pointing
> to system pages, you can't go back to huge PMDs again without a munmap() in
> between.

This is all basically magic to me still, but THP does this
transformation and I think what it does could work here too. We
probably wouldn't be able to upgrade while handling fault, but at the
same time, this should be quite rare as it would require the driver to
have supplied a small page for this VMA at some point.

> > Apart from that I still don't fully get why we need this in the first
> > place.
> 
> Because virtual huge page address boundaries need to be aligned with
> physical huge page address boundaries, and mmap can happen before bos are
> populated so you have no way of knowing how physical huge page
> address

But this is a mmap-time problem, fault can't fix mmap using the wrong VA.

> > I really don't see that either. When a buffer is accessed by the CPU it
> > is in > 90% of all cases completely accessed. Not faulting in full
> > ranges is just optimizing for a really unlikely case here.
> 
> It might be that you're right, but are all drivers wanting to use this like
> drm in this respect? Using the interface to fault in a 1G range in the hope
> it could map it to a huge pud may unexpectedly consume and populate some 16+
> MB of page tables.

If the underlying device block size is so big then sure, why not? The
"unexpectedly" should be quite rare/non existant anyhow.

Jason
 
