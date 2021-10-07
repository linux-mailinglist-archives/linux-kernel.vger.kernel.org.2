Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C109142570D
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Oct 2021 17:50:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241878AbhJGPwd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Oct 2021 11:52:33 -0400
Received: from conssluserg-01.nifty.com ([210.131.2.80]:25997 "EHLO
        conssluserg-01.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241765AbhJGPwb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Oct 2021 11:52:31 -0400
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177]) (authenticated)
        by conssluserg-01.nifty.com with ESMTP id 197FoM6r007339
        for <linux-kernel@vger.kernel.org>; Fri, 8 Oct 2021 00:50:23 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-01.nifty.com 197FoM6r007339
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1633621823;
        bh=2ictrqXAcs0/Jf+501IU2xn9Ag6+SYGQ2GB1JSMdfsk=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=XMZHChvUbi0/x64LrjBMjBDD8xRAZzR0gb9nQmJ4eBWHB+eJXeRdTWOM7lOGE2Pbk
         o+ybVG6MvojCUYxmsOrO94dutpJ4TF5r27EIaAkutr5R3xWYp8zutrKW4eVr2BHbXe
         mP5ktpD991UXujzbHoZ6Ra21/WrPvbgBxukVk2oyt8XoQSh9g2pKYyi0DJlsJzuGHt
         0bxzEgLKc3uBh/UYnUCmgBcQm6nt585LAM+9mMvnvVTghIR6ziEIvqTz3mtKrKI0ZI
         LW/ME6rITE8b9ySgQKetVBIGyjHa14nmpY4LAdpDrwxkCxPfJDynCs04O1B6pkhPsD
         qxfwCnglWwjSQ==
X-Nifty-SrcIP: [209.85.214.177]
Received: by mail-pl1-f177.google.com with SMTP id x8so4168318plv.8
        for <linux-kernel@vger.kernel.org>; Thu, 07 Oct 2021 08:50:23 -0700 (PDT)
X-Gm-Message-State: AOAM531RWrj1r7Za4oO2J4Yj35gzjM2xFjsJHKhh7dqAUVRuOsofI9Q4
        HPtcieEp6ZhTpIwJl/XN0Flo4VHOfcKlOjgIFrc=
X-Google-Smtp-Source: ABdhPJzGjr0g3OMZKs7rwCvM6PfYXgPw2KXHF9cvejM0rXE06zKWYrhO1bS2++snMAc8G6LVr00CozT0DNarzLxE4sk=
X-Received: by 2002:a17:90a:4414:: with SMTP id s20mr5636167pjg.144.1633621822196;
 Thu, 07 Oct 2021 08:50:22 -0700 (PDT)
MIME-Version: 1.0
References: <20211005171728.3147094-1-lucas.demarchi@intel.com>
In-Reply-To: <20211005171728.3147094-1-lucas.demarchi@intel.com>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Fri, 8 Oct 2021 00:49:44 +0900
X-Gmail-Original-Message-ID: <CAK7LNARbNQHPxHHp4=oLOsJLpaCv0c3NRHGSs6hAKnP3N4DHKQ@mail.gmail.com>
Message-ID: <CAK7LNARbNQHPxHHp4=oLOsJLpaCv0c3NRHGSs6hAKnP3N4DHKQ@mail.gmail.com>
Subject: Re: [PATCH v3] drm/i915: remove IS_ACTIVE
To:     Lucas De Marchi <lucas.demarchi@intel.com>
Cc:     intel-gfx <intel-gfx@lists.freedesktop.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Steven Price <steven.price@arm.com>,
        Chris Wilson <chris@chris-wilson.co.uk>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Jani Nikula <jani.nikula@intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 6, 2021 at 2:21 AM Lucas De Marchi <lucas.demarchi@intel.com> wrote:
>
> When trying to bring IS_ACTIVE to linux/kconfig.h I thought it wouldn't
> provide much value just encapsulating it in a boolean context. So I also
> added the support for handling undefined macros as the IS_ENABLED()
> counterpart. However the feedback received from Masahiro Yamada was that
> it is too ugly, not providing much value. And just wrapping in a boolean
> context is too dumb - we could simply open code it.
>
> As detailed in commit babaab2f4738 ("drm/i915: Encapsulate kconfig
> constant values inside boolean predicates"), the IS_ACTIVE macro was
> added to workaround a compilation warning. However after checking again
> our current uses of IS_ACTIVE it turned out there is only
> 1 case in which it triggers a warning in clang (due
> -Wconstant-logical-operand) and 2 in smatch. All the others
> can simply use the shorter version, without wrapping it in any macro.
>
> So here I'm dialing all the way back to simply removing the macro. That
> single case hit by clang can be changed to make the constant come first,
> so it doesn't think it's mask:
>
>         -       if (context && CONFIG_DRM_I915_FENCE_TIMEOUT)
>         +       if (CONFIG_DRM_I915_FENCE_TIMEOUT && context)
>
> As talked with Dan Carpenter, that logic will be added in smatch as
> well, so it will also stop warning about it.
>
> Signed-off-by: Lucas De Marchi <lucas.demarchi@intel.com>
> Acked-by: Jani Nikula <jani.nikula@intel.com>

Reviewed-by: Masahiro Yamada <masahiroy@kernel.org>





-- 
Best Regards
Masahiro Yamada
