Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3638135AC7C
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Apr 2021 11:32:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234566AbhDJJcT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Apr 2021 05:32:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:38822 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229992AbhDJJcR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Apr 2021 05:32:17 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9A65D61165;
        Sat, 10 Apr 2021 09:32:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1618047123;
        bh=JC1u+XwPQ0Lk3zOdvJDmOnjpgGCwEAkzpUo3n6Lz3oo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=vDy4zFclyPeMotI2iwg5qx2MH4OGSC2hflgkl5gdGMrigRHMsGZxYkRLMtcSmCs2/
         8V7F0sQtS5rYS1vy6S7KhlHoafqsVKimHncvKwc5NEvJppov/HTwSAwBmtuIeijiJL
         7yoFpNnvW0IdXPzdtL100Kz2tPLQhs6M1aZg51l4=
Date:   Sat, 10 Apr 2021 11:32:00 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
Cc:     outreachy-kernel@googlegroups.com, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [Outreachy kernel] [PATCH v7 1/3] staging: rtl8723bs: Remove
 camelcase in several files
Message-ID: <YHFwkJlTNxQwPyN3@kroah.com>
References: <20210410092232.15155-1-fmdefrancesco@gmail.com>
 <20210410092232.15155-2-fmdefrancesco@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210410092232.15155-2-fmdefrancesco@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 10, 2021 at 11:22:29AM +0200, Fabio M. De Francesco wrote:
> Remove camelcase in bFwCurrentInPSMode, a variable used by code
> of several subdirectories/files of the driver. Issue detected by
> checkpatch.pl. Delete the unnecessary "b" (that stands for "byte") from
> the beginning of the name.
> 
> Signed-off-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>
> ---
> 

Why is there a "v7" in this subject line, but not all the other lines?

It should be in all of them, including the 0/X email, git format-patch
will create it automatically if you tell it to.

thanks,

greg k-h
