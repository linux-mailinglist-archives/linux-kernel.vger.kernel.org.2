Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE215403225
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Sep 2021 03:21:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345915AbhIHBXD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Sep 2021 21:23:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229946AbhIHBXC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Sep 2021 21:23:02 -0400
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 465FAC061575
        for <linux-kernel@vger.kernel.org>; Tue,  7 Sep 2021 18:21:55 -0700 (PDT)
Received: by mail-lj1-x22c.google.com with SMTP id d16so685387ljq.4
        for <linux-kernel@vger.kernel.org>; Tue, 07 Sep 2021 18:21:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KeNC+xKtdDu6RTTBHmLc6/GMNcuVkbNM9xz7wbPcFt0=;
        b=C6PQPdgaqWvNpRQJzk5mjGikGCmfGfZG6rs53tEoPAr3c11GXY1RIpPL0qf6HG9P/q
         buUN59vo7ouy1QSmlby8yYm1wVmLwMwpc1iVPBhRRbnPvV0yJw5yxAIE+y3FaQUUj6m6
         jtnD2rlG0gohDBQoliNzFByxIk8SASTAWndDbDhzyqVcVMaVS1fcQEeSrQQ+On5tk+t7
         TFzlKpyVYDZg+krdIr/p9gjuQ56GYB8DyajIIcfPrdBMQhQaM7srg46y+/qN5qzhBxLW
         l3X5zWdH3fOA4/uIid1YC0k13YVW7Ce5EwvKIDLzcGWvocmo7GGtO4/R2Nqi2DAYHUn8
         PfIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KeNC+xKtdDu6RTTBHmLc6/GMNcuVkbNM9xz7wbPcFt0=;
        b=hbBJJhv30oEAhc4CG2rTc+loHLj/1QV3lRKkT9bpCXgrYtT+6cW2xMIuglSPT60KQY
         +pAIQM6+axIlC97NBcpHrdQ3Io9j0Y5rnfzXid04bWq5UWibu5Asyz5sln2Ots4UUD34
         27435zqQllSu0ZS/F+TK8KL35nLWkXVAcsntvCBbSRZKEjn97E/jeZdM6w9Wcpl0jUZO
         KPm9lcHBfSCowLPedSon9Q2lVKAorb4n7+k5a8SLCiTmQHRprac05i25jjNPgqkyXQBs
         boSRgJrHfG3+PnkrXVKMJzdJ1yea2JF6dYfZUseZzqBQ0o5OMR5Rek+oatDztVrGNmhK
         6QTg==
X-Gm-Message-State: AOAM533Bi6iEzJznfNoJ5r1S7kL3Jsc20HjlyyfekxA7Hu+ZD/UHJcC7
        COrc88H//R+F1+UAEmeB+caUoWQJGt25+YdWfjks8w==
X-Google-Smtp-Source: ABdhPJxmk5JpnPt/l3GLD8X4Z8zmvHTEhjebR5aPXNGM2ng2gIkRYC0aVcx89Tzi5a7HpVOXBJqnUniHbq1Mb2Oqxyc=
X-Received: by 2002:a2e:a0c8:: with SMTP id f8mr790291ljm.170.1631064112393;
 Tue, 07 Sep 2021 18:21:52 -0700 (PDT)
MIME-Version: 1.0
References: <20210907123112.10232-1-justin.he@arm.com> <20210907123112.10232-2-justin.he@arm.com>
In-Reply-To: <20210907123112.10232-2-justin.he@arm.com>
From:   Oliver Upton <oupton@google.com>
Date:   Tue, 7 Sep 2021 20:21:40 -0500
Message-ID: <CAOQ_QshwO2AtzKTNZJ1FXWTuvdvnxnLQxej1UpLAqVrJC_oCgw@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] KVM: arm64: vgic: Add memcg accounting to vgic allocations
To:     Jia He <justin.he@arm.com>
Cc:     Marc Zyngier <maz@kernel.org>, James Morse <james.morse@arm.com>,
        Alexandru Elisei <Alexandru.Elisei@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Xiaoming Ni <nixiaoming@huawei.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Kees Cook <keescook@chromium.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        linux-kernel@vger.kernel.org, Liu Shixin <liushixin2@huawei.com>,
        Sami Tolvanen <samitolvanen@google.com>,
        Will Deacon <will@kernel.org>, kvmarm@lists.cs.columbia.edu,
        linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 7, 2021 at 7:33 AM Jia He <justin.he@arm.com> wrote:
>
> Inspired by commit 254272ce6505 ("kvm: x86: Add memcg accounting to KVM
> allocations"), it would be better to make arm64 vgic consistent with
> common kvm codes.
>
> The memory allocations of VM scope should be charged into VM process
> cgroup, hence change GFP_KERNEL to GFP_KERNEL_ACCOUNT.
>
> There remain a few cases since these allocations are global, not in VM
> scope.
>
> Signed-off-by: Jia He <justin.he@arm.com>
> ---
>  arch/arm64/kvm/vgic/vgic-init.c    |  2 +-
>  arch/arm64/kvm/vgic/vgic-irqfd.c   |  2 +-
>  arch/arm64/kvm/vgic/vgic-its.c     | 14 +++++++-------
>  arch/arm64/kvm/vgic/vgic-mmio-v3.c |  2 +-
>  arch/arm64/kvm/vgic/vgic-v4.c      |  2 +-
>  5 files changed, 11 insertions(+), 11 deletions(-)
>

Reviewed-by: Oliver Upton <oupton@google.com>
