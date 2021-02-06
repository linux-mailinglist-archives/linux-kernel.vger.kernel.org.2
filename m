Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 09A46311C00
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Feb 2021 08:47:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229609AbhBFHq6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 6 Feb 2021 02:46:58 -0500
Received: from mail.kernel.org ([198.145.29.99]:51862 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229492AbhBFHqy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Feb 2021 02:46:54 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 85C6764FBA;
        Sat,  6 Feb 2021 07:46:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1612597574;
        bh=yUYOCBeTH5VbtXJ+NRfVOolPSOtHblYZttrAmI6QgTA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=nN4J6o/TkS3NwWXFfYR0VC4AECVZduFKDddEP/miGvjDrDBepZafFzU/KGGur8bJT
         3TblSSfwkFQ0NcWZaEpJ4P8Gs9Dcmxa72xvla+agBJ0DhhSAS+g97rdlkkrtMBRvdh
         1tro8vVbhxZ7x8oaLSUyl3gZ4k+dCspeWxdzMe0BI/kTP15ABy9WB6cKw7vq/HNOPK
         rpGiY7UYMQgcc6HOw8ZUIRaV0q0lZLSIqR3lpVwnlUfvKMt+sEsy7i5z3zJFJbZ5DJ
         amsxzRikqXqYSQgeKrZm3Cuf6lozCu0aWne93PgMwvDGHO3i+dAqp5C+7P24q9OOV/
         JP/VWAM+wyMsg==
Date:   Sat, 6 Feb 2021 15:46:10 +0800
From:   Peter Chen <peter.chen@kernel.org>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Pawel Laszczak <pawell@cadence.com>, peter.chen@nxp.com,
        dan.carpenter@oracle.com, colin.king@canonical.com,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org, kurahul@cadence.com
Subject: Re: [PATCH] usb: cdnsp: Removes some useless trace events
Message-ID: <20210206074610.GA2648@b29397-desktop>
References: <20210204092035.32424-1-pawell@cadence.com>
 <YBvMENpo3OTp5vrj@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YBvMENpo3OTp5vrj@kroah.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21-02-04 11:27:28, Greg KH wrote:
> On Thu, Feb 04, 2021 at 10:20:35AM +0100, Pawel Laszczak wrote:
> > Patch removes some useless trace events that can
> > be replaced by ftrace.
> > 
> > Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
> > Signed-off-by: Pawel Laszczak <pawell@cadence.com>
> > ---
> >  drivers/usb/cdns3/cdnsp-ep0.c    |  5 -----
> >  drivers/usb/cdns3/cdnsp-gadget.c |  2 --
> >  drivers/usb/cdns3/cdnsp-ring.c   |  1 -
> >  drivers/usb/cdns3/cdnsp-trace.h  | 10 ----------
> >  4 files changed, 18 deletions(-)
> 
> Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

Applied, thanks Pawel.

-- 

Thanks,
Peter Chen

