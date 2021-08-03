Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A4A013DE44B
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Aug 2021 04:18:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233644AbhHCCSe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Aug 2021 22:18:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233200AbhHCCSd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Aug 2021 22:18:33 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6536C061764
        for <linux-kernel@vger.kernel.org>; Mon,  2 Aug 2021 19:18:22 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id z2so37225016lft.1
        for <linux-kernel@vger.kernel.org>; Mon, 02 Aug 2021 19:18:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=p0Rg8uoQAdCMqNvWG4KJ4Lml0OYquOl0PzeY+NghgIs=;
        b=rJeSRXesNgqD/ctsEcHci3GJIr+ZkXbWSPIKY0cGUASov47tyDQAO5lBimd0asmIsL
         +4rmPRHpsXvlmc0U/W2TuK9bg1MhTeOs7bo8xF8pbSMAURvWUezdYoi0kluk8bQwRucC
         sVI0o4Nkcozxs0qQcniS007Mw17HutvMJYPWo5XFmdPmurdTI4nsoUb6cEW5QHA4gsJ4
         MY2BCxRTcVYUddEibbqdE6MT3YsNNPvMNUJ4G0z+qJSPoRFIEO4PXKaGHgQ81CJhLojN
         HoAJQ0Sf6F0cfaImhnZg544kzLmUxPDV3XS8Ilm6pjvOYyzbU5onvpQy6uTTI+FiM5Jk
         1R8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=p0Rg8uoQAdCMqNvWG4KJ4Lml0OYquOl0PzeY+NghgIs=;
        b=nOrAiONDJWapNYDcZVBmt2yKgNlixnjIWEINvgr/Qb7rAgi/NExALSA6r0Big66Tvf
         3cmZ4HrtVfuDFQo+ZYMF4GOtrWZe57Nt2zmc9LrML22k8JJatiJ7k3yb22m1SvIVy9rq
         08kghdO3617+IBa2dsFPqYMGbaLoOuTtN3BUSHTcURg2tO/o37lVOAAtiJtk2wYE2GK/
         BEwUtGyT4QfSEChnwVpzMtVYu6cn/Rz2UlN9mfbzxD2jiTy9H3v+3mfy/S+8nilyEXLi
         Sg/7qTdLjZipMMxzYLsvQfDeKRfQ5xH8kLpM2lai91MB6ZBYKOEcrQ2ZwxnrYPtLCPOL
         +LFw==
X-Gm-Message-State: AOAM531Cx0PHfqUNAsa3koaE8y/RaJep621fcF7lT168BILFpDfSvVR5
        QnY2MCH1FtnvGlufS4gZE7Za9lkmzHO1Y9hbBfAP9A==
X-Google-Smtp-Source: ABdhPJwB8Bh43O7mdPYun1vDdLefZZTbI63nsPtzVedjyUVpk4FUL0NZ+QI6+2qAksUHe2ZBeqUpGQ1yETx3aQ9XVsw=
X-Received: by 2002:a19:c10a:: with SMTP id r10mr14608548lff.508.1627957101180;
 Mon, 02 Aug 2021 19:18:21 -0700 (PDT)
MIME-Version: 1.0
References: <20210722190747.1986614-1-hridya@google.com>
In-Reply-To: <20210722190747.1986614-1-hridya@google.com>
From:   John Stultz <john.stultz@linaro.org>
Date:   Mon, 2 Aug 2021 19:18:09 -0700
Message-ID: <CALAqxLVLMt7rbJBQtFBw-ikBAjKrVgfS8=Nu6NFQbp_gq1m22Q@mail.gmail.com>
Subject: Re: [PATCH] dma-buf: heaps: Set allocation limit for system heap
To:     Hridya Valsaraju <hridya@google.com>
Cc:     Sumit Semwal <sumit.semwal@linaro.org>,
        Benjamin Gaignard <benjamin.gaignard@linaro.org>,
        Liam Mark <lmark@codeaurora.org>,
        Laura Abbott <labbott@redhat.com>,
        Brian Starkey <Brian.Starkey@arm.com>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        linux-media <linux-media@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        "moderated list:DMA BUFFER SHARING FRAMEWORK" 
        <linaro-mm-sig@lists.linaro.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Android Kernel Team <kernel-team@android.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 22, 2021 at 12:07 PM Hridya Valsaraju <hridya@google.com> wrote:
> This patch limits the size of total memory that can be requested in a
> single allocation from the system heap. This would prevent a
> buggy/malicious client from depleting system memory by requesting for an
> extremely large allocation which might destabilize the system.
>
> The limit is set to half the size of the device's total RAM which is the
> same as what was set by the deprecated ION system heap.
>
> Signed-off-by: Hridya Valsaraju <hridya@google.com>

Seems sane to me, unless folks have better suggestions for allocation limits.

Reviewed-by: John Stultz <john.stultz@linaro.org>

thanks
-john
