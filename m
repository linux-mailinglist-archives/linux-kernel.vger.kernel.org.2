Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 348923F1EBB
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Aug 2021 19:06:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230504AbhHSRGv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Aug 2021 13:06:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:40200 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230344AbhHSRGu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Aug 2021 13:06:50 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4CFC960E76;
        Thu, 19 Aug 2021 17:06:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1629392774;
        bh=QD5CGpDAzse7pBECVOhujy0C11Da8v1HrvuWNjGqpuA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=KQVVtlL8l+byQPbcdKnRveNl3Sscqk2UwzFZDLXyWQvnpah0M/tkL4h0JYFWGVBWK
         Rs2bZ2LJquPN4BFPufBxjBkUD/NDOeOUV7h+2uCcz+oKiLd3uE7uJdsZM2p52i+cFs
         Lw+0EzkxhMKSYYN9r3YfScKMVnGzMYXMcq89IUcs=
Date:   Thu, 19 Aug 2021 19:04:34 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Oded Gabbay <ogabbay@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [git pull] habanalabs pull request for kernel 5.15
Message-ID: <YR6PIvwYbYG20ZY0@kroah.com>
References: <20210819110209.GA115485@ogabbay-vm2.habana-labs.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210819110209.GA115485@ogabbay-vm2.habana-labs.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 19, 2021 at 02:02:09PM +0300, Oded Gabbay wrote:
> Hi Greg,
> 
> This is habanalabs pull request for the merge window of kernel 5.15.
> The commits divide roughly 50/50 between adding new features, such
> as peer-to-peer support with DMA-BUF or signaling from within a graph,
> and fixing various bugs, small improvements, etc.

Pulled and pushed out, thanks!

greg k-h
