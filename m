Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 57C433B3CFB
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jun 2021 09:02:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229531AbhFYHEr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Jun 2021 03:04:47 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:31646 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229437AbhFYHEn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jun 2021 03:04:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1624604542;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Wk4gJrvVmFJkUUV0V+8tjI0BeJ/S5lprpVx2BaJWvxE=;
        b=gqyyfbAb2NgpDF/hGNXUqJ6FK0CVEkjFNq5UZdi0alkoD4nvlgQmFMqVlI2Q4uXz377Af6
        +gg9uGH91RUp3SAVRmx5pDQrQci/u3oc9WDTEKYv/aiQ4x/kNZtb+sCmBFi+jExwUf/CxH
        P8RfzSAbuWEc3iEA/9VxDQ1Fp2vX+0A=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-151-Y3HvfNbcMTmVh2N4D06Vpw-1; Fri, 25 Jun 2021 03:02:21 -0400
X-MC-Unique: Y3HvfNbcMTmVh2N4D06Vpw-1
Received: by mail-ej1-f69.google.com with SMTP id q14-20020a1709066aceb029049fa6bee56fso2719915ejs.21
        for <linux-kernel@vger.kernel.org>; Fri, 25 Jun 2021 00:02:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Wk4gJrvVmFJkUUV0V+8tjI0BeJ/S5lprpVx2BaJWvxE=;
        b=V5poZWdz+sWgA2PLE6OvI83TCWT3m4GO0lekFFrtMfp0WLurBXmzzrR6M0QvYVfKMb
         FV6KbN58/RFFmBWsxxU1yblHi0+26p58jvUrO1mDa+3dQLUlLmU6HPWYrUJ4PzBSJEAO
         NVbanOa2YB+tdazncQu/TB6/ovgBUH2sRYQ93GSt86wVjJMiiACX/zPWv1JsK5VaEBgy
         3I+bQZk0Rri2uP0zvwEfQXa9JWsgg9QH3HecrP+z4RfQxsgeieyCs7RcQrgJ6/ieknUw
         QkVnZ0Kn2R848wRBwAgsA0e30n0+geMRg7G82MzDLo7rHepqZGwlZ/aZkiRTYs3e3lUB
         zxQg==
X-Gm-Message-State: AOAM530T4m3wOP2K2+wgNkcb6ifSLdafggcwq152HHebybsWadvgIqqU
        C3zDYSw0KPD5vZ5qGTletIyWZrvfotBNHfznbxSN0XyGk5ntAj1HD7DhA3DNqBpmQHyJirvDns7
        o6Jqwe5ZyPb7SP6GnNytJjodV
X-Received: by 2002:a50:8dc6:: with SMTP id s6mr12618440edh.50.1624604540082;
        Fri, 25 Jun 2021 00:02:20 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxLZ1E0ag2fxZhez+/apF5lYTGyruCtFj2/grYppl3iqtimvhupRWwcMIgagBLs1nWLMWQjCA==
X-Received: by 2002:a50:8dc6:: with SMTP id s6mr12618408edh.50.1624604539896;
        Fri, 25 Jun 2021 00:02:19 -0700 (PDT)
Received: from gator (cst2-174-132.cust.vodafone.cz. [31.30.174.132])
        by smtp.gmail.com with ESMTPSA id f20sm162281ejl.41.2021.06.25.00.02.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Jun 2021 00:02:19 -0700 (PDT)
Date:   Fri, 25 Jun 2021 09:02:17 +0200
From:   Andrew Jones <drjones@redhat.com>
To:     Gavin Shan <gshan@redhat.com>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        rdunlap@infradead.org, robh+dt@kernel.org, shan.gavin@gmail.com
Subject: Re: [PATCH v4] Documentation, dt, numa: Add note to empty NUMA node
Message-ID: <20210625070217.4ffmfe7nwlusbbjc@gator>
References: <20210625052338.4875-1-gshan@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210625052338.4875-1-gshan@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 25, 2021 at 01:23:38PM +0800, Gavin Shan wrote:
> The empty memory nodes, where no memory resides in, are allowed.
> For these empty memory nodes, the 'len' of 'reg' property is zero.
> The NUMA node IDs are still valid and parsed, but memory can be
> added to them through hotplug afterwards. I finds difficulty to
> get where it's properly documented.
> 
> So lets add note to empty memory nodes in the NUMA binding doc.
> 
> Signed-off-by: Gavin Shan <gshan@redhat.com>
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

Please change the second sentence to:

  The NUMA node IDs in these empty memory nodes are still valid and
  memory may be added into them through hotplug afterwards.

But, this doesn't look like the right place for this paragraph. You're
adding the paragraph to the example section, but the example doesn't have
any empty memory nodes.

I think the paragraph should be added to section "2 - numa-node-id" and an
example empty memory node should be provided. Also, the commit message
talks about the length of 'reg' being zero, which is an important
distinction which should also be documented.

Thanks,
drew

> +
>  	memory@c00000 {
>  		device_type = "memory";
>  		reg = <0x0 0xc00000 0x0 0x80000000>;
> -- 
> 2.23.0
> 

