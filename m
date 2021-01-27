Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 068D0305470
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jan 2021 08:23:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233757AbhA0HWx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jan 2021 02:22:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S317497AbhA0AmX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jan 2021 19:42:23 -0500
Received: from mail-yb1-xb2e.google.com (mail-yb1-xb2e.google.com [IPv6:2607:f8b0:4864:20::b2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E9A1C06174A
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jan 2021 16:41:40 -0800 (PST)
Received: by mail-yb1-xb2e.google.com with SMTP id b11so370516ybj.9
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jan 2021 16:41:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Sp41synaVHOuSVQtii9ixbvOGDzx9cyX8huZX1w1U9I=;
        b=c4KjGbX0lBoGhM6l+Uv9s10uJdLuSxAi8eZh+mrrrR/dwXfhvZdJE+j8AruMkNYsIH
         sK5kpEo202ahk1ppqDGgBapZdLOzx+Zzd5b/7CzCu6z5FG1CSYi3iNuOTm9wAmllxyFM
         7HLM48BDWJbdnzbgAvCKvPZ5n34/pJnM7/80OL2RSdSjZfHEE2OPAoODspFnTO0OLGrg
         yQISbAt1A5EIsQk1eHXbtWJPVl+KCGqGRXZjh98SVkvtd8G+LaqaGfMH4RaO185da4qP
         fCogWZ8ZF7MLJRqZXYIYCTkkbaWtswpiVbesqduRsK2us2Wo4BEuO0Iv2GyDOAlxLDvC
         Zqjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Sp41synaVHOuSVQtii9ixbvOGDzx9cyX8huZX1w1U9I=;
        b=ldTYy/Vw+1LrPqviIFzV9nPGQPGF5WLFsHwILV4rhGsw9XDRcKx5JqEn63F2mCiPbG
         itxx0oMWc1/4irwZjykbEZN/PvQzsn+GgaoWmDtS3T/7hRe1WX0RZ794JHlHFfG8cLML
         9IMQ026yu1oIuQkPNi5zvSrlHR1anYVssXDXD66MffXRlC0QplaX2gTgPQdKBSquXuKd
         nmdMlKdsz2eYS3Y9mpb+zZ3sILV0S7v4TtlvSIUfdi7gTvaiIczb4DEbZ+dz58gGveyc
         oZ7xv90n7OF+8nUP2QbHMMx5bVrmQThiibHjHe33Gmh0mzT/K7UEsh8rSoQ3oVnz6h7p
         zEsA==
X-Gm-Message-State: AOAM531QYdYE9DJCiT3wlDsOjVLQcvz0HhIW49Dy//zq9KYEs9sEm4HD
        PwWgoEErZx276Ka1eG3Tz+VA9JfeNSj2s3VxtCR1Xb4tpyraZw==
X-Google-Smtp-Source: ABdhPJyHIGgIfchxwCtyTwopsp5lk+2pHWVxRsYiFXZz/TlqpgRoIq69sGt0qtRAyist8LMHEtiU5zmccYm65eqrmTA=
X-Received: by 2002:a25:538a:: with SMTP id h132mr11851786ybb.247.1611708099327;
 Tue, 26 Jan 2021 16:41:39 -0800 (PST)
MIME-Version: 1.0
References: <20210126212730.2097108-1-nathan@kernel.org>
In-Reply-To: <20210126212730.2097108-1-nathan@kernel.org>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Wed, 27 Jan 2021 01:41:28 +0100
Message-ID: <CANiq72mrh_rU2vOcx4DY8uQKeLRgr74ei2XBgq5wdsU8uyiDCw@mail.gmail.com>
Subject: Re: [PATCH] MAINTAINERS/.mailmap: Use my @kernel.org address
To:     Nathan Chancellor <nathan@kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 26, 2021 at 10:27 PM Nathan Chancellor <nathan@kernel.org> wrote:
>
> Use my @kernel.org for all points of contact so that I am always
> accessible.
>
> Signed-off-by: Nathan Chancellor <nathan@kernel.org>

Acked-by: Miguel Ojeda <ojeda@kernel.org>

Cheers,
Miguel
