Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EBF11409E26
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Sep 2021 22:31:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243768AbhIMUcY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Sep 2021 16:32:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:34064 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230404AbhIMUcX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Sep 2021 16:32:23 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9048C6108B;
        Mon, 13 Sep 2021 20:31:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1631565067;
        bh=I1luLBrQT2QS6nSSKLDDdX9lKRGVXUWe967myVRKHq8=;
        h=Date:From:To:cc:Subject:In-Reply-To:References:From;
        b=NkMwMKqzji1BQ9efEE20R8HGJLZmk2XracuUWD04u26bu5/zQYoT51EuIpnj8a98Y
         XBMpos47u9CxnpLg4uCQ1HZ1GdVhmR/KIqMQQhR6m/MhF5B6JxbD5eKcm9DRBW7Iht
         jxPJOcjcvS4UU3Saa6uy6ggSVWWJxZxuUplqTAyMol9C0a1Zkx5dlBJwdYYs09wp/x
         Ax6gcedHW/T+qr+IViyy00YeVYY1+za2CK6cRf6KI+9CHS+FoPkhMM58+fDGeNGNPm
         Pui7DgrkZnxXiaK6qWwnHK4FtowGTMImhm8nMMhb2AfgMe5+6ZtgegMOrY2Rvx8xuZ
         9n+jW82xbiLwA==
Date:   Mon, 13 Sep 2021 13:31:06 -0700 (PDT)
From:   Stefano Stabellini <sstabellini@kernel.org>
X-X-Sender: sstabellini@sstabellini-ThinkPad-T480s
To:     Jan Beulich <jbeulich@suse.com>
cc:     Stefano Stabellini <sstabellini@kernel.org>,
        Juergen Gross <jgross@suse.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        lkml <linux-kernel@vger.kernel.org>,
        "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>
Subject: Re: [PATCH 04/12] swiotlb-xen: ensure to issue well-formed
 XENMEM_exchange requests
In-Reply-To: <d868bbcc-e800-ed30-3524-a30a5feb7e5a@suse.com>
Message-ID: <alpine.DEB.2.21.2109131328130.10523@sstabellini-ThinkPad-T480s>
References: <588b3e6d-2682-160c-468e-44ca4867a570@suse.com> <397bf325-f81e-e104-6142-e8c9c4955475@suse.com> <alpine.DEB.2.21.2109101613130.10523@sstabellini-ThinkPad-T480s> <d868bbcc-e800-ed30-3524-a30a5feb7e5a@suse.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 13 Sep 2021, Jan Beulich wrote:
> On 11.09.2021 01:14, Stefano Stabellini wrote:
> > On Tue, 7 Sep 2021, Jan Beulich wrote:
> >> While the hypervisor hasn't been enforcing this, we would still better
> >> avoid issuing requests with GFNs not aligned to the requested order.
> >>
> >> Signed-off-by: Jan Beulich <jbeulich@suse.com>
> >> ---
> >> I wonder how useful it is to include the alignment in the panic()
> >> message.
> > 
> > Not very useful given that it is static. I don't mind either way but you
> > can go ahead and remove it if you prefer (and it would make the line
> > shorter.)
> > 
> > 
> >> I further wonder how useful it is to wrap "bytes" in
> >> PAGE_ALIGN(), when it is a multiple of a segment's size anyway (or at
> >> least was supposed to be, prior to "swiotlb-xen: maintain slab count
> >> properly").
> > 
> > This one I would keep, to make sure to print out the same amount passed
> > to memblock_alloc.
> 
> Oh - if I was to drop it from the printk(), I would have been meaning to
> also drop it there. If it's useless, then it's useless everywhere.

That's fine too
