Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D5A8236045B
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Apr 2021 10:35:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231700AbhDOIf2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Apr 2021 04:35:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:33326 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230090AbhDOIfZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Apr 2021 04:35:25 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 24073601FD;
        Thu, 15 Apr 2021 08:35:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1618475701;
        bh=8QUuqpA7nbNGk3YzMcAbRg8vAX4zEmHRY5lwyMMpeLs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=mhnkGNtK9NV0W0N6DL46mPQVNA1II/S2zRQX9QfWfR/9TYJjG+nHgooLzTe2mTW/Y
         6hqyUeImYxZEQfMVwTiI9UV45qScSePtFoJwg1/4NObt1d4C1vBT6sT4NoIk8NjCmW
         svmrS+lJ2n3W5tfYj7bweOp3DOxnTt62t+Pxurh8=
Date:   Thu, 15 Apr 2021 10:34:59 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/7] stm class: Replace uuid_t with plain u8 uuid[16]
Message-ID: <YHf6s2r28XOtP2+2@kroah.com>
References: <20210414171251.14672-1-alexander.shishkin@linux.intel.com>
 <20210414171251.14672-3-alexander.shishkin@linux.intel.com>
 <YHcnckePpKDujCU+@kroah.com>
 <YHcqxMLR44laX2PZ@smile.fi.intel.com>
 <YHc68v7keeITnA3K@kroah.com>
 <87sg3sfzl1.fsf@ashishki-desk.ger.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87sg3sfzl1.fsf@ashishki-desk.ger.corp.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 14, 2021 at 10:14:34PM +0300, Alexander Shishkin wrote:
> Greg Kroah-Hartman <gregkh@linuxfoundation.org> writes:
> 
> >> Using raw buffer APIs against uuid_t / guid_t.
> >
> > So you want to do that, or you do not want to do that?  Totally
> > confused,
> 
> My understanding is that:
> 1) generate_random_uuid() use is allegedly bad even though it's in their
> header,
> 2) poking directly at the byte array inside uuid_t is bad, even though,
> again, header.
> 
> It is, indeed, not ideal.
> 
> If agreeable, I'll update this patch to the below and respin the whole
> series.

You are showing that Andy wrote this, when you are the one that did :(

Anyway, I've dropped this single patch from the series and applied the
rest.  Feel free to send this patch as a stand-alone one once you have
the authorship issues sorted out.

thanks,

greg k-h
