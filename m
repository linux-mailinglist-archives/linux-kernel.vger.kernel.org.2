Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9EA77438EB7
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Oct 2021 07:17:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229822AbhJYFTq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Oct 2021 01:19:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:33018 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229499AbhJYFTn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Oct 2021 01:19:43 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 16F0760E96;
        Mon, 25 Oct 2021 05:17:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1635139041;
        bh=pPl/6epcFU5UtDdcWktgwNE4t7AxSpwYK6ivyQKTMcw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=LqQbuVfaCyykhxG2635IzHG1pHPGy/WyuB7ZEy3TT8IiuFUH6t88lCRKWc0eT92Ck
         /aoXwfr1RTO763CPoeZwfsdaGl81MROZa7DoOVewYAm9QmwqOzFNLPlp78XPhCNY/L
         08414zyrMv4+yLzyU2B1GMw53D1BltWt9rJ/lZv4=
Date:   Mon, 25 Oct 2021 07:17:12 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Philipp Hortmann <philipp.g.hortmann@gmail.com>
Cc:     corbet@lwn.net, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
Subject: Re: [PATCH 0/2] Docs: usb: update struct usb_driver, remove :c:func:
Message-ID: <YXY92DxK7VEXmChB@kroah.com>
References: <cover.1635138058.git.philipp.g.hortmann@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1635138058.git.philipp.g.hortmann@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 25, 2021 at 07:09:38AM +0200, Philipp Hortmann wrote:
> update struct usb_driver and remove :c:func: for usb_register and usb_deregister
> 
> Philipp Hortmann (2):
>   Docs: usb: update struct usb_driver
>   Docs: usb: remove :c:func: for usb_register and usb_deregister
> 
>  Documentation/driver-api/usb/writing_usb_driver.rst | 11 +++++++----
>  1 file changed, 7 insertions(+), 4 deletions(-)

Thanks, these look much better.  I will take them through my usb tree.

greg k-h
