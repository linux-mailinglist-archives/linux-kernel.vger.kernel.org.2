Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7BD0832F2BE
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Mar 2021 19:36:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230198AbhCESfs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Mar 2021 13:35:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230425AbhCESfV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Mar 2021 13:35:21 -0500
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 308FBC0613D9
        for <linux-kernel@vger.kernel.org>; Fri,  5 Mar 2021 10:33:49 -0800 (PST)
Received: by mail-pf1-x429.google.com with SMTP id q20so2687261pfu.8
        for <linux-kernel@vger.kernel.org>; Fri, 05 Mar 2021 10:33:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=gopE1fDc4vVgparSpgvp1lWA7bVSSuK93mUAKs4+V30=;
        b=YiaGCb5bE+tvCz5nKQBEiOL7qODtlLrbF8Z/tqD8Ik6DNRSrNFGBu7UNuMxkgeafDF
         v3MUspNuhmXZ3vPryyB1myvzRsZ7TO7bqtC0FRjd4VNi3+hq/xz6ABG/ofn/XZF4L19v
         JrnyNKO/A2kCk7rkzkgsBIryhOK5ZR0l+Lag7XjyNUqynw/XbE1eU6S3+b2/RrTUw1jq
         KtdFhq8AvxIrrYmKqG9ZoxShtwUPh1xkeogq36DKPowNNxDfsm9tPKyP+l5IY0YfUmJV
         KBReUWWtNszUxTueVpv4xlbYe69DoXxwQ3SiNI8LcwBspqTMoTbr6GzxctyugyNjM5Qa
         viRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=gopE1fDc4vVgparSpgvp1lWA7bVSSuK93mUAKs4+V30=;
        b=dOcJ+p3TSaeA9PbGlRUPlJ+Yxioh5fzEpNy3WF26Mq2K1tT6D4KXQpI8BjkHOy5l6E
         ZPWHAeUjoFOoobD2urr3uvytz4UKTddnttAJSf9/IsXOySVa/mGldK1VJ0tuHv+Oh7Y8
         1rXIAuafD1Rk6TOM2siLWgeUm/0Y+qkafa1K5O63o4xce4/yx6elm+5xRa3zlXprlKth
         aJcb9AUkChPneh95ZJzJtWNEtUfvQI2J5wOl2w82VyAN7xKpaaEBX98YURUlVXXIF3rl
         UE6nOZ2fAFWNmII/8ICiUgMMH7GLZqFEaNGOBq2Y02oKb38WITXA1uPdiEkvxalFyG9h
         y09Q==
X-Gm-Message-State: AOAM5327sy+Ua2uL2tTMDdJWv5QWWdUXCTBG+qGY5XPk8rIB7HoaLFFV
        tjOBI4Crytd89r0RNGxXPwkc9Q==
X-Google-Smtp-Source: ABdhPJzfv9A6DkoJT3pBO2IRdFRsSR/tN96ya98M6730iFgnRyno3kwUUm/9pGp9x30/lHjntR4DXw==
X-Received: by 2002:a63:d601:: with SMTP id q1mr9810597pgg.417.1614969228630;
        Fri, 05 Mar 2021 10:33:48 -0800 (PST)
Received: from google.com ([2620:15c:f:10:9857:be95:97a2:e91c])
        by smtp.gmail.com with ESMTPSA id q205sm2235539pfc.126.2021.03.05.10.33.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Mar 2021 10:33:48 -0800 (PST)
Date:   Fri, 5 Mar 2021 10:33:41 -0800
From:   Sean Christopherson <seanjc@google.com>
To:     Paolo Bonzini <pbonzini@redhat.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 00/11] KVM: VMX: Clean up Hyper-V PV TLB flush
Message-ID: <YEJ5hTNoDLqG7fm3@google.com>
References: <20210305183123.3978098-1-seanjc@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210305183123.3978098-1-seanjc@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I'm an idiot and Cc'd my old @intel.com address on everything.  Apologies in
advance for the inevitable bounces. :-/

On Fri, Mar 05, 2021, Sean Christopherson wrote:
> Clean up KVM's PV TLB flushing when running with EPT on Hyper-V, i.e. as
> a nested VMM.  No real goal in mind other than the sole patch in v1, which
> is a minor change to avoid a future mixup when TDX also wants to define
> .remote_flush_tlb.  Everything else is opportunistic clean up.
