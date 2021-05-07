Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B9B4937621E
	for <lists+linux-kernel@lfdr.de>; Fri,  7 May 2021 10:34:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236321AbhEGIef (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 May 2021 04:34:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:33458 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234870AbhEGIeb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 May 2021 04:34:31 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2D3816113E;
        Fri,  7 May 2021 08:33:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1620376411;
        bh=PLCTXmiXTvM3LLyImsS6YcOvyRq3ZlDNL6qwvK21Ar8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=TZmEi7eRdmru6CdI4pnvjn5NQmvHYddJmm5yzM7hjEkJWg3ikurDrQiDXhDzhrMFU
         ZwWGcL4i5iNrfYfzPJGvBCEyoLz9umdX5a/lB9ZwrOW1Yq0nNzZLO1E5H4zEQgi+zV
         TtZSh3uQzzNo+2ntqMogBOujGnclX6t9eZpbReJ0=
Date:   Fri, 7 May 2021 10:33:27 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     He Zhe <zhe.he@windriver.com>
Cc:     corbet@lwn.net, linux-usb@vger.kernel.org,
        linux-doc@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Subject: Re: Concern about Documentation/usb/linux-cdc-acm.inf and
 Documentation/usb/linux.inf
Message-ID: <YJT7V8DZn94F1vex@kroah.com>
References: <9d7bb262-1d0d-0961-7211-157c99add96c@windriver.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9d7bb262-1d0d-0961-7211-157c99add96c@windriver.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 07, 2021 at 04:25:48PM +0800, He Zhe wrote:
> Hello maintainers,
> 
> MLPL is found in Documentation/usb/linux-cdc-acm.inf and Documentation/usb/linux.inf.
> 
> Does this conflict with GPLv2? Anything else we need to know when using these as opensource software?

As these are to be used on WINDOWS operating systems, please consult the
owner of the copyright on those files (and operating system) (i.e.
Microsoft), if you have questions/concerns about this.

Good luck!

greg k-h
