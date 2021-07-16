Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D32E3CB36E
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jul 2021 09:41:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235806AbhGPHoP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jul 2021 03:44:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231482AbhGPHoL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jul 2021 03:44:11 -0400
Received: from mail-oi1-x22c.google.com (mail-oi1-x22c.google.com [IPv6:2607:f8b0:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD278C06175F
        for <linux-kernel@vger.kernel.org>; Fri, 16 Jul 2021 00:41:16 -0700 (PDT)
Received: by mail-oi1-x22c.google.com with SMTP id s23so9965094oij.0
        for <linux-kernel@vger.kernel.org>; Fri, 16 Jul 2021 00:41:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Ca6CcvN4gIl6bM0OQN4a/p1N8Quw1yYHoBlszGmTDtE=;
        b=cJEwK2QZoEZVNRqMgFxuAMHjjr7LvTj5v11fSzSXH2VZPZmb2hUeSjnN7cV0bAvNWk
         jJw4AaFssxttPPh9VwQnLrmiOGFgTWoEU1BdGl1KV5PAoOKy9dDi2Zbi7z02JbIjoAhK
         bf3qJve9Q8u7N4d/ESrdxOqPlv5deUPC690mwtSW02mV5dON8BBw2WNkms6TaTKio+ZF
         a6hKmgaiDadaxV5NHWpw5OJKQge2EL8T+qBg2+8o4NpdE58FuAOrggNaQ8FzkIsiOWy5
         sguytO782IJ/XyTpuGL0pkBeflviTjXs0R1j31HCf40NnfshpUL+m/qWnF6+rqXnSiUR
         0Uag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Ca6CcvN4gIl6bM0OQN4a/p1N8Quw1yYHoBlszGmTDtE=;
        b=hsCpk52RIE8Lt0l1YiqixW4D0H0fIe13YJQSsfRmKOLgjzgxZadcOGSQdSDguvQl3z
         i4/VIYOjUFDKAt1IEZSdxtnivaEUQKNBYvaZJgdXzvWMP+sMPdNYXbNgED2728KDqwkv
         JAek4Bys09KhYFxQ3LqYY1Fr+vII0dCSbi7SaVMn/HmNxT/Uk3bzCp/mhoUFfeBVvzqf
         5sTLNmeF03WQtY/BC4mErRVm3C88/r5twbfXnO8kHVdgMiXpwlhcF/N3q75I3N56HnkA
         7KoDu05vwmGC5ahbRWcP9tGvifQUT4/XFggdTa8jXVgISkJCwAvLLtId9FQLOvo5foe1
         xznA==
X-Gm-Message-State: AOAM533tZGp9yD+b+cvkfHNtGudpeBs0jTu07aqL69J88KGD1DsvZByv
        Z9OZRP3MyMxU9m4HjnKOT9gq9ZVXgke13BYqZ62AeA==
X-Google-Smtp-Source: ABdhPJxBWTmGlDkF7S1AqiTmH9Cd+D/mTMI4k9X8kqeRo356YrvpiRZDCXLjYWwaF16sDCvsMXzX8cafSQosjBHRUOU=
X-Received: by 2002:aca:fd44:: with SMTP id b65mr6942794oii.172.1626421275836;
 Fri, 16 Jul 2021 00:41:15 -0700 (PDT)
MIME-Version: 1.0
References: <20210705111453.164230-1-wangkefeng.wang@huawei.com>
 <20210705111453.164230-4-wangkefeng.wang@huawei.com> <YOMfcE7V7lSE3N/z@elver.google.com>
 <089f5187-9a4d-72dc-1767-8130434bfb3a@huawei.com> <5f760f6c-dcbd-b28a-2116-a2fb233fc534@huawei.com>
In-Reply-To: <5f760f6c-dcbd-b28a-2116-a2fb233fc534@huawei.com>
From:   Marco Elver <elver@google.com>
Date:   Fri, 16 Jul 2021 09:41:04 +0200
Message-ID: <CANpmjNP8Js3nKeVfwPqV7oQaBbGebKxFYRWe8TifTduP2q86xA@mail.gmail.com>
Subject: Re: [PATCH -next 3/3] kasan: arm64: Fix pcpu_page_first_chunk crash
 with KASAN_VMALLOC
To:     Kefeng Wang <wangkefeng.wang@huawei.com>
Cc:     Dmitry Vyukov <dvyukov@google.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kasan-dev@googlegroups.com, linux-mm@kvack.org,
        Daniel Axtens <dja@axtens.net>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 16 Jul 2021 at 07:06, Kefeng Wang <wangkefeng.wang@huawei.com> wrote:
> Hi Marco and Dmitry, any comments about the following replay, thanks.

Can you clarify the question? I've been waiting for v2.

I think you said that this will remain arm64 specific and the existing
generic kasan_populate_early_shadow() doesn't work.

If there's nothing else that needs resolving, please go ahead and send
v2 (the __weak comment still needs resolving).

Thanks,
-- Marco
