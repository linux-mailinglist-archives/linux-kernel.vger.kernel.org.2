Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9725645B6F2
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Nov 2021 09:52:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234321AbhKXI4F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Nov 2021 03:56:05 -0500
Received: from mail.kernel.org ([198.145.29.99]:50648 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229825AbhKXI4C (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Nov 2021 03:56:02 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 843CF6044F;
        Wed, 24 Nov 2021 08:52:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1637743973;
        bh=KkzqBUvGNUBsPo7CDvSCmHv1J7fmjeDSkGc2AKdm2W8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=dMJhYXqxj/fFw5H+6QSAO48qY5U2Xey4Adbm3u5Em8r6kvYs6p4pkHXB8NVW1dR6j
         i6WyAxseizXMETRVNktOpQPHm8vNT9By/aVqHykQlpMcIbqpu4b6BT6q/H5I/8hZvw
         u/6rZk9oXFpmWeixFcCCSuJvHIpn8l0BvjgzlEUI=
Date:   Wed, 24 Nov 2021 09:52:50 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Cai Huoqing <caihuoqing@baidu.com>
Cc:     Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev
Subject: Re: [PATCH v2 1/3] staging: zynpu: Add driver support for ARM(China)
 ZHOUYI AI accelerator
Message-ID: <YZ39YqsNTSolEJZ2@kroah.com>
References: <20211124084620.628-1-caihuoqing@baidu.com>
 <20211124084620.628-2-caihuoqing@baidu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211124084620.628-2-caihuoqing@baidu.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 24, 2021 at 04:46:15PM +0800, Cai Huoqing wrote:
> ZHOUYI NPU is an AI accelerator chip which is integrated into ARM SOC,
> such as Allwinner R329 SOC.
> Add driver support for this AI accelerator here.
> 
> This driver is not tandard linux style, there are some clean up works,

"standard"?

> fixing code style, refactorring.
> And it only works with a closed source usermode driver, so need to
> reverse the libraries, and impelement it, then open source
> the usermode driver.

Who will be doing the "reversing" of the usermode driver?

We can't take this now if there's no actual users of this code that
anyone can test.  Why not just change the license of the usermode code
now to make this simpler?

thanks,

greg k-h
