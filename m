Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 074053F7151
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Aug 2021 10:53:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233248AbhHYIye (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Aug 2021 04:54:34 -0400
Received: from verein.lst.de ([213.95.11.211]:55333 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231963AbhHYIyd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Aug 2021 04:54:33 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 0C18267357; Wed, 25 Aug 2021 10:53:46 +0200 (CEST)
Date:   Wed, 25 Aug 2021 10:53:45 +0200
From:   "hch@lst.de" <hch@lst.de>
To:     sasaki tatsuya <tatsuya6.sasaki@kioxia.com>
Cc:     "kbusch@kernel.org" <kbusch@kernel.org>,
        "axboe@fb.com" <axboe@fb.com>, "hch@lst.de" <hch@lst.de>,
        "sagi@grimberg.me" <sagi@grimberg.me>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] nvme: update keep alive interval when kato is
 modified
Message-ID: <20210825085345.GA31419@lst.de>
References: <526a1a756d6c4643b15b1b305cc32817@kioxia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <526a1a756d6c4643b15b1b305cc32817@kioxia.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Any reason we can't just call this from nvme_passthru_end instead
of inventing a new API?  Right now the nvmet passthrough code never
uses the underlying keep alive code, so it doesn't make a difference,
but I expect we'll need more handling for passthrough commands like
this, and we might also grow more users (e.g. the io_uring based
passthrough).
