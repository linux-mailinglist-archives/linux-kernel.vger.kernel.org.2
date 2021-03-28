Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F25F334BC5C
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Mar 2021 14:43:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230476AbhC1Mmg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 28 Mar 2021 08:42:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:51070 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230144AbhC1MmG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Mar 2021 08:42:06 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4EA65600EF;
        Sun, 28 Mar 2021 12:42:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1616935325;
        bh=9H1R5D+P5Wj1OdxKbN1Mpyb1GMprHvambZlIutMPryk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Tkydg4oFDlP+NmLi+pyZEKVJa0+thQ/CEVkElvs2s883ogMb0mrhVs0nDFWYg58VH
         ayHaIFqC4FkuUYSkO6iQAqwhKCODKc4PMSBfevo2yWVN/NB/IJQgqqbufxT8ZHHXfI
         i4xDPzfUWTSxwgbkAFFod4Mi2zKtKi2k4fkN8Pbw=
Date:   Sun, 28 Mar 2021 14:42:03 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Bhaskar Chowdhury <unixbhaskar@gmail.com>
Cc:     tglx@linutronix.de, linux-spdx@vger.kernel.org,
        linux-kernel@vger.kernel.org, rdunlap@infradead.org
Subject: Re: [PATCH] scripts/spdxcheck.py: Fix a typo
Message-ID: <YGB5m7qrontEfwTx@kroah.com>
References: <20210326091443.26525-1-unixbhaskar@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210326091443.26525-1-unixbhaskar@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 26, 2021 at 02:44:43PM +0530, Bhaskar Chowdhury wrote:
> 
> s/Initilize/Initialize/
> 
> Signed-off-by: Bhaskar Chowdhury <unixbhaskar@gmail.com>

Now queued up, thanks.

greg k-h
