Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B0AF372D39
	for <lists+linux-kernel@lfdr.de>; Tue,  4 May 2021 17:46:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231414AbhEDPr2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 May 2021 11:47:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:39748 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230401AbhEDPr1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 May 2021 11:47:27 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1831860BD3;
        Tue,  4 May 2021 15:46:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1620143192;
        bh=HjWdlGi51gxgMbxhNStXncgZHq51SkoVHiNnYwf6fMM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=lAPGmaSMFz8brn0DX/cZkjHNSWTlHdENIaczx9iKbXXSTNjt9oCaQF9gmqG5dfTxR
         wKQxHtviDPxFpf+MVmQXvF2k6ByJ/QC3jT2tVF4bbIgvzvdrRJF7IiT+ndCmtTzcHX
         AOUkg38T0mHwHJKeDl+7j7kY+S8CWep3cNC8Tjbo=
Date:   Tue, 4 May 2021 17:46:29 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
Cc:     Matthew Wilcox <willy@infradead.org>,
        outreachy-kernel@googlegroups.com,
        David Kershner <david.kershner@unisys.com>,
        sparmaintainer@unisys.com, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org, Daniel Vetter <daniel@ffwll.ch>,
        Dan Carpenter <dan.carpenter@oracle.com>
Subject: Re: [Outreachy kernel] Re: [PATCH v7] staging: unisys: visorhba:
 Convert module from IDR to XArray
Message-ID: <YJFsVTA/DTLvfWQG@kroah.com>
References: <20210504133253.32269-1-fmdefrancesco@gmail.com>
 <3550993.e1xmc6yJDa@linux.local>
 <20210504140119.GH1847222@casper.infradead.org>
 <810075373.q0sU067TuV@linux.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <810075373.q0sU067TuV@linux.local>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 04, 2021 at 04:38:11PM +0200, Fabio M. De Francesco wrote:
> 
> As far as (1) and (2) are regarded, I've been told that when one modifies code 
> she/he should not diverge from the style of the subsystem/driver maintainer/
> author. If you look at visorhba_main.c, you'll find a lot of unnecessary 
> 'else' and 'if (success)'...
> 
> So what are the general rules one should follow when changing (trivial) Linux 
> code? Please note that my question has no other (hidden) purposes than 
> learning to work properly with the Linux community and to reduce the 
> unnecessary noise consequential to submitting a high number of patch versions.

"trivial" changes should only be done in subsystems that welcome it.

drivers/staging/ welcomes it, anything other than that, you need to ask
the maintainer.

thanks,

greg k-h
