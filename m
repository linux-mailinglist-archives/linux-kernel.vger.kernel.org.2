Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E068C380562
	for <lists+linux-kernel@lfdr.de>; Fri, 14 May 2021 10:41:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233685AbhENIm0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 May 2021 04:42:26 -0400
Received: from mx2.suse.de ([195.135.220.15]:40750 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230316AbhENImZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 May 2021 04:42:25 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 6BADBB151;
        Fri, 14 May 2021 08:41:13 +0000 (UTC)
Date:   Fri, 14 May 2021 10:41:12 +0200
From:   Daniel Wagner <dwagner@suse.de>
To:     Christoph Hellwig <hch@lst.de>
Cc:     linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
        Sagi Grimberg <sagi@grimberg.me>,
        Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>,
        Enzo Matsumiya <ematsumiya@suse.com>
Subject: Re: [PATCH v3] nvmet: Reset ns->file when open fails
Message-ID: <20210514084112.pxeoyx2lpvwpvvgi@beryllium.lan>
References: <20210512145005.103653-1-dwagner@suse.de>
 <20210512174942.GA26130@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210512174942.GA26130@lst.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Christoph,

On Wed, May 12, 2021 at 07:49:42PM +0200, Christoph Hellwig wrote:
> Thanks,
> 
> applied to nvme-5.13.

I did write the first word with a upercase letter again. I
swear, next time I use a lowercase one.

I noticed you fixed this from 'Reset' to 'seset'. In case you are going
to rebase the branch, you might want to fix the typo. It's not terrible
important though.

Thanks,
Daniel
