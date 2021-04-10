Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C7B235ADC7
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Apr 2021 15:48:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234684AbhDJNst (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Apr 2021 09:48:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:42216 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234180AbhDJNsm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Apr 2021 09:48:42 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id D32FC610A7;
        Sat, 10 Apr 2021 13:48:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1618062508;
        bh=BV9vwcodbAKeTvV83HkpyUEzg0GvejpCEcxYAY2s9/w=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=VqL5by2vI075Osno2/+I6lG7twNASIjNQ4RIfekAGdZ0tvRKa+V295U4rYRgZeuwk
         0HVEI/2TuTUF1+yYPLz/Xnu2cv3jQpabdjzNlwZBWm5Sy/G1eMCaAqlHxE+eSpu8qq
         0Lt6dBQTf605WufbqtpFntSGI42aL/5z7ujEfiyk=
Date:   Sat, 10 Apr 2021 15:48:26 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Mitali Borkar <mitaliborkar810@gmail.com>
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        outreachy-kernel@googlegroups.com, mitali_s@me.iitr.ac.in
Subject: Re: [PATCH v2] staging: rtl8192e: fixed pointer error by adding '*'
Message-ID: <YHGsqpNPPw+yZN12@kroah.com>
References: <YHGhdtldqAlRsPHT@kali>
 <YHGksKltkkmaUeAk@kroah.com>
 <YHGqBLS+IcHdkI6r@kali>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YHGqBLS+IcHdkI6r@kali>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 10, 2021 at 07:07:08PM +0530, Mitali Borkar wrote:
> On Sat, Apr 10, 2021 at 03:14:24PM +0200, Greg KH wrote:
> > On Sat, Apr 10, 2021 at 06:30:38PM +0530, Mitali Borkar wrote:
> > > Fixed Comparison to NULL can be written as '!...' by replacing it with
> > > simpler form i.e. boolean expression. This makes code more readable
> > > alternative.
> > > Reported by checkpatch.
> > 
> > Checkpatch did not report this specific problem, Julia did :)
> > 
> > And this changelog text does not reflect the commit you made here.
> > 
> Making the changes now.
> 
> > > 
> > > Signed-off-by: Mitali Borkar <mitaliborkar810@gmail.com>
> > 
> > We need a "Reported-by:" line here to reflect that someone reported the
> > problem as well.
> >
> I am resending this as patch v3. I have to add reprted by Julia, right?

Yes please.
