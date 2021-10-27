Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C709E43CFC4
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Oct 2021 19:32:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236974AbhJ0RfX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Oct 2021 13:35:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229612AbhJ0RfW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Oct 2021 13:35:22 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9F4CC061570
        for <linux-kernel@vger.kernel.org>; Wed, 27 Oct 2021 10:32:56 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id r4so13054243edi.5
        for <linux-kernel@vger.kernel.org>; Wed, 27 Oct 2021 10:32:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XuOlL+WlhxFREjULrbNCzcikysHZz3+YPdS+RvWZfUo=;
        b=c4KKAVWMDFDHdzGcuWzrk10Xnrm2SRrpxNNb/S2HmpT+FywEuTMooMePKQ0AjuXPs/
         /cM5Yg/FIowQgbY51NlN2jfvG7tDHsf8Xnm8W6LMVDe/u81UQR5SIi+X83Xk7WxvUEie
         x8Ye3JJNmsZIsJN+xaM6SaAs0ivtBkcFxQCXlJ4ehELzn2eSfRTlMBilLwIdT9tY4X5K
         SJGcOUxtWcAi4lwoOFFiR4glQRpkxedUFTDj9tcYyT7DPsv2q1IpR3gGMDIerQKrD2w2
         m/mOwW/xImz1Z6lTgs2qN4MUNPmTpisuBa0stfHs3+WehK57x5v5gGF/kvfLV2MvCbWX
         sGyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XuOlL+WlhxFREjULrbNCzcikysHZz3+YPdS+RvWZfUo=;
        b=LCTYqBjcjvm7gv9437rzX9jjciQpMtRvS8M5Tu5P+LmK5MUnpDxv7fZVXyinXo6Dny
         VDblDoCW6elLYRFRBY3MmC3oT6vZ7qaTgid2BYmIgSyuYHIzi3DkykIx+aKbn1Y6m5Wt
         YhGU920wLzhm8wfUVqN0RtIEagOcxoXKH6TBmrERfzgSKLwxI7TZ++CXMQ7zvVSqDg0f
         mC03L1stQnq2MHsNGsjyhjU7j3QvrdcinHbphxjG6jjMS0Hbvx1i3ddkQaOUziVcQaeA
         oTWXPqYbxCYgmEx8kcLOevAFi2aqM73kb+CDaDRdmkFRgIoMci/PNv+TDoClNV+E8eCa
         gmsA==
X-Gm-Message-State: AOAM533j4fTNhOLSCocr1eGlOx4YMGyOA97wNlSznZNuxL14elh4o8+9
        sHla92UsblDrh0pBGuI5BE4bWR6mNCTEAcYsFg/wmaMvGf4=
X-Google-Smtp-Source: ABdhPJwMYvuaNNgqFocoQJYPD33Ldz/Pq6TA+N37frKX/f379Ky8+VSiqUf+I6Ba2Qi7OOx9YtrDa9NzHrGVxBey4wM=
X-Received: by 2002:a50:da4e:: with SMTP id a14mr46853368edk.154.1635355975260;
 Wed, 27 Oct 2021 10:32:55 -0700 (PDT)
MIME-Version: 1.0
References: <20211026195545.3951306-1-mathieu.poirier@linaro.org> <YXj2trHe8XA0QtFO@kroah.com>
In-Reply-To: <YXj2trHe8XA0QtFO@kroah.com>
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
Date:   Wed, 27 Oct 2021 11:32:43 -0600
Message-ID: <CANLsYkwcUbV-kX3yZt6K0rK9PBUpkW=fp2_Y5Bd3+fCgxZr4EA@mail.gmail.com>
Subject: Re: [GIT PULL v2] Coresight changes for v5.16
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Coresight ML <coresight@lists.linaro.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 27 Oct 2021 at 00:50, Greg KH <gregkh@linuxfoundation.org> wrote:
>
> On Tue, Oct 26, 2021 at 01:55:45PM -0600, Mathieu Poirier wrote:
> > The following changes since commit 5816b3e6577eaa676ceb00a848f0fd65fe2adc29:
> >
> >   Linux 5.15-rc3 (2021-09-26 14:08:19 -0700)
> >
> > are available in the Git repository at:
> >
> >   git@gitolite.kernel.org:pub/scm/linux/kernel/git/coresight/linux.git tags/coresight-next-v5.16
>
> Better but I get the following errors when my scripts try to merge them.
> Note, the linux-next scripts will give you the same complaint, so this
> isn't a new thing:

Can you point me to the linux-next script you are referring to above?
Usually when that happens I get an email but this time I didn't get
anything.

>
> Commit 6871138a7ab9 ("coresight: etm4x: Add ETM PID for Kryo-5XX")
>         committer Signed-off-by missing
>         author email:    quic_taozha@quicinc.com
>         committer email: mathieu.poirier@linaro.org
>         Signed-off-by: Tao Zhang <quic_taozha@quicinc.com>
>         Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
>
> Commit 202d403ae3a9 ("coresight: Don't immediately close events that are run on invalid CPU/sink combos")
>         committer Signed-off-by missing
>         author email:    james.clark@arm.com
>         committer email: mathieu.poirier@linaro.org
>         Signed-off-by: James Clark <james.clark@arm.com>
>         Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
>
> Commit ef095e61dc8f ("coresight: Update comments for removing cs_etm_find_snapshot()")
>         committer Signed-off-by missing
>         author email:    leo.yan@linaro.org
>         committer email: mathieu.poirier@linaro.org
>         Signed-off-by: Leo Yan <leo.yan@linaro.org>
>         Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
>
> Commit 7be15eef996f ("coresight: tmc-etr: Use perf_output_handle::head for AUX ring buffer")
>         committer Signed-off-by missing
>         author email:    leo.yan@linaro.org
>         committer email: mathieu.poirier@linaro.org
>         Signed-off-by: Leo Yan <leo.yan@linaro.org>
>         Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
>
> Commit 60067d5ab339 ("coresight: tmc-etf: Add comment for store ordering")
>         committer Signed-off-by missing
>         author email:    leo.yan@linaro.org
>         committer email: mathieu.poirier@linaro.org
>         Signed-off-by: Leo Yan <leo.yan@linaro.org>
>         Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
>
> Commit 7c202525ff8c ("coresight: tmc-etr: Add barrier after updating AUX ring buffer")
>         committer Signed-off-by missing
>         author email:    leo.yan@linaro.org
>         committer email: mathieu.poirier@linaro.org
>         Signed-off-by: Leo Yan <leo.yan@linaro.org>
>         Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
>
> Errors in tree with Signed-off-by, please fix!
>
>
> Is there some reason you are committing changes to your tree and not signing
> off on them?  That's not really a good idea :(
>

Not sure why sarcasm is required here - simply pointing out the
problem would have been sufficient.

These patches were committed by Suzuki who co-maintains the subsystem
with me.  The committer information likely got transferred when I
cherry-picked the patches when putting the pull request together.

> thanks,
>
> greg k-h
