Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 922323383F4
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Mar 2021 03:48:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231468AbhCLCsN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Mar 2021 21:48:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231700AbhCLCry (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Mar 2021 21:47:54 -0500
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F2FEC061765
        for <linux-kernel@vger.kernel.org>; Thu, 11 Mar 2021 18:47:54 -0800 (PST)
Received: by mail-pj1-x1030.google.com with SMTP id x7-20020a17090a2b07b02900c0ea793940so10058906pjc.2
        for <linux-kernel@vger.kernel.org>; Thu, 11 Mar 2021 18:47:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=3pbYYGaj80nmpPvKAoi7nhvjG8dX/laYbfFgJvGfe3c=;
        b=TVvY3uWHgNwAIsZEgnbifL/pc30apYHHTufaQZzVegGdzliIuHgvA8Nbd8Lrll72FY
         KFmxKs8QqhJcSAjCd6mlI3lKltRekuyYpF/AgZJ6+fCknS1tomIK1kPZGVB92pEeZEVp
         3UjOXcbS9ZxbdtV8l7DXBsqnx9hkNEYwPcarI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=3pbYYGaj80nmpPvKAoi7nhvjG8dX/laYbfFgJvGfe3c=;
        b=X9ie2b+447FqzPGItyzUbGakJkcs5TyHbH5p+czNmcF6+6DweDav7iquM95x/qwowh
         NBn4FDjPApG7eo1ZiP+PfLklwZI+pzoYI77tm3PQnU8HQU5b4hHI18pfsXWqCPrrvE4R
         EHQf+4qna8Zb9/jLV5M9iIUbaLnSPiDkz1ZmZAZABAScbD0A/z79v8EcFCdMHNxCMsx0
         BOms6lU7EAU9CCP8LE1O0Bm8G0hfmSQRZYaTeq1HXC1a5s7/QFR23RjIcIy615UrhXji
         zOxwyv6BT38Qtazf6+XoFW0aNlsL1SSe/wDl46ueTWbRW7D3vtzanVk2vXaDaDa3f0aL
         5DOQ==
X-Gm-Message-State: AOAM531GKCyOto/24Dt44mCd2GeCocfkYsKGd3KTwis4V16P5YUWl6IB
        YepmuFquWoXnYMISd7jdgvpwIw==
X-Google-Smtp-Source: ABdhPJxK8F7zRzFG3Hv59fvgnwRI+OZARJnDoK1+LfDL/LiWLtBVkDEva8AoU4vTLsGb4IOwAup2lw==
X-Received: by 2002:a17:90b:f15:: with SMTP id br21mr11959110pjb.234.1615517274302;
        Thu, 11 Mar 2021 18:47:54 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id d24sm381554pjw.37.2021.03.11.18.47.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Mar 2021 18:47:53 -0800 (PST)
Date:   Thu, 11 Mar 2021 18:47:52 -0800
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
Subject: Re: [PATCH 14/17] arm64: add __nocfi to functions that jump to a
 physical address
Message-ID: <202103111847.0EC7EDBF@keescook>
References: <20210312004919.669614-1-samitolvanen@google.com>
 <20210312004919.669614-15-samitolvanen@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210312004919.669614-15-samitolvanen@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 11, 2021 at 04:49:16PM -0800, Sami Tolvanen wrote:
> Disable CFI checking for functions that switch to linear mapping and
> make an indirect call to a physical address, since the compiler only
> understands virtual addresses and the CFI check for such indirect calls
> would always fail.
> 
> Signed-off-by: Sami Tolvanen <samitolvanen@google.com>

(I wonder if there is some value in a separate macro for "makes a PA
call"? Might other things care about that besides just CFI?)

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
