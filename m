Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C0233BD86A
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jul 2021 16:38:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232476AbhGFOku (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jul 2021 10:40:50 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:31413 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232320AbhGFOkn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jul 2021 10:40:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1625582284;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=l5bV/gA0yAQFqvV1OT7l8CWzwMSmZ2Sm1npnLyvfAVM=;
        b=A8sCO8R3Vio3oniFxAK7DNtw6y7aq1xIbb5fznqnHHblVEfVM6Hdw9nvVwGMFTYsUWpBrK
        VkIf1IIsrBko5WU1Y43pzMIfPfZZqED64I/wKPzBNnci95Od/nNvfx8rssSaK3SdZxsiYs
        4w1VSanvVw0y9NHE3/ujultMtod+vNc=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-170-jvaKCCA0OJKc_T1s-cTxEg-1; Tue, 06 Jul 2021 10:23:52 -0400
X-MC-Unique: jvaKCCA0OJKc_T1s-cTxEg-1
Received: by mail-ej1-f70.google.com with SMTP id ia10-20020a170907a06ab02904baf8000951so4293768ejc.10
        for <linux-kernel@vger.kernel.org>; Tue, 06 Jul 2021 07:23:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=l5bV/gA0yAQFqvV1OT7l8CWzwMSmZ2Sm1npnLyvfAVM=;
        b=KfGfbaK807+y8KDgE3utwgXi5FvPgc9h/SiUMiywQQl4JA7Jd+a69lJiNslhDfJ5zY
         s+DK2M4MM+WVRKOOLxc63RGBcG5yVayL654umGCQlMaqOzNu7EZy2Pho4jb4Y4IQnO+z
         Zn2rds65O/z+0X28Kzu11VJBWRzDex3RUNgiWAiQry6ZmsqZVNasDMTfaZo8UaA/WPtS
         hp8pOh5nb3GKbdepjC6hgVXbsK+Aey7u5klnYpL1NI2RRma8AZyLEZT3cQjdjtI2fqyF
         2lF4Upk0TmyP0d7ztBmzpHoU9QU4HH3dEjqLYwrXvSgrSOKJuArR/7O0jzkB4j1gHZfq
         1wOQ==
X-Gm-Message-State: AOAM531SLdYUMEXUsgWeKjilKKZr6m44jxMSmaLL1uwSOnSAMhkie1EX
        E+XGg4FwBC+Mr3cB1i9wmzXdYUSoZ/8bI7i6F5h4Yu57Rr113XwnUZWAv+xoA3186k6C5kr0aeI
        LAqLp6/ZMp2ZgySG9A4eBSNdA
X-Received: by 2002:a05:6402:2552:: with SMTP id l18mr23785155edb.363.1625581431395;
        Tue, 06 Jul 2021 07:23:51 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzk71oCS3Req1hJz1CsO2d2aGknmMOi/chnxeB2jmEtLJf/dO/zM5zYF8qLk5DNx8SdQ8itSQ==
X-Received: by 2002:a05:6402:2552:: with SMTP id l18mr23785097edb.363.1625581431075;
        Tue, 06 Jul 2021 07:23:51 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:c8dd:75d4:99ab:290a? ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
        by smtp.gmail.com with ESMTPSA id mm27sm5752133ejb.67.2021.07.06.07.23.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 06 Jul 2021 07:23:50 -0700 (PDT)
Subject: Re: [RFC PATCH v2 68/69] KVM: TDX: add document on TDX MODULE
To:     isaku.yamahata@intel.com, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, erdemaktas@google.com,
        Connor Kuehl <ckuehl@redhat.com>,
        Sean Christopherson <seanjc@google.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc:     isaku.yamahata@gmail.com
References: <cover.1625186503.git.isaku.yamahata@intel.com>
 <b5d0446fedfe5d47a8aa5e623f39cb04d62837ce.1625186503.git.isaku.yamahata@intel.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <636f315e-f1d0-0e2c-849c-b7f393da2bc9@redhat.com>
Date:   Tue, 6 Jul 2021 16:23:49 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <b5d0446fedfe5d47a8aa5e623f39cb04d62837ce.1625186503.git.isaku.yamahata@intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/07/21 00:05, isaku.yamahata@intel.com wrote:
> From: Isaku Yamahata <isaku.yamahata@intel.com>
> 
> Add a document on how to integrate TDX MODULE into initrd so that
> TDX MODULE can be updated on kernel startup.
> 
> Signed-off-by: Isaku Yamahata <isaku.yamahata@intel.com>
> ---
>   Documentation/virt/kvm/tdx-module.rst | 48 +++++++++++++++++++++++++++
>   1 file changed, 48 insertions(+)
>   create mode 100644 Documentation/virt/kvm/tdx-module.rst
> 
> diff --git a/Documentation/virt/kvm/tdx-module.rst b/Documentation/virt/kvm/tdx-module.rst
> new file mode 100644
> index 000000000000..8beea8302f94
> --- /dev/null
> +++ b/Documentation/virt/kvm/tdx-module.rst
> @@ -0,0 +1,48 @@
> +.. SPDX-License-Identifier: GPL-2.0
> +
> +==========
> +TDX MODULE
> +==========
> +
> +Integrating TDX MODULE into initrd
> +==================================
> +If TDX is enabled in KVM(CONFIG_KVM_INTEL_TDX=y), kernel is able to load
> +tdx seam module from initrd.
> +The related modules (seamldr.ac, libtdx.so and libtdx.so.sigstruct) need to be
> +stored in initrd.
> +
> +tdx-seam is a sample hook script for initramfs-tools.
> +TDXSEAM_SRCDIR are the directory in the host file system to store files related
> +to TDX MODULE.
> +
> +Since it heavily depends on distro how to prepare initrd, here's a example how
> +to prepare an initrd.
> +(Actually this is taken from Documentation/x86/microcode.rst)
> +::
> +  #!/bin/bash
> +
> +  if [ -z "$1" ]; then
> +      echo "You need to supply an initrd file"
> +      exit 1
> +  fi
> +
> +  INITRD="$1"
> +
> +  DSTDIR=lib/firmware/intel-seam
> +  TMPDIR=/tmp/initrd
> +  LIBTDX="/lib/firmware/intel-seam/seamldr.acm /lib/firmware/intel-seam/libtdx.so /lib/firmware/intel-seam/libtdx.so.sigstruct"
> +
> +  rm -rf $TMPDIR
> +
> +  mkdir $TMPDIR
> +  cd $TMPDIR
> +  mkdir -p $DSTDIR
> +
> +  cp ${LIBTDX} ${DSTDIR}
> +
> +  find . | cpio -o -H newc > ../tdx-seam.cpio
> +  cd ..
> +  mv $INITRD $INITRD.orig
> +  cat tdx-seam.cpio $INITRD.orig > $INITRD
> +
> +  rm -rf $TMPDIR
> 

I think this belongs in a different series that adds SEAM loading?

Paolo

