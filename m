Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5877B3D8D58
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jul 2021 13:59:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236149AbhG1L7j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jul 2021 07:59:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:54746 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234537AbhG1L7h (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jul 2021 07:59:37 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id B88E160F9D;
        Wed, 28 Jul 2021 11:59:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1627473576;
        bh=AecFhB13gNEVES4mwh6SCDd76tCtrwnb1mf7/6NTb2c=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=LEWTyw8VxmVpzBj6vAVeo5u24jiVWX1PiDPJDDbVazwOkZLaRAEykEVHshWC9I1k2
         Fz0Q2Iw3Asis3Rz9bzPATHto4budXIMz0h/m99u7xpaTci6zsvQHHeyE8dnmARzUVq
         NmLmN0J76lbqHlOfb8cxjdOREir+2vkoc0r+Qm5o=
Date:   Wed, 28 Jul 2021 13:59:34 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Pavel Machek <pavel@denx.de>, Jason Ekstrand <jason@jlekstrand.net>
Cc:     linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Marcin Slusarz <marcin.slusarz@intel.com>,
        Jason Ekstrand <jason.ekstrand@intel.com>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Jon Bloomfield <jon.bloomfield@intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>
Subject: Re: [PATCH 5.10 154/167] Revert "drm/i915: Propagate errors on
 awaiting already signaled fences"
Message-ID: <YQFGpoHkJ9tCfGqh@kroah.com>
References: <20210726153839.371771838@linuxfoundation.org>
 <20210726153844.582795218@linuxfoundation.org>
 <20210727213546.GA20206@amd>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210727213546.GA20206@amd>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 27, 2021 at 11:35:46PM +0200, Pavel Machek wrote:
> Hi!
> 
> According to changelog, this introduces security hole.
> 
> > From: Jason Ekstrand <jason@jlekstrand.net>
> > 
> > commit 3761baae908a7b5012be08d70fa553cc2eb82305 upstream.
> > 
> > This reverts commit 9e31c1fe45d555a948ff66f1f0e3fe1f83ca63f7.  Ever
> > since that commit, we've been having issues where a hang in one
> > client
> 
> Hmm. Sounds like problem I'm seeing in mainline. So... good to know.
> 
> > For backporters: Please note that you _must_ have a backport of
> > https://lore.kernel.org/dri-devel/20210602164149.391653-2-jason@jlekstrand.net/
> > for otherwise backporting just this patch opens up a security bug.
> 
> AFAICT we don't have that c9d9fdbc108af8915d3f497bbdf3898bf8f321b8
> drm/i915: Revert "drm/i915/gem: Asynchronous cmdparser" in 5.10 tree.
> 
> Hmm, and it needs follow up fix:
> 6e0b6528d783b2b87bd9e1bea97cf4dac87540d7 drm/i915: Correct the docs
> for intel_engine_cmd_parser.
> 
> (Someone please double check this).

thanks, let me drop this for now.

Jason, you sent me a single patch to backport, should this be 3 patches
instead?

thanks,

greg k-h
