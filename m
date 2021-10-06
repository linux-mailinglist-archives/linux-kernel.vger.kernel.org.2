Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E531D423FE1
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Oct 2021 16:11:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238768AbhJFONG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Oct 2021 10:13:06 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:30339 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231540AbhJFONE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Oct 2021 10:13:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1633529472;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Xy5RlYEymjHYhlTWwEGYUp75qVXWvZYvAwlzU8nRwYE=;
        b=KaPSFrTPLvzhSPpPW/cDlHijUZc8+hlt0Al9I4B/604f7dmhXKAu7KKIqVoMf2yKpWhf4O
        YoKm+lJT4fbhoCgY4mAKg9DA4ISwjm1t6H76QqZDoB7HTI9207Z/JnQHjhNA20of8KShHZ
        JrY4hJL8wiTLqKU15NaMOYIdOP14z2A=
Received: from mail-ot1-f72.google.com (mail-ot1-f72.google.com
 [209.85.210.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-237-HmvIHqUtP76eSo49qhIr5Q-1; Wed, 06 Oct 2021 10:11:11 -0400
X-MC-Unique: HmvIHqUtP76eSo49qhIr5Q-1
Received: by mail-ot1-f72.google.com with SMTP id b7-20020a0568301de700b0054e351e751aso71838otj.11
        for <linux-kernel@vger.kernel.org>; Wed, 06 Oct 2021 07:11:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Xy5RlYEymjHYhlTWwEGYUp75qVXWvZYvAwlzU8nRwYE=;
        b=7+yicqRTd+wEVX04wvzOKZ1cCa3S0zWA56icziWCO+Ge37vJWCW5CIEQNjsO/vtDBL
         xRMCAUiK6UoHg8vg0R5In0oYNvavWa9i+S9ODyjkuAQR9ayKehzg1TleWJwlRZMnO+i5
         /HUyhE3MYEaExZpoPEaggdyHFNEqUXsVprVAPJoIYrHTxVywNY5pfSZmGhbgNp2Vk9As
         5p5mD6WH5QRHPPZRVCDTEvBEG/CqaTJE6YlENYSldhO6tkOCQmb00B/f7wKyk3Qrib4d
         eJeHVM4P8z0iRVa4xHp3Ybkt2k8Cg2u3lLuIu74nkSai4XAb99PVIA1aK2/+jW39cc8P
         MQ2A==
X-Gm-Message-State: AOAM530jZUFtPAx9UANHPLs/HmO8Tec7w/XHl0RYrRWpF+TOu1EQIw39
        KQVLitkCfOdD+Qrcw7fNZ9QZf6ANMNjvVmGRIAd2bw8FZlz0OSLLqDBpW98yJ7SvPtOZysxpqcw
        hud0T4sCnW9gUigBh+ST99M4y
X-Received: by 2002:a54:4799:: with SMTP id o25mr7399253oic.90.1633529470331;
        Wed, 06 Oct 2021 07:11:10 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJynhZ1smlMQdEfQrCtrXOQZRjyieymRWXcbQ4mnTNDnk2g1VaYvZkd2FcoTkv0m6/3IlBFQxg==
X-Received: by 2002:a54:4799:: with SMTP id o25mr7399215oic.90.1633529470068;
        Wed, 06 Oct 2021 07:11:10 -0700 (PDT)
Received: from treble ([2600:1700:6e32:6c00::49])
        by smtp.gmail.com with ESMTPSA id e2sm4289367otk.46.2021.10.06.07.11.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Oct 2021 07:11:09 -0700 (PDT)
Date:   Wed, 6 Oct 2021 07:11:05 -0700
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Borislav Petkov <bp@alien8.de>
Cc:     "Kuppuswamy, Sathyanarayanan" 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, x86@kernel.org,
        Paolo Bonzini <pbonzini@redhat.com>,
        David Hildenbrand <david@redhat.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Juergen Gross <jgross@suse.com>, Deep Shah <sdeep@vmware.com>,
        VMware Inc <pv-drivers@vmware.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, Peter H Anvin <hpa@zytor.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Kirill Shutemov <kirill.shutemov@linux.intel.com>,
        Sean Christopherson <seanjc@google.com>,
        Kuppuswamy Sathyanarayanan <knsathya@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v8 03/11] x86/cpufeatures: Add TDX Guest CPU feature
Message-ID: <20211006141105.offh3fqhyupzqs7v@treble>
References: <20211005025205.1784480-1-sathyanarayanan.kuppuswamy@linux.intel.com>
 <20211005025205.1784480-4-sathyanarayanan.kuppuswamy@linux.intel.com>
 <20211005210423.yfftpxxmj3cjprtv@treble>
 <15a07997-2659-6be1-b8a3-da57e72562b5@linux.intel.com>
 <20211006034218.ynamwigsvpgad7sr@treble>
 <f15d1b41-e4fb-0203-88f7-dbac3f4e5307@linux.intel.com>
 <20211006050309.ldn5myznmpurnomm@treble>
 <YV2a7h5AKCcTQLsT@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YV2a7h5AKCcTQLsT@zn.tnic>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 06, 2021 at 02:47:42PM +0200, Borislav Petkov wrote:
> On Tue, Oct 05, 2021 at 10:03:09PM -0700, Josh Poimboeuf wrote:
> > I'm not suggesting getting rid of the feature flag.  I'm suggesting
> > getting rid of the global variable.  Is there a reason you can't check
> > the feature flag instead of checking the global variable?
> 
> The reason is that cc_platform_has() is used too early, even before
> get_cpu_cap(). So you need to have TDX guest detected even before
> feature flags.

Ok.  At least it sounds like cc_platform_has() needs a comment stating
that caps can't be relied on, and why.

-- 
Josh

