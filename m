Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 547803446FB
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Mar 2021 15:20:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230406AbhCVOUA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Mar 2021 10:20:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229591AbhCVOTx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Mar 2021 10:19:53 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4826C061574
        for <linux-kernel@vger.kernel.org>; Mon, 22 Mar 2021 07:19:52 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id b9so17119145wrt.8
        for <linux-kernel@vger.kernel.org>; Mon, 22 Mar 2021 07:19:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=pu5z42QVaf24rLBi+z7TEIvMrv7JJaCJisu7Lt46g5A=;
        b=lIcT4jmSofsgtqFJrXxirehwOaHWSwyzdqjqm1XPXPhEXg3cn1xRv4m2ZG+JCrJaQE
         yYC241C904ty8cKHg+Zy/awmqiLeS6JesA+2eVGgmMi5S4TIDscPM/ci8H9HV6uUh5Gk
         rTqny3M4uk9AYDfZIkdMvsKdUgF76tZpEgpPz66d6WHonw7NAiTG7SdH/N3aOVPN6Pbn
         abIO9COUceKtdP4HQc+FxP8n+rFFhpEIjYTDV0Y696YpBrmWTHVRdKByFsOWQi6oHOWo
         tv3ry/HLxKt4iQ+CCvBuKw3X1TI4Yl7piOctl625KVXmshHcmonC3MkDBGR9IruWqEEt
         Gosw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=pu5z42QVaf24rLBi+z7TEIvMrv7JJaCJisu7Lt46g5A=;
        b=LtG2ydeUU5AvXihvlQFaPRzhjl6vNwCDc9FMrCsSW5CCRxiBl8B6LM0GF2IlrEbUU0
         n6QsOfyMtHuYqyy+4b2F9r0EBThAMoToHktf7p30RJJeS6dVE8MguLcBqjpUs+p0qDS1
         FRzEST5zp8n14KwQc0dvL2ade9q0CZuZJGaFu+vlf6Y7alb/yyKV0URnWFl8ls7UlZ1a
         Vgu2Lq2wt2V/l3mljbckX/O+wqFp9YnTlj+2eMGp1zYJCNrmMMG5ceu2AYTZz9S7mU1r
         YkbN+Rqw7yO+OI962TfZdxDe/XmFkSUn4mWM7yHcORjVRrlvvaGt7ci+q/6yEA44S27o
         6SCQ==
X-Gm-Message-State: AOAM531wYgMnWkHvJl22cGBPkoEtUc41ztkcCrPlGE85BZ0QE/QsCMz0
        w1G9UG+DfB7ecl6ghpHogLD6cg==
X-Google-Smtp-Source: ABdhPJwj8gq5zhlHMExf+1jG9iBIEkRK4vGue0nQMyroI0Z5Wmndn2pz4FSD9q7V5hqtn9QMvKeA6Q==
X-Received: by 2002:a5d:6c67:: with SMTP id r7mr18514820wrz.373.1616422791417;
        Mon, 22 Mar 2021 07:19:51 -0700 (PDT)
Received: from google.com (230.69.233.35.bc.googleusercontent.com. [35.233.69.230])
        by smtp.gmail.com with ESMTPSA id v3sm16837255wmj.25.2021.03.22.07.19.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Mar 2021 07:19:51 -0700 (PDT)
Date:   Mon, 22 Mar 2021 14:19:48 +0000
From:   Quentin Perret <qperret@google.com>
To:     Marc Zyngier <maz@kernel.org>
Cc:     catalin.marinas@arm.com, will@kernel.org, james.morse@arm.com,
        julien.thierry.kdev@gmail.com, suzuki.poulose@arm.com,
        android-kvm@google.com, seanjc@google.com, mate.toth-pal@arm.com,
        linux-kernel@vger.kernel.org, robh+dt@kernel.org,
        linux-arm-kernel@lists.infradead.org, kernel-team@android.com,
        kvmarm@lists.cs.columbia.edu, tabba@google.com, ardb@kernel.org,
        mark.rutland@arm.com, dbrazdil@google.com
Subject: Re: [PATCH v6 13/38] KVM: arm64: Enable access to sanitized CPU
 features at EL2
Message-ID: <YFinhL6hHWwT7ztb@google.com>
References: <20210319100146.1149909-1-qperret@google.com>
 <20210319100146.1149909-14-qperret@google.com>
 <87o8fbgv5l.wl-maz@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87o8fbgv5l.wl-maz@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hey Marc,

On Monday 22 Mar 2021 at 13:44:38 (+0000), Marc Zyngier wrote:
> I can't say I'm thrilled with this. Actually, it is fair to say that I
> don't like it at all! ;-)

:-)

> Copying whole structures with pointers that
> make no sense at EL2 feels... wrong.

And I don't disagree at all. I tried to keep this as small as possible
as the series is already quite intrusive, but I certainly understand the
concern.

> As we discussed offline, the main reason for this infrastructure is
> that the read_ctr macro directly uses arm64_ftr_reg_ctrel0.sys_val
> when ARM64_MISMATCHED_CACHE_TYPE is set.

Indeed that is the only reason.

> One thing to realise is that with the protected mode, we can rely on
> patching as there is no such thing as a "late" CPU. So by specialising
> read_ctr when compiled for nVHE, we can just make it give us the final
> value, provided that KVM's own __flush_dcache_area() is limited to
> protected mode.
> 
> Once this problem is solved, this whole patch can mostly go, as we are
> left with exactly *two* u64 quantities to be populated, something that
> we can probably do in kvm_sys_reg_table_init().
> 
> I'll post some patches later today to try and explain what I have in
> mind.

Sounds great, thank you very much for the help!
Quentin
