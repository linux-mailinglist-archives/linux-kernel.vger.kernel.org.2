Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F777398D34
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Jun 2021 16:37:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232024AbhFBOjJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Jun 2021 10:39:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:59676 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231245AbhFBOjH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Jun 2021 10:39:07 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 61A36610E5;
        Wed,  2 Jun 2021 14:37:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1622644643;
        bh=Ba1fJoC8PHQZgu+PPULsYm/Lb98b/hJDzMf9rPIQPf4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=pNH2h+AN+6BEc/BuTwAg7ebeGDvP1IzS8/dwuw9WyemvRqLXvrO0rboW3BeYOrCRC
         A0x5ap3FiVFLypJl7Z3pkI+c8vsDBR15UziGnletDfGVJlZSHWbbUV8G55lfj/Egog
         Le3d3nYED4XwoCN9rIhgixCubhSJ5GUl5dTJGTGI=
Date:   Wed, 2 Jun 2021 16:37:21 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Manikishan Ghantasala <manikishanghantasala@gmail.com>
Cc:     Alex Elder <elder@ieee.org>, Rui Miguel Silva <rmfrfs@gmail.com>,
        Johan Hovold <johan@kernel.org>, Alex Elder <elder@kernel.org>,
        greybus-dev@lists.linaro.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: greybus: fixed the coding style, labels should
 not be indented.
Message-ID: <YLeXoQH2/iJjxkc+@kroah.com>
References: <20210602133659.46158-1-manikishanghantasala@gmail.com>
 <9a3878fd-3b59-76f5-ddc7-625c66f9fee8@ieee.org>
 <CAKzJ-FNW8EPX2oQd1qr5NagnvjtWwvSeuAh8DNLetj11+BJ6RA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKzJ-FNW8EPX2oQd1qr5NagnvjtWwvSeuAh8DNLetj11+BJ6RA@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 02, 2021 at 07:57:35PM +0530, Manikishan Ghantasala wrote:
> Sending this mail again as I missed to reply to all.
>  Hi Alex,
> 
> I agree those are called bit-field member names rather than labels.
> But the reason I mentioned is because the ./scripts/checkpatch.pl
> gave out a warning saying "labels should not be indented".

checkpatch is a perl script that does it's best, but does not always get
it right.  In this case, it is incorrect, the existing code is just
fine.

thanks,

greg k-h
