Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8BEBB447F73
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Nov 2021 13:22:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236670AbhKHMYy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Nov 2021 07:24:54 -0500
Received: from mail.kernel.org ([198.145.29.99]:35818 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232912AbhKHMYx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Nov 2021 07:24:53 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2534160FDA;
        Mon,  8 Nov 2021 12:22:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1636374129;
        bh=Yl2R0y7pxCQ0xb5hoZzKXpXsuW1sVQgECOa9MTTn6z4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=LSFYRik9NDCCZIQ2CvGfpO+twDXA6MvDR2lhAd6iyB7KWbKYQNR5Nk4/QV39exvK8
         i7SBR5KTJb7mxQFTFfJwrBtvREpLvx5K/KJ35aduaWq89RLLuHTkhJ6uqXnUWCFjO9
         egdJHXLLrzPSqaCRpq+tmMC4GavLNIDFC7oJapm8=
Date:   Mon, 8 Nov 2021 13:22:07 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Ajay Garg <ajaygargnsit@gmail.com>
Cc:     andy@kernel.org, Kees Cook <keescook@chromium.org>,
        akpm@linux-foundation.org, adobriyan@gmail.com,
        Nick Desaulniers <ndesaulniers@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-hardening@vger.kernel.org
Subject: Re: RFC for a new string-copy function, using mixtures of strlcpy
 and strscpy
Message-ID: <YYkWb4GQAAtZJNsT@kroah.com>
References: <CAHP4M8X1ABEhu8kGtRSJHeqQ_m627hNT_N3Q_GGdcr3W_Rfspw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHP4M8X1ABEhu8kGtRSJHeqQ_m627hNT_N3Q_GGdcr3W_Rfspw@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 08, 2021 at 08:46:01AM +0530, Ajay Garg wrote:
> Hello everyone.
> 
> I recently came across the functions strlcpy and strscpy, and it seems
> something is missing/unclean.
> 
> This email is a RFC for another function, by the name "strlscpy".

Wait, why?  We have recently added new string copy functions to resolve
the type of issues you have pointed out.  The kernel is not yet
converted to use them, so why add yet-another-function that also is not
used?

I think you should work with the functions we have _first_ and help
convert the kernel to use them, before adding another one please.

thanks,

greg k-h
