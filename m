Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A740743CC08
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Oct 2021 16:23:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238191AbhJ0OZl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Oct 2021 10:25:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236746AbhJ0OZW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Oct 2021 10:25:22 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68C37C061767
        for <linux-kernel@vger.kernel.org>; Wed, 27 Oct 2021 07:22:56 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id f8so2089749plo.12
        for <linux-kernel@vger.kernel.org>; Wed, 27 Oct 2021 07:22:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=faL3hH+NCX5/DsGmoTk4v9BzANklOoCX7PZ1uyEQYpE=;
        b=QrEZWHgde4++98wbsrBj5x36HpDhYBfgqU3mCtPL1nQYVwNy4QyAaUYqD6+VFSvRUs
         nEWDOV8QgQDyDcvPcyjQfiBC9zgakU1+p1YwYvgm6b9C56fefd2p+KBG2Fu1gvtIW1wP
         CV2WWh3u0wxrWM6h0Hh16F/CV6RRjNVW/3y52IPEoTfbQBrW0iRetDfVQfQvusvNeQ5E
         VMsXYCohPB4pWLoPUvbil+VhhWXxIwgCX7bsslW4RaB1t/wEeV9z6EyQIjJ0Wmk5NEO+
         pRagFJ0B+40+QZAhubJC32LRPQ1ptxXmP/RrQuSaXruW3x7+ojm7gsNPPYps3tkW2+AA
         PSSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=faL3hH+NCX5/DsGmoTk4v9BzANklOoCX7PZ1uyEQYpE=;
        b=PbFPuJhQles+3JCINWxXkjmqsk/IwbQJVU7ic60nutIEpgeDTyB6y4r2eDYX+Gi5El
         9STzTO0sUesUFCTyR8/mIVr5FQndTbIymIps1irSrC0YogXITNJFB6XrtGlWfy+QgY+d
         KHQcq3xJ5xW5zz3RfabF59aTGXRl9hhWUgO2RfSS4tj3xIbwikDJN+VGpXOz3XPzLilg
         feMLsVZHAgj/GbO2HQoTyd9CQdVvGQDe1YREuYKOmk8HpyjIUZJkJXqxrNWix6QybRXj
         1X8Nc+PhBbiEoAbf29j98hX3LLjgBxFIqvo6wyMCbQhOgJWBpjgQpklA6ucshbIevn/M
         I6Zw==
X-Gm-Message-State: AOAM5305G6YfOp8TlytKd7IoLijiFQGOlAxXW5fHdXzaVO0Ah185XF14
        ST0TjdRfzva5Bbk3gFQKWba4rA==
X-Google-Smtp-Source: ABdhPJxsbiaILsnaJKJZgCYWkLS/pVhvL8mHQ9k4WgCuMh3J4M+rfVk+Somp468m8Jj93Vo7OfLOfQ==
X-Received: by 2002:a17:90b:1a87:: with SMTP id ng7mr6228120pjb.69.1635344574094;
        Wed, 27 Oct 2021 07:22:54 -0700 (PDT)
Received: from google.com (157.214.185.35.bc.googleusercontent.com. [35.185.214.157])
        by smtp.gmail.com with ESMTPSA id u2sm150520pfi.120.2021.10.27.07.22.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Oct 2021 07:22:53 -0700 (PDT)
Date:   Wed, 27 Oct 2021 14:22:49 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Qian Cai <quic_qiancai@quicinc.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] kvm: Avoid shadowing a local in search_memslots()
Message-ID: <YXlguTLnOuEphLiZ@google.com>
References: <20211026181915.48652-1-quic_qiancai@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211026181915.48652-1-quic_qiancai@quicinc.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 26, 2021, Qian Cai wrote:
> It is less error-prone to use a different variable name from the existing
> one in a wider scope. This is also flagged by GCC (W=2):
> 
> ./include/linux/kvm_host.h: In function 'search_memslots':
> ./include/linux/kvm_host.h:1246:7: warning: declaration of 'slot' shadows a previous local [-Wshadow]
>  1246 |   int slot = start + (end - start) / 2;
>       |       ^~~~
> ./include/linux/kvm_host.h:1240:26: note: shadowed declaration is here
>  1240 |  struct kvm_memory_slot *slot;
>       |                          ^~~~
> 
> Signed-off-by: Qian Cai <quic_qiancai@quicinc.com>
> ---

Reviewed-by: Sean Christopherson <seanjc@google.com>
