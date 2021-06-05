Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B4C839C768
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Jun 2021 12:26:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230097AbhFEK2V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Jun 2021 06:28:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229902AbhFEK2U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Jun 2021 06:28:20 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFCE9C061767
        for <linux-kernel@vger.kernel.org>; Sat,  5 Jun 2021 03:26:16 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id k15so9287181pfp.6
        for <linux-kernel@vger.kernel.org>; Sat, 05 Jun 2021 03:26:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=A7dQxJYaCXMIhpLLE5OL3sgALzOxVshV1s/+sLvv2mA=;
        b=OfAr6bXPncM5uCFphXI3MFVT/USlPReB4Lv8lg9guId8a5OyRnU3TmEG268l1svDiJ
         zUwbjqFmUagVzzvnEjoHMWg4peiz3tmUEy+NrpqiERcrK0cQPtfYOlfrvbho+hVfe590
         sBIU+3QRk0cfCwuQEx3Gz7m2viUmv5GHIO2Rg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=A7dQxJYaCXMIhpLLE5OL3sgALzOxVshV1s/+sLvv2mA=;
        b=A8w3D2cJYK8TCM5YAaJlZKSKxTfFYjOlhpTZxIeEonvxUQ13g4xyYiHUCWIi6AapEo
         fUnngtuFlx0QiO+J2+08G6KhBLNnD/EKW12Ow8T3Wun6A9OOFUZ1ajqGt0PVWSPZaPtk
         mzSPJeHBWBkdD0FKCV3BqypIF2fOi6gn/gYEGqCAOc+GnAtWIyuLoIQBln1YIU80efAC
         dTdijbylIOj3PLPeCA59oXa7Zduig6SSBPbuALZhFUppUkOTvK+myi2C8vroIIFsOINa
         QWH65+/hI84kTn9/oWZ/ou7nb8IEAOIECT/bCK9gMkDEdZYyOBZMyd4uW3rbpP/KgvaV
         ozBw==
X-Gm-Message-State: AOAM5317NrWUkMtDglLt/rkB6FDfxc0jDiqq72yG85eqZ+3kSwqfmZyV
        s6pDcZnGyOGJG75VKHglCY/ULQ==
X-Google-Smtp-Source: ABdhPJyVnf1Sfj9IsodJVK9bc2KmHiVTZ1LFECsZ//Q95AMgY73GH+UrJw92aQL39XgpHtR6Pw2eYw==
X-Received: by 2002:a63:db17:: with SMTP id e23mr9327049pgg.274.1622888776525;
        Sat, 05 Jun 2021 03:26:16 -0700 (PDT)
Received: from google.com ([2409:10:2e40:5100:5981:261e:350c:bb45])
        by smtp.gmail.com with ESMTPSA id j10sm6815520pjb.36.2021.06.05.03.26.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Jun 2021 03:26:16 -0700 (PDT)
Date:   Sat, 5 Jun 2021 19:26:11 +0900
From:   Sergey Senozhatsky <senozhatsky@chromium.org>
To:     Marc Zyngier <maz@kernel.org>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Suleiman Souhlal <suleiman@google.com>, x86@kernel.org,
        kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCHv2 2/2] kvm: x86: implement KVM PM-notifier
Message-ID: <YLtRQ/uYQoVbve0v@google.com>
References: <20210605023042.543341-1-senozhatsky@chromium.org>
 <20210605023042.543341-2-senozhatsky@chromium.org>
 <87k0n8u1nk.wl-maz@kernel.org>
 <YLtK09pY1EjOtllS@google.com>
 <YLtL/JPvGs2efZKO@google.com>
 <87im2sty5k.wl-maz@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87im2sty5k.wl-maz@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (21/06/05 11:15), Marc Zyngier wrote:
> > For the time being kvm_set_guest_paused() errors out when
> > !vcpu->arch.pv_time_enabled, but this probably can change in the
> > future (who knows?).  So shall I check vcpu->arch.pv_time_enabled in
> > kvm_arch_suspend_notifier()?
> 
> That, or check for the -EINVAL return value.

I suppose this should do the trick then (hate to do `int ret = 0`,
but we can have no VCPUs with enabled pv_time)

---

+static int kvm_arch_suspend_notifier(struct kvm *kvm)
+{
+       struct kvm_vcpu *vcpu;
+       int i, ret = 0;
+
+       mutex_lock(&kvm->lock);
+       kvm_for_each_vcpu(i, vcpu, kvm) {
+               if (!vcpu->arch.pv_time_enabled)
+                       continue;
+
+               ret = kvm_set_guest_paused(vcpu);
+               if (ret) {
+                       pr_err("Failed to pause guest VCPU%d: %d\n",
+                              vcpu->vcpu_id, ret);
+                       break;
+               }
+       }
+       mutex_unlock(&kvm->lock);
+
+       return ret ? NOTIFY_BAD : NOTIFY_DONE;
+}
