Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8DEAE3EB3CD
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Aug 2021 12:05:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239869AbhHMKGL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Aug 2021 06:06:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239650AbhHMKGL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Aug 2021 06:06:11 -0400
Received: from viti.kaiser.cx (viti.kaiser.cx [IPv6:2a01:238:43fe:e600:cd0c:bd4a:7a3:8e9f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83F6DC061756
        for <linux-kernel@vger.kernel.org>; Fri, 13 Aug 2021 03:05:44 -0700 (PDT)
Received: from martin by viti.kaiser.cx with local (Exim 4.89)
        (envelope-from <martin@viti.kaiser.cx>)
        id 1mEU4G-0002an-N0; Fri, 13 Aug 2021 12:05:36 +0200
Date:   Fri, 13 Aug 2021 12:05:36 +0200
From:   Martin Kaiser <martin@kaiser.cx>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     Phillip Potter <phil@philpotter.co.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Larry Finger <Larry.Finger@lwfinger.net>,
        Michael Straube <straube.linux@gmail.com>,
        linux-staging@lists.linux.dev,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 3/5] staging: r8188eu: (trivial) remove a duplicate debug
 print
Message-ID: <20210813100536.xkjzfq5pstbhdwru@viti.kaiser.cx>
References: <20210811201450.31366-1-martin@kaiser.cx>
 <20210811201450.31366-3-martin@kaiser.cx>
 <CAA=Fs0n0U62cZADeEGXD7HUYzCXpZuHXGZZruztNoTeShFw5aA@mail.gmail.com>
 <20210812061759.GW22532@kadam>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210812061759.GW22532@kadam>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: Martin Kaiser <martin@viti.kaiser.cx>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dan and Phil,

Thus wrote Dan Carpenter (dan.carpenter@oracle.com):

> Please think of the subject and the commit message as two different
> things.  Often it's people reviewing on email will only read one or the
> other.  In other words just restate the subject:

ok, I'll keep that in mind for further patches.

> > Dear Martin,

> > Just my personal opinion, but I'd be inclined to strip out all DBG_88E
> > calls totally. If there are necessary functions being called such as
> > device_may_wakeup() we can always just keep this part and remove the
> > macro call (not checked this function out myself yet). Thanks.

I'd agree with you, Phil. Most DBG_88E prints don't say anything useful.

This comment from Greg made me drop the DBG_88E removal for now

https://lore.kernel.org/linux-staging/20210803201511.29000-1-martin@kaiser.cx/T/#m05d82a0ca8ed36180ebdc987114b4d892445c52d

A compromise would be to remove only those DBG_88E prints which are
really not helpful.

Best regards,
Martin
