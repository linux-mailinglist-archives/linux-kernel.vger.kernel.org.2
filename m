Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F06E3A2F5D
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jun 2021 17:31:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231622AbhFJPdp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Jun 2021 11:33:45 -0400
Received: from mail-pg1-f182.google.com ([209.85.215.182]:37687 "EHLO
        mail-pg1-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231356AbhFJPdo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jun 2021 11:33:44 -0400
Received: by mail-pg1-f182.google.com with SMTP id t9so70205pgn.4
        for <linux-kernel@vger.kernel.org>; Thu, 10 Jun 2021 08:31:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Rk5wfRvJVKJdMnbOaJy4V5qWnwJU3HYRmmh+2TN5+1k=;
        b=As6FMwpWU+r0zvLETxnPGn4GsPMXpNUhxyGinqEO5adiLVQ/ovYPPNOqEwv9jI+I4s
         zZGL/6j2yPbdHQxChQSOyvTTRtn7F081Q85lIQnmFq8/h079N6OAILgWMfDBy9INkyr0
         XwUmLz+RXJ7lsEaOyRZRul76gQhuTRKK/zEVteWMmp6AZ/K6ryN9dN8Tvwxdw/A0UKq8
         7rZkFoRyTpRrC/BOzjjzjMWC+aMY48cccETE7N91gcNzHtAzb8dc3vKXUtjgYw6oHNey
         +B42lHcrRZLLYoLZakIOa5JMbE+cVuiSFqD46OBDRNmyYRfuKcdoASKbq3o+D4MFE5AB
         9sqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Rk5wfRvJVKJdMnbOaJy4V5qWnwJU3HYRmmh+2TN5+1k=;
        b=Yn1M+QwLCdHRv6JCl90OvAXQJ1ZMpr1WgRMDtaN/MWmfvh3Y1IOYNhoOGlx+eJdY4C
         wp7n/+Y1zZf9LHlx7A1+kd7651WxKSeHJ1a9MakkkHSeCoYBStVwZolkUC2uVjkqrM6P
         fHDnIsROHkzaRZIkSoJtVGMDgZpPUy76VbUcV0w5gRduackGBq0F4m+OaMgoee8CwY16
         2333XOaY6YS2YbqWIOxyHlljl2l7VnpPDKoKJdiXFwcKmU0/5y/gn+d+hbC44+iQJ8Tr
         qHozO5GAVLGpDgezPzBKCV+EtQjh6TBmMulAk7S7gNbWQUgR+oXJ4ml3EBOhJPCnKltJ
         cJiQ==
X-Gm-Message-State: AOAM531GF1A9/j3UL0mZQVagcx1K5v4J7934Ao9POeAGRp9n8iCIZ4p6
        GBmRREetQ/tncVBs9La70WVxjw==
X-Google-Smtp-Source: ABdhPJyO4WF/eusmKVpie/u9Ap8R+gQWZfdzUbiZxiWBJOG3QfBVrCBQK4y81moCl0Mu/g5SSXf0jg==
X-Received: by 2002:a63:5553:: with SMTP id f19mr5341596pgm.419.1623339036001;
        Thu, 10 Jun 2021 08:30:36 -0700 (PDT)
Received: from google.com (157.214.185.35.bc.googleusercontent.com. [35.185.214.157])
        by smtp.gmail.com with ESMTPSA id 18sm2704883pfx.71.2021.06.10.08.30.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Jun 2021 08:30:35 -0700 (PDT)
Date:   Thu, 10 Jun 2021 15:30:31 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Vitaly Kuznetsov <vkuznets@redhat.com>
Cc:     Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        syzbot+fb0b6a7e8713aeb0319c@syzkaller.appspotmail.com,
        Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH 2/9] KVM: x86: Emulate triple fault shutdown if RSM
 emulation fails
Message-ID: <YMIwF/so0I+w60kt@google.com>
References: <20210609185619.992058-1-seanjc@google.com>
 <20210609185619.992058-3-seanjc@google.com>
 <87eedayvkn.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87eedayvkn.fsf@vitty.brq.redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 10, 2021, Vitaly Kuznetsov wrote:
> why don't we have triple fault printed in trace by default BTW???

Or maybe trace_kvm_make_request()?  Not sure how much pain that would inflict on
the binaries though.
