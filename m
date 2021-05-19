Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 28A8D3887A1
	for <lists+linux-kernel@lfdr.de>; Wed, 19 May 2021 08:35:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237456AbhESGg4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 May 2021 02:36:56 -0400
Received: from verein.lst.de ([213.95.11.211]:36903 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237417AbhESGgz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 May 2021 02:36:55 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 1FAF767373; Wed, 19 May 2021 08:35:34 +0200 (CEST)
Date:   Wed, 19 May 2021 08:35:33 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Wu Bo <wubo40@huawei.com>
Cc:     hch@lst.de, sagi@grimberg.me, chaitanya.kulkarni@wdc.com,
        kbusch@kernel.org, amit.engel@dell.com,
        linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
        linfeilong@huawei.com
Subject: Re: [PATCH 0/2] nvmet: Fix memory leak when create ctrl fails
Message-ID: <20210519063533.GC30513@lst.de>
References: <1621400470-593256-1-git-send-email-wubo40@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1621400470-593256-1-git-send-email-wubo40@huawei.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks,

applied to nvme-5.13 with slight tweaks to the commit messages and
fixes tags.
