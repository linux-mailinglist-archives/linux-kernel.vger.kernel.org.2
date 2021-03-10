Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3DDD733427F
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Mar 2021 17:08:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230506AbhCJQIV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Mar 2021 11:08:21 -0500
Received: from mail.kernel.org ([198.145.29.99]:58204 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232569AbhCJQH6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Mar 2021 11:07:58 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id E45D564F4C;
        Wed, 10 Mar 2021 16:07:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1615392478;
        bh=7sTMvplzl4qRhmylBff3JMaWNZ6VDs7GHryb8IWMb8E=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=PIIVIbrunaUx2mEUOz6ZJxHRH1se7E+5o1HDWFnKHf8eRzIiylHjOZmg5NZShqUGW
         hjBa9elVXNdk4eDdsGhTeXYuzv3/BXbX9p/KFb7ybT6VG90bTEx1lnCRZOw2RFaiFz
         xUEZGv0mJM9hDLsvPxYJiJZDiqjW49MgbOGmc1zY8E3cbyvNj4DU6HwresgdU5wkaD
         /6Nzn59UjeidTCW1K7nx7/asBj1lP/sYdEKM7aFPidqM8CVyvFTnzvC3yn1XacZioJ
         H8pxELt905xod7Mk5tdYLPuc5q0SIB1frKl7tHHxsimgV+p7eYBm76eNyVHMHiOgX+
         s9X5laJqNqC3Q==
Date:   Wed, 10 Mar 2021 16:07:48 +0000
From:   Will Deacon <will@kernel.org>
To:     Claire Chang <tientzu@chromium.org>
Cc:     Rob Herring <robh+dt@kernel.org>, mpe@ellerman.id.au,
        Joerg Roedel <joro@8bytes.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        boris.ostrovsky@oracle.com, jgross@suse.com,
        Christoph Hellwig <hch@lst.de>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        benh@kernel.crashing.org, paulus@samba.org,
        "list@263.net:IOMMU DRIVERS" <iommu@lists.linux-foundation.org>,
        sstabellini@kernel.org, Robin Murphy <robin.murphy@arm.com>,
        grant.likely@arm.com, xypron.glpk@gmx.de,
        Thierry Reding <treding@nvidia.com>, mingo@kernel.org,
        bauerman@linux.ibm.com, peterz@infradead.org,
        Greg KH <gregkh@linuxfoundation.org>,
        Saravana Kannan <saravanak@google.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        heikki.krogerus@linux.intel.com,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        linux-devicetree <devicetree@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        linuxppc-dev@lists.ozlabs.org, xen-devel@lists.xenproject.org,
        Nicolas Boichat <drinkcat@chromium.org>,
        Jim Quinlan <james.quinlan@broadcom.com>
Subject: Re: [PATCH v4 13/14] dt-bindings: of: Add restricted DMA pool
Message-ID: <20210310160747.GA29834@willie-the-truck>
References: <20210209062131.2300005-1-tientzu@chromium.org>
 <20210209062131.2300005-14-tientzu@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210209062131.2300005-14-tientzu@chromium.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Claire,

On Tue, Feb 09, 2021 at 02:21:30PM +0800, Claire Chang wrote:
> Introduce the new compatible string, restricted-dma-pool, for restricted
> DMA. One can specify the address and length of the restricted DMA memory
> region by restricted-dma-pool in the reserved-memory node.
> 
> Signed-off-by: Claire Chang <tientzu@chromium.org>
> ---
>  .../reserved-memory/reserved-memory.txt       | 24 +++++++++++++++++++
>  1 file changed, 24 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/reserved-memory/reserved-memory.txt b/Documentation/devicetree/bindings/reserved-memory/reserved-memory.txt
> index e8d3096d922c..fc9a12c2f679 100644
> --- a/Documentation/devicetree/bindings/reserved-memory/reserved-memory.txt
> +++ b/Documentation/devicetree/bindings/reserved-memory/reserved-memory.txt
> @@ -51,6 +51,20 @@ compatible (optional) - standard definition
>            used as a shared pool of DMA buffers for a set of devices. It can
>            be used by an operating system to instantiate the necessary pool
>            management subsystem if necessary.
> +        - restricted-dma-pool: This indicates a region of memory meant to be
> +          used as a pool of restricted DMA buffers for a set of devices. The
> +          memory region would be the only region accessible to those devices.
> +          When using this, the no-map and reusable properties must not be set,
> +          so the operating system can create a virtual mapping that will be used
> +          for synchronization. The main purpose for restricted DMA is to
> +          mitigate the lack of DMA access control on systems without an IOMMU,
> +          which could result in the DMA accessing the system memory at
> +          unexpected times and/or unexpected addresses, possibly leading to data
> +          leakage or corruption. The feature on its own provides a basic level
> +          of protection against the DMA overwriting buffer contents at
> +          unexpected times. However, to protect against general data leakage and
> +          system memory corruption, the system needs to provide way to lock down
> +          the memory access, e.g., MPU.

As far as I can tell, these pools work with both static allocations (which
seem to match your use-case where firmware has preconfigured the DMA ranges)
but also with dynamic allocations where a 'size' property is present instead
of the 'reg' property and the kernel is responsible for allocating the
reservation during boot. Am I right and, if so, is that deliberate?

I ask because I think that would potentially be useful to us for the
Protected KVM work, where we need to bounce virtio memory accesses via
guest-determined windows because the guest memory is generally inaccessible
to the host. We've been hacking this using a combination of "swiotlb=force"
and set_memory_{decrypted,encrypted}() but it would be much better to
leverage the stuff you have here.

Also:

> +
> +		restricted_dma_mem_reserved: restricted_dma_mem_reserved {
> +			compatible = "restricted-dma-pool";
> +			reg = <0x50000000 0x400000>;
> +		};
>  	};
>  
>  	/* ... */
> @@ -138,4 +157,9 @@ one for multimedia processing (named multimedia-memory@77000000, 64MiB).
>  		memory-region = <&multimedia_reserved>;
>  		/* ... */
>  	};
> +
> +	pcie_device: pcie_device@0,0 {
> +		memory-region = <&restricted_dma_mem_reserved>;
> +		/* ... */
> +	};

I find this example a bit weird, as I didn't think we usually had DT nodes
for PCI devices; rather they are discovered as a result of probing config
space. Is the idea that you have one reserved memory region attached to the
RC and all the PCI devices below that share the region, or is there a need
for a mapping mechanism?

Will
