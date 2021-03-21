Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 64CE73433BB
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Mar 2021 18:30:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230267AbhCURaL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 21 Mar 2021 13:30:11 -0400
Received: from new2-smtp.messagingengine.com ([66.111.4.224]:43753 "EHLO
        new2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230242AbhCUR3j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Mar 2021 13:29:39 -0400
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailnew.nyi.internal (Postfix) with ESMTP id 6292A5807F6;
        Sun, 21 Mar 2021 13:29:38 -0400 (EDT)
Received: from imap21 ([10.202.2.71])
  by compute3.internal (MEProxy); Sun, 21 Mar 2021 13:29:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=svenpeter.dev;
         h=mime-version:message-id:in-reply-to:references:date:from:to
        :cc:subject:content-type; s=fm1; bh=6XSrGznozEa+8b6KgEeFZf7lrkVD
        WjLgxEJbfR7lK5Q=; b=0ZvS3Dj7x6RiXwlWtjlxq4jktkkjRICejqMvkB4ehZ8u
        /nvRCbwi89kx7KmIK3Zbb5ex0Ak6aoo2hmVtYY2JoNs3UVQ4BPIjFYZzcbxIzcwO
        /XvZmgIIplRHoLWaT4ljOjbKCR7UaA4VlviIwXQ13ap+QOrgXmaYzMPeLSTPqzqE
        LeIB0tuBKyUeWC2JCLnwpTVUgWcGRXeHbPu/NkGel4V7HAdIfuzfiFQSJnfU4fch
        K7bAoxlwuilXgNBR37rVOiaWRmmzBlUp4KfSdlHnY71K0t7BFj9qz0JABZa2fDVG
        XWkGx141BrYGRb6SkGhxg3EbTCFqXba53TvQiSlxYw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=6XSrGz
        nozEa+8b6KgEeFZf7lrkVDWjLgxEJbfR7lK5Q=; b=C+7wd7+uV8WzWRrwJZpxHO
        4/ZMAp9mvNMX2MiiVziJlHp/rFtN3cG1UGvT+qXR43pDbuSAgZ+Lqst1zlrHFf6a
        U36Ojmk8p6d5VnGCAxoCGKyJBsOUy2+ANMU3aqOCw3MRaL57JLr/ebma6U65Wz1w
        Nrno5FveYOXIg0cmL4X84PZ+VJFPvZOFfviAdIUyE4vkQA1i4v2AivTCQIdj66EU
        3RdanjbdyxRufdgi0UQyBXeG49xBCY9lbfET6fkJlJstFviX9htg+lxO/9D4Xyi4
        62NdOd44wgEsXvMbbT2w7IZOGsIzoiJz68vC5SanrdjuCUXoc+wgJKAbIGiSqC6A
        ==
X-ME-Sender: <xms:gIJXYLrvmzE5Bt5XFcZh0PeUbYDmP19WL-0YeF4hSj4G22QePt9VQA>
    <xme:gIJXYFpKNMyjkitA5TWmK2FY31JujYe0m-gNN6QuQpDw2fxuDEP3r695MeqRpA-m1
    Tz1GrZyfH90Be8Bsgg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrudegvddguddtvdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefofgggkfgjfhffhffvufgtsehttdertderredtnecuhfhrohhmpedfufhv
    vghnucfrvghtvghrfdcuoehsvhgvnhesshhvvghnphgvthgvrhdruggvvheqnecuggftrf
    grthhtvghrnhepgfeigeeiffeuhfettdejgfetjeetfeelfefgfefgvddvtdfghfffudeh
    vdefkeffnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
    epshhvvghnsehsvhgvnhhpvghtvghrrdguvghv
X-ME-Proxy: <xmx:gIJXYIPcaHsVN7wB26vN2RHLUcw5-QRH5T8MFU5EpJwrux8TrKFMoQ>
    <xmx:gIJXYO4Ba-npvP6y-Ejj46lhrlrRv9hCHJHBuni1Kpgnq4UTthgdJQ>
    <xmx:gIJXYK5q9-2zC7rJZFau2MrcZOkt07TlRUyourlWMEq05cCwtyuY-A>
    <xmx:goJXYChZxdXfJnEUtWvgCGkipDmOzSC9ES1CAaW-kUCB8QXaI-dWXurpQbU>
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 66E7851C005E; Sun, 21 Mar 2021 13:29:36 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.5.0-alpha0-206-g078a48fda5-fm-20210226.001-g078a48fd
Mime-Version: 1.0
Message-Id: <9b2a6b19-9751-4459-af99-7ab3e20b6106@www.fastmail.com>
In-Reply-To: <c1bcc0609e920bc6@bloch.sibelius.xs4all.nl>
References: <20210320151903.60759-1-sven@svenpeter.dev>
 <c1bcc0609e920bc6@bloch.sibelius.xs4all.nl>
Date:   Sun, 21 Mar 2021 18:28:59 +0100
From:   "Sven Peter" <sven@svenpeter.dev>
To:     "Mark Kettenis" <mark.kettenis@xs4all.nl>
Cc:     iommu@lists.linux-foundation.org, joro@8bytes.org, will@kernel.org,
        robin.murphy@arm.com, robh+dt@kernel.org, arnd@kernel.org,
        marcan@marcan.st, maz@kernel.org, mohamed.mediouni@caramail.com,
        stan@corellium.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH 0/3] Apple M1 DART IOMMU driver
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Hi Mark,

Sorry for the spam if you get this message twice. This is pretty embarrassing
but I've just switched mail providers after ProtonMail messed up yesterday and
it looks like my new one defaulted to sending HTML messages even though I only
typed plaintext. This shouldn't have happened in the first place but it
certainly shouldn't happen again now :-(

> On 21. Mar 2021, at 17:00, Mark Kettenis <mark.kettenis@xs4all.nl> wrote:
> 
> I don't think the first option is going to work for PCIe.  PCIe
> devices will have to use "iommu-map" properties to map PCI devices to
> the right iommu, and the currently implementation seems to assume that
> #iommu-cells = <1>.  The devictree binding[1] doesn't explicitly state
> that it relies on #iommu-cells = <1>, but it isn't clear how the
> rid-base to iommu-base mapping mechanism would work when that isn't
> the case.
> 
> Now the PCIe DARTs are simpler and seem to have only one "instance"
> per DART.  So if we keep #iommu-cells = <1> for those, you'd still be
> fine using the first approach.

Good point, I guess that only leaves option two for now then.
Having some DARTs use cells = <1> and others <2> sounds confusing to me.


> 
> As I mentioned before, not all DARTs support the full 32-bit aperture.
> In particular the PCIe DARTs support a smaller address-space.  It is
> not clear whether this is a restriction of the PCIe host controller or
> the DART, but the Apple Device Tree has "vm-base" and "vm-size"
> properties that encode the base address and size of the aperture.
> These single-cell properties which is probably why for the USB DARTs
> only "vm-base" is given; since "vm-base" is 0, a 32-bit number
> wouldn't be able to encode the full aperture size.  We could make them
> 64-bit numbers in the Linux device tree though and always be explicit
> about the size.  Older Sun SPARC machines used a single "virtual-dma"
> property to encode the aperture.  We could do someting similar.  You
> would use this property to initialize domain->geometry.aperture_start
> and domain->geometry.aperture_end in diff 3/3 of this series.
> 
> I think it would make sense to include this in this series, as this
> would make adding support for PCIe very easy, and PCIe gives you
> aupport for network (both wired and wireless) and the type-A USB ports
> on the mini.



Agreed, I'd ideally like to converge on a device tree binding
that won't have to change in the near future.

I've tried to use an address space larger than 32bit and that seems to
work for parts of the dwc3 controller but breaks for the xhci parts because
the upper lines don't seem to be connected there (e.g. if xhci tries to
use <0x1 0xffff0000> I get a fault for <0 0xffff0000>).

Looking at other iommu drivers I have found the following two similar
bindings:

qcom uses a ranges property with a 64bit address and 32 bit size [1]

  apps_iommu: iommu@1e20000 {
      ...
      ranges = <0 0x1e20000 0x40000>;
      ...
  };

and tegra seems to support a dma-window property with 32bit address
and size [2]

  smmu {
          [...]
          dma-window = <0 0x40000000>;    /* IOVA start & length */
          [...]
  };

I believe there already is of_get_dma_window to handle parsing this
in the common iommu code [3] but I can't find any place using it.
It's a little bit more complex that we need since it allows to specify the
number of cells for both the address and the size but it should allow us to
express all possible configurations:

  usb_dart {
      [ ... ]
      #dma-address-cells = <1>;
      #dma-size-cells = <2>;
      dma-window = <0 0x1 0x0>;
      [ ... ]
  };
  pcie_dart {
      [ ... ]
      #dma-address-cells = <1>;
      #dma-size-cells = <1>;
      dma-window = <0x100000 0x3fe00000>;
      [ ... ]
  };

where #dma-address-cells and #dma-size-cells default to
#address-cells and #size-cells respectively if I understand
the code correctly. That way we could also just always use
a 64bit address and size in the DT, e.g.

  pcie_dart {
      [ ... ]
      dma-window = <0 0x100000 0 0x3fe00000>;
      [ ... ]
  };


Best,

Sven


[1] Documentation/devicetree/bindings/iommu/qcom,iommu.txt
[2] Documentation/devicetree/bindings/iommu/nvidia,tegra30-smmu.txt
[3] drivers/iommu/of_iommu.c
