Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E7D5355626
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Apr 2021 16:12:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240377AbhDFONA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Apr 2021 10:13:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:40330 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232041AbhDFOMz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Apr 2021 10:12:55 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id D4A8A6139C;
        Tue,  6 Apr 2021 14:12:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1617718367;
        bh=pcziQPHW1TqS0kWxpYxP9neRIebp6sZAONItqnbfQvY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=KdFawesu53kdwMYki+QYg5Bso5YqGTCFpROshhmtT4kuZCLKQ0VG1OPQhi/eB6zhz
         2G3/wPjNSfuOdfSHAK+PxgQTmAZ8BlUpVFRhQ3W7utBYiH1qoz+FspI8B5EPgTdluY
         e6u9GyNQIbzYX7pPVNff0eyhIIue0MnR8eF/wjhw=
Date:   Tue, 6 Apr 2021 16:12:44 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Zhansaya Bagdauletkyzy <zhansayabagdaulet@gmail.com>
Cc:     Larry.Finger@lwfinger.net, florian.c.schilhabel@googlemail.com,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        outreachy-kernel@googlegroups.com
Subject: Re: [PATCH v2 2/2] staging: rtl8712: Remove extra blank lines
Message-ID: <YGxsXMonD5TvtUyB@kroah.com>
References: <cover.1617710602.git.zhansayabagdaulet@gmail.com>
 <f61f6d330bc3fa53d4d420754d1d461b6cfcb2de.1617710602.git.zhansayabagdaulet@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f61f6d330bc3fa53d4d420754d1d461b6cfcb2de.1617710602.git.zhansayabagdaulet@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 06, 2021 at 06:09:58PM +0600, Zhansaya Bagdauletkyzy wrote:
> Remove extra blank lines after an open brace to adhere to Linux kernel
> coding style.
> Reported by checkpatch.
> 
> Signed-off-by: Zhansaya Bagdauletkyzy <zhansayabagdaulet@gmail.com>
> ---
>  drivers/staging/rtl8712/rtl871x_io.h   | 1 -
>  drivers/staging/rtl8712/rtl871x_mlme.h | 1 -
>  drivers/staging/rtl8712/rtl871x_recv.h | 1 -
>  drivers/staging/rtl8712/sta_info.h     | 1 -
>  4 files changed, 4 deletions(-)

This does not apply either :(
