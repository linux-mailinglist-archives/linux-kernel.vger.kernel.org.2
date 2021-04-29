Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E320836F0C1
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Apr 2021 22:03:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237065AbhD2UB4 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 29 Apr 2021 16:01:56 -0400
Received: from jabberwock.ucw.cz ([46.255.230.98]:51684 "EHLO
        jabberwock.ucw.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236978AbhD2T7c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Apr 2021 15:59:32 -0400
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id C43DD1C0BA2; Thu, 29 Apr 2021 21:58:44 +0200 (CEST)
Date:   Thu, 29 Apr 2021 21:58:43 +0200
From:   Pavel Machek <pavel@denx.de>
To:     Daniel Vetter <daniel@ffwll.ch>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ben Skeggs <bskeggs@redhat.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        intel-gfx <intel-gfx@lists.freedesktop.org>,
        "Anholt, Eric" <eric@anholt.net>,
        "airlied@gmail.com" <airlied@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Aditya Pakki <pakki001@umn.edu>, Kangjie Lu <kjlu@umn.edu>,
        David Airlie <airlied@linux.ie>,
        Linus Walleij <linus.walleij@linaro.org>,
        Jean Delvare <jdelvare@suse.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Subject: Re: [PATCH 000/190] Revertion of all of the umn.edu commits
Message-ID: <20210429195843.GA1067@bug>
References: <20210421130105.1226686-1-gregkh@linuxfoundation.org>
 <CAKMK7uFONR-12CZEGJLrjgS0N-kF_v7_cXJEiSBPFoBbyRHn0w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <CAKMK7uFONR-12CZEGJLrjgS0N-kF_v7_cXJEiSBPFoBbyRHn0w@mail.gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> >   Revert "drm/radeon: Fix reference count leaks caused by
> >     pm_runtime_get_sync"
> >   Revert "drm/radeon: fix multiple reference count leak"
> >   Revert "drm/amdkfd: Fix reference count leaks."
> 
> I didn't review these carefully, but from a quick look they all seem
> rather inconsequental. Either error paths that are very unlikely, or
> drivers which are very dead (looking at the entire list, not just what
> you reverted here).
> 
> Acked-by: Daniel Vetter <daniel.vetter@ffwll.ch>

So you are knowingly acking patch re-introducing bugs into kernel, because 
the bugs are minor? I don't believe that's an okay thing to do.

Maybe something needs reverting, but lets not introduce bugs into kernel because they are
"minor".

Best regards,
									Pavel

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
