Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B3A99402382
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Sep 2021 08:39:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233233AbhIGGiJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Sep 2021 02:38:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231960AbhIGGiI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Sep 2021 02:38:08 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7490C061575
        for <linux-kernel@vger.kernel.org>; Mon,  6 Sep 2021 23:37:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=YQOY8UMKPVMa5zT85FVHWuEJT2tSvdV0m2cYLg8PbJ8=; b=NHKK2aK0sWEg1VGGk06VKOiB81
        3sU2KDlUBSmz24IigHPbUUc3/yDUdtcdVsCrGD7zGp0a+ui8wsZ4MBccqMP1im9fMn8ylEr4ZBNKt
        rrf15zZ/3OAZa2WhkvFdRwnQ+FZ9ZIsxKA6X8cXbGXcBrOcCJjLhcb1tSCjIZqZBYAmdyQjPwBX1z
        VP8nWYgP/sOrWbbFWb8qcfh1f2sbYf43Duw0Kn/r8HGb9M0cFldpe3brXlLUGtq0/SYN3pA/kpA5R
        hNcHYMfrcr5yXBIhyvZyjpX5Tvz6UMhsx4I3nLETLvmWu7dnFeyAqRgsb8T9u1YOq9uFbUvGU6l32
        uBcwunCQ==;
Received: from hch by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mNUhZ-007bAp-Dm; Tue, 07 Sep 2021 06:35:55 +0000
Date:   Tue, 7 Sep 2021 07:35:25 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     Lukas Prediger <lumip@lumip.de>
Cc:     axboe@kernel.dk, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] drivers/cdrom: improved ioctl for media change
 detection
Message-ID: <YTcILRYw/AKen0X4@infradead.org>
References: <20210829143735.512146-1-lumip@lumip.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210829143735.512146-1-lumip@lumip.de>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> +static int cdrom_ioctl_timed_media_change(struct cdrom_device_info *cdi,
> +		unsigned long arg)
> +{
> +	int ret;
> +	struct cdrom_timed_media_change_info __user *info;
> +	struct cdrom_timed_media_change_info tmp_info;
> +
> +	if (!CDROM_CAN(CDC_MEDIA_CHANGED))
> +		return -ENOSYS;
> +
> +	info = (struct cdrom_timed_media_change_info __user *)arg;
> +	cd_dbg(CD_DO_IOCTL, "entering CDROM_TIMED_MEDIA_CHANGE\n");
> +
> +	ret = cdrom_ioctl_media_changed(cdi, CDSL_CURRENT);
> +	if (ret < 0)
> +		return ret;
> +
> +	if (copy_from_user(&tmp_info, info, sizeof(tmp_info)) != 0)
> +		return -EFAULT;
> +
> +	tmp_info.has_changed = ((tmp_info.last_media_change - cdi->last_media_change_ms) < 0);

Overly long line here, but more importantly this is much cleaner with
a good old if:


	if (tmp_info.last_media_change - cdi->last_media_change_ms) < 0)
		tmp_info.has_changed = 1;

> +{
> +	__s64	last_media_change;	/* Timestamp of the last detected media
> +					 * change in ms. May be set by caller, updated
> +					 * upon successful return of ioctl.
> +					 */
> +	__u64	has_changed;		/* Set to 1 by ioctl if last detected media

More overly long lines.  Also why is has_changed a u64 if it is used as
a boolean flag?
