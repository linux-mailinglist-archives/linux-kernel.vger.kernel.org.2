Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B22F93E578B
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Aug 2021 11:54:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234433AbhHJJyZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Aug 2021 05:54:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:42386 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238418AbhHJJyU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Aug 2021 05:54:20 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 680966056C;
        Tue, 10 Aug 2021 09:53:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1628589236;
        bh=+Jack2MU3vGBzmwtndm/AK6co/iJxacfHP18ZxLV8eA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=leec2U6/bIrUYPIxBr4+DeL1QdZWEUkCccM2/3LqzDlK1Dvio6l5l8k1HNFDF6qmm
         G9lCpm9/VLYl1v1uIh6/7T4FCFJDRzG2gSX/pIqI4ZqDG8dAbKRErSJcZ+E+dLlfdj
         hK0osg2Wr8LsmTPB1H82K+TkacaTcRqFF4Gk3esI=
Date:   Tue, 10 Aug 2021 11:53:54 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Dongliang Mu <mudongliangabcd@gmail.com>
Cc:     Samuel Iglesias Gonsalvez <siglesias@igalia.com>,
        Jens Taprogge <jens.taprogge@taprogge.org>,
        Lv Yunlong <lyl2019@mail.ustc.edu.cn>,
        Randy Dunlap <rdunlap@infradead.org>,
        Aditya Srivastava <yashsri421@gmail.com>,
        industrypack-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/2] ipack: tpci200: fix many double free issues in
 tpci200_pci_probe
Message-ID: <YRJMssKBFeToLvKi@kroah.com>
References: <20210810074932.3934499-1-mudongliangabcd@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210810074932.3934499-1-mudongliangabcd@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 10, 2021 at 03:49:21PM +0800, Dongliang Mu wrote:
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

No cc: stable markings on the patches?

:(

