Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 992A740B2C0
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Sep 2021 17:14:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234625AbhINPPM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Sep 2021 11:15:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234802AbhINPPG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Sep 2021 11:15:06 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97A9DC0613DE
        for <linux-kernel@vger.kernel.org>; Tue, 14 Sep 2021 08:13:48 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id i7so13407473lfr.13
        for <linux-kernel@vger.kernel.org>; Tue, 14 Sep 2021 08:13:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vs4JzNzYOIkiMNCXl/BXAxJoRkCBxorofWXnQlKIKTc=;
        b=pRPWsNXgrIohQph/8NpbL+8CQcifHOg3AtasJUc6ewrlqivFf7tNOnOev6xbHNeScy
         5lUw0JKVS2bKoFDpADjDZDubGnxK5+M9NWO2BpPX9q2R9b58vLMbE5CMjgmeiW2mNU8s
         o7ThsamuF+OksBlmKnCdC/Nw0BTW4A0/yGHr6VSMZWFPhdhurnzjm6uYfu9gnLkkCbv0
         lpdeXMq9bL2t29SyoDO11ImlthHn7AXkSS4a0zy/pQiHkSYi566+PTsS85skBEHoByF1
         ZgvNHr/rm3TIdw1ErNJ7E4dDZUpJCDskQV8oxzwthUO37ZBKKoQhbdM/zIrykMAFIsCq
         Kl9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vs4JzNzYOIkiMNCXl/BXAxJoRkCBxorofWXnQlKIKTc=;
        b=1sU26qAUiZ8iUD45k8NrVNPRN0J5hiNkSvdBeOaqM+V5ZttjOjMYNm6JZcTSb1fN62
         ibZfpk/654NkCEqOeaQprK28MsTMzWobQ/xpdGgGHKTN/VXi33f0dxir+WP/41UrVNg4
         N9g9JbT6qXejC8m9BLa6hm/tRtFY7zRdhS9/Zvt0bMuvXz+DnFf9Zx1YaygI3+HxVMyz
         jFfGW+QqZht2bjYSo5Z1VoAEyX+2aGa1/5a14ppdQPIZFsjEQqMRiW9pQ5NPWxZtnULf
         A484u6mYkL4iqg47eXl58jiXVn49FDI6S8Y/1MblaDKSDg3NPjYJcXApW0Zn225XNgv8
         Zf0w==
X-Gm-Message-State: AOAM531pf8Jj6q77pxiciUqpj0aSVAq3sm7YBfoD+8R7jV8gEuzun9bM
        pf6BNXOtzUn9qAHDt7hSMbyp1lMFSTq8wvMvTwbErA==
X-Google-Smtp-Source: ABdhPJz/nB2X7ZhjAGNpGQ+wUMu55D7srT5Jv3DFOroslyMj15lcS2R9RnxlnBnfcSTTFydrMt0Pg3Xb7m3aCBq9Pto=
X-Received: by 2002:a05:6512:318a:: with SMTP id i10mr14107059lfe.444.1631632426763;
 Tue, 14 Sep 2021 08:13:46 -0700 (PDT)
MIME-Version: 1.0
References: <20210913192816.1225025-1-robh@kernel.org> <20210913192816.1225025-9-robh@kernel.org>
In-Reply-To: <20210913192816.1225025-9-robh@kernel.org>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Tue, 14 Sep 2021 08:13:35 -0700
Message-ID: <CAKwvOdnNOMDWar2jpEw_yt8-dzW6KX-NVWh=UHc2FeYzux4tVw@mail.gmail.com>
Subject: Re: [PATCH v2 8/8] kbuild: Enable dtc 'unit_address_format' warning
 by default
To:     Rob Herring <robh@kernel.org>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>, Pavel Machek <pavel@ucw.cz>,
        Liviu Dudau <liviu.dudau@arm.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-leds@vger.kernel.org, Michal Marek <michal.lkml@markovi.net>,
        linux-kbuild@vger.kernel.org,
        Masahiro Yamada <masahiroy@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 13, 2021 at 12:28 PM Rob Herring <robh@kernel.org> wrote:
>
> With all the 'unit_address_format' warnings fixed, enable the warning by
> default.
>
> Cc: Michal Marek <michal.lkml@markovi.net>
> Cc: Nick Desaulniers <ndesaulniers@google.com>
> Cc: linux-kbuild@vger.kernel.org
> Acked-by: Masahiro Yamada <masahiroy@kernel.org>
> Signed-off-by: Rob Herring <robh@kernel.org>

Acked-by: Nick Desaulniers <ndesaulniers@google.com>

> ---
>  scripts/Makefile.lib | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/scripts/Makefile.lib b/scripts/Makefile.lib
> index 54582673fc1a..56d50eb0cd80 100644
> --- a/scripts/Makefile.lib
> +++ b/scripts/Makefile.lib
> @@ -310,7 +310,6 @@ DTC_FLAGS += -Wno-interrupt_provider
>  # Disable noisy checks by default
>  ifeq ($(findstring 1,$(KBUILD_EXTRA_WARN)),)
>  DTC_FLAGS += -Wno-unit_address_vs_reg \
> -       -Wno-unit_address_format \
>         -Wno-avoid_unnecessary_addr_size \
>         -Wno-alias_paths \
>         -Wno-graph_child_address \
> --
> 2.30.2
>


-- 
Thanks,
~Nick Desaulniers
