Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 55A8A3A3E70
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jun 2021 10:58:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231408AbhFKJAv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Jun 2021 05:00:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:60124 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230385AbhFKJAv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jun 2021 05:00:51 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8399E60BD3;
        Fri, 11 Jun 2021 08:58:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1623401921;
        bh=vvNyA3+tCNK10QXDM+AEGDlrV6IhxcKFPiACJT/DfG8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=2lsnBH6UoNL0qkn78B/3nBgKWTQRrynyWtcW6FylVwYEdJJiACfANEMVSnCdFItV/
         U+WY5SuMKzUASe1otlW9xfjX9xF+BexqOcGrwPLCUrizwgwD5lxHoZcSgMZJkmHJ6U
         v8ul9ZC1X1TTx+tDNiNIIKghZZVRNfbYpdU6vAzQ=
Date:   Fri, 11 Jun 2021 10:58:38 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/9] nvmem: patches (set 1) for 5.14
Message-ID: <YMMlvpGdORKSS5Mb@kroah.com>
References: <20210611083348.20170-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210611083348.20170-1-srinivas.kandagatla@linaro.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 11, 2021 at 09:33:39AM +0100, Srinivas Kandagatla wrote:
> Hi Greg,
> 
> Here are some nvmem patches for 5.14 which includes
> - these are mostly minor fixes in provider drivers like missing
>   MODULE_DEVICE_TABLE and improve comments
> - fix in core for missing of_node_put.
> - setting correct provider type in sunxi sid provider

I took the last 4 patches of this series.  See the review comments on
the first 5 for what should be done with them.

thanks,

greg k-h
