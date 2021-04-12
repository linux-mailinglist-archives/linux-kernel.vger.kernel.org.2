Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C2BF35D06C
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Apr 2021 20:34:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245054AbhDLSfG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Apr 2021 14:35:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237110AbhDLSfE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Apr 2021 14:35:04 -0400
Received: from mail-oi1-x22a.google.com (mail-oi1-x22a.google.com [IPv6:2607:f8b0:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 580E2C06174A
        for <linux-kernel@vger.kernel.org>; Mon, 12 Apr 2021 11:34:46 -0700 (PDT)
Received: by mail-oi1-x22a.google.com with SMTP id i3so14397999oik.7
        for <linux-kernel@vger.kernel.org>; Mon, 12 Apr 2021 11:34:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=B0snQNysZJ+eshswUbAATX3408PkT3sHTGisEmQRaBI=;
        b=IsdBy7Y/xmB8myrYlMcMiSwKQpCyqozNO016+uuiDGDNmjEQMQMtKQT1O+LeOkXvse
         J5dsvtTfRBQmpe1/98/Xr8lUlqaVQmFb3UTBov6DVfgEzz/Q+K5SscVQ0eYGManVVXz6
         7sa1XVPKwXBqF3rrdjoM68UcJ2BRZhds2SSqmeN1EZqjs9JHC6hCQ8dYalP9U5U0CDAo
         OdAZAi3C5IdcRVzjPg1oVHfDbUXyvNlPUYb4QbD036RCNftz6pTpjwGtQYag1mkJuniH
         5Pc4tjVgYjo6C7XSFUbsv/wm+clXa5+a8uXiKTOvSgRj5uY6jvHvcXD31msbwYm+a1ZU
         r1TQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=B0snQNysZJ+eshswUbAATX3408PkT3sHTGisEmQRaBI=;
        b=U3qWg+ju/EAisSUMbS5h5jCzJn0WdXBT2SHrBPtqYgREBZPp5WVxgOFczMazsLXnZb
         llwcZzOkdEsx5MrZT1clGCuIOenBea2cf2sklHK7t5xWgc6hPTQcsTBrJUL/PoEoAPSR
         KZlP5kInmbMbWXt0Dgp8wfgubY/tbh+LHrngvzx8ZHjoeCJZ+st/6YxYFrdspH/0174G
         ReVzqVPsXR9fl9odFUK44zevn1CFAySKOvJclSqwyE3d09/lxn0b9EPEA+Nj9DMwkNcX
         Iw7aJPPz7RwSlmw5x0MiZ/TjgpZty5GmRwmDEEYhwMpMmUdX5qgXOZRj0hwKaJSH3T0C
         JOdg==
X-Gm-Message-State: AOAM530lA/ymQZaHtRLSPtZfpCppJAc4HFm8nq5atQpuMO4k4nzbB6K9
        52eGnw2vCttH73U8+now+W0WM+gta1OC1RZaI20vCQ==
X-Google-Smtp-Source: ABdhPJzbTsNFNsgJCq0R6sPG/+Uw4Bcv0ply156WXPYUJEkjjlz7V73QxyWbH2frTyfzaD1/yzUR9lYn2tuwb237SyU=
X-Received: by 2002:a05:6808:f14:: with SMTP id m20mr397142oiw.13.1618252485403;
 Mon, 12 Apr 2021 11:34:45 -0700 (PDT)
MIME-Version: 1.0
References: <20210412130938.68178-1-david.edmondson@oracle.com>
In-Reply-To: <20210412130938.68178-1-david.edmondson@oracle.com>
From:   Jim Mattson <jmattson@google.com>
Date:   Mon, 12 Apr 2021 11:34:33 -0700
Message-ID: <CALMp9eRTy-m6DkXRSGNU=r7xmrzFFQU60DB2asUDZLCgw93wRQ@mail.gmail.com>
Subject: Re: [PATCH 0/6] KVM: x86: Make the cause of instruction emulation
 available to user-space
To:     David Edmondson <david.edmondson@oracle.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        kvm list <kvm@vger.kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Sean Christopherson <seanjc@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Joerg Roedel <joro@8bytes.org>,
        Wanpeng Li <wanpengli@tencent.com>,
        Borislav Petkov <bp@alien8.de>, Ingo Molnar <mingo@redhat.com>,
        Aaron Lewis <aaronlewis@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 12, 2021 at 6:09 AM David Edmondson
<david.edmondson@oracle.com> wrote:
>
> Instruction emulation happens for a variety of reasons, yet on error
> we have no idea exactly what triggered it. Add a cause of emulation to
> the various originators and pass it upstream when emulation fails.

What is userspace going to do with this information? It's hard to say
whether or not this is the right ABI without more context.
