Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A378B42CB2C
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Oct 2021 22:36:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229667AbhJMUiY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Oct 2021 16:38:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229526AbhJMUiX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Oct 2021 16:38:23 -0400
Received: from mail-ua1-x931.google.com (mail-ua1-x931.google.com [IPv6:2607:f8b0:4864:20::931])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 770F0C061749
        for <linux-kernel@vger.kernel.org>; Wed, 13 Oct 2021 13:36:19 -0700 (PDT)
Received: by mail-ua1-x931.google.com with SMTP id 64so7074742uab.12
        for <linux-kernel@vger.kernel.org>; Wed, 13 Oct 2021 13:36:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=oxmlE0jWTvIABAOfcWenbXPbvIcFQQi9okWp6MfW2Rk=;
        b=dSwYr10Czbxlxm7F67KMPvvJG9P3phmX0JBl9Ty+/TuGFPA0rsFQPLdAUoKK7dCh41
         9uMqVVhVMu8cioCd5Y2rVX+7tzSExeucmzg+GfpGSWafRxGh8Gyy8x1nICbhYFOuPD6D
         3227y+5cZC8ZqIXulPV6s4wxTMnUNoNxZWlJCUJPUHt7ok0hfsJ1g5kTSrZHeY83Opte
         PjM3CPJpRBV6Ne9KK7m1wElFoUStioYCCRwZGX4K9me+zIOdMy8qMo85c+Anyhox/lm6
         iXOplN3FBIrzrEB21N8FpE/yOlyfK5kcbAcrdtkcX8rZY5rZcInFj05k5egv2a7iGkLD
         SojQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=oxmlE0jWTvIABAOfcWenbXPbvIcFQQi9okWp6MfW2Rk=;
        b=f0Ab+LldggqUTsydaGxoTZn+gdts1Vsf+JGPLrxtZakISYAVrKfn0c/VUxCgygeRUZ
         Yp7aH+SSD0yUG1lYfjpjSlbH0ReaNsI/djJJKTt0U2n71RpBDALFbSunJsE8hgAaPwL1
         ZpFQ2evcA3btTQJSZrgOHeP8J59CGn9MJJuMieIfaB2BJdJUzzfBTxrPMNPo023bPlcj
         aASaS4qCEnE0iy6uqyF2ndq/ue7BGyjF/Lg+tilwEnN6mJ22vTZ/wwgUPbl0ky2Qct2X
         dz+3RqbfVcGtrs50FKPkjgHaJzwgSK3JBjoeyY0rOzIefu6OfAEalXnz95IA2CW1//n5
         uuAg==
X-Gm-Message-State: AOAM531RBej/xdIVCk4jsjZ1QcIj8IbTupsoIBysPNhFRJQTcI44/PNx
        nOCn9MX9IXt0o31tBmZUcaYCjXRKRqIJCOot1uz8CA==
X-Google-Smtp-Source: ABdhPJxCWJwH8wsDAPq7q8Ma8DI8v/ghsdOiUWd7ssye0vrKNbb4cbAPYMkSxDl5594oZyze0+c7hz4obonnasO/r/c=
X-Received: by 2002:ab0:540e:: with SMTP id n14mr1776903uaa.73.1634157378226;
 Wed, 13 Oct 2021 13:36:18 -0700 (PDT)
MIME-Version: 1.0
References: <20211007002507.42501-1-ramjiyani@google.com> <20211012085915.GA25069@lst.de>
In-Reply-To: <20211012085915.GA25069@lst.de>
From:   Ramji Jiyani <ramjiyani@google.com>
Date:   Wed, 13 Oct 2021 13:36:06 -0700
Message-ID: <CAKUd0B8UUFKif0OOQG_4gUcyoWPgsau+KWtWt__Vjuxfw13kmg@mail.gmail.com>
Subject: Re: [PATCH v4] aio: Add support for the POLLFREE
To:     Christoph Hellwig <hch@lst.de>
Cc:     arnd@arndb.de, viro@zeniv.linux.org.uk, bcrl@kvack.org,
        kernel-team@android.com, linux-aio@kvack.org,
        linux-arch@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, oleg@redhat.com, ebiggers@kernel.org,
        Jeff Moyer <jmoyer@redhat.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 12, 2021 at 1:59 AM Christoph Hellwig <hch@lst.de> wrote:
>
> Looks good,
>
> Reviewed-by: Christoph Hellwig <hch@lst.de>

Thanks, Christoph.

~ Ramji
