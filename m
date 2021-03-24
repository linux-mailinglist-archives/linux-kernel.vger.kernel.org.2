Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 502B03473EE
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Mar 2021 09:50:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233861AbhCXItq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Mar 2021 04:49:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:48702 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231693AbhCXIte (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Mar 2021 04:49:34 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 579CA619E5;
        Wed, 24 Mar 2021 08:49:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1616575774;
        bh=HngmhS0wtasTKIvVa50RnFj6kvM+eDwLx+0Kof45b0s=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=TwZ+u/Eov49iDQlwKutWzTCZaDPF58uo7n9jznAmUkGp5uNuh4nVby4iGhh1gCopw
         KNJ2KGIGqTvhSvrn3Htm69PLq1+g9mliAZPVpfo7WT7Rx4uYStrtEXExGYvVQn7Old
         ZPoVoToxXpqBjPnQPkAPY8LKPbdikzth7E8pUDNU=
Date:   Wed, 24 Mar 2021 09:46:22 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Kai Ye <yekai13@huawei.com>
Cc:     linux-accelerators@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        linuxarm@huawei.com, zhangfei.gao@linaro.org,
        wangzhou1@hisilicon.com
Subject: Re: [PATCH] uacce: fixup coding style
Message-ID: <YFr8Xhedmb/02uAS@kroah.com>
References: <1616573515-38828-1-git-send-email-yekai13@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1616573515-38828-1-git-send-email-yekai13@huawei.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 24, 2021 at 04:11:55PM +0800, Kai Ye wrote:
> delete invalid and redundant variable initialization.

Why is it "invalid"?  Seems to just not be needed.

And this isn't a coding style issue, your subject line is incorrect :(

thanks,

greg k-h
