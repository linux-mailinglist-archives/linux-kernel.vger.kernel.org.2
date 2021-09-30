Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E0E0141DBDA
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Sep 2021 16:03:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351700AbhI3OEk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Sep 2021 10:04:40 -0400
Received: from conssluserg-02.nifty.com ([210.131.2.81]:22792 "EHLO
        conssluserg-02.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351585AbhI3OE0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Sep 2021 10:04:26 -0400
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45]) (authenticated)
        by conssluserg-02.nifty.com with ESMTP id 18UE2IWg018776
        for <linux-kernel@vger.kernel.org>; Thu, 30 Sep 2021 23:02:19 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-02.nifty.com 18UE2IWg018776
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1633010539;
        bh=VuabDIbpmxk72sKuiRHg+TdNhDteCOPteADF+KS7huU=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=LaLEN9K3YWFe+G5xyw5VNkDs+JH6l+gbJ0YYW67ry2nMgMKObqPqZj3X3wA/bqBvL
         QT9QIZq1/BxU0lzAooFf3CtkWphG50xI8HVWMNpVXcv+xlxz+UnWLC0t8Z6FAUkPMf
         HJKLJRburriMu29+/XxlYM10uTSqQMfw3y1EA17LCXwxkRqdNvUOEeFowBIJDe+JrG
         Dyvs594T44BDdAaWptJJreXJOxeZf4OE9jnIrs9r9kcBsqqFAhBmCAVaokfxq2MoTi
         cj9Tg0aeSYudnZ4gViFn6SI/LgU/zEJOoK4NbwWETDzFv9ilsspgUqjMGUAjBhZwCw
         8lNDPWE3p3sVw==
X-Nifty-SrcIP: [209.85.167.45]
Received: by mail-lf1-f45.google.com with SMTP id e15so25799868lfr.10
        for <linux-kernel@vger.kernel.org>; Thu, 30 Sep 2021 07:02:18 -0700 (PDT)
X-Gm-Message-State: AOAM533yVDMvG2RSmhwDS2cChpEIXRufhkNJc743W1CAwxaKta29EGMn
        8wn4nghJDjulgX8RMwPzvQBS8/D/kEOn0yMfA40=
X-Google-Smtp-Source: ABdhPJw+mGEsdDSY8gXRmEoAlTAeLprEfe0NdJWhOeaN21T4sF+dG+g3cSQdq97CjBYXTI3CvNR84NzGFaMk5Dl16ps=
X-Received: by 2002:ac2:4d57:: with SMTP id 23mr6154739lfp.493.1633010533423;
 Thu, 30 Sep 2021 07:02:13 -0700 (PDT)
MIME-Version: 1.0
References: <20210929183357.1490204-1-lucas.demarchi@intel.com> <20210929183357.1490204-4-lucas.demarchi@intel.com>
In-Reply-To: <20210929183357.1490204-4-lucas.demarchi@intel.com>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Thu, 30 Sep 2021 23:01:36 +0900
X-Gmail-Original-Message-ID: <CAK7LNAQ765CBjg83Kpt8XdOjqPw8Xuv--_bcTvd3udZ=tsgMdA@mail.gmail.com>
Message-ID: <CAK7LNAQ765CBjg83Kpt8XdOjqPw8Xuv--_bcTvd3udZ=tsgMdA@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] Move IS_CONFIG_NONZERO() to kconfig.h
To:     Lucas De Marchi <lucas.demarchi@intel.com>
Cc:     intel-gfx <intel-gfx@lists.freedesktop.org>,
        Daniel Vetter <daniel.vetter@intel.com>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 30, 2021 at 3:34 AM Lucas De Marchi
<lucas.demarchi@intel.com> wrote:
>
> The check for config value doesn't really belong to i915_utils.h - we
> are trying to eliminate that utils helper and share them when possible
> with other drivers and subsystems.
>
> Rationale for having such macro is in commit
> babaab2f4738 ("drm/i915: Encapsulate kconfig constant values inside boolean predicates")
> whereas later it is improved to not break the build if used with
> undefined configs. The caveat is detailed in the documentation: unlike
> IS_ENABLED(): it's not preprocessor-only logic so can't be used for
> things like `#if IS_CONFIG_NONZERO(...)`
>
> Signed-off-by: Lucas De Marchi <lucas.demarchi@intel.com>


Hypothetical "it would be nice to have ..." is really unneeded.

       if (context && CONFIG_DRM_I915_FENCE_TIMEOUT > 0)
                     return
msecs_to_jiffies_timeout(CONFIG_DRM_I915_FENCE_TIMEOUT);


is enough, and much cleaner.



This warning is shown only when a constant is used
together with '&&'.

Most of IS_ACTIVE can go away.

Given that, there are not many places where the IS_ACTIVE macro
is useful, even in the i915 driver.

For a few sources of the warnings,
replacing it with  != 0 or > 0 is just fine.

Of course, such an ugly macro is not worth being moved to <linux/kconfig.h>




-- 
Best Regards
Masahiro Yamada
