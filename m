Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F27D1357F84
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Apr 2021 11:42:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231196AbhDHJma (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Apr 2021 05:42:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:55796 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230506AbhDHJmY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Apr 2021 05:42:24 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id A105961041;
        Thu,  8 Apr 2021 09:42:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1617874933;
        bh=e9G96CJPvnxdDJgzAUdCgD5peO0SNEQpP7/Ue+6c7mA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=f3VlkD566WrjD+rFz1GITHTVmNlkYycIX2zyJgvokiriP+WcAuQbo0T7CnhwIVOm2
         zl0QlFuwLc6QBM9Qrf8x9d+6KWmRHI/M/LFtPAmzIqjwGiHIdutgdAVzs1ahQQqVUg
         gtM5lyCkrzLh1raXWRUqMxkfP9MgBDoivP87qod+5TibKcmFnps/m4CawMFpnQHegy
         0VHStS4W3b1iUPZ9mJNTqFo0tWtPw7QE5LgacOHZwOaOdz5nYjNi2ocjiFdW0jqQ8p
         8ePC69qptdk1ywfTCknS63hN0MXhWortM2EpBUO8Y1Cv3NvbkhzgJ0ZDGo66Gr0nQH
         2haVjc/5HJKQg==
Received: from johan by xi.lan with local (Exim 4.93.0.4)
        (envelope-from <johan@kernel.org>)
        id 1lURAu-0002zo-D1; Thu, 08 Apr 2021 11:42:08 +0200
Date:   Thu, 8 Apr 2021 11:42:08 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Oliver Neukum <oneukum@suse.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] USB: cdc-acm: fix unprivileged TIOCCSERIAL
Message-ID: <YG7P8EJ1obdM01J8@hovoldconsulting.com>
References: <20210407102845.32720-1-johan@kernel.org>
 <20210407102845.32720-3-johan@kernel.org>
 <8918b0b50068705a865ffc22fe9745dacf0c21e8.camel@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8918b0b50068705a865ffc22fe9745dacf0c21e8.camel@suse.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 08, 2021 at 09:48:38AM +0200, Oliver Neukum wrote:
> Am Mittwoch, den 07.04.2021, 12:28 +0200 schrieb Johan Hovold:
> > TIOCSSERIAL is a horrid, underspecified, legacy interface which for most
> > serial devices is only useful for setting the close_delay and
> > closing_wait parameters.
> > 
> > A non-privileged user has only ever been able to set the since long
> > deprecated ASYNC_SPD flags and trying to change any other *supported*
> > feature should result in -EPERM being returned. Setting the current
> > values for any supported features should return success.
> > 
> > Fix the cdc-acm implementation which instead indicated that the
> > TIOCSSERIAL ioctl was not even implemented when a non-privileged user
> > set the current values.
> 
> Hi,
> 
> the idea here was that you are setting something else, if you are
> not changing a parameter that can be changed. That conclusion is
> dubious, but at the same time, this implementation can change
> only these two parameters. So can the test really be dropped
> as opposed to be modified?

The de-facto standard for how to handle change requests for
non-supported features (e.g. changing the I/O port or IRQ) is to simply
ignore them and return 0.

For most (non-legacy) serial devices the only relevant parameters are
close_delay and closing_wait. And as we need to return -EPERM when a
non-privileged user tries to change these, we cannot drop the test.

(And returning -EOPNOTSUPP was never correct as the ioctl is indeed
supported.)

Johan
