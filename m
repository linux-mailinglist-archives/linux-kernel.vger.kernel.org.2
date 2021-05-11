Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B182E37AD75
	for <lists+linux-kernel@lfdr.de>; Tue, 11 May 2021 19:57:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231437AbhEKR6l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 May 2021 13:58:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:60324 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231728AbhEKR6j (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 May 2021 13:58:39 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id CDCF961628;
        Tue, 11 May 2021 17:57:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1620755852;
        bh=coNUdddX6bfruDWKAREJnoSqQ4xaAEd24WPtbh7Miag=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=pyNaRjlWsLZR9S4Ng+jVsCCUTQrwC4jtqIpMO2iyOYH7YvlBf55i1MRSghaFQDgta
         7/Ym69vuOmSRFJcVKPUPhATzAujfDDC9IgP6LW/yXdk35mXKt7N1xLCfe4EU4pdehD
         cjox1XKaSmUjxMk229U0oUyjzs37guB0LilCepUE=
Date:   Tue, 11 May 2021 19:57:29 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Tong Zhang <ztong0001@gmail.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] misc: alcor_pci: fix null-ptr-deref when there is no PCI
 bridge
Message-ID: <YJrFib6BD8JcX3DM@kroah.com>
References: <20210426220728.1230340-1-ztong0001@gmail.com>
 <YJlE+Z2VKhamVWaw@kroah.com>
 <CAA5qM4CAdb_Aaay1_gjy_AC48Doxtga0f69E1P36=8vscsR9Eg@mail.gmail.com>
 <YJosRuXcSKiFemC8@kroah.com>
 <CAA5qM4CWNsjupqOy+-xKuhT7wSK33r5m_VtvxUikkTi+LA8rHA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAA5qM4CWNsjupqOy+-xKuhT7wSK33r5m_VtvxUikkTi+LA8rHA@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 11, 2021 at 10:17:12AM -0700, Tong Zhang wrote:
> On Tue, May 11, 2021 at 12:03 AM Greg Kroah-Hartman
> <gregkh@linuxfoundation.org> wrote:
> >
> > On Mon, May 10, 2021 at 03:20:02PM -0700, Tong Zhang wrote:
> > > On Mon, May 10, 2021 at 7:36 AM Greg Kroah-Hartman
> > > <gregkh@linuxfoundation.org> wrote:
> > > >
> > > > On Mon, Apr 26, 2021 at 06:07:27PM -0400, Tong Zhang wrote:
> > > > > the PCI bridge might be NULL, so we'd better check before use it
> > > >
> > > > I do not understand, how can pci ever be NULL?  There is only 1 way this
> > >
> > > Hi Greg,
> > > I think the problem is with
> > >     priv->parent_pdev = pdev->bus->self
> > > where bus->self can be NULL. when bus->self is NULL, calling
> >
> > How can bus->self be NULL?
> 
> Hi Greg,
> Please correct me if I am wrong,
> when bus->self is not NULL, it means there is a bridge,
> However, a device can be directly attached to the port on the root
> complex. In this case, the bus->self is NULL.

Does that ever happen with a device on the root like that?

> > Did you see this on a real system?  How did you duplicate the error
> > listed here?
> I did this in QEMU. If QEMU is considered not real, then I haven't
> seen an alcor controller configured in this way in a real system.
> That being said, this kind of configuration is still legit IMHO.

Ah, ok, that makes more sense, this is a virtual system.

I suggest, again, steping back up and just not calling this function if
you are on the root, as it does not make any sense to do so for a device
that is not there.

thanks,

greg k-h
