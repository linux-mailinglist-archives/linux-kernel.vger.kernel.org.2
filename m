Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 669BD31CC2F
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Feb 2021 15:40:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230264AbhBPOju (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Feb 2021 09:39:50 -0500
Received: from mail.kernel.org ([198.145.29.99]:35580 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230377AbhBPOh7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Feb 2021 09:37:59 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 18C3F64E08;
        Tue, 16 Feb 2021 14:37:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1613486238;
        bh=vbB6s1ifJDv17sAqk4UHNOS3D8Q+83NryMR7igO9p9U=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Gv6pJQr8+2L+swIvPetVdHSyhVA/80y3EWeEiEOeNa1wnTmeK7AKqefjXOUx5PT4J
         lfQ86q/3cc1aGDOwWiwD8w/jMX9SKMEFWw0UTpWnPXiBUtPTByH8tt/9Cc4ZrnbjgV
         CBtbHt1rlKll8PG1r9oLMd5VEi7wAKkZdou/DcS0=
Date:   Tue, 16 Feb 2021 15:37:15 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/2] driver core: dd: remove deferred_devices variable
Message-ID: <YCvYm9NZmUsDfWTl@kroah.com>
References: <20210216142400.3759099-1-gregkh@linuxfoundation.org>
 <20210216142400.3759099-2-gregkh@linuxfoundation.org>
 <CAJZ5v0jeGgVv8vLZnimJXcRWZNf926Ff61mT4o4kGQ48FzyYCA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJZ5v0jeGgVv8vLZnimJXcRWZNf926Ff61mT4o4kGQ48FzyYCA@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 16, 2021 at 03:34:27PM +0100, Rafael J. Wysocki wrote:
> On Tue, Feb 16, 2021 at 3:24 PM Greg Kroah-Hartman
> <gregkh@linuxfoundation.org> wrote:
> >
> > No need to save the debugfs dentry for the "devices_deferred" debugfs
> > file (gotta love the juxtaposition), if we need to remove it we can look
> > it up from debugfs itself.
> >
> > Cc: "Rafael J. Wysocki" <rafael@kernel.org>
> > Cc: linux-kernel@vger.kernel.org
> > Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> 
> Reviewed-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Thanks for the quick review, I'll queue these up after 5.12-rc1 is out.

greg k-h
