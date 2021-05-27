Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B18CF3938AB
	for <lists+linux-kernel@lfdr.de>; Fri, 28 May 2021 00:20:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236389AbhE0WWH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 May 2021 18:22:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235032AbhE0WWF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 May 2021 18:22:05 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFAECC061574
        for <linux-kernel@vger.kernel.org>; Thu, 27 May 2021 15:20:29 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id s4so644305plg.12
        for <linux-kernel@vger.kernel.org>; Thu, 27 May 2021 15:20:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=884VghC01TjQ3oIxVCfrrH69EZr17LL3ZWrNS8Yzksc=;
        b=eTWtOyDXaVAbz6RM03KF2vpw0Qtzk1rcnRkx0Bb0v3wBH00aM6FzrCwEt5x0LLGzk2
         HAhHWbNJJrUuOTMETEy1lNaMCiu3LEKxJ6liY0wIgPhbjPKYtLOanbifaG7vqZ71B57Q
         3iPYzOEATPIZvGRt0AgCfqHULBp2yVM4XaYUA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=884VghC01TjQ3oIxVCfrrH69EZr17LL3ZWrNS8Yzksc=;
        b=V9hX1BNuIAF6BaR6CD03uDaq/HE9h5YvZd7uVOzd77qoUph/Zo0QidLQCtkbSxzYK+
         buHiBXuymp0QXTZcq+dSLqRo8rmEhBz6+/SdW/CDaeSA1kRq81NhZerdOrnOTUA/vCUI
         nNqdgLVRnEA7LwS8F8x/M3NQSkj5pe2eNFM3EeTwA72h7FCgJO+OvRVNCS9hIFpoL7vj
         osOkDkI1f4ZKrHmEzP/CGzBBcFNpv3W0iLKRuedaP5MWUCXOIDs8UQAGpvOCNXiOPCQR
         rMAG0BA8Phf/uQeelI4y94E6RjAL65n5mSYPDIH6mVW2yT7l+RYrNpxBuwDZbO4i7IPM
         INdw==
X-Gm-Message-State: AOAM530bq019QMhdYhyn88AvWnCAL1CHVMhx+jo7Osn7Y60LZkWz8f7p
        B7xVejAFO5za9BSwt8T22JlOgA==
X-Google-Smtp-Source: ABdhPJzZloMnHeYHEg6NQlKP5tojiWQ4fhOjaw876Vi053KzhQohlVZKL1I5x/k9LxL1YiCbK7dW5Q==
X-Received: by 2002:a17:90a:7d15:: with SMTP id g21mr803760pjl.37.1622154029049;
        Thu, 27 May 2021 15:20:29 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id w11sm2677914pfc.79.2021.05.27.15.20.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 May 2021 15:20:28 -0700 (PDT)
Date:   Thu, 27 May 2021 15:20:27 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Will Drewry <wad@chromium.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Andy Lutomirski <luto@amacapital.net>
Subject: Re: [PATCH] selftests/seccomp: Flush benchmark output regularly
Message-ID: <202105271519.4C8BD290@keescook>
References: <20210527033018.3731126-1-keescook@chromium.org>
 <CAAFS_9GA8UFoN4YYN0cJGXft74op-YaL9H9KvF-FyacLX_qPzg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAAFS_9GA8UFoN4YYN0cJGXft74op-YaL9H9KvF-FyacLX_qPzg@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 27, 2021 at 02:05:38PM -0500, Will Drewry wrote:
> On Wed, May 26, 2021 at 10:30 PM Kees Cook <keescook@chromium.org> wrote:
> >
> > When running the seccomp benchmark under a test runner, it wouldn't
> > provide any feedback on progress. Force IO flushes during the test.
> 
> Would it make sense to just setbuf(stdout, NULL); in main?

*forehead slap* Ugh, yes. That works much better. I will respin. Thank
you for the reminder about setbuf() existing. :)

-Kees

-- 
Kees Cook
