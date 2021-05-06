Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB941375820
	for <lists+linux-kernel@lfdr.de>; Thu,  6 May 2021 18:04:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235724AbhEFQE4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 May 2021 12:04:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235156AbhEFQEw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 May 2021 12:04:52 -0400
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25ABAC061574
        for <linux-kernel@vger.kernel.org>; Thu,  6 May 2021 09:03:53 -0700 (PDT)
Received: by mail-lj1-x22b.google.com with SMTP id p12so7745979ljg.1
        for <linux-kernel@vger.kernel.org>; Thu, 06 May 2021 09:03:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qyVEBL+xt1SQPCegOBTUU+QFYg0wXbsBFOTlu91fBI0=;
        b=T0KSrzdSGE888MPYuUq4G9EM95hI7x6fGzbOVXyDI1FWHmes4gTalsGxdVnFz4ykq7
         XPdAI1NUBLfokLmeJRjRLyh5mwLSByqOeNom7T0l5aonABz7mxnLRjEMkTgWBgBtRAGP
         kki0T4yJ3PI9LTsSAcQCEI1a/QXBHL3xJR3O0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qyVEBL+xt1SQPCegOBTUU+QFYg0wXbsBFOTlu91fBI0=;
        b=q+rx703YfQ4Z3SH/XPvbU/dtc9RnNTd5vp+JBrQ4p6K1xwz9y5NsC6C9yS1fmorB7z
         jNcrghnXVTHeINXT8igc+O9luKmIrHyJ13SwJkzH+WZ2k/LBSjxYAtm6nQf/jzSvSKUE
         bGk4u7koOsTGgOfSljr+kqNGKGqUl2yQ1w/iwmEbbb3fUWn+mJqK1+2w749eKaTDrItV
         H2FjUjCbMGs0RpJGE6AQOMmjPYaOIM7vI8UntvaAK+TDxB3qkiPRtG7gbZIwTt11RarF
         w7yOHk54N5t9rSeOSy2pvEDxIIlUj+fGXbbM+1pxeSbnh1Aw+YzlN7dSBAJtbkFbqyej
         47qQ==
X-Gm-Message-State: AOAM532dDaPIckPEXBbnc3x1QxFn9yAWDofzQdkJTkfLSKq7UdgrNQjV
        k5m8sEaqMcIBW7r91rVp7qxeRv1ZmcsPb9M5GX0=
X-Google-Smtp-Source: ABdhPJz6xSPYiZxLGcoaEEgV7lfxCoWPhQOQa/Ry+5D9e0YgKBh37tz9VaodcioZF1EBOkHAnAVBKw==
X-Received: by 2002:a2e:99c2:: with SMTP id l2mr2977090ljj.125.1620317031407;
        Thu, 06 May 2021 09:03:51 -0700 (PDT)
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com. [209.85.208.179])
        by smtp.gmail.com with ESMTPSA id m4sm394722ljp.9.2021.05.06.09.03.49
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 May 2021 09:03:49 -0700 (PDT)
Received: by mail-lj1-f179.google.com with SMTP id u20so7688591lja.13
        for <linux-kernel@vger.kernel.org>; Thu, 06 May 2021 09:03:49 -0700 (PDT)
X-Received: by 2002:a05:651c:3de:: with SMTP id f30mr4067041ljp.251.1620317028967;
 Thu, 06 May 2021 09:03:48 -0700 (PDT)
MIME-Version: 1.0
References: <a81e116ba3d64aab8d379703bedcf032@codeaurora.org>
In-Reply-To: <a81e116ba3d64aab8d379703bedcf032@codeaurora.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 6 May 2021 09:03:32 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgU-ERpeM0CJnN8JTVVUsBRtgpvU33sKke67V6pZj6A=g@mail.gmail.com>
Message-ID: <CAHk-=wgU-ERpeM0CJnN8JTVVUsBRtgpvU33sKke67V6pZj6A=g@mail.gmail.com>
Subject: Re: [GIT PULL] hexagon changes for v5.13
To:     Brian Cain <bcain@codeaurora.org>
Cc:     linux-hexagon <linux-hexagon@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        sidneym@codeaurora.org,
        clang-built-linux <clang-built-linux@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 5, 2021 at 2:10 PM <bcain@codeaurora.org> wrote:
>
> Please pull the following changes for Hexagon: they contain build fixes.

The pull looks fine, but I'm wondering what key you've signed this with?

I find your key 175C464E541B6D47 in the kernel.org pgpkeys archive,
but your tag was signed with RSA key 1A54AFB8E5646C32, which I don't
find.

And the standard keyservers are - as usual - not very helpful.

I'd have loved to see a key I recognize, and I was hoping to also see
that key signed by Richard Kuo. And maybe it is, but I can't find it..

Anyway, pulled, just hoping for some clarification,

                Linus
