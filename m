Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E29C411CF6
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Sep 2021 19:13:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345050AbhITRPK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Sep 2021 13:15:10 -0400
Received: from mail-ua1-f49.google.com ([209.85.222.49]:34380 "EHLO
        mail-ua1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345779AbhITRNF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Sep 2021 13:13:05 -0400
Received: by mail-ua1-f49.google.com with SMTP id 6so865601uac.1
        for <linux-kernel@vger.kernel.org>; Mon, 20 Sep 2021 10:11:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=i9wjl3VW7I76KDvYCT3HzL0qO3/KX+BihrPKQ7omPYY=;
        b=Hv+cOcB6eOGllYT1Z1h+da/VF49bnErCZMoq1U1tlSi7yDZD+IM4mgNZyHVqIZE03H
         vJYiqMZ9RRprRZ/Hg69pBaaxa1GmhDSXtjyuJMorMomTOKKY1U94eaa6/xnghN6FRbff
         fxNQuqT1Kh0QSfQQbQnNBtVc5hDxqMGaZk/SLjZO8fznHvbYb6DexAWXruvb3Dt83xQZ
         6CfDwcwFlDQqhQkHH7iskz8Ux2gHCT3hKATGtP/kIBZjAJKgCYQlFpi49Reb4MVCDUMU
         McG9MaPi6TT9hCbR8ghiUw5yZoR+8Iech4Et1JtiHlmyGcReLRyb0O+mc0/iiAVHgtnR
         aSXQ==
X-Gm-Message-State: AOAM531VNziurUn7qvzLxYI93yyIRtU2KNrWueQDiiT5Cc0H6poHYD1O
        n1SstWvYOrRxykxTJyqE4D264DnooK0UDuXGqS/2VacsohY=
X-Google-Smtp-Source: ABdhPJxx16fBt/8fMvA5rPzV3VejL+j6VTqCq+jaPvhscrlPxci3ZuQtiJiDqSWvN/jJ/G2jOBqAKLCW50s0vrqauKY=
X-Received: by 2002:ab0:6ec9:: with SMTP id c9mr14237488uav.114.1632157897537;
 Mon, 20 Sep 2021 10:11:37 -0700 (PDT)
MIME-Version: 1.0
References: <44ee2bfe-e4bc-b918-b908-7352ea012524@oxidecomputer.com>
 <dfa20866-0d00-9bd3-6078-5544cfa5b633@sr71.net> <CAMuHMdUUfm6u_Pz3qzA0V7tLZd7jhcwdyxU7L0SyC_EdyzwQxw@mail.gmail.com>
 <CAMuHMdVtHDQ2f0VKAdQFQV9dZJ5uFGD9yHvNviQ_k7AEfhN77w@mail.gmail.com>
 <bf22702e-01b2-214a-1650-da9e4ec3c2be@labbott.name> <20210920162329.GJ4192@sirena.org.uk>
 <5c88ae67-df7b-60ab-d087-bd244753c98f@labbott.name> <20210920164837.GK4192@sirena.org.uk>
 <ebcaac1d-9b97-81d9-28eb-eeb51c51673f@labbott.name> <20210920165716.GL4192@sirena.org.uk>
In-Reply-To: <20210920165716.GL4192@sirena.org.uk>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 20 Sep 2021 19:11:26 +0200
Message-ID: <CAMuHMdVOEDLPRNi7YEV0foz5CRTq_7BHKiQCQY2JjkH7-=ZE9Q@mail.gmail.com>
Subject: Re: [Tech-board-discuss] IMPORTANT: CIVS opt-in for Technical
 Advisory Board voting
To:     Mark Brown <broonie@kernel.org>
Cc:     Laura Abbott <laura@labbott.name>, Dave Hansen <dave@sr71.net>,
        "tab-elections@lists.linuxfoundation.org" 
        <tab-elections@lists.linuxfoundation.org>, ksummit@lists.linux.dev,
        "tech-board-discuss@lists.linuxfoundation.org" 
        <tech-board-discuss@lists.linuxfoundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mark,

On Mon, Sep 20, 2021 at 6:58 PM Mark Brown <broonie@kernel.org> wrote:
> On Mon, Sep 20, 2021 at 12:53:48PM -0400, Laura Abbott wrote:
> > On 9/20/21 12:48, Mark Brown wrote:
> > > How can I do this?  As (IIRC) Geert reported if you've activated your
> > > mail then attempting to activate again causes CIVS to report "This email
> > > address is already activated" with no link to any existing polls.
>
> > CIVS said it should give a list of all polls but perhaps that didn't
> > happen. I'll see if I can get it to resend.
>
> It gives a list of all polls on activation but it seems like it doesn't
> get that far on reactivations, it looks like it's generating an error
> refusing to activate again before it gets that far.

Do you get the list when following the configuration URL at the
bottom of the activation code email?

BTW, just got an email "Poll: Linux Foundation Technical Advisory
Board Elections 2021". But I've already voted before ;-)


Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
