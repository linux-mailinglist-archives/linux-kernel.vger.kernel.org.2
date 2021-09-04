Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 84FBB400CCA
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Sep 2021 21:11:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237394AbhIDTMk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Sep 2021 15:12:40 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:36854 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232424AbhIDTMj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Sep 2021 15:12:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1630782696;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=+vglIRiq2twF0gBLHp0cEuyzMuL4N3cukyGbV97IcVA=;
        b=RfAGUl1Vxq3R+aopl+ESwzP6gREPTnkYmt4N3o0fAegGwml1wwmbNyLff+G/CNMdGZYZ6Z
        jslGdG9XX39Q1gPhjA406a8mjVDXIMDfkQCzjuv9yyFNYB8EhajLQ2QZ90bOJ0Qq2nlEu+
        /Ox+YBLvpHN1mz4t9mmET0xVHXgDdW8=
Received: from mail-oo1-f69.google.com (mail-oo1-f69.google.com
 [209.85.161.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-493-bZ1G58n1PuyJ-HeR3qh3jg-1; Sat, 04 Sep 2021 15:11:35 -0400
X-MC-Unique: bZ1G58n1PuyJ-HeR3qh3jg-1
Received: by mail-oo1-f69.google.com with SMTP id i5-20020a4ad385000000b0028bd047a835so1649053oos.12
        for <linux-kernel@vger.kernel.org>; Sat, 04 Sep 2021 12:11:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=+vglIRiq2twF0gBLHp0cEuyzMuL4N3cukyGbV97IcVA=;
        b=rqAe/2jY5Euss7D3FYCwaR4lCMaPxyW5D3fk8DfDMGU5ty5NRR5v5wM/8LGgCoy6oa
         i66W3EvtzRvTuW83dxJ25LBYUVflwgKHANAlB6KMHaO4Vgc84YlD9kEbi7Hy1U4kDUf7
         cZ4AEyvBUy7DW8YRT5snSyWU6ypNXxFC9B2xq0KS4Qju0ZmUUCoYIQ0wQ08Gyj5Vu58Z
         wgVNuAhJrmz6aIZ3qdpH1VI5IOOMZiPow3AuJpBI7dHSzdI+I+qR0xa02cm6z75NYi9b
         PXijzQ8a5VgJaoZoCg4Rh+WPQi6uCo1tuAiLx/uz63etd4/mVS35gazd1fvCgRDELUgF
         73ng==
X-Gm-Message-State: AOAM530lu7g4kgwM+xvbYd58SKzBgd9a2kmmGWZ0db0CLX+36hEyyhIL
        0CD5aMZBw7omo9fMvvCc+xyxOqfS2npj/EfClfHdhZWyAP4Ol+1NufERcja1mVNk7eleSV68DzR
        k4jVKPe//Nh/ue2jo7jmckbig
X-Received: by 2002:aca:aa47:: with SMTP id t68mr3462250oie.25.1630782694597;
        Sat, 04 Sep 2021 12:11:34 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxexRTc29ssbmqIdxMigB8JG8giqljBFapJRUIzV8QTTXgC9eG79OPAg7coHZwHcVf57cchcA==
X-Received: by 2002:aca:aa47:: with SMTP id t68mr3462238oie.25.1630782694362;
        Sat, 04 Sep 2021 12:11:34 -0700 (PDT)
Received: from treble ([2600:1700:6e32:6c00::15])
        by smtp.gmail.com with ESMTPSA id c10sm680077ots.48.2021.09.04.12.11.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Sep 2021 12:11:33 -0700 (PDT)
Date:   Sat, 4 Sep 2021 12:11:31 -0700
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     linux-kbuild@vger.kernel.org,
        Michal Marek <michal.lkml@markovi.net>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        clang-built-linux@googlegroups.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 06/13] kbuild: reuse $(cmd_objtool) for
 cmd_cc_lto_link_modules
Message-ID: <20210904191131.mwbckb2dfxbvoez4@treble>
References: <20210831074004.3195284-1-masahiroy@kernel.org>
 <20210831074004.3195284-7-masahiroy@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210831074004.3195284-7-masahiroy@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 31, 2021 at 04:39:57PM +0900, Masahiro Yamada wrote:
> For CONFIG_LTO_CLANG=y, the objtool processing is not possible at the
> compilation, hence postponed by the link time.
> 
> Reuse $(cmd_objtool) for CONFIG_LTO_CLANG=y by defining objtool-enabled
> properly.
> 
> For CONFIG_LTO_CLANG=y:
> 
>   objtool-enabled is off for %.o compilation
>   objtool-enabled is on  for %.lto link
> 
> For CONFIG_LTO_CLANG=n:
> 
>   objtool-enabled is on for %.o compilation
>       (but, it depends on OBJECT_FILE_NON_STANDARD)
> 
> Set part-of-module := y for %.lto.o to avoid repeating --module.
> 
> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>

With Kees' suggested fix:

Acked-by: Josh Poimboeuf <jpoimboe@redhat.com>

-- 
Josh

