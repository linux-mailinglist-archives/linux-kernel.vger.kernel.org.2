Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ABDFA4216A9
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Oct 2021 20:38:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238786AbhJDSkA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Oct 2021 14:40:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234678AbhJDSj6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Oct 2021 14:39:58 -0400
Received: from mail-qt1-x82f.google.com (mail-qt1-x82f.google.com [IPv6:2607:f8b0:4864:20::82f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A136CC061745
        for <linux-kernel@vger.kernel.org>; Mon,  4 Oct 2021 11:38:09 -0700 (PDT)
Received: by mail-qt1-x82f.google.com with SMTP id t2so523242qtx.8
        for <linux-kernel@vger.kernel.org>; Mon, 04 Oct 2021 11:38:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=LY3XIgAipiKQ5KOBfmir+6O81dFl8bwFaRJNVWIJEOQ=;
        b=WswXKoAQ5C7dw5sMYuGmP4LURhz4dqg1ae/EZlIMAXM7NlNuxb5Y2q+UxF4eLf2fpz
         Rg7X+SnBw+hg+GSpbPv0qhJKh2a7jrp5lLV1co9uteJ06nnevhs8ZDCVn9rSkgaie2/4
         Qqgbz1ix7KDs8MKB9RG1XQf/01v8wXsEv9J/M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=LY3XIgAipiKQ5KOBfmir+6O81dFl8bwFaRJNVWIJEOQ=;
        b=xw9rlJfuks2Xb7sqc9/9/vQ2ALr6GZykEDbjt1pct3Ig9OMmrj+KAJ9udU9FeOLo8j
         ouj2OEX8H6/oUs7/JiENaJ8XCsVrP6XG8U/EiYTo0xJR1DKU7ekwu4K6GwelcLEsR/nb
         spMHRRrRBHrPzWU++kpAPoiulxbjQ/rqMXy3UYtI0eFv3W/ZgDykjB/teztQjjlJCK33
         y881gh4LHWkqB8gGGenAa0J27bFRWNi+UUL5T+TsC/sq1IhxBcMiERs66mn/rVlfMIMF
         rP1DpKZSosonCiJnz68HvbTu6D/PaZpOH18ZKZbeMZa3+VLtJd9ffK4SCvOhO29N6EsJ
         C0kA==
X-Gm-Message-State: AOAM531QSdOBnkp/ZBGVMqdnMYtIQ+eOR/hINyR3GgUxlPLsS8oXn6Fy
        5TvFBjeWCYsGrGaGl7U81yUFLA==
X-Google-Smtp-Source: ABdhPJy5qVo8YAG+9IfB7eA2QUTEyLjVNo1J041cwh/+k3Es6uTMBlFZh52NqBmQYegfPH+0wdpiUA==
X-Received: by 2002:ac8:7769:: with SMTP id h9mr15238642qtu.156.1633372688728;
        Mon, 04 Oct 2021 11:38:08 -0700 (PDT)
Received: from meerkat.local (bras-base-mtrlpq5031w-grc-32-216-209-220-181.dsl.bell.ca. [216.209.220.181])
        by smtp.gmail.com with ESMTPSA id g4sm1259206qtp.43.2021.10.04.11.38.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Oct 2021 11:38:08 -0700 (PDT)
Date:   Mon, 4 Oct 2021 14:38:06 -0400
From:   Konstantin Ryabitsev <konstantin@linuxfoundation.org>
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Kees Cook <keescook@chromium.org>, linux-kernel@vger.kernel.org,
        "KE . LI" <like1@oppo.com>, Stephen Boyd <swboyd@chromium.org>,
        Fangrui Song <maskray@google.com>,
        Miroslav Benes <mbenes@suse.cz>,
        Padmanabha Srinivasaiah <treasure4paddy@gmail.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Joe Perches <joe@perches.com>, Jessica Yu <jeyu@kernel.org>,
        Sami Tolvanen <samitolvanen@google.com>, llvm@lists.linux.dev
Subject: Re: [PATCH v6] kallsyms: strip LTO suffixes from static functions
Message-ID: <20211004183806.5weyuk554ppe5olb@meerkat.local>
References: <202110020501.RKX4zca7-lkp@intel.com>
 <20211004162936.21961-1-ndesaulniers@google.com>
 <163337043811.3396838.458236649388694225.b4-ty@chromium.org>
 <CAKwvOdm5bBUE0df8jbXq+bSCf9U0AM3Wm4NsZeHu=Nuhi0yd-A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAKwvOdm5bBUE0df8jbXq+bSCf9U0AM3Wm4NsZeHu=Nuhi0yd-A@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 04, 2021 at 11:32:43AM -0700, Nick Desaulniers wrote:
> $ git format-patch HEAD~
> 0001-ARM-mm-proc-macros-ensure-_tlb_fns-are-4B-aligned.patch
> $ git send-email --suppress-cc=body --to keescook@chromium.org
> 0001-ARM-mm-proc-macros-ensure-_tlb_fns-are-4B-aligned.patch
> patatt: E: -: Not a valid RFC2822 message
> fatal: 0001-ARM-mm-proc-macros-ensure-_tlb_fns-are-4B-aligned.patch:
> rejected by sendemail-validate hook
> fatal: command 'git hook run sendemail-validate -- <patch>' died with
> exit code 1
> warning: no patches were sent

Woah. What git version is this?

-K
