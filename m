Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1E18D3893E5
	for <lists+linux-kernel@lfdr.de>; Wed, 19 May 2021 18:37:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355270AbhESQi4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 May 2021 12:38:56 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:58674 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1347383AbhESQiy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 May 2021 12:38:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1621442254;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=WZ5uWoy1UxuW2HCG2i+GDn7yK9hnNKwWkhoavaIlAUs=;
        b=gdm8GUFqu0r2cDcc0MlvCHYNETeZ+imHDqlu57/dzrmwNFcRVG1uVBopcocVVNH64B5q/1
        Rgvm/+OPOa3tUBmlVAUxCltkXn3pIHrYkHg/ariKWcR+r0jwKPObdgWtZY3QIRie9BqwgT
        9avpVRyPsecBWp5/VF3TrtwDwLkW0s8=
Received: from mail-oo1-f71.google.com (mail-oo1-f71.google.com
 [209.85.161.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-262--t7hPRU5MM21x-rnB7NH2g-1; Wed, 19 May 2021 12:37:26 -0400
X-MC-Unique: -t7hPRU5MM21x-rnB7NH2g-1
Received: by mail-oo1-f71.google.com with SMTP id n16-20020a0568200550b029020b438b2591so9428013ooj.19
        for <linux-kernel@vger.kernel.org>; Wed, 19 May 2021 09:37:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=WZ5uWoy1UxuW2HCG2i+GDn7yK9hnNKwWkhoavaIlAUs=;
        b=fVEKgSXJdp6g9AF0gbHAc6sVfudx/mqBb3l2ekZRuaQoGWYYiLlzUd49k5p+1X9nbD
         7mZ61JEoze2jU/cKHuB8U4RhmICbDuyGml2/5jhT/eLSRTQwrqq0cZRh86EWxPgojcxK
         CO0MhV1ilRqlJ4TwPHsvhnXbLjdAk6TPLGvCzt8VAZnnOORUvNsG12TDpyzkINNMB1Tm
         rAN76FGw40MQ1cgC/nOl0us7KTR6PFuIVWSpaUixO0beLdpA7Qo+2l9PCvnY9QDs1YL2
         c9DqnTnis/nF7gt4qOCR63aKKyvFU0Z7/xx5vyVL44G75HmG7xFN66FSa5uAFPtnuD/h
         heJw==
X-Gm-Message-State: AOAM532ILo3hXYsTU6YUpo/qLeCpDNg4DA3R+a0jbPfd2jXQJ4BOxtC9
        7kYP8j1kNAYUrmURBs5Hc/vVX/S2nYjvnnEoLPLgO/rXZsVDWnxcrDDDWNHfMMf230ipuJlxCrv
        Y7XEdjUXy0vXJuuHWwdW1OzLg
X-Received: by 2002:a4a:49c8:: with SMTP id z191mr167863ooa.62.1621442245943;
        Wed, 19 May 2021 09:37:25 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwT9Z7+BgF+Y4z9e/UaTaUStcmFjg7RSgwJ5ZdJxc6pmT9q2Q4v0VsHk1X24SzvGIkTyijfQQ==
X-Received: by 2002:a4a:49c8:: with SMTP id z191mr167834ooa.62.1621442245728;
        Wed, 19 May 2021 09:37:25 -0700 (PDT)
Received: from [192.168.0.173] (ip68-103-222-6.ks.ok.cox.net. [68.103.222.6])
        by smtp.gmail.com with ESMTPSA id g48sm45212otg.50.2021.05.19.09.37.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 May 2021 09:37:25 -0700 (PDT)
Subject: Re: [RFC PATCH 00/67] KVM: X86: TDX support
To:     isaku.yamahata@intel.com, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc:     isaku.yamahata@gmail.com
References: <cover.1605232743.git.isaku.yamahata@intel.com>
From:   Connor Kuehl <ckuehl@redhat.com>
Message-ID: <3edc0fb2-d552-88df-eead-9e2b80e79be4@redhat.com>
Date:   Wed, 19 May 2021 11:37:23 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <cover.1605232743.git.isaku.yamahata@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/16/20 12:25 PM, isaku.yamahata@intel.com wrote:
> From: Isaku Yamahata <isaku.yamahata@intel.com>
> 
> * What's TDX?
> TDX stands for Trust Domain Extensions which isolates VMs from
> the virtual-machine manager (VMM)/hypervisor and any other software on
> the platform. [1]
> For details, the specifications, [2], [3], [4], [5], [6], [7], are
> available.
> 
> 
> * The goal of this RFC patch
> The purpose of this post is to get feedback early on high level design
> issue of KVM enhancement for TDX. The detailed coding (variable naming
> etc) is not cared of. This patch series is incomplete (not working).
> Although multiple software components, not only KVM but also QEMU,
> guest Linux and virtual bios, need to be updated, this includes only
> KVM VMM part. For those who are curious to changes to other
> component, there are public repositories at github. [8], [9]

Hi,

I'm planning on reading through this patch set; but before I do, since
it's been several months and it's a non-trivially sized series, I just
wanted to confirm that this is the latest revision of the RFC that
you'd like comments on. Or, if there's a more recent series that I've
missed, I would be grateful for a pointer to it.

Thanks,

Connor

