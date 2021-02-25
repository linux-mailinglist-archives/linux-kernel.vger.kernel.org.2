Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6FD72325896
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Feb 2021 22:24:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234202AbhBYVYf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Feb 2021 16:24:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233916AbhBYVY2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Feb 2021 16:24:28 -0500
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90BAEC061786
        for <linux-kernel@vger.kernel.org>; Thu, 25 Feb 2021 13:23:48 -0800 (PST)
Received: by mail-pj1-x1033.google.com with SMTP id t5so5632127pjd.0
        for <linux-kernel@vger.kernel.org>; Thu, 25 Feb 2021 13:23:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=zl7BGuEjRmRiIwCyoaPfFxWDxWG1s1pkq54saj9Pb+Q=;
        b=ZvNpz1SLjAkZXy8QFcEi+pMYA09UJhW69MDf1cOmpIxOH3XnIdEDjr2XcCN1KRj7q4
         0+8oqrrbbznjDHZAbrrfsI5TxEfwK+gmT/c5obSSzCBCfWUW98aAX+cY21BFv56e3XQb
         6tWKVweUE0lw6nSI5oUA4Pt4KQU6PZ1AgL3hI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=zl7BGuEjRmRiIwCyoaPfFxWDxWG1s1pkq54saj9Pb+Q=;
        b=IeD/sQ3EFrOj3O1vNJzgnDxa6TnZ7WRvDuyz0SPcKPVtrzHHt6LxdIeM1PeJvg7PAT
         wWWogImJljmvOoSfEnhOE9EIWPrjAqwxq0eOZZ3Daden2Iq2OuZwKUkGGlLly3SIPllz
         JJDstFkSSfQmqbTY0UYiZsos5yRMbSK0g0kqP1naJczjeWAQSUZS0yJ+fuqth2zT4wM/
         N/WkxBR35YuD5Uq3M08bTQUsx+W4lOSGWcP2EvaRoLoF7QrbMC1YcATzH74YOqo4iQqY
         DdQmM4v16m43+Wi8seIL6uIsuCO9LGv4yu5WHEDNPE4kHQs2eiVlQcsDCtK5AvFDJfBW
         GijA==
X-Gm-Message-State: AOAM532HoGoTTSDC+HQoyiMThb5ajJlJOOgx+oMd0wgrzgKGUF8ZAfUG
        Cpzt10Aa3fnB7y2auZP0iqkPjA==
X-Google-Smtp-Source: ABdhPJzl9SAZt3si9WtKf9YFkozO0evA7KE3UpvwhBd7Ug15yhD53/Z0pLqAt16pwyHfzB0nuyw8nw==
X-Received: by 2002:a17:902:9a46:b029:e2:f97b:47da with SMTP id x6-20020a1709029a46b02900e2f97b47damr4422664plv.77.1614288228089;
        Thu, 25 Feb 2021 13:23:48 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id z16sm6550218pgj.51.2021.02.25.13.23.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Feb 2021 13:23:47 -0800 (PST)
From:   Kees Cook <keescook@chromium.org>
To:     Helge Deller <deller@gmx.de>,
        "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Sami Tolvanen <samitolvanen@google.com>
Cc:     Kees Cook <keescook@chromium.org>, linux-parisc@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        "Steven Rostedt (VMware)" <rostedt@goodmis.org>
Subject: Re: [PATCH v2] parisc: select FTRACE_MCOUNT_USE_PATCHABLE_FUNCTION_ENTRY
Date:   Thu, 25 Feb 2021 13:23:40 -0800
Message-Id: <161428814140.2305182.15838957882450280547.b4-ty@chromium.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210224225706.2726050-1-samitolvanen@google.com>
References: <20210224225706.2726050-1-samitolvanen@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 24 Feb 2021 14:57:06 -0800, Sami Tolvanen wrote:
> parisc uses -fpatchable-function-entry with dynamic ftrace, which means we
> don't need recordmcount. Select FTRACE_MCOUNT_USE_PATCHABLE_FUNCTION_ENTRY
> to tell that to the build system.

Applied to kspp/clang-lto, thanks!

[1/1] parisc: select FTRACE_MCOUNT_USE_PATCHABLE_FUNCTION_ENTRY
      https://git.kernel.org/kees/c/3d1dc719bca9

-- 
Kees Cook

