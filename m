Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 444B344D494
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Nov 2021 11:01:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232686AbhKKKEF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Nov 2021 05:04:05 -0500
Received: from verein.lst.de ([213.95.11.211]:57723 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229668AbhKKKEB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Nov 2021 05:04:01 -0500
Received: by verein.lst.de (Postfix, from userid 2407)
        id 9A6DC68AA6; Thu, 11 Nov 2021 11:01:08 +0100 (CET)
Date:   Thu, 11 Nov 2021 11:01:08 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Enzo Matsumiya <ematsumiya@suse.de>
Cc:     linux-nvme@lists.infradead.org, Keith Busch <kbusch@kernel.org>,
        Jens Axboe <axboe@fb.com>, Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH] nvme: add NO APST quirk for Kioxia device
Message-ID: <20211111100108.GB5343@lst.de>
References: <20211106020858.18625-1-ematsumiya@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211106020858.18625-1-ematsumiya@suse.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks, applied to nvme-5.16 with a few cosmetic fixups.
