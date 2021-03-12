Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C829F3383D0
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Mar 2021 03:46:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231685AbhCLCpf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Mar 2021 21:45:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231591AbhCLCpT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Mar 2021 21:45:19 -0500
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49743C061765
        for <linux-kernel@vger.kernel.org>; Thu, 11 Mar 2021 18:45:19 -0800 (PST)
Received: by mail-pf1-x432.google.com with SMTP id j12so847126pfj.12
        for <linux-kernel@vger.kernel.org>; Thu, 11 Mar 2021 18:45:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=AssdNLgVnE+ciH4+zO5lxL3YhHsnzigu9rKdFnlTKlk=;
        b=hIQlmeCWP7pIGfJ5QNK11xJD01Ah5yhUwvyA2ww7yhNm+fTC+X7nXsvxCf/cfPJkw8
         nkcI9fivFzWEt/maVUeYndiFDn25FO8B7W04AYR/UDOt3gRYjRZzQNUCnbTnncwE0cZP
         XqXc4TvxtdB2n7+7RQIxaEFd3VdXAy+vdwy6o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=AssdNLgVnE+ciH4+zO5lxL3YhHsnzigu9rKdFnlTKlk=;
        b=qUTE7F+jfsvoO0CuxUu5+5/+LHN6hHeulbl2/sAlQwlA+tXoWY+j1oZP05m0jJOH30
         pIUIGSXjR5hKjyo82/2GaR+k5UZ5cPaPMix6XYmLqAJUyckE0WVCtDizVavP0BxqV12S
         PNKr5ZEZd+zCYMa0jFfpMuvql7kLEA3Zj/UYoXJy/0/invR6uOKx1pjLJPKkrJomqp1t
         PCOJ61CaW9YNleaWmTg/ajyJ4slHtaRXN5f4W6ZBoDQyyP+eTzo92QSAkE67tE/DBczd
         aUecydhKZ+V8z5bcsFg+yqp3dcuwpDoBK86DaXmbcK2NmJ530pS+YVaZ7ifQt0O0RN+J
         LB1g==
X-Gm-Message-State: AOAM530Z8Iw/MMaROrnEvP+xb1IEdBsXnBQeGhTlVfVTQSAFd39iz/5R
        I4UAZ0cZF6LdKngXVmb9QnPnFQ==
X-Google-Smtp-Source: ABdhPJxI0qWCdvIWD0Iv1exumtIeT9fGoJnsI5bP8+qNI3aaTbYLPtnoi/Tg5jl4840YLUIassNTiw==
X-Received: by 2002:a63:1e0a:: with SMTP id e10mr9855197pge.3.1615517118872;
        Thu, 11 Mar 2021 18:45:18 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id 14sm3673048pfo.141.2021.03.11.18.45.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Mar 2021 18:45:18 -0800 (PST)
Date:   Thu, 11 Mar 2021 18:45:17 -0800
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
Subject: Re: [PATCH 08/17] bpf: disable CFI in dispatcher functions
Message-ID: <202103111845.3A6EEB3E43@keescook>
References: <20210312004919.669614-1-samitolvanen@google.com>
 <20210312004919.669614-9-samitolvanen@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210312004919.669614-9-samitolvanen@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 11, 2021 at 04:49:10PM -0800, Sami Tolvanen wrote:
> BPF dispatcher functions are patched at runtime to perform direct
> instead of indirect calls. Disable CFI for the dispatcher functions to
> avoid conflicts.
> 
> Signed-off-by: Sami Tolvanen <samitolvanen@google.com>

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
