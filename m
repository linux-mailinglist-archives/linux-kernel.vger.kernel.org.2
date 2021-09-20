Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 83D53411897
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Sep 2021 17:48:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237875AbhITPtr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Sep 2021 11:49:47 -0400
Received: from mail-vs1-f51.google.com ([209.85.217.51]:35745 "EHLO
        mail-vs1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231216AbhITPtq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Sep 2021 11:49:46 -0400
Received: by mail-vs1-f51.google.com with SMTP id f18so17129834vsp.2
        for <linux-kernel@vger.kernel.org>; Mon, 20 Sep 2021 08:48:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4XIrinN7AxFNslMU/oL1dAz4eVX1XxUFtIGJluVZ79A=;
        b=fMZHLgZnYqfCNVKBXpUPz0vVlIpHdBG1NDHUmvWf6jorzDrdFCCXNNU0EZEgmQOdT6
         eCPcAAnpsgLQh2wTmKJVkUFS9Ro61Et/hc6bO1+b1ZRLU6zxIBlqZVfpn0Gx/JB8WFoV
         8ggW4W5kK5x9IoTSiOGklDzMNPFkzV1jO58VKLGjN2JSmRGYFzQNDa1ylnM+C5si6OWp
         /K0G+iWEBYov6KZBlDRRHcV6vxRx1cFT5cMlTDmenQ+cmETsYxKZZv3QqCqx60HJqtN7
         4xccFwFNsi1NXFyCxpE7ssHhMW6JgOx8na0eSPgBrrmI+2gzm+2mOseN4eVM9+pKwY0V
         lthg==
X-Gm-Message-State: AOAM530u3sz7iNORR7yCDpGdp4/fxr2Z9VngCgnIJuCDIQ2ZKLGXcXvD
        6kB55lbB/7dh33gIVH4b8vcpYJf7Vboq8aXIbtw=
X-Google-Smtp-Source: ABdhPJxjZKoTyAkMmmNlQd+SNmg4qFylQBCJHa8rcDR2Qu/ASVHuJgmD1OIQrevb6XFIQfkZEifsvrqMyWyq2m7atlM=
X-Received: by 2002:a05:6102:2417:: with SMTP id j23mr16612983vsi.35.1632152899468;
 Mon, 20 Sep 2021 08:48:19 -0700 (PDT)
MIME-Version: 1.0
References: <44ee2bfe-e4bc-b918-b908-7352ea012524@oxidecomputer.com> <dfa20866-0d00-9bd3-6078-5544cfa5b633@sr71.net>
In-Reply-To: <dfa20866-0d00-9bd3-6078-5544cfa5b633@sr71.net>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 20 Sep 2021 17:48:08 +0200
Message-ID: <CAMuHMdUUfm6u_Pz3qzA0V7tLZd7jhcwdyxU7L0SyC_EdyzwQxw@mail.gmail.com>
Subject: Re: IMPORTANT: CIVS opt-in for Technical Advisory Board voting
To:     Dave Hansen <dave@sr71.net>
Cc:     Laura Abbott <laura@oxidecomputer.com>, ksummit@lists.linux.dev,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "tech-board-discuss@lists.linuxfoundation.org" 
        <tech-board-discuss@lists.linuxfoundation.org>,
        "tab-elections@lists.linuxfoundation.org" 
        <tab-elections@lists.linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 20, 2021 at 5:37 PM Dave Hansen <dave@sr71.net> wrote:
> My @linux.intel.com account is the most common one from the git logs.  I
> have only received one TAB-related email there:
>
>         Subject: Upcoming Technical Advisory Board election -- look for
>                  your ballot
>
> However, I never actually received a ballot at that email, presumably
> because of this CIVS opt-in issue.
>
> Was this just me?  Or would it be appropriate to send these opt-in
> instructions to all of those that should have received a ballot instead
> of just sending to the mailing lists?

I did the CIVS opt-in, and entered the confirmation number.
Still, unlike Vlastimil, I saw no way to vote?
Just retried the opt-in, "already opted-in".

Gr{oetje,eeting}s,

                        Geert


--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
