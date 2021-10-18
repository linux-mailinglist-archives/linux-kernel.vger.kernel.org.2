Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 14DDF43167D
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Oct 2021 12:51:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229998AbhJRKxg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Oct 2021 06:53:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229491AbhJRKxe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Oct 2021 06:53:34 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A69CC06161C
        for <linux-kernel@vger.kernel.org>; Mon, 18 Oct 2021 03:51:23 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id r10so40464419wra.12
        for <linux-kernel@vger.kernel.org>; Mon, 18 Oct 2021 03:51:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=EUaW7JwfSGO8IfMzxXtAbFj7chATqlw6VUjN7U2ryQM=;
        b=gsh2UkIAMsm5gYe5c49OiGWmzsspPVgjB2PAZkdcBDhHzqjXni96n8WS2mo1deqjcp
         EAWvXhBI3vbC6FovJLqT+tzcAWgqGm27iLzkbUAHDk51q01CC0bWX2vHMA22sXq8cNrV
         FYGbGg1+1E6kzv8/MgEDzSJxpJ+m0Lq1Rpz7qj/xrP5MJ8Y3b44gQ4tBk9n/TNizOR7x
         jwhOMhPLLLQhu+zdIKywI8J/ckZX+WWuMWn0FCdCRChKJwdSZ/ybmc0sP1AyY0y02Sst
         8j2wT9/pm1hfRlBeHG1YiMYxoXjAKAINmnfHZ8VIOfHMxyWEItndpA0p9wAbQ99sH2QF
         tXpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=EUaW7JwfSGO8IfMzxXtAbFj7chATqlw6VUjN7U2ryQM=;
        b=3u/cOcNSILiWx88t3jIsb+pC1zM5XIZfIv/CuYODBi/Auj3FH+3/PwaX6k6suBaiN3
         CWNddLnIc17cdEPPMXU2E8PR1GiBe5tTdWHdjpIAkQ7OXOWVXfKqQDuIWlqH2zcAtMqS
         fFQvWM+9Ipo3VFuZMK0Dq86dRdRUc7hmM2bL59TmYspZrxi2BKuqY/OOiyVglS+IKKWo
         Z9qBtBJ2Q3n/q0JM742s2GaHAK+HWW4aPq5oDIiRYZ4YHOaaOh/j8xRNsX4eihMcOS1a
         kjWcHoYqMvmKoWrtSh+W/ptlWykUN0VcMVEon2Ku+xLxpbgORtBTmqK25g48TfNzsFdN
         HOKw==
X-Gm-Message-State: AOAM533w71EFPcxwgKhtWYSyfHZw1ExCTNWa2Oce6tRd8HGwde5WLHC1
        TIry7mBAbP7RWz+gOBTqlW2L8A==
X-Google-Smtp-Source: ABdhPJwhtb3NOEzuy2ZFJYNVEotlalYXUtDQUgg53zsWLVY3XRXYV7dP0NvO8Pf6NgSALYKR0zEs3g==
X-Received: by 2002:a5d:59a9:: with SMTP id p9mr35745131wrr.386.1634554281829;
        Mon, 18 Oct 2021 03:51:21 -0700 (PDT)
Received: from google.com ([2a00:79e0:d:210:ba81:6f1b:ab2e:f120])
        by smtp.gmail.com with ESMTPSA id h8sm13921425wrm.27.2021.10.18.03.51.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Oct 2021 03:51:21 -0700 (PDT)
Date:   Mon, 18 Oct 2021 11:51:18 +0100
From:   Quentin Perret <qperret@google.com>
To:     Marc Zyngier <maz@kernel.org>
Cc:     James Morse <james.morse@arm.com>,
        Alexandru Elisei <alexandru.elisei@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Fuad Tabba <tabba@google.com>,
        David Brazdil <dbrazdil@google.com>,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu,
        linux-kernel@vger.kernel.org, kernel-team@android.com
Subject: Re: [PATCH 04/16] KVM: arm64: Introduce kvm_share_hyp()
Message-ID: <YW1RphOb9D/4/QGp@google.com>
References: <20211013155831.943476-1-qperret@google.com>
 <20211013155831.943476-5-qperret@google.com>
 <875ytworvy.wl-maz@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <875ytworvy.wl-maz@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 17 Oct 2021 at 11:41:21 (+0100), Marc Zyngier wrote:
> Not directly related to this code, but it looks to me that
> kvm_host_owns_hyp_mappings() really ought to check for
> is_kernel_in_hyp_mode() on its own. VHE really deals with its own
> mappings, and create_hyp_mappings() already has a check to do nothing
> on VHE.

Sure, I'll stick a patch at the beginning of the series.

> 
> > +
> > +	return pkvm_share_hyp(kvm_kaddr_to_phys(from), kvm_kaddr_to_phys(to));
> > +}
> > +
> >  /**
> >   * create_hyp_mappings - duplicate a kernel virtual address range in Hyp mode
> >   * @from:	The virtual kernel start address of the range
> > @@ -316,12 +327,8 @@ int create_hyp_mappings(void *from, void *to, enum kvm_pgtable_prot prot)
> >  	if (is_kernel_in_hyp_mode())
> >  		return 0;
> >  
> > -	if (!kvm_host_owns_hyp_mappings()) {
> > -		if (WARN_ON(prot != PAGE_HYP))
> > -			return -EPERM;
> > -		return pkvm_share_hyp(kvm_kaddr_to_phys(from),
> > -				      kvm_kaddr_to_phys(to));
> > -	}
> > +	if (WARN_ON(!kvm_host_owns_hyp_mappings()))
> > +		return -EPERM;
> 
> Do we really need this? Can't we just verify that all the code paths
> to create_hyp_mappings() check for kvm_host_owns_hyp_mappings()?
> 
> At the very least, make this a VM_BUG_ON() so that this is limited to
> debug. Yes, I'm quickly developing a WARN_ON()-phobia.

Right, that _is_ purely debug. It's just that folks are used to being
able to just call create_hyp_mappings() for anything, so I wanted to
make sure we have an easy way to catch future changes that would
unknowingly break pKVM, but no objection to make this VM_BUG_ON().

Cheers,
Quentin
