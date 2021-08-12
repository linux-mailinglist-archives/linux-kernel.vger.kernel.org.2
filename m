Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D9BC33EA93E
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Aug 2021 19:15:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235125AbhHLRPe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Aug 2021 13:15:34 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:36953 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234570AbhHLRPc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Aug 2021 13:15:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1628788506;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Hl2q/IBeDF11InTwkjo+Q88yO1GQYT5aRVKT9ieIQAI=;
        b=FT+ry8+qt1epauQX3tA7iZAI3cisYNrBewW2C/2M3Fd8o9ofEBJjAX2nKbT7u6wjpUuX8I
        2wCmA6OqgMHoqgVkJdLrBARE5hLgT0lcZDDoEIcNHw5lzpdU4FptFDdywwvTKQtMxWMiI7
        qMpaa5S8lnUxjZxOAbAk2H+xhlqoTSE=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-594-m95tS8d9ONu6M2gPJHwmIw-1; Thu, 12 Aug 2021 13:15:05 -0400
X-MC-Unique: m95tS8d9ONu6M2gPJHwmIw-1
Received: by mail-ej1-f69.google.com with SMTP id ja25-20020a1709079899b02905b2a2bf1a62so2087709ejc.4
        for <linux-kernel@vger.kernel.org>; Thu, 12 Aug 2021 10:15:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Hl2q/IBeDF11InTwkjo+Q88yO1GQYT5aRVKT9ieIQAI=;
        b=pAREIUL2bVXtm/LfHt9Uk3Phs9fob/hw6Fnc0CVeQE3OzyHOS0z/3qfkfywDNwrwnC
         uEMU+fHxK5CX5D1/BWQhtUo2xdWdIlQFvItmTD/ZYPgrQwBrA/twazZ5NNBLd9bNzJtt
         yUHtwzHjJ5V6el++lfDMCzPpGAXQNKu7EU3JQx8pafHvgHPlvi8ljUpt7Fyh8t3s8STd
         D5ofOBLWVW8/iA/oyeY+tv7fA0mD/LNPgOuEz5oI9aIOPah4evYyzGNSpZIGqDuy7/X6
         NEbQRXt43KVpQ578OorsJ6QKFhvEwZXyU8mH92c/2lXoyoQjvjvK0N68TNFQoiqY/RZa
         rGlg==
X-Gm-Message-State: AOAM531dd97HuPivjRvQ1lI7VSTPb7d88smETG+h8v+ggclLH2Ybgm1N
        aAokq74bv68pGO+w/E1gtdllhXWWjWMWCPFgBCaiv8R89Jp6T0/GJdtqUq7urxrrBFMgaugGaJb
        16DM3hv/yeg3bLjzysVHdhFX4cI2Tp5uyTF6t9pmCe0Kigogottqp6AskGqN/lqJRO4g9hs/MsY
        MH
X-Received: by 2002:a17:906:27c2:: with SMTP id k2mr4767566ejc.83.1628788503934;
        Thu, 12 Aug 2021 10:15:03 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyxEeKcRzmOwBpp9BraLT3nidE1aRoYWBwP+lWqClH2qMMa+9atOOooDHgiCXS/nS9PCTgByA==
X-Received: by 2002:a17:906:27c2:: with SMTP id k2mr4767524ejc.83.1628788503613;
        Thu, 12 Aug 2021 10:15:03 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:c8dd:75d4:99ab:290a? ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
        by smtp.gmail.com with ESMTPSA id n26sm1408416eds.63.2021.08.12.10.15.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Aug 2021 10:15:02 -0700 (PDT)
Subject: Re: [PATCH 2/2] KVM: x86/mmu: Don't step down in the TDP iterator
 when zapping all SPTEs
To:     Sean Christopherson <seanjc@google.com>,
        Ben Gardon <bgardon@google.com>
Cc:     Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm <kvm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
References: <20210812050717.3176478-1-seanjc@google.com>
 <20210812050717.3176478-3-seanjc@google.com>
 <CANgfPd8HSYZbqmi21XQ=XeMCndXJ0+Ld0eZNKPWLa1fKtutiBA@mail.gmail.com>
 <YRVVWC31fuZiw9tT@google.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <928be04d-e60e-924c-1f3a-cb5fef8b0042@redhat.com>
Date:   Thu, 12 Aug 2021 19:15:01 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <YRVVWC31fuZiw9tT@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/08/21 19:07, Sean Christopherson wrote:
> Yeah, I was/am on the fence too, I almost included a blurb in the cover letter
> saying as much.  I'll do that for v2 and let Paolo decide.

I think it makes sense to have it.  You can even use the ternary operator

	/*
	 * When zapping everything, all entries at the top level
	 * ultimately go away, and the levels below go down with them.
	 * So do not bother iterating all the way down to the leaves.
	 */
	int min_level = zap_all ? root->role.level : PG_LEVEL_4K;

Paolo

