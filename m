Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 02AC63BD7C1
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jul 2021 15:26:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231876AbhGFN2A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jul 2021 09:28:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:48278 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231415AbhGFN14 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jul 2021 09:27:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1625577917;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=C1B57ANHjAVcLhsuPRM1Y0QCiMQTnaCSGKrd9jRLx20=;
        b=I+WlJFlCUk0ai8EKaiIgWTGr8yqAaQaPUSqrJfV0HCHgwwzHwO6vtGmP8b2GYXv9/UraQA
        8Hr6P8BuwNWbgNeZuvL1CTqaHdK8siAkibduHv0RNBZ5wyRpgov601uRTMdYFYFfmmNfBk
        iwOwenloeXfjwgDJ1Qe8x5eIzOufF0s=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-489-cSJVVl4yMQeZ8fpCHRb2_g-1; Tue, 06 Jul 2021 09:25:16 -0400
X-MC-Unique: cSJVVl4yMQeZ8fpCHRb2_g-1
Received: by mail-ed1-f70.google.com with SMTP id i19-20020a05640200d3b02903948b71f25cso10785883edu.4
        for <linux-kernel@vger.kernel.org>; Tue, 06 Jul 2021 06:25:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=C1B57ANHjAVcLhsuPRM1Y0QCiMQTnaCSGKrd9jRLx20=;
        b=YQwhY4IXxK+E1/7So3hgaWfiBbFlqCPl/HOx/1ae3j5hk5VYjOp5cobnN4L8BfO2Qe
         Ozifn6rXWjNfkzfPvZY6sMURzV8lKLLoLy8EDHolwmUV/LOX+7UhnXQFWhlZ/C2M8/v+
         HfXdm4oTtT75QD/Hy1LRcFVvKrWbcltWUK95R2eXZX+QsQw8bV0pQazeKRpH8tpD/zBp
         ZbeFRkwoSVWgOEs00BpkuFOcXyuXyVlk5aqbCKzGlT1rhnwn6OM8FWBy3YALq4ialEMG
         OT50q36MhChjji/cGzvgOBaPh7jn3/R6fr2h1A9TEyjNO9eReN3vE02w+F7uiYv5hqRM
         f0TQ==
X-Gm-Message-State: AOAM532yGJYVBC5Gc2nrZHDcNalMvPnDbK5reXo7yleTFUr3xoz3re/e
        H5ThIIzxHIeYJnh1lfrbZKR/GnZ6/RMepBPU/5/pInGOUt1k4xFyTCRb1ufODdpsQYxSb/KWzpO
        dZiZfm8VzyHZYRqk3vhj/R1Q6
X-Received: by 2002:a17:907:2ce1:: with SMTP id hz1mr18090473ejc.376.1625577913309;
        Tue, 06 Jul 2021 06:25:13 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxCtSyy3u5ljkzgyVxAxYf8T/FFmYNUqZm5zTvUNc0dO7fNIv/sQ7Iu9O+LJl/9DMIgIAXOWQ==
X-Received: by 2002:a17:907:2ce1:: with SMTP id hz1mr18090134ejc.376.1625577909447;
        Tue, 06 Jul 2021 06:25:09 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:c8dd:75d4:99ab:290a? ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
        by smtp.gmail.com with ESMTPSA id gl26sm5713802ejb.72.2021.07.06.06.25.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 06 Jul 2021 06:25:08 -0700 (PDT)
Subject: Re: [RFC PATCH v2 09/69] KVM: TDX: Add C wrapper functions for TDX
 SEAMCALLs
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
Cc:     isaku.yamahata@gmail.com,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Kai Huang <kai.huang@linux.intel.com>,
        Xiaoyao Li <xiaoyao.li@intel.com>
References: <cover.1625186503.git.isaku.yamahata@intel.com>
 <96e4e50feee62f476f2dcf170d20f9267c7d7d6a.1625186503.git.isaku.yamahata@intel.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <597dcaf4-19c0-3507-ebfa-e07cb32f784c@redhat.com>
Date:   Tue, 6 Jul 2021 15:25:07 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <96e4e50feee62f476f2dcf170d20f9267c7d7d6a.1625186503.git.isaku.yamahata@intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/07/21 00:04, isaku.yamahata@intel.com wrote:
> +static inline u64 tdh_mng_addcx(hpa_t tdr, hpa_t addr)
> +{
> +	return seamcall(TDH_MNG_ADDCX, addr, tdr, 0, 0, 0, NULL);
> +}
> +

Since you have wrappers anyway, I don't like having an extra macro level 
just to remove the SEAMCALL_ prefix.  It messes up editors that look up 
the symbols.

Paolo

