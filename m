Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9AAB2389D5D
	for <lists+linux-kernel@lfdr.de>; Thu, 20 May 2021 07:52:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230271AbhETFx2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 May 2021 01:53:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229547AbhETFx0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 May 2021 01:53:26 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E4CEC061574
        for <linux-kernel@vger.kernel.org>; Wed, 19 May 2021 22:52:05 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id b15-20020a17090a550fb029015dad75163dso4696146pji.0
        for <linux-kernel@vger.kernel.org>; Wed, 19 May 2021 22:52:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=xVFlntO83dWvWvtx9KvOLjFPmaDKkXXQ5N3aaeDH8ts=;
        b=NnVVrvx74wIAZwYge9TJXULR2rcCO9PQ4JOuiIL/cXLcNUP2ZZ71jhAKBeSfx846uW
         ju7KjFRg6G/SmoHOqToZ8hWy9qULxGPT4hE/X0VJ7agMWjggoxNKxfWQaxRZNUfkLCuP
         DA43acz+uiSepF2+pKukS9cIBsnLvZaIQYcjc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=xVFlntO83dWvWvtx9KvOLjFPmaDKkXXQ5N3aaeDH8ts=;
        b=LAt8Vf0IuruysV1vfQ4lybAFKlAKE1v/bCsdPsyne5GeY0ZvbilesM+rkmhlv4dA4k
         auqr9l+oGPeuCNwrKjNco60/idMqZPML0J8Be0HF7a3p08/epheuzB2V1Oo/bJpEBmpj
         KjM8ti0cuBi4daBDQDzQyC3N0Afk0XKt3nhbg9vPBLot/z1ZKVWqtok1mIS1wixR7KtT
         wldLcsbRhBERJbDb/xCoq5D5ASmFJle9NcoZRN74vQOj8b+T6bk0iXIRTuibHdrjnQJP
         7Y22P6n38CVdzoLNBJf5huCdlnVxRNT1BSTTSranO94LGQCLrX4i32StJCVYVeaylcvV
         +KmQ==
X-Gm-Message-State: AOAM532gBYiy5+99vN0LWteCV1UzrSfKY3JYbP6+KyOnmv1AaqvjTu7t
        OzyKYsxAz0xpkpl+o9wp6nObTA==
X-Google-Smtp-Source: ABdhPJyV0bXl0pcLAlAuaSr7aGRgSP+bR09ru8Y6/49SF6MTqhqi8lxNOXse2c97miniH6akjQ2QtQ==
X-Received: by 2002:a17:90a:f85:: with SMTP id 5mr3022996pjz.64.1621489925015;
        Wed, 19 May 2021 22:52:05 -0700 (PDT)
Received: from google.com ([2409:10:2e40:5100:48db:abf:343e:b4f7])
        by smtp.gmail.com with ESMTPSA id s16sm1025981pga.5.2021.05.19.22.52.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 May 2021 22:52:04 -0700 (PDT)
Date:   Thu, 20 May 2021 14:52:00 +0900
From:   Sergey Senozhatsky <senozhatsky@chromium.org>
To:     Petr Mladek <pmladek@suse.com>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] watchdog: Reliable handling of timestamps
Message-ID: <YKX5AFlDkYqXVNGt@google.com>
References: <20210517140612.222750-1-senozhatsky@chromium.org>
 <YKPfDQoN5hToB9nk@alley>
 <YKT55gw+RZfyoFf7@alley>
 <YKT+GMZVIiRNIDle@alley>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YKT+GMZVIiRNIDle@alley>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (21/05/19 14:01), Petr Mladek wrote:
> This is my preferred solution. It makes it clear when the various
> values are read and various situations handled.

Looks good to me.
