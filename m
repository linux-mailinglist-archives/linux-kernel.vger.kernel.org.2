Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 12A2B32F8F2
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Mar 2021 09:20:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229982AbhCFIT2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 6 Mar 2021 03:19:28 -0500
Received: from mail.kernel.org ([198.145.29.99]:54412 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229701AbhCFITQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Mar 2021 03:19:16 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 407E665012;
        Sat,  6 Mar 2021 08:19:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1615018756;
        bh=0hfOENxhVnX1yjdNrP/1FHbMGCQPZIvQnOF1zBWR0z8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=NILZTZ3sHhkiuctvansXIrN8RZvO1IWkz+/NM4xUO1z8elzrgNxk4PGA8ssXCIGQo
         3rYzvPggeGXcPr9vm/HUM+Q5E+vsJ6TLyOWG4390PXy2mU3bmDq+oE7/YIZ7MsQlft
         GkahuuSE3Wb82Nye/ThC0/JZpZxZI6HhUZi9+4NQ=
Date:   Sat, 6 Mar 2021 09:19:13 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Peter Chen <peter.chen@kernel.org>
Cc:     Pawel Laszczak <pawell@cadence.com>, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, kurahul@cadence.com,
        sparmar@cadence.com
Subject: Re: [PATCH] usb: cdnsp: Fixes incorrect value in ISOC TRB
Message-ID: <YEM7AbyAPey5vn0P@kroah.com>
References: <20210305051059.31623-1-pawell@gli-login.cadence.com>
 <20210306005342.GA1119@b29397-desktop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210306005342.GA1119@b29397-desktop>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 06, 2021 at 08:53:42AM +0800, Peter Chen wrote:
> On 21-03-05 06:10:59, Pawel Laszczak wrote:
> > From: Pawel Laszczak <pawell@cadence.com>
> > 
> > The value "start_cycle ? 0 : 1" in assignment caused
> > implicit truncation whole value to 1 byte.
> > To fix the issue, an explicit casting has been added.
> 
> The root cause for this issue should be operator "|" priority higher
> than "? :", I think just add () for start_cycle ? 0 : 1 could fix it.
> Please double confirm it, and change the commit log if necessary

Please do not rely on this type of thing to get the code right.  Spell
it out with real if () statements so that humans can read it and
understand it and maintain it for the next 10+ years.

thanks,

greg k-h
