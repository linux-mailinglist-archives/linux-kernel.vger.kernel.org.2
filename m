Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 27A34345D7D
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Mar 2021 12:57:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230137AbhCWL5Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Mar 2021 07:57:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:56930 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229482AbhCWL4s (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Mar 2021 07:56:48 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6D48F6191F;
        Tue, 23 Mar 2021 11:56:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1616500608;
        bh=tq02Vd5NqpuFLSWzDRKQbq1PXhG1AGLHdMYDxgmkTaE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=1qz4yEgix7wGFQBvKOSXcCiEwQkrYLSh/VLIfLFo/8mItyPGjLztqoJ+LZTscswvN
         wN6sQmwZ5GFskJ6DFIGKH9T7nwoHsCT+ALz1ksuTuWizxGo53z/mwopBFPDurjEcUp
         a6BfPfxhu0mal6n7JsWQKsPAAVj3QL9/2wOx4AQk=
Date:   Tue, 23 Mar 2021 12:56:45 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Ruslan Bilovol <ruslan.bilovol@gmail.com>
Cc:     Felipe Balbi <balbi@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
        gschmottlach@gmail.com, linux-usb@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/8] USB Audio Gadget part 2: Feedback endpoint,
 Volume/Mute support
Message-ID: <YFnXfUr21JrweUoU@kroah.com>
References: <1614603943-11668-1-git-send-email-ruslan.bilovol@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1614603943-11668-1-git-send-email-ruslan.bilovol@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 01, 2021 at 03:05:35PM +0200, Ruslan Bilovol wrote:
> This is extendend version of "UAC2 Feedback endpoint" patch set
> I've sent back in 2020 [1]. It is extended with
> bi-directional Volume/Mute controls support for both UAC1
> and UAC2 gadgets.
> 
> It fixes issues with enumeration in various operation systems
> because of Feedback endpoint implementation, yet also adds
> new Volume/Mute support which allows developers to control
> UAC1/2 Gadget's Volume/Mute from the Host and in the same way
> UAC1/2 Gadget can control Volume/Mute of the Host making it
> closer to a real USB Audio card.
> 
> This patch set should be applied on top of USB Audio Gadget
> part 1 fixes/improvements that I've sent previously to the
> mailing list [2]

This series did not apply to my tree (except for the first patch).  Can
you rebase it on my usb-testing branch and resend?

thanks,

greg k-h
