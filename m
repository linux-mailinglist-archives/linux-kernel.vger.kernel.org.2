Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 12B413B3C40
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jun 2021 07:29:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233125AbhFYFbs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Jun 2021 01:31:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbhFYFbq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jun 2021 01:31:46 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7248BC061574;
        Thu, 24 Jun 2021 22:29:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
        Subject:Sender:Reply-To:Content-ID:Content-Description;
        bh=cLC98jiTPo1gha2IvZDXk9+JdpFRGnaI/CVGtq7Uo10=; b=VIfRY38T8ObhjQYAl4bld7vSFW
        WiE8Bveu99uFFz5keRNKhvsD1IZ/0YAledCW4anb30got1YzBhmtrN8SXCp+f8rqgz+gDTePEBaX1
        UQPy06n9v9shcCAEGQFTn/w24gNMd/n5vATugZEbKsgcUlA6bE+FGhFRpRGPktQOPx5bxA2Ew7B80
        2DJVEeDqHwnMRR68ZoT59LxqgudH5SyUzCJRuncwidyiwQIbG2gFGvUIGlqjdMeUDg3UGkHXO6bVl
        sYlljlvb5GOWDJZWVbbYHSogdVFbLXdL4DQdOEk0tZbfobdZ6L5/ygTcVR8raivaF2EAWrOOtMm1T
        eopo0KRA==;
Received: from [2601:1c0:6280:3f0::aefb]
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1lweP5-00HJQu-AJ; Fri, 25 Jun 2021 05:29:23 +0000
Subject: Re: [PATCH v4] Documentation, dt, numa: Add note to empty NUMA node
To:     Gavin Shan <gshan@redhat.com>, devicetree@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, robh+dt@kernel.org,
        drjones@redhat.com, shan.gavin@gmail.com
References: <20210625052338.4875-1-gshan@redhat.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <7cdbafb8-4c38-1aac-5362-25e27e1d13e4@infradead.org>
Date:   Thu, 24 Jun 2021 22:29:22 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210625052338.4875-1-gshan@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/24/21 10:23 PM, Gavin Shan wrote:
> The empty memory nodes, where no memory resides in, are allowed.
> For these empty memory nodes, the 'len' of 'reg' property is zero.
> The NUMA node IDs are still valid and parsed, but memory can be
> added to them through hotplug afterwards. I finds difficulty to
> get where it's properly documented.
> 
> So lets add note to empty memory nodes in the NUMA binding doc.
> 
> Signed-off-by: Gavin Shan <gshan@redhat.com>

Acked-by: Randy Dunlap <rdunlap@infradead.org>

Thanks.

> ---
>  Documentation/devicetree/bindings/numa.txt | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/numa.txt b/Documentation/devicetree/bindings/numa.txt
> index 21b35053ca5a..0fc882e44270 100644
> --- a/Documentation/devicetree/bindings/numa.txt
> +++ b/Documentation/devicetree/bindings/numa.txt
> @@ -109,6 +109,10 @@ Example:
>  Dual socket system consists of 2 boards connected through ccn bus and
>  each board having one socket/soc of 8 cpus, memory and pci bus.
>  
> +Note that empty memory nodes, which no memory resides in, are allowed.
> +The NUMA node IDs in these empty memory nodes are still valid, but
> +memory can be added into them through hotplug afterwards.
> +
>  	memory@c00000 {
>  		device_type = "memory";
>  		reg = <0x0 0xc00000 0x0 0x80000000>;
> 
