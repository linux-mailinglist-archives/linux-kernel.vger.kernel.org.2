Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3BECB3E48EA
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Aug 2021 17:34:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235688AbhHIPeV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Aug 2021 11:34:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:44608 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235642AbhHIPdZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Aug 2021 11:33:25 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id C459D60EFF;
        Mon,  9 Aug 2021 15:32:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1628523159;
        bh=0ikNJgQfITbSz3nHSHziN1gfIXRqD0c4yxNNf9eg0Uk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=TN/p3VYrpd/4XjXbzfQP7t4i6DrkH8Td1HhIsBe3RdkbK0hMLujA29k0ajc5BFYwA
         49b7dEclfkQDS3ZPIO9ayL2cZiTI1lSbB/1kbpXKXkH/UCY5pWmKCysy+Cr+eZ22Uo
         XRfwYd+P7aC825ZknqddTZbI41RaCED7N41G1myw=
Date:   Mon, 9 Aug 2021 17:32:36 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Dongliang Mu <mudongliangabcd@gmail.com>
Cc:     Samuel Iglesias Gonsalvez <siglesias@igalia.com>,
        Jens Taprogge <jens.taprogge@taprogge.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Aditya Srivastava <yashsri421@gmail.com>,
        Lv Yunlong <lyl2019@mail.ustc.edu.cn>,
        industrypack-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/4] ipack: tpci200: fix many double free issues in
 tpci200_pci_probe
Message-ID: <YRFKlOvXKKQX9vr6@kroah.com>
References: <20210809143049.3531188-1-mudongliangabcd@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210809143049.3531188-1-mudongliangabcd@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 09, 2021 at 10:30:26PM +0800, Dongliang Mu wrote:
> The function tpci200_register called by tpci200_install and
> tpci200_unregister called by tpci200_uninstall are in pair. However,
> tpci200_unregister has some cleanup operations not in the
> tpci200_register. So the error handling code of tpci200_pci_probe has
> many different double free issues.
> 
> Fix this problem by moving those cleanup operations out of
> tpci200_unregister, into tpci200_pci_remove and reverting
> the previous commit 9272e5d0028d ("ipack/carriers/tpci200:
> Fix a double free in tpci200_pci_probe").
> 
> Reported-by: Dongliang Mu <mudongliangabcd@gmail.com>
> Fixes: 9272e5d0028d ("ipack/carriers/tpci200: Fix a double free in tpci200_pci_probe")
> Signed-off-by: Dongliang Mu <mudongliangabcd@gmail.com>
> ---
> v1->v2: revise PATCH 2/3, 3/3, not depending on PATCH 1/3; move the
> location change of tpci_unregister into one separate patch;

Also needs to go to the stable trees, right?

