Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA1B23F35F1
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Aug 2021 23:16:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240615AbhHTVRP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Aug 2021 17:17:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231200AbhHTVRO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Aug 2021 17:17:14 -0400
Received: from mail-ot1-x32d.google.com (mail-ot1-x32d.google.com [IPv6:2607:f8b0:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DE74C061575
        for <linux-kernel@vger.kernel.org>; Fri, 20 Aug 2021 14:16:36 -0700 (PDT)
Received: by mail-ot1-x32d.google.com with SMTP id i3-20020a056830210300b0051af5666070so7283943otc.4
        for <linux-kernel@vger.kernel.org>; Fri, 20 Aug 2021 14:16:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JK5qp9aGPwlk30xRI3qcWwl4gv4KOP1fwY03JpC1sQc=;
        b=JybGeEAWGaaSntO3R2lT7WUj35AygFj+itlN16mJYpO0OvjZL4KqEBkfiQp4PGz5Mh
         IrMNHPoa3RsBgJOm5bzBRMyg06657LdqdM3qiOSs3QY6vOx/NvESZuyoce2FByz4HnNL
         1gZiAXesklldc7Jy2N/XS7I1aWhbJKnHGm2DE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JK5qp9aGPwlk30xRI3qcWwl4gv4KOP1fwY03JpC1sQc=;
        b=DM2Qa84PnT2pXRNazZw+uwR/bnIJMCpnG4CCamA3hsuo0ul4uOqaLQfPMe8lvhysdd
         OEvoZGRO8oEI6wimgwaN+CexLin46HUGxaz+iPTvJT3mmpjy/yjdRYlc7Een3RB4PVld
         shf2fO8r2zqiL3KXDaxG0lK8UmdFyWSO6EqPSw/FxSI1mzSqUyWqqe0/W1wgQzf64GSw
         pB/p43iXFRJ9dT/i+ExjBbxUR7Mhpr0TbjDM8/nvD6lQx1k84crON+DbV6v38UGLjPII
         He9HRZQ8zc/85QiJw0xTRmmJCr9SaIN0ZzbkpGWtSIGWUP4idcKcqS0Fglnl+Tpy+kAZ
         AYCQ==
X-Gm-Message-State: AOAM531IcH6L7bH+9VfgrxM2VCwbZzEihW0ha28G3e9VP74RN1RPhL7U
        j6CEnMIwLjVtIJXV/TVt12EFmZmz4tZLVA==
X-Google-Smtp-Source: ABdhPJxcjIIfBt68RCdyoLtPe3vpSkbRQcqqGGabaxJAkye1SeD0qjjY+q7i9KoyufXMgo/+baRwSw==
X-Received: by 2002:a9d:309:: with SMTP id 9mr18771017otv.365.1629494195304;
        Fri, 20 Aug 2021 14:16:35 -0700 (PDT)
Received: from mail-ot1-f48.google.com (mail-ot1-f48.google.com. [209.85.210.48])
        by smtp.gmail.com with ESMTPSA id z78sm1531324ooa.29.2021.08.20.14.16.34
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 20 Aug 2021 14:16:34 -0700 (PDT)
Received: by mail-ot1-f48.google.com with SMTP id h63-20020a9d14450000b02904ce97efee36so16974503oth.7
        for <linux-kernel@vger.kernel.org>; Fri, 20 Aug 2021 14:16:34 -0700 (PDT)
X-Received: by 2002:a9d:309:: with SMTP id 9mr18770960otv.365.1629494194200;
 Fri, 20 Aug 2021 14:16:34 -0700 (PDT)
MIME-Version: 1.0
References: <20210820133829.1.Ica46f428de8c3beb600760dbcd63cf879ec24baf@changeid>
 <CAD=FV=UwAcJEDE3BQYuCDq4kRKPFAsuzPOseGY66wfXcW8Wn7A@mail.gmail.com>
In-Reply-To: <CAD=FV=UwAcJEDE3BQYuCDq4kRKPFAsuzPOseGY66wfXcW8Wn7A@mail.gmail.com>
From:   Brian Norris <briannorris@chromium.org>
Date:   Fri, 20 Aug 2021 14:16:23 -0700
X-Gmail-Original-Message-ID: <CA+ASDXO=Bjr+f4mtXwt7vtiTz6tSw7SPuY1RvNWMp6-43Baqfg@mail.gmail.com>
Message-ID: <CA+ASDXO=Bjr+f4mtXwt7vtiTz6tSw7SPuY1RvNWMp6-43Baqfg@mail.gmail.com>
Subject: Re: [PATCH] arm64: dts: rockchip: add RK3399 Gru gpio-line-names
To:     Doug Anderson <dianders@chromium.org>
Cc:     Heiko Stuebner <heiko@sntech.de>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 20, 2021 at 2:05 PM Doug Anderson <dianders@chromium.org> wrote:
> I guess one minor nit (now that I look back on the veyron patch where
> I mentioned it explicitly in the commit message) is that on the veyron
> ones we sorted this down at the bottom with the other pinctrl stuff
> instead of sorting it alphabetically with everything else. I'll let
> Heiko say which he likes better.

Huh, didn't notice that semi-convention. I can sort it however Heiko prefers.

> I also notice for veyron that we had a second "ABI" exception for the
> recovery mode pin, but I believe that goes through a different
> mechanism now so we're good there.

I believe the recovery mode pin is dropped from recent designs (don't
quote me in general on that), and there's a different mechanism used
just to get the at-boot-time "recovery mode" state directly from the
firmware.

> Even though I didn't do a line-by-line review, I'll still give:
>
> Reviewed-by: Douglas Anderson <dianders@chromium.org>
>
> ...though it's possible an "Acked-by" would be more in the spirit of
> that? Not sure...

Thanks!

Brian
