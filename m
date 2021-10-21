Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D609E435CFB
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Oct 2021 10:35:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231443AbhJUIiC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Oct 2021 04:38:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:55496 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231441AbhJUIh5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Oct 2021 04:37:57 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 78D1860FC0;
        Thu, 21 Oct 2021 08:35:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1634805342;
        bh=zYc8BgeDcX1s9EwG1PG1svkNJLRcwRDOiYfOT1psu/w=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=sBm0ahUKom/4sjWMN7UsVVmSTYE5go6xo+vqXtemDB4h4gsXgmsXCYlgBWEfBOn4b
         cEoqlrRFNrEuhVJasvYjvjr9TSEia2qhT25QGckTskYY07TePSyyP9DfRmaKkvlyJu
         /gn7FMJwlwl+kb/Pn9IN0OkXo7rKFMU7fqImyMA4=
Date:   Thu, 21 Oct 2021 10:35:39 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Xianting Tian <xianting.tian@linux.alibaba.com>
Cc:     jirislaby@kernel.org, amit@kernel.org, arnd@arndb.de,
        osandov@fb.com, shile.zhang@linux.alibaba.com,
        linuxppc-dev@lists.ozlabs.org,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v11 0/3] make hvc pass dma capable memory to its backend
Message-ID: <YXEmW071C+GlmXqw@kroah.com>
References: <20211015024658.1353987-1-xianting.tian@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20211015024658.1353987-1-xianting.tian@linux.alibaba.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 15, 2021 at 10:46:55AM +0800, Xianting Tian wrote:
> Dear all,
> 
> This patch series make hvc framework pass DMA capable memory to
> put_chars() of hvc backend(eg, virtio-console), and revert commit
> c4baad5029 ("virtio-console: avoid DMA from stack”)

Thanks for sticking with this, looks much better now, all now queued up.

greg k-h
