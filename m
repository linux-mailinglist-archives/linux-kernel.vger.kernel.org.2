Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3640E30DF75
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Feb 2021 17:16:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234977AbhBCQOz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Feb 2021 11:14:55 -0500
Received: from verein.lst.de ([213.95.11.211]:52086 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234910AbhBCQOb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Feb 2021 11:14:31 -0500
Received: by verein.lst.de (Postfix, from userid 2407)
        id 9B38168AFE; Wed,  3 Feb 2021 17:13:45 +0100 (CET)
Date:   Wed, 3 Feb 2021 17:13:44 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
Cc:     kbusch@kernel.org, axboe@fb.com, hch@lst.de, sagi@grimberg.me,
        linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] nvme: convert sysfs sprintf/snprintf family to
 sysfs_emit
Message-ID: <20210203161344.GA4116@lst.de>
References: <1612249577-66130-1-git-send-email-jiapeng.chong@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1612249577-66130-1-git-send-email-jiapeng.chong@linux.alibaba.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks,

applied to nvme-5.12.
