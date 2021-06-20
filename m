Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F0D93ADF97
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Jun 2021 19:28:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229901AbhFTRaN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Jun 2021 13:30:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:50452 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229650AbhFTRaJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Jun 2021 13:30:09 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 844D361078;
        Sun, 20 Jun 2021 17:27:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1624210077;
        bh=UbCQeaZa/L2lRzOnKsDDfsxAGl5phqY488Y8n18gIso=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=PAGL7vZcF+ozh1JU4/6Kf7MGp2Jn+3pfZSTjIhB8xpU28mdtoQ2H3Ui5Qz5MfV4Sl
         Md6TpZZt5ccWWhlPPJvdzV/IZGoI10EslufO6222s9QB5ycwOkcN7EoyHKvG8dI+PW
         ONFnC+P8IYZAsGxm5FHxvdX8foVFqXamiKU1m5OHmD51VbJ4yCPO5rixHW42CJrJ0s
         mVe8RD+5DN0wJgVLSVzNX0GMMB3A5Z1H/IJ6FQU3asTbN41r6UznmqQVQsGCJ5sTG9
         w4ChlWVccq36Ib4qB25fBLMyDFguAvDFdgUiytU0JkEQHeXZJDg5d5twnuYGxBr53N
         ONlyXWoENrlRQ==
Date:   Sun, 20 Jun 2021 10:27:54 -0700
From:   Keith Busch <kbusch@kernel.org>
To:     =?utf-8?B?5ZGo5Lyg6auY?= <zhouchuangao@vivo.com>
Cc:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@fb.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: Re: [PATCH] drivers/nvme/host: Use kobj_to_dev() API
Message-ID: <20210620172754.GB1137891@dhcp-10-100-145-180.wdc.com>
References: <20210618141817.GA18781@lst.de>
 <ABYAKQDNDmr9B7YYOVwFFKqU.3.1624078894067.Hmail.zhouchuangao@vivo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ABYAKQDNDmr9B7YYOVwFFKqU.3.1624078894067.Hmail.zhouchuangao@vivo.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 19, 2021 at 01:01:34PM +0800, 周传高 wrote:
> >On Fri, Jun 18, 2021 at 07:10:58AM -0700, zhouchuangao wrote:
> >> Use kobj_to_dev() API instead of container_of().
> >
> >Why?  That just makes the code harder to read.
> 
> In my opinion, the kobj_to_dev() interface is provided by the kernel so that
> we can get device based on kobj without having to pass more parameters.
> I think it's easier to use.

This same patch has been proposed and rejected numerous times. Do we
need to place a comment in the code to prevent future requests?

http://lists.infradead.org/pipermail/linux-nvme/2021-March/023316.html
http://lists.infradead.org/pipermail/linux-nvme/2021-February/023060.html
http://lists.infradead.org/pipermail/linux-nvme/2020-September/019462.html
