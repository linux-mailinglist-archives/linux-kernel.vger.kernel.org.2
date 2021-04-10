Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9034435ABF4
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Apr 2021 10:41:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234238AbhDJIlv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Apr 2021 04:41:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:59070 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233606AbhDJIlu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Apr 2021 04:41:50 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9746661184;
        Sat, 10 Apr 2021 08:41:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1618044096;
        bh=89sN6PMXx2TMCv8HF7o7UTNzKaWHKjT2V/j8/AnQ4YA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Uo+9ihhfOZ9HbZBGTjgLFFHrtZv/1PQWez1CISbSevSdEnUnY2J09SVrSxkATeD5W
         lSuLI1BPUDVQtu1OQngMCDBHhDRRzZH+UWSb8IyraN3qx+Xcy4LuEoQORjaE2kFTlC
         YDPTSim1z0q9qt8dpwBVAKSWouSj2cjkC7ggs3GM=
Date:   Sat, 10 Apr 2021 10:41:33 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Hillf Danton <hdanton@sina.com>
Cc:     Jiri Slaby <jirislaby@kernel.org>, linux-kernel@vger.kernel.org,
        Dmitry Vyukov <dvyukov@google.com>,
        Hao Sun <sunhao.th@gmail.com>
Subject: Re: [PATCH] tty: n_gsm: check error while registering tty devices
Message-ID: <YHFkvRSF3pYdmVB/@kroah.com>
References: <20210407021622.1417-1-hdanton@sina.com>
 <20210407082130.1586-1-hdanton@sina.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210407082130.1586-1-hdanton@sina.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 07, 2021 at 04:21:30PM +0800, Hillf Danton wrote:
> On Wed, 7 Apr 2021 07:37:53 Jiri Slaby wrote:
> >
> >Yes, the fix makes sense.
> 
> Thanks for taking a look.
> 
> >But could you elaborate in the commit log when this happens?
> >I only wonder how real this is. I assume you inject faults to allocations?
> 
> After looking at Hao's report [1] again, I think you are right as it was
> reported by syzbot too. Can you share the info you know about the syzbot
> report, Hao, something like the line below with the Reported-by prefix?
> 
> (This is just an example     Reported-by: syzbot+b804f902bbb6bcf290cb@syzkaller.appspotmail.com)

Yes, the changelog text here needs to be fixed up when you resend it to
include this type of information.

thanks,

greg k-h
