Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 491B93070B2
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jan 2021 09:09:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231822AbhA1IIZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jan 2021 03:08:25 -0500
Received: from mail.kernel.org ([198.145.29.99]:39102 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232370AbhA1ICX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jan 2021 03:02:23 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id B1C4964DD6;
        Thu, 28 Jan 2021 08:01:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1611820902;
        bh=WrlsGz++54Gzgwjtd4KIQGOX6cc9XAs7lUylJv5Y3/Q=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=QgwYtip63HZsCDT7GQiKY6iw7fHfh3z2ES3aMq9Ac17Wsk1V/B9Ne6QqFWit3mLH9
         G7nTbHDYqSy6xZtdm4YBe11QZOe/l1clXc/+0i04tNETQfLGXQB8MhG16swS7Z/2a2
         4LX6USVew5GdBv0cCNF7tgpSEb1EkhYtp/luW+uc=
Date:   Thu, 28 Jan 2021 09:01:38 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Tom Rix <trix@redhat.com>
Cc:     richard.gong@linux.intel.com, mdf@kernel.org,
        linux-kernel@vger.kernel.org, Richard Gong <richard.gong@intel.com>
Subject: Re: [PATCHv1] firmware: stratix10-svc: reset
 COMMAND_RECONFIG_FLAG_PARTIAL to 0
Message-ID: <YBJvYqh2JaYKImEt@kroah.com>
References: <1611783801-30766-1-git-send-email-richard.gong@linux.intel.com>
 <1611783801-30766-2-git-send-email-richard.gong@linux.intel.com>
 <0c4ec1b0-120e-5704-4b4f-d4255f2e84c0@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0c4ec1b0-120e-5704-4b4f-d4255f2e84c0@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 27, 2021 at 02:00:06PM -0800, Tom Rix wrote:
> 
> On 1/27/21 1:43 PM, richard.gong@linux.intel.com wrote:
> > From: Richard Gong <richard.gong@intel.com>
> >
> > Clean up COMMAND_RECONFIG_FLAG_PARTIAL flag by resetting it to 0, which
> > aligns with the firmware settings.
> 
> For fixes, you need to have a 'Fixes: ... ' line in the comment.
> 
> This lets folks doing the stable branch know how far back to apply the fix.

It is a nice hint, but not always needed, and is NOT how to trigger a
patch to be backported to stable kernels.  Please read the documentation
on how to properly do that.

thanks,

greg k-h
