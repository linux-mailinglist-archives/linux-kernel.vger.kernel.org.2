Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9AF6D40450E
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Sep 2021 07:36:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350795AbhIIFhc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Sep 2021 01:37:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350766AbhIIFha (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Sep 2021 01:37:30 -0400
Received: from mail-il1-x12d.google.com (mail-il1-x12d.google.com [IPv6:2607:f8b0:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A91B3C061575
        for <linux-kernel@vger.kernel.org>; Wed,  8 Sep 2021 22:36:21 -0700 (PDT)
Received: by mail-il1-x12d.google.com with SMTP id u17so718727ilm.13
        for <linux-kernel@vger.kernel.org>; Wed, 08 Sep 2021 22:36:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=rs5Tku62bnXK35H0Ulh2hfV6Nn9BVEa4pNd3KqkqUPs=;
        b=GMYQBh6WtXAaT5vNg8hi9Kb7xMdP3NL5qvzhh7Ue+yitvRoS2SOSlMiAf34qHAUOYb
         fxbnbFHZlBEtGe5Dl1hVQT1yA49nnbTthLHge+Pdh0Qv22zejYyAiivtcBg+ous2chQ9
         nDhlQu96I30StM5J6gnplhjyT+qyeJEVbxKpp+xMSoNAXousbBAJirlV1a/CrEyefBhO
         pI8q4n+Itugi/jPAQrP/0j2b6ipq4nt8miMBop9exEii3zQzzyPmh8XNEtoV+yW8RBS2
         zk/iIl8kAp8QzxOoM46ukJRXafhKCM9e6QCgoVq4mW5BBz+409Ab+Y+/+T7iT6wRw7NQ
         EUAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=rs5Tku62bnXK35H0Ulh2hfV6Nn9BVEa4pNd3KqkqUPs=;
        b=Fa18Sj2tjLCPqmee+qo6gjJhGG5PSmwIgmQX6NF18h7AC8qIDitR3MUtVWY33EsEnH
         98SkEsOyCjDCSsxCCRM9V59Rthpaacf2QfXcOHl5bvFBpdT0ys8Q3TxNuyZkT5CNpnGc
         O6JMSSyuq9fyfs8YFtM10IK7+1xkjGbmL3ozZSybVKHtQ3Fj+Vtgqowg1iRWmOdnCg3I
         oMI0zSc23xigHe9vIclVFsWXqtXyrqavloM+N1/31A0z6suHPbUBUXzt4B/XP0FO4hjz
         YPmFrJpkuuMthRcsYvuGvzR7Aj2U1EQ+vgwA47a9w2+JYkkbErWNe72dr9TdD6RWR/wb
         ThPw==
X-Gm-Message-State: AOAM530JSRwuT6azMNUYSOVi73TdBQX0OYlk+nX1tVx6bYr/uCrItZ94
        5N1yoBTy+lVN47+SHjdhep8weA==
X-Google-Smtp-Source: ABdhPJz2tiiZiLS+hXn/+gHFSIX1wmyP8hppIZxSTGQIgnCL75/acuIPebWpw5ZoRZACvU+9n9ydSw==
X-Received: by 2002:a92:da49:: with SMTP id p9mr1010706ilq.89.1631165780802;
        Wed, 08 Sep 2021 22:36:20 -0700 (PDT)
Received: from google.com (194.225.68.34.bc.googleusercontent.com. [34.68.225.194])
        by smtp.gmail.com with ESMTPSA id c11sm424815ilu.74.2021.09.08.22.36.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Sep 2021 22:36:20 -0700 (PDT)
Date:   Thu, 9 Sep 2021 05:36:16 +0000
From:   Oliver Upton <oupton@google.com>
To:     Raghavendra Rao Ananta <rananta@google.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>, Marc Zyngier <maz@kernel.org>,
        Andrew Jones <drjones@redhat.com>,
        James Morse <james.morse@arm.com>,
        Alexandru Elisei <alexandru.elisei@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Peter Shier <pshier@google.com>,
        Ricardo Koller <ricarkol@google.com>,
        Reiji Watanabe <reijiw@google.com>,
        Jing Zhang <jingzhangos@google.com>,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Subject: Re: [PATCH v4 18/18] KVM: selftests: vgic_init: Pull
 REDIST_REGION_ATTR_ADDR from vgic.h
Message-ID: <YTmdUEcbvf/7mkOw@google.com>
References: <20210909013818.1191270-1-rananta@google.com>
 <20210909013818.1191270-19-rananta@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210909013818.1191270-19-rananta@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 09, 2021 at 01:38:18AM +0000, Raghavendra Rao Ananta wrote:
> Pull the definition of REDIST_REGION_ATTR_ADDR from vgic.h.
> 
> Signed-off-by: Raghavendra Rao Ananta <rananta@google.com>
> ---
>  tools/testing/selftests/kvm/aarch64/vgic_init.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)

Just squash this into the commit where you hoist it into vgic.h. It is
fine to glob it together with the other vgic changes since you're
dropping it into a completely new header file.

--
Thanks,
Oliver
