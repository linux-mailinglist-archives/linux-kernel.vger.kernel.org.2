Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A458E441E39
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Nov 2021 17:31:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232692AbhKAQeR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Nov 2021 12:34:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232070AbhKAQeP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Nov 2021 12:34:15 -0400
Received: from mail-oo1-xc31.google.com (mail-oo1-xc31.google.com [IPv6:2607:f8b0:4864:20::c31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62188C061714
        for <linux-kernel@vger.kernel.org>; Mon,  1 Nov 2021 09:31:42 -0700 (PDT)
Received: by mail-oo1-xc31.google.com with SMTP id o26-20020a4abe9a000000b002b74bffdef0so6454784oop.12
        for <linux-kernel@vger.kernel.org>; Mon, 01 Nov 2021 09:31:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=RoxrbwXI/uzghbJByN0kudXg7vyA8QYSZFm4zmFhcvg=;
        b=KcxYFvFVS2aVhuqU5fCWKH/beck96M3XSdshLqzozu7Bm41PLb8HYXUH1r/VviksrA
         kwRieikyx2iuDGkrARVy5MxOzUBU9w2kvQOkwc9jr6AAzjzM3qbfeT52R2Swm1yXsaJF
         O5gYj8uh95VXdy68GKY60azTFUUPsfm1/d5o8SBmAurpNKF32P3QIHDcPy4Lg53cJfIr
         RkG9p1bQkB+JUsB3U9fkllhhZ2Y3+0MkAYRhQ7T4YeYlD2SgaVcdjSziwrOT2y2MJfVc
         IQyQdLIbC/5pvbKMuA3VCCVpnSgMn68ZAlIY9EIhKssYV9E5/qMGCex5rM6RpeejToON
         WT4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RoxrbwXI/uzghbJByN0kudXg7vyA8QYSZFm4zmFhcvg=;
        b=n02MDsWm8CAnYcYqbTPOKBUvkStTixpxgWQmYJcTE3A/mU/4rSklGp6dQ8lTNdcZF+
         eYX/T2f8y9lskaqhZ3FemgDkPgd0NzVreOawooDzickF0+cEgoGxWcetcGUCDRfwrMU/
         3IDtC6mws++cixjibMnFwB0ulzlF7i0ZuCujIs8ANuTy7z9ZRltHAGMVpsh7czlITzJw
         dsbcQ5h0dIDMy/wg6WyEqVVj5zANAtgGjIf79UDft7Q0tu+jb9eiEQiL4pyqr2KbtHqs
         TvXTiCmb/VLm5ITX8+i0XMxCuYfTmyoO3HGw0zLdhl85uvLxYwR3W4tcrurbYD8X2N04
         SvTQ==
X-Gm-Message-State: AOAM530FUES+/qv/4rlBTyRmxDE0180O28GkIPY0xpRSl7TyJgIEJ884
        BMqQ5UDxui+Km1mEFbukXnm/7/RnMmbkQo+0OHyckw==
X-Google-Smtp-Source: ABdhPJwdWjQxYd3uF5tbv+EyRSlihkTR74QwtSNyzpKsGmaK8YAZ5Lh3VQ5OKy5O1AR9OP1S409UU35oWuUEVPN4jiw=
X-Received: by 2002:a4a:dc1a:: with SMTP id p26mr19990397oov.6.1635784301540;
 Mon, 01 Nov 2021 09:31:41 -0700 (PDT)
MIME-Version: 1.0
References: <20211028175749.1219188-1-pgonda@google.com>
In-Reply-To: <20211028175749.1219188-1-pgonda@google.com>
From:   Marc Orr <marcorr@google.com>
Date:   Mon, 1 Nov 2021 09:31:30 -0700
Message-ID: <CAA03e5HhGfBKKWFo1eT3wyUUY+5r2C3-jWQpMkntOQRe=CocTw@mail.gmail.com>
Subject: Re: [PATCH 0/4] Add SEV_INIT_EX support
To:     Peter Gonda <pgonda@google.com>
Cc:     Thomas.Lendacky@amd.com, David Rientjes <rientjes@google.com>,
        Brijesh Singh <brijesh.singh@amd.com>,
        Joerg Roedel <jroedel@suse.de>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        John Allen <john.allen@amd.com>,
        "David S. Miller" <davem@davemloft.net>,
        Paolo Bonzini <pbonzini@redhat.com>,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 28, 2021 at 10:57 AM Peter Gonda <pgonda@google.com> wrote:
>
> SEV_INIT requires users to unlock their SPI bus for the PSP's non
> volatile (NV) storage. Users may wish to lock their SPI bus for numerous
> reasons, to support this the PSP firmware supports SEV_INIT_EX. INIT_EX
> allows the firmware to use a region of memory for its NV storage leaving
> the kernel responsible for actually storing the data in a persistent
> way. This series adds a new module parameter to ccp allowing users to
> specify a path to a file for use as the PSP's NV storage. The ccp driver
> then reads the file into memory for the PSP to use and is responsible
> for writing the file whenever the PSP modifies the memory region.
>
> Signed-off-by: Peter Gonda <pgonda@google.com>
> Acked-by: David Rientjes <rientjes@google.com>
> Cc: Tom Lendacky <thomas.lendacky@amd.com>
> Cc: Brijesh Singh <brijesh.singh@amd.com>
> Cc: Marc Orr <marcorr@google.com>
> Cc: Joerg Roedel <jroedel@suse.de>
> Cc: Herbert Xu <herbert@gondor.apana.org.au>
> Cc: David Rientjes <rientjes@google.com>
> Cc: John Allen <john.allen@amd.com>
> Cc: "David S. Miller" <davem@davemloft.net>
> Cc: Paolo Bonzini <pbonzini@redhat.com> (
> Cc: linux-crypto@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
>
> David Rientjes (1):
>   crypto: ccp - Add SEV_INIT_EX support
>
> Peter Gonda (3):
>   crypto: ccp - Fix SEV_INIT error logging on init
>   crypto: ccp - Move SEV_INIT retry for corrupted data
>   crypto: ccp - Refactor out sev_fw_alloc()
>
>  drivers/crypto/ccp/sev-dev.c | 235 ++++++++++++++++++++++++++++++-----
>  include/linux/psp-sev.h      |  21 ++++
>  2 files changed, 222 insertions(+), 34 deletions(-)
>
> --
> 2.33.1.1089.g2158813163f-goog
>

I've just replied with my Reviewed-by tag to all of the patches
because I had reviewed the v1 internally, before Peter posted
externally. Thank you, Tom, for the excellent reviews! I'm looking
forward to seeing the v2 with all of this feedback incorporated.
