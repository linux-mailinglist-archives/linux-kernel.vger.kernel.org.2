Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 11605326FBB
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Feb 2021 01:20:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230175AbhB1AUZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 27 Feb 2021 19:20:25 -0500
Received: from kvm5.telegraphics.com.au ([98.124.60.144]:59690 "EHLO
        kvm5.telegraphics.com.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230010AbhB1AUW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Feb 2021 19:20:22 -0500
Received: from localhost (localhost.localdomain [127.0.0.1])
        by kvm5.telegraphics.com.au (Postfix) with ESMTP id 96D2A23F62;
        Sat, 27 Feb 2021 19:19:35 -0500 (EST)
Date:   Sun, 28 Feb 2021 11:19:31 +1100 (AEDT)
From:   Finn Thain <fthain@telegraphics.com.au>
To:     Jens Axboe <axboe@kernel.dk>
cc:     "David S. Miller" <davem@davemloft.net>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Michael Schmitz <schmitzmic@gmail.com>,
        linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH RESEND] ide/falconide: Fix module unload
In-Reply-To: <5d7fd7bb-1bb8-a21c-61d8-4d1046f92ca8@kernel.dk>
Message-ID: <d92db64-cfb8-9640-35a4-4f864dfc99a2@telegraphics.com.au>
References: <63369c9b96673442a4bd653fe92acda99172123a.1605847196.git.fthain@telegraphics.com.au> <alpine.LNX.2.23.453.2101031017290.12@nippy.intranet> <5d7fd7bb-1bb8-a21c-61d8-4d1046f92ca8@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 3 Jan 2021, Jens Axboe wrote:

> > 
> > This patch was sent in September and subsequently resent in November. 
> > I've since learned that the maintainer has been ill. What's the best 
> > way forward for fixes like this?
> 
> I can queue it up.
> 

That would be great.
