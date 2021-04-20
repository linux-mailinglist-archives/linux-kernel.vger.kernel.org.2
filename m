Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D8FA365EAD
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Apr 2021 19:34:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233352AbhDTReq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Apr 2021 13:34:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232913AbhDTRep (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Apr 2021 13:34:45 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 658CAC06174A
        for <linux-kernel@vger.kernel.org>; Tue, 20 Apr 2021 10:34:13 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id d27so5849633lfv.9
        for <linux-kernel@vger.kernel.org>; Tue, 20 Apr 2021 10:34:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=uM3oKrFolkHhfKMBW4x9Y9WVeNa3u7FgDSkg2cxr0ck=;
        b=M8aXFP35uK44/1z3q9Pty+eFhAK40fEVO/ejJbUeAVk1do4zhUh7mMSe0GzuW6p0M5
         SdoTJAcwUH63ljVRjl8KZXgsaPVJVJ0ViZFJKxOo6VlC9RzyEk6n7z1hPfqnjp/FXlzh
         ukEXTFv+VS6kPazjRyDcyp/N1NZOl9cEdT7vo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uM3oKrFolkHhfKMBW4x9Y9WVeNa3u7FgDSkg2cxr0ck=;
        b=Yx/n82iTDbkyh+CJ8gaVvAI/RWGaWO9d6mjoESysllnd7Jmol5I3fG8pb7Mufl8Byb
         AohDH97d46ubKHT4VESH+RGo2Ln+aAv9imO+15irT5+yVyjPHkuZjV3bQ//hDrS2BbEl
         7qqaccQ9i1wLbQVmKIZ5SuEbtrkNlicoY0gfI8qQW+PH5Em9XgDpR6ZIdX7qgrDpLxOg
         fr7PkCArvXtVh9bFzRyCwXLk4abJClQlrZr44NrYYxnMtuBVcrc4mMNXnsg1Rsr0Tm2P
         UZw0FTW+v8qzY71sdW3gO5HYb07vFJhZrh6pgtawR4XJzY3DhgnLcueeJhBa1+TQymmQ
         4iOg==
X-Gm-Message-State: AOAM533BfNuxv6GFfIT3FMgMS5b/W+gofSeaCJ0T/grof50fexz+vycr
        0ap9Rkf7KhqOqePT22SbPQ5+j9wKPYw7E+I4
X-Google-Smtp-Source: ABdhPJy9SPtyMOcfurah75cYaB2JMCFYCCrIDp85NEH6sVpn1/4dl/ek8RaLPecXpjiAqMC+MStxQA==
X-Received: by 2002:ac2:47ee:: with SMTP id b14mr9554688lfp.409.1618940051566;
        Tue, 20 Apr 2021 10:34:11 -0700 (PDT)
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com. [209.85.208.175])
        by smtp.gmail.com with ESMTPSA id l24sm1885986lfc.23.2021.04.20.10.34.10
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Apr 2021 10:34:10 -0700 (PDT)
Received: by mail-lj1-f175.google.com with SMTP id b38so3352708ljf.5
        for <linux-kernel@vger.kernel.org>; Tue, 20 Apr 2021 10:34:10 -0700 (PDT)
X-Received: by 2002:a2e:b6c6:: with SMTP id m6mr15361256ljo.411.1618940050087;
 Tue, 20 Apr 2021 10:34:10 -0700 (PDT)
MIME-Version: 1.0
References: <20210416045851.GA13811@mail.hallyn.com> <20210416150501.zam55gschpn2w56i@wittgenstein>
 <20210416213453.GA29094@mail.hallyn.com> <20210417021945.GA687@mail.hallyn.com>
 <20210417200434.GA17430@mail.hallyn.com> <20210419122514.GA20598@mail.hallyn.com>
 <20210419160911.5pguvpj7kfuj6rnr@wittgenstein> <20210420034208.GA2830@mail.hallyn.com>
 <20210420083129.exyn7ptahx2fg72e@wittgenstein> <20210420134334.GA11582@mail.hallyn.com>
 <20210420164707.lzrpynsii3kqe2tm@wittgenstein>
In-Reply-To: <20210420164707.lzrpynsii3kqe2tm@wittgenstein>
From:   Linus Torvalds <torvalds@linuxfoundation.org>
Date:   Tue, 20 Apr 2021 10:33:54 -0700
X-Gmail-Original-Message-ID: <CAHk-=wj3M87k8QKb5jn+SxK8u74_aEEE7ZsuvVY84usCAJEWrA@mail.gmail.com>
Message-ID: <CAHk-=wj3M87k8QKb5jn+SxK8u74_aEEE7ZsuvVY84usCAJEWrA@mail.gmail.com>
Subject: Re: [PATCH v3.4] capabilities: require CAP_SETFCAP to map uid 0
To:     Christian Brauner <christian.brauner@ubuntu.com>
Cc:     "Serge E. Hallyn" <serge@hallyn.com>,
        lkml <linux-kernel@vger.kernel.org>,
        Kees Cook <keescook@chromium.org>,
        "Andrew G. Morgan" <morgan@kernel.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Security Officers <security@kernel.org>,
        Tycho Andersen <tycho@tycho.ws>,
        Andy Lutomirski <luto@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 20, 2021 at 9:47 AM Christian Brauner
<christian.brauner@ubuntu.com> wrote:
>
> If there's no objections then Linus can probably just pick up the single
> patch here directly:

I'm ok with that assuming I don't hear any last-minute concerns..

I'll plan on appling it later today, so anybody with concerns please
holler quickly.

I don't want to leave it to much later in the week, and I may or may
not be functional tomorrow (getting my second vaccine shot, some
people react more strongly to it, so I'm leaving the possibility open
of not getting out of bed ;)

             Linus
