Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4DBF53AA1B2
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jun 2021 18:43:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230350AbhFPQpk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Jun 2021 12:45:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229602AbhFPQpg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jun 2021 12:45:36 -0400
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2432C061574
        for <linux-kernel@vger.kernel.org>; Wed, 16 Jun 2021 09:43:30 -0700 (PDT)
Received: by mail-pg1-x52c.google.com with SMTP id m2so2449813pgk.7
        for <linux-kernel@vger.kernel.org>; Wed, 16 Jun 2021 09:43:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=LJ1OHgnR34ogOAEVHUpUGKUo8aum/tsPypBTkAfpFU8=;
        b=Pk+mS4DKUQ1J3BqFzsg9jT/dZ5rPDDAQonFTVQeHpjJqyRP1WKGgbZKfUKMsaHW5HH
         YH85LVmuR5elaXNQYOq3yzhE+GPT+tvz/NQLYXtzNwicAwNfi8DcNM6y70q8Ea2/s2dp
         Cz6rTQ92VUchxHiESeQpaxsWa2E4NRiLzr3IQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=LJ1OHgnR34ogOAEVHUpUGKUo8aum/tsPypBTkAfpFU8=;
        b=ODy3alWtDLP8lvb7krUhOcRzDEz/vc/2fxxTroJU1I32b9rVNX8HjnOP1LeespMJfM
         gbjyf5mgmxjcQbPX6/PAyCr7Jj2yuDIK9iUas1XxJau+MWxHVWWJEZik01yKvmBMl0IR
         f1Ssidb7anooNjQGr1WlYpKtiVDwEAq07VFOSzVv3AKn8AZ6T/eVz4HHTaoG1lO/l4Z3
         MpJuuy3YP94nnwn9FcBW8s6ABMy+84r5DDnbfA1gdSxQUtOkho7C0KHqK+rCHuCtqt+D
         UCFqixY0PkG0vyipR1dpP/Jvxf02KWCaYx4b4eCscxpZIxxRxxOminievrf7MeVfxe+9
         fu4A==
X-Gm-Message-State: AOAM533om/3iws+gXh3JXP+Yi1udnqBR0X501pWIjBcUhvHadcAmFJ4w
        d4pQFQ23v2V8c1C5uwrdmYtLqQ==
X-Google-Smtp-Source: ABdhPJxx8P6LudPS5rIEnTr/BUC6TgWMdgguqNoArRbYwmw7/JgkUI8vh3DGYEEyc1T9SjhYmMEWrA==
X-Received: by 2002:aa7:9118:0:b029:2eb:2ef3:f197 with SMTP id 24-20020aa791180000b02902eb2ef3f197mr576275pfh.27.1623861810210;
        Wed, 16 Jun 2021 09:43:30 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id ei23sm5895053pjb.57.2021.06.16.09.43.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Jun 2021 09:43:29 -0700 (PDT)
Date:   Wed, 16 Jun 2021 09:43:28 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Lecopzer Chen <lecopzer.chen@mediatek.com>
Cc:     clang-built-linux@googlegroups.com, linux-kbuild@vger.kernel.org,
        linux-kernel@vger.kernel.org, masahiroy@kernel.org,
        michal.lkml@markovi.net, nathan@kernel.org,
        ndesaulniers@google.com, samitolvanen@google.com,
        yj.chiang@mediatek.com
Subject: Re: [PATCH] kbuild: lto: fix module versionings mismatch in
 incremental build
Message-ID: <202106160942.A89674E54@keescook>
References: <202106150821.B4D3E02@keescook>
 <20210616080252.32046-1-lecopzer.chen@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210616080252.32046-1-lecopzer.chen@mediatek.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 16, 2021 at 04:02:52PM +0800, Lecopzer Chen wrote:
> Yes, We can imitate how CLANG_VERSION was implemented in Kconfig.
> 
> Accroding to GNU make release page[1], I've only tested for 3.81,
> 4.2 and 4.3.
> 4.2 was released in 2016, I think it's fine for LTO lowest version.

Okay, sounds good. Are you able to build a patch for this?

Thanks for figuring it out!

-- 
Kees Cook
