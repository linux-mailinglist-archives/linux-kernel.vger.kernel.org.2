Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 444073CB39C
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jul 2021 09:54:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236837AbhGPH5B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jul 2021 03:57:01 -0400
Received: from verein.lst.de ([213.95.11.211]:42197 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236777AbhGPH5A (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jul 2021 03:57:00 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 3BC4F67373; Fri, 16 Jul 2021 09:54:04 +0200 (CEST)
Date:   Fri, 16 Jul 2021 09:54:04 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Zhihao Cheng <chengzhihao1@huawei.com>
Cc:     kbusch@kernel.org, axboe@fb.com, hch@lst.de, sagi@grimberg.me,
        rakesh@tuxera.com, linux-nvme@lists.infradead.org,
        linux-kernel@vger.kernel.org, yukuai3@huawei.com
Subject: Re: [PATCH] nvme-pci: Don't WARN_ON in nvme_reset_work if
 ctrl.state is not RESETTING
Message-ID: <20210716075404.GC15223@lst.de>
References: <20210705133829.349660-1-chengzhihao1@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210705133829.349660-1-chengzhihao1@huawei.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks,

applied to nvme-5.14.
