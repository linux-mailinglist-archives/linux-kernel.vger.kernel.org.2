Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D81423532FD
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Apr 2021 09:40:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232233AbhDCHkU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 3 Apr 2021 03:40:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:52992 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231282AbhDCHkO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Apr 2021 03:40:14 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9ACD361177;
        Sat,  3 Apr 2021 07:40:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1617435611;
        bh=SeLXz6T4CcIQOyXu4N3CLhfUFpDVaT2Qg2mT3xXx9p4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=LjvKpT9DjAoN14OtfBVwzFpTJAo2yzr7pOUvBkvH/bG+XuTTDkL9Cb3DWVStm7bEK
         uAlI+bOoLzAVEoFTThBh9782o8PYG2HbyryPN8EWyT+NH6ooNYMOcIX7rp9v5cMkbF
         EcHr2PU+DWXTsAzMPWIkuVH6GcGZwUlK3mjM8sfo=
Date:   Sat, 3 Apr 2021 09:40:08 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Fabio Aiuto <fabioaiuto83@gmail.com>
Cc:     dan.carpenter@oracle.com, joe@perches.com,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 01/30] staging: rtl8723bs: remove RT_TRACE logs in
 core/rtw_xmit.c
Message-ID: <YGgb2Mtzyp79elQ6@kroah.com>
References: <cover.1617384172.git.fabioaiuto83@gmail.com>
 <34b6f0b80cd3913722b258e9554dbc77268fb2bf.1617384172.git.fabioaiuto83@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <34b6f0b80cd3913722b258e9554dbc77268fb2bf.1617384172.git.fabioaiuto83@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 02, 2021 at 07:29:43PM +0200, Fabio Aiuto wrote:
> remove all RT_TRACE logs
> 

I don't mean to be a pain, but this changelog text needs some work.

This says _what_ it does, but not _why_ you are doing this.  The kernel
documentation has a section on how to write a good changelog text, you
might want to look at that.

For this type of series, this could be as simple as:
	Remove all of the RT_TRACE_LOGs in the rtx_xmit.c file as they
	currently do nothing as they require the code to be modified by
	hand in order to be turned on.  This obviously has not happened
	since the code was merged, so just remove them as they are
	unused.


Or something like that.

Most of the time, writing the changelog can take more work than the
actual code change itself, but it's important as we need to know what is
happening both for the reviewers, as well as people in the future who
might have to look back and try to understand the reason for specific
changes.

Can you fix up this series based on this and resend?

thanks,

greg k-h
