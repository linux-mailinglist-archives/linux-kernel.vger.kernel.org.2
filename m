Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 480393EFA29
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Aug 2021 07:36:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237865AbhHRFgo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Aug 2021 01:36:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:34348 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237820AbhHRFg2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Aug 2021 01:36:28 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id BA47861076;
        Wed, 18 Aug 2021 05:35:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1629264954;
        bh=Hm/dPGB1nCzvZRhrVpbssQriJ5nhbqHe+/paKFl+774=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=i2oEP0CtJsVeRXVUIMaLor3n7gpag6efp+kf17/XFHsHwfWMxQKAB9BjtVZfkTUOc
         Ph/cnZ0VJ4lf4EJedV/2+c/xSV5pgmUtuEEA6yu+35sY7rH/GjNSs7oKDjbHklx2ww
         hbVCj+MotXhYSP5IzbuURnkiPX6i6fgVggnfkfmA=
Date:   Wed, 18 Aug 2021 07:35:49 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Daniel Steger <daniel.steger@xilinx.com>
Cc:     rafael@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fs: sysfs: do not remove files if group is null
Message-ID: <YRycNdVNKx47QA/u@kroah.com>
References: <20210818010756.3300864-1-daniel.steger@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210818010756.3300864-1-daniel.steger@xilinx.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 17, 2021 at 06:07:57PM -0700, Daniel Steger wrote:
> This email and any attachments are intended for the sole use of the named recipient(s) and contain(s) confidential information that may be proprietary, privileged or copyrighted under applicable law. If you are not the intended recipient, do not read, copy, or forward this email message or any attachments. Delete this email message and any attachments immediately.

Now deleted.
