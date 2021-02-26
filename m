Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C6421325E99
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Feb 2021 09:05:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230139AbhBZIE6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Feb 2021 03:04:58 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:60731 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229967AbhBZIEy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Feb 2021 03:04:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1614326607;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=CPnOIjDZYXeNRWYCqamKS1PZpsu8x/uzl+V1b5s0iw8=;
        b=BZSHbEZE68hT/ROjjh3a1cSxuLRGw58wT1ftsx4SsffG4Jbm9pEFk4Vt7jgw/Hv3u0M4fY
        5NnvFunoK4wf9XStGUBZ6Yhls62wc+BwvrcNbV3Vg7Hc7agQGK59P4mV49DfgvPcli+3M6
        mYhkqE4yilODuHZ1ez1CpTefs9EzVi8=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-67-PJrbYlAbNVOZrpE2dGF2ug-1; Fri, 26 Feb 2021 03:03:25 -0500
X-MC-Unique: PJrbYlAbNVOZrpE2dGF2ug-1
Received: by mail-ed1-f71.google.com with SMTP id m1so4119846edv.12
        for <linux-kernel@vger.kernel.org>; Fri, 26 Feb 2021 00:03:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=CPnOIjDZYXeNRWYCqamKS1PZpsu8x/uzl+V1b5s0iw8=;
        b=kyGpfqBmcBFBs+gqSqJsZl9b90V6VMWP6incm+r0GcsgXdZSa60h2Wbc6nkeuNyjPp
         5lPV5R0E/90cVVM2nAsLwChu1vdl7R6Yjs3pQ3GzoKZWjCE3UEwG1lXe1pruuNzB6efR
         Hs++8kugChU95mi0RUvWt4PGjlTp6LffYHMZzbGNlgKanqYtbPbJfYlIVB7O3YhimiaK
         0COMFaWkkzeAZdCQs/y2qTJDtF1QbMCXMQGAslvKkPYMP5yx2ukamEq4LUlwQo/m6KI9
         d5qgpAKrqG9WLZnDAftlSTLMebGXIJfx5qKnlsu4JOeT5Ka2uyHuPGgQJz5+3knmm4pf
         yjTw==
X-Gm-Message-State: AOAM531N9The47ubWKTKkJw4CfBSEUflbpZExcIyiMhZW8nCfuDWBHvG
        RpLmsGFZpY+jg80cTtgut2nOhqV+JicuE879S1XT7zYp2hhTcQUziUYiXaogub8jxBcfLOT24SL
        V5DaGvfRmPU0KSWkb9FIlhm+rUSOAotV4q4U7t63QxElKjj9kIZ4017eXmCEnBFSYyzPOGOPpLL
        tf
X-Received: by 2002:a17:906:bc85:: with SMTP id lv5mr1985205ejb.412.1614326603185;
        Fri, 26 Feb 2021 00:03:23 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzx4ypKh5EdCVtEubF3HXKELpdlAIDE42Z3LFmZxc9/XlfnJVuK8HdKXKabBE/JYJ4o3+hSJw==
X-Received: by 2002:a17:906:bc85:: with SMTP id lv5mr1985186ejb.412.1614326603008;
        Fri, 26 Feb 2021 00:03:23 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:c8dd:75d4:99ab:290a? ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
        by smtp.gmail.com with ESMTPSA id i7sm5113867edq.87.2021.02.26.00.03.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 26 Feb 2021 00:03:22 -0800 (PST)
Subject: Re: [PATCH] KVM: Documentation: rectify rst markup in kvm_run->flags
To:     Chenyi Qiang <chenyi.qiang@intel.com>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Jonathan Corbet <corbet@lwn.net>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20210226075541.27179-1-chenyi.qiang@intel.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <3461a412-f214-fb75-3b82-97466aca03f4@redhat.com>
Date:   Fri, 26 Feb 2021 09:03:21 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <20210226075541.27179-1-chenyi.qiang@intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26/02/21 08:55, Chenyi Qiang wrote:
> Commit c32b1b896d2a ("KVM: X86: Add the Document for
> KVM_CAP_X86_BUS_LOCK_EXIT") added a new flag in kvm_run->flags
> documentation, and caused warning in make htmldocs:
> 
>    Documentation/virt/kvm/api.rst:5004: WARNING: Unexpected indentation
>    Documentation/virt/kvm/api.rst:5004: WARNING: Inline emphasis start-string without end-string
> 
> Fix this rst markup issue.
> 
> Signed-off-by: Chenyi Qiang <chenyi.qiang@intel.com>
> ---
>   Documentation/virt/kvm/api.rst | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/virt/kvm/api.rst b/Documentation/virt/kvm/api.rst
> index aed52b0fc16e..0717bf523034 100644
> --- a/Documentation/virt/kvm/api.rst
> +++ b/Documentation/virt/kvm/api.rst
> @@ -5000,7 +5000,8 @@ local APIC is not used.
>   	__u16 flags;
>   
>   More architecture-specific flags detailing state of the VCPU that may
> -affect the device's behavior. Current defined flags:
> +affect the device's behavior. Current defined flags::
> +
>     /* x86, set if the VCPU is in system management mode */
>     #define KVM_RUN_X86_SMM     (1 << 0)
>     /* x86, set if bus lock detected in VM */
> 

Queued, thanks.

Paolo

