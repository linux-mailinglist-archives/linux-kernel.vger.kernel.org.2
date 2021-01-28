Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CDF2B3070AF
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jan 2021 09:09:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231637AbhA1IFn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jan 2021 03:05:43 -0500
Received: from mail.kernel.org ([198.145.29.99]:38986 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232263AbhA1IBh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jan 2021 03:01:37 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9B6726146D;
        Thu, 28 Jan 2021 08:00:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1611820856;
        bh=7ty3YUSnGLJtJH0Qxl5H4y9j20nBh3M5j1WwTLB8qrU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=bin9V7kzgM+e/7S/ARyAmFXIu2lDpDR/JJm9HkjpOC7+qsodGW0uHX7bsvl9/4PxO
         YFDofN1zCZLdWzVjCHFzaxSE/g6WwVd3pLyOF3GwpzGRpoEAnFKtfJGvYkWf1sOdU1
         1cb9soLzGDOuXQr1FbluzY6oBCgtl1PAw/ixYD8Q=
Date:   Thu, 28 Jan 2021 09:00:52 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     richard.gong@linux.intel.com
Cc:     mdf@kernel.org, trix@redhat.com, linux-kernel@vger.kernel.org,
        Richard Gong <richard.gong@intel.com>
Subject: Re: [PATCHv1] firmware: stratix10-svc: reset
 COMMAND_RECONFIG_FLAG_PARTIAL to 0
Message-ID: <YBJvNL8MhtrFi6gL@kroah.com>
References: <1611783801-30766-1-git-send-email-richard.gong@linux.intel.com>
 <1611783801-30766-2-git-send-email-richard.gong@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1611783801-30766-2-git-send-email-richard.gong@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 27, 2021 at 03:43:21PM -0600, richard.gong@linux.intel.com wrote:
> From: Richard Gong <richard.gong@intel.com>
> 
> Clean up COMMAND_RECONFIG_FLAG_PARTIAL flag by resetting it to 0, which
> aligns with the firmware settings.
> 
> Signed-off-by: Richard Gong <richard.gong@intel.com>
> ---
>  include/linux/firmware/intel/stratix10-svc-client.h | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)

<formletter>

This is not the correct way to submit patches for inclusion in the
stable kernel tree.  Please read:
    https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html
for how to do this properly.

</formletter>
