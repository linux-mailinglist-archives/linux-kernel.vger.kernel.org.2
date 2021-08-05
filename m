Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 77E443E1353
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Aug 2021 12:58:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240609AbhHEK7F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Aug 2021 06:59:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:51332 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240080AbhHEK7E (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Aug 2021 06:59:04 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id C4BF5610CC;
        Thu,  5 Aug 2021 10:58:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1628161130;
        bh=W5+8fOY46ERocNkBVQLYJeWbPtwbDFyp6xF/ik8h/eM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=1jsVLZwZ58FQkjNBQRcEM5qgjbwjB6z6jei1avtf1LG6AbM7JyCWX1x/rpZ3vpJo3
         qd1CIWmtgof+cxjrxI3WPi1+CuKpg+wd1VxGpGWe7pFh+kFy5L9Ij9dw97tyas20PV
         7YES607a+ZXIbHjVs2/OlRZKulfaieBp2Rhq+2Nc=
Date:   Thu, 5 Aug 2021 12:58:44 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Larry Finger <Larry.Finger@lwfinger.net>
Cc:     phil@philpotter.co.uk, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 00/10] Various cleanups of driver
Message-ID: <YQvEZDF6DiBxZv38@kroah.com>
References: <20210803135223.12543-1-Larry.Finger@lwfinger.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210803135223.12543-1-Larry.Finger@lwfinger.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 03, 2021 at 08:52:13AM -0500, Larry Finger wrote:
> This set of patches removes some wrappers around simple actions,
> and replaces some of the home-built bit manipulation macros.
> 
> Signed-off-by: Larry Finger <Larry.Finger@lwfinger.net>
> 
> 
> Larry Finger (10):
>   staging: r8188eu: Remove wrappers for kalloc() and kzalloc()
>   staging: r8188eu: Remove wrapper around vfree
>   staging: r8188eu: Remove wrappers for atomic operations
>   staging: r8188eu: Remove 4 empty routines from os_sep/service.c
>   staging: r8188eu: Remove all calls to _rtw_spinlock_free()
>   staging: r8188eu: Remove more empty routines
>   staging: r8188eu: Remove rtw_division64()
>   staging: r8188eu: Remove wrapper around do_div
>   staging: r8188eu: Remove some unused and ugly macros
>   staging: r8188eu: Remove some bit manipulation macros

Portions of this series applied, again, can you rebase and resend?

thanks,

greg k-h
