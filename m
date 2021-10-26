Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9901443AC5B
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Oct 2021 08:40:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233806AbhJZGmj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Oct 2021 02:42:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:55798 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233421AbhJZGmi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Oct 2021 02:42:38 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5C9F9610A4;
        Tue, 26 Oct 2021 06:40:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1635230414;
        bh=kJYULAxQ9GWcD7oobmxKznGq86FsJz8NuROcbxvoE9o=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ONd6rJYwrcgVeO3z1KX+xDqqb+sFKsLcGcEpAYNqYQanJ0ylItJ211pZP85+JaZWs
         yDH+Dv4RBHuE8kBwtLobCcR8OwLCuxiA66C2wPi8c0FD2a2TMHrqfVbWl/f8gZT+X4
         mj//tbucPeeFWfzVEWqTB9qUP8OuGAg+lBN0hHo4=
Date:   Tue, 26 Oct 2021 08:40:12 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Mathieu Poirier <mathieu.poirier@linaro.org>
Cc:     coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [GIT PULL] Coresight subsystem for v5.16
Message-ID: <YXeizB7QRA33jSZA@kroah.com>
References: <20211025200332.3901607-1-mathieu.poirier@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211025200332.3901607-1-mathieu.poirier@linaro.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 25, 2021 at 02:03:32PM -0600, Mathieu Poirier wrote:
> The following changes since commit 5816b3e6577eaa676ceb00a848f0fd65fe2adc29:
> 
>   Linux 5.15-rc3 (2021-09-26 14:08:19 -0700)
> 
> are available in the Git repository at:
> 
>   git@gitolite.kernel.org:pub/scm/linux/kernel/git/coresight/linux.git tags/v5.16-next
> 
> for you to fetch changes up to 7cf0754113f7ed6fad999483e40d95985c987353:
> 
>   arm64: errata: Enable TRBE workaround for write to out-of-range address (2021-10-25 12:06:02 -0600)
> 
> ----------------------------------------------------------------
> Hi Greg,
> 
> Please consider these for the next merge window.  Also let me know if there
> is any modifications I can do to this pull request to make things easier
> on your side.
> 
> Thanks,
> Mathieu
> 
> Included herein:
> 
> - A new option to make coresight cpu-debug capabilities available as early
> as possible in the kernel boot process.
> 
> - Make trace sessions more enduring by coping with scenarios where events
> are scheduled on CPUs that can't reach the selected sink.
> 
> - A set of improvement to make the TMC-ETR driver more efficient.
> 
> - Enhancements to the TRBE driver to correct several errata.
> 
> - An enhancement to make the AXI burts size configurable for TMC devices
> that can't work with the default value.
> 
> - A fix in the CTI module to use the correct device when calling
> pm_runtime_put()
> 
> - The addition of the Kryo-5xx device to the list of support ETMs.

None of this information above is included in the tag, and it needs to
be there, right?  At the moment, there is nothing in the tag at all to
show up when I do the merge :(

Also, can you please use a signed tag, I don't like to take non-signed
tags if at all possible.

thanks,

greg k-h
