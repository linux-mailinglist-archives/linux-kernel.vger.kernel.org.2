Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 13EBB3E09D0
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Aug 2021 23:03:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240045AbhHDVDp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Aug 2021 17:03:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240125AbhHDVDn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Aug 2021 17:03:43 -0400
Received: from mail-yb1-xb30.google.com (mail-yb1-xb30.google.com [IPv6:2607:f8b0:4864:20::b30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CB41C0613D5
        for <linux-kernel@vger.kernel.org>; Wed,  4 Aug 2021 14:03:27 -0700 (PDT)
Received: by mail-yb1-xb30.google.com with SMTP id z18so5747641ybg.8
        for <linux-kernel@vger.kernel.org>; Wed, 04 Aug 2021 14:03:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jlekstrand-net.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=CyeKjKtoo9LoSd8Ka8M+GcyT9q9AB1Q66au6WOGmIu8=;
        b=QOgxNkaWKKyNO5qwEAGPVjVHQU2HHIWNpHskRmVAAVZacLU8CDl2sHjiVHfkecCDAD
         EGVwrQgz/ONC8DatBMXsP+ggp6b9tl0qK+IGkqT6V/sgBMB3m+LP0qSIxULbW76/FyRu
         F7qqZYG/i/8YupmS7IVwYdhlQWjNr1ycL22Wg+xb/Aac25zzPlK+1iH3uPyAih22MUzo
         zPDGriYbgSihlN7BbyUlvPdwe8kux768j6PeZW9KWBj+y4qysW6Brn2e2J1KG0fWJUc9
         W5Wc9JdX40S+qrejo2mcvF1FuFrCb1TyAxDEf0yCo0qAPoLz5r8n3nsqG+Vt2FHQKG4U
         h0RQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CyeKjKtoo9LoSd8Ka8M+GcyT9q9AB1Q66au6WOGmIu8=;
        b=qFpqvKYj06AS0v3+Xa5TSm/fqLdtPld5d7MZVVf+c3UaFpOEIhMAWoqSBPWvIWGPuY
         OwaIGpKII//fV6QNetgOVEW+mmatd6Zc8nHccpn3UltY+Gk9lXYrOLWjh0Nd+I5f71b4
         3yaJtWLn2XabtpnnxLDXMAFY6bQzimnTAp/nlrOrUHduay5WGn0SdxNm/9QuMePwYv3y
         tu74JGUALHle0QEk367jUTW2hcTaiuf3IjdDrnL3Ck1t0EHZfuxxXAAG2Qw/iQL/SGtF
         2qlagp+so1YfTxYe1l2sAmGwW/m4jzgpn00SCbzinYJDOf+7NEFxYNPIeoQQn8arhPrQ
         v/2A==
X-Gm-Message-State: AOAM531moJlM9H4xx3hnZ04iVABzvG9oshFVWnuPG5pTjdCeXrivMUrc
        +z7zAdPmPWs/5CybNJC9tn5MlyA+P4jQKuXxGNqN6g==
X-Google-Smtp-Source: ABdhPJx4D532aHvf28UN5ogYmIBkrzQd5oszq1iQNc6mbV1wwkUv/3ic7VceumFl/dA5J6RsWAW0VJy0Bj8j8uaKnKg=
X-Received: by 2002:a25:680b:: with SMTP id d11mr1696970ybc.241.1628111006488;
 Wed, 04 Aug 2021 14:03:26 -0700 (PDT)
MIME-Version: 1.0
References: <20210804204147.2070-1-rdunlap@infradead.org>
In-Reply-To: <20210804204147.2070-1-rdunlap@infradead.org>
From:   Jason Ekstrand <jason@jlekstrand.net>
Date:   Wed, 4 Aug 2021 16:03:15 -0500
Message-ID: <CAOFGe95raX2O3aKBvTPhKy19aOA96yp0=6hp4nsg6T8x9OBj5A@mail.gmail.com>
Subject: Re: [PATCH -next] drm/i915: fix i915_globals_exit() section mismatch error
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Intel GFX <intel-gfx@lists.freedesktop.org>,
        Maling list - DRI developers 
        <dri-devel@lists.freedesktop.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 4, 2021 at 3:41 PM Randy Dunlap <rdunlap@infradead.org> wrote:
>
> Fix modpost Section mismatch error in i915_globals_exit().
> Since both an __init function and an __exit function can call
> i915_globals_exit(), any function that i915_globals_exit() calls
> should not be marked as __init or __exit. I.e., it needs to be
> available for either of them.
>
> WARNING: modpost: vmlinux.o(.text+0x8b796a): Section mismatch in reference from the function i915_globals_exit() to the function .exit.text:__i915_globals_flush()
> The function i915_globals_exit() references a function in an exit section.
> Often the function __i915_globals_flush() has valid usage outside the exit section
> and the fix is to remove the __exit annotation of __i915_globals_flush.
>
> ERROR: modpost: Section mismatches detected.
> Set CONFIG_SECTION_MISMATCH_WARN_ONLY=y to allow them.

My gut says we actually want to back-port
https://lore.kernel.org/dri-devel/YPk3OCMrhg7UlU6T@phenom.ffwll.local/
instead.  Daniel, thoughts?

--Jason

>
> Fixes: 1354d830cb8f ("drm/i915: Call i915_globals_exit() if pci_register_device() fails")
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Cc: Jason Ekstrand <jason@jlekstrand.net>
> Cc: Daniel Vetter <daniel.vetter@ffwll.ch>
> Cc: Rodrigo Vivi <rodrigo.vivi@intel.com>
> Cc: Jani Nikula <jani.nikula@linux.intel.com>
> Cc: Joonas Lahtinen <joonas.lahtinen@linux.intel.com>
> Cc: intel-gfx@lists.freedesktop.org
> Cc: dri-devel@lists.freedesktop.org
> ---
>  drivers/gpu/drm/i915/i915_globals.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> --- linext-2021-0804.orig/drivers/gpu/drm/i915/i915_globals.c
> +++ linext-2021-0804/drivers/gpu/drm/i915/i915_globals.c
> @@ -138,7 +138,7 @@ void i915_globals_unpark(void)
>         atomic_inc(&active);
>  }
>
> -static void __exit __i915_globals_flush(void)
> +static void  __i915_globals_flush(void)
>  {
>         atomic_inc(&active); /* skip shrinking */
>
