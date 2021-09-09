Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C31E14058A0
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Sep 2021 16:08:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242004AbhIIOIn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Sep 2021 10:08:43 -0400
Received: from verein.lst.de ([213.95.11.211]:44478 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240716AbhIIOIg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Sep 2021 10:08:36 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id E007C67373; Thu,  9 Sep 2021 16:07:24 +0200 (CEST)
Date:   Thu, 9 Sep 2021 16:07:24 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
Cc:     kbusch@kernel.org, axboe@fb.com, hch@lst.de, sagi@grimberg.me,
        linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] nvme: Fix missing error code in
 nvme_configure_directives()
Message-ID: <20210909140724.GB28735@lst.de>
References: <1631181021-108687-1-git-send-email-jiapeng.chong@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1631181021-108687-1-git-send-email-jiapeng.chong@linux.alibaba.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks,

applied to nvme-5.15.
