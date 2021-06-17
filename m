Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E5E03AAB67
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jun 2021 07:52:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229693AbhFQFyG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Jun 2021 01:54:06 -0400
Received: from mail-mw2nam12on2089.outbound.protection.outlook.com ([40.107.244.89]:24833
        "EHLO NAM12-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229515AbhFQFyD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jun 2021 01:54:03 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Q19Ot0t6OqBfeJC/3qs6Ju0IZbJ7ZwV/y67kAuVWUNwjpP6vHpId3gR6TUY1NJjDFH0dm1YRFvA+5MFUh+cOflk8/2aQi/TBcK8TCMqwem/6TItey3wik6eQDgDXrfMrNxuD3+hjCXeJ8GvAeTD0yK4PDarvS1/q/dv/ruDBkcF78I84JNHYiz0X2wqs7bEGZf+zslVB9die3G3LPHoCU769UHULx/P4TI7YVnTh5ThdRbJJxnZX76Jwy12Xi3AMmJTX5tuL48wP4ziRfYhB4VxCx6AWGcKe4qpwWK8Ekf0YJUKjV8sp9u6XPpCDwt9ueVFJI0qyPN6A3svSwaO1OA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8Rk0Tr5PbW9/2vXBsnb8a2hlO4SsJEBZ1oFO+LVYSsk=;
 b=IPS0Eb6j3aW/hbNfmWgYGcgMpU2sv0HUO43C39BJXcjsXcpjueUCRt8I+K6IZ57Rw+0DPUTyMrkAZkyUm9qMLt9+d9IAGXlFSsmRauzVLWixcl3cdx7By8nVzQpTGvYV/ogHVon5plGxf0IEZT2ZNHRw1YJiZR7pEFTvkwLoYH3OABlE2EHPWk/n6llnNLJJzr6B3FK3xyQDSFCmvGvXDmHKm/4PXIfQIdZaOuMGZKHQkSXGrVbE4vzTNWM6WtHQeZe194JT5XIXqZmM7VvVeJj2//AYV5H0ybMwIMnVomN0Zz+C52GlGgRycovAH/dxrDHRhcIxYqvVudG5F/yVSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.34) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8Rk0Tr5PbW9/2vXBsnb8a2hlO4SsJEBZ1oFO+LVYSsk=;
 b=aEweZLqTXfdNkSwzzcHbE/BcXm9bcW3gAW3iy3PBpIsAODtkFThyK6E7/iu36QobqErL7Ir4D1xJ7GT7VUAN/NbDrjBpkTqMZkLuTxm8f04YF7BL0Z1geXlYHFR3YJU4nAhyd4OcW4lisX/G7WholuE3wCk63TDH11qy7TThXM2CWsVrtXJbXoqVj0QNOTrj9TtiGw+2zJJL3T7Z8GkxKu5RS6avq4JISuNPTSBnjDXdbbv9jl0vrmS/NUXrCtTOltjbjVcS0jaCO/56cAtvI64HqrRlg04zxxKmu6Q2Bg60pRjdSh01tp4FOIsUzVRQT+NUWaxwULoe663qhR9T3w==
Received: from DM5PR18CA0088.namprd18.prod.outlook.com (2603:10b6:3:3::26) by
 BL1PR12MB5270.namprd12.prod.outlook.com (2603:10b6:208:31e::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4242.18; Thu, 17 Jun 2021 05:51:55 +0000
Received: from DM6NAM11FT022.eop-nam11.prod.protection.outlook.com
 (2603:10b6:3:3:cafe::87) by DM5PR18CA0088.outlook.office365.com
 (2603:10b6:3:3::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.19 via Frontend
 Transport; Thu, 17 Jun 2021 05:51:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.34)
 smtp.mailfrom=nvidia.com; kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.34 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.34; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.34) by
 DM6NAM11FT022.mail.protection.outlook.com (10.13.172.210) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4242.16 via Frontend Transport; Thu, 17 Jun 2021 05:51:55 +0000
Received: from [10.40.103.48] (172.20.187.6) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Thu, 17 Jun
 2021 05:51:52 +0000
Subject: Re: [PATCH 1/2] iommu: Fix race condition during default domain
 allocation
To:     Robin Murphy <robin.murphy@arm.com>, Will Deacon <will@kernel.org>,
        <vdumpa@nvidia.com>
CC:     <iommu@lists.linux-foundation.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
References: <1623298614-31755-1-git-send-email-amhetre@nvidia.com>
 <1623298614-31755-2-git-send-email-amhetre@nvidia.com>
 <20210611104524.GD15274@willie-the-truck>
 <faf4504c-43f2-f68e-9a00-5e450dd7f352@arm.com>
From:   Ashish Mhetre <amhetre@nvidia.com>
Message-ID: <315fe1c5-2685-6ee3-2aa4-35a27233127b@nvidia.com>
Date:   Thu, 17 Jun 2021 11:21:39 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <faf4504c-43f2-f68e-9a00-5e450dd7f352@arm.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [172.20.187.6]
X-ClientProxiedBy: HQMAIL111.nvidia.com (172.20.187.18) To
 HQMAIL107.nvidia.com (172.20.187.13)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d476eb37-637f-4f17-9ccf-08d93154036d
X-MS-TrafficTypeDiagnostic: BL1PR12MB5270:
X-Microsoft-Antispam-PRVS: <BL1PR12MB5270323C8134A20E7DC31F7ACA0E9@BL1PR12MB5270.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NgKBSx0OsX18aQsVDtW+Lne+5qn9VVTHlK31P7DCcN5FchydaFB0/j1zLhGpMkcCO55HUYmKvxCaHMippBmA4sqcCmDcT5CsoW87LIZhPUOBcUqGhhvE/6QfspnMOl0W4G1jUf4KMfA1hX+5bohpwzEMX1fzb9s9Aw5D2qy1yPEg298blnjFEeaExElE4tlTG41x37ci7hxkbAX4FjYfc+lmuMO+f3AShoVMe49sJZiSP5w6/n736BrCyfq1iufIavf7FqcCWTltxFRrxpOQ6GVfT0e/3Laj+TGfa9u4heAJlMpRxS7VlHQn0Oauht9axsnaS4fyuKCvcsOlXr6LBeMirve1R8pCEmYwPGM0QUrfNNcxrcf0btu9DOwHhtYS/B5euLwU4wZF3+65QYvLTIHDvP8jYaenF3hcYXvsdWee8FgGevn9r4cy8MOqXKa4opG4Pbtw/d+JzF04XKfUhGgoNIm9cxBE7YQOhCqp+85t2jPF3I43jLAphjlbtyHOoVyZI8PgDL9M41dgulzr0PDgbW6QvS+B2moMEc4KDeouxWoQwBpk9TtJSDCO4fr0SRnxyr5idsfFphSOX+B4gwm1FyfUV5uQm/AFcWXcbEzcWssKE5BrqK6HwF8K+JoYGI+7QDRnjhXqGpSF1LhMiSwnzX2+sFViVgk09OFIhFUjDw2zzRIygcNsnbf/9ndw
X-Forefront-Antispam-Report: CIP:216.228.112.34;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:schybrid03.nvidia.com;CAT:NONE;SFS:(4636009)(39860400002)(376002)(346002)(136003)(396003)(46966006)(36840700001)(47076005)(16576012)(4326008)(5660300002)(110136005)(186003)(26005)(478600001)(54906003)(36906005)(2616005)(336012)(82740400003)(86362001)(2906002)(356005)(36860700001)(426003)(7636003)(316002)(8936002)(70206006)(82310400003)(70586007)(6636002)(31686004)(53546011)(36756003)(31696002)(16526019)(6666004)(8676002)(83380400001)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2021 05:51:55.3035
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d476eb37-637f-4f17-9ccf-08d93154036d
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.112.34];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT022.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5270
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 6/11/2021 6:19 PM, Robin Murphy wrote:
> External email: Use caution opening links or attachments
> 
> 
> On 2021-06-11 11:45, Will Deacon wrote:
>> On Thu, Jun 10, 2021 at 09:46:53AM +0530, Ashish Mhetre wrote:
>>> Domain is getting created more than once during asynchronous multiple
>>> display heads(devices) probe. All the display heads share same SID and
>>> are expected to be in same domain. As iommu_alloc_default_domain() call
>>> is not protected, the group->default_domain and group->domain are ending
>>> up with different domains and leading to subsequent IOMMU faults.
>>> Fix this by protecting iommu_alloc_default_domain() call with 
>>> group->mutex.
>>
>> Can you provide some more information about exactly what the h/w
>> configuration is, and the callstack which exhibits the race, please?
> 
> It'll be basically the same as the issue reported long ago with PCI
> groups in the absence of ACS not being constructed correctly. Triggering
> the iommu_probe_device() replay in of_iommu_configure() off the back of
> driver probe is way too late and allows calls to happen in the wrong
> order, or indeed race in parallel as here. Fixing that is still on my
> radar, but will not be simple, and will probably go hand-in-hand with
> phasing out the bus ops (for the multiple-driver-coexistence problem).
> 
For iommu group creation, the stack flow during race is like:
Display device 1:
iommu_probe_device -> iommu_group_get_for_dev -> arm_smmu_device_group
Display device 2:
iommu_probe_device -> iommu_group_get_for_dev -> arm_smmu_device_group

And this way it ends up in creating 2 groups for 2 display devices 
sharing same SID.
Ideally for 2nd display device, iommu_group_get call from 
iommu_group_get_for_dev should return same group as 1st display device. 
But due to the race, it ends up with 2 groups.

For default domain, the stack flow during race is like:
Display device 1:
iommu_probe_device -> iommu_alloc_default_domain -> arm_smmu_domain_alloc
Display device 2:
iommu_probe_device -> iommu_alloc_default_domain -> arm_smmu_domain_alloc

Here also 2nd device should already have domain allocated and 
'if(group->default_domain)' condition from iommu_alloc_default_domain 
should be true for 2nd device.

Issue with this is IOVA accesses from 2nd device results in context faults.

>>> Signed-off-by: Ashish Mhetre <amhetre@nvidia.com>
>>> ---
>>>   drivers/iommu/iommu.c | 2 ++
>>>   1 file changed, 2 insertions(+)
>>>
>>> diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
>>> index 808ab70..2700500 100644
>>> --- a/drivers/iommu/iommu.c
>>> +++ b/drivers/iommu/iommu.c
>>> @@ -273,7 +273,9 @@ int iommu_probe_device(struct device *dev)
>>>       * support default domains, so the return value is not yet
>>>       * checked.
>>>       */
>>> +    mutex_lock(&group->mutex);
>>>      iommu_alloc_default_domain(group, dev);
>>> +    mutex_unlock(&group->mutex);
>>
>> It feels wrong to serialise this for everybody just to cater for systems
>> with aliasing SIDs between devices.
> 
> If two or more devices are racing at this point then they're already
> going to be serialised by at least iommu_group_add_device(), so I doubt
> there would be much impact - only the first device through here will
> hold the mutex for any appreciable length of time. Every other path
> which modifies group->domain does so with the mutex held (note the
> "expected" default domain allocation flow in bus_iommu_probe() in
> particular), so not holding it here does seem like a straightforward
> oversight.
> 
> Robin.
Serialization will only happen for the devices sharing same group. Only 
the first device in group will hold this till domain is created. For 
rest of the devices it will just check for existing domain in 
iommu_alloc_default_domain and then return and release the mutex.


