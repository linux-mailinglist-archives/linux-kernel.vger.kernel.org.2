Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B2912309E6D
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Jan 2021 20:59:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231612AbhAaTvw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 31 Jan 2021 14:51:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231192AbhAaTnR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 Jan 2021 14:43:17 -0500
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87D22C0617A9
        for <linux-kernel@vger.kernel.org>; Sun, 31 Jan 2021 11:42:33 -0800 (PST)
Received: by mail-lj1-x22e.google.com with SMTP id b20so9096406ljo.1
        for <linux-kernel@vger.kernel.org>; Sun, 31 Jan 2021 11:42:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gdDG1ar4rnuG4xwDcnEtAG+ycH7kTafI2p4nnyLBOUo=;
        b=OO2lBD2TNTkXe7mzZPdASVGlHz9lxfdCjUsZw3TlUCTGVXRs7xdEzzZqef8UmHP6/B
         2cbMlqpz7gqZ1MJ0BazBSRuJZJGnCAjmsxHmAcE7JIjt0lxpovNgE3MN02dRUYiV7Mpo
         JxgiD2IzvqxehOzAhJ4DuMidZHfD2qrX1ymAA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gdDG1ar4rnuG4xwDcnEtAG+ycH7kTafI2p4nnyLBOUo=;
        b=XfVkFkKw4zvDQlYUnKplaW/KE4jUthHAlGUgQ+9mfGr+zbqFAxqIOaz9QyWK04NvsE
         msQlidC4qfGBan9iTR0IQdVG3096BpLJ5JPUmZMpnlSrCMOyTc4AzdrD+n1P7NGzmBoz
         FJjWb/bdvG3N4L36jfvweMENqJzaUiBWthFUOPy3VipF/AEn7iNv3iPFZlZAA/KVLCvm
         lF7nP0LPkclh0yferW4eXrwRAeeYtlJFPx2Z7oOvH0BJP32R4CnmL9j/Um9EzG8pezRg
         LUnC5CrUIZwRukxCEVeKI2FUsgTedAYMl037wQijtHkiY/lCXvtM46xd+2b88ZCi1cXZ
         w1fA==
X-Gm-Message-State: AOAM531sfZ1CrzO/m1uijo9yYuYMTTs0ZbrJK9jJ0kWUmiCAxPhxMtgc
        9MnFuOydpNK1EQQlj1ITuffNrFuDi2vBpw==
X-Google-Smtp-Source: ABdhPJyy7TMeIHmyFVRzTl37rGwRWCiL3w1MM8el43nB1Kze/8qyglADq02Bb0OxrGHlL2IRQzeECg==
X-Received: by 2002:a05:651c:211e:: with SMTP id a30mr8343137ljq.108.1612122151857;
        Sun, 31 Jan 2021 11:42:31 -0800 (PST)
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com. [209.85.208.180])
        by smtp.gmail.com with ESMTPSA id z17sm2751212lfe.135.2021.01.31.11.42.30
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 31 Jan 2021 11:42:30 -0800 (PST)
Received: by mail-lj1-f180.google.com with SMTP id r14so16988927ljc.2
        for <linux-kernel@vger.kernel.org>; Sun, 31 Jan 2021 11:42:30 -0800 (PST)
X-Received: by 2002:a2e:b70b:: with SMTP id j11mr7993956ljo.61.1612122150092;
 Sun, 31 Jan 2021 11:42:30 -0800 (PST)
MIME-Version: 1.0
References: <161208961675.22671.12893376547737348246.tglx@nanos> <161208961796.22671.11474931705642662612.tglx@nanos>
In-Reply-To: <161208961796.22671.11474931705642662612.tglx@nanos>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 31 Jan 2021 11:42:14 -0800
X-Gmail-Original-Message-ID: <CAHk-=wjYn+4PXdXE+YN=zfNXNOii4AAtUr4xZVcJqEKuD5_07w@mail.gmail.com>
Message-ID: <CAHk-=wjYn+4PXdXE+YN=zfNXNOii4AAtUr4xZVcJqEKuD5_07w@mail.gmail.com>
Subject: Re: [GIT pull] timers/urgent for v5.11-rc6
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "the arch/x86 maintainers" <x86@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 31, 2021 at 2:40 AM Thomas Gleixner <tglx@linutronix.de> wrote:
>
> please pull the latest timers/urgent branch from:
>
>    git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git timers-urgent-2021-01-31

Manual pr-tracker-bot says thanks again.

           Linus
