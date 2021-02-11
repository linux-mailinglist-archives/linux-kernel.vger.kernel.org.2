Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA2D53186AB
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Feb 2021 10:15:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229946AbhBKJCU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Feb 2021 04:02:20 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:49072 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229938AbhBKI6M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Feb 2021 03:58:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1613033892;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=GUxj7277CqOjx0CBHzOaHRlV6qbv/MC2NWGltcghRDE=;
        b=VDv/y+gN0F7Yx6NWSKtWQ4r8Go+osq7G0qsd9RkZIEslBHiuQlAwmq4+fO4tGPmRQ4ZpzK
        z+6tt6eYrQzYpxAoaNlONWTWMK7nDysnFlXb9QarVJ3s+v2pfqTuaTUbJJDSnwJ7sgO3XI
        o/Zn0GGUo3zAuasFttLXPqQ5HHsBAV0=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-180-XABQDFcBP7iP53Rcjhw06g-1; Thu, 11 Feb 2021 03:58:10 -0500
X-MC-Unique: XABQDFcBP7iP53Rcjhw06g-1
Received: by mail-wm1-f71.google.com with SMTP id t128so2211957wmg.4
        for <linux-kernel@vger.kernel.org>; Thu, 11 Feb 2021 00:58:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=GUxj7277CqOjx0CBHzOaHRlV6qbv/MC2NWGltcghRDE=;
        b=sW71bpy7p9+mr3ZWuNCFPjFPjhaxaHNnYZNL1ql+Wr4kO4AJGn0z7pSon7TQ4CGR44
         6hc2TMM0k/xSlLg/l/MIX/5jTJ3j4B7hUHJJHY868ceszUkHCgoUSGiMpIGaP+JM6Yxw
         YTYvcjy/5pldUJD+bwImDjisu2p9L9i3U8HjuTVaCDnXtPtxfVEboZsLSTSfpnxOgW5x
         qDd6+vyRR83RBgZorK4C+yTVIz6GFVtrOwqUo7n2ATDNKCLrlKuzvgOnftLD7nOwYAiA
         IbJcEmS4aCM0WuZyVN/d9BA/PgnR5/nLb77dIjh26zjXisxLcy+JzxllNx/3+hjAPaDL
         x4Hg==
X-Gm-Message-State: AOAM53283qpA3+O5modh7L3uRL+WvuhIFa4E4SfVdG49ztFIy+I+R2GA
        t3ljEbshNSNt9mnC7plv+O466qESaJEVs+qyWCEh2d0cDdINKBypnmsQLXMr/t24U8U+UIbVJb3
        1QbwZdoRsCYuqv87eG2t+7/Sz
X-Received: by 2002:a05:600c:4ec6:: with SMTP id g6mr4100355wmq.2.1613033888840;
        Thu, 11 Feb 2021 00:58:08 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyK1/8aVu2WYOl7zLZ5yMObIdtUFQQl74YoKXEmxfZLkmUMMpqDzTqh0qEx/atPIppVPOvBZA==
X-Received: by 2002:a05:600c:4ec6:: with SMTP id g6mr4100340wmq.2.1613033888693;
        Thu, 11 Feb 2021 00:58:08 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:c8dd:75d4:99ab:290a? ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
        by smtp.gmail.com with ESMTPSA id o124sm8905080wmo.41.2021.02.11.00.58.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 Feb 2021 00:58:07 -0800 (PST)
Subject: Re: [RESEND PATCH ] KVM: VMX: Enable/disable PML when dirty logging
 gets enabled/disabled
To:     Sean Christopherson <seanjc@google.com>,
        Makarand Sonare <makarandsonare@google.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        pshier@google.com, jmattson@google.com,
        Ben Gardon <bgardon@google.com>
References: <20210210212308.2219465-1-makarandsonare@google.com>
 <YCSRSiSNErkC6+9R@google.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <ce9b7902-cf3b-3572-dcb9-a0442687dc84@redhat.com>
Date:   Thu, 11 Feb 2021 09:58:06 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <YCSRSiSNErkC6+9R@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/02/21 03:07, Sean Christopherson wrote:
>> Tested:
>> 	kvm-unit-tests
>> 	dirty_log_test
>> 	dirty_log_perf_test
> Eh, I get that we like these for internal tracking, but for upstream there's an
> assumption that you did your due diligence.  If there's something noteworthy
> about your testing (or lack thereof), throw it in the cover letter or in the
> part that's not recorded in the final commit.
> 

I actually don't mind it and I should do it myself as well.  Sure for 
large series it's better to put it just once in the cover letter, but 
for small submissions such as this one it's not a problem.

Paolo

