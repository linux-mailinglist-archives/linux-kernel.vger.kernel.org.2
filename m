Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 80AE43FCC5A
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Aug 2021 19:31:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240389AbhHaRcH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Aug 2021 13:32:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240324AbhHaRcE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Aug 2021 13:32:04 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC923C061760
        for <linux-kernel@vger.kernel.org>; Tue, 31 Aug 2021 10:31:07 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id u11-20020a17090adb4b00b00181668a56d6so3004338pjx.5
        for <linux-kernel@vger.kernel.org>; Tue, 31 Aug 2021 10:31:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=5LyN0K+Wus5Cj53RnJaq/QRwIimxfpbtiHPTvrng6hg=;
        b=nyzULMjwjJw6h/+Oy1rkXR5IyeiOrfFqiN6AVnkctw3ssI+hirKxSRuQEze7nxWScm
         YPrM+qgb1UTHnIPbwGJYwy+z5jKknx/1TrCDo0rja5PKQCb4h2KcYHtyzpzzLcUKWX/j
         vuM7sAb3MX8hLz/wqRYrvDUxUbKZS5r+txjmw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=5LyN0K+Wus5Cj53RnJaq/QRwIimxfpbtiHPTvrng6hg=;
        b=okXJJtQwhBUvRan0bHa1DZxlSQhKv0lDLBn27lGai6MxDWI1wGZwAAYJn4vbk2u64H
         vpgIMVHNMo2qe9xG28tyXmaPYsUfb4FTBe5L52Yzg1HBXIjq8wHUwaFzCXfs/QQfeuul
         0Uo0tF/nrNBt9Gy3AsIQKlnHFqXu7HAfwaZqlWYuP3NxA2zqgyqurR7M+IKBQiW4x50c
         b8cbAPUBY2Azew4wxlEcSBehWj0T8FaYzNn3XsQ6zBJv+gLcwOFkGcEjvXXvZNud+i9M
         /psnxw53FlqF6EfdpfZ5nBqG0tF95A9GO83O2hN4k8KILSCB3PjUC0RzYjGw99rA7K+R
         Ekdw==
X-Gm-Message-State: AOAM533V+15VDk5TFWgtbn6XX9RjDrjUUqHeqnbOI14K32b36TxFp424
        m+27uqBCdYDN1OdoRo9A1b0Oqw==
X-Google-Smtp-Source: ABdhPJyreXlCVuGBRZGGEG/FVzXeBVHZmYwNxr4ysj6JV2xB/EulpLX2NMh4JPN80o8MPLbWFFUx1A==
X-Received: by 2002:a17:902:8606:b029:12c:2625:76cf with SMTP id f6-20020a1709028606b029012c262576cfmr5692548plo.17.1630431067343;
        Tue, 31 Aug 2021 10:31:07 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id c24sm10985547pfd.145.2021.08.31.10.31.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Aug 2021 10:31:06 -0700 (PDT)
Date:   Tue, 31 Aug 2021 10:31:05 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     linux-kbuild@vger.kernel.org,
        Michal Marek <michal.lkml@markovi.net>,
        Nick Desaulniers <ndesaulniers@google.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 04/13] kbuild: factor out OBJECT_FILES_NON_STANDARD
 check into a macro
Message-ID: <202108311030.CEA8856D@keescook>
References: <20210831074004.3195284-1-masahiroy@kernel.org>
 <20210831074004.3195284-5-masahiroy@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210831074004.3195284-5-masahiroy@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 31, 2021 at 04:39:55PM +0900, Masahiro Yamada wrote:
> The OBJECT_FILES_NON_STANDARD check is quite long.
> 
> Factor it out into a new macro, objtool-enabled, to not repeat it.
> 
> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>

Looks right to me.

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
