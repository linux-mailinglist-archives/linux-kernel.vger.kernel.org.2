Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F3E833C0A8
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Mar 2021 16:59:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231485AbhCOP63 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Mar 2021 11:58:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:41404 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230435AbhCOP6J (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Mar 2021 11:58:09 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0A12764ED2;
        Mon, 15 Mar 2021 15:58:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1615823889;
        bh=3ji+Q6uY/D0rI03EiK2D5j+YzlmQX7UrPD4ibSY9pes=;
        h=Date:From:To:Cc:Subject:From;
        b=ZUqZqoaiH1LEngvzBROnmPz6AH7yewKwWQFfYI5Xgzmf1mui/3BMTl/pLuvh7mo0b
         V/o/iwLYRjONi5xXW8a7B9vC9QOIdLt9/dKVlm9R/23DReUInpVtvObCWYJpvL71W/
         Ezd0jXPzdUdU/hwJbpAayxyBYmyEPpNuOoiP0Emg=
Date:   Mon, 15 Mar 2021 16:58:06 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     devel@driverdev.osuosl.org
Cc:     linux-staging@list.linux.dev, linux-kernel@vger.kernel.org
Subject: driverdev mailing list is moving!
Message-ID: <YE+EDpgrEU35GoNq@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

After almost 14 years of being hosted by OSUOSL, the driverdev mailing
list is moving to lists.linux.dev.  This should help out with the
occasional mailman issues that driverdev had at times, and is one of the
first lists to help stress-test the new linux.dev mailing lists
infrastructure.

As the scope of this list has changed a lot since it was first created
in 2007, the new name of the list reflects what it has really been for
the past decade or so, a place for patches and development of the
drivers/staging/ subsystem in the Linux kernel.  As such, the new list
address is:
	linux-staging@lists.linux.dev

To sign up for it, go to:
	https://subspace.kernel.org/lists.linux.dev.html
and follow the instructions there.

I'll send a patch to move the list address that is in the MAINTAINERS
file to point to the new list, and this old list will probably be
retired in a month or so after everyone realizes to use the new one.

Thanks so much to OSUOSL for hosting this for so long, and for putting
up with the odd requirements of a tiny mailing list that does not
restrict postings from non-subscribers.  They have done a great job with
this over the years.

If anyone has any questions about this, please let me know.

thanks,

greg k-h
