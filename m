Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9FFB4432292
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Oct 2021 17:18:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232645AbhJRPUd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Oct 2021 11:20:33 -0400
Received: from verein.lst.de ([213.95.11.211]:34748 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233230AbhJRPU0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Oct 2021 11:20:26 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 7D15668AFE; Mon, 18 Oct 2021 17:18:11 +0200 (CEST)
Date:   Mon, 18 Oct 2021 17:18:11 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Coly Li <colyli@suse.de>
Cc:     Arnd Bergmann <arnd@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Jens Axboe <axboe@kernel.dk>,
        Kent Overstreet <kmo@daterainc.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH] [v2] bcache: hide variable-sized types from uapi
 header check
Message-ID: <20211018151811.GA30977@lst.de>
References: <20210928085554.2299495-1-arnd@kernel.org> <ce05e90b-f22f-bd0e-4e0f-da560bffc0c2@suse.de> <CAK8P3a1brJNoq65h15-zZtNgwV92hwXH9p32cJpzAY3=ouOHnw@mail.gmail.com> <12a593bc-68bc-ac03-0307-a65a0c064af3@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <12a593bc-68bc-ac03-0307-a65a0c064af3@suse.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 18, 2021 at 10:42:37PM +0800, Coly Li wrote:
> I am quite open for this idea. It is in uapi directory before I maintain 
> bcache. I just though the header fines on-media format should go into 
> include/uapi/, but if this is not the restricted rule, it is fine for me to 
> move this header to drivers/md/bcache/.

Having the on-disk format in uapi seems weird.  It isn't a userspace
ABI in any way.
