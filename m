Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4030C3AFEE0
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jun 2021 10:14:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230040AbhFVIRE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Jun 2021 04:17:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229628AbhFVIRD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jun 2021 04:17:03 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 575BCC061574;
        Tue, 22 Jun 2021 01:14:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=CJeA0+MEt1zElZXSqf4pwES0ZCFoCyVJFjupde8Xr4w=; b=OjR+ufqxV8O1RtS05VwozlyVXX
        hQRgmWESL+3o1aESP0duhCGlBQ7Sy5UPRpN5EXeOhpaxYkBX0JCRz13MqGQTLeiocyssy1I9aUu8D
        Y/OSMjLgBxveHcZvW1LXBGLCNBGtGJ0nqAOR68+jkopdRMqOWYrt9FH0jUzavalm+dlt0GlF99exS
        91tm5VarRfkLBllzAg36Kb2v0GRMOyZ6wC73IYw6ZPuz2pEqwZHxoGqnW6TwSJvwp3d3Qcy3s/SYH
        IzbyfECIi5sD8FFVizPeCd7Pvvc1PA+JgRQxno7NoNnqQrLlEE3t2WsCySFXj8xzUGtt1b5YMyRtA
        And6scOw==;
Received: from hch by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1lvbXw-00E2pk-HK; Tue, 22 Jun 2021 08:14:19 +0000
Date:   Tue, 22 Jun 2021 09:14:12 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     Naresh Kamboju <naresh.kamboju@linaro.org>
Cc:     linux-block <linux-block@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        linux-mtd@lists.infradead.org, Jens Axboe <axboe@kernel.dk>,
        yukuai3@huawei.com, chengzhihao1@huawei.com,
        alexander.sverdlin@nokia.com,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: WARNING: at block/genhd.c:491 __device_add_disk
Message-ID: <YNGb1CFGWljoKmsU@infradead.org>
References: <CA+G9fYtbNfqqM6Hs9XpweFjYALHGTJ9yo3xkg8O3=Lq2grFDSQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+G9fYtbNfqqM6Hs9XpweFjYALHGTJ9yo3xkg8O3=Lq2grFDSQ@mail.gmail.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 22, 2021 at 01:34:25PM +0530, Naresh Kamboju wrote:
> [Please ignore if is already reported]
> 
> Regression found,
> 
> The following kernel warnings reported on Linux next 20210621 while booting
> arm64 hikey and db410c and arm BeagleBoard-X15 devices.
> 
> This crash is always reproducible on these devices while booting with the
> provided config link.

https://git.kernel.dk/cgit/linux-block/commit/?h=for-5.14/drivers-late&id=7059d7cf150a1387ee72403976b81c2bf10af015
