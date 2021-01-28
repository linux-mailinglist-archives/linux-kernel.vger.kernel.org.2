Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E613307F52
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jan 2021 21:16:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230526AbhA1UQf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jan 2021 15:16:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229786AbhA1UQ0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jan 2021 15:16:26 -0500
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5F1DC0613D6
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jan 2021 12:15:45 -0800 (PST)
Received: by mail-ej1-x632.google.com with SMTP id rv9so9628417ejb.13
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jan 2021 12:15:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kylehuey.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8KYRxCq+VijaHyGm3nspszs6+isH7KSG4Ik6j3Av93c=;
        b=B58P+9oOAaIsSpBC4lg74dzWJKJ3ybSV89M2L0Mp9OjaJ3bTLg3t6Az7ItGGNz0wFz
         lBdFpDS2UvNVVdTxyUf55Gm1rnuSCuf2KHNBzO34+YUYI6z8pl4eqTYZMGNIdObs1G0R
         9hgnwmYVSGshMAzPNxInKmudVEP5kdMlo059wq7Gs3y+BxnRP1JioJbuUjTatu/PGO0D
         5w+8ImILu00Uc1gM/mmV863bVzkc0JTXRr/SNyHFkgxhQCNf/U2iGonexjT37/G1SZJy
         15kYwJbkM+GXn6OeO87JLuJuG0xuw5E/tZnkqsJQxWZ2wLK3p/bTqg0R6EDQr6rlAOiH
         LDhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8KYRxCq+VijaHyGm3nspszs6+isH7KSG4Ik6j3Av93c=;
        b=ZAaX322me3k+QMMO9BYZiwp/1lzc1uJRpuNDnh5E01vR3C67x9fpkTKygWLk6UQciy
         3M7+VfYNSPGf3YR5lyq1N1EFq6W4Hl4n4Q4l2DHH5TUvI6oQgl3tRsKpSHA1xY5n+k//
         lgJmtriN8zWB375sLs/ckPzESy5V7aIYCeeL0mSmdtOkpqdhrX/JFviXfDQrMb032mEr
         64RxdOykCooROpnkB8hiEgYU/MkGzmkdvRTpdfoEW1myqjiqwLDZCP4ctQRnzSkxwaFe
         jzrMabBMq+murzHnCQ7iAv/tmCe/PFOUT4o7jUO+cBz7Bmp5QqdfEiZlq6+r563zmIX0
         +qEQ==
X-Gm-Message-State: AOAM531cHdadVm8RyULNfRPBnuyb1Sg0MVQz/02xTQzq5SoEVkJEVlEM
        sLD9E9bSfRuLJMlPDWKrf1OZtQv+DgXKxo5j3nRTEg==
X-Google-Smtp-Source: ABdhPJzrAjJJP8ciZP1YuWUVcouJS1kYbZeC3mzFP3+/fTGLdsLLmBkGaDddFt2JuDlToQ2cA6VFjKPoHC8UKp4Pefk=
X-Received: by 2002:a17:906:9342:: with SMTP id p2mr1214159ejw.300.1611864944451;
 Thu, 28 Jan 2021 12:15:44 -0800 (PST)
MIME-Version: 1.0
References: <CAP045Arw973KWCiHqXmRJ3QxH8o84on-t8Nm6NyEYXDpicF7JA@mail.gmail.com>
 <CAHk-=wiVj-0zV8ePHZ2rGFErJAYkRb3FZ8K9aYus6is0bALL5A@mail.gmail.com>
In-Reply-To: <CAHk-=wiVj-0zV8ePHZ2rGFErJAYkRb3FZ8K9aYus6is0bALL5A@mail.gmail.com>
From:   Kyle Huey <me@kylehuey.com>
Date:   Thu, 28 Jan 2021 12:15:32 -0800
Message-ID: <CAP045ApuTzezCto0sqqeyPsgXOtrY9pgWvVk2k4ptmcDjYL=jA@mail.gmail.com>
Subject: Re: [PATCH] ptrace: restore the previous single step reporting behavior
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Andy Lutomirski <luto@kernel.org>, kernel@collabora.com,
        Gabriel Krisman Bertazi <krisman@collabora.com>,
        linux-arch <linux-arch@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        yshuiv7@gmail.com, "Robert O'Callahan" <rocallahan@gmail.com>,
        "the arch/x86 maintainers" <x86@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 28, 2021 at 11:10 AM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
> You should have pointed to the actual patch.

Sorry, I broke the reply threading in my mail client.

- Kyle
