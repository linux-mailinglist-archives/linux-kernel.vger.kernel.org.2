Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D6D33595EF
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Apr 2021 08:59:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233462AbhDIG7t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Apr 2021 02:59:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:41006 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233333AbhDIG7q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Apr 2021 02:59:46 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6BAD9610FC;
        Fri,  9 Apr 2021 06:59:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1617951574;
        bh=HMjg5B+gYovTbn8z0jGFU4cHQNwYP6uHFynnln3Fr24=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=NsfSqKqAlJ/bnaUYOUB/z6LMFCWpSpuLAxgYBTTJc7y7PQLHw20qJAMcpNvj3Jj0Y
         eEYRE25xIFWcymhTHX624rD+GEYP145uNq5fKpvFQe9GtwwDdLprUicgt4gX0sSBU1
         eD0BsKM/422ROerdd2AFX/K6lwd64kmzCrir8/GI=
Date:   Fri, 9 Apr 2021 08:59:31 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Gioh Kim <gi-oh.kim@ionos.com>, linux-kernel@vger.kernel.org,
        ndesaulniers@google.com, dan.j.williams@intel.com,
        laniel_francis@privacyrequired.com, keescook@chromium.org,
        dja@axtens.net, haris.iqbal@ionos.com, jinpu.wang@ionos.com
Subject: Re: [PATCH v4] lib/string: Introduce sysfs_streqcase
Message-ID: <YG/7U4RtfnLO9i4Y@kroah.com>
References: <20210408130605.541796-1-gi-oh.kim@ionos.com>
 <20210408220502.8126bc2f278b5199707ec122@linux-foundation.org>
 <YG/315XLSIZG2bCU@kroah.com>
 <20210408235132.e62ace3277fd46f123f5ff1b@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210408235132.e62ace3277fd46f123f5ff1b@linux-foundation.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 08, 2021 at 11:51:32PM -0700, Andrew Morton wrote:
> On Fri, 9 Apr 2021 08:44:39 +0200 Greg Kroah-Hartman <gregkh@linuxfoundation.org> wrote:
> 
> > On Thu, Apr 08, 2021 at 10:05:02PM -0700, Andrew Morton wrote:
> > > On Thu,  8 Apr 2021 15:06:05 +0200 Gioh Kim <gi-oh.kim@ionos.com> wrote:
> > > 
> > > > As the name shows, it checks if strings are equal in case insensitive
> > > > manner.
> > > 
> > > Peh.  Who would die if we simply made sysfs_streq() case-insensitive?
> > 
> > I doubt anyone, let's do that instead.
> 
> There's a risk that people will write scripts/config/etc on a 5.13+
> kernel and then find that they malfunction on earlier kernels...
> 

That's not a regression, that is a "newer kernels have newer features"
issue :)
