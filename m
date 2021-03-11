Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 27EF633728F
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Mar 2021 13:28:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233001AbhCKM14 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Mar 2021 07:27:56 -0500
Received: from mail.kernel.org ([198.145.29.99]:57110 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232827AbhCKM1t (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Mar 2021 07:27:49 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id C242F64FE0;
        Thu, 11 Mar 2021 12:27:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1615465669;
        bh=fqmiIMmkzGm4bk+5cd6uISUpc1KUDfW61C1dpaTb2Vs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=bGIhEtFZrRg1Zhk+XYs90DdnMeE1i6g1e/Ng1AqmZhrjDN4JE9pUBDuvrX/yiCPr6
         rXFhXVv+0LUo8pqwmHozhqBYrautk+lFezqgjF118NfGrIuwv7lTUzDnfZ63waA4QH
         ZCgbps0EEMYNYHAk804FLoIdNbwBpLOh6ApOpNNA=
Date:   Thu, 11 Mar 2021 13:27:46 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Shubhankar Kuranagatti <shubhankarvk@gmail.com>
Cc:     axboe@kernel.dk, jack@suse.cz, hare@suse.de, tj@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] init: do_mounts.c: Fix indentation errors.
Message-ID: <YEoMwumEF+rO0bz3@kroah.com>
References: <20210311120650.nzgv6l3addpouwep@kewl-virtual-machine>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210311120650.nzgv6l3addpouwep@kewl-virtual-machine>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 11, 2021 at 05:36:50PM +0530, Shubhankar Kuranagatti wrote:
> Switch and case have been aligned together, extra tab removed
> Removed extra space before tab.
> 
> Signed-off-by: Shubhankar Kuranagatti <shubhankarvk@gmail.com>
> ---
>  init/do_mounts.c | 13 ++++++-------
>  1 file changed, 6 insertions(+), 7 deletions(-)

For basic "clean up the code as a first patch task", please stick to the
code under drivers/staging/ and do not venture out into the "core"
kernel files as that just causes unneeded and unwanted churn.

good luck!

greg k-h
