Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 75AAA36B57E
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Apr 2021 17:11:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234026AbhDZPMR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Apr 2021 11:12:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:44796 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233674AbhDZPMQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Apr 2021 11:12:16 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id B2DA86127A;
        Mon, 26 Apr 2021 15:11:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1619449894;
        bh=mKNVRThB4TR6cTVKU1O3OLaFcmlBF2z0v5DlzX94AGM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hYzD/DCgSUokuruvcCebS+W/pAShhtvrukY0mhG+4lNm6BqyK2ITPFyMVWo7zU8bu
         fglanqjg6kObAKbToMewzwJ/z15pOiD7GD6UKh6e6U+OfbRxe2455d8hxwumcZmXEo
         XU9plv5OLFTKD4ltO7Qw7dKyc9oRJXE5UmL5qB4A=
Date:   Mon, 26 Apr 2021 17:11:31 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Stephen Rothwell <sfr@rothwell.id.au>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        devel@linuxdriverproject.org, linux-kernel@vger.kernel.org,
        linux-staging@lists.linux.dev, Mark Brown <broonie@kernel.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Olof Johansson <olof@lixom.net>, Arnd Bergmann <arnd@arndb.de>,
        ARM <linux-arm-kernel@lists.infradead.org>
Subject: Re: [GIT PULL] Staging/IIO driver updates for 5.13-rc1
Message-ID: <YIbYI2825E4Z2b/3@kroah.com>
References: <YIa2ErYuJyCfSkS+@kroah.com>
 <20210427002648.22459fa7@elm.ozlabs.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210427002648.22459fa7@elm.ozlabs.ibm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 27, 2021 at 12:26:48AM +1000, Stephen Rothwell wrote:
> Hi Greg,
> 
> On Mon, 26 Apr 2021 14:46:10 +0200 Greg KH <gregkh@linuxfoundation.org> wrote:
> >
> > All of these have been in linux-next for a while with no reported
> > issues.
> 
> There was just these:
> 
> https://lore.kernel.org/linux-next/20210329165525.32d51a3a@canb.auug.org.au/
> 
> https://lore.kernel.org/linux-next/20210331175151.67fcfe4d@canb.auug.org.au/
> 
> (the scmi tree commit mentioned in the latter is now in the arm-soc tree)
> 
> Not issues as such, but worth mentioning the conflicts and resolutions.

Yeah, merge issues with other trees are hard to resolve in the single
tree here, not much I can just yet, have to wait for them to hit Linus's
tree.

thanks,

greg k-h
