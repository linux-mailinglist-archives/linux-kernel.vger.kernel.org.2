Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8569C3F2E24
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Aug 2021 16:33:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240882AbhHTOeS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Aug 2021 10:34:18 -0400
Received: from verein.lst.de ([213.95.11.211]:41230 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238451AbhHTOeR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Aug 2021 10:34:17 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id DDF216736F; Fri, 20 Aug 2021 16:33:37 +0200 (CEST)
Date:   Fri, 20 Aug 2021 16:33:37 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Christoph Hellwig <hch@lst.de>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        "moderated list:H8/300 ARCHITECTURE" 
        <uclinux-h8-devel@lists.sourceforge.jp>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: remove set_fs() for h8300
Message-ID: <20210820143337.GA30797@lst.de>
References: <20210709115311.3424912-1-hch@lst.de> <20210817052003.GA4595@lst.de> <CAK8P3a3rtL5t65GQOEP5XdfsaEOZP=PpiZM9hjYkO=jC6oOptA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK8P3a3rtL5t65GQOEP5XdfsaEOZP=PpiZM9hjYkO=jC6oOptA@mail.gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 20, 2021 at 01:05:30PM +0200, Arnd Bergmann wrote:
> It took me a while to figure out that this works on architectures that
> define CONFIG_UACCESS_MEMCPY, as they get the asm-generic
> version of get_kernel_nofault(). Maybe add that to the changelog,
> plus my
> 
> Reviewed-by: Arnd Bergmann <arnd@arndb.de>
> 
> Do you have more of these? I'm happy to take them through the
> asm-generic tree, at least for architectures with no response from
> the maintainers (not m68k, which looks too complex). I did partial
> patches for sh and sparc at some point to remove the set_fs() callers,
> but got stuck when I tried doing ia64 and didn't submit any of these.

This one actually got picked up in the u8300 tree now.  The only
outstanding one I have is uml, waiting for maintainer feedback for
that.
