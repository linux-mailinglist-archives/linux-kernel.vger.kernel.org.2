Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7AEB53575BC
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Apr 2021 22:16:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356044AbhDGUQX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Apr 2021 16:16:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346203AbhDGUQT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Apr 2021 16:16:19 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2FE0C061760
        for <linux-kernel@vger.kernel.org>; Wed,  7 Apr 2021 13:16:08 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id h19so107783lfu.9
        for <linux-kernel@vger.kernel.org>; Wed, 07 Apr 2021 13:16:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KL2/e0uGb7NX5yS8FiIKOuFOYMDcYomDgmvO6yQYdMs=;
        b=K/IB4jUBdtp24A0UqyYnr5nt6cvhJBJpStTA1TmF+h0OrsQeszkj+i2LHCzRirPlpI
         paHpuVbQeqVDaULxsgyY58lNZj+2norM/mwpT1VGZ+pEm9sEdhdAdwggWGbtvXwWktGq
         J7RCpJLiO4j++XboKo1vDcVmOlgn2TpqHhEsXjbMeqrlX4rTLfnaybWnU+VAgnUNTlEQ
         TUfplTvzgsy044qKGat9IzMimpatBxvBu7LLf/8SqaNbaPgCJISSbypj2ExW/1A/wttH
         ZnyuIDRXCPf3J0dZJGreNicSyxF+SHoUHNc/MaHuStXUAE58qdGSJOdrXNpW+cvxXPnD
         YH4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KL2/e0uGb7NX5yS8FiIKOuFOYMDcYomDgmvO6yQYdMs=;
        b=mGX1p013+o48NR52yt/RbD/DSkWgqBula67k/rBDeJZUdjt64QTQqCYa09yspefZYp
         fTtZg2z+dKFSpnYVcvR6r7RrkT5E4cMhkXZ/88mj+sNu1cgNOdeOQH+FI1AL3Xixp87d
         SM5aZdBbUIanLZ02zyCIGE9sxQ1+aGrLutuuQLK0mSmbGn9yGJz0MaR+N9lw7xmjLZqP
         NCRdpZkOcfpaM7nXLK17R/7w4hw3v6TKJxsmVrWhGfUBG4VxBNkyvUU+S5f0LP+lafoD
         24NgUaApvH9e31nZBhkiG5ledkQxm4Ibf1BS7HL3CY3u5yFyeRx3HGGM4zQgnH0uj92V
         SIHA==
X-Gm-Message-State: AOAM5330D7ZoCrQ6ddQE4Vn7dUl6LjU7tUTMMDPg1tJrukXnzye/Mcou
        fipbyD9L9ZRDq1PpQda7zFyP2I3RGANO2FCxKdmBgw==
X-Google-Smtp-Source: ABdhPJzFO65llRXXIPXsAeIR6V6+dBBAOzfVBbxbkqI+SClK7vuT8w1J5QV2aqZAG7z0UgpgCs/5D8s/CloCcuDtR3s=
X-Received: by 2002:a19:430e:: with SMTP id q14mr3809125lfa.374.1617826567222;
 Wed, 07 Apr 2021 13:16:07 -0700 (PDT)
MIME-Version: 1.0
References: <ead0e9c32a2f70e0bde6f63b3b9470e0ef13d2ee.1616107969.git.andreyknvl@google.com>
 <20210407201455.49907-1-ndesaulniers@google.com>
In-Reply-To: <20210407201455.49907-1-ndesaulniers@google.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Wed, 7 Apr 2021 13:15:56 -0700
Message-ID: <CAKwvOdkeKm0LCpLnqX+0-jC3JVeVbgv-+fhr58XqR+hBwW0evg@mail.gmail.com>
Subject: Re: [PATCH] mailmap: update Andrey Konovalov's email address
To:     Andrey Konovalov <andreyknvl@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Marco Elver <elver@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

err..with Marco's real email address this time

On Wed, Apr 7, 2021 at 1:14 PM Nick Desaulniers <ndesaulniers@google.com> wrote:
>
> (replying to https://lore.kernel.org/lkml/ead0e9c32a2f70e0bde6f63b3b9470e0ef13d2ee.1616107969.git.andreyknvl@google.com/)
>
> Just got the bounceback, RIP. :(
>
> Marco is updating your epitaph.
>
> Acked-by: Nick Desaulniers <ndesaulniers@google.com>



-- 
Thanks,
~Nick Desaulniers
