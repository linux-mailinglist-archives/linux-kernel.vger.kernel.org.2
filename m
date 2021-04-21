Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 605BE366E34
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Apr 2021 16:28:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240208AbhDUO3J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Apr 2021 10:29:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:54580 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235193AbhDUO3F (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Apr 2021 10:29:05 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id A23DB61454
        for <linux-kernel@vger.kernel.org>; Wed, 21 Apr 2021 14:28:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1619015312;
        bh=8bQZFFWHUwobJjK+so56OmD7hgBTOgc9MoS2JZ0x8yU=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=G7MBN5Yuy342nLi2Ul34DREJ2F0a+OqXTOpQmsl2EZHdHkG0kYWtN62+ixf7CgWK5
         GBq/DOyl4Cj1hVO/6+7IWAsHnn2DQmAnE/ovHpH7mgC4tQEbr0W33OgzNWNKr6IPRV
         U0EpbHW8ZrkSxs8W24cg+PbusicY0WEGyoqaEuWPwJzzcPH7/0Gt661LSESoJnY1Zw
         HL+neLbtwNJjaqasnYlM/bx849EQscziOu+6Ad03LlG+4xBrHpVvuL+IFaSu7IT6XN
         VccB0yRt65axnsB7peoXGgpr2QR8i5+KfaZfr4wOvfrh9q8LcV2vSF9U2hGecjb7bY
         osTWvrc8p72Ww==
Received: by mail-wm1-f47.google.com with SMTP id u187so2832053wmb.0
        for <linux-kernel@vger.kernel.org>; Wed, 21 Apr 2021 07:28:32 -0700 (PDT)
X-Gm-Message-State: AOAM530O2nNjEBOl3cL2tLM/UvfnF/OOJ+8fB0JGqBwHZUwink5Dbg9O
        ZU7HC9Dgl01zvqN+QwOYoQbJT7rdp/5EFbRXsYg=
X-Google-Smtp-Source: ABdhPJxIUQLYorkc2Y1TA/JMYa5A/I82k7QTNNMLQMbkob1EklUV0bxK+vJ5SHvdTIJNRQJxYHSe6I0FlbiIp6XQswE=
X-Received: by 2002:a05:600c:2282:: with SMTP id 2mr10374790wmf.84.1619015311239;
 Wed, 21 Apr 2021 07:28:31 -0700 (PDT)
MIME-Version: 1.0
References: <20210421134922.3309033-1-arnd@kernel.org> <87y2dbpwqn.wl-maz@kernel.org>
In-Reply-To: <87y2dbpwqn.wl-maz@kernel.org>
From:   Arnd Bergmann <arnd@kernel.org>
Date:   Wed, 21 Apr 2021 16:28:12 +0200
X-Gmail-Original-Message-ID: <CAK8P3a26F1+9XJqHtqO5S0dwTjBhV8Z+0J1r_D69y9h84qyY7g@mail.gmail.com>
Message-ID: <CAK8P3a26F1+9XJqHtqO5S0dwTjBhV8Z+0J1r_D69y9h84qyY7g@mail.gmail.com>
Subject: Re: [PATCH] KVM: arm64: build perf support only when enabled
To:     Marc Zyngier <maz@kernel.org>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        James Morse <james.morse@arm.com>,
        Alexandru Elisei <alexandru.elisei@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Fuad Tabba <tabba@google.com>,
        Andrew Scull <ascull@google.com>,
        David Brazdil <dbrazdil@google.com>,
        Quentin Perret <qperret@google.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        kvmarm@lists.cs.columbia.edu,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 21, 2021 at 3:56 PM Marc Zyngier <maz@kernel.org> wrote:
> On Wed, 21 Apr 2021 14:49:01 +0100, Arnd Bergmann <arnd@kernel.org> wrote:
>
> I think a better way is to get rid of perf_num_counters() entirely,
> see [1]. If someone acks the second and last patches, I'll even take
> the whole series in (nudge nudge...).

Makes sense. I like your diffstat, too.

       Arnd
