Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D1BC5377D9F
	for <lists+linux-kernel@lfdr.de>; Mon, 10 May 2021 10:04:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230200AbhEJIFT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 May 2021 04:05:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:36304 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229852AbhEJIFS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 May 2021 04:05:18 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id B01FF61364;
        Mon, 10 May 2021 08:04:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1620633854;
        bh=Bj86/4Et0xeTSR3tRYUNP9e0149TjoWhrpCd960Ypbc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=pS/bsb3SU93qc3spkQnToy90R3yHADzaYNt4hEfTPS77eyIJ1EFOgrCQgC6NiWzcs
         1qJGTirD7BMaLJUr3kjbuu4z8guhMpGxbZRxJOUp8yFZ9RluA+puPFBHuNhVbbIXzl
         +ANO3gxcjx8orof5BRyvX07jJcPDMzRyZas+SPJ4=
Date:   Mon, 10 May 2021 10:04:12 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     sprasad@microsoft.com, stfrench@microsoft.com, tom@talpey.com,
        stable-commits@vger.kernel.org
Subject: Re: Patch "smb3: when mounting with multichannel include it in
 requested capabilities" has been added to the 5.4-stable tree
Message-ID: <YJjo/Jevkg9s7QkC@kroah.com>
References: <162063336417115@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <162063336417115@kroah.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 10, 2021 at 09:56:04AM +0200, gregkh@linuxfoundation.org wrote:
> 
> This is a note to let you know that I've just added the patch titled
> 
>     smb3: when mounting with multichannel include it in requested capabilities
> 
> to the 5.4-stable tree which can be found at:
>     http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary
> 
> The filename of the patch is:
>      smb3-when-mounting-with-multichannel-include-it-in-requested-capabilities.patch
> and it can be found in the queue-5.4 subdirectory.
> 
> If you, or anyone else, feels it should not be added to the stable tree,
> please let <stable@vger.kernel.org> know about it.
> 
> 
> >From 679971e7213174efb56abc8fab1299d0a88db0e8 Mon Sep 17 00:00:00 2001
> From: Steve French <stfrench@microsoft.com>
> Date: Fri, 7 May 2021 18:24:11 -0500
> Subject: smb3: when mounting with multichannel include it in requested capabilities
> 
> From: Steve French <stfrench@microsoft.com>
> 
> commit 679971e7213174efb56abc8fab1299d0a88db0e8 upstream.
> 
> In the SMB3/SMB3.1.1 negotiate protocol request, we are supposed to
> advertise CAP_MULTICHANNEL capability when establishing multiple
> channels has been requested by the user doing the mount. See MS-SMB2
> sections 2.2.3 and 3.2.5.2
> 
> Without setting it there is some risk that multichannel could fail
> if the server interpreted the field strictly.
> 
> Reviewed-By: Tom Talpey <tom@talpey.com>
> Reviewed-by: Shyam Prasad N <sprasad@microsoft.com>
> Cc: <stable@vger.kernel.org> # v5.8+
> Signed-off-by: Steve French <stfrench@microsoft.com>
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

Oops, nope, dropped from 5.4.y, sorry for the noise.

greg k-h
