Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 437903DA470
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jul 2021 15:37:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237621AbhG2Nho (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Jul 2021 09:37:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237480AbhG2Nhk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jul 2021 09:37:40 -0400
Received: from viti.kaiser.cx (viti.kaiser.cx [IPv6:2a01:238:43fe:e600:cd0c:bd4a:7a3:8e9f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3617CC061765
        for <linux-kernel@vger.kernel.org>; Thu, 29 Jul 2021 06:37:37 -0700 (PDT)
Received: from martin by viti.kaiser.cx with local (Exim 4.89)
        (envelope-from <martin@viti.kaiser.cx>)
        id 1m96E6-0002pn-FI; Thu, 29 Jul 2021 15:37:30 +0200
Date:   Thu, 29 Jul 2021 15:37:30 +0200
From:   Martin Kaiser <martin@kaiser.cx>
To:     Phillip Potter <phil@philpotter.co.uk>,
        Greg KH <gregkh@linuxfoundation.org>,
        Larry Finger <Larry.Finger@lwfinger.net>
Cc:     Dan Carpenter <dan.carpenter@oracle.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-staging@lists.linux.dev, Fabio Aiuto <fabioaiuto83@gmail.com>
Subject: Re: [PATCH v4 0/6] staging: r8188eu: add newer/better RTL8188eu
 driver
Message-ID: <20210729133730.lnxqzawnvksp4skg@viti.kaiser.cx>
References: <20210727232219.2948-1-phil@philpotter.co.uk>
 <20210728074605.pp5rs4c65tofnqot@viti.kaiser.cx>
 <CAA=Fs0mH9YAVhr24YeE3jpZrnuDGhOuhj=Sb9Ekkpb-xoC5LYg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAA=Fs0mH9YAVhr24YeE3jpZrnuDGhOuhj=Sb9Ekkpb-xoC5LYg@mail.gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: Martin Kaiser <martin@viti.kaiser.cx>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Phil and all,

Thus wrote Phillip Potter (phil@philpotter.co.uk):

> I see what you are saying for sure - I think we've both sunk a fair
> few patches into the existing driver :-)

> That said, from what Larry has mentioned, this newer driver would
> still be a better bet overall due to the additional work that has
> already happened on it out-of-tree. The Realtek driver you reference
> probably has no CFG80211 support etc. would be my guess, but I am
> going off what others have suggested in terms of proposing this
> patchset. I can't honestly say what the risk of this happening again
> would be, but minimal I'd imagine.

ok, understood. That's an important feature. I see that Greg accepted
your patches, there's no point in arguing any more ;-)

Greg and Larry: Would you mind sharing your ideas about getting
rtl8188eu support mainline? Do you imagine that we clean up this driver
until it can be moved out of staging? If so, we'd probably have to
resolve name conflicts with other realtek drivers and rename lots of
functions. Or would a cleanup of the new rtl8188eu driver be a
preparation for adding bits and pieces of it to rtlwifi?

Thanks,
Martin
