Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 97958456534
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Nov 2021 22:52:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229921AbhKRVzS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Nov 2021 16:55:18 -0500
Received: from mail-dm6nam10on2073.outbound.protection.outlook.com ([40.107.93.73]:7264
        "EHLO NAM10-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229472AbhKRVzR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Nov 2021 16:55:17 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jUQQJp6UmZy3/agwF5ycbd7jkAZjougHU5GhMxOLvjUeOqt+2RBV2UBujGM5XBWUIdEr3eGrIo1YmJ2ccT00vBYbhvcDr3NpQO90lYs/2kqqMKTrOZ8FjDsKJ9Ofk7o7gcOCr+w7Ofj0L7Bu/HeRLrJH+5NNUUSOeqBZmSkZFChmoOmDWrrQYrm7tjBbceb8n6X+o6RRyglFyn8hcxn5xFXENDlPokgb1CWSsZYoK8D3pqzVwikPxvtO/Vh/Isq37S5J0+1dnnoB5Mo5lZdZhMaCA2HV4vxgtI5tyAJ9w2Ocq7qaNili+ALZ8detj13Uz0oNfGk/497Ukaueow8wyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0JzYThKhctI0vH+GpzDQ1fdCXn383Yjinqk0jEM9Ch4=;
 b=OSE1GOuHqr3xm0/r28eD8YCo0enEuQamnB3rwjR+HJmtGL3J4QTHYvLAASXLunOeSO8o35ws2wS1uU6ofzo3Vuu39r312GY3ajqsph7bcxKLQ9274Sv109aJeM6XysUo2x8JOORwep6EIrloWrsKJhZajhA4D7hOU4xLD8YItv+J+xUt7Ac6iLekpYCcnqKrPDh2HvX5E4ItEGIqosY0dQdIn2ouRrmdjE1KFRgbqlz6muqAq+dfZ6JSnGXp2LHas26+b62AR7KdiWlpT9q96b2YbwCdZ4CTQc+p7K+lV421dzZs7nJ1dLgkyT8qpECZfOQicOOM6TN0/CBZuzqioA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0JzYThKhctI0vH+GpzDQ1fdCXn383Yjinqk0jEM9Ch4=;
 b=2e0RldrM07qyEG5K4Qs/YgQxYXRgTcAZxpwdO03RJVizMbUJ0K94p4N1A4d0tv59mpY3Su++fbThHmIlTremjrrESKmzPof7vypv8rAIISrC+m8SHjPZODXU/P4+/IsDZkwedb6WtWHckH8aq0XHXsbtdn9ZZqNQi+ihcEVjfYQ=
Received: from SN1PR12MB2575.namprd12.prod.outlook.com (2603:10b6:802:25::14)
 by SN6PR12MB4768.namprd12.prod.outlook.com (2603:10b6:805:e8::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.19; Thu, 18 Nov
 2021 21:52:14 +0000
Received: from SN1PR12MB2575.namprd12.prod.outlook.com
 ([fe80::dc61:1d3f:e774:5589]) by SN1PR12MB2575.namprd12.prod.outlook.com
 ([fe80::dc61:1d3f:e774:5589%6]) with mapi id 15.20.4713.022; Thu, 18 Nov 2021
 21:52:14 +0000
From:   "Errabolu, Ramesh" <Ramesh.Errabolu@amd.com>
To:     kernel test robot <lkp@intel.com>
CC:     "llvm@lists.linux.dev" <llvm@lists.linux.dev>,
        "kbuild-all@lists.01.org" <kbuild-all@lists.01.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Deucher, Alexander" <Alexander.Deucher@amd.com>,
        "Kuehling, Felix" <Felix.Kuehling@amd.com>
Subject: RE: [agd5f:drm-next 51/92]
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c:1335:6: warning: no previous
 prototype for function 'amdgpu_amdkfd_gpuvm_unpin_bo'
Thread-Topic: [agd5f:drm-next 51/92]
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c:1335:6: warning: no previous
 prototype for function 'amdgpu_amdkfd_gpuvm_unpin_bo'
Thread-Index: AQHX3LegE2Szfg669ka2uUn3zz+MK6wJ0tyg
Date:   Thu, 18 Nov 2021 21:52:14 +0000
Message-ID: <SN1PR12MB257567FC4234239ED1BEE0E7E39B9@SN1PR12MB2575.namprd12.prod.outlook.com>
References: <202111190400.ImNbUILt-lkp@intel.com>
In-Reply-To: <202111190400.ImNbUILt-lkp@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=true;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2021-11-18T21:52:12Z;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD Official Use
 Only-AIP 2.0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ActionId=fca451b8-c81f-4a52-a790-ba3224bc6389;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=1
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_enabled: true
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_setdate: 2021-11-18T21:52:12Z
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_method: Standard
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_name: AMD Official Use
 Only-AIP 2.0
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_actionid: 135c4934-c5e3-4712-88ce-88546eee42a6
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 2981ef9a-ee17-4a00-6076-08d9aaddaeca
x-ms-traffictypediagnostic: SN6PR12MB4768:
x-microsoft-antispam-prvs: <SN6PR12MB4768C80260E58DD2B87285C9E39B9@SN6PR12MB4768.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:69;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: dv2F1f0j/QXuR1rqAyZ/T8s07uh94EU0UqVE2+hEFmympmG3E71GmY53wJ/vyB7CxekvQmsSi/hpkr0HM/PPL9+gTeCGbczl06l7eE/BRyfajxzb9lFU9oSknepA4a7X/XEdB2pqMSvg8tItWS3kv1RX6Y7N4N/mTahhNzDbLG396Z9dVRAuW3L61DMwofwBfzYG8OXT5msRND+pRWshnI0khGT1fBsiZ7Pxfu5B6iPl74lCibyp5uQRMKE6L4YyCIouhqd6oDazbIOQ7IHD8sk4ORSF7f6gBP6l/u0D533FLOB5LPaWr3OXK/LNXVPZIQdgj6lOS/isiV+AIfebEq+Tdl22BxsnuCWX26Xf7iiOVGFZ+uN4U9s4bdZGdOJuOINzLuRbYnyttmEaPNSrePDWNzgMarOzqFnZZElMLZfav+LHmnPsvdyZIVlR3A1ubC3AA5Kjv9g2zgEbGu+NWA54+y0dxxLAg34bvpqBhJPpwmvi1HmFesI2rwcwoGQ4qmengC6OHc1Hs4i4Pi3aiOjKz8Jnezi2LDkMHx7zeXNvMKvVlskV4geJT65xDaXcuhBjkgA1L++kFeauEMzjrWc2QdVOWdjTeFdCIhKMLfiZwIPd3iQUSV+r1gUxbyxBnO5nj1gvpSG0540UGXTHK5GFKa72fp9EXcWaWX7bfs06BCzSpzXZrquX6OD9TqPawvLTF0bIXaz6HTdA4NkCs9aq8Fz6aNdadeKCF+xkVc7SgSsE+Tj0xYhrJxBYpP85y3NpT33jC8ZiBTJdpPi11yjsaBn3QKI48/DaoDjmfg0=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN1PR12MB2575.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(966005)(6916009)(316002)(5660300002)(508600001)(2906002)(38070700005)(4326008)(76116006)(6506007)(26005)(83380400001)(186003)(53546011)(52536014)(33656002)(66556008)(45080400002)(66446008)(66476007)(66946007)(86362001)(8676002)(64756008)(8936002)(122000001)(7696005)(38100700002)(9686003)(54906003)(71200400001)(55016002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?zHOtRtsM2UBpYa50WR800UYuSyEdSjSh33ZacC7GJdYgjrpxRcNkoHHKWti0?=
 =?us-ascii?Q?9gz1lHNdM6Nri3xV/sEplqO0RvTW+n1vo7Vtz7UV+njOyuM0zsZaRuZwV/wW?=
 =?us-ascii?Q?kSKi54bLLf06l8E+49Bfida0UOhBBTOm4/WL9GfAKIpechGk1Fn5Fa2hmUxu?=
 =?us-ascii?Q?tIHitqSFqwkviikZNEKyFgXekt0GjSqZjWibyCgoX7nV2+12Bb9XoUOAj+LT?=
 =?us-ascii?Q?/EE4lA3IUqC5x4HKJKCQgYc7Ss0rwXhrm3SjVgUx5EBpQ4tdeaxCBlWIlCPT?=
 =?us-ascii?Q?+XNolCFrBV13YtudWfc7IFsboyDhSp1QqIGVadAQ2DR5KiM2Sd3NviToyhZt?=
 =?us-ascii?Q?dkAOzvTtnuquB10AKTOCIyrdvhdCU4JcKrYwj2zpZKOv238avmHn/7KIAtrC?=
 =?us-ascii?Q?ApIm0A+C42O8KTLk1+jSrcyHuu5uoO7R4a/BrJ8b77XyUbR0N27TFQJJSTYG?=
 =?us-ascii?Q?0ZkIIX4BKQouctpaqq74Klg4zXTOJvQw5dD5CBEgvi4izLTO5Z5OwdZijUsC?=
 =?us-ascii?Q?T4STmLj+wg3imnyf/Xvnfm6uDpazjl/vDyrfJv9pFiaoxYVTzNcMaU3AcT72?=
 =?us-ascii?Q?h7h9DTzqvx9xii11B+F3j7TddfeCMKndwpPLCJksWx4ruQ5w2xQBMo5kfE33?=
 =?us-ascii?Q?13uobAqdFQcb9rQlaEUYaVVhzVCEatYcSIxqjiLeD9+hzlXsig9SlpGPNELL?=
 =?us-ascii?Q?pK4Q0mEZgTY+1u/VDVBkh3fMWjcW0wvAZ26O07jNvIZtosTz7E4WLc7opNak?=
 =?us-ascii?Q?L0hHTkpfkIFFJdGgb7n8siIlf+e2dq2MVPdPyBLKQOMD5DF/46hFzdS/oZt0?=
 =?us-ascii?Q?aNqSuVSfHrZDNWZgZP7d4IY+puj82Qj1IGX4eegFEzKF2McA5yZdgijew3sK?=
 =?us-ascii?Q?cnP7LyqKLTR2W1uAOxKaEUe+3oKTIov+29C4uGfcihfZ8ObIusdUf2sWksyd?=
 =?us-ascii?Q?8OkWymUiFHT1f8kbkgfMbQaAXKjUknfcouyKzDN8/+4N/ifsvRHIVxUcOq8r?=
 =?us-ascii?Q?KpmG9hfaVd6i8aVaTUh+aCJdikvat10ir4jQDCzYhSgc5Ygg7YrmVdZ7KFmM?=
 =?us-ascii?Q?OX5nqDvTsEfmFtzhKO3eUuJ79nW/tBX5DL16rHhV/VclsXvBuyu6OBTQqmIU?=
 =?us-ascii?Q?ZjkRi0CjNRmApl+HGr49J+DKUMMYaBxMExmrx2xBa5YtXqXGEpjOi+FS3ypT?=
 =?us-ascii?Q?iIIEDL6fYHmcigC9eWZMRMUs6+jILMFeAJosf35mLKj3G0kgYwS6oUZU8sC9?=
 =?us-ascii?Q?uUnBM+oIN9xMxT7fgDVtO/sID9alX8eDrgp7y1guuW3WkGtlNOC3SaYcQFwl?=
 =?us-ascii?Q?24zKZM3yMsjHCTgo+00VEcLwuj21tYMapmeTxM1B0vb2J0I3TKrOXsKy5V4W?=
 =?us-ascii?Q?S0/lNNp+e37p7ZcQbao30jtbb7rrGtsoxUyxH2cXlT00adD9DHqMjQ7GnCfe?=
 =?us-ascii?Q?gJph6r0LPFRaKgQh1q09lPsij4XJ6BwrHxmeoUzvQpXsZDRVmR9L75j6By3Z?=
 =?us-ascii?Q?caANXeVTuF5hbKXWr0mTPdqb8UkznYsRTHx2+3b/pHbaZcqX+aP3NH+lNVXx?=
 =?us-ascii?Q?SOYyRA1AzMj0ocgkXkJjLuv5MKzrY8TWA92glRvX1oDuIM4lfxs4dsZ6tSVl?=
 =?us-ascii?Q?kztyCaM1mtKS9OhvEAiqCpg=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN1PR12MB2575.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2981ef9a-ee17-4a00-6076-08d9aaddaeca
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Nov 2021 21:52:14.5779
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qOzKvZhm10vRRZA42pB0f3XgcvAaN1cFTva50gkQkPNIjdGsnPfoGfp+kpDJ2SKu6bEO4gEEzYEQl83Ud4CxUQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR12MB4768
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[AMD Official Use Only]

Felix,

Could you advise if I should submit a patch to fix the warning. The api und=
er question (amdgpu_amdkfd_gpuvm_unpin_bo) MUST be non-static in DKMS branc=
h. However it could be specified as static on drm-next. What is the policy =
under such situations. Let me know.

Regards,
Ramesh

-----Original Message-----
From: kernel test robot <lkp@intel.com>
Sent: Thursday, November 18, 2021 2:00 PM
To: Errabolu, Ramesh <Ramesh.Errabolu@amd.com>
Cc: llvm@lists.linux.dev; kbuild-all@lists.01.org; linux-kernel@vger.kernel=
.org; Deucher, Alexander <Alexander.Deucher@amd.com>; Kuehling, Felix <Feli=
x.Kuehling@amd.com>
Subject: [agd5f:drm-next 51/92] drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gp=
uvm.c:1335:6: warning: no previous prototype for function 'amdgpu_amdkfd_gp=
uvm_unpin_bo'

[CAUTION: External Email]

tree:   https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2=
Fgitlab.freedesktop.org%2Fagd5f%2Flinux.git&amp;data=3D04%7C01%7CRamesh.Err=
abolu%40amd.com%7Cb83bf0b9d065404f642808d9aace10f3%7C3dd8961fe4884e608e11a8=
2d994e183d%7C0%7C0%7C637728627265110891%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4=
wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000&amp;sdata=3D=
K8TrE3DWtsNrw4qWrttGfGdL71w3w9Gv1KUCOq1zWHk%3D&amp;reserved=3D0 drm-next
head:   eaae0714f4a82df81a60c6aae74c568e8974a716
commit: f140fc51a32ef8637b522a880b8f9f14683ce8df [51/92] drm/amdgpu: Pin MM=
IO/DOORBELL BO's in GTT  domain
config: x86_64-randconfig-r001-20211118 (attached as .config) reproduce (th=
is is a W=3D1 build):
        wget https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A=
%2F%2Fraw.githubusercontent.com%2Fintel%2Flkp-tests%2Fmaster%2Fsbin%2Fmake.=
cross&amp;data=3D04%7C01%7CRamesh.Errabolu%40amd.com%7Cb83bf0b9d065404f6428=
08d9aace10f3%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C63772862726512088=
0%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1ha=
WwiLCJXVCI6Mn0%3D%7C3000&amp;sdata=3DOEvXACWiWtGXk1em3DdxFBHWJEQ8InliJUbr9F=
LoKbU%3D&amp;reserved=3D0 -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        git remote add agd5f https://nam11.safelinks.protection.outlook.com=
/?url=3Dhttps%3A%2F%2Fgitlab.freedesktop.org%2Fagd5f%2Flinux.git&amp;data=
=3D04%7C01%7CRamesh.Errabolu%40amd.com%7Cb83bf0b9d065404f642808d9aace10f3%7=
C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637728627265120880%7CUnknown%7C=
TWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0=
%3D%7C3000&amp;sdata=3DMc0JG24aLBE%2B%2Bo073hnBipZMP8LicS3oeiXufr3h4Bo%3D&a=
mp;reserved=3D0
        git fetch --no-tags agd5f drm-next
        git checkout f140fc51a32ef8637b522a880b8f9f14683ce8df
        # save the attached .config to linux build tree
        COMPILER_INSTALL_PATH=3D$HOME/0day COMPILER=3Dclang make.cross W=3D=
1 ARCH=3Dx86_64

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c:1335:6: warning: no=20
>> previous prototype for function 'amdgpu_amdkfd_gpuvm_unpin_bo'
>> [-Wmissing-prototypes]
   void amdgpu_amdkfd_gpuvm_unpin_bo(struct amdgpu_bo *bo)
        ^
   drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c:1335:1: note: declare '=
static' if the function is not intended to be used outside of this translat=
ion unit
   void amdgpu_amdkfd_gpuvm_unpin_bo(struct amdgpu_bo *bo)
   ^
   static
   1 warning generated.


vim +/amdgpu_amdkfd_gpuvm_unpin_bo +1335 drivers/gpu/drm/amd/amdgpu/amdgpu_=
amdkfd_gpuvm.c

  1326
  1327  /**
  1328   * amdgpu_amdkfd_gpuvm_unpin_bo() - Unpins BO using following crite=
ria
  1329   * @bo: Handle of buffer object being unpinned
  1330   *
  1331   *   - Is a illegal request for USERPTR BOs and is ignored
  1332   *   - All other BO types (GTT, VRAM, MMIO and DOORBELL) will have =
their
  1333   *     PIN count decremented. Calls to UNPIN must balance calls to =
PIN
  1334   */
> 1335  void amdgpu_amdkfd_gpuvm_unpin_bo(struct amdgpu_bo *bo)
  1336  {
  1337          int ret =3D 0;
  1338
  1339          ret =3D amdgpu_bo_reserve(bo, false);
  1340          if (unlikely(ret))
  1341                  return;
  1342
  1343          amdgpu_bo_unpin(bo);
  1344          amdgpu_bo_unreserve(bo);
  1345  }
  1346

---
0-DAY CI Kernel Test Service, Intel Corporation
https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flists.0=
1.org%2Fhyperkitty%2Flist%2Fkbuild-all%40lists.01.org&amp;data=3D04%7C01%7C=
Ramesh.Errabolu%40amd.com%7Cb83bf0b9d065404f642808d9aace10f3%7C3dd8961fe488=
4e608e11a82d994e183d%7C0%7C0%7C637728627265120880%7CUnknown%7CTWFpbGZsb3d8e=
yJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000&am=
p;sdata=3DiNtsNcsj43m1oShIaDr3W%2FVTj0uSOtcI2RU9u04CuDA%3D&amp;reserved=3D0
