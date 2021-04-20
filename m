Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D7294365B4C
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Apr 2021 16:37:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232739AbhDTOiS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Apr 2021 10:38:18 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:44703 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232627AbhDTOiQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Apr 2021 10:38:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1618929464;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=33CVA8kWHawipps7EFzUJb1CXaHeSH20T2baV3pWy8g=;
        b=AtrOlgDj6I9eI/BVIvy2TULGdf66h225lv7UV7r2++G7c94sPYj+D3KaynANhm31Mnfi47
        omcPxr1y0cfqK5LYZ/L0KxuCXC0119k+lLyNXP1irzp1nkJ2BVxISv0In1JFRwEcDuL78F
        bvl4iFjUHdJotjH1Z37j7XaIteElQb0=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-271-P-p7zZ38NNGOAbrWltXhcA-1; Tue, 20 Apr 2021 10:37:41 -0400
X-MC-Unique: P-p7zZ38NNGOAbrWltXhcA-1
Received: by mail-qk1-f200.google.com with SMTP id p15-20020a05620a056fb02902e30b3f1950so7337127qkp.23
        for <linux-kernel@vger.kernel.org>; Tue, 20 Apr 2021 07:37:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=33CVA8kWHawipps7EFzUJb1CXaHeSH20T2baV3pWy8g=;
        b=UrT7dHGdjqeYxviu+bLf5z2vmVVjnIWkBRzWJLwHOvcn7mKxeRUZaCZ+S4U2jZV1dp
         Mc5UaZAYg9UmW5RqVPNKVQtZ7lcqlOna86DtSOIm8Hy7J9/8eI3G7A1YE8FGyusoDokc
         nGRITxnBZBn2Q7Qx3ZXloRIMDqh8z1/TGCu2rJrapPMCKuqHWidogwhVc26NfmcPhmX7
         FWNPso3PA8PBILORgdtp1/BAVcwABOoaWLEEUOVjmb7EhvXmyMft+kOmfAgMoc6iIXHN
         ZPnIFNkjxdYi8covC+QUdYPl3aiTae/8J/kwhxHyyYBLA/k+ZNWCkhIHN2kpZ2sExRDo
         RbLg==
X-Gm-Message-State: AOAM531OQ8UYHSzD5IHcFqF4bdevUTZcN/dM4t3T+hwsRuYSbvc7HfFe
        QrncAfbNkjr0shLX22HeZyfHP8006uwz3jvqji9rV9l4fHnPMyHAiSGUGxrSvOYWZXWFL1SWaxo
        qKfWabfJKP8BMcw4k1gb56+Jp
X-Received: by 2002:a0c:fb43:: with SMTP id b3mr12120014qvq.42.1618929461410;
        Tue, 20 Apr 2021 07:37:41 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx4ONXVSlwHL519fIegDGFnXVnOOob94nUlZsSOdtHzcOFxIJiOusGtNuV+XRpmmYe1+KUq/Q==
X-Received: by 2002:a0c:fb43:: with SMTP id b3mr12119998qvq.42.1618929461181;
        Tue, 20 Apr 2021 07:37:41 -0700 (PDT)
Received: from xz-x1 (bras-base-toroon474qw-grc-88-174-93-75-154.dsl.bell.ca. [174.93.75.154])
        by smtp.gmail.com with ESMTPSA id k127sm12216745qkc.88.2021.04.20.07.37.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Apr 2021 07:37:40 -0700 (PDT)
Date:   Tue, 20 Apr 2021 10:37:39 -0400
From:   Peter Xu <peterx@redhat.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        stable@vger.kernel.org
Subject: Re: [PATCH] KVM: selftests: Always run vCPU thread with blocked
 SIG_IPI
Message-ID: <20210420143739.GA4440@xz-x1>
References: <20210420081614.684787-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210420081614.684787-1-pbonzini@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 20, 2021 at 04:16:14AM -0400, Paolo Bonzini wrote:
> The main thread could start to send SIG_IPI at any time, even before signal
> blocked on vcpu thread.  Therefore, start the vcpu thread with the signal
> blocked.
> 
> Without this patch, on very busy cores the dirty_log_test could fail directly
> on receiving a SIGUSR1 without a handler (when vcpu runs far slower than main).
> 
> Reported-by: Peter Xu <peterx@redhat.com>
> Cc: stable@vger.kernel.org
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>

Yes, indeed better! :)

Reviewed-by: Peter Xu <peterx@redhat.com>

-- 
Peter Xu

