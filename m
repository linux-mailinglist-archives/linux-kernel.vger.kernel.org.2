Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 941F5344B4D
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Mar 2021 17:28:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231902AbhCVQ2h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Mar 2021 12:28:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:59608 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231195AbhCVQ2S (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Mar 2021 12:28:18 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 342BF6198E
        for <linux-kernel@vger.kernel.org>; Mon, 22 Mar 2021 16:28:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1616430498;
        bh=hKSQLkY2oC69mPcZ6TI/L5EnOfY2hPSxx6Pvk86SVqY=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=WE7f8JQ7HPxnyP4DP3K7c5cXB9y2Fu5PtzxMS4FcprRcJ7ivROQK8clPKrRF8J/bN
         SMWEhezXbHTvlWkfzWy5UdIHRomiKMNts6kLJkoI0uJ7E2+vLx1VJRuypwBj+bD0aY
         B63MNQm0BU09IfgpnW8bRRQTDKvOj3yUoxSGcXlBTvw/qA39dLVtNT1Wncwm5+Q2mk
         0yxDozTHIhiNuCi6GdLiSPDhNcswVoUh2U3QFCiKsrJsqHkj+HCsiPUiySATTFa39j
         KzQs2Rn/tv77qTwd6z72iXdKkji0DIyRqFH1tpiVU6D3RZf1hhcVmOQJiI8tDolG+x
         Nxp0FTGGTIrfg==
Received: by mail-ot1-f49.google.com with SMTP id 31-20020a9d00220000b02901b64b9b50b1so16508413ota.9
        for <linux-kernel@vger.kernel.org>; Mon, 22 Mar 2021 09:28:18 -0700 (PDT)
X-Gm-Message-State: AOAM530aleApH8WFlRQEUXoBUPiu4+BYkKculV2vHjt4zRClcPTcHUQR
        b1elf3dcdpO9KyR7mt+wUls8fzoW79U8I24vj3E=
X-Google-Smtp-Source: ABdhPJxubyxVHf5kmA7mDuWA+s7TJCuJV7+LNP+mXCIls5AgH+PTYr8Ja2fiYk4IE/HxbfsbBOkaZO+arW/zwwKeJtU=
X-Received: by 2002:a05:6830:148c:: with SMTP id s12mr587764otq.251.1616430497463;
 Mon, 22 Mar 2021 09:28:17 -0700 (PDT)
MIME-Version: 1.0
References: <20210322114536.3517661-1-arnd@kernel.org> <20210322143344.GN3141668@madcap2.tricolour.ca>
In-Reply-To: <20210322143344.GN3141668@madcap2.tricolour.ca>
From:   Arnd Bergmann <arnd@kernel.org>
Date:   Mon, 22 Mar 2021 17:28:01 +0100
X-Gmail-Original-Message-ID: <CAK8P3a2NkB7COUetdq65cSNjVe7-96c44=4JE5BXkBwXG-5nyQ@mail.gmail.com>
Message-ID: <CAK8P3a2NkB7COUetdq65cSNjVe7-96c44=4JE5BXkBwXG-5nyQ@mail.gmail.com>
Subject: Re: [PATCH] audit: avoid -Wempty-body warning
To:     Richard Guy Briggs <rgb@redhat.com>
Cc:     Paul Moore <paul@paul-moore.com>, Eric Paris <eparis@redhat.com>,
        Jules Irenge <jbi.octave@gmail.com>, linux-audit@redhat.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 22, 2021 at 3:33 PM Richard Guy Briggs <rgb@redhat.com> wrote:

> > Change the macros to use the usual "do { } while (0)" instead, and change a
> > few more that were (void)0, for consistency.
>
> So what about audit_put_watch() and audit_get_watch() which are set to
> {}?   (And all of include/linux/audit.h that uses the latter...)  Does
> this only matter if they are the only action called in an if or loop?
>

I missed those, thanks for pointing it out. I sent a v2 patch now.

         Arnd
