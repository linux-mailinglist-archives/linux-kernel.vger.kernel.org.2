Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A13D04198CE
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Sep 2021 18:21:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235447AbhI0QXe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Sep 2021 12:23:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235338AbhI0QXe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Sep 2021 12:23:34 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47ED0C061575
        for <linux-kernel@vger.kernel.org>; Mon, 27 Sep 2021 09:21:56 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id w19so16283785pfn.12
        for <linux-kernel@vger.kernel.org>; Mon, 27 Sep 2021 09:21:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=zE0WK5KeeYoSEMUqx2JoFV8T7/T0HCpAa3xAp2o0SGE=;
        b=Ovom/58nDytk/sPQ4xnYffxyhIaOb1dbAY5kNn0OlX7f/06z78wegirQ1Oy2+R1P1w
         Xj9FAzi4KvGTTxb5QyC2qxYmG6V1WaLa+lEvZj+6cMzJSbtvR+WOD/opdnsqcXTR6K8U
         +JHFoVFk3ZjltKlbBVfm64cDMnj9JRXIJggss=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=zE0WK5KeeYoSEMUqx2JoFV8T7/T0HCpAa3xAp2o0SGE=;
        b=pTsl26eqHmM8g0M6/sis846CQQkJuMYWN7/8p8rWCSDlIAewsbUR/B9Ze/ClVzKQR6
         0+QdlT8C6Ibo2SQd9KfhqHCtCOvp2iNgIcAmaV00OIcEc3emJAMTrkO00ThrzlXD8+tx
         U1EEXXAWwLmd8pEJrqFlrX7LSqLeqUPSmhQrG3In2oIsoKmo+9NOvdwTktyqL/RRvdAD
         L35BtkD6IZYKx0IE6RfDAI4qQ2o1wQdLqdPFhofrQl3LJ9eLFz41shN4/Wq0uTPsoc3H
         7YfFKJN1tj8vvI16f1xr4An3TRV7sCIUU1kUSBvRKPO0K7dMaOcl9PM/xX8F/kJIswKo
         4cYw==
X-Gm-Message-State: AOAM531FUaEl9Y127ewItH9D5TM3erNHo6npfs0lSsivpd25CcOHNhYW
        e7UxM81EGTDtE0Pl+EPUgOCDwg==
X-Google-Smtp-Source: ABdhPJw7E9n4w5w/LlRosUapgP1QwTF6PBj/DsSkOkj67gRHp+kn+vwPHZEHDh5oITAyBUsfezVI4g==
X-Received: by 2002:a62:641:0:b0:44b:74bb:294c with SMTP id 62-20020a620641000000b0044b74bb294cmr557046pfg.12.1632759715779;
        Mon, 27 Sep 2021 09:21:55 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id w5sm18341171pgp.79.2021.09.27.09.21.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Sep 2021 09:21:55 -0700 (PDT)
Date:   Mon, 27 Sep 2021 09:21:54 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Luis Chamberlain <mcgrof@kernel.org>, Jessica Yu <jeyu@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Miroslav Benes <mbenes@suse.cz>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sergey Shtylyov <s.shtylyov@omprussia.ru>,
        Sami Tolvanen <samitolvanen@google.com>,
        Stephen Boyd <swboyd@chromium.org>,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev
Subject: Re: [PATCH] module: fix clang CFI with MODULE_UNLOAD=n
Message-ID: <202109270921.F0A304C@keescook>
References: <20210927121541.939745-1-arnd@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210927121541.939745-1-arnd@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 27, 2021 at 02:15:10PM +0200, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> When CONFIG_MODULE_UNLOAD is disabled, the module->exit member
> is not defined, causing a build failure:
> 
> kernel/module.c:4493:8: error: no member named 'exit' in 'struct module'
>                 mod->exit = *exit;
> 
> add an #ifdef block around this.
> 
> Fixes: cf68fffb66d6 ("add support for Clang CFI")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Nice catch; thanks! (Not a lot of config build that way it seems...)

Acked-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
