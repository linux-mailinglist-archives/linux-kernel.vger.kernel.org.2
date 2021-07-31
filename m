Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 414CE3DC395
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Jul 2021 07:37:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234849AbhGaFhn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 31 Jul 2021 01:37:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:39154 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229766AbhGaFhj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 31 Jul 2021 01:37:39 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id E8F9E60F12;
        Sat, 31 Jul 2021 05:37:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1627709853;
        bh=S3uexazbecHE/Hgv8ReBZYx8s/DUibwfmrnN3y8zAw4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=wKqnh8WuJcKmWLQ2YEjFxgGx+a9IkBBsZSypBE3jI3KuAubPDIU98J7BsvV+4EyH5
         2nY/tea7JezudGybI3Ly/3LOvCrYcEM0y6tVczrbFY7i0NHPnvrOZpbKWfXo4+sLTc
         n/exC2QoGvjcL8958RCgYdHv5uMLEKIVcftCQCbI=
Date:   Sat, 31 Jul 2021 07:37:31 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Larry Finger <Larry.Finger@lwfinger.net>
Cc:     LKML <linux-kernel@vger.kernel.org>, linux-staging@lists.linux.dev
Subject: Re: kernel BUG in new r8188eu
Message-ID: <YQThm1A0Up1m4l1S@kroah.com>
References: <80042e9f-6811-38f3-010b-1c0951ba88db@lwfinger.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <80042e9f-6811-38f3-010b-1c0951ba88db@lwfinger.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 30, 2021 at 02:59:44PM -0500, Larry Finger wrote:
> Greg,
> 
> When I unplug the USB device with the driver loaded, I get the following BUG
> and my laptop freezes:
> 
> kernel: BUG: unable to handle page fault for address: ffffeb0200043248
> kernel: #PF: supervisor read access in kernel mode
> kernel: #PF: error_code(0x0000) - not-present page
> 
> The traceback points to a kfree() call. I do not understand this BUG. Can
> you explain what happens?

Is this a new regression due to the recent cleanups, or something that
has always been here?

As for the error, looks like someone is reading to an address that is
in userspace without doing the proper copy_from_user() thing.  Do you
have a full traceback?

> I think I know how to avoid the BUG, but that might be at the expense of a
> memory leak.

That shouldn't be needed :)

thanks,

greg k-h
