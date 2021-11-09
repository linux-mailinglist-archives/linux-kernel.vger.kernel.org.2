Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E14D44AC92
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Nov 2021 12:25:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245745AbhKIL2i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Nov 2021 06:28:38 -0500
Received: from mail.kernel.org ([198.145.29.99]:34928 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S245705AbhKIL2h (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Nov 2021 06:28:37 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0F11461181;
        Tue,  9 Nov 2021 11:25:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1636457151;
        bh=ShWODb78JTesztD8vw3v6PUkVGfjRqdMSwOpbeq8enQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Z49g3JObLd2ZWq39ykZxII8k1g/bZcHhngpgwinB8FN0bD6XsVUslZNA5qqTyxLUk
         g7uSttEUla/lDAti3E5OaSIQmf5Ky6ll7GEhUw1v9Pq9lGHYu+ifLouRCbD5FDshzl
         1B9U5JGeo1p7TySk3Ganmf8zlGa3/QV+CJ/KNidw=
Date:   Tue, 9 Nov 2021 12:25:48 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Philipp Deppenwiese <philipp.deppenwiese@immu.ne>
Cc:     Hans-Gert Dahmen <hans-gert.dahmen@immu.ne>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "mauro.lima@eclypsium.com" <mauro.lima@eclypsium.com>,
        "hughsient@gmail.com" <hughsient@gmail.com>,
        "platform-driver-x86@vger.kernel.org" 
        <platform-driver-x86@vger.kernel.org>
Subject: Re: [PATCH] firmware: export x86_64 platform flash bios region via
 sysfs
Message-ID: <YYpavE0t/3OF0qaX@kroah.com>
References: <YYpMTVP/dWsyxMSt@kroah.com>
 <C7D4E238-04FA-4C96-9D54-89CD649B6CBC@getmailspring.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <C7D4E238-04FA-4C96-9D54-89CD649B6CBC@getmailspring.com>
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


On Tue, Nov 09, 2021 at 11:30:06AM +0100, Philipp Deppenwiese wrote:
> Hi Greg,
> 
> sorry for the previous html email, totally forgot kernel ml was plain
> text only.

It's also interleaved responses :)

> Just some feedback regarding the use case for the interface. As you may
> know the firmware (BIOS/UEFI/coreboot) is growing massively in the last
> few years. So we have now 32MB of firmware on a normal x86 system. The
> interface shall be used as safe and secure method to get the first 16MB
> read-only copy of the firmware. The interface from Intel is read-only so
> we shouldn't introduce any security issues here.

The problem is this driver will "bind" to any device it is loaded on,
which is not ok.  It must only work on hardware that it is known to work
on, as remember, Linux runs on hundreds of thousands of different
platforms and types of hardware.

> Aside from us there is fwupd.org and another company which are
> interested in the interface as well. We have added Richard from Redhat
> to the CC. We use the interface mainly for firmware analysis and TPM PCR
> pre-calculation features in our SaaS product.
> 
> I hope that resolves your questions :). Let me know if you want to
> discuss more.

Given a lack of documentation as to what this interface would be used
for, that needs to be resolved, along with links to userspace code that
uses this new api.

thanks,

greg k-h
