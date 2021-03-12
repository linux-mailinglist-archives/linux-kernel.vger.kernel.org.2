Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C2123383CF
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Mar 2021 03:46:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231562AbhCLCpe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Mar 2021 21:45:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231373AbhCLCpM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Mar 2021 21:45:12 -0500
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA6CCC061765
        for <linux-kernel@vger.kernel.org>; Thu, 11 Mar 2021 18:45:11 -0800 (PST)
Received: by mail-pl1-x62c.google.com with SMTP id c16so11241363ply.0
        for <linux-kernel@vger.kernel.org>; Thu, 11 Mar 2021 18:45:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=RwJ0npvlf94WoHHNghlKh7pfAsSY3kaD5+gAJapol+w=;
        b=bpZBKNh/QL9GElmYyMVWjg0TXLHOvRLf/AJusUpMp5M9GhAoX1vyXiQO5qjooDTLBU
         JzoyxgAy+jtXqTW2nhjU+NFbBjWEh9Cnaiik7yl7LEJVvRol9EJH9gFiWziYFuLK0mlG
         LfGHNNjlBiC2I2x4tgijzQUT7YRqmnmrZhpM4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=RwJ0npvlf94WoHHNghlKh7pfAsSY3kaD5+gAJapol+w=;
        b=Kh3YHu/eHTz8zMQeWLLRoYtRyOHa+d6Vx8SXaGw+muMA+9dwQ4TltuEsMEo3ezUmV+
         ty7JSOEBkgJe0bzY4o51QuHsaWfztG+my6VxZJ7MrZZTxzQ7XdHU2l6+INpIdd1z1Y9o
         yyOcnc7TemuS9GC1FxP/gHpt1QFueMWe+COosGB5WlnjM2fk6KGLgBoWJ+SYf3EnplGF
         FfSziPP8D7WfiTjKawdQqLJaiLy7KCARgZPH4xwesWkT6IiXOygU22Si/0W+/WWcuwRh
         tdyd6pu6j4OjV2AzgFiZRJogGHe4yvQQ0JNeSRuQNx95rgpGMeZltYHnXhCphU21PMIN
         SwRQ==
X-Gm-Message-State: AOAM530VSwrcZgmAGZht1kU77tta+QV5iFkG4eAnmRH69EOx2j7GZoxc
        ctU1a2QQCu1n0qDl+2C4QY7naw==
X-Google-Smtp-Source: ABdhPJx0aXaKeloHsr9QGNEEDau0lh32ZHQZJQ1m7oA0GayR5TMfTM/IufYD/dXI5ahtsSEzPZ6Xow==
X-Received: by 2002:a17:902:6b43:b029:e6:3d73:e9fb with SMTP id g3-20020a1709026b43b02900e63d73e9fbmr11384932plt.37.1615517111244;
        Thu, 11 Mar 2021 18:45:11 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id h5sm3498426pgv.87.2021.03.11.18.45.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Mar 2021 18:45:10 -0800 (PST)
Date:   Thu, 11 Mar 2021 18:45:09 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Sami Tolvanen <samitolvanen@google.com>
Cc:     Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Will Deacon <will@kernel.org>, Jessica Yu <jeyu@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, Tejun Heo <tj@kernel.org>,
        bpf@vger.kernel.org, linux-hardening@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kbuild@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 07/17] kallsyms: cfi: strip hashes from static functions
Message-ID: <202103111843.008B935F8@keescook>
References: <20210312004919.669614-1-samitolvanen@google.com>
 <20210312004919.669614-8-samitolvanen@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210312004919.669614-8-samitolvanen@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 11, 2021 at 04:49:09PM -0800, Sami Tolvanen wrote:
> With CONFIG_CFI_CLANG and ThinLTO, Clang appends a hash to the names
> of all static functions not marked __used. This can break userspace
> tools that don't expect the function name to change, so strip out the
> hash from the output.
> 
> Suggested-by: Jack Pham <jackp@codeaurora.org>
> Signed-off-by: Sami Tolvanen <samitolvanen@google.com>

(Is it possible we could end up with symbol name collisions? ... though
I guess we would have had collisions before?)

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
