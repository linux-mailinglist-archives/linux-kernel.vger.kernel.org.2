Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5086139B014
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Jun 2021 03:55:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230092AbhFDB4x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Jun 2021 21:56:53 -0400
Received: from mga03.intel.com ([134.134.136.65]:1994 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229576AbhFDB4w (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Jun 2021 21:56:52 -0400
IronPort-SDR: 3XnTYcmaQXOXeoxoe61ium6nHmJkVUFErW3Q4kNd4smIa/MZgi5XvM7jVEFDyFY/aO0tV0n6WL
 k4O9YqEpmUvA==
X-IronPort-AV: E=McAfee;i="6200,9189,10004"; a="204229355"
X-IronPort-AV: E=Sophos;i="5.83,246,1616482800"; 
   d="scan'208";a="204229355"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jun 2021 18:54:58 -0700
IronPort-SDR: GIuUhVXRQGGXpdsR8TZ9byLZ0RpOG9Jow67XS70dt0XTNpfjTOwpdL3cfgXqwC33OJXkMLPV2G
 TVxuxMDYq99g==
X-IronPort-AV: E=Sophos;i="5.83,246,1616482800"; 
   d="scan'208";a="550918837"
Received: from akleen-mobl1.amr.corp.intel.com (HELO [10.209.7.237]) ([10.209.7.237])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jun 2021 18:54:56 -0700
Subject: Re: [PATCH v1 1/8] virtio: Force only split mode with protected guest
To:     Andy Lutomirski <luto@kernel.org>, mst@redhat.com
Cc:     Jason Wang <jasowang@redhat.com>,
        virtualization@lists.linux-foundation.org, hch@lst.de,
        m.szyprowski@samsung.com, robin.murphy@arm.com,
        iommu@lists.linux-foundation.org,
        the arch/x86 maintainers <x86@kernel.org>,
        sathyanarayanan.kuppuswamy@linux.intel.com,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20210603004133.4079390-1-ak@linux.intel.com>
 <20210603004133.4079390-2-ak@linux.intel.com>
 <cc5c8265-83f7-aeb1-bc30-3367fe68bc97@kernel.org>
 <a0e66b4c-cec5-2a26-9431-d5a21e22c8f2@linux.intel.com>
 <2b2dec75-a0c1-4013-ac49-a49f30d5ac3c@www.fastmail.com>
 <3159e1f4-77cd-e071-b6f2-a2bb83cfc69a@linux.intel.com>
 <b8b39b76-8d07-4e4a-804a-746269787b61@www.fastmail.com>
 <884f34e0-fcd2-bb82-9e9e-4269823fa9b2@linux.intel.com>
 <308e7187-1ea7-49a7-1083-84cf8654f52a@kernel.org>
From:   Andi Kleen <ak@linux.intel.com>
Message-ID: <d3bf637e-556a-be48-39f9-dc7defd19092@linux.intel.com>
Date:   Thu, 3 Jun 2021 18:54:54 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.2
MIME-Version: 1.0
In-Reply-To: <308e7187-1ea7-49a7-1083-84cf8654f52a@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> For most Linux drivers, a report that a misbehaving device can corrupt
> host memory is a bug, not a feature.  If a USB device can corrupt kernel
> memory, that's a serious bug.  If a USB-C device can corrupt kernel
> memory, that's also a serious bug, although, sadly, we probably have
> lots of these bugs.  If a Firewire device can corrupt kernel memory,
> news at 11.  If a Bluetooth or WiFi peer can corrupt kernel memory,
> people write sonnets about it and give it clever names.  Why is virtio
> special?

Well for most cases it's pointless because they don't have any memory 
protection anyways.

Why break compatibility if it does not buy you anything?

Anyways if you want to enable the restricted mode for something else, 
it's easy to do. The cases where it matters seem to already work on it, 
like the user space virtio ring.

My changes for boundary checking are enabled unconditionally anyways, as 
well as the other patchkits.


>
> This one:
>
> int arch_has_restricted_virtio_memory_access(void)
> +{
> +	return is_tdx_guest();
> +}
>
> I'm looking at a fairly recent kernel, and I don't see anything for s390
> wired up in vring_use_dma_api.

It's not using vring_use_dma_api, but enforces the DMA API at virtio 
ring setup time, same as SEV/TDX.

-Andi

