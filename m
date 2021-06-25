Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 258273B3AA0
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jun 2021 03:49:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232999AbhFYBve (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Jun 2021 21:51:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232917AbhFYBve (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jun 2021 21:51:34 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 395F4C061574;
        Thu, 24 Jun 2021 18:49:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
        Subject:Sender:Reply-To:Content-ID:Content-Description;
        bh=e1tpDeAEwxgZK2ZK4L54r7FiKBLJS+0x5+T+TRAyDls=; b=dIFI5qR6HvHwN0IAy0eWaLtPXl
        VXRz+Opl7Hpa9XMxRQ4ZBzjfsrKcZZqeLJzh2KkcA55im/iTcNKybVROCpUIOymB8BBxgTNSwd65R
        XghAtBk0UREhaJQidTG1jggYZnY9GzbHAaP3zwbmUwpiVb3Ybn8aB6IEX4SIBWHcKbbdyNgDsVdJu
        zwfQ22eXYShdzRwsygSQyHf+uvjjc8y9VRFy1f9cZTJ1E7QT9+7U6hg1Y6cpD5U2jhGxu1MzgFLWB
        w+L4RoT3CewrdPK2Bw0qaRc2B3lnQil4VQeKyW3Qw+KSU/fbfBdtm4xWunSZELFRlfKpMQEmh65TH
        8uPIuyrw==;
Received: from [2601:1c0:6280:3f0::aefb]
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1lwaxx-00H4DU-3G; Fri, 25 Jun 2021 01:49:09 +0000
Subject: Re: [PATCH v2] Documentation, dt, numa: Add note to empty NUMA node
To:     Gavin Shan <gshan@redhat.com>, devicetree@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, robh+dt@kernel.org,
        drjones@redhat.com, shan.gavin@gmail.com
References: <20210625020322.43825-1-gshan@redhat.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <834b6b3a-c56b-b8e3-f401-30fdc689d6a2@infradead.org>
Date:   Thu, 24 Jun 2021 18:49:08 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210625020322.43825-1-gshan@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/24/21 7:03 PM, Gavin Shan wrote:
> The empty NUMA nodes, where no memory resides in, are allowed. For
> these empty NUMA nodes, the 'len' of 'reg' property is zero. These
> empty NUMA node IDs are still valid and parsed. I finds difficulty
> to get where it's properly documented.
> 
> So lets add note to empty NUMA nodes in the NUMA binding doc.
> 
> Signed-off-by: Gavin Shan <gshan@redhat.com>
> ---
> v2: Update to address Randy's comments

Hi Gavin,

Sorry, there has been some misunderstanding. Please see below.


> ---
>  Documentation/devicetree/bindings/numa.txt | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/numa.txt b/Documentation/devicetree/bindings/numa.txt
> index 21b35053ca5a..08e361f9954c 100644
> --- a/Documentation/devicetree/bindings/numa.txt
> +++ b/Documentation/devicetree/bindings/numa.txt
> @@ -109,6 +109,10 @@ Example:
>  Dual socket system consists of 2 boards connected through ccn bus and
>  each board having one socket/soc of 8 cpus, memory and pci bus.
>  
> +Note that the empty NUMA nodes, which no memory resides in period, are

In patch v1, this was:

  +Note that the empty NUMA nodes, which no memory resides in, are allowed 

and I said:

  Missing period at end of the sentence above.

What I meant by that was "Missing 'period' ('.') punctuation at the end
of the sentence above. So it should simply be changed to:


  +Note that the empty NUMA nodes, which no memory resides in, are allowed.



> +allowed. Their NUMA node IDs are still valid so that memory can be added
> +into these NUMA nodes through hotplug afterwards.
> +
>  	memory@c00000 {
>  		device_type = "memory";
>  		reg = <0x0 0xc00000 0x0 0x80000000>;

Sorry about the confusion.
