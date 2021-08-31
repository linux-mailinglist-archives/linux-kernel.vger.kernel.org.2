Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2F2DD3FCC61
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Aug 2021 19:33:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240391AbhHaRdz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Aug 2021 13:33:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233532AbhHaRdx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Aug 2021 13:33:53 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8109BC061575
        for <linux-kernel@vger.kernel.org>; Tue, 31 Aug 2021 10:32:58 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id d17so11054068plr.12
        for <linux-kernel@vger.kernel.org>; Tue, 31 Aug 2021 10:32:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=rkTnEj3ChzJlO/isucTXbatcCaYkpBJdKq7prvC6mwI=;
        b=HhGTLRmVZYdnVdhrAHYzM9lsXjOIUlrqlHTibD4qCyEdZ213nFKFT06wmlf0G2gZzE
         Y4u4g/zsf5TGC9uVx8PY2KHbXQkAg4SvIm+M01h/mgfIggys+MFIT9HWcyey+cLvG9R5
         ww2WntK2Cwsg88MdIt92vfKhA93i1ypGeAg00=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=rkTnEj3ChzJlO/isucTXbatcCaYkpBJdKq7prvC6mwI=;
        b=Wf4mHPbpPi2TsB6uW8qbunyddv6cIggyBNXcgDG3dCp/pswwjS0ZH7gnt+Ujw+lPdk
         GtYWi3x8brix+oNW+DmF2KQpeB3f2pY2daiT8KkSuCHCyI5HPkr+QV+11p2Ss3pnOxjf
         SaHHFxrwexqIOO+f9qcKe/K2w9rvmvLe8Oaz3R1XwP6NupRsb9mawIjurygK32GK6WG/
         FjojSwihFe4v80tnEeYbb4NPv66HgmjB9U49X+uOKITDqm87JB2UA1Fkr/N7JpKUhxqU
         wpqgFXqLYhuR9ks7G6jPsCB4VRB83Cqqxv30unaYObZTSyxrJZGpvdSrh1wYzpYxU1ci
         xx2Q==
X-Gm-Message-State: AOAM533JbBDDGotUsl5cgE5XKDOiafntJW+KcVoYdD2iyU9bqZFtW+Eh
        vhdIpyzlSDAAUmC7xJt/ukdiVkkR1gAE6g==
X-Google-Smtp-Source: ABdhPJwPPtqvpXwclkQ4+DzkARjQoGHhy/jsY84H8+Bxvv8BK7bQHJLt0Q+7+eH4cjfWvOv9GNkkjg==
X-Received: by 2002:a17:902:e88d:b0:136:7033:895c with SMTP id w13-20020a170902e88d00b001367033895cmr5565705plg.70.1630431178004;
        Tue, 31 Aug 2021 10:32:58 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id d15sm18311058pfh.34.2021.08.31.10.32.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Aug 2021 10:32:57 -0700 (PDT)
Date:   Tue, 31 Aug 2021 10:32:56 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     linux-kbuild@vger.kernel.org,
        Michal Marek <michal.lkml@markovi.net>,
        Nick Desaulniers <ndesaulniers@google.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 05/13] kbuild: detect objtool update without using
 .SECONDEXPANSION
Message-ID: <202108311032.F503B07@keescook>
References: <20210831074004.3195284-1-masahiroy@kernel.org>
 <20210831074004.3195284-6-masahiroy@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210831074004.3195284-6-masahiroy@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 31, 2021 at 04:39:56PM +0900, Masahiro Yamada wrote:
> Redo commit 8852c5524029 ("kbuild: Fix objtool dependency for
> 'OBJECT_FILES_NON_STANDARD_<obj> := n'") to add the objtool
> dependency in a cleaner way.
> 
> Using .SECONDEXPANSION ends up with unreadable code due to escaped
> dollars. Also, it is not efficient because the second half of
> Makefile.build is parsed twice every time.
> 
> Append the objtool dependency to the *.cmd files at the build time.
> 
> This is what fixdep and gen_ksymdeps.sh already do. So, following the
> same pattern seems a natural solution.
> 
> This allows us to drop $$(objtool_deps) entirely.
> 
> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>

Okay, so IIUC, this means objtool (and args) now ends up in the .cmd
file instead of in the Makefile dep rules? That seems reasonable.

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
