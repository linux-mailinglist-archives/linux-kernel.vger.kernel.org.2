Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B1A2A413379
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Sep 2021 14:41:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232844AbhIUMnG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Sep 2021 08:43:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:50806 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232838AbhIUMnB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Sep 2021 08:43:01 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 785EA60249;
        Tue, 21 Sep 2021 12:41:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1632228093;
        bh=KctZ37/K53xgz2KFk6mwt+AcFiMxEwJaw677ODdeatY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Rpttbj55Oat4YnDVWW5MjLLzhuvkstSB0F1tt0FOVWs8PLkFptAFh8smRIxm7ux4a
         aRU9rUtp/sjV9dZW5/nEfGEKDtTqsGx/QreDQUwFli+24H5+kUyLxEbFavIVddBrGS
         kJT5RRJGyBjA8DT5gH8/0zQs7HTy5D2PRYA9nIQnM5Atud1+j0Vi60wO86d13oeFvU
         qdZ2wnfIclxPCcmcGxifM3yd7jpx801M0JJ/+d/T0EDVUVSnmVoNRCNfXoanbS3fA/
         o1kOVK/7P8vnjEQ3DffQAeNoAmvPwobOPxqBKvbMIYPBtK71iWfjltoUqsAvzmJeMS
         2b91sgnvUFH7A==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1mSf5Y-000561-7f; Tue, 21 Sep 2021 14:41:32 +0200
Date:   Tue, 21 Sep 2021 14:41:32 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Himadri Pandya <himadrispandya@gmail.com>
Cc:     gregkh@linuxfoundation.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 6/6] USB: serial: kl5kusb105: use
 usb_control_msg_recv() and usb_control_msg_send()
Message-ID: <YUnS/Chgat7vNHO7@hovoldconsulting.com>
References: <20210801203122.3515-1-himadrispandya@gmail.com>
 <20210801203122.3515-7-himadrispandya@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210801203122.3515-7-himadrispandya@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 02, 2021 at 02:01:22AM +0530, Himadri Pandya wrote:
> The wrappers usb_control_msg_send/recv eliminate the need of allocating
> dma buffers for usb message. They also impose proper error checks on the
> return value of usb_control_msg() to handle short read/write. Hence use
> the wrappers and remove dma allocations.
> 
> Signed-off-by: Himadri Pandya <himadrispandya@gmail.com>
> ---
> Changes in v2:
>  - Fix the caller of klsi_105_chg_port_settings()
>  - Drop unnecessary use of the wrappers

Now applied with an amended commit message:

    USB: serial: kl5kusb105: use usb_control_msg_recv() and usb_control_msg_send()
    
    The wrappers usb_control_msg_send/recv eliminate the need of
    manually allocating DMA buffers for USB messages. They also treat
    short reads as an error. Hence use the wrappers and remove DMA
    allocations.
    
    Note that short reads are now logged as -EREMOTEIO instead of the amount
    of data read.

I've applied all but the first two patches in the series now. Would you
mind respinning those two?

Thanks,
Johan
