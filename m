Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C71BC39110E
	for <lists+linux-kernel@lfdr.de>; Wed, 26 May 2021 08:55:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232922AbhEZG5R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 May 2021 02:57:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232678AbhEZG5O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 May 2021 02:57:14 -0400
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8520FC061756
        for <linux-kernel@vger.kernel.org>; Tue, 25 May 2021 23:55:43 -0700 (PDT)
Received: by mail-pg1-x531.google.com with SMTP id m124so121850pgm.13
        for <linux-kernel@vger.kernel.org>; Tue, 25 May 2021 23:55:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fRNt3yDJdpwTK9bRPuQ1aGtN7MrbvWxWH2kT5DYkn8M=;
        b=bwbkdTgWaocp3VjWgxBOJan5QzGkWRCklR8q67slhSVry4VknFHRa22TBs9SVNCwd+
         yXo+6iBxC4cj429zKPhNRHBSK30y9WFUC0PcchVBDTXR65lpST9hpnYGgr8cNGfDntzS
         pvUVAdspJHOo3AR4Lkk81TYSvkjPX8rlFBjtc22G3tfT9/xrqVX497jKMutKHg8fOcGJ
         L6B5NTmE6L3Sa8jW2JUdLah7zGSimlTf/kLurw8DRlE9lQQ5WVhS6e6dAnZab3OWYtFr
         iExmrIW2Wlv8MzJBREArwZF890xQcFhXDj4ja+wZibkEW4WygvpodX01GjANQwxyiiYf
         wgDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fRNt3yDJdpwTK9bRPuQ1aGtN7MrbvWxWH2kT5DYkn8M=;
        b=FfCcxTXNiAIG+q38BOkYu3S0f+T3X7l70Ng41KZtHXu5eWRxdT2ADLsEZS9TQ2+eJG
         4hLsFKN+3fYjnlqes2Clio4/w5OQofgIjw+VgfxTxw3q/8hDane0BicSShuiDQqyRVLw
         A2FyecM1teHk6VHYC4AqS8W4/4Z2p3eSMjdteE3CCNgjllwoQqUFbCE9tS8GnqN9bAqs
         apTnvfrChxNWOVQiLY2s4KIvD8y28SHUe+xlBG//wdpTPnpOZFjpQkxOhQUlslS+934o
         9Aw7VNHqfUwfS78x6Q1qQxrSWtvfsvkREDJ64iAwhwWjbQLIPf3L+fiRMggeQjJlF1VU
         HvOQ==
X-Gm-Message-State: AOAM533IB/gmc4EfhILv9w5H3MAOyoOirDr6T8yCqY2J4+EvkE+q2zY4
        KMo8acjKCPjHPAAXDnqFcVPWlofwbP7ML5kOBuNfuw==
X-Google-Smtp-Source: ABdhPJxW+w+xCRsWQj5SiE05rhMKrZut4HzNjipHDanV+PDJc9s1hbQA5gWFyIPc/QGNfTN9KZTftQygzBUk2c+lCLU=
X-Received: by 2002:a65:61a8:: with SMTP id i8mr23255331pgv.271.1622012142943;
 Tue, 25 May 2021 23:55:42 -0700 (PDT)
MIME-Version: 1.0
References: <20210424004645.3950558-1-seanjc@google.com> <20210424004645.3950558-16-seanjc@google.com>
In-Reply-To: <20210424004645.3950558-16-seanjc@google.com>
From:   Reiji Watanabe <reijiw@google.com>
Date:   Tue, 25 May 2021 23:55:27 -0700
Message-ID: <CAAeT=Fx4a406d5pfquWPTt4hPHxLu+iZnM=JiKuudZd04sgxgA@mail.gmail.com>
Subject: Re: [PATCH 15/43] KVM: x86: Set BSP bit in reset BSP vCPU's APIC base
 by default
To:     Sean Christopherson <seanjc@google.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 23, 2021 at 5:50 PM Sean Christopherson <seanjc@google.com> wrote:
>
> Set the BSP bit appropriately during local APIC "reset" instead of
> relying on vendor code to clean up at a later point.  This is a step
> towards consolidating the local APIC, VMX, and SVM xAPIC initialization
> code.
>
> Signed-off-by: Sean Christopherson <seanjc@google.com>

Reviewed-by: Reiji Watanabe <reijiw@google.com>
