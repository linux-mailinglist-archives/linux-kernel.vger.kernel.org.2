Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E34630714A
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jan 2021 09:20:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232014AbhA1IS6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jan 2021 03:18:58 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:42464 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231725AbhA1ISE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jan 2021 03:18:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1611821799;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=pQjhFF8PA9KgrrHABCtOSMHOQHZwwUG/J8Os5OD+Pxg=;
        b=EhUJsx3UYfjnMP6vAE6OxQQC9eMnjd9mcwFMXh54VPJ0af1YEDB0h5pbYGyRFhhRwIKrdL
        aBBLe//v0C9WFM8ezx0vQ/L6YEXDOOzQ6sXxfWUaLUNhybQ1XW/DJFI3th2yVXv2FSmF5S
        o0FK6+AOI/4U4KnBkuS+o5vQEIF20rk=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-574-1_fRnnoJPMKnLzFb6zk1BQ-1; Thu, 28 Jan 2021 03:16:37 -0500
X-MC-Unique: 1_fRnnoJPMKnLzFb6zk1BQ-1
Received: by mail-ej1-f70.google.com with SMTP id ar27so709207ejc.22
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jan 2021 00:16:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=pQjhFF8PA9KgrrHABCtOSMHOQHZwwUG/J8Os5OD+Pxg=;
        b=BQbIujgMGWOdQc498tbIDp6+tsg34F2DDZ2ub0POu4Pl2uWmo8Cs/4LRdxtuhCKGe1
         +hjW/jw7+tXTkS2vuVeocZztL/5hro2q+x9UnzBRgwo3reb+B2U4HMBGnNfWXiABF+Kr
         W2JtN59Y9wPS2prE6tE+wxMluR/PWWJ+UcbCGHQlhz9g8OBbH9/WRMA4CiX/1GUCKBC5
         PQOz2+A8ssBUCgJ2sRJLMyqG1gADZipbVxPvvoBYS9Wgpai5B3rFANRcCTCBDGHb1R0/
         8MFxIDS0Z7BZVbNcj7QaZQqrt/3kNaw4M+QkHXkeVS8RLHf5piG3oamaulvYHpfvXbQ0
         0Hhg==
X-Gm-Message-State: AOAM533I72qK7lJls40owIqWbNSCvfzmzf5H3KUaLFCqZLNsUwf/ttI+
        0TQW5VbTmkHKPpDw+5Scw5XnAA2jFVT2XWCmJ6QeLEpeSHRI3I0WQB3TMQPqv70DfATKr8rMzZu
        Dq8H11Zpe4LgCmqv47+E9KQRarLRpPbVDnK9gAua72Cx2dDBGWXBOAqCOQmSfYNKK4D9Tcky2Pb
        SV
X-Received: by 2002:a17:906:e106:: with SMTP id gj6mr9622386ejb.337.1611821794856;
        Thu, 28 Jan 2021 00:16:34 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwLuNIFyC7TLo0nrn4d8vGNT4D7BktAvk9O6gTR9IZCzuzI9c/ieVRS9b86mNYO///7R1HwVw==
X-Received: by 2002:a17:906:e106:: with SMTP id gj6mr9622375ejb.337.1611821794649;
        Thu, 28 Jan 2021 00:16:34 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:c8dd:75d4:99ab:290a? ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
        by smtp.gmail.com with ESMTPSA id h16sm2722046edw.34.2021.01.28.00.16.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 Jan 2021 00:16:33 -0800 (PST)
Subject: Re: [PATCH] KVM: Documentation: Fix documentation for nested.
To:     Yu Zhang <yu.c.zhang@linux.intel.com>, kvm@vger.kernel.org
Cc:     corbet@lwn.net, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20210128154747.4242-1-yu.c.zhang@linux.intel.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <1b5cf1ea-0ae9-acc2-d92f-c2f2da75f82f@redhat.com>
Date:   Thu, 28 Jan 2021 09:16:32 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <20210128154747.4242-1-yu.c.zhang@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28/01/21 16:47, Yu Zhang wrote:
> Nested VMX was enabled by default in commit <1e58e5e59148> ("KVM:
> VMX: enable nested virtualization by default"), which was merged
> in Linux 4.20. This patch is to fix the documentation accordingly.
> 
> Signed-off-by: Yu Zhang <yu.c.zhang@linux.intel.com>
> ---
>   Documentation/virt/kvm/nested-vmx.rst            | 6 ++++--
>   Documentation/virt/kvm/running-nested-guests.rst | 2 +-
>   2 files changed, 5 insertions(+), 3 deletions(-)
> 
> diff --git a/Documentation/virt/kvm/nested-vmx.rst b/Documentation/virt/kvm/nested-vmx.rst
> index 6ab4e35..ac2095d 100644
> --- a/Documentation/virt/kvm/nested-vmx.rst
> +++ b/Documentation/virt/kvm/nested-vmx.rst
> @@ -37,8 +37,10 @@ call L2.
>   Running nested VMX
>   ------------------
>   
> -The nested VMX feature is disabled by default. It can be enabled by giving
> -the "nested=1" option to the kvm-intel module.
> +The nested VMX feature is enabled by default since Linux kernel v4.20. For
> +older Linux kernel, it can be enabled by giving the "nested=1" option to the
> +kvm-intel module.
> +
>   
>   No modifications are required to user space (qemu). However, qemu's default
>   emulated CPU type (qemu64) does not list the "VMX" CPU feature, so it must be
> diff --git a/Documentation/virt/kvm/running-nested-guests.rst b/Documentation/virt/kvm/running-nested-guests.rst
> index d0a1fc7..bd70c69 100644
> --- a/Documentation/virt/kvm/running-nested-guests.rst
> +++ b/Documentation/virt/kvm/running-nested-guests.rst
> @@ -74,7 +74,7 @@ few:
>   Enabling "nested" (x86)
>   -----------------------
>   
> -From Linux kernel v4.19 onwards, the ``nested`` KVM parameter is enabled
> +From Linux kernel v4.20 onwards, the ``nested`` KVM parameter is enabled
>   by default for Intel and AMD.  (Though your Linux distribution might
>   override this default.)
>   
> 

Queued, thanks.

Paolo

