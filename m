Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B2BA3400C7E
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Sep 2021 20:18:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237311AbhIDSTf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Sep 2021 14:19:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:38522 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234085AbhIDSTe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Sep 2021 14:19:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1630779511;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=eTFJ/z23uhAgEiUhaPIzvjGnzGJZGxRWifNygGsPOgI=;
        b=PlWzQdn/VYquwj3Zy1+zsPsrdHmqHyfFxmwkz6W82crLZCTbwYg6pKzYDDKpatTpWyzB2L
        8fmnxKPte2nRylllVFHwaZc0eyLTbYyWUTP26GtLJncnDiyPylrCVcHcGmhr6jW1OGQG55
        pbfnoHZyVkM0W6YxNJxRoRv3LSD2XuA=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-587-MDfKV0AgM2-gmpNU5yhlHg-1; Sat, 04 Sep 2021 14:18:30 -0400
X-MC-Unique: MDfKV0AgM2-gmpNU5yhlHg-1
Received: by mail-qk1-f197.google.com with SMTP id p23-20020a05620a22f700b003d5ac11ac5cso3884235qki.15
        for <linux-kernel@vger.kernel.org>; Sat, 04 Sep 2021 11:18:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=eTFJ/z23uhAgEiUhaPIzvjGnzGJZGxRWifNygGsPOgI=;
        b=Cl916djGrY8yjOgHce+tJf/0pSslG/sQyEt7SbWE6QNXFsaJqW8VX5oXnBVvL9BcLd
         8ZzfC1zeiP2FaBd576A4kDpqyRM1nDeFtlOwyWoEFi3E6Ur2ut18C37d95aunjgkN7IJ
         u21f4hL5PcJh1CPmawfDTCLryXPsiJDAGfloKjrSd2us6YxTiWPs5oar3TmZ/G1BBOlU
         zNGc1raj7l+ifGD3bctv83W7KXpnck2nBlkCVc0kGXYi4E5FKhAuOp9PkiwiYNz7YqjE
         QT2pXfBegaDsDeIAcgOa3SayJwss0leV4UwkkJiZbZPXQR9wo+c1fhwBRpj4fxdJk8fY
         1OyQ==
X-Gm-Message-State: AOAM531RbBdShcahiGtZRQHtUUiIYwlXdHCarMokCm/G67CAMUltn60R
        LgXntE3kWLb0zm6hzf0EVI63AGGpE6ZwxO00iT8j/6w74zE/63XKs76qWwvbiiZ2WCUK3xwNgR8
        nUEaG/fofvxUq96EI5Egqwtv9
X-Received: by 2002:a0c:804a:: with SMTP id 68mr4992484qva.66.1630779510108;
        Sat, 04 Sep 2021 11:18:30 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyVS9Nh2wSL5lnSoIEyNJcSfAick9YJ9gFMhOKEOQXbkL3UKT2x6G79oInn/A+Vjk23ZIBoPw==
X-Received: by 2002:a0c:804a:: with SMTP id 68mr4992465qva.66.1630779509951;
        Sat, 04 Sep 2021 11:18:29 -0700 (PDT)
Received: from treble ([2600:1700:6e32:6c00::15])
        by smtp.gmail.com with ESMTPSA id s8sm1958102qta.48.2021.09.04.11.18.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Sep 2021 11:18:29 -0700 (PDT)
Date:   Sat, 4 Sep 2021 11:18:26 -0700
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     linux-kbuild@vger.kernel.org, Kees Cook <keescook@chromium.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Nick Desaulniers <ndesaulniers@google.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 01/13] kbuild: move objtool_args back to
 scripts/Makefile.build
Message-ID: <20210904181826.shkpubse4fmd77ph@treble>
References: <20210831074004.3195284-1-masahiroy@kernel.org>
 <20210831074004.3195284-2-masahiroy@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210831074004.3195284-2-masahiroy@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 31, 2021 at 04:39:52PM +0900, Masahiro Yamada wrote:
> Commit b1a1a1a09b46 ("kbuild: lto: postpone objtool") moved objtool_args
> to Makefile.lib, so the arguments can be used in Makefile.modfinal as
> well as Makefile.build.
> 
> With commit 2b1d7fc05467 ("kbuild: Fix TRIM_UNUSED_KSYMS with
> LTO_CLANG"), module LTO linking came back to scripts/Makefile.build
> again.
> 
> So, there is no more reason to keep objtool_args in a separate file.
> 
> Get it back to the original place, close to the objtool command.
> 
> Remove the stale comment too.
> 
> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
> Reviewed-by: Kees Cook <keescook@chromium.org>

Acked-by: Josh Poimboeuf <jpoimboe@redhat.com>

-- 
Josh

