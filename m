Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5097E39868C
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Jun 2021 12:31:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232876AbhFBKcn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Jun 2021 06:32:43 -0400
Received: from mail-dm6nam08on2059.outbound.protection.outlook.com ([40.107.102.59]:22227
        "EHLO NAM04-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232692AbhFBKcU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Jun 2021 06:32:20 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lsCQp7ElaXt1qPW+izJhk8i3wDsCLltvhuw/h34d/+WzKvnjVWXJGipEMCNkSTAfbs4vrvoFWtYwJxzhTOeHzl18IH5hp4BSQGydVYGBhCxVArm9YwCO0XRvfyf7+EPWUGFLSoCBgRJ414TfO6FBZHNtUaVQ19pvX8/IQYkLslSpYcNNcUTtbtl+7CuxZzjVoV+lmMsq+flYmoORI3wL+z86h1KgC1fgl2VxbobM3TKtXfkEjRaiZJK/zaZZ1bOGnjSFF1dYMDNMPxc73XTVS1/unTZp6WrAJ7cH3t1FPn/R84qCROzPfOMfrZlCT48JLuOZTSpRME6hmIqgEs3ZnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7iIKutyuKmQ237P3jNxx5dfqP9b7SyRG3wls/UyDWy8=;
 b=CCnCnp2LRNW0j/m23RC2XupFAjVmWloor4hzfkvKOJRFNrxKE4+7BXvxBs2haxPcKdux8rdAcYs1PoZXFcUBVY08DYqt+FgpXKMzAXVCCrQZ1IDvzWyVgK60wAo761VdfighSh+VGogiATTliVoNjF9RvS/BD62yzMANt/plg29an6kqjTAStEkzm3KyTfEHum25NvURe3jzlg4omsLvsiQLo5EVdg+/7C5AV4VuY5+pFBb1NFOv15NRw9C4z+tdk3XkP+U80Smy/eBavM8RruJhaOLvmQzir9MqiqlUmzYMFfB1FnyPp8cfZXIg76s+nkNOS/ppVpfLZUR6mkIspQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.34) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7iIKutyuKmQ237P3jNxx5dfqP9b7SyRG3wls/UyDWy8=;
 b=KiML6cm8KCTzGTQxUZWdVDqarkUtg5P0OdARt29eU0tgBzdiMD1anKEsi4Iyf7pXF1z/PW6ap+Y13wRY1x7GLFWdSyv6uXEMPPNA2U8Hg5sBwNxSCVIMiTEnk3jmqqDzlthWNrWybWh8cfIyyo4S7O8VOlSmmaWFHu3giOh88uL6KaaYpz3aFDIeuRKIt750QYbFtZJlgdYeX5MhGePDG64F7cTyFlFcwvCLfq6XIqkaMDSiiZJ/QtCfMITfARaqzYElJPMfShig+PWpjVRucewDBb4Tb4GR8zie2pekxxta71D1c8IL7PdtXIzQhZh1IvVv1oG7rKELC3NBGgvJ5w==
Received: from CO2PR05CA0061.namprd05.prod.outlook.com (2603:10b6:102:2::29)
 by CH0PR12MB5121.namprd12.prod.outlook.com (2603:10b6:610:bc::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.22; Wed, 2 Jun
 2021 10:30:36 +0000
Received: from CO1NAM11FT067.eop-nam11.prod.protection.outlook.com
 (2603:10b6:102:2:cafe::46) by CO2PR05CA0061.outlook.office365.com
 (2603:10b6:102:2::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.9 via Frontend
 Transport; Wed, 2 Jun 2021 10:30:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.34)
 smtp.mailfrom=nvidia.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.34 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.34; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.34) by
 CO1NAM11FT067.mail.protection.outlook.com (10.13.174.212) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4150.30 via Frontend Transport; Wed, 2 Jun 2021 10:30:36 +0000
Received: from mtl-vdi-166.wap.labs.mlnx (172.20.187.5) by
 HQMAIL107.nvidia.com (172.20.187.13) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Wed, 2 Jun 2021 10:30:31 +0000
Date:   Wed, 2 Jun 2021 13:30:25 +0300
From:   Eli Cohen <elic@nvidia.com>
To:     Jason Wang <jasowang@redhat.com>
CC:     "Michael S. Tsirkin" <mst@redhat.com>,
        virtualization <virtualization@lists.linux-foundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>, <parav@nvidia.com>,
        Lingshan Zhu <lingshan.zhu@intel.com>, <mapfelba@redhat.com>
Subject: Re: [RFC PATCH] vdpa: mandate 1.0 device
Message-ID: <20210602103025.GA17279@mtl-vdi-166.wap.labs.mlnx>
References: <20210409115343-mutt-send-email-mst@kernel.org>
 <42891807-cb24-5352-f8cb-798e9d1a1854@redhat.com>
 <20210412050730-mutt-send-email-mst@kernel.org>
 <01918e14-7f7a-abf2-5864-292a32f0233c@redhat.com>
 <d5632a4d-4d0b-b08d-06f9-c56f16734607@redhat.com>
 <20210421035331-mutt-send-email-mst@kernel.org>
 <3d5754f3-c012-67ad-5f01-fc16ec53df4e@redhat.com>
 <529543956.24692551.1620722593826.JavaMail.zimbra@redhat.com>
 <20210511061740-mutt-send-email-mst@kernel.org>
 <CACGkMEuvqUL04_wHqSKPUufu5O6ydhytHAx0NryLODNHkEO+Fw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACGkMEuvqUL04_wHqSKPUufu5O6ydhytHAx0NryLODNHkEO+Fw@mail.gmail.com>
User-Agent: Mutt/1.9.5 (bf161cf53efb) (2018-04-13)
X-Originating-IP: [172.20.187.5]
X-ClientProxiedBy: HQMAIL111.nvidia.com (172.20.187.18) To
 HQMAIL107.nvidia.com (172.20.187.13)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1acb53a4-4ad7-4d62-34bb-08d925b175a0
X-MS-TrafficTypeDiagnostic: CH0PR12MB5121:
X-Microsoft-Antispam-PRVS: <CH0PR12MB5121705FEFBA48050358061FAB3D9@CH0PR12MB5121.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2201;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WgvFQuk5VsA1iJ1OURrLTgtg0xsSgnvWZaf1jqGJq27q3Q17LBd0Tufipu1xJdV/Eh6r03iBUNUvp+bWUO6hU+WfzO+brgI3m7C4JkDGRJUVi3tqYOmSwIBbFpwmpS/E7z+r0IH/AqMyQVWzHlpO1hMEqjg1x5jA2rcmcAc6xYkrdkVBs1KbSefHEF7F0kbarEkW+L9cfDr3YaY/TZaiDeDTdG58MrE5q9fTDL90Bxxg0j89hZe5elV4rxC6AYSuekF9PwtGDrFhU4BFolSjWmqNIqWmwtxK2LI4Uamfc+M+70f8Tl/03D2v6CnXq5Qo1fZNkPU+hz4DuvA0FhC5vS41tFfeuI6Th6UW7/pZ/n1TjQkXS4GaqT2qJqrFoZHaXvZR5fv/tWtOjGBE25xHcTg0oR0W7HQPyAvOSe4l09T/78CtzNkFXaMmuEh+bCPpnHbfzUc7jhce54ev7KMtGtlTH9bakqmFJzSe+OOcUfAzCnYYt9tPaV96g8nt4ORZ9X/811qD/bGR68HomoxFNjkhzp9ac+mVe+FmNgnc0CzU9vWcybbpIs9RXJfQVH3cCeBInSSyriMwU/yUe9pXQseTt+QyYwOspnkDz4JHC5d2tqUy0LvfYGQNLd7RzDmV1S3fn7r6M9g+BaxHd/6q10f9cSbye9gPQ39zwxEbJAQ=
X-Forefront-Antispam-Report: CIP:216.228.112.34;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:schybrid03.nvidia.com;CAT:NONE;SFS:(4636009)(396003)(136003)(376002)(346002)(39860400002)(36840700001)(46966006)(86362001)(26005)(186003)(16526019)(83380400001)(36860700001)(9686003)(5660300002)(8676002)(82740400003)(2906002)(70206006)(33656002)(6666004)(4326008)(6916009)(54906003)(55016002)(82310400003)(36906005)(316002)(70586007)(53546011)(7636003)(426003)(47076005)(7696005)(478600001)(336012)(1076003)(356005)(8936002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jun 2021 10:30:36.1169
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1acb53a4-4ad7-4d62-34bb-08d925b175a0
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.112.34];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT067.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5121
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 12, 2021 at 05:24:21PM +0800, Jason Wang wrote:

Michael,
Did you and Jason came into agreement regarding this? Do you think we
can have the bits in 5.13 and still have time for me to push the vdpa
too stuff?


> On Wed, May 12, 2021 at 3:54 PM Michael S. Tsirkin <mst@redhat.com> wrote:
> >
> > On Tue, May 11, 2021 at 04:43:13AM -0400, Jason Wang wrote:
> > >
> > >
> > > ----- 原始邮件 -----
> > > >
> > > > 在 2021/4/21 下午4:03, Michael S. Tsirkin 写道:
> > > > > On Wed, Apr 21, 2021 at 03:41:36PM +0800, Jason Wang wrote:
> > > > >> 在 2021/4/12 下午5:23, Jason Wang 写道:
> > > > >>> 在 2021/4/12 下午5:09, Michael S. Tsirkin 写道:
> > > > >>>> On Mon, Apr 12, 2021 at 02:35:07PM +0800, Jason Wang wrote:
> > > > >>>>> 在 2021/4/10 上午12:04, Michael S. Tsirkin 写道:
> > > > >>>>>> On Fri, Apr 09, 2021 at 12:47:55PM +0800, Jason Wang wrote:
> > > > >>>>>>> 在 2021/4/8 下午11:59, Michael S. Tsirkin 写道:
> > > > >>>>>>>> On Thu, Apr 08, 2021 at 04:26:48PM +0800, Jason Wang wrote:
> > > > >>>>>>>>> This patch mandates 1.0 for vDPA devices. The goal is to have the
> > > > >>>>>>>>> semantic of normative statement in the virtio
> > > > >>>>>>>>> spec and eliminate the
> > > > >>>>>>>>> burden of transitional device for both vDPA bus and vDPA parent.
> > > > >>>>>>>>>
> > > > >>>>>>>>> uAPI seems fine since all the vDPA parent mandates
> > > > >>>>>>>>> VIRTIO_F_ACCESS_PLATFORM which implies 1.0 devices.
> > > > >>>>>>>>>
> > > > >>>>>>>>> For legacy guests, it can still work since Qemu will mediate when
> > > > >>>>>>>>> necessary (e.g doing the endian conversion).
> > > > >>>>>>>>>
> > > > >>>>>>>>> Signed-off-by: Jason Wang <jasowang@redhat.com>
> > > > >>>>>>>> Hmm. If we do this, don't we still have a problem with
> > > > >>>>>>>> legacy drivers which don't ack 1.0?
> > > > >>>>>>> Yes, but it's not something that is introduced in this
> > > > >>>>>>> commit. The legacy
> > > > >>>>>>> driver never work ...
> > > > >>>>>> My point is this neither fixes or prevents this.
> > > > >>>>>>
> > > > >>>>>> So my suggestion is to finally add ioctls along the lines
> > > > >>>>>> of PROTOCOL_FEATURES of vhost-user.
> > > > >>>>>>
> > > > >>>>>> Then that one can have bits for legacy le, legacy be and modern.
> > > > >>>>>>
> > > > >>>>>> BTW I looked at vhost-user and it does not look like that
> > > > >>>>>> has a solution for this problem either, right?
> > > > >>>>> Right.
> > > > >>>>>
> > > > >>>>>
> > > > >>>>>>>> Note 1.0 affects ring endianness which is not mediated in QEMU
> > > > >>>>>>>> so QEMU can't pretend to device guest is 1.0.
> > > > >>>>>>> Right, I plan to send patches to do mediation in the
> > > > >>>>>>> Qemu to unbreak legacy
> > > > >>>>>>> drivers.
> > > > >>>>>>>
> > > > >>>>>>> Thanks
> > > > >>>>>> I frankly think we'll need PROTOCOL_FEATURES anyway, it's
> > > > >>>>>> too useful ...
> > > > >>>>>> so why not teach drivers about it and be done with it? You
> > > > >>>>>> can't emulate
> > > > >>>>>> legacy on modern in a cross endian situation because of vring
> > > > >>>>>> endian-ness ...
> > > > >>>>> So the problem still. This can only work when the hardware can support
> > > > >>>>> legacy vring endian-ness.
> > > > >>>>>
> > > > >>>>> Consider:
> > > > >>>>>
> > > > >>>>> 1) the leagcy driver support is non-normative in the spec
> > > > >>>>> 2) support a transitional device in the kenrel may requires the
> > > > >>>>> hardware
> > > > >>>>> support and a burden of kernel codes
> > > > >>>>>
> > > > >>>>> I'd rather simply drop the legacy driver support
> > > > >>>> My point is this patch does not drop legacy support. It merely mandates
> > > > >>>> modern support.
> > > > >>>
> > > > >>> I am not sure I get here. This patch fails the set_feature if VERSION_1
> > > > >>> is not negotiated. This means:
> > > > >>>
> > > > >>> 1) vDPA presents a modern device instead of transitonal device
> > > > >>> 2) legacy driver can't be probed
> > > > >>>
> > > > >>> What I'm missing?
> > > > >>
> > > > >> Hi Michael:
> > > > >>
> > > > >> Do you agree to find the way to present modern device? We need a
> > > > >> conclusion
> > > > >> to make the netlink API work to move forward.
> > > > >>
> > > > >> Thanks
> > > > > I think we need a way to support legacy with no data path overhead. qemu
> > > > > setting VERSION_1 for a legacy guest affects the ring format so it does
> > > > > not really work. This seems to rule out emulating config space entirely
> > > > > in userspace.
> > > >
> > > >
> > > > So I'd rather drop the legacy support in this case. It never work for
> > > > vDPA in the past and virtio-vDPA doesn't even need that. Note that
> > > > ACCESS_PLATFORM is mandated for all the vDPA parents right now which
> > > > implies modern device and LE. I wonder what's the value for supporting
> > > > legacy in this case or do we really encourage vendors to ship card with
> > > > legacy support (e.g endian support in the hardware)?
> > >
> > > Hi Michael:
> > >
> > > Any thoughts on this approach?
> > >
> > > My understanding is that dropping legacy support will simplify a lot of stuffs.
> > >
> > > Thanks
> >
> > So basically the main condition is that strong memory barriers aren't
> > needed for virtio, smp barriers are enough.
> > Are there architectures besides x86 (where it's kind of true - as long as
> > one does not use non-temporals) where that is true?
> > If all these architectures are LE then we don't need to worry
> > about endian support in the hardware.
> 
> So I agree it's better not to add those stuffs in either qemu or
> kernel. See below.
> 
> >
> > In other words I guess yes we could have qemu limit things to x86 and
> > then just pretend to the card that it's virtio 1.
> > So endian-ness we can address.
> >
> > Problem is virtio 1 has effects beyond this. things like header size
> > with mergeable buffers off for virtio net.
> >
> > So I am inclined to say let us not do the "pretend it's virtio 1" game
> > in qemu.
> 
> I fully agree.
> 
>   Let us be honest to the card about what happens.
> > But if you want to limit things to x86 either in kernel or in qemu,
> > that's ok by me.
> 
> So what I want to do is:
> 
> 1) mandate 1.0 device on the kernel
> 2) don't try to pretend transitional or legacy device on top of modern
> device in Qemu, so qemu will fail to start if vhost-vDPA is started
> with a legacy or transitional device
> 
> And this simply the management API which can assume LE for
> pre-configuration via config space.
> 
> So if I'm not misunderstanding, we can merge this patch and I can do
> the Qemu work on top?
> 
> Thanks
> 
> >
> > >
> > > >
> > > >
> > > > >
> > > > > So I think we should add an ioctl along the lines of
> > > > > protocol features. Then I think we can reserve feature bits
> > > > > for config space format: legacy LE, legacy BE, modern.
> > > >
> > > >
> > > > We had VHOST_SET_VRING_ENDIAN but this will complicates both the vDPA
> > > > parent and management. What's more important, legacy behaviour is not
> > > > restrictied by the spec.
> > > >
> > > >
> > > > >
> > > > > Querying the feature bits will provide us with info about
> > > > > what does the device support. Acking them will tell device
> > > > > what does guest need.
> > > >
> > > >
> > > > I think this can work, but I wonder how much we can gain from such
> > > > complexitiy.
> > > >
> > > > Thanks
> > > >
> > > >
> > > > >
> > > > >
> > > > >
> > > > >
> > > > >
> > > > >>>
> > > > >>>>> to have a simple and easy
> > > > >>>>> abstarction in the kenrel. For legacy driver in the guest,
> > > > >>>>> hypervisor is in
> > > > >>>>> charge of the mediation:
> > > > >>>>>
> > > > >>>>> 1) config space access endian conversion
> > > > >>>>> 2) using shadow virtqueue to change the endian in the vring
> > > > >>>>>
> > > > >>>>> Thanks
> > > > >>>> I'd like to avoid shadow virtqueue hacks if at all possible.
> > > > >>>> Last I checked performance wasn't much better than just emulating
> > > > >>>> virtio in software.
> > > > >>>
> > > > >>> I think the legacy driver support is just a nice to have. Or do you see
> > > > >>> any value to that? I guess for mellanox and intel, only modern device is
> > > > >>> supported in the hardware.
> > > > >>>
> > > > >>> Thanks
> > > > >>>
> > > > >>>
> > > > >>>>>>>>
> > > > >>>>>>>>
> > > > >>>>>>>>> ---
> > > > >>>>>>>>>      include/linux/vdpa.h | 6 ++++++
> > > > >>>>>>>>>      1 file changed, 6 insertions(+)
> > > > >>>>>>>>>
> > > > >>>>>>>>> diff --git a/include/linux/vdpa.h b/include/linux/vdpa.h
> > > > >>>>>>>>> index 0fefeb976877..cfde4ec999b4 100644
> > > > >>>>>>>>> --- a/include/linux/vdpa.h
> > > > >>>>>>>>> +++ b/include/linux/vdpa.h
> > > > >>>>>>>>> @@ -6,6 +6,7 @@
> > > > >>>>>>>>>      #include <linux/device.h>
> > > > >>>>>>>>>      #include <linux/interrupt.h>
> > > > >>>>>>>>>      #include <linux/vhost_iotlb.h>
> > > > >>>>>>>>> +#include <uapi/linux/virtio_config.h>
> > > > >>>>>>>>>      /**
> > > > >>>>>>>>>       * vDPA callback definition.
> > > > >>>>>>>>> @@ -317,6 +318,11 @@ static inline int
> > > > >>>>>>>>> vdpa_set_features(struct vdpa_device *vdev, u64
> > > > >>>>>>>>> features)
> > > > >>>>>>>>>      {
> > > > >>>>>>>>>              const struct vdpa_config_ops *ops = vdev->config;
> > > > >>>>>>>>> +        /* Mandating 1.0 to have semantics of
> > > > >>>>>>>>> normative statements in
> > > > >>>>>>>>> +         * the spec. */
> > > > >>>>>>>>> +        if (!(features & BIT_ULL(VIRTIO_F_VERSION_1)))
> > > > >>>>>>>>> +        return -EINVAL;
> > > > >>>>>>>>> +
> > > > >>>>>>>>>          vdev->features_valid = true;
> > > > >>>>>>>>>              return ops->set_features(vdev, features);
> > > > >>>>>>>>>      }
> > > > >>>>>>>>> --
> > > > >>>>>>>>> 2.25.1
> > > >
> > > >
> >
> 
