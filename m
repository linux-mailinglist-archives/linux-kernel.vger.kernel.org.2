Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2DD6E44D603
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Nov 2021 12:43:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233104AbhKKLql (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Nov 2021 06:46:41 -0500
Received: from mail.kernel.org ([198.145.29.99]:43020 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232256AbhKKLqk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Nov 2021 06:46:40 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 443F361261;
        Thu, 11 Nov 2021 11:43:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1636630997;
        bh=05D0QYBkxAy2EtM0RakIVcxKg/l8FuvvMQKcxG4EsVY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=KqyyQZhwMPNiWGip8i2cvixX9HsY3xnRPje9JDKSpNLCVMwtwF9ZaEIqZQt5mYRn0
         AfKnBqIxWNmwUSfoJlzEyfaCf95hfgI77FwgB9JDxEKLPtPLI0Jc2ghnGmmq88ij0S
         4ANfvpHTZhnoghIr0+nhhcLnSbduLWYihx0dpEfY=
Date:   Thu, 11 Nov 2021 12:43:15 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Hans-Gert Dahmen <hans-gert.dahmen@immu.ne>
Cc:     Mika Westerberg <mika.westerberg@linux.intel.com>,
        Richard Hughes <hughsient@gmail.com>,
        Mauro Lima <mauro.lima@eclypsium.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Philipp Deppenwiese <philipp.deppenwiese@immu.ne>,
        "platform-driver-x86@vger.kernel.org" 
        <platform-driver-x86@vger.kernel.org>
Subject: Re: [PATCH] firmware: export x86_64 platform flash bios region via
 sysfs
Message-ID: <YY0B0yBshwK9azJO@kroah.com>
References: <CAHifhD7Qf7+dc7K-MjNguqmiCWUxOJZmQoCTRUZOR-RWMm_JPw@mail.gmail.com>
 <CAHp75Ve9BMNy3gP=-Dajm+Lgu+E4FCqc4phLgV1_cr2qUnTX_w@mail.gmail.com>
 <CAHifhD4n7O5eWFPOjRAmHYL52tW0K=uXXzVj7L5+enTFwFXW2A@mail.gmail.com>
 <CAArk9MP5cKJ+VhAZUseW4LnQNRvux=MZe2eSy3rQkbHKnUsGig@mail.gmail.com>
 <CAHp75VdRwvU5WjFP5E4gg8U+_e34A0Lwze+nz_wVHoB49jLeLg@mail.gmail.com>
 <CAArk9MNGSxR+92n-D2pe_+r+Z0Q9FoTMPqk11sAKA=4Vckj0HQ@mail.gmail.com>
 <YYy7QZGKeEEfI1mH@lahna>
 <CAHifhD5bXu2nP533RXyWDnyNt=k2rRZq5Z6A6CCik_2e6XNgGA@mail.gmail.com>
 <YYzxWPIWFAV04LRU@lahna>
 <CAHifhD4cmsTFc02xNMWnMA74qMQcWMjNoseV3uRjwpY2N9xJ1A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHifhD4cmsTFc02xNMWnMA74qMQcWMjNoseV3uRjwpY2N9xJ1A@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 11, 2021 at 11:55:25AM +0100, Hans-Gert Dahmen wrote:
> > My concern of
> > removing the DANGEROUS tag is that we end up bricking yet another Lenovo
> > laptop by accident. Avoiding that would give me more peace of mind :)
> 
> Yes of course, I think to not endanger users with malfunctions caused
> by code we produce is of our mutual interest here and we should make
> sure to be absolutely serious about it.

This is why I was saying that the driver HAS to specify the hardware
that it is allowed to bind to, and only bind to that hardware.  Your
driver today does not take that into account at all, which is my primary
objection to the code as-is.

thanks,

greg k-h
