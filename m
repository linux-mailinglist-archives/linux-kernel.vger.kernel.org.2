Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 57292400C81
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Sep 2021 20:21:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237363AbhIDSWl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Sep 2021 14:22:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234085AbhIDSWh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Sep 2021 14:22:37 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD3B5C061575
        for <linux-kernel@vger.kernel.org>; Sat,  4 Sep 2021 11:21:35 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id k13so4990060lfv.2
        for <linux-kernel@vger.kernel.org>; Sat, 04 Sep 2021 11:21:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=OYVoNaiPiFMT3Pif6m6N9zlRXVSGL7jm7maPDpwjqxY=;
        b=Ang18iGIJIGHSbErxXNfo9uvDRcm4O0krZ8gfLCcNAEyJblRQ0e5scvxzF/jxu6Qz3
         ZPM1IWvrnHSBlRK+h5Zsuu7fdIM2Wr6enj7GArXXczrQU6l4yuze4yRPze9aeCVA32sP
         Vonv/bMqSwUd80MBhFQyu27ChN48Z0FV3U430=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OYVoNaiPiFMT3Pif6m6N9zlRXVSGL7jm7maPDpwjqxY=;
        b=t1WRICMVHr367LLapKvVRl3oWI6wKnenoFXbiI1yt9uvB8RjhO9xeZc48VJurkhKNG
         PbEVuNJRGYpCpnfz7l8jSRix0n/gh8n+P7HQuymd52irWxZBZuBviqDr+LutDf7JwWEZ
         6QZ/Unaz7er+7qRK/CNoe4ZOlpNc8Bx5ihdNDbsZz1gsw+4qnwzcCmf1sm8bRU3u9G7C
         d1SDctECoxl7GS5+fgNbmdZ1mLDP0xBui07MqcjSWLJhFXJed3K5nCD2I4jQFO5CkGW+
         1mwIS9ojUxeuxb7Imk1C45aoiHWUjxBukrCkjNX1BLb2RM7wA7VrexGHOkAMJvvwoW9c
         i7Dg==
X-Gm-Message-State: AOAM533LJKFOQulhSKwfkVoU8HM5pgRg7Q/LQMCwwxYjveGROs2n4ciM
        RO8oVhbnffBBms/ilxmjzCIbuaQeXAxrCH1u
X-Google-Smtp-Source: ABdhPJyy7u4r1IvBaZrBaXEeI6V9djKmmqzyFn8k3Q6Um/FhkDOpF6z3s9/GntgyauYUrVM+NATtoQ==
X-Received: by 2002:ac2:558e:: with SMTP id v14mr3837387lfg.424.1630779693923;
        Sat, 04 Sep 2021 11:21:33 -0700 (PDT)
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com. [209.85.167.48])
        by smtp.gmail.com with ESMTPSA id 4sm340029ljq.99.2021.09.04.11.21.33
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 04 Sep 2021 11:21:33 -0700 (PDT)
Received: by mail-lf1-f48.google.com with SMTP id s10so4933259lfr.11
        for <linux-kernel@vger.kernel.org>; Sat, 04 Sep 2021 11:21:33 -0700 (PDT)
X-Received: by 2002:a05:6512:114c:: with SMTP id m12mr3748805lfg.150.1630779693120;
 Sat, 04 Sep 2021 11:21:33 -0700 (PDT)
MIME-Version: 1.0
References: <YTOF8VYTYNFYpB7O@zeniv-ca.linux.org.uk> <CAHk-=whho2pj4Au+rVpTGkoj7nJCEJwSfikLQVHDZ8kbKG7U1w@mail.gmail.com>
 <CAHk-=whx9iKutjLY6iRBHg2TTzSDXgrZ0-Uj5sUqhyQZZQ_yRQ@mail.gmail.com> <YTO2yrr3z45XtGWt@zeniv-ca.linux.org.uk>
In-Reply-To: <YTO2yrr3z45XtGWt@zeniv-ca.linux.org.uk>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sat, 4 Sep 2021 11:21:17 -0700
X-Gmail-Original-Message-ID: <CAHk-=wg2MC-MOmWa5wy-djNm+FCj6s4484UFncprHZ=--ZGVpg@mail.gmail.com>
Message-ID: <CAHk-=wg2MC-MOmWa5wy-djNm+FCj6s4484UFncprHZ=--ZGVpg@mail.gmail.com>
Subject: Re: [possible bug] missed wakeup in do_sigtimedwait()?
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 4, 2021 at 11:13 AM Al Viro <viro@zeniv.linux.org.uk> wrote:
>
> Thanks.  AFAICS, it's this logics in __schedule():
>                 if (signal_pending_state(prev_state, prev)) {
>                         WRITE_ONCE(prev->__state, TASK_RUNNING);

Exactly. As you note, it also handles the WAKEKILL case which is
basically equivalent (just for the "I can't take normal signals, but
I'm ok dying" case)

            Linus
