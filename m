Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D1E563AB53E
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jun 2021 15:55:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232795AbhFQN5S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Jun 2021 09:57:18 -0400
Received: from verein.lst.de ([213.95.11.211]:58866 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230411AbhFQN5R (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jun 2021 09:57:17 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 2935468C4E; Thu, 17 Jun 2021 15:55:08 +0200 (CEST)
Date:   Thu, 17 Jun 2021 15:55:07 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     JK Kim <jongkang.kim2@gmail.com>
Cc:     kbusch@kernel.org, axboe@fb.com, hch@lst.de, sagi@grimberg.me,
        linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] nvme-pci: fix var. type for increasing cq_head
Message-ID: <20210617135507.GC28419@lst.de>
References: <YMrlaTjfyy9slGg6@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YMrlaTjfyy9slGg6@localhost>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks,

applied to nvme-5.14.
