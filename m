Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 911C7320564
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Feb 2021 13:43:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229657AbhBTMmx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 20 Feb 2021 07:42:53 -0500
Received: from mail.kernel.org ([198.145.29.99]:40142 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229476AbhBTMmv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Feb 2021 07:42:51 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 985F664DFD;
        Sat, 20 Feb 2021 12:42:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1613824930;
        bh=cSr82vkt7W3FnlpG2Kubk27WIB9eM/IHLTJFPNiD3Yc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=NQUxIbibAxGzdANWcnx7kG+koBEC6olP76L/pkRy/HZuMDMnLVn1dWEF831BjvZ8N
         3gJ8Z6r4oNnemPUhNnIN4T1LukRDBi7zPPXbmtG5tMXohT63CMuRp+iVcmCcmrdFNH
         jqnaHfs6rYOPkf/nGkNr8ZpFlZKy+Wg8PyybdSLM=
Date:   Sat, 20 Feb 2021 13:42:06 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     RajMAIN <sssraj.sssraj@gmail.com>
Cc:     devel@driverdev.osuosl.org, sfr@canb.auug.org.au,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: wimax: i2400m: add space before open parenthesis
Message-ID: <YDEDnilZFC2vBNjw@kroah.com>
References: <20210220104816.13263-1-sssraj.sssraj@gmail.com>
 <YDDuu6sRtSfWhnbY@kroah.com>
 <5dbde654-386b-2011-0020-729e41043f45@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5dbde654-386b-2011-0020-729e41043f45@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 20, 2021 at 05:58:35PM +0530, RajMAIN wrote:
> 
> On 20-02-2021 16:42, Greg KH wrote:
> > On Sat, Feb 20, 2021 at 02:48:16AM -0800, Rajesh Kumbhakar wrote:
> > > netdev.c
> > Why is this here?
> 
> You mean that filename? I thought I should mention it. Should I remove it
> and resubmit?

Please read the section entitled "The canonical patch format" in the
kernel file, Documentation/SubmittingPatches for what is needed in order
to properly describe the change.

thanks,

greg k-h
