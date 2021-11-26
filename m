Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C32245F0C5
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Nov 2021 16:34:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378160AbhKZPhs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Nov 2021 10:37:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354716AbhKZPfm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Nov 2021 10:35:42 -0500
X-Greylist: delayed 417 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 26 Nov 2021 07:26:41 PST
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C18FC0613FA
        for <linux-kernel@vger.kernel.org>; Fri, 26 Nov 2021 07:26:40 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id C7521CE207B
        for <linux-kernel@vger.kernel.org>; Fri, 26 Nov 2021 15:19:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70B47C93056;
        Fri, 26 Nov 2021 15:19:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1637939979;
        bh=qnE9XhOI+WA69G+x+qp5Q1uA10N0T/D7GpkOFZQsNu4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=QyPvqt8ZFjeQWy/cUU3eZInE7W0DHqevjxoaD/0G4Hms9a3f6s1tmJsu7E8A3om4I
         jnRRLEDRt/60c8Ct1/J3C/YUaILfkREViN8bEhRpUec412lyq5CUMt1y0wEP5Sm96q
         xbkZApNanCCnpYYDsZPRwRaIS3874+/LWGX+4sPc=
Date:   Fri, 26 Nov 2021 16:19:36 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/1] include/linux/byteorder/generic.h: fix index
 variables
Message-ID: <YaD7CGtEO2kfx80P@kroah.com>
References: <20210523204958.64575-1-xypron.glpk@gmx.de>
 <bbc73df5-acda-5577-2cfd-ee8c8e1018c3@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bbc73df5-acda-5577-2cfd-ee8c8e1018c3@gmx.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 27, 2021 at 08:27:42PM +0200, Heinrich Schuchardt wrote:
> On 5/23/21 22:49, Heinrich Schuchardt wrote:
> > In cpu_to_be32_array() and be32_to_cpu_array() the length of the array is
> > given by variable len of type size_t. An index variable of type int is used
> > to iterate over the array. This is bound to fail for len > INT_MAX and
> > lets GCC add instructions for sign extension.
> > 
> > Correct the type of the index variable.
> > 
> > Signed-off-by: Heinrich Schuchardt <xypron.glpk@gmx.de>
> > ---
> >   include/linux/byteorder/generic.h | 4 ++--
> 
> Dear Greg,
> 
> This file is not assigned to any maintainer. Could you handle the patch?

Sure, I'll pick it up, thanks.

greg k-h
