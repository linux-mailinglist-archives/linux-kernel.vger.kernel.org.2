Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 033AE41C0EF
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Sep 2021 10:45:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244883AbhI2Irb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Sep 2021 04:47:31 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:50897 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S244764AbhI2Ir3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Sep 2021 04:47:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1632905148;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Gvu4L83YOBGLGvWqLGUuGEaO/DEUZyEQ1rFR5bn6b8M=;
        b=JX8sXbowIGFwf7cZnZnH3wolVvbBg/04UwcHDM4LArKbK7y5RdnLF7GKBfNlCIqxj7WeYb
        EJQIzjv+Oko8xuDDKM8M1tO52KUIC4K0DaVpqAhlyP0JmqIwixnUFtYcSt5jJSOtPXDc77
        LK4n2WibCqgob34LQwQqKU6A/2Ads4g=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-554-pIse04O-ONC7fIlFfR5meg-1; Wed, 29 Sep 2021 04:45:47 -0400
X-MC-Unique: pIse04O-ONC7fIlFfR5meg-1
Received: by mail-wm1-f71.google.com with SMTP id c77-20020a1c9a50000000b0030d06638a56so1988399wme.9
        for <linux-kernel@vger.kernel.org>; Wed, 29 Sep 2021 01:45:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=Gvu4L83YOBGLGvWqLGUuGEaO/DEUZyEQ1rFR5bn6b8M=;
        b=dkOI81gzprHvw5+syo7nzJ0+Uy5cj74cbqAE7D5z82RBFypxkETnwstXzakMGRmUmL
         R12mpbb3XZt7RGloxqd9OhncR4z6UO4ozHXOjMW/2C2v3Ml9yo7srpvOlUG9qeorX/sl
         OyRYORt6WhA6p0P1jeINIwQgRz/BBawsY6yA7PhTM0YpBmsTjh2tJ7EPtVRIeIrW16/Z
         t0fgcibCDdr6a/P6tQ/SUYJf0Ncw3wtH02vZcp2WOMJSBPZr04ktXp/uElMlEWn7VGu9
         0L1i1XRB9ZKreU+c9yqbR6wiojO4St9DMZiGptkwiKwCUID9rbSUK4yzyxZdqk5QHG9J
         malw==
X-Gm-Message-State: AOAM532vp9EwEDl1jiOyC1dJEjpbWGzuy/bBZ2loWHEeWr7KTfbTkA9B
        tjvi9ihx7uvVQhxRx7ujjZ9D+rSddXoDGTcZSvwvYf7rJpt/wIuJU2f1WCL55s3851GiUILJSR0
        iraXVSbTVXi3TGWzPRlPqLGiw
X-Received: by 2002:a1c:7c0f:: with SMTP id x15mr8734498wmc.149.1632905146272;
        Wed, 29 Sep 2021 01:45:46 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyaikWIkzzrJGqHValULa/ZmnNfg4rl1LyjKqzMWVt+gz9mbskxaXhni5v3m042+vSd753h3g==
X-Received: by 2002:a1c:7c0f:: with SMTP id x15mr8734485wmc.149.1632905146123;
        Wed, 29 Sep 2021 01:45:46 -0700 (PDT)
Received: from [192.168.3.132] (p4ff23c3b.dip0.t-ipconnect.de. [79.242.60.59])
        by smtp.gmail.com with ESMTPSA id t126sm893773wma.4.2021.09.29.01.45.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Sep 2021 01:45:45 -0700 (PDT)
Subject: Re: [PATCH v1 2/8] x86/xen: simplify xen_oldmem_pfn_is_ram()
To:     Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        linux-kernel@vger.kernel.org
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, Juergen Gross <jgross@suse.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Dave Young <dyoung@redhat.com>, Baoquan He <bhe@redhat.com>,
        Vivek Goyal <vgoyal@redhat.com>,
        Michal Hocko <mhocko@suse.com>,
        Oscar Salvador <osalvador@suse.de>,
        Mike Rapoport <rppt@kernel.org>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, x86@kernel.org,
        xen-devel@lists.xenproject.org,
        virtualization@lists.linux-foundation.org,
        kexec@lists.infradead.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org
References: <20210928182258.12451-1-david@redhat.com>
 <20210928182258.12451-3-david@redhat.com>
 <4ab2f8c2-c3d5-30b3-a670-a8b38e218b6e@oracle.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Message-ID: <bfe72f46-9a0d-1a87-64bd-4b03999edd1e@redhat.com>
Date:   Wed, 29 Sep 2021 10:45:44 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <4ab2f8c2-c3d5-30b3-a670-a8b38e218b6e@oracle.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> 
> How about
> 
>      return a.mem_type != HVMMEM_mmio_dm;
> 

Ha, how could I have missed that :)

> 
> Result should be promoted to int and this has added benefit of not requiring changes in patch 4.
> 

Can we go one step further and do


@@ -20,24 +20,11 @@ static int xen_oldmem_pfn_is_ram(unsigned long pfn)
         struct xen_hvm_get_mem_type a = {
                 .domid = DOMID_SELF,
                 .pfn = pfn,
+               .mem_type = HVMMEM_ram_rw,
         };
-       int ram;
  
-       if (HYPERVISOR_hvm_op(HVMOP_get_mem_type, &a))
-               return -ENXIO;
-
-       switch (a.mem_type) {
-       case HVMMEM_mmio_dm:
-               ram = 0;
-               break;
-       case HVMMEM_ram_rw:
-       case HVMMEM_ram_ro:
-       default:
-               ram = 1;
-               break;
-       }
-
-       return ram;
+       HYPERVISOR_hvm_op(HVMOP_get_mem_type, &a);
+       return a.mem_type != HVMMEM_mmio_dm;
  }
  #endif


Assuming that if HYPERVISOR_hvm_op() fails that
.mem_type is not set to HVMMEM_mmio_dm.

-- 
Thanks,

David / dhildenb

