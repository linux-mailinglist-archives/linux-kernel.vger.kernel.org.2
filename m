Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A8DFF3265AA
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Feb 2021 17:39:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230169AbhBZQi2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Feb 2021 11:38:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230153AbhBZQiU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Feb 2021 11:38:20 -0500
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42BE3C061574;
        Fri, 26 Feb 2021 08:37:39 -0800 (PST)
Received: by mail-ej1-x634.google.com with SMTP id a22so15873683ejv.9;
        Fri, 26 Feb 2021 08:37:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=KMT1d1Gs8BZ9utr+GYuVKfNILn5qh+CRx49B4cHumdg=;
        b=ifH+WRoVDCq7KD0/hRxdhkyVlkjwcLAgzep2Rkx2WPSYpla3PHPRxxkVx2i1m4onFR
         Qu5bA6//9R1+62IPc4K4EeUb7aEAZUfe3xtXQcc1Gt5kggS0VsrITKQXGrBtsmhGSI4M
         j1Z3dNOpDaDHvSywSFOrR0Jhuu+Nt5eB49arcRM51hQxO629xa7tCHhJouIfYVnfi5cQ
         jzROWH+L/B/+jWkMiSh7GjqPCc9KDj81cn2m4TgpWgSLOkxdqEmtQOTYJo7D7KlyZdGW
         Aqi3dQSBUKOljFQLCc67tYRvL/f+0LSNOR9Myq4saHf+7SgEwdKQk/XkhhHk9TONunp7
         DeWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=KMT1d1Gs8BZ9utr+GYuVKfNILn5qh+CRx49B4cHumdg=;
        b=YeU/6SstYEBBG3vHfdSjRDmD07AWleQajlrHZ0WR2gteHwZpnZJ14dawzthvUZAvnF
         kUDOFqV7SknONALBxVOrGqoEDlGKqctYQoJujzcrbTg5tXOgsY4FdXmFpKiDKPMc4Jnf
         DPLFLqLUNNSHu8FQiTLQfrbp7ilRoTePT7yh30TTF054rXIYeo6BzP8h5MYxx4gMMf4Y
         WgrR2on8n149cZONnig6r9SfL3M8E9axll1vDBs8mFbRCS+yV5tuU7tF2CMx2wmEt0QR
         G6XL8ha7WnuUUeKy+prS+y/WXUhqs7lmztNKid8R7ZCcrkrCkzr+9uJrlX42Ye5DPx2T
         GLeg==
X-Gm-Message-State: AOAM533mB24dQKe14JAAvegtTd//pg7sDVFa25iKJlNRc1HK8GOzEEJy
        /3QgRW8ns09L3SDED6yO3M8=
X-Google-Smtp-Source: ABdhPJw67rlPCl8cTfCkX5Bl7e62XoaFKe8iFWv2hpDqnNWTNfIT4TN/iXzQ+BnJP1FtmF07xkkc+g==
X-Received: by 2002:a17:906:5797:: with SMTP id k23mr4142769ejq.489.1614357458064;
        Fri, 26 Feb 2021 08:37:38 -0800 (PST)
Received: from mail ([2a02:a03f:b7fe:f700:a502:29ea:4ea3:1c47])
        by smtp.gmail.com with ESMTPSA id f5sm662940ejb.64.2021.02.26.08.37.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Feb 2021 08:37:37 -0800 (PST)
Date:   Fri, 26 Feb 2021 17:37:34 +0100
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Nathan Chancellor <nathan@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Miguel Ojeda <ojeda@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nick Hu <nickhu@andestech.com>,
        Greentime Hu <green.hu@gmail.com>,
        Vincent Chen <deanbo422@gmail.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>, Guo Ren <guoren@kernel.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Sami Tolvanen <samitolvanen@google.com>,
        Marco Elver <elver@google.com>,
        Arvind Sankar <nivedita@alum.mit.edu>,
        clang-built-linux@googlegroups.com, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-csky@vger.kernel.org
Subject: Re: [PATCH] [v2] linux/compiler-clang.h: define HAVE_BUILTIN_BSWAP*
Message-ID: <20210226163734.hjfhzwbqzedqjapy@mail>
References: <20210226161151.2629097-1-arnd@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210226161151.2629097-1-arnd@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Acked-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

Thanks,
-- Luc
