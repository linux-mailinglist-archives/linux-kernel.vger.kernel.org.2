Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 86AD338CA8B
	for <lists+linux-kernel@lfdr.de>; Fri, 21 May 2021 18:03:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232094AbhEUQEu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 May 2021 12:04:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229586AbhEUQEq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 May 2021 12:04:46 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12AB5C061574
        for <linux-kernel@vger.kernel.org>; Fri, 21 May 2021 09:03:21 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id q3so269567lfu.2
        for <linux-kernel@vger.kernel.org>; Fri, 21 May 2021 09:03:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yiSHm/i0ntIC7XV9xeKxtIeUyYju4T+JD0ZeRfIjKFo=;
        b=pqRuS9toNOMN69IxAEDNhxeuDceaDJikh7Bd9vsb5rOXAkMuzb6Lp0xwKixYtSucz4
         On6UNZ4deHHb1i0M3LzSaYQfA7kIvKWCB99LZx92cM0p+krKQ8Zokd4uiwEMhz3Cn1MV
         zzBh3tP35+2CiLcY/YR3pXRE1+ICooRpQMA7HewKmDPH2aMnxJS7hDdieFteC4gnxEbG
         TBCpDqjgzCjBi/dYIq4geI4rUyZS+Bkv5g06oMAH+mzcoN73Xh56oIIsXuscPPOuRM2H
         Xvviqoq1CQGRCmrGvLcEoJhzjFpKBwaIZJODSWnVX0w72c9HyhCJ8sn1+qFynfamm0jD
         EZHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yiSHm/i0ntIC7XV9xeKxtIeUyYju4T+JD0ZeRfIjKFo=;
        b=EADqWrnqzME04LKNy76dYbJ/RAYq8z7ZIHwMnZm9gF4CWIvs2DAQg8UCfNzX1FX4VX
         gwSQUSt6yeQJtxjUEnq8yKd0w7rLMxg2VqRW3evk2vZHMRGsyiOLVZB277knhhbMqKvB
         LgzUGH67m/p+vgd93oZQ2Zc8kdVpo2mnVVakFMxf+6DWYzHzx2oDUriSCzuymq68sCqV
         8BpcREVbfAdv3q+ObYWDA6++UhceMI7B/pGBEufmG5+PC6Hqev/sHM6mIaFH37/+McRt
         7u0VUWC/4S+yUDgsqwICGb+hywLnkoit+eQbcVa32TEMuSksybpunWx/tVT4Ahj5fVTp
         7wUA==
X-Gm-Message-State: AOAM530HWqYxzzhQRTA+zuXaIBU0suMNnPSUSXhPY4jKH//xkcOiU7M2
        4GowuwlBQZp0pSYMCxXmP/pECx6ewJHk+u+PgNXfvg==
X-Google-Smtp-Source: ABdhPJxXq0B6Vn9HMEOppK94x/UHgrXEDhu0rEkT2EJkihbrQyKoQ2ii57nIv7CFq4aUMptuOh6rwPZwTt1/EL3b/+U=
X-Received: by 2002:ac2:520a:: with SMTP id a10mr2710768lfl.180.1621612999247;
 Fri, 21 May 2021 09:03:19 -0700 (PDT)
MIME-Version: 1.0
References: <20210520183614.1227046-1-posk@google.com> <87mtspm7fe.fsf@meer.lwn.net>
 <CAPNVh5eV+CtY74_JMv6_Bm5aCVBh_F9hkWLT6v3BT=H0UwodUg@mail.gmail.com> <87eee0m8ez.fsf@meer.lwn.net>
In-Reply-To: <87eee0m8ez.fsf@meer.lwn.net>
From:   Peter Oskolkov <posk@google.com>
Date:   Fri, 21 May 2021 09:03:07 -0700
Message-ID: <CAPNVh5fhkgscs44Lpj3DPBrA9NrhFohUpRwpT2iMM1BDBcLW4A@mail.gmail.com>
Subject: Re: [RFC PATCH v0.1 0/9] UMCG early preview/RFC patchset
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-api <linux-api@vger.kernel.org>,
        Paul Turner <pjt@google.com>, Ben Segall <bsegall@google.com>,
        Peter Oskolkov <posk@posk.io>,
        Joel Fernandes <joel@joelfernandes.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andrei Vagin <avagin@google.com>,
        Jim Newsome <jnewsome@torproject.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 21, 2021 at 8:08 AM Jonathan Corbet <corbet@lwn.net> wrote:

[...]
> Documentation patches can help to guide that discussion; they also need
> to be reviewed as well.  So yes, I think they should be present from the
> beginning.  But then, that's the position I'm supposed to take :)  This
> is a big change to the kernel's system-call API, I don't think that
> there can be a proper discussion of that without a description of what
> you're trying to do.

Hi Jon,

There are doc comments in patches 2 and 7 in umcg.c documenting the
new syscalls. That said, I'll prepare a separate doc patch - I guess
I'll add Documentation/scheduler/umcg.rst, unless you tell me there is
a better place to do that. ETA mid-to-late next week.

Thanks,
Peter
