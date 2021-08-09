Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D3FD03E48EE
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Aug 2021 17:34:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235975AbhHIPe7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Aug 2021 11:34:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:44964 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235632AbhHIPeR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Aug 2021 11:34:17 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 05C7F60EFF;
        Mon,  9 Aug 2021 15:33:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1628523230;
        bh=6D3se/ysW+imcmJ/JEOrULledjmGBYOTqqFNWZAWvdQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=W9QbrrNWfkhSJjwkTaOC1jxEeRnHrJwnYbedq1dWj95FchtkDURGCknMzuaY87x2a
         xQJZHZN4etKZs8I/1LF16YcR0XtJBi+vCnu4UIWJLivpBY7p9xZhmjIiUABuJxUWl2
         9YWbf4S+Rao4EY852d/RuVmvOqQwIwJhF1RYlqd4=
Date:   Mon, 9 Aug 2021 17:33:48 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Dongliang Mu <mudongliangabcd@gmail.com>
Cc:     Samuel Iglesias Gonsalvez <siglesias@igalia.com>,
        Jens Taprogge <jens.taprogge@taprogge.org>,
        Lv Yunlong <lyl2019@mail.ustc.edu.cn>,
        Randy Dunlap <rdunlap@infradead.org>,
        Aditya Srivastava <yashsri421@gmail.com>,
        industrypack-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 4/4] ipack: tpci200: move tpci200_unregister close to
 tpci200_register
Message-ID: <YRFK3HxNGicni9OB@kroah.com>
References: <20210809143049.3531188-1-mudongliangabcd@gmail.com>
 <20210809143049.3531188-4-mudongliangabcd@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210809143049.3531188-4-mudongliangabcd@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 09, 2021 at 10:30:29PM +0800, Dongliang Mu wrote:
> Move tpci200_unregister close to tpci200_register, then it is easier to
> review the code related to the registration and unregistration
> 
> Signed-off-by: Dongliang Mu <mudongliangabcd@gmail.com>
> ---
>  drivers/ipack/carriers/tpci200.c | 28 ++++++++++++++--------------
>  1 file changed, 14 insertions(+), 14 deletions(-)

Again, independent of the first 2, and for 5.15-rc1, right?

