Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA01939743D
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Jun 2021 15:31:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234052AbhFANcz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Jun 2021 09:32:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233925AbhFANcx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Jun 2021 09:32:53 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E4CDC061574
        for <linux-kernel@vger.kernel.org>; Tue,  1 Jun 2021 06:31:11 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id c3so14320670wrp.8
        for <linux-kernel@vger.kernel.org>; Tue, 01 Jun 2021 06:31:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ceM+pzGaASjItNNpKWFEaDd0DaKnxYhb/K4oaZ7JsPI=;
        b=LP2fsEvMTFs8wSLGgZY1ubi1BD83fbQR+WWGlnKbnhrJzkcoYhZUlw/ZkFPHVRX2pS
         1kxI8JgLhb0g3kz0pGI8o3ABqCJYAa0imQmWdnz1EWZGapSxVVG0FE8I2m7eCNFp+FhJ
         LX0uC4VCrnahVcOZ/Fet/aQm0qdopbZL6zqs2RlZqUjc4xKX7utUPhIEuwzdWLNG7IVz
         ++liR5Sn4WQaIdIQG2oJDi6hnggLc2WP6sfG4+RcODkWpixbjWvXjXfdGBeUfjYhoY1y
         DhzTNVl41otb4rKKFkL85f8end5tGK+CpDfjGjCeZ4NEEnEvWdsyM8i67qe/y/1t0Wyt
         kmQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ceM+pzGaASjItNNpKWFEaDd0DaKnxYhb/K4oaZ7JsPI=;
        b=M6opWu46tPQcqu3EBtNFcE6BfBHC/TV1SVzTWGRBBBP2cxcw2VCnBiWBzCoEdKEmGi
         AHw98JQiURbs9KMQPg0zPnDqpACMPi+G1fGXwu2Bb9sPgF68k1KXNKddFdqvHLz5tmWr
         sZ96iQfORVH6NX3PeifY7piMKfZ/YNjbNxMWYaysP5dAw/bocKY3R97d5XT8bnHS7pxk
         xLu9zGlW0l/1UvVdJBzr6iHUw+m0ApZIkBWbf6RB+U5RwgQOmFJ7N/CyboV++SCBTRRQ
         QvlTzyRiSGGvlAoVtJt0oCHxbri3V/7T/+ngTFpIoioBIn8etCb7pM95FZt/BdnT6dlE
         0raQ==
X-Gm-Message-State: AOAM530GAAXc1/fg/fUanIqeM1mJQjH8XvhjoWAexqiN41/Doovopx+c
        bCPIJ2SDPUeV2wTLQ1iotR5B3w==
X-Google-Smtp-Source: ABdhPJwkD2HduO0uUirxMSgy26JktuDamd44LHDyKx90TnuHOIIZTT9Fv/kzeN7mfG9dVVkN7NVWOg==
X-Received: by 2002:a5d:4003:: with SMTP id n3mr27693980wrp.173.1622554270083;
        Tue, 01 Jun 2021 06:31:10 -0700 (PDT)
Received: from google.com (105.168.195.35.bc.googleusercontent.com. [35.195.168.105])
        by smtp.gmail.com with ESMTPSA id w13sm490487wmi.4.2021.06.01.06.31.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Jun 2021 06:31:09 -0700 (PDT)
Date:   Tue, 1 Jun 2021 13:31:06 +0000
From:   Quentin Perret <qperret@google.com>
To:     Marc Zyngier <maz@kernel.org>
Cc:     will@kernel.org, james.morse@arm.com, alexandru.elisei@arm.com,
        catalin.marinas@arm.com, suzuki.poulose@arm.com,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu,
        kernel-team@android.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/7] KVM: arm64: Move hyp_pool locking out of refcount
 helpers
Message-ID: <YLY2mjxGCSyunnhV@google.com>
References: <20210527125134.2116404-1-qperret@google.com>
 <20210527125134.2116404-2-qperret@google.com>
 <87sg2123pj.wl-maz@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87sg2123pj.wl-maz@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 01 Jun 2021 at 13:02:00 (+0100), Marc Zyngier wrote:
> On Thu, 27 May 2021 13:51:28 +0100,
> Quentin Perret <qperret@google.com> wrote:
> > 
> > The hyp_page refcount helpers currently rely on the hyp_pool lock for
> > serialization. However, this means the refcounts can't be changed from
> > the buddy allocator core as it already holds the lock, which means pages
> > have to go through odd transient states.
> > 
> > For example, when a page is freed, its refcount is set to 0, and the
> > lock is transiently released before the page can be attached to a free
> > list in the buddy tree. This is currently harmless as the allocator
> > checks the list node of each page to see if it is available for
> > allocation or not, but it means the page refcount can't be trusted to
> > represent the state of the page even if the pool lock is held.
> > 
> > In order to fix this, remove the pool locking from the refcount helpers,
> > and move all the logic to the buddy allocator. This will simplify the
> > removal of the list node from struct hyp_page in a later patch.
> 
> Is there any chance some documentation could be added so that we have
> a record of what the locking boundaries are? Something along the line
> of what we have in arch/arm64/kvm/vgic/vgic.c, for example.

Sounds like a good idea, I'll go write something.

Cheers,
Quentin
