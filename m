Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E30503AE2CD
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jun 2021 07:36:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229661AbhFUFiS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Jun 2021 01:38:18 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:30901 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229479AbhFUFiQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jun 2021 01:38:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1624253761;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=RY9DMg40/fTZjgZ6Fij6lpyg1UQhKJ1773t8fOZ+VDA=;
        b=iNVen4KR3MKrjcofAnkndEAHOvskE0h7ha9IsSdVkB0uZBFmLeBoLUIS2dLHjPB6MZM8+S
        Nf5xTyTKTNLs80C8s3wL72j4S55H9tZbjKeSW8xk4oF/K/7jpcMaxzbzyiokDuknoKPblE
        8ikMatEZvlSb9n4uMTx/jYhfBTHwON0=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-540-sJa_fmIxMFK4b3B2TYbY5Q-1; Mon, 21 Jun 2021 01:35:59 -0400
X-MC-Unique: sJa_fmIxMFK4b3B2TYbY5Q-1
Received: by mail-wr1-f69.google.com with SMTP id l2-20020adfe5820000b029011a64161d6aso8017924wrm.6
        for <linux-kernel@vger.kernel.org>; Sun, 20 Jun 2021 22:35:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=RY9DMg40/fTZjgZ6Fij6lpyg1UQhKJ1773t8fOZ+VDA=;
        b=CIlzwcSzlP3dlDXPaQ5/b7lLG1T6XMax6Pnqglh5vvB1vFoUotvo0cND0kej5R5xTe
         yjfBG/Z3hXm50lGuH8kKgFFRM68qNC/rfxTb5KgcYEBYklsGA/lQ7OwNaULkRH7YgVmt
         5bIXE/A11LnMnM6b9W2NdfOCoMS1HoYWP0sp6DxGd0Pa3BDSCARjoLkl2zzV7Sv/ab6D
         wQ0zaTWVAwrap9AZFwKtvF6Ys5hRI5GF03dUD+YMI2kRCq+U26xYVwvnoF4Hgrad5xfk
         eGH+BZ9NyqvBQZHdDZ9z8hGbbVE1/Kbg22ox1pPYSWT3lbA4Sw+c60vEpM68GyVHW0vk
         Wmcw==
X-Gm-Message-State: AOAM532vA4ZHyLu5kIiDi0XGGlckJ7iO8T8MxyWvlDpOdo7AVtK2gMan
        t6zNwiqMGYdlSheb/YupW79V96aQq3fQXKCGnsu//0DiyAkN+Mu3q85/y/HsEwr4x5KPsJLWp6f
        EXmRTzzRLR6t8dtFWfA6EnViD
X-Received: by 2002:a5d:6583:: with SMTP id q3mr11825345wru.360.1624253758476;
        Sun, 20 Jun 2021 22:35:58 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzNVzD02BSHJ5YfAF1/SPXAwkkudd9JO9SOY1nKn8HyLYLX4v9IpbakIlVA1prWMh7+0Pf55Q==
X-Received: by 2002:a5d:6583:: with SMTP id q3mr11825334wru.360.1624253758292;
        Sun, 20 Jun 2021 22:35:58 -0700 (PDT)
Received: from localhost.localdomain ([151.29.58.33])
        by smtp.gmail.com with ESMTPSA id f19sm16229383wre.48.2021.06.20.22.35.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Jun 2021 22:35:57 -0700 (PDT)
Date:   Mon, 21 Jun 2021 07:35:55 +0200
From:   Juri Lelli <juri.lelli@redhat.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     bigeasy@linutronix.de, linux-rt-users@vger.kernel.org,
        peterz@infradead.org, linux-kernel@vger.kernel.org,
        bristot@redhat.com, Anna-Maria Behnsen <anna-maria@linutronix.de>
Subject: Re: [RFC PATCH RT v2 1/2] time/hrtimer: Add PINNED_HARD mode for
 realtime hrtimers
Message-ID: <YNAlO4CScpaj65HG@localhost.localdomain>
References: <20210616071705.166658-1-juri.lelli@redhat.com>
 <20210616071705.166658-2-juri.lelli@redhat.com>
 <87k0mqeofg.ffs@nanos.tec.linutronix.de>
 <87bl82e19d.ffs@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87bl82e19d.ffs@nanos.tec.linutronix.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 19/06/21 09:56, Thomas Gleixner wrote:
> On Sat, Jun 19 2021 at 01:35, Thomas Gleixner wrote:
> > The wild west of anything which scratches 'my itch' based on 'my use
> > case numbers' in Linux ended many years ago and while RT was always a
> > valuable playground for unthinkable ideas we definitely tried hard not
> > to accept use case specific hacks wihtout a proper justification that it
> > makes sense in general.
> >
> > So why are you even trying to sell this to me?
> 
> I wouldn't have been that grumpy if you'd at least checked whether the
> task is pinned. Still I would have told you that you "fix" it at the
> wrong place.

Ah, indeed. Pulled the trigger too early it seems. I'll ponder more.

> Why on earth is that nohz heuristic trainwreck not even checking that?
> It's not a RT problem and it's not a problem restricted to RT tasks
> either. If a task is pinned then arming the timer on a random other CPU
> is blatant nonsense independent of the scheduling class.

Agree. Lemme look more into it.

Thanks for the comments!

Best,
Juri

