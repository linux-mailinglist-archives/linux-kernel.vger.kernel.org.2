Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DBD703C2ACE
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jul 2021 23:29:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230506AbhGIVbj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jul 2021 17:31:39 -0400
Received: from h2.fbrelay.privateemail.com ([131.153.2.43]:38932 "EHLO
        h2.fbrelay.privateemail.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229792AbhGIVbi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jul 2021 17:31:38 -0400
Received: from MTA-11-3.privateemail.com (mta-11-1.privateemail.com [198.54.118.201])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by h1.fbrelay.privateemail.com (Postfix) with ESMTPS id AC76E80B6B;
        Fri,  9 Jul 2021 17:28:52 -0400 (EDT)
Received: from mta-11.privateemail.com (localhost [127.0.0.1])
        by mta-11.privateemail.com (Postfix) with ESMTP id 5450D18000A9;
        Fri,  9 Jul 2021 17:28:51 -0400 (EDT)
Received: from [192.168.0.46] (unknown [10.20.151.249])
        by mta-11.privateemail.com (Postfix) with ESMTPA id 906FD18000A5;
        Fri,  9 Jul 2021 17:28:48 -0400 (EDT)
Date:   Fri, 09 Jul 2021 17:28:42 -0400
From:   Hamza Mahfooz <someguy@effective-light.com>
Subject: Re: [PATCH] fbcon: garbage collect fbdev scrolling acceleration
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Peilin Ye <yepeilin.cs@gmail.com>,
        Jing Xiangfeng <jingxiangfeng@huawei.com>,
        George Kennedy <george.kennedy@oracle.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        Linux Fbdev development list <linux-fbdev@vger.kernel.org>,
        Pavel Machek <pavel@ucw.cz>
Message-Id: <UBYZVQ.O83H1QJFD7TX@effective-light.com>
In-Reply-To: <CAMuHMdWhs4en-yR9ic+d4V9M_0BUFX40rP0M=tZRGMaUy2wv3g@mail.gmail.com>
References: <20210709010055.86663-1-someguy@effective-light.com>
        <CAMuHMdWhs4en-yR9ic+d4V9M_0BUFX40rP0M=tZRGMaUy2wv3g@mail.gmail.com>
X-Mailer: geary/40.0
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
X-Virus-Scanned: ClamAV using ClamSMTP
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, Jul 9 2021 at 09:49:02 AM +0200, Geert Uytterhoeven 
<geert@linux-m68k.org> wrote:
> Bummer, more code to revert to re-enable acceleration in the _56_
> fbdev drivers using acceleration (some of them unusable without),
> despite commit 39aead8373b3 claiming "No other driver supportes
> accelerated fbcon"...
Should they be refactored to DRM drivers? (I don't mind looking into it 
if you believe it's worthwhile.)


