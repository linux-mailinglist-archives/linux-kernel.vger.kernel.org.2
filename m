Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4E98531F733
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Feb 2021 11:16:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230363AbhBSKQC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Feb 2021 05:16:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230361AbhBSKOt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Feb 2021 05:14:49 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B003C061574
        for <linux-kernel@vger.kernel.org>; Fri, 19 Feb 2021 02:14:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=RJkUgC/iQhNKeXe0maTV0ikvP4g9JnesDTSCL+skfaQ=; b=o2/K5PYzj8bZkoDS5ZSHljNFAF
        isafR5NuTHsOdce4HzE0xEF+QV9OE4ICObUtJuUzN3K+VUv7/jHqQGBMyTF1da2Ii89TgCH2VKhio
        CSFFJLhk/pNYgAnyW1yyS5L0BmZQVJbQX/PMEzczsK5O/xbeGaeALFd6Rf/WxbdaCkGdFjULf/MqB
        m5E/H0fekjK9KxKoElxE4VNkjlKJ7rggYDoDePzgPadrNJMA1CmDbyLb0jOsN7URaWjqUli48Dv3v
        lIQc5Wo02lUPp2yPXvRXb8VhqfjwYtDqVD6d+f+CoqMcIsZZiKN/m2hfkuuXrbkq26G3o4MEWljwN
        YuW6YTZw==;
Received: from hch by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lD2mn-002jqk-Vl; Fri, 19 Feb 2021 10:13:30 +0000
Date:   Fri, 19 Feb 2021 10:13:21 +0000
From:   Christoph Hellwig <hch@infradead.org>
To:     Jason Wang <jasowang@redhat.com>
Cc:     mst@redhat.com, virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Anders Roxell <anders.roxell@linaro.org>,
        Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH] virtio: don't prompt CONFIG_VIRTIO_PCI_MODERN
Message-ID: <20210219101321.GA651861@infradead.org>
References: <20210219084509.48269-1-jasowang@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210219084509.48269-1-jasowang@redhat.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 19, 2021 at 03:45:09AM -0500, Jason Wang wrote:
> We used to prompt CONFIG_VIRTIO_PCI_MODERN to user which may bring a
> lot of confusion. E.g it may break various default configs which want
> virtio devices.
> 
> So this patch fixes this by hide the prompot and document the
> dependency.

Is there any good reason to keep the symbol at all?

