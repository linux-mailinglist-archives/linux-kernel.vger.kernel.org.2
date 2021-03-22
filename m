Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C05A344897
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Mar 2021 16:05:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231510AbhCVPFO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Mar 2021 11:05:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231477AbhCVPFB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Mar 2021 11:05:01 -0400
Received: from mail-vs1-xe32.google.com (mail-vs1-xe32.google.com [IPv6:2607:f8b0:4864:20::e32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A60A1C061756
        for <linux-kernel@vger.kernel.org>; Mon, 22 Mar 2021 08:05:00 -0700 (PDT)
Received: by mail-vs1-xe32.google.com with SMTP id e72so2168797vsc.6
        for <linux-kernel@vger.kernel.org>; Mon, 22 Mar 2021 08:05:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WzcaGF7w6W11GdLHn3ihyHrWcDJilQZIx3XWKEsGk6M=;
        b=lNOubS+ftCZhU5QS64oOu76U6ggSOiePJ3vmTdHoSpR3/0cuM84KSzX+NqbZa8GerK
         zEFeTVdbT2Aq7JMcb/v2EoeZCMzstzCI1zQumKG7s5UWIMctYaNsELkraDs90bQLWWqI
         MF0d1EWuSU6mCl7dCB8QJoJFy7MOtgzMrnXNs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WzcaGF7w6W11GdLHn3ihyHrWcDJilQZIx3XWKEsGk6M=;
        b=fmPVs5HnAn9NeB8D82sM7YcGyME5Ogyn45y+hSo/k/RVlLsJdDkYiOoAQaSgEerRMo
         bBRbjVnScipeFTvCexvMUoSRTW7OrDTnLZBvavst591fe28+HFEQ+4SRgUB8N1dmN0Ki
         Hwqpe8QbKC72Sqzke50NH5/RhkGjf8qbmsuhPPzeWRWRGcGzaErOKpmwCuqaEwbDIIDZ
         LG56a+Vn+vJ+zrGzocpLG7oJKxZ8NG0PzOPRp5Il3Jy0E7QMwvEAU7JtD2s2jj+ZNsrX
         U2tgQRR7ruxFjE9q6gBh0z5feR8w6l4r+tSghAetWLIHIogUqL3snRWHZJKAcDl10O84
         TG7A==
X-Gm-Message-State: AOAM53286NIfLT3scvR62zdvP2S7nP8KnG5xo7cZKTTe+FakdqVWhAVG
        2PZ14KOlNJ8CJe6VWnvhIms9assCwIXxVoB4SCrdLw==
X-Google-Smtp-Source: ABdhPJxMQEao5pR626XzTPCcUeMDFXi5Gr5QpKTbxJatunHz1CTfdOzSnt3WU3AVODHXsiuOu45niZuCVGLIeiTTc20=
X-Received: by 2002:a05:6102:323b:: with SMTP id x27mr284884vsf.0.1616425499866;
 Mon, 22 Mar 2021 08:04:59 -0700 (PDT)
MIME-Version: 1.0
References: <20210319150514.1315985-1-balsini@android.com>
In-Reply-To: <20210319150514.1315985-1-balsini@android.com>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Mon, 22 Mar 2021 16:04:48 +0100
Message-ID: <CAJfpegsovR6i6tVOzTPP8V8Y9PxmtRx5M+=2Z9oKMcpYO3Dd2Q@mail.gmail.com>
Subject: Re: [PATCH] fs/fuse: Fix matching of FUSE_DEV_IOC_CLONE command
To:     Alessio Balsini <balsini@android.com>
Cc:     Arnd Bergmann <arnd@kernel.org>,
        kernel-team <kernel-team@android.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 19, 2021 at 4:06 PM Alessio Balsini <balsini@android.com> wrote:
>
> With commit f8425c939663 ("fuse: 32-bit user space ioctl compat for fuse
> device") the matching constraints for the FUSE_DEV_IOC_CLONE ioctl
> command are relaxed, limited to the testing of command type and number.
> As Arnd noticed, this is wrong as it wouldn't ensure the correctness of
> the data size or direction for the received FUSE device ioctl.
>
> Fix by bringing back the comparison of the ioctl received by the FUSE
> device to the originally generated FUSE_DEV_IOC_CLONE.
>
> Fixes: f8425c939663 ("fuse: 32-bit user space ioctl compat for fuse device")
> Reported-by: Arnd Bergmann <arnd@kernel.org>
> Signed-off-by: Alessio Balsini <balsini@android.com>

Thanks, applied.   I'm holding this till the 5.13 merge window unless
a more series fuse issue emerges in the meantime

Thanks,
Miklos
