Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2F6A6438FC3
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Oct 2021 08:53:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231310AbhJYGzu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Oct 2021 02:55:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:54046 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229727AbhJYGzu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Oct 2021 02:55:50 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id CCB0060FBF;
        Mon, 25 Oct 2021 06:53:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1635144808;
        bh=hB89tqqA+R2LBw/YNd/zh9ZgvPTsJ4RANMMKM3Yz924=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=iLQoaY/KT5FHbCEpvvOFKkAa/rjUw9qtSfRwlUVTXp3ca+U3r+qlT/bBXn7Zt1kq/
         McCZcuN3ClCBkFI0H0B9PUxQEQY1JOP0CvwqsWije27BoXyzVrPJ83BOJUa8MClal7
         pMFGWnw5KI6/0p2w2cnMst8gFg8OUo1O5qBTDgHc=
Date:   Mon, 25 Oct 2021 08:53:21 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Vinod Koul <vkoul@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>
Subject: Re: [GIT PULL]: soundwire updates for v5.16-rc1
Message-ID: <YXZUYfM2kdtwbHMq@kroah.com>
References: <YXVn3w1vRvPp0xY4@matsya>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YXVn3w1vRvPp0xY4@matsya>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 24, 2021 at 07:34:15PM +0530, Vinod Koul wrote:
> Hello Greg,
> 
> Please pull to receive updates for SoundWire subsystem. Things seems
> settling down now, odd updates for core and qcom driver.
> 
> The following changes since commit 6880fa6c56601bb8ed59df6c30fd390cc5f6dd8f:
> 
>   Linux 5.15-rc1 (2021-09-12 16:28:37 -0700)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/vkoul/soundwire.git tags/soundwire-5.16-rc1

Pulled and pushed out, thanks.

greg k-h
