Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 093E24113CB
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Sep 2021 13:50:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237295AbhITLvf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Sep 2021 07:51:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:58222 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237280AbhITLvd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Sep 2021 07:51:33 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 420396108E;
        Mon, 20 Sep 2021 11:50:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1632138606;
        bh=zQq36pq7rleFs1uOyXpcFPcOgIjdP8YvsOsmALTdTO4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=kwYW6QpczncnC5kf5OXZd9f3gcR78KXq+V3Xw6P+yZKveujNc7FMHGU6m2NiOXJge
         j2WleNdzPVFHvzLkOS2qE1Pw9/OfJcpd0QPUoLYs4NQHee0D0kgcTIMjHSVt0UdG/F
         xcAaKRp/GBIXRL2ai6WMB3A0xwe0SlZ+MS6nJiyA=
Date:   Mon, 20 Sep 2021 13:50:04 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Pavel Skripkin <paskripkin@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        David Laight <david.Laight@aculab.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Martin Kaiser <martin@kaiser.cx>
Subject: Re: [PATCH v8 10/19] staging: r8188eu: rename symbols in rtw_read*()
 and rtw_write*()
Message-ID: <YUh1bBCu644R895r@kroah.com>
References: <20210919235356.4151-1-fmdefrancesco@gmail.com>
 <20210919235356.4151-11-fmdefrancesco@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210919235356.4151-11-fmdefrancesco@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 20, 2021 at 01:53:47AM +0200, Fabio M. De Francesco wrote:
> Rename names of variables in rtw_read{8.16.32}() and in
> rtw_write{8,16,32,N}() because of unnecessary 'p' (that probably stand
> for "pointer to") and 'w' (that probably stands for "word"):
> 
>         pio_priv => io_priv;
>         pintfhdl => intfhdl;
>         wvalue => value.

All spaces, nice :)

Anyway, same 'intfhdl' issue here.

thanks,

greg k-h
