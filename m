Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F04453A7D8D
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jun 2021 13:50:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229520AbhFOLw0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Jun 2021 07:52:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:60244 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229869AbhFOLwX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jun 2021 07:52:23 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id EEAED6145D;
        Tue, 15 Jun 2021 11:50:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1623757818;
        bh=80BKNxMl4vfWn+OgvuwBg4oJz0whC/obf0+2MF/CC/g=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=tjlbJqiCP0gphqnn4Yl4Pybx7ifuZvVN4BXXX2ZNmutWWh8vZsgQv7SDS+W7oHJPv
         fg5YUHiEz7zGOXrhgSPYzzqMUQBjboE/PlSGo3se/i0+j5pYDJ2fhWz++hVw/HuHak
         WJvjKgiM6wWmeAcF3YzNzYugMAGHqTIpKBhPWcpQ=
Date:   Tue, 15 Jun 2021 13:50:15 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
Cc:     David Kershner <david.kershner@unisys.com>,
        sparmaintainer@unisys.com, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org, Matthew Wilcox <willy@infradead.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        Dan Carpenter <dan.carpenter@oracle.com>
Subject: Re: [PATCH v8 RESEND] staging: unisys: visorhba: Convert module from
 IDR to XArray
Message-ID: <YMiT9+msL8H2+3yV@kroah.com>
References: <20210514081112.19542-1-fmdefrancesco@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210514081112.19542-1-fmdefrancesco@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 14, 2021 at 10:11:11AM +0200, Fabio M. De Francesco wrote:
> Converted visorhba from IDR to XArray. The abstract data type XArray is
> more memory-efficient, parallelizable, and cache friendly. It takes
> advantage of RCU to perform lookups without locking. Furthermore, IDR is
> deprecated because XArray has a better (cleaner and more consistent)
> API.
> 
> Signed-off-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>
> Reviewed-by: Dan Carpenter <dan.carpenter@oracle.com>
> ---

Given a lack of response from the unisys maintainer, I'll go apply this
now and see what breaks :)

thanks,

greg k-h
