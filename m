Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 03212377131
	for <lists+linux-kernel@lfdr.de>; Sat,  8 May 2021 12:27:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230397AbhEHK1q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 8 May 2021 06:27:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:54778 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230234AbhEHK1o (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 May 2021 06:27:44 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8668861107;
        Sat,  8 May 2021 10:26:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1620469603;
        bh=DvSUl04cKdEjrduzfuDLwpeh8ofSPAD1e4KGPH51WCg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=C9nq7UDLQbIC50SaELxPGinI23wLIjk7w1/9IwsgOEiyte4FXazMqUg3itNnNWr4F
         Igg4Mf33Dddrr6x+NdZC++2astH6W9hJS1oLRg4Td9dUzcTWOy6HJ+MZh2vFHpFL2y
         QCyuTUmWs35yEo1b0yORn6RZ3eevqMeHPHmIx9sg=
Date:   Sat, 8 May 2021 12:26:40 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     jroedel@suse.de, stable-commits@vger.kernel.org
Subject: Re: Patch "x86/boot/compressed/64: Check SEV encryption in the
 32-bit boot-path" has been added to the 5.12-stable tree
Message-ID: <YJZnYDty7Siyo68k@kroah.com>
References: <20210508032224.039CF613ED@mail.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210508032224.039CF613ED@mail.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 07, 2021 at 11:22:23PM -0400, Sasha Levin wrote:
> This is a note to let you know that I've just added the patch titled
> 
>     x86/boot/compressed/64: Check SEV encryption in the 32-bit boot-path
> 
> to the 5.12-stable tree which can be found at:
>     http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary
> 
> The filename of the patch is:
>      x86-boot-compressed-64-check-sev-encryption-in-the-3.patch
> and it can be found in the queue-5.12 subdirectory.
> 
> If you, or anyone else, feels it should not be added to the stable tree,
> please let <stable@vger.kernel.org> know about it.
> 
> 
> 
> commit 2c622aeb46b16fd945fc681fec16b989940b826d
> Author: Joerg Roedel <jroedel@suse.de>
> Date:   Fri Mar 12 13:38:23 2021 +0100
> 
>     x86/boot/compressed/64: Check SEV encryption in the 32-bit boot-path
>     
>     [ Upstream commit fef81c86262879d4b1176ef51a834c15b805ebb9 ]
>     
>     Check whether the hypervisor reported the correct C-bit when running
>     as an SEV guest. Using a wrong C-bit position could be used to leak
>     sensitive data from the guest to the hypervisor.
>     
>     Signed-off-by: Joerg Roedel <jroedel@suse.de>
>     Signed-off-by: Borislav Petkov <bp@suse.de>
>     Link: https://lkml.kernel.org/r/20210312123824.306-8-joro@8bytes.org
>     Signed-off-by: Sasha Levin <sashal@kernel.org>

This breaks the build (link time) for 5.12, 5.11, and 5.10 trees, so
I'll go drop it for now.

if it needs to come back, can someone submit a working version?

thanks,

greg k-h
