Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 040D9402094
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Sep 2021 22:05:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243755AbhIFT6D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Sep 2021 15:58:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231432AbhIFT6C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Sep 2021 15:58:02 -0400
Received: from mail-yb1-xb2c.google.com (mail-yb1-xb2c.google.com [IPv6:2607:f8b0:4864:20::b2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0E70C061575
        for <linux-kernel@vger.kernel.org>; Mon,  6 Sep 2021 12:56:57 -0700 (PDT)
Received: by mail-yb1-xb2c.google.com with SMTP id a93so15458834ybi.1
        for <linux-kernel@vger.kernel.org>; Mon, 06 Sep 2021 12:56:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xaieRye1AeYugSPI36l1iJTAUqlrY3yw60sYt+VY7So=;
        b=owYtIrdgFhnYEPiIVu/2YoEohn98+TOeR5b0yYti2jQJ+RZHA63ZsQZ/i6EFbNK/Z9
         9y9hvVi2vcnXI0cQYKqV1mswbRtNK591SG/xL4Vb1vFIjBASEvkwLe/ARbUxh6k4hGqk
         FROLqendx80BAH9hzh3PHgzivzrOC6OEThNKXT6ddElJ4EWfXl1csEq6QCKXOl/Hrb3i
         YBmezf4cdA3hKb/Zu8674ri5ex4QfV/13vaOI3oSmab5kL4y35C7ksMNNrBhueM84E6A
         XA1UyX0iwhI3dCok61ccpxBSeKW6nL+cYiWlSkBdNSlzvPHDNYBzuxNgSXlba+l67UcQ
         7rYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xaieRye1AeYugSPI36l1iJTAUqlrY3yw60sYt+VY7So=;
        b=PWG1VYxuNSdK6emC1VNcxsfKuxBX5oKpW+z2eI5NKNw6qaV2bNCAnun5dp6zM6uism
         BTHy+/MIuT7OThxvwrjdBaFlKPvUan+3sCEjxRkPawZSmN32Bojx8C7wMNVV6hEiw6j8
         Qgr5Y9gRTXgifa2w21R1DB9oXyCXOeqXou3LBKOctoh9VQKH71QydBhbv3Mp2oeAHeue
         S30hxp59lumL6WLFMreUM0PSIb76z/fFwA9idc4morJUEFBPDpyWB2HINEkawDupZegY
         5pmdtvvCvUV9or3O6KofFiQOhNzbAW9wohRcwW9594YgmkjF6q3z2KkOhllOMi00zyyV
         d74Q==
X-Gm-Message-State: AOAM531OSBpR+gkMDiGw26w56E1gPMbKt9LE71EZFu/Kwq7K1ck1xa0h
        ZqR7PEWC1JUkbm8w8vRbGwGGzemK+GBTqYQw7CI2Zw==
X-Google-Smtp-Source: ABdhPJzRQzl8K/3M0uB4Gy1BOL0qXo4S9LDLwtYnf3xODXKZOoKSyv75E1AQ/hr3Ilb3wXtUqAVXg0Ct688vpTSKZSw=
X-Received: by 2002:a25:500c:: with SMTP id e12mr18963036ybb.30.1630958216940;
 Mon, 06 Sep 2021 12:56:56 -0700 (PDT)
MIME-Version: 1.0
References: <20210829182641.2505220-1-mizhang@google.com> <20210829182641.2505220-2-mizhang@google.com>
 <YS5e4PGxu7tjiEBI@google.com>
In-Reply-To: <YS5e4PGxu7tjiEBI@google.com>
From:   Mingwei Zhang <mizhang@google.com>
Date:   Mon, 6 Sep 2021 12:56:46 -0700
Message-ID: <CAL715WJBMe8tPX=Tch_v=LiGNjPZpCqQVZKM=8GtzaJ_6Q1bXg@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] selftests: KVM: align guest physical memory base
 address to 1GB
To:     Sean Christopherson <seanjc@google.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>, kvm <kvm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        David Matlack <dmatlack@google.com>,
        Jing Zhang <jingzhangos@google.com>,
        Peter Xu <peterx@redhat.com>, Ben Gardon <bgardon@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> 1gb may not be appropriate for all architectures and we don't want to _just_
> test 1gb aligned memslots.  The alignment should be tied to the backing store,
> even if the test is hardcoded to use THP, that way the alignment logic works
> without modification if the backing store is changed.

Agree on that.
>
> I had a patch[1] that did this, let me go resurrect that series.  My series got
> put on the backburner in favor of Yanan's series[2] which did a much better
> job of identifying/handling the host virtual address alignment, but IIRC my
> approach for handling GPA was correct.
>
> [1] https://lore.kernel.org/kvm/20210210230625.550939-6-seanjc@google.com/
> [2] https://lkml.kernel.org/r/20210330080856.14940-1-wangyanan55@huawei.com
>

Thanks for the info. I will use patch [1] instead of mine in the next version.

Regards.
-Mingwei
