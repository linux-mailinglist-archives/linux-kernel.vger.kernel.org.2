Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E503437F089
	for <lists+linux-kernel@lfdr.de>; Thu, 13 May 2021 02:39:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235483AbhEMAkv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 May 2021 20:40:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239342AbhEMAiY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 May 2021 20:38:24 -0400
Received: from angie.orcam.me.uk (angie.orcam.me.uk [IPv6:2001:4190:8020::4])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 8DBA1C061760;
        Wed, 12 May 2021 17:37:15 -0700 (PDT)
Received: by angie.orcam.me.uk (Postfix, from userid 500)
        id 7E0FB92009D; Thu, 13 May 2021 02:37:13 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by angie.orcam.me.uk (Postfix) with ESMTP id 79B8D92009B;
        Thu, 13 May 2021 02:37:13 +0200 (CEST)
Date:   Thu, 13 May 2021 02:37:13 +0200 (CEST)
From:   "Maciej W. Rozycki" <macro@orcam.me.uk>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>
cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Daniel Vetter <daniel@ffwll.ch>,
        Martin Hostettler <textshell@uchuujin.de>,
        Peilin Ye <yepeilin.cs@gmail.com>,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 0/3] VT_RESIZEX fixes
Message-ID: <alpine.DEB.2.21.2105090548170.2587@angie.orcam.me.uk>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

 I got to the bottom of the issue with VT_RESIZEX recently discussed and 
came up with this small patch series, fixing an additional issue that I 
originally thought might be broken VGA hardware emulation with my laptop, 
which however turned out to be intertwined with the original problem and 
also a regression introduced somewhat later.  This had to become 1/3 then 
and to make backporting feasible I had to put a revert of the offending 
change from last Sep next, followed by a proper fix for the framebuffer 
issue the Sep change tried to address.

 See individual change descriptions for details.

 These have been verified with true VGA hardware (a Trident TVGA8900 ISA 
video adapter) using various combinations of `svgatextmode' and `setfont' 
command invocations to change both the VT size and the font size, and also 
switching between the text console and X11, both by starting/stopping the 
X server and by switching between VTs.  All this to ensure bringing the 
behaviour of VGA text console back to correct operation as it used to be 
with Linux 2.6.18.

 A minor glitch observed was that when I called `svgatextmode' while 
running X11 the screen became garbled and upon a subsequent VT switch to a 
text console the machine locked up hard right away.  This might require 
further attention, but is not itself a problem with this patch series or a 
regression.

 Please apply then.

  Maciej
