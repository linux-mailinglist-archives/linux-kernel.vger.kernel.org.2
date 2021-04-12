Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C0F0435CECB
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Apr 2021 18:56:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245004AbhDLQtL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Apr 2021 12:49:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:44946 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1344842AbhDLQp6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Apr 2021 12:45:58 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3106161042;
        Mon, 12 Apr 2021 16:45:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1618245937;
        bh=YzJfpRRwHIL/702AQ7JNIjM04wJ0QxXSj4/2WU2D0Yo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=enPn3PDHLhw/lDt7On0cAtqD72stzBnSJQiVTR3LsgOEClrvOanEN1Jmulh2WTFbG
         wGkuIFFO8I+ciIUm9snU3Hep1VV4mXl2dutwDy3U8fabfo7K0CtbwmbKpdbak5rMrD
         1yETrg+Y4byb5Ye69LdOhq9IO5kUFQR4Z4EEOcTE=
Date:   Mon, 12 Apr 2021 18:45:35 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Bryan Brattlof <hello@bryanbrattlof.com>
Cc:     Hans de Goede <hdegoede@redhat.com>,
        Larry Finger <Larry.Finger@lwfinger.net>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: Re: [PATCH v2] staging: rtl8723bs: remove unnecessary adapter
Message-ID: <YHR5L2aSZ4hNNmT0@kroah.com>
References: <20210412163650.42467-1-hello@bryanbrattlof.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210412163650.42467-1-hello@bryanbrattlof.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 12, 2021 at 04:43:56PM +0000, Bryan Brattlof wrote:
> The if2 adapter is defined in rtw_dvr_init() and in the dvobj_priv
> structure but never used anywhere in the driver. This will remove all
> definitions of if2
> 
> Signed-off-by: Bryan Brattlof <hello@bryanbrattlof.com>
> ---
>  drivers/staging/rtl8723bs/include/drv_types.h |  1 -
>  drivers/staging/rtl8723bs/os_dep/sdio_intf.c  | 10 ++++------
>  2 files changed, 4 insertions(+), 7 deletions(-)

What changed from v1?  That goes below the --- line.

v3?
