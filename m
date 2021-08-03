Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 620FF3DEB42
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Aug 2021 12:52:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235503AbhHCKwF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Aug 2021 06:52:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235059AbhHCKwD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Aug 2021 06:52:03 -0400
Received: from mail-ot1-x332.google.com (mail-ot1-x332.google.com [IPv6:2607:f8b0:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B69BC061757
        for <linux-kernel@vger.kernel.org>; Tue,  3 Aug 2021 03:51:52 -0700 (PDT)
Received: by mail-ot1-x332.google.com with SMTP id c7-20020a9d27870000b02904d360fbc71bso20226259otb.10
        for <linux-kernel@vger.kernel.org>; Tue, 03 Aug 2021 03:51:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WUxc5MB+Tq9hVrzE0x/FFFlgnTm10UXPxyV+GzRqkrU=;
        b=vEGntt1HAENdzj7VnMWn1fUB6jPHul3UT5wMP8S8Tb6a+ytZly9lG4RVFX/gfhuAng
         ARWKq53znmro8GS9NNAmLHkaTgkUuO8k85Ag/VbXZ5iKHpWVFt8fNh0VsYs8yV+MajiF
         uZjAnHsvi4AAm23IdbL96IZgZiQD6pEwQL4Fn3RgacC2PeQSLzbsDE8Q62jSHkvDXiBa
         FfSlcBIYI0w7/26HnO32BO3oEaMEXEQ4mxW+EibsRnAW7vinAxjvGtG+i2uYkASGVUTK
         fxG1ViAkBlY5o5sKtV7ntAKMPOsk0mJ/HbArVU1/HIgiDGYHsGaQwGWoHDIH3gxp9o20
         SUHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WUxc5MB+Tq9hVrzE0x/FFFlgnTm10UXPxyV+GzRqkrU=;
        b=atk6ktWmgwPytEjfALkr4qWkkFWE7WxMQwJTqu0H6cco3oJXA/B2C/TNOaCVApe5ML
         d8qeoWSIzFiUfjFvdhBVxVeQvRVEXeVAdE6JqRrf6EilPELU0ELSvkATAwuuR20kVbWg
         md0WqdnM+oCTJfZ8sMLprQsNre91KL6KHbnBvGZgsf5So6PF6MoLaJt5ypifkq1Na9tj
         pIDLY9KSkDjdbhRzAwF6NbQRWuIgrNcwbFKZ+9gJpOJHpgQj7Z0Ss3CXK2viuWoRJNpT
         5viPetXMGPb796Ul3SS7uUxe9tjexpTEQhaxtwjGxzclFx6GD+aKNenga7BLzBx/GOP/
         dAhA==
X-Gm-Message-State: AOAM532aIhgQFC1NH5S6qyjEcxnxgyrApqAi2Yhsixy6StWJY2W5Ki9j
        YwJoZz4e9L2Iv/oE91rogpLFzBps3UFC093wDvU4aw==
X-Google-Smtp-Source: ABdhPJxvZT6TZfQaKjA6ySTyD8WZ6X/uh3f6kHY+xaZ5tPnSjzoDuCwt+rtQflv2skumMaQuDNbtoJ1oPtX8ZEwIuV4=
X-Received: by 2002:a9d:202d:: with SMTP id n42mr1249812ota.52.1627987911567;
 Tue, 03 Aug 2021 03:51:51 -0700 (PDT)
MIME-Version: 1.0
References: <20210729132818.4091769-1-qperret@google.com> <20210729132818.4091769-20-qperret@google.com>
 <CA+EHjTwWt+jvRZsk5KEhQWzn+XqdV2gZSq7oCuOCVXRa1=JiWw@mail.gmail.com> <YQkcUXnrqp7hsZZT@google.com>
In-Reply-To: <YQkcUXnrqp7hsZZT@google.com>
From:   Fuad Tabba <tabba@google.com>
Date:   Tue, 3 Aug 2021 12:51:14 +0200
Message-ID: <CA+EHjTye7hA7XqGSx5DvqXAcVaA9HYkC-rqeQ5fnQY7MdpHkFw@mail.gmail.com>
Subject: Re: [PATCH v3 19/21] KVM: arm64: Refactor protected nVHE stage-1 locking
To:     Quentin Perret <qperret@google.com>
Cc:     maz@kernel.org, james.morse@arm.com, alexandru.elisei@arm.com,
        suzuki.poulose@arm.com, catalin.marinas@arm.com, will@kernel.org,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu,
        linux-kernel@vger.kernel.org, ardb@kernel.org, qwandor@google.com,
        dbrazdil@google.com, kernel-team@android.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Quentin,

> > > +int pkvm_create_mappings(void *from, void *to, enum kvm_pgtable_prot prot)
> > > +{
> > > +       int ret;
> > > +
> > > +       hyp_spin_lock(&pkvm_pgd_lock);
> > > +       ret = pkvm_create_mappings_locked(from, to, prot);
> > > +       hyp_spin_unlock(&pkvm_pgd_lock);
> > > +
> > > +       return ret;
> > > +}
> > > +
> >
> > I'm wondering whether this patch should also refactor
> > __pkvm_create_mappings. It doesn't quite do the exact same thing and
> > has different parameters.
>
> Sorry, not sure I'm understanding your suggestion here. What do you
> think should be done to __pkvm_create_mappings?

Sorry, my comment wasn't very clear, and "refactor" is the wrong word.
I think it should probably be renamed, because __pkvm_create_mappings
isn't called by pkvm_create_mappings nor by
pkvm_create_mappings_locked. It also has different parameters and
behaves slightly differently.

Thanks,
/fuad

> Cheers,
> Quentin
