Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CDB473D155C
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jul 2021 19:47:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236583AbhGURGW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jul 2021 13:06:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236498AbhGURGV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jul 2021 13:06:21 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04332C061757
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jul 2021 10:46:57 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id gb6so4479841ejc.5
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jul 2021 10:46:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=AxTvururg15eAgQqT/Vw3IaCmq/AtpICOLNE7tzoQWM=;
        b=s0WASEAsAruBpiL/ESXJp2VeA5h+VTH0uEnk+LjAD3MHgy72GUAmI0zBPcvrD8s0SA
         BWd9ei0B8Hv1rK7VYNbIu6CBlaBhnbfO64qTWXLIdQniLZyup1q2j9Bl5Ub6BeGijcX8
         o2GowuJAhyePRBqL1PylmSGGCsNgtoGiloJFlPnxkrNT2U81r5Mxayn2fG2GDKvW/6Wr
         JHGyMNfwDGxoCXuUwC54Cph9OIE9di/Zn5VNuNjuxY1xSE8IY6oZOFZOwV1+s5UgN5EL
         WdegzQ2TXCJbEAUWTyI+Nys4iqZoAnBRb0CZnuj1SZTVekfvqquMS7B2ygo0sDqp4kYi
         SlKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=AxTvururg15eAgQqT/Vw3IaCmq/AtpICOLNE7tzoQWM=;
        b=Hi04sIyZqKnU2I3DuS6CQ6atJnG92VOhKB+Si2dUTPZgVZEJGJniHk8nVuxGJw0fTA
         zquEJRax92k3+V0asWG1LRbyBu6rBrEJc72TxDmwDcgE28RtcJ+FktBNplgfeshxrsIs
         8y9Fww7+J6gVabei9JvoUJjhr0i3OhdirBPSb6na7rxHglF3gDDZmfJUgUOVYGZB+D39
         qnoXxV1ShzSLcw/iph+QtSdOE24Q+UnFdi7AUxJYfhf56S76jvg3mIcoXlz6QeaRe0Zz
         pPSUaXfp5pd3yO3YFFWyBQHMtgtp5AyHwqzDUX4Z2U1CUFaLfpD8dhGj5wmoV00qMXJJ
         PyGg==
X-Gm-Message-State: AOAM531Po77/NxgFvgmKdtjq16IPEcAGgmv2BcX2rYlKcef7vYhIfk4U
        dP2uP0idPzzNepffj6SZkAEo/A==
X-Google-Smtp-Source: ABdhPJy4TQnKuFecqxFoIlEfztLPuXcjzFwaiFkqmvuxoQO+VS6qVLl59Uri6H53MV/Z29iViIl6mw==
X-Received: by 2002:a17:907:170c:: with SMTP id le12mr41029420ejc.288.1626889615495;
        Wed, 21 Jul 2021 10:46:55 -0700 (PDT)
Received: from myrica (adsl-84-226-111-173.adslplus.ch. [84.226.111.173])
        by smtp.gmail.com with ESMTPSA id qo6sm8570087ejb.122.2021.07.21.10.46.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jul 2021 10:46:55 -0700 (PDT)
Date:   Wed, 21 Jul 2021 19:46:34 +0200
From:   Jean-Philippe Brucker <jean-philippe@linaro.org>
To:     Oliver Upton <oupton@google.com>
Cc:     Alexandru Elisei <Alexandru.Elisei@arm.com>,
        salil.mehta@huawei.com, lorenzo.pieralisi@arm.com,
        kvm@vger.kernel.org, corbet@lwn.net, maz@kernel.org,
        linux-kernel@vger.kernel.org, jonathan.cameron@huawei.com,
        catalin.marinas@arm.com, pbonzini@redhat.com, will@kernel.org,
        kvmarm@lists.cs.columbia.edu, linux-arm-kernel@lists.infradead.org
Subject: Re: [RFC PATCH 0/5] KVM: arm64: Pass PSCI to userspace
Message-ID: <YPhdehJ2m/EEGkdT@myrica>
References: <20210608154805.216869-1-jean-philippe@linaro.org>
 <c29ff5c8-9c94-6a6c-6142-3bed440676bf@arm.com>
 <YPW+Hv3r586zKxpY@myrica>
 <CAOQ_QsjyP0PMGOorTss2Fpn011mHPwVqQ72x26Gs2L0bg2amsQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOQ_QsjyP0PMGOorTss2Fpn011mHPwVqQ72x26Gs2L0bg2amsQ@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 19, 2021 at 12:37:52PM -0700, Oliver Upton wrote:
> On Mon, Jul 19, 2021 at 11:02 AM Jean-Philippe Brucker
> <jean-philippe@linaro.org> wrote:
> > We forward the whole PSCI function range, so it's either KVM or userspace.
> > If KVM manages PSCI and the guest calls an unimplemented function, that
> > returns directly to the guest without going to userspace.
> >
> > The concern is valid for any other range, though. If userspace enables the
> > HVC cap it receives function calls that at some point KVM might need to
> > handle itself. So we need some negotiation between user and KVM about the
> > specific HVC ranges that userspace can and will handle.
> 
> Are we going to use KVM_CAPs for every interesting HVC range that
> userspace may want to trap? I wonder if a more generic interface for
> hypercall filtering would have merit to handle the aforementioned
> cases, and whatever else a VMM will want to intercept down the line.
> 
> For example, x86 has the concept of 'MSR filtering', wherein userspace
> can specify a set of registers that it wants to intercept. Doing
> something similar for HVCs would avoid the need for a kernel change
> each time a VMM wishes to intercept a new hypercall.

Yes we could introduce a VM device group for this:
* User reads attribute KVM_ARM_VM_HVC_NR_SLOTS, which defines the number
  of available HVC ranges.
* User writes attribute KVM_ARM_VM_HVC_SET_RANGE with one range
  struct kvm_arm_hvc_range {
          __u32 slot;
  #define KVM_ARM_HVC_USER (1 << 0) /* Enable range. 0 disables it */
          __u16 flags;
	  __u16 imm;
          __u32 fn_start;
          __u32 fn_end;
  };
* KVM forwards any HVC within this range to userspace.
* If one of the ranges is PSCI functions, disable KVM PSCI.

Since it's more work for KVM to keep track of ranges, I didn't include it
in the RFC, and I'm going to leave it to the next person dealing with this
stuff :)

Thanks,
Jean
