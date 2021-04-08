Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D8602357E3F
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Apr 2021 10:37:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230033AbhDHIhf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Apr 2021 04:37:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:43322 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229554AbhDHIhe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Apr 2021 04:37:34 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id C681A61004;
        Thu,  8 Apr 2021 08:37:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1617871042;
        bh=gTRJUY1qblXJejgz2sywV+BWhoT7K1wnHBT96srPwq8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=V6GxBF5jSNseCmswWdYSFXiLQuH+aG/A37oCuSEAh7CmY2C6N1PC84DplxdY3O1ui
         NStz0KauMpzYzjj+qboizZE4QjEjFtgeKAg2sQTmsaEDPk4JoebI/ogPE/QYCw5vov
         OUZS4GRsv3lRdgaukMhB/Mf4Up4YrjfZyukaYt/w=
Date:   Thu, 8 Apr 2021 10:37:19 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Mitali Borkar <mitaliborkar810@gmail.com>
Cc:     Larry.Finger@lwfinger.net, florian.c.schilhabel@googlemail.com,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        outreachy-kernel@googlegroups.com, mitali_s@me.iitr.ac.in
Subject: Re: [PATCH] staging: rtl8712: removed unnecessary blank line
Message-ID: <YG7Avz5/iaSynCwX@kroah.com>
References: <YG61JYTdl1HQKcGj@kali>
 <YG64Kvun5Xxy4lOL@kroah.com>
 <CAHWmKdgm0bjRBasEjcWdtDPX1DPON6RSmNXMTp+NQfYrYHmcXg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHWmKdgm0bjRBasEjcWdtDPX1DPON6RSmNXMTp+NQfYrYHmcXg@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A: http://en.wikipedia.org/wiki/Top_post
Q: Were do I find info about this thing called top-posting?
A: Because it messes up the order in which people normally read text.
Q: Why is top-posting such a bad thing?
A: Top-posting.
Q: What is the most annoying thing in e-mail?

A: No.
Q: Should I include quotations after my reply?

http://daringfireball.net/2007/07/on_top

On Thu, Apr 08, 2021 at 01:36:07PM +0530, Mitali Borkar wrote:
> Okay, should I rename the patch?

I can't take it as-is, so you need to change something :)

> I removed a line and matched alignment, so should I rename this
> appropriately?

Only do one logical thing per patch, so if this is 2 logical things,
then you need 2 patches, right?

thanks,

greg k-h
