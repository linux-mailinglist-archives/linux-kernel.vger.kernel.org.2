Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F0A2F3E48EC
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Aug 2021 17:34:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235827AbhHIPeh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Aug 2021 11:34:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:44778 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234275AbhHIPdo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Aug 2021 11:33:44 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 056E66101D;
        Mon,  9 Aug 2021 15:33:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1628523202;
        bh=IVjv+5e9aS/a2m09jyExJuZAFAxYork84u93qgltgm8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=FdIEBvepESn9gpWbBU7M/c2GMH0jWi0piUlsYIxT6aoAeOkSLgJbCM/sk3L9qobwt
         9Faj4ooRcRu5W2JttMR8pgYGsZ08T7NKhjaxDf/Fv0RUg1GxEMVVRgMtUUIgT7yjqD
         /7p0EAcP3vPMM8zR+odlrTTR60/WeneUT2D6ky5I=
Date:   Mon, 9 Aug 2021 17:33:20 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Dongliang Mu <mudongliangabcd@gmail.com>
Cc:     Samuel Iglesias Gonsalvez <siglesias@igalia.com>,
        Jens Taprogge <jens.taprogge@taprogge.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Lv Yunlong <lyl2019@mail.ustc.edu.cn>,
        Aditya Srivastava <yashsri421@gmail.com>,
        industrypack-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/4] ipack: tpci200: change pci_iounmap to iounmap
Message-ID: <YRFKwDfjazo5s2xd@kroah.com>
References: <20210809143049.3531188-1-mudongliangabcd@gmail.com>
 <20210809143049.3531188-3-mudongliangabcd@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210809143049.3531188-3-mudongliangabcd@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 09, 2021 at 10:30:28PM +0800, Dongliang Mu wrote:
> The deallocation api for ioremap should be iounmap, other than
> pci_iounmap.
> 
> Signed-off-by: Dongliang Mu <mudongliangabcd@gmail.com>
> ---
>  drivers/ipack/carriers/tpci200.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)

This should just go for 5.15-rc1, right?  It should be a separate series
independant of the first 2?

