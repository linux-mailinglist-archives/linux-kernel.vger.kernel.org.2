Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 10B39400337
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Sep 2021 18:25:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349954AbhICQ0E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Sep 2021 12:26:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235480AbhICQ0D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Sep 2021 12:26:03 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 182E2C061757
        for <linux-kernel@vger.kernel.org>; Fri,  3 Sep 2021 09:25:03 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id r13so4657685pff.7
        for <linux-kernel@vger.kernel.org>; Fri, 03 Sep 2021 09:25:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=MuUVKGuzhcnw475fxR/h4MUJO7/8nCYvBhM/dqOqGY8=;
        b=a5qp69RtKWOpDgVoJpcbKeFp4fHb3dpctDXalKWvk9x0mZvk5wTr//5DY4W0LTXZ59
         vU5wMjKNFAB0/sDDpjwVsbJ4UXu/E2SC9wtVAJILZ1WqCW57WPTvS811boyUOcKLnupz
         I2kI7S/7Jx+p7ysFlAQ8Bk0f32XV/Wgfd5pc2KNXWsbPFtW/zZzsLy+9AIBf3ax5Whe4
         ainrZ1m/2ggdSr2qgoL9bZdwdbT8xhMYN2ptG6vhbY6UwyHgNzZF0m2p2aU2S7yS3Ud6
         QZLl3jg1c50P5Qdz/R9pcZQm507HQ549CZa8imyuzhAyXGSpxkZVOZ79HKfZakgPHrm3
         PE7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=MuUVKGuzhcnw475fxR/h4MUJO7/8nCYvBhM/dqOqGY8=;
        b=oDFjFMGSUTxPTFK0EV4uCzp/cSWnubZEFNAAT3GJebDo6JRDSlS+vGC5qvaXJ1DIWZ
         Q7RrGfvMZU3OHs+hsCiwIRNVvBjyk6nidbXFBfh8JwVk8n4cEJbXJlAYLYIzQUYbNd2c
         eKLPmkQy/LaxIsPqjz7/N0NURH5DXYTn2yNwleQBqJgEEh9AhMZrwvT2uaXLFTptouDx
         83uKeGv80UwpPzBMt+GIQKGSWAzn+M8RPP2Wqb/rwaHjX3xI2hYln/6/lZCnm68YJawm
         Vjv2mnlhBv59IKH/jOiLKI0rdvJ4BBqcDOpCCf/PtMtUMe4dvO9daVxMGDddZv61CAPT
         it+w==
X-Gm-Message-State: AOAM532GGGynnYIwbwurYQqDUBzywtt2BD7zxUD7tM27KBfQqGi3XT1w
        9rK/tAzqkcHGNxgDmrUze2xL6w==
X-Google-Smtp-Source: ABdhPJwopWhVnbj64wyd76GFU8+hftQz9LsUECQ7yePVtwZeoENrkbJy4he1stiIW/KKmLPf5rlayA==
X-Received: by 2002:a65:63d0:: with SMTP id n16mr4261048pgv.432.1630686302332;
        Fri, 03 Sep 2021 09:25:02 -0700 (PDT)
Received: from google.com (157.214.185.35.bc.googleusercontent.com. [35.185.214.157])
        by smtp.gmail.com with ESMTPSA id q18sm6086348pfj.46.2021.09.03.09.25.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Sep 2021 09:25:01 -0700 (PDT)
Date:   Fri, 3 Sep 2021 16:24:57 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Vitaly Kuznetsov <vkuznets@redhat.com>
Cc:     kvm@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
        Nitesh Narayan Lal <nitesh@redhat.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Maxim Levitsky <mlevitsk@redhat.com>,
        Eduardo Habkost <ehabkost@redhat.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 7/8] KVM: Pre-allocate cpumasks for
 kvm_make_all_cpus_request_except()
Message-ID: <YTJMWaMGcaSwkwn3@google.com>
References: <20210903075141.403071-1-vkuznets@redhat.com>
 <20210903075141.403071-8-vkuznets@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210903075141.403071-8-vkuznets@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 03, 2021, Vitaly Kuznetsov wrote:
> Allocating cpumask dynamically in zalloc_cpumask_var() is not ideal.
> Allocation is somewhat slow and can (in theory and when CPUMASK_OFFSTACK)
> fail. kvm_make_all_cpus_request_except() already disables preemption so
> we can use pre-allocated per-cpu cpumasks instead.
> 
> Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
> ---

Reviewed-by: Sean Christopherson <seanjc@google.com>
