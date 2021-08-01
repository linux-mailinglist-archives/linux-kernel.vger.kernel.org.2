Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C2603DCD05
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Aug 2021 19:51:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230242AbhHARvF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 1 Aug 2021 13:51:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229851AbhHARvC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Aug 2021 13:51:02 -0400
Received: from viti.kaiser.cx (viti.kaiser.cx [IPv6:2a01:238:43fe:e600:cd0c:bd4a:7a3:8e9f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84D3DC06175F
        for <linux-kernel@vger.kernel.org>; Sun,  1 Aug 2021 10:50:54 -0700 (PDT)
Received: from martin by viti.kaiser.cx with local (Exim 4.89)
        (envelope-from <martin@viti.kaiser.cx>)
        id 1mAFbt-0002fK-Te; Sun, 01 Aug 2021 19:50:49 +0200
Date:   Sun, 1 Aug 2021 19:50:49 +0200
From:   Martin Kaiser <martin@kaiser.cx>
To:     Larry Finger <Larry.Finger@lwfinger.net>
Cc:     Phillip Potter <phil@philpotter.co.uk>,
        Greg KH <gregkh@linuxfoundation.org>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-staging@lists.linux.dev, Fabio Aiuto <fabioaiuto83@gmail.com>
Subject: Re: [PATCH v4 0/6] staging: r8188eu: add newer/better RTL8188eu
 driver
Message-ID: <20210801175049.eubghjzmhx25ol73@viti.kaiser.cx>
References: <20210727232219.2948-1-phil@philpotter.co.uk>
 <20210728074605.pp5rs4c65tofnqot@viti.kaiser.cx>
 <CAA=Fs0mH9YAVhr24YeE3jpZrnuDGhOuhj=Sb9Ekkpb-xoC5LYg@mail.gmail.com>
 <20210729133730.lnxqzawnvksp4skg@viti.kaiser.cx>
 <1d687d5f-d514-655a-f8bf-a5bac321affb@lwfinger.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1d687d5f-d514-655a-f8bf-a5bac321affb@lwfinger.net>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: Martin Kaiser <martin@viti.kaiser.cx>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Greg and Larry,

thanks for your responses.

Thus wrote Larry Finger (Larry.Finger@lwfinger.net):

> I do see this driver being cleaned up to the point that it transitions to mainline.

> It is not clear to me that it would fit into the rtlwifi framework. It
> probably could use the USB driver there, but unlikely to use a lot more of
> that code.

Ok, that clarifies that path forward. I wasn't sure if a standalone
(non-rtlwifi) driver is acceptable at all.

> I will certainly be on the lookout for conflicts with the rtlwifi and
> rtl8xxxu, indeed the whole drivers/net/wireless/realtek/, code as the
> cleanup proceeds.

At the moment, the driver (like the old one) can be compiled only as a
module. I guess that's because of name conflicts between realtek drivers
that originated from the same codebase. It seems that we'll have to
rename some functions along the way.

Thanks,
Martin
