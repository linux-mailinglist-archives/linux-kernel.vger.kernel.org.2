Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 246C838056E
	for <lists+linux-kernel@lfdr.de>; Fri, 14 May 2021 10:45:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233687AbhENIq3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 May 2021 04:46:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:53026 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231839AbhENIq2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 May 2021 04:46:28 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id BEBCB61287;
        Fri, 14 May 2021 08:45:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1620981917;
        bh=GChweA7UlqSx0jPjazErNbjNcvyuSkWf5X3Y2ZUsotQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=MvWUOmakKlJzxnJ7mfH2vpBVjO6aFNbomZjVJq6ELYPB1SxnzTuFle+rVHEyPHaLI
         5ig3SNgFW+X1B9PwUthmctkEuiSAjGa/+DBK72w5n2FlDuQKlI9Wxy5qgrh14YhCZt
         cSMtUfOJX7xcbOwY1k+FqAk2PqtU8WNLzsTnGlR4=
Date:   Fri, 14 May 2021 10:45:14 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Fabio Aiuto <fabioaiuto83@gmail.com>
Cc:     hdegoede@redhat.com, Larry.Finger@lwfinger.net,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: staging: rtl8723bs: questions on TODO list
Message-ID: <YJ44mtOUVZwhxW4m@kroah.com>
References: <20210514083856.GA13800@agape.jhs>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210514083856.GA13800@agape.jhs>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 14, 2021 at 10:38:57AM +0200, Fabio Aiuto wrote:
> Hello all,
> 
> I'd like to have some clarifications about rtl8723bs driver.
> In order to make this driver ready for moving out of staging
> I would like to know:
> 
> - find and remove remaining code valid only for 5 GHz. Most of the obvious
>   ones have been removed, but things like channel > 14 still exist.
> 
> is it possible to remove all 5g code, even the one related to power
> regulation when on band 5g? As far as I know about this card is that
> it doesn't support 5g, so may I just delete all 5g code or there are some
> constraints I'd take care of?
> 
> - find and remove any code for other chips that is left over
> 
> Ok this seems clear, are there some suggestion to do it safely?
> 
> - convert any remaining unusual variable types
> 
> Ok (but feel free to suggest anything)
> 
> - find codes that can use %pM and %Nph formatting
> 
> Ok (but feel free to suggest anything)
> 
> - checkpatch.pl fixes - most of the remaining ones are lines too long. Many
>   of them will require refactoring
> 
> Ok
> 
> - merge Realtek's bugfixes and new features into the driver
> 
> Please, can you explain what one could do that?
> 
> - switch to use LIB80211
> - switch to use MAC80211
> 
> I think I need a few details for these last points as well.
> 
> Do you think that one will need real hardware to complete
> these tasks? I don't have rtl8723bs card at the moment, so
> I think I will focus on those TODO activities which
> don't need it.

I recommend getting one of these devices to do the more complex tasks as
described above.  Otherwise it's going to be hard to verify that your
changes are valid.

thanks,

greg k-h
