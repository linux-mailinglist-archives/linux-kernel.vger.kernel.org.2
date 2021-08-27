Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9BF573F97BA
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Aug 2021 12:01:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244724AbhH0KBN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Aug 2021 06:01:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:39090 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233173AbhH0KBN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Aug 2021 06:01:13 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1C14960F14;
        Fri, 27 Aug 2021 10:00:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1630058424;
        bh=u8hAQd3Hm65QqeZOuG/ksgjYwWKsJjZKkd7hgnpvwdE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qfRkj6I7Rlcs0Udscvpc4qCYdA7g1/pPoFFrTwiShfmz3z8JtliMI+/IT6nKfmrLd
         LGH/RvAWvEYcQXF0bZ2JoMSm5nBSejjNBB8fj8YGotHTbT4ncQpEytbAPinOHNFPHa
         q/UxApOtdjMeo2v1pQvR6bKYs7Qa+N1QPnUQRBAE=
Date:   Fri, 27 Aug 2021 12:00:14 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Dongliang Mu <mudongliangabcd@gmail.com>
Cc:     Samuel Iglesias Gonsalvez <siglesias@igalia.com>,
        Jens Taprogge <jens.taprogge@taprogge.org>,
        Lv Yunlong <lyl2019@mail.ustc.edu.cn>,
        Aditya Srivastava <yashsri421@gmail.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        industrypack-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ipack: tpci200: change pci_iounmap to iounmap
Message-ID: <YSi3rpsoL3UIuzFY@kroah.com>
References: <20210827094351.203328-1-mudongliangabcd@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210827094351.203328-1-mudongliangabcd@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 27, 2021 at 05:43:47PM +0800, Dongliang Mu wrote:
> The deallocation api for ioremap should be iounmap, other than
> pci_iounmap.

why?

Isn't this a pci device?

thanks,

greg k-h
