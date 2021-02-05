Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F9BA3107D6
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Feb 2021 10:30:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230523AbhBEJ2B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Feb 2021 04:28:01 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:37946 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230177AbhBEJZP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Feb 2021 04:25:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1612517029;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=FkGj7z//CzVWjRN9C2HYvXgeUqNsaA9YYrEEEvxeE5U=;
        b=EJ8lSCgQ2psfPTLUm8lFpvxkVNLMT5QkXHMOz0FELnrRfSNLbZkzUTVenaM6hk50g4yf+u
        owVPpGvEttkqhSctfmEvYit0jLCs+II55KqsKnsWDi11ofe9n53PCHN7LHuzOicxfJmaCz
        l7vwdafUVhw3um/dUjR+EcYoMKCb8Ws=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-197-PEQVqGPpPFGXEEICdg4Qng-1; Fri, 05 Feb 2021 04:23:47 -0500
X-MC-Unique: PEQVqGPpPFGXEEICdg4Qng-1
Received: by mail-ed1-f71.google.com with SMTP id f4so6502553eds.5
        for <linux-kernel@vger.kernel.org>; Fri, 05 Feb 2021 01:23:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=FkGj7z//CzVWjRN9C2HYvXgeUqNsaA9YYrEEEvxeE5U=;
        b=g1vwF8+68fG+JUpue+9ulZUMVQ1U4wDtOGf7EVAl4TvlZK6sJ3mM0a6xvKDBxw2ep4
         ppgfFRZWUJZ4gIL0/ZozFVbnU3qGYvJiEQlmgijgjd7Ci4S913LBGzSIVchlxoT6ZWut
         cchSzWcwAxtK0m4/X02tEEq94Ckg2RVqJWhDeABSddkbtDczwHFjiyxXyFlqryOdoy3a
         aaZYgno/FCd0ePW80NKN700KnvvSjGZBNIpiRy8Qg4I+kbVnz7hGqx5bdmGGgavB/MCC
         Nsg29CNjEqCg6L4dnNlejExDWzpPB9J2yw5pkK2F96NKIZB+DYGz63qbsHQ1mSt+/rc/
         UVTg==
X-Gm-Message-State: AOAM5328rFuoltMQ2/H9SYy7RnAilY+zw08EAURvxgQHoz47XfvC5UZX
        nmfgkv9mpoYDyY2J1tOZGKVqrbIKh9QUHDxhsfX8Y/0PhEjtrpHF+fUWaCxH9Ri/UdTqJPdl97q
        ZDvjGLooKRTszFtyQw7djx+Tuhv5y4E5xIpW0t5xn0TQA1IrUkN5QBbJizUcp/CZ0XpNSyFQvwB
        Wh
X-Received: by 2002:a05:6402:31ae:: with SMTP id dj14mr2679105edb.364.1612517026108;
        Fri, 05 Feb 2021 01:23:46 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxwaOxnMgmRd1FH9QlvhwcxYAbQQGCrlD28vpdIaD0/S1MV/imltd7xAXtWyCQ5A8RzkVZZrw==
X-Received: by 2002:a05:6402:31ae:: with SMTP id dj14mr2679084edb.364.1612517025966;
        Fri, 05 Feb 2021 01:23:45 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:c8dd:75d4:99ab:290a? ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
        by smtp.gmail.com with ESMTPSA id k3sm3645996ejv.121.2021.02.05.01.23.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 05 Feb 2021 01:23:45 -0800 (PST)
Subject: Re: [PATCH v4 2/5] KVM: X86: Expose PKS to guest
To:     Chenyi Qiang <chenyi.qiang@intel.com>,
        Sean Christopherson <seanjc@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>,
        Xiaoyao Li <xiaoyao.li@intel.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20210205083706.14146-1-chenyi.qiang@intel.com>
 <20210205083706.14146-3-chenyi.qiang@intel.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <89c82d11-8206-1ad9-9dfd-666d34685109@redhat.com>
Date:   Fri, 5 Feb 2021 10:23:44 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <20210205083706.14146-3-chenyi.qiang@intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/02/21 09:37, Chenyi Qiang wrote:

> +	/*
> +	 * PKS is not yet implemented for shadow paging.
> +	 * If not support VM_{ENTRY, EXIT}_LOAD_IA32_PKRS,
> +	 * don't expose the PKS as well.
> +	 */
> +	if (enable_ept && cpu_has_load_ia32_pkrs())
> +		kvm_cpu_cap_check_and_set(X86_FEATURE_PKS);

This piece should be a separate patch, added after patch 4.

Paolo

