Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 26A5534ACF2
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Mar 2021 17:57:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230296AbhCZQ4e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Mar 2021 12:56:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230347AbhCZQ4J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Mar 2021 12:56:09 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83C06C0613AA
        for <linux-kernel@vger.kernel.org>; Fri, 26 Mar 2021 09:56:09 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id o19so7095112edc.3
        for <linux-kernel@vger.kernel.org>; Fri, 26 Mar 2021 09:56:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bCYUHEJOOmAYGk1u0DJXlBrrHde9W54rxGamO+7985Q=;
        b=HDrGqW6dLSVa8fiG+befjHX77BN+C2c40r3vBuGfH7daUarEnQFO3rLCwf6ufadDS8
         y2dxq3h1ka6Y1YOFuK/ISSnioapWJhjES5XO3YS8JGR/CJcaBNznr1hX++rMJyQpeLr0
         w551pfbWKacC0BLsIZqCyJZaLSepEVbxXEN06+tRAW2ovYNj3xtWtvrN1w7gyjLUrGmg
         uszYR+zDWnMF5gu7RqDWQBxuGdCbML/bLlfGI6lftZ5Tn50hAeOVfrPVskQKtUyzjrC0
         SwG0c664JBu8PDzFTFVBIzwl306jL2pGji2hVkjgvTYiMYf84Gpp75+mMaVRo91UWD3Z
         zitA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bCYUHEJOOmAYGk1u0DJXlBrrHde9W54rxGamO+7985Q=;
        b=XqDKCJBtvM3BT4ADb9kU6eZ/vSGxM0SGpXk4uxoOUMFGK2hEp9HCiYH7+NyGr38yXo
         4n1UdvbPBkd/JNZOKwTMRIjArq1u1gIhNwRx+lNNU8B2Lqp7PEWpoCrQErj1vWAuTRfg
         61zAQRZTGanrH2hldmcAmEfuiuBII1BL+Zknp9bSf1hstguV2Z4SZlI/Fohr6RXqkvx5
         yCiwSFN5TYphfHGtKBv9JejEJD0OULiRLOskweeG1GIHgod1dGDn0ImXcb4jd5SBN8wU
         UcgZLXAFWit4b2A0viE/XFlE8DwcU5vKM55Hs8APBbawna1aqOFnoC+gf9KgdmJDhuxN
         a1RQ==
X-Gm-Message-State: AOAM531zoWF76QlcrAH1q7mXcZfmy7DuWA0VphoLVHri2DsmmliwhSLX
        fqNIBWVj926Liokatjg3WPAJ8OhCLrWGvgQugFk=
X-Google-Smtp-Source: ABdhPJzHoc1Mn8WK2QJ07wL/A3pZkPV+pPANFtEm9eqfe7IddcVdMgszY0WNzNDlt8vUr6dE2+NV03oC7FcBVx+sndY=
X-Received: by 2002:a05:6402:26d3:: with SMTP id x19mr4248449edd.349.1616777768362;
 Fri, 26 Mar 2021 09:56:08 -0700 (PDT)
MIME-Version: 1.0
References: <20210326012739.18038-1-unixbhaskar@gmail.com>
In-Reply-To: <20210326012739.18038-1-unixbhaskar@gmail.com>
From:   Max Filippov <jcmvbkbc@gmail.com>
Date:   Fri, 26 Mar 2021 09:55:57 -0700
Message-ID: <CAMo8BfKFa7cuogeA4uNV+i-iudEwk+SnL+HGm+iK8POSZEi4nA@mail.gmail.com>
Subject: Re: [PATCH] platforms/iss/simcall.h: Change compitible to compatible
To:     Bhaskar Chowdhury <unixbhaskar@gmail.com>
Cc:     Chris Zankel <chris@zankel.net>,
        "open list:TENSILICA XTENSA PORT (xtensa)" 
        <linux-xtensa@linux-xtensa.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Randy Dunlap <rdunlap@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 25, 2021 at 6:29 PM Bhaskar Chowdhury <unixbhaskar@gmail.com> wrote:
>
>
> s/compitible/compatible/
>
> Signed-off-by: Bhaskar Chowdhury <unixbhaskar@gmail.com>
> ---
>  arch/xtensa/platforms/iss/include/platform/simcall.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Thanks, applied to my xtensa tree with minor adjustment of the subject line.

-- 
Thanks.
-- Max
