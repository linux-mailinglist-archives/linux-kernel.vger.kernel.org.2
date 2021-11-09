Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F12B244B23C
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Nov 2021 18:56:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241465AbhKIR6t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Nov 2021 12:58:49 -0500
Received: from mail.kernel.org ([198.145.29.99]:51006 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241457AbhKIR6p (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Nov 2021 12:58:45 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id BEDF3610A0;
        Tue,  9 Nov 2021 17:55:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1636480559;
        bh=Slrt1Be8BwzXjB1clZSescouhmhXLHLusvWpHUZB5xY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=yhQdydmz7v7JFpX2PMcoPgaAsOUikTtx5i3UtexEc5CsmNp91W5A2CTX/kIZ6GiI/
         S9t+ILKeCbgM8BGkxM+IQeD7evpR1lUMOXKH8C45yF5O8ALFGwYtu9/SEYsBKXZv17
         oCjWtBhRotJ7GOER7SXhWAJ3ly5F6vWtBqP9HXvg=
Date:   Tue, 9 Nov 2021 18:55:56 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Vihas Mak <makvihas@gmail.com>
Cc:     sudipm.mukherjee@gmail.com, arnd@arndb.de,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] char: ppdev: fixed a validation issue
Message-ID: <YYq2LLHZAX0KpC6A@kroah.com>
References: <20211108185818.GA73382@makvihas>
 <YYoUYOyyP4EFYTSJ@kroah.com>
 <CAH1kMwSqfNT-jB70c6Md_Wa6Sn6GJKr2=LOunSaZwEk2TKzraA@mail.gmail.com>
 <YYpaP1fAg7jrFyhJ@kroah.com>
 <CAH1kMwR7BA6kpcHCmEnEQ_EPeJxFDHQ3QB9mAn0D8NzdB8LNhw@mail.gmail.com>
 <YYqWuYK/c6D9K3Xi@kroah.com>
 <CAH1kMwQyy5v+cNkSzORo-tAe7gUuLJA+9GDDV5kGc9QzZ-zMxQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAH1kMwQyy5v+cNkSzORo-tAe7gUuLJA+9GDDV5kGc9QzZ-zMxQ@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 09, 2021 at 11:21:39PM +0530, Vihas Mak wrote:
> > And you didn't answer my question above, what happens if the mode is not
> > set properly today?
> 
> It'll throw a ENOSYS if the mode is not set properly and print the following:
> 
> pr_debug("%s: Unknown mode 0x%02x\n",
>              port->name, port->ieee1284.mode);

Ah, good, so then your change is not needed at all, so why add it?

thanks,

greg k-h
