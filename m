Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E3C2031DB8C
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Feb 2021 15:38:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233501AbhBQOhv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Feb 2021 09:37:51 -0500
Received: from mail.kernel.org ([198.145.29.99]:45616 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233492AbhBQOhs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Feb 2021 09:37:48 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 02BB764E02;
        Wed, 17 Feb 2021 14:37:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1613572628;
        bh=O5veh4OELfkyBJQ1B2KxNysd80YQUjhIRZwEUI8Oz20=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=YeCi/2wBslmEOMzRks85JVxgVPWqdo4YKErEQi2CCEUexokprnqMCU1evQFYvnadS
         pVp2nZpeqxwFjQ1EXxpaod0eW5DWgXsiU9lDaDzwn1TApW/uS267cDuTcG9rLoinPo
         lEiyZxclmhu3V+HXfis089DfuM9HsbJwV31pdd5M=
Date:   Wed, 17 Feb 2021 15:37:04 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Sean Behan <codebam@riseup.net>
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        nathan@kernel.org, Kumar Kartikeya Dwivedi <memxor@gmail.com>,
        Colin Ian King <colin.king@canonical.com>,
        Alex Dewar <alex.dewar90@gmail.com>
Subject: Re: [PATCH] staging: emxx_udc: remove unused variable driver_desc
Message-ID: <YC0qECFf+05Flik0@kroah.com>
References: <20210217142420.7350-1-codebam@riseup.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210217142420.7350-1-codebam@riseup.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 17, 2021 at 09:24:17AM -0500, Sean Behan wrote:
> When building with W=1, there is a warning that this variable is unused.
> 
> It is not used so remove it to fix the warning.
> 
> Thanks to nathan@kernel.org for helping me submit my first patch.

This is nice, but is it needed in the changelog text?  Please put it
below the --- line when you resend.

thanks,

greg k-h
