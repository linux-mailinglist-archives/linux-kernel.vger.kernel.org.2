Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 942E03B53C8
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Jun 2021 16:29:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231305AbhF0OcS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Jun 2021 10:32:18 -0400
Received: from netrider.rowland.org ([192.131.102.5]:36113 "HELO
        netrider.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S231158AbhF0OcQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Jun 2021 10:32:16 -0400
Received: (qmail 625995 invoked by uid 1000); 27 Jun 2021 10:29:52 -0400
Date:   Sun, 27 Jun 2021 10:29:52 -0400
From:   Alan Stern <stern@rowland.harvard.edu>
To:     Igor Kononenko <i.kononenko@yadro.com>
Cc:     Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jens Axboe <axboe@kernel.dk>, openbmc@lists.ozlabs.org,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/6] fms: Add TOC/PMA/ATIP DVD-ROM capabilities
Message-ID: <20210627142952.GE624763@rowland.harvard.edu>
References: <20210626211820.107310-1-i.kononenko@yadro.com>
 <20210626211820.107310-4-i.kononenko@yadro.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210626211820.107310-4-i.kononenko@yadro.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 27, 2021 at 12:18:16AM +0300, Igor Kononenko wrote:
> The DVD-ROM required the SCSI 6.25 READ TOC/PMA/ATIP Command formats:
>  * Response Format 0000b: Formatted TOC
>  * Response Format 0001b: Multi-session Information
> (MMC-6 Specification).
> 
> This patch adds an implementation of that described above formats.

I will sum up the last four patches of this series by saying that they
add features for emulating DVD-ROM and BD devices.  Doing so increases
the size of the f_mass_storage driver by a considerable amount and
also adds a large amount of new material to Jens Axboe's
include/uapi/linux/cdrom.h.

Is any of this really needed?  What usage scenarios require
f_mass_storage to emulate a DVD-ROM that couldn't use f_tcm instead?

Alan Stern
