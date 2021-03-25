Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 05EEE348AC9
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Mar 2021 08:55:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229935AbhCYHyn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Mar 2021 03:54:43 -0400
Received: from new3-smtp.messagingengine.com ([66.111.4.229]:56543 "EHLO
        new3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229882AbhCYHyX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Mar 2021 03:54:23 -0400
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailnew.nyi.internal (Postfix) with ESMTP id 57F9E580A83;
        Thu, 25 Mar 2021 03:54:20 -0400 (EDT)
Received: from imap21 ([10.202.2.71])
  by compute3.internal (MEProxy); Thu, 25 Mar 2021 03:54:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=svenpeter.dev;
         h=mime-version:message-id:in-reply-to:references:date:from:to
        :cc:subject:content-type; s=fm1; bh=wywrE1Y+RTZ0wMV7aq8mui1sDFBC
        V4PPf7ndEvyaysc=; b=tO7AbqGrZXdNYcrptturPfOMfhE6RT5aAIc9AHZKnnBl
        sEMBxc6HcN87LsWBynZbRw3DZE8TUCFprSD+BXmBm49lbfB27BbAhqrzqukHx5Lb
        J/wbYXmMZeAS5GWQxpX+ndQzY8bmfvH6GAXB2dQEsOYkhapUuTwZMEU37VsfedLr
        XcSKniRJEqZQx6o/ZtIscj487A6SiG0hEy/AeX98FHXBFFWi8x+3eWPZM8FMuYTz
        B5DqDIY0cmpIv8K1vCyMHSPbykvERTPhMiNvzGiWnvXhIpiFx+TUmRtHAQYFAtHm
        w6jpu12gjHBeu6txZjGyBOk3sefr/+lqOB75iZN1gA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=wywrE1
        Y+RTZ0wMV7aq8mui1sDFBCV4PPf7ndEvyaysc=; b=thdfhC9x1k6+U/idpOw8uK
        JP1ss8GfXrXCOAlLiOKB+KCrp8+iwu4gZ5JNHcT4WLESbCP7Iniep/mnrXZGkznC
        oULlEyILJH4XdCozHUUf9zakTlZnrEFdMpKqdZ5X62xYoDAIxK6Dzt7AxZdUR54I
        IrhIOiL0JP0lONMFpvWP9eHVzMrhi2CgU76/Ig8TuWWzHYXaDrLpC4uUTXuPs9XU
        Era8IrS9/U+Fj5jGNqPOV4vlqxsxmcXI6hxrxx/A5hHo3gGBsmnYc+MStTbLaWbk
        ir4Yx50CxM7v2QK5lbBahWH9opxawKETgS7QLz5/Vb10FhTqiyl4YkxL5s5RDiqQ
        ==
X-ME-Sender: <xms:q0FcYAC4xvDw2XGH5YJBWg0w0SpUArnmxy9fd_wqpwcjSrfOrjNYIA>
    <xme:q0FcYCh04vVJD5jBgyYUF9WOAGdSyBPIhOGqNpXxmoxO9TackILAGkfTMQ5PPtC52
    p9DBng2oAQqYlN1TaE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrudegledguddufecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefofgggkfgjfhffhffvufgtsehttdertderredtnecuhfhrohhmpedfufhv
    vghnucfrvghtvghrfdcuoehsvhgvnhesshhvvghnphgvthgvrhdruggvvheqnecuggftrf
    grthhtvghrnhepgfeigeeiffeuhfettdejgfetjeetfeelfefgfefgvddvtdfghfffudeh
    vdefkeffnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
    epshhvvghnsehsvhgvnhhpvghtvghrrdguvghv
X-ME-Proxy: <xmx:q0FcYDm9B-I3U7bjkF3DRcGV1nd9-bZ4bWb-mxepQXTg-SH0gKMtpA>
    <xmx:q0FcYGwzvFTnSfH0yFiCj-ltuIJAOxk6NEfjEM_IIBlAS4Lk5v0sCw>
    <xmx:q0FcYFSxKHaZEEnwVzxD8W6Fa0lzMHAscvUuCh7lxp3r4Npat-XVlQ>
    <xmx:rEFcYFYZmfOY1o68g8gmSfX2U77kKv-_jfrb_z7-bSxfNi1YvCPtBat8cDA>
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 224FE51C005E; Thu, 25 Mar 2021 03:54:19 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.5.0-alpha0-273-g8500d2492d-fm-20210323.002-g8500d249
Mime-Version: 1.0
Message-Id: <43685c67-6d9c-4e72-b320-0462c2273bf0@www.fastmail.com>
In-Reply-To: <20210323205346.GA1283560@robh.at.kernel.org>
References: <20210320151903.60759-1-sven@svenpeter.dev>
 <c1bcc0609e920bc6@bloch.sibelius.xs4all.nl>
 <20210323205346.GA1283560@robh.at.kernel.org>
Date:   Thu, 25 Mar 2021 08:53:18 +0100
From:   "Sven Peter" <sven@svenpeter.dev>
To:     "Rob Herring" <robh@kernel.org>,
        "Mark Kettenis" <mark.kettenis@xs4all.nl>
Cc:     iommu@lists.linux-foundation.org, joro@8bytes.org, will@kernel.org,
        "Robin Murphy" <robin.murphy@arm.com>,
        "Arnd Bergmann" <arnd@kernel.org>, marcan@marcan.st,
        "Marc Zyngier" <maz@kernel.org>, mohamed.mediouni@caramail.com,
        stan@corellium.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH 0/3] Apple M1 DART IOMMU driver
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, Mar 23, 2021, at 21:53, Rob Herring wrote:
> On Sun, Mar 21, 2021 at 05:00:50PM +0100, Mark Kettenis wrote:
> > > Date: Sat, 20 Mar 2021 15:19:33 +0000
> > > From: Sven Peter <sven@svenpeter.dev>
> > > I have just noticed today though that at least the USB DWC3 controller in host
> > > mode uses *two* darts at the same time. I'm not sure yet which parts seem to
> > > require which DART instance.
> > > 
> > > This means that we might need to support devices attached to two iommus
> > > simultaneously and just create the same iova mappings. Currently this only
> > > seems to be required for USB according to Apple's Device Tree.
> > > 
> > > I see two options for this and would like to get feedback before
> > > I implement either one:
> > > 
> > >     1) Change #iommu-cells = <1>; to #iommu-cells = <2>; and use the first cell
> > >        to identify the DART and the second one to identify the master.
> > >        The DART DT node would then also take two register ranges that would
> > >        correspond to the two DARTs. Both instances use the same IRQ and the
> > >        same clocks according to Apple's device tree and my experiments.
> > >        This would keep a single device node and the DART driver would then
> > >        simply map iovas in both DARTs if required.
> > > 
> > >     2) Keep #iommu-cells as-is but support
> > >             iommus = <&usb_dart1a 1>, <&usb_dart1b 0>;
> > >        instead.
> > >        This would then require two devices nodes for the two DART instances and
> > >        some housekeeping in the DART driver to support mapping iovas in both
> > >        DARTs.
> > >        I believe omap-iommu.c supports this setup but I will have to read
> > >        more code to understand the details there and figure out how to implement
> > >        this in a sane way.
> > > 
> > > I currently prefer the first option but I don't understand enough details of
> > > the iommu system to actually make an informed decision.
> 
> Please don't mix what does the h/w look like and what's easy to 
> implement in Linux's IOMMU subsytem. It's pretty clear (at least 
> from the description here) that option 2 reflects the h/w. 
> 

Good point, I'll keep that in mind and give option 2 a try.

> > 
> > As I mentioned before, not all DARTs support the full 32-bit aperture.
> > In particular the PCIe DARTs support a smaller address-space.  It is
> > not clear whether this is a restriction of the PCIe host controller or
> > the DART, but the Apple Device Tree has "vm-base" and "vm-size"
> > properties that encode the base address and size of the aperture.
> > These single-cell properties which is probably why for the USB DARTs
> > only "vm-base" is given; since "vm-base" is 0, a 32-bit number
> > wouldn't be able to encode the full aperture size.  We could make them
> > 64-bit numbers in the Linux device tree though and always be explicit
> > about the size.  Older Sun SPARC machines used a single "virtual-dma"
> > property to encode the aperture.  We could do someting similar.  You
> > would use this property to initialize domain->geometry.aperture_start
> > and domain->geometry.aperture_end in diff 3/3 of this series.
> 
> 'dma-ranges' is what should be used here.
> 

The iommu binding documentation [1] mentions that

    The device tree node of the IOMMU device's parent bus must contain a valid
    "dma-ranges" property that describes how the physical address space of the
    IOMMU maps to memory. An empty "dma-ranges" property means that there is a 
    1:1 mapping from IOMMU to memory.

which, if I understand this correctly, means that the 'dma-ranges' for the
parent bus of the iommu should be empty since the DART hardware can see the
full physical address space with a 1:1 mapping.


The documentation also mentions that

     When an "iommus" property is specified in a device tree node, the IOMMU
     will be used for address translation. If a "dma-ranges" property exists
     in the device's parent node it will be ignored.

which means that specifying a 'dma-ranges' in the parent bus of any devices
that use the iommu will just be ignored.

As a concrete example, the PCIe DART IOMMU only allows translations from iovas
within 0x00100000...0x3ff00000 to the entire physical address space (though
realistically it will only map to 16GB RAM starting at 0x800000000 on the M1).

I'm probably just confused or maybe the documentation is outdated but I don't
see how I could specify "this device can only use DMA addresses from
0x00100000...0x3ff00000 but can map these via the iommu to any physical
address" using 'dma-ranges'.

Could you maybe point me to the right direction or give me a small example?
That would help a lot!



Thanks,

Sven


[1] Documentation/devicetree/bindings/iommu/iommu.txt
