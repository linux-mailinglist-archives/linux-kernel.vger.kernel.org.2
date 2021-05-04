Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF3E8372D30
	for <lists+linux-kernel@lfdr.de>; Tue,  4 May 2021 17:43:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231432AbhEDPoa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 May 2021 11:44:30 -0400
Received: from jabberwock.ucw.cz ([46.255.230.98]:49094 "EHLO
        jabberwock.ucw.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230256AbhEDPo2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 May 2021 11:44:28 -0400
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id 827341C0B87; Tue,  4 May 2021 17:43:32 +0200 (CEST)
Date:   Tue, 4 May 2021 17:43:31 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     kernel list <linux-kernel@vger.kernel.org>,
        Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        Linux LED Subsystem <linux-leds@vger.kernel.org>
Subject: Re: [GIT PULL] LEDs changes for v5.13-rc1
Message-ID: <YJFro4ue80SIboQd@mobian>
References: <20210502220519.GA24775@duo.ucw.cz>
 <CAHk-=wg0Cvmxk58f0waakTKo8G5wPWarVw5b2=11f35vBAOYUw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wg0Cvmxk58f0waakTKo8G5wPWarVw5b2=11f35vBAOYUw@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > This modifies MAINTAINER's file to remove Dan Murphy's email that is
> > bouncing (and does it globally). I hope that does not conflict too badly.
> 
> Well, it caused conflicts, but it's not like they were hard to resolve.
> 
> In fact, the resolution was to ignore your changes, because those
> email addresses had been removed by the other branches I already
> merged, so they were gone even before your merge (and the conflicts
> were just due to other changes around it)

Oops, sounds like I should have test-merged it and dropped the
change. Thanks for solving it for me.

Best regards,
									Pavel

-- 
