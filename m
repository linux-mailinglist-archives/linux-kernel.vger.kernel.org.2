Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D3B1E31C282
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Feb 2021 20:36:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230318AbhBOTfU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Feb 2021 14:35:20 -0500
Received: from mail.kernel.org ([198.145.29.99]:46658 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229930AbhBOTfS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Feb 2021 14:35:18 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id DED8064E31
        for <linux-kernel@vger.kernel.org>; Mon, 15 Feb 2021 19:34:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1613417678;
        bh=bWW3ztjLwdLysqq6kBGDDWGlZ+5T/kzIxKXxekKWt+Q=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=EJUw+3Hg5hxbrPb7P8Ia+rt5JMIPVKg2qpFCrnrkWeTNPZlD2Ss9QTBXke1qidobI
         d5DzpJSXEDgj2r5LvynBbpChr/pwEa/ov94O26wO5HqPzFShDAhMIt5i9warlnR7hH
         b9lbzdVXmOkbTv+uHIMxjOBlI/K5aetd3zzSBnKKnzzv3c6BLIQl2CqG5SLkZc7Vul
         UkafHe+BORFPolIf7lyKN22KTMVh8Unpo4bxR8FwWYqFpbCxBjHsdtv75OTtYBLwGi
         Hh7f0GbO/KCPnREHzG6UQRzPd/fjEJl28eWHpObiHQL0g6Z9FSc41loA3w1iJhvcB/
         yOCPTaH/jvyNQ==
Received: by mail-oo1-f46.google.com with SMTP id x19so1766178ooj.10
        for <linux-kernel@vger.kernel.org>; Mon, 15 Feb 2021 11:34:37 -0800 (PST)
X-Gm-Message-State: AOAM530jKpynFLAbAg4nn2vckMSE7GVi+I/YI1CRgtvvyT0CDJ6St4uv
        1OKmMY4jnmv8tCy604EqLETvxcui5y34Gpp8rpQ=
X-Google-Smtp-Source: ABdhPJzjo6WFdJnn3FxDpmpYoaxAbUqD1J+deOYYEklSiCFb1mYImlUiIvPE7V4IuGPab5HBHMjIjdOe4Xzie48tYlo=
X-Received: by 2002:a4a:e0d3:: with SMTP id e19mr7675802oot.45.1613417677178;
 Mon, 15 Feb 2021 11:34:37 -0800 (PST)
MIME-Version: 1.0
References: <20210215192237.362706-1-pasha.tatashin@soleen.com>
 <20210215192237.362706-2-pasha.tatashin@soleen.com> <CAMj1kXGxyV0=s6jVZ674O_2amkYSnwSnubnozbzD6g6GOMJE-A@mail.gmail.com>
 <CA+CK2bA7Xz0Zg5phsQi3mhnp+_PHLAAGRLgFTQNw1FjBHaXsHA@mail.gmail.com>
In-Reply-To: <CA+CK2bA7Xz0Zg5phsQi3mhnp+_PHLAAGRLgFTQNw1FjBHaXsHA@mail.gmail.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Mon, 15 Feb 2021 20:34:26 +0100
X-Gmail-Original-Message-ID: <CAMj1kXESuD-von_dtzYcUMwK7TLF=qTki9bd8_iTo_isBwj13g@mail.gmail.com>
Message-ID: <CAMj1kXESuD-von_dtzYcUMwK7TLF=qTki9bd8_iTo_isBwj13g@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] arm64: mm: correct the inside linear map
 boundaries during hotplug check
To:     Pavel Tatashin <pasha.tatashin@soleen.com>
Cc:     Tyler Hicks <tyhicks@linux.microsoft.com>,
        James Morris <jmorris@namei.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Mike Rapoport <rppt@kernel.org>,
        Logan Gunthorpe <logang@deltatee.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 15 Feb 2021 at 20:30, Pavel Tatashin <pasha.tatashin@soleen.com> wrote:
>
> > Can't we simply use signed arithmetic here? This expression works fine
> > if the quantities are all interpreted as s64 instead of u64
>
> I was thinking about that, but I do not like the idea of using sign
> arithmetics for physical addresses. Also, I am worried that someone in
> the future will unknowingly change it to unsigns or to phys_addr_t. It
> is safer to have start explicitly set to 0 in case of wrap.

memstart_addr is already a s64 for this exact reason.

Btw, the KASLR check is incorrect: memstart_addr could also be
negative when running the 52-bit VA kernel on hardware that is only
48-bit VA capable.
