Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DBD9E3A3447
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jun 2021 21:48:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230353AbhFJTuH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Jun 2021 15:50:07 -0400
Received: from mail-pf1-f173.google.com ([209.85.210.173]:40590 "EHLO
        mail-pf1-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230323AbhFJTuG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jun 2021 15:50:06 -0400
Received: by mail-pf1-f173.google.com with SMTP id q25so2498021pfh.7
        for <linux-kernel@vger.kernel.org>; Thu, 10 Jun 2021 12:48:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=1riA2amXnwC2QT35mVQ5QFxvx4A6tenDjIbnnUpEvuM=;
        b=KM/C4DJcsRXXxxiqObrs2HaCutGBRssCSphexck+IF/i7F6izF3Qq/tU7FbecSuzgP
         lZIDfkGxK3MJEsWkpkmJkMHU9BpEgtlIALexAScNb9jPVogYqZZWmGSDIC4/D+T6dMVZ
         Ooal/oWYhZG9FX9bfEBKSZtMEFXaAO04pJdB/pEJiVBPkkvBwATheFhom55lo8P0H4vL
         +d1NFn0OljDWANQnj+DTuett6lJjF9GQoAWE0uKxN3/erm6apHFkO19Y7ad0KgJnt+HA
         2VjAIGVZMy/tk88wAOB2ovc4oNpjrQeN/fpq6VWPOoH04sAfLewGIWQGvRkOo17pwjHH
         vYPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=1riA2amXnwC2QT35mVQ5QFxvx4A6tenDjIbnnUpEvuM=;
        b=AeI3um6dxCJJanmA55IMATXf5XreMyt4QDbnJT7VjcF6AyU4DkTHqV6f8TjG1tW+OY
         7/3KARDtOmBHfvWW7umSkBYoeTbp+WKd28JwkMBETs/oLXz509wFnXBs98Fb+ZAiHGlZ
         z0EBRwb3TPEPMykkEA2iv4MzP54dIOzp2hfEwwK5rkePs4xMxPnmbzq0G2vUq3xr4Bds
         j/FRvNgUPXStwaHBvGPxiWQsvZM+L1DVbpr0GKfIV5855DJMJW9qEazdkztLGToU5ssF
         WynQ9VquPhrYYG8IcY7k+k5BYVBbYNFrayl1mK6FLB3yGbXXx9hJp9njGnyAYnk/yR64
         Kzxw==
X-Gm-Message-State: AOAM531YXFIBfRu4dFKtSELOw8dS1px3DHczVrTX0p1nVJOcDyacYn8+
        cZ2D5pbAcu4TEfH7x8Xd9ZATaAPjcSstIQ==
X-Google-Smtp-Source: ABdhPJxNlTWRsUwcfOKSpSAmQxfeUV7yFXAa/M2OS/GpoudIhUXco0Fccs+9RRjwPblPPCQPu+edyg==
X-Received: by 2002:a63:7a01:: with SMTP id v1mr32520pgc.307.1623354429290;
        Thu, 10 Jun 2021 12:47:09 -0700 (PDT)
Received: from google.com (157.214.185.35.bc.googleusercontent.com. [35.185.214.157])
        by smtp.gmail.com with ESMTPSA id x6sm3040429pfd.173.2021.06.10.12.47.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Jun 2021 12:47:08 -0700 (PDT)
Date:   Thu, 10 Jun 2021 19:47:05 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        Jing Zhang <jingzhangos@google.com>
Subject: Re: [PATCH] KVM: switch per-VM stats to u64
Message-ID: <YMJsOXtpU5hU2nc+@google.com>
References: <20210610164638.287798-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210610164638.287798-1-pbonzini@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 10, 2021, Paolo Bonzini wrote:
> Make them the same type as vCPU stats.  There is no reason
> to limit the counters to 64 bits.

s/64/32?  Either that or I'm worse at math than I thought.
