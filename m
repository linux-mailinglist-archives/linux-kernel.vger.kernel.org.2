Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D44803FD96F
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Sep 2021 14:22:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243990AbhIAMXG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Sep 2021 08:23:06 -0400
Received: from verein.lst.de ([213.95.11.211]:47393 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S243982AbhIAMXF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Sep 2021 08:23:05 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id C0F186736F; Wed,  1 Sep 2021 14:22:05 +0200 (CEST)
Date:   Wed, 1 Sep 2021 14:22:05 +0200
From:   "hch@lst.de" <hch@lst.de>
To:     sasaki tatsuya <tatsuya6.sasaki@kioxia.com>
Cc:     "kbusch@kernel.org" <kbusch@kernel.org>,
        "axboe@fb.com" <axboe@fb.com>, "hch@lst.de" <hch@lst.de>,
        "sagi@grimberg.me" <sagi@grimberg.me>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3] nvme: update keep alive interval when kato is
 modified
Message-ID: <20210901122205.GA10479@lst.de>
References: <894db4eeb08a4622aa1b08425cad0133@kioxia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <894db4eeb08a4622aa1b08425cad0133@kioxia.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks,

applied to nvme-5.15 with a few cosmetic fixups, including making
the From match the spelling of your name in the signoff to keep the
commit vs signoff bots silent.  I hope this ok, if you want a different
spelling let me know.
