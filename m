Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E725D422AD9
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Oct 2021 16:20:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235469AbhJEOVv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Oct 2021 10:21:51 -0400
Received: from netrider.rowland.org ([192.131.102.5]:47787 "HELO
        netrider.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S234899AbhJEOVu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Oct 2021 10:21:50 -0400
Received: (qmail 622086 invoked by uid 1000); 5 Oct 2021 10:19:58 -0400
Date:   Tue, 5 Oct 2021 10:19:58 -0400
From:   Alan Stern <stern@rowland.harvard.edu>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Nikita Yushchenko <nikita.yoush@cogentembedded.com>,
        Felipe Balbi <balbi@kernel.org>, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Petr Nechaev <petr.nechaev@cogentembedded.com>
Subject: Re: [PATCH v3] usb: gadget: storage: add support for media larger
 than 2T
Message-ID: <20211005141958.GA621017@rowland.harvard.edu>
References: <YUnsSxUERYj/oXTO@kroah.com>
 <20210921145901.11952-1-nikita.yoush@cogentembedded.com>
 <YVwyDsuIT9lZWi2v@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YVwyDsuIT9lZWi2v@kroah.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 05, 2021 at 01:07:58PM +0200, Greg Kroah-Hartman wrote:
> On Tue, Sep 21, 2021 at 05:59:02PM +0300, Nikita Yushchenko wrote:
> > This adds support for READ_CAPACITY(16), READ(16) and WRITE(16)
> > commands, and fixes READ_CAPACITY command to return 0xffffffff if
> > media size does not fit in 32 bits.
> > 
> > This makes f_mass_storage to export a 16T disk array correctly.
> > 
> > Signed-off-by: Nikita Yushchenko <nikita.yoush@cogentembedded.com>
> > ---
> > v3:
> > - added this changelog
> > 
> > v2:
> > - fixed call to check_command() for READ_CAPACITY(16)
> > - fixed alphabetical order of commands in switch statement
> > - renamed variable, added comments, and fixed formatting, per advices by
> >   Alan Stern <stern@rowland.harvard.edu>
> 
> Felipe and Alan, any objections to this change?

No objections.  In fact, I already sent my Acked-by for v2 of the 
patch (which is the same as v3):

https://marc.info/?l=linux-usb&m=163165151506682&w=2

Alan Stern
