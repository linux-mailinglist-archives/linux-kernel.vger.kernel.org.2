Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B6C70352E15
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Apr 2021 19:16:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235746AbhDBRQx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Apr 2021 13:16:53 -0400
Received: from verein.lst.de ([213.95.11.211]:44403 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234759AbhDBRQw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Apr 2021 13:16:52 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 7601268BEB; Fri,  2 Apr 2021 19:16:48 +0200 (CEST)
Date:   Fri, 2 Apr 2021 19:16:48 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Niklas Cassel <Niklas.Cassel@wdc.com>
Cc:     Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        "minwoo.im.dev@gmail.com" <minwoo.im.dev@gmail.com>,
        "javier@javigon.com" <javier@javigon.com>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH] nvme: allow NVME_IOCTL_IO_CMD on controller char
 dev even when multiple ns
Message-ID: <20210402171648.GA22651@lst.de>
References: <20210326205943.431185-1-Niklas.Cassel@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210326205943.431185-1-Niklas.Cassel@wdc.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Well, there is at least one good reason for not allowing this
retroactively:

Old users of the ioctl could have complete garbage in the field, and
might send the command to a random namespace now instead of the first
one.

So unles we have a very good reason I think we should keep
NVME_IOCTL_IO_CMD on the controller char dev deprecated and maybe
eventually remove it.
