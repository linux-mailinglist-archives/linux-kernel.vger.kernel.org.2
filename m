Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4CC0D309F1C
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Jan 2021 22:33:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231159AbhAaVbV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 31 Jan 2021 16:31:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229983AbhAaVbR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 Jan 2021 16:31:17 -0500
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47BF3C061573
        for <linux-kernel@vger.kernel.org>; Sun, 31 Jan 2021 13:30:37 -0800 (PST)
Received: by mail-lj1-x232.google.com with SMTP id l12so17166600ljc.3
        for <linux-kernel@vger.kernel.org>; Sun, 31 Jan 2021 13:30:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=CaTVIGm5985F5NuW7JB1ERHj4+N19HT2lPjMEBsBNIw=;
        b=hXnocFx9cevvGbDetOVPoHmFe7i/tO8xVob6PumWbFtKncji/zoOphusGc3C/eSRHs
         9sjqHo3sGJ2Z5Xgjtjc2UZkA4k/Q6AcNISmE1zctyE0C99kVBP1Ej9vMUp12aWZ84hDm
         WXdwc4REw3tuaDKJO84557Pv6+A11sqASDYBg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CaTVIGm5985F5NuW7JB1ERHj4+N19HT2lPjMEBsBNIw=;
        b=rCobonLI1m17QJuQ9cvJm4ML/WE+/dke2MzYc9zm9clfX4Dl+3ccgjv86/tf2xQR9E
         rEJhqIOPjMeUHzFfHkDtj14RlBYOIVYgEGjSLm5jtIT/jR/WRPmlP36Mf/4Tt4Ixpghf
         2RqPe8XPCkzgsh4TE6laoA/csp5s7uWh9ST2hHaW7Xvif22fvv1FYXIErkK+016WimNg
         oXpD6Tw94gak9D2vbaJ6/PGZX2S6PMlpPjh9N2rllVQCUeE281upDnQNLBDO4tTCDJFw
         yAN2O5e5ARLJ63Y93KPZZUYU+TcDAoeW3eZG9pYwUB0Nx6vYD8tC3axXgIETAgzkeTDW
         V+hA==
X-Gm-Message-State: AOAM531zusDuPjpjXOMp1T18d5Rl0ZgJgGwxTBWm/DaAt3rb6AZt4PFI
        CWk/1efZp+bbT/A2wAo1H9dh3YJ80u6Hpg==
X-Google-Smtp-Source: ABdhPJzSg7xqa1wjIk7FMOp5fpCMC0B6tVYVgltuyIqMi3xq0fXlK9pHAIxr0Y5PsWxzv12kReg5PQ==
X-Received: by 2002:a2e:3507:: with SMTP id z7mr8581115ljz.428.1612128634051;
        Sun, 31 Jan 2021 13:30:34 -0800 (PST)
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com. [209.85.167.48])
        by smtp.gmail.com with ESMTPSA id 137sm2784473lfi.77.2021.01.31.13.30.33
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 31 Jan 2021 13:30:33 -0800 (PST)
Received: by mail-lf1-f48.google.com with SMTP id q12so20066762lfo.12
        for <linux-kernel@vger.kernel.org>; Sun, 31 Jan 2021 13:30:33 -0800 (PST)
X-Received: by 2002:a05:6512:2287:: with SMTP id f7mr6731550lfu.40.1612128632766;
 Sun, 31 Jan 2021 13:30:32 -0800 (PST)
MIME-Version: 1.0
References: <CAP045AoL4=6L16Nxi4TW7Jt8dqNXBQTvZZOqBEBRRcZdHCQ_VA@mail.gmail.com>
 <CAHk-=wjqzP5UuZ4=F4ok18R5_1_vAZw9m_3G-W9Eodc1raM3TQ@mail.gmail.com> <CAP045ApxLJ7vXOVp5Cwx7WEyDr6v01D9YD3xGFDv3WAp6czaMQ@mail.gmail.com>
In-Reply-To: <CAP045ApxLJ7vXOVp5Cwx7WEyDr6v01D9YD3xGFDv3WAp6czaMQ@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 31 Jan 2021 13:30:16 -0800
X-Gmail-Original-Message-ID: <CAHk-=wgeG7WP_vxho_bfENK3rYP9zUF0_ZjA1X3OftERrs_j2w@mail.gmail.com>
Message-ID: <CAHk-=wgeG7WP_vxho_bfENK3rYP9zUF0_ZjA1X3OftERrs_j2w@mail.gmail.com>
Subject: Re: [REGRESSION] x86/entry: TIF_SINGLESTEP handling is still broken
To:     Kyle Huey <me@kylehuey.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Andy Lutomirski <luto@kernel.org>,
        Gabriel Krisman Bertazi <krisman@collabora.com>,
        open list <linux-kernel@vger.kernel.org>,
        "Robert O'Callahan" <rocallahan@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Btw Kyle, do you have a good simple test-case for this? Clearly this
is some weird special case use, and regular single-stepping works
fine.

             Linus
