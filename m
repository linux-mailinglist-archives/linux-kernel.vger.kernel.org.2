Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6896232D788
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Mar 2021 17:22:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236754AbhCDQVk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Mar 2021 11:21:40 -0500
Received: from mail.kernel.org ([198.145.29.99]:54542 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233357AbhCDQVL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Mar 2021 11:21:11 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0FA9364F36;
        Thu,  4 Mar 2021 16:20:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1614874831;
        bh=HdYjQQ9T7OFQF4PQe0zh7rKA5LNLX9PTjiuGNW8yaM8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=H+e8iaF+XafVIJIgZn5IjaQa2zYQDKyEXC5nrP/kPL1ySjbMSdwCVD4iJ90H2+SYw
         N+zy5t+KoFemWErlgeOedUkxvzNo2gjzGVbGxRhsNEo+6a329XdP+laSuHWOGLq/cS
         6facQO1uFwABZG1drQ4d1lGB55SKDwv4SZIYnygE=
Date:   Thu, 4 Mar 2021 17:20:28 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org, Jiri Slaby <jirislaby@kernel.org>,
        Corey Minyard <cminyard@mvista.com>,
        Mark Brown <broonie@kernel.org>, Takashi Iwai <tiwai@suse.de>
Subject: Re: regression with TTY changes in v5.12-rc1
Message-ID: <YEEIzO7BrsAwM1LG@kroah.com>
References: <00154592-c5ee-aaba-956e-b265473b53bc@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <00154592-c5ee-aaba-956e-b265473b53bc@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 04, 2021 at 08:37:44AM -0600, Pierre-Louis Bossart wrote:
> Hi,
> Our SOF/audio CI shows an across-the-board regression when we try v5.12-rc1,
> specifically on pause/resume tests with an interactive terminal running
> 'aplay -i' commands managed by expect to simulate the user pressing the
> space bar to pause/unpause. It turns out the processes are not longer killed
> and the audio devices remain busy (see publicly available test results
> listed below).
> 
> git bisect points to commit 33d4ae9885987 ("drivers:tty:pty: Fix a race
> causing data loss on close"). Reverting the patch fixes the issue on all
> test devices.
> 
> Further analysis with Corey Minyard points to a problem where a slave tty
> will not get a SIGHUP when the master is closed.
> 
> Unless there is an alternate fix, a revert looks necessary?
> 
> Regards
> -Pierre
> 
> https://github.com/thesofproject/linux/pull/2772
> https://sof-ci.01.org/linuxpr/PR2772/build5352/devicetest/

Now reverted.

thanks,

greg k-h
