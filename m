Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5DACF42DC04
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Oct 2021 16:49:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231781AbhJNOv2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Oct 2021 10:51:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:39658 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231396AbhJNOv1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Oct 2021 10:51:27 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id BED29606A5;
        Thu, 14 Oct 2021 14:49:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1634222962;
        bh=8qehXygtz+uMQbMsOlGXOq4amdYCvB24FnMrOuWFdGc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ES2SPPOyBr+obO6gXcobl2iQRBJjIUgMedvY/1H5OnDGtsGfxuGFI4k/moWjvNG6X
         EISO1nlgOBpOypRGZHQMa4YGv5BLvxQ9kod0qAIckrMUH4T7K9Os8K0y1MTwRDzi6/
         IuF3mU5DVtRwaXZZUvBcD+09vGXLwS9mYz3hZozk=
Date:   Thu, 14 Oct 2021 16:49:19 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Saurav Girepunje <saurav.girepunje@gmail.com>
Cc:     fabioaiuto83@gmail.com, ross.schm.dev@gmail.com,
        marcocesati@gmail.com, insafonov@gmail.com,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        saurav.girepunje@hotmail.com
Subject: Re: [PATCH v3] staging: rtl8723bs: os_dep: simplify the return
 statement
Message-ID: <YWhDb5/ZDUUs9gb7@kroah.com>
References: <YWhBQF4yUH0/r53A@Sauravs-MacBook-Air.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YWhBQF4yUH0/r53A@Sauravs-MacBook-Air.local>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 14, 2021 at 08:10:00PM +0530, Saurav Girepunje wrote:
> Remove goto statement where function simply return value without doing
> any cleanup action.
> 
> Simplify the return using goto label to avoid unneeded 'if' condition
> check.
> 
> Remove the unneeded and redundant check of variable on goto.
> 
> Remove the assignment of NULL on local variable.

You are saying _what_ you are doing here, but not _why_ you are doing
this.  For example, this last sentance does not make sense, why would
you want to do such a thing (hint, I know, but you need to explain it in
the changelog...)

It's getting better, but the changelog still needs work.  Often times
that's the hardest part of writing a kernel patch.

thanks,

greg k-h
