Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ACEEE371DE1
	for <lists+linux-kernel@lfdr.de>; Mon,  3 May 2021 19:10:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236060AbhECRFq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 May 2021 13:05:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:42894 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234768AbhECQys (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 May 2021 12:54:48 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2346A61422;
        Mon,  3 May 2021 16:42:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1620060134;
        bh=w1jmLRhVdFy5ZelzMGG2M3Zwq0ImzKCjeQDPvXQ4P2E=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=dQyYQje/pGbkQUgHTu0sn5ViLnaAkjken2UWLWsRRasqKe5f+kjifq2xTwchxMs+t
         YUZg/F0n2GuwNAek5LQG/SRpciJX+hT7lXhIcZTC+ZDW9Hu4BbHOyvPaQja3WN98vU
         JBNk8vBpkSJgdJSD11KS6J4iysfyzsMI+LWE6pLA=
Date:   Mon, 3 May 2021 18:42:11 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Alexander Vorwerk <alec@vc-celle.de>
Cc:     forest@alittletooquiet.net, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] staging: vt6655: remove multiple assignments
Message-ID: <YJAn4zTAhDF1K4im@kroah.com>
References: <20210502210826.10323-1-alec@vc-celle.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210502210826.10323-1-alec@vc-celle.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 02, 2021 at 11:08:24PM +0200, Alexander Vorwerk wrote:
> These two patches fix two multiple assignments coding-style
> issues reported by checkpatch.pl.
> 
> Alexander Vorwerk (2):
>   staging: vt6655: remove multiple assignment
>   staging: vt6655: remove multiple assignment

You sent 2 patches that do different things yet have the same identical
subject line :(

Please fix up and resend.

thanks,

greg k-h
