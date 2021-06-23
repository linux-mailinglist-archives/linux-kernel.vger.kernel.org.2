Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC0473B137F
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jun 2021 07:51:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230004AbhFWFxk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Jun 2021 01:53:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229864AbhFWFxh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jun 2021 01:53:37 -0400
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB653C061574
        for <linux-kernel@vger.kernel.org>; Tue, 22 Jun 2021 22:51:18 -0700 (PDT)
Received: by mail-pg1-x536.google.com with SMTP id u190so831381pgd.8
        for <linux-kernel@vger.kernel.org>; Tue, 22 Jun 2021 22:51:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=gvifQC5IeicUDnWoUsRHMENVSvoiy4CqG/g46bHGIBE=;
        b=Nfhhac/bZAPq4PYEl8wGoNG3LtOlUf0ySTTBOT1i1L2PgBv0e5wt01FLhqlJmLQz8j
         bkVCQAyMVaPjFnbOvJEsa/+w7he3kCWPerUO8x1LcddUFd7zGgL/G7/iplT3Ssaxmc9C
         +7CXA1AJ638YsSQeYWXKnMaIevl4qskFAg0xQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=gvifQC5IeicUDnWoUsRHMENVSvoiy4CqG/g46bHGIBE=;
        b=KFyzpM7A84UZSa/GQapvxcASs/PKLX6X/RKdDTVlEzfz+xJ1PyrnHJ7bmcUOVospgp
         5pgwQG6r3vYk0g4qit4SZDToQxJwoTXwbpCQR6hdDY696WMqlTc4eM5ELEWGw7JJCbk6
         errqDZFYOm1+7aZoch6a7DpE96hAQcFvBFozQwcpD3CaRly3WLbm8D0w/TXepI7P3qRz
         aIZhGnMRgLVZuafU7WgvLr/hYBIJEotioR1BR/womSj7FzPo2/LnAZXGgGyxSp9ufDhq
         FxSDsYnrhE8HyEGjuEDRUi82HmyuC1HQXHxPxbKk7u5ykJk3QlFs9jGjlbmueE2dLXdc
         8QsQ==
X-Gm-Message-State: AOAM533qzgS3eb5nrewbjXQeTw3Jclv2TuOOMkB1SD1FMAPFdo+cwxhD
        0wchpru8Q3DIKBkzVxlKlxch8CdprISvVxZ5
X-Google-Smtp-Source: ABdhPJwS551YzUKPlrLg4xaKTDfZblIg72w73yK6vsDqeuSfN09P1F0/y6J/wAAl/1MV9m/6mJxyMQ==
X-Received: by 2002:a63:5553:: with SMTP id f19mr2218816pgm.419.1624427478576;
        Tue, 22 Jun 2021 22:51:18 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id v129sm1108705pfc.71.2021.06.22.22.51.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Jun 2021 22:51:17 -0700 (PDT)
Date:   Tue, 22 Jun 2021 22:51:17 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Nathan Chancellor <nathan@kernel.org>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Nick Desaulniers <ndesaulniers@google.com>,
        Sami Tolvanen <samitolvanen@google.com>,
        clang-built-linux@googlegroups.com
Subject: Re: [PATCH 2/2] ACPI: bgrt: Use sysfs_emit
Message-ID: <202106222250.7BD80A12FF@keescook>
References: <20210623013802.1904951-1-nathan@kernel.org>
 <20210623013802.1904951-2-nathan@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210623013802.1904951-2-nathan@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 22, 2021 at 06:38:02PM -0700, Nathan Chancellor wrote:
> sysfs_emit is preferred to snprintf for emitting values after
> commit 2efc459d06f1 ("sysfs: Add sysfs_emit and sysfs_emit_at to format
> sysfs output").
> 
> Signed-off-by: Nathan Chancellor <nathan@kernel.org>

Perhaps just squash this into patch 1? Looks good otherwise!

-- 
Kees Cook
