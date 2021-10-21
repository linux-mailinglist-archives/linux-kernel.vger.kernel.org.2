Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 44D524367E7
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Oct 2021 18:35:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231952AbhJUQhR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Oct 2021 12:37:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231749AbhJUQhP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Oct 2021 12:37:15 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F143AC0613B9
        for <linux-kernel@vger.kernel.org>; Thu, 21 Oct 2021 09:34:59 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id u6so817818ple.2
        for <linux-kernel@vger.kernel.org>; Thu, 21 Oct 2021 09:34:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=g18UoufPwLwrXB6C5k/HZxl4B7ioRgvSnA8Dlx3FVgE=;
        b=LVa/QvqLEdTuP61OUqb4Y03AEXN7vMxshUOovUpDLr4NRZoCudXKJK37m7clmYc/Jv
         4Dz5FrAeUfk/xIOI58kbcq+0swq49Inx7QOcF9sOD1g6iUANYFh50c5LeyNn4L9M2UBD
         1pjfbwdKUH1KaS60PqI1aSAi9DaKxHXGFVNnw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=g18UoufPwLwrXB6C5k/HZxl4B7ioRgvSnA8Dlx3FVgE=;
        b=mmfDE8k4yVp4WEBD+Klx0oTkUH9clgoILriB2tSKvPEhz9F36xNRV8cQe7oxvdeApg
         A3C2DqNgj4OoPHf/OJ95vtHZfFuqHuDinlw/qGve/F+h8GfCAAq2NhwcL5XTcAre2sOM
         bbSTJiKh9nFmqgMkWlWJF9ZmwRYq5KZVDl67ofKkcL+imKdiGMd8cXVPJAqtLDc7rFz9
         yxbAEH2GeTbcvJelIZ+fVHGb1HNHFfFdHY7JLUb3lexCir38Dva3ugCzb1tQ0NwnZjb+
         KISueebeDUDYTeYILkiSiCdMicvryI8Vb9WelF1cbH9GUABO11MgANKoIcDsxdvDXjwb
         YpEQ==
X-Gm-Message-State: AOAM531lc3SR8NsOxjicfXxiGaSgQ0GyPUA8Koa4Q1Butxdv95CUPXvP
        erf99KYZT7OXV6lBeQR6WcvhXQ==
X-Google-Smtp-Source: ABdhPJzFAVcp7GM7lGGEbe8W4YoGodE1JUucBdO8LFX2Ib5xA1dAmtXQZQRdRQQeNjM6GHNZzt7KvQ==
X-Received: by 2002:a17:90b:1e4a:: with SMTP id pi10mr7866481pjb.142.1634834099560;
        Thu, 21 Oct 2021 09:34:59 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id r31sm9969468pjg.28.2021.10.21.09.34.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Oct 2021 09:34:59 -0700 (PDT)
Date:   Thu, 21 Oct 2021 09:34:58 -0700
From:   Kees Cook <keescook@chromium.org>
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Oleg Nesterov <oleg@redhat.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        David Miller <davem@davemloft.net>, sparclinux@vger.kernel.org
Subject: Re: [PATCH 16/20] signal/sparc32: In setup_rt_frame and setup_fram
 use force_fatal_sig
Message-ID: <202110210934.E84B977268@keescook>
References: <87y26nmwkb.fsf@disp2133>
 <20211020174406.17889-16-ebiederm@xmission.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211020174406.17889-16-ebiederm@xmission.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 20, 2021 at 12:44:02PM -0500, Eric W. Biederman wrote:
> Modify the 32bit version of setup_rt_frame and setup_frame to act
> similar to the 64bit version of setup_rt_frame and fail with a signal
> instead of calling do_exit.
> 
> Replacing do_exit(SIGILL) with force_fatal_signal(SIGILL) ensures that
> the process will be terminated cleanly when the stack frame is
> invalid, instead of just killing off a single thread and leaving the
> process is a weird state.
> 
> Cc: David Miller <davem@davemloft.net>
> Cc: sparclinux@vger.kernel.org
> Signed-off-by: Eric W. Biederman <ebiederm@xmission.com>

Nicely already had the return path written. :)

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
