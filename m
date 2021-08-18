Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 128CD3F0E6C
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Aug 2021 00:54:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233928AbhHRWyn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Aug 2021 18:54:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234135AbhHRWyk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Aug 2021 18:54:40 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E360EC0617AD
        for <linux-kernel@vger.kernel.org>; Wed, 18 Aug 2021 15:54:04 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id w13-20020a17090aea0db029017897a5f7bcso3427480pjy.5
        for <linux-kernel@vger.kernel.org>; Wed, 18 Aug 2021 15:54:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Bdg/OtOV5wymBEUwuQlX5+GK5JjmwLGgSiZ+Tmmadzg=;
        b=bGU4j745GyvuoiOCvJ9XjMdyezUrxYO1pPcd3Nh9uTw2AHyNof0gLDjkyhM8xE1bpY
         ZhK4WiLLT0bHAnhPZz+LIR1+EgOwNsqitav2SEBVEKiVfgPXmLnjjumcy0TFltdAkpUp
         +Y/iv2y66lHJkcJw8yDjHLrdQLAKo5xhCntkA7/YsKW0wiAtv4Qvj7Ok2yu75nvP5VG/
         kQ33sD5kcz6G3nunSMjMr3GEhOael40I5f0/SkDnOprQdLkOYlZpBPRnAiPwJ3is8bPU
         tVhgUeDxPTVKaaCpoehLowvGyCLbirnVXNHyIzEPJxHcN9722SczInchAhVN3qboCzK5
         oo2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Bdg/OtOV5wymBEUwuQlX5+GK5JjmwLGgSiZ+Tmmadzg=;
        b=gyEQY6D9i10crfHS9unHV82m11aDxGqWNxDzwRs0Q8V9Smxc4LLMv3zlwNM9zQdPr8
         3W0C/XPNZINOXl+fwGSfrlF0QaoqGQr3kqUMPqaNW3AkD6dOiMZ9feWi0UuS6NXnRifS
         e4isEhibR+8fFoycpGtSGAzDY79lY8lfRce4eJ0wQeueJK37pUQuMiPPJIRjbnCrsiXp
         qc+RKVx1cSz3mW1MbtYhx8ighArU04JrjdSH7b1zduAcox7kyLMaUe8WKlAxS0r5jJEu
         oPZ4iBS7rdxAL/NRMWXKG4RqYmgG0vdChQcKYoKmI4DdMvlsNCfeCBpy8q5h54+Du9vv
         2cSA==
X-Gm-Message-State: AOAM532XH9SJJGFrv1qc8/Hhlrd/kkOrT2YZhB7DfAC8hXdJYkahmXpg
        X5mb3CLRztdl0jrQH0m+VETILA==
X-Google-Smtp-Source: ABdhPJzzXby04WbbyigGFBDREGEkGV8RqUxAeMQ0ojYzJgYocP/xgVxlZiD/Hh9heqjmIsz5yKhdZw==
X-Received: by 2002:a17:90a:af88:: with SMTP id w8mr11746328pjq.104.1629327244194;
        Wed, 18 Aug 2021 15:54:04 -0700 (PDT)
Received: from google.com (157.214.185.35.bc.googleusercontent.com. [35.185.214.157])
        by smtp.gmail.com with ESMTPSA id s26sm894895pgv.46.2021.08.18.15.54.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Aug 2021 15:54:03 -0700 (PDT)
Date:   Wed, 18 Aug 2021 22:53:58 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Kees Cook <keescook@chromium.org>
Cc:     linux-kernel@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        kvm@vger.kernel.org, "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-staging@lists.linux.dev,
        linux-block@vger.kernel.org, linux-kbuild@vger.kernel.org,
        clang-built-linux@googlegroups.com,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH v2 53/63] KVM: x86: Use struct_group() to zero decode
 cache
Message-ID: <YR2PhlO3njPcFOkg@google.com>
References: <20210818060533.3569517-1-keescook@chromium.org>
 <20210818060533.3569517-54-keescook@chromium.org>
 <YR0jIEzEcUom/7rd@google.com>
 <202108180922.6C9E385A1@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202108180922.6C9E385A1@keescook>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 18, 2021, Kees Cook wrote:
> On Wed, Aug 18, 2021 at 03:11:28PM +0000, Sean Christopherson wrote:
> > From dbdca1f4cd01fee418c252e54c360d518b2b1ad6 Mon Sep 17 00:00:00 2001
> > From: Sean Christopherson <seanjc@google.com>
> > Date: Wed, 18 Aug 2021 08:03:08 -0700
> > Subject: [PATCH] KVM: x86: Replace memset() "optimization" with normal
> >  per-field writes
> > 
> > Explicitly zero select fields in the emulator's decode cache instead of
> > zeroing the fields via a gross memset() that spans six fields.  gcc and
> > clang are both clever enough to batch the first five fields into a single
> > quadword MOV, i.e. memset() and individually zeroing generate identical
> > code.
> > 
> > Removing the wart also prepares KVM for FORTIFY_SOURCE performing
> > compile-time and run-time field bounds checking for memset().
> > 
> > No functional change intended.
> > 
> > Reported-by: Kees Cook <keescook@chromium.org>
> > Signed-off-by: Sean Christopherson <seanjc@google.com>
> 
> Reviewed-by: Kees Cook <keescook@chromium.org>
> 
> Do you want me to take this patch into my tree, or do you want to carry
> it for KVM directly?

That's a Paolo question :-)

What's the expected timeframe for landing stricter bounds checking?  If it's
5.16 or later, the easiest thing would be to squeak this into 5.15.
