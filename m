Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0AF973FB941
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Aug 2021 17:51:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237644AbhH3Pu7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Aug 2021 11:50:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231725AbhH3Pu5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Aug 2021 11:50:57 -0400
Received: from mail-qk1-x72d.google.com (mail-qk1-x72d.google.com [IPv6:2607:f8b0:4864:20::72d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39A2DC061575
        for <linux-kernel@vger.kernel.org>; Mon, 30 Aug 2021 08:50:04 -0700 (PDT)
Received: by mail-qk1-x72d.google.com with SMTP id t4so16122092qkb.9
        for <linux-kernel@vger.kernel.org>; Mon, 30 Aug 2021 08:50:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=3EjivDiNW5dAOyhrOMqEWL8a+PXeFCbzRwgo6qum9x8=;
        b=oQZXiB4wg3hwg9pROFj1CoypHmcCfz4uSOZBMPOw/xjTn1PwskNdiAZ/vTxdS92iNc
         1HD/EDIlpMW/dhprQTo1DzB/D3P7QvETxar+Gedl9J2hDunJdSk3gJJZHazGVJIkdf1a
         Lf342kZ0S2V8+IXepRe5lGNz6535xTxR8R991bYdMBtyKjEdf7pyQBzRa6gALfw97g1k
         WSerrn33LjuqjHnEzFXzE9MO5fQHDrpCRu/2ggL26yCod5jR6uUNibiKGasAVkJnGX/F
         SAD5E0crVc5OgON5VR4F+OlqxD/8hJeXwHvILMqK2JBNZPbr6F20TWumUGkv/HFvBu5O
         vEOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=3EjivDiNW5dAOyhrOMqEWL8a+PXeFCbzRwgo6qum9x8=;
        b=JJdy0l4fvXSYdUvwJKzopDxdxXO48qv+szYOGa1xaKsfsgg1c8D4ADB4xnwfwnVpd9
         Y6z1ev2GplnPOUvmI1R+mE1iC4wq6neiRKqy4thh1caOHjMh9FSCe/u4XN24M9RIPklf
         n1m/RPBpqub+a+xBXCjA9lRQ4EWzVpTJcGTrfyYDlafqSHw6ezNHbYzZtjEV/aj99cZt
         FYrGiLLpgVXKYVcfI2k3QUYEqR4Rk8AMun1AsuzncKAqEKy7LojWOgPLL8Qp11a0kCOR
         QsIOIOxZg7nvJ7BSIEhBx0AWIO6c/DA9gMfQ4nbBJDyNKgyrDBMLOSpVZc0b5Dwvavz5
         BLoA==
X-Gm-Message-State: AOAM531SZ+yrBbULzr9GoUgUrz0STOynvVa/f6tKY1JgflLNsGHWCCRk
        +9J7IWSBVOPAtihIwNra1KMzJsSGDpI=
X-Google-Smtp-Source: ABdhPJzWXWn+YQQ1fdQPNgufa2i+54nhHiOyLZOncNbYj+OEbg09OUaqVYm1Qs5NCHQ177vQ/KkCQw==
X-Received: by 2002:a37:68d0:: with SMTP id d199mr23264888qkc.96.1630338603341;
        Mon, 30 Aug 2021 08:50:03 -0700 (PDT)
Received: from vps.qemfd.net (vps.qemfd.net. [173.230.130.29])
        by smtp.gmail.com with ESMTPSA id q184sm11750482qkd.35.2021.08.30.08.50.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Aug 2021 08:50:02 -0700 (PDT)
Received: from schwarzgerat.orthanc (schwarzgerat.danknet [192.168.128.2])
        by vps.qemfd.net (Postfix) with ESMTP id 6757D2B361;
        Mon, 30 Aug 2021 11:50:02 -0400 (EDT)
Received: by schwarzgerat.orthanc (Postfix, from userid 1000)
        id 57E756001F5; Mon, 30 Aug 2021 11:50:02 -0400 (EDT)
Date:   Mon, 30 Aug 2021 11:50:02 -0400
From:   nick black <dankamongmen@gmail.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Jiri Slaby <jirislaby@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] console: consume APC, DM, DCS
Message-ID: <YSz+KnydjtIC3dtK@schwarzgerat.orthanc>
References: <YSydL0q8iaUfkphg@schwarzgerat.orthanc>
 <0f094eb9-11d4-1bd5-0a1b-823317ad4f7d@kernel.org>
 <YSysHCQyN+brJLEj@schwarzgerat.orthanc>
 <CAHk-=wg6-HbEPEC6-Fz0kqnHsB4nZryWi5TEZEN=NCWzBtg4iw@mail.gmail.com>
 <CAHk-=whjqVuOL-0Ar85dapyU=jiVWASQnzoyxv=wL7ZEOwFUUw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=whjqVuOL-0Ar85dapyU=jiVWASQnzoyxv=wL7ZEOwFUUw@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds left as an exercise for the reader:
> Side note: it would have been nice to see "v2: whitespace changes" or
> something in the patch description, below the "---" that cuts off the
> commit message.
> I had your previous patch version pending, and had to check what had
> changed in the re-send.

thanks for the feedback and heads-up. i'm looking to do some
further work in this area over coming weeks, so i'm glad to hear
you're interested in it =]. this patch was not just conformance
for conformance's sake -- Notcurses is doing several queries
which leave nastiness on the screen without this.

thanks for the merge! =]

-- 
nick black -=- https://www.nick-black.com
to make an apple pie from scratch,
you need first invent a universe.
