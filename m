Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA5AA3A92ED
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jun 2021 08:41:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231889AbhFPGn2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Jun 2021 02:43:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:47844 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231132AbhFPGnP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jun 2021 02:43:15 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 55A9961375;
        Wed, 16 Jun 2021 06:41:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1623825669;
        bh=bnyQKexuJ6RDzlgtnJgkcwR58gl2mLOp+F8KaKPS6ig=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=QYyMahyOZRO6QcBE2RMTBmOB5v4NSui2UoqvdKU/ZDFK3PW315AlXdyCE94NzaRNz
         5mL7O/G/23917osPj5HyStd/VDEbl7BkYdJaJ1RJLa7k921xUD4TUfEpYsmDKBujP5
         IMa3Rq5Xdu5jTUosm5xMx0Tfs4uku79Jn6kg1Gog=
Date:   Wed, 16 Jun 2021 08:41:05 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Zhen Lei <thunder.leizhen@huawei.com>
Cc:     Johannes Thumshirn <morbidrsa@gmail.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 1/1] mcb: Use DEFINE_RES_MEM() to simplify code
Message-ID: <YMmdAQtPN7QRfcNO@kroah.com>
References: <20210616015509.672-1-thunder.leizhen@huawei.com>
 <20210616015509.672-2-thunder.leizhen@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210616015509.672-2-thunder.leizhen@huawei.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 16, 2021 at 09:55:09AM +0800, Zhen Lei wrote:
> Use DEFINE_RES_MEM() to save a couple of lines of code, which makes the
> code a bit shorter and easier to read. The start address does not need to
> appear twice.
> 
> By the way, the value of '.end' should be "start + size - 1". So the
> previous writing should have omitted subtracted 1.

Does that mean the current code is wrong and this is a bugfix?  If so,
what commit id does this fix?

thanks,

greg k-h
