Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0598539A0DA
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Jun 2021 14:29:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230145AbhFCMa6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Jun 2021 08:30:58 -0400
Received: from mail-ot1-f42.google.com ([209.85.210.42]:36591 "EHLO
        mail-ot1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229958AbhFCMa5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Jun 2021 08:30:57 -0400
Received: by mail-ot1-f42.google.com with SMTP id h24-20020a9d64180000b029036edcf8f9a6so5563495otl.3
        for <linux-kernel@vger.kernel.org>; Thu, 03 Jun 2021 05:28:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JSAZo468btl5h+81ZQoc4rkUXIfRohA0D+Skemi7f4c=;
        b=t1mX+FKgztbD8cgqo/Mg/kcb27HWRN9xEUYJIg7MFBt7Xd8kAL1hv0pAP9aVpGwqen
         ApMh6K4D+miy3e1EltFIBV+Go0k029IIm0OTYwaMcUK3xCr13mSVu6JUz44Po+XF3VvK
         MZDSnBN/FW1MaFlb1XMscH1rXBqTTFQ1g3HK89SOvdeLF5x1iOl36ZZoLU9cc1JEOiQ9
         3/55OA/DjB/djZ9L743CHJ9T0pFjavAyh3vCVkZEthIVHuFsEoH18/ILX9XAUTMGh/HL
         CxOpV3Y2/r2sF32BNuqA3NYoi7pQTTydW3U9sRvfZncqUJPt1nI+dQ5jK4cU/zQ+TSv3
         zMcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JSAZo468btl5h+81ZQoc4rkUXIfRohA0D+Skemi7f4c=;
        b=kwLJloOli6o7RcCat4UG75OPCfBJ603oIw/Mkn9jQoKLr0TzYzWq8bOtAa1KnMu6Wj
         N5tjm7VgxExEkKJx+oZptb5+dyOcg+Nfyx4wPRZPYw99JySup1+1ONXIkdI/eJ+moUOr
         KWBoOZvlR7HAq5LAhgc4bBjWkftIooysxXIRJH2QiTaqWvZcKXZOze7P5BaRDItRsieB
         Q+GWayfhAccxWi9wLooYkW1Xhx0lT/zcWAuWGngQdOpINtj63XXin5jtD07pKPR1tfcG
         PtQQ/tuNSKljDeTzG/S6CLo2z9XnA7yA4VeU9Jw5fJJpMwlbz4GuZ3IupinI8QBaxMXf
         aVpA==
X-Gm-Message-State: AOAM531AGWaYRSPHjXhQpYjzxaSeXtCzB+CBAEqvuQanTlCccV7+BJ4O
        xH8O9bHz3thUVmjnst4b1jTHTZvzVk5bT0B6d/ySdw==
X-Google-Smtp-Source: ABdhPJyfqTh3RyhrbLLKVaZQU6m2lY60v3CeuzincqeamG/lTK7kAUd8htUpZgRW5aEBnKXf/RquiYR9w1cIeTkKj+0=
X-Received: by 2002:a9d:131:: with SMTP id 46mr30430846otu.241.1622723278062;
 Thu, 03 Jun 2021 05:27:58 -0700 (PDT)
MIME-Version: 1.0
References: <1622710841-76604-1-git-send-email-wanpengli@tencent.com> <1622710841-76604-2-git-send-email-wanpengli@tencent.com>
In-Reply-To: <1622710841-76604-2-git-send-email-wanpengli@tencent.com>
From:   Jim Mattson <jmattson@google.com>
Date:   Thu, 3 Jun 2021 05:27:46 -0700
Message-ID: <CALMp9eSK-_xOp=WdRbOOHaHHMHuJkPhG+7h4M+_+=4d-GCNzwA@mail.gmail.com>
Subject: Re: [PATCH 2/2] KVM: LAPIC: reset TMCCT during vCPU reset
To:     Wanpeng Li <kernellwp@gmail.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        kvm list <kvm@vger.kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <seanjc@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Joerg Roedel <joro@8bytes.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 3, 2021 at 2:01 AM Wanpeng Li <kernellwp@gmail.com> wrote:
>
> From: Wanpeng Li <wanpengli@tencent.com>
>
> The value of current counter register after reset is 0 for both Intel
> and AMD, let's do it in kvm.
>
> Signed-off-by: Wanpeng Li <wanpengli@tencent.com>

How did we miss that?

Reviewed-by: Jim Mattson <jmattson@google.com>
