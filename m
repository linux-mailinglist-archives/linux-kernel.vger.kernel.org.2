Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 30D1A3A308F
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jun 2021 18:25:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231388AbhFJQ1L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Jun 2021 12:27:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:36066 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230197AbhFJQ1J (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jun 2021 12:27:09 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 08E6B60C40;
        Thu, 10 Jun 2021 16:24:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1623342300;
        bh=WwLLfcwGZHDA7ZGpQXlP63WXRUejUeq9+2++Wn7zSP8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=WIWMv4ay18ENXTAuS3f1UbSGfY04qOBcjRirgNP8oUbh/lEb0DqKYWD4VjQc6RVzo
         LdgcXRMxC8x+NwsS11IsEbB/Tb8qn4jMRWD9+sByeGuHugCr0TgSdQLt5MSHENDkgN
         CYrXpdquvDQwDycL0s+04v4Jzqyso2k4apRNDISE=
Date:   Thu, 10 Jun 2021 18:24:57 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Philippe Dixon <philippesdixon@gmail.com>
Cc:     hdegoede@redhat.com, Larry.Finger@lwfinger.net,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/3] Fix various checkpatch.pl warnings
Message-ID: <YMI82S+F/YiO+hD0@kroah.com>
References: <cover.1623339773.git.philippesdixon@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1623339773.git.philippesdixon@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 10, 2021 at 08:51:14AM -0700, Philippe Dixon wrote:
> This patchset contains minor changes to remove some checkpatch.pl
> warnings and better follow the Linux kernel coding style
> recommendations.
> 
> Philippe Dixon (3):
>   staging: rtl8723bs: core: add blank line after variable declaration
>   staging: rtl8723bs: core: add * to each line of block comment
>   staging: rtl8723bs: core: remove whitespace from beginning of line

In the future, make your 0/X email subject line also reflect what part
of the kernel you are changing.  Something like what your commit
messages have in their subject lines would be helpful.

thanks,

greg k-h
