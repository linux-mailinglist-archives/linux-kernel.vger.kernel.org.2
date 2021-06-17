Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5ACFF3AB53D
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jun 2021 15:54:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232757AbhFQN47 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Jun 2021 09:56:59 -0400
Received: from verein.lst.de ([213.95.11.211]:58857 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230411AbhFQN45 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jun 2021 09:56:57 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id E83B568C4E; Thu, 17 Jun 2021 15:54:46 +0200 (CEST)
Date:   Thu, 17 Jun 2021 15:54:46 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Wesley Sheng <wesley.sheng@amd.com>
Cc:     kbusch@kernel.org, axboe@fb.com, hch@lst.de, sagi@grimberg.me,
        linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
        logang@deltatee.com, wesleyshenggit@sina.com
Subject: Re: [PATCH] nvme.h: add missing nvme_lba_range_type endianness
 annotations
Message-ID: <20210617135446.GA28419@lst.de>
References: <20210616052508.78970-1-wesley.sheng@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210616052508.78970-1-wesley.sheng@amd.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks,

applied to nvme-5.14.

(and I hope you do not actually plan to use the horribly ill defined
LBA ranges for anything..)
