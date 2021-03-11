Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E80E73378BE
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Mar 2021 17:07:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234334AbhCKQGf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Mar 2021 11:06:35 -0500
Received: from mx2.suse.de ([195.135.220.15]:39796 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234388AbhCKQGC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Mar 2021 11:06:02 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1615478761; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3qBsv45UjL97TgtzJLfDkDi/Mr3EkrptzlfttXXQt2E=;
        b=kbn8gS+jY6nAxt918hAN+fu75RmT9tlBvxP90VfLOTuckANF5bfFqh9VKuapV/ow0+F7vc
        RQqEVoVRnzm2+l5Ggm0hQb3PYBA/FLXdPIzHDpZgjyvPCNd5zvc9FlL8CheHzyZye4exWN
        Yo4PkmSLdJG2JtZiET4E0AroDNsAGrw=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id A32A8AC16;
        Thu, 11 Mar 2021 16:06:01 +0000 (UTC)
Message-ID: <56fd14aea3e2063a472eab443eb788ab047ed74a.camel@suse.com>
Subject: Re: [PATCH v2] block: Suppress uevent for hidden device when removed
From:   Martin Wilck <mwilck@suse.com>
To:     Daniel Wagner <dwagner@suse.de>, linux-block@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@lst.de>
Date:   Thu, 11 Mar 2021 17:06:00 +0100
In-Reply-To: <20210311151917.136091-1-dwagner@suse.de>
References: <20210311151917.136091-1-dwagner@suse.de>
Content-Type: text/plain; charset="ISO-8859-15"
User-Agent: Evolution 3.38.2 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2021-03-11 at 16:19 +0100, Daniel Wagner wrote:
> register_disk() suppress uevents for devices with the GENHD_FL_HIDDEN
> but enables uevents at the end again in order to announce disk after
> possible partitions are created.
> 
> When the device is removed the uevents are still on and user land
> sees
> 'remove' messages for devices which were never 'add'ed to the system.
> 
> � KERNEL[95481.571887] remove�� /devices/virtual/nvme-
> fabrics/ctl/nvme5/nvme0c5n1 (block)
> 
> Let's suppress the uevents for GENHD_FL_HIDDEN by not enabling the
> uevents at all.
> 
> Signed-off-by: Daniel Wagner <dwagner@suse.de>

Reviewed-by: Martin Wilck <mwilck@suse.com>

