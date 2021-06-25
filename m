Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8EA283B3B4E
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jun 2021 05:47:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233095AbhFYDtq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Jun 2021 23:49:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233068AbhFYDto (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jun 2021 23:49:44 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29C6AC061574;
        Thu, 24 Jun 2021 20:47:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
        Subject:Sender:Reply-To:Content-ID:Content-Description;
        bh=XlZ/3rzzY7rPc2FtHStq/k//1hM/cEEnSyPTEf25P34=; b=Tjt98dozfSBm7/bzkAL1uWHL6T
        cCauF6Uxt6LMT7u4Pw0xLe3SOs46mDh2lyu5GACOnk0ni+LmjW01xw1sT/eFQpVDHSWt6Drpl1rBG
        gC/sjWgpWyxuHTIjFL1QL4flFaA9e6C49O79IzvyVzHI3jXUzelrILEQDDgVURlv0HysSMSYqXmNF
        /WOXTYFjTMmPUYGnZ3ZTeHJlz67xex7EcJadKLe31o1FwuTyCvF9yqFJWaK0iRQWV5kX7GH/QUYrF
        KNcaystELY4RtKT5n0rXS3lZb3hPjMKQrZ1670n4o7qgDgv/3saNUYAfqPzO6s9dTmug2IUBVjPEu
        3hAeMAiQ==;
Received: from [2601:1c0:6280:3f0::aefb]
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1lwcoK-00HCBG-75; Fri, 25 Jun 2021 03:47:20 +0000
Subject: Re: [PATCH v3] Documentation, dt, numa: Add note to empty NUMA node
To:     Gavin Shan <gshan@redhat.com>, devicetree@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, robh+dt@kernel.org,
        drjones@redhat.com, shan.gavin@gmail.com
References: <20210625043025.47469-1-gshan@redhat.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <874bcd17-29b6-658b-fa11-7854b1300d30@infradead.org>
Date:   Thu, 24 Jun 2021 20:47:19 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210625043025.47469-1-gshan@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/24/21 9:30 PM, Gavin Shan wrote:
> The empty NUMA nodes, where no memory resides in, are allowed. For
> these empty NUMA nodes, the 'len' of 'reg' property is zero. These
> empty NUMA node IDs are still valid and parsed. I finds difficulty
> to get where it's properly documented.
> 
> So lets add note to empty NUMA nodes in the NUMA binding doc.
> 
> Signed-off-by: Gavin Shan <gshan@redhat.com>
> ---
>  Documentation/devicetree/bindings/numa.txt | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/numa.txt b/Documentation/devicetree/bindings/numa.txt
> index 21b35053ca5a..edf728cff155 100644
> --- a/Documentation/devicetree/bindings/numa.txt
> +++ b/Documentation/devicetree/bindings/numa.txt
> @@ -109,6 +109,10 @@ Example:
>  Dual socket system consists of 2 boards connected through ccn bus and
>  each board having one socket/soc of 8 cpus, memory and pci bus.
>  
> +Note that the empty NUMA nodes, which no memory resides in, are allowed.

I would write that without "the":

+Note that empty NUMA nodes, which no memory resides in, are allowed.

BTW, AFAIK, NUMA nodes may contain memory, CPU(s), or I/O -- any one, two, or
three, without the other types of resources being present.


> +Their NUMA node IDs are still valid so that memory can be added into these
> +NUMA nodes through hotplug afterwards.
> +
>  	memory@c00000 {
>  		device_type = "memory";
>  		reg = <0x0 0xc00000 0x0 0x80000000>;


OT: is your system clock off by a couple of hours?
Your emails seem to be from in the future.

Thanks.

