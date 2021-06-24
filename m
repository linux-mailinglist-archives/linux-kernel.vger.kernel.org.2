Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 552EC3B24CB
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jun 2021 04:14:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229926AbhFXCQs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Jun 2021 22:16:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229774AbhFXCQr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jun 2021 22:16:47 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37ADEC061574;
        Wed, 23 Jun 2021 19:14:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
        Subject:Sender:Reply-To:Content-ID:Content-Description;
        bh=ciibjgKEUw5oVm1s7IvRP6GwfSSYvy16GrUGFqaBAYk=; b=bBjOkXyjyHGpA0N6Qg8AbwxVaj
        eFmTRJ0wrI7LhrZpld7JSAhj0xQz7qmNJNngrExcB76d88Wvz/TGuEc71pTF1FHvTBEMeq5fTYK+L
        L2FoOALhGZHZOrXeoYpvkSWs6opa7QiGrZovGD6kfzRTo2K1A1/cXQb0IjWXKGOTq0CBLqxQvPEkz
        zH+wofl2IklRF/fLrencRXMydHeCN75RorvYBKMLsuEmmetPtsp9edqQw3h/kIrflmoEPeXnqacbr
        LEgsz/SOZtTFKQDEQOjC3CwkCGTGMWYG9E2/0sx/QYUwE+CBLQ1RKpkyq5iAYVP3QMJLkkjpeCzmE
        egXhOulw==;
Received: from [2601:1c0:6280:3f0::aefb]
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1lwEsr-00CPFB-GT; Thu, 24 Jun 2021 02:14:25 +0000
Subject: Re: [PATCH] Documentation, dt, numa: Add note to empty NUMA node
To:     Gavin Shan <gshan@redhat.com>, devicetree@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, robh+dt@kernel.org,
        drjones@redhat.com, shan.gavin@gmail.com
References: <20210624033740.20862-1-gshan@redhat.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <a6cdc518-3bd7-2b66-acd0-c4d53d360eae@infradead.org>
Date:   Wed, 23 Jun 2021 19:14:21 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210624033740.20862-1-gshan@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/23/21 8:37 PM, Gavin Shan wrote:
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
> index 21b35053ca5a..c564705c0eac 100644
> --- a/Documentation/devicetree/bindings/numa.txt
> +++ b/Documentation/devicetree/bindings/numa.txt
> @@ -109,6 +109,10 @@ Example:
>  Dual socket system consists of 2 boards connected through ccn bus and
>  each board having one socket/soc of 8 cpus, memory and pci bus.
>  
> +Note that the empty NUMA nodes, which no memory resides in, are allowed

Missing period at end of the sentence above.

> +Their NUMA node IDs are still valid so that memory can be added into these
> +NUMA nodes through hotplug afterwards.
> +
>  	memory@c00000 {
>  		device_type = "memory";
>  		reg = <0x0 0xc00000 0x0 0x80000000>;


thanks.
