Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC9C035927B
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Apr 2021 05:08:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233099AbhDIDIf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Apr 2021 23:08:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232831AbhDIDIe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Apr 2021 23:08:34 -0400
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA2DEC061761
        for <linux-kernel@vger.kernel.org>; Thu,  8 Apr 2021 20:08:20 -0700 (PDT)
Received: by mail-pg1-x534.google.com with SMTP id f29so2816419pgm.8
        for <linux-kernel@vger.kernel.org>; Thu, 08 Apr 2021 20:08:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=qBMvo8evKNRC1mxrN/i7ZVaEgG6elSKJhlY8HtxFtHo=;
        b=NgeQId413/TWMsJRKMQzt4AMwYyCF3vnpS8DNOnr5M9IlgSa+6pklDgCshooKKqU9c
         ybAs87qAUg8YkXygY0a8syQePjVbaDcLRyn3BBBwIY5JngGyXAQ3UN8l0IIBbu5Lo5Vn
         ZGUP6yO8JgEtHdKcMLnH/3YQjlxOOZP8f/lso=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=qBMvo8evKNRC1mxrN/i7ZVaEgG6elSKJhlY8HtxFtHo=;
        b=log1NkxT0fc/RNG51JI7kvdVHv/d8wDJGzMcAYWaDgi+YbxXxYOajvWIbT8y0rhtu2
         cBwYhk32PQ3AB354lsHt9yzVuA+doZOpuf4q9JxQANJww8iLGQLH9ACfwK+AzuCcgUqQ
         A0pYZ20ws6ZcYk46Dgri4dTpEJN/xMM+RCgz1psBjmUt/DF0tsZGuC7eUeEi3pF+J2/o
         0VNNG2x15dlTo8QyTEd9Q0Oll9S/nK8Jga8abIN+XrIQ5xAmHS6gAtc/5lhFPZLWicF/
         5lXuT81sDvVOltJ7+WQlGqM1H5IBKAwuxz4ChnbK9G0ULqO6W/tkCivlQK+ByHqOoRmB
         1DOw==
X-Gm-Message-State: AOAM531f3C3d0z0rwn+j119fJBdZ5P1Hna3F79/CWaZZ/wHbmSlT8mhJ
        bdXNeiLXT+CYs4ekkvcwUe9Gew==
X-Google-Smtp-Source: ABdhPJyHo1TPCLI+4uWyuTbfK5+Vodl/lmd7z9H7XsnC6ze0ivUxnfzHT+a9JH2slM6oVprHwdDR8g==
X-Received: by 2002:a65:4d4c:: with SMTP id j12mr10846262pgt.346.1617937700544;
        Thu, 08 Apr 2021 20:08:20 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id x2sm676590pfx.41.2021.04.08.20.08.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Apr 2021 20:08:19 -0700 (PDT)
Date:   Thu, 8 Apr 2021 20:08:18 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        linux-kbuild@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 09/20] kbuild: arm64: use common install script
Message-ID: <202104082007.88622E72F@keescook>
References: <20210407053419.449796-1-gregkh@linuxfoundation.org>
 <20210407053419.449796-10-gregkh@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210407053419.449796-10-gregkh@linuxfoundation.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 07, 2021 at 07:34:08AM +0200, Greg Kroah-Hartman wrote:
> The common scripts/install.sh script will now work for arm65, no changes

nit: arm64

> needed so convert the arm64 boot Makefile to call it instead of the
> arm64-only version of the file and remove the now unused file.
> 
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will@kernel.org>
> Cc: linux-arm-kernel@lists.infradead.org
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

With that fixed:

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
