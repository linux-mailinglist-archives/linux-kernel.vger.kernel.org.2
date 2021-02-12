Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E686D319C5C
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Feb 2021 11:10:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230364AbhBLKHq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Feb 2021 05:07:46 -0500
Received: from mail.kernel.org ([198.145.29.99]:46758 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230349AbhBLKG1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Feb 2021 05:06:27 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8B0F664E6C;
        Fri, 12 Feb 2021 10:05:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1613124346;
        bh=6bki0Au+K2JaECcmUHQQU+dhCdZZhRL3yqcY8rcUtsE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=b0iX8pRA6j+ZQ5YeUbwZ2KbYkIJHl4IsI2y/6G4MIDpQtX4GkbCWnnFeRwu8VYubV
         a7KWhIlPzqXtFlsYCce6DGBV+Apj7QKhUiWN+M3s+WDSgAdsDbN58E+yHmcOgBovET
         /C9tfDteHrNwrWy3357JirJUhBmuga2l7c75T6Jg0xAz5EW7SymWUqqZOAIMkZzVnh
         YMOKZPlDbnbGcyGxyuppbAyj32CGqV1sOSXq26Zn4trOTxfScP/9mFj/PsOksYIGYB
         vG2P9nqZeMKcW8430de2uMcc3Hl3s1+YqBXr0QCGHGuGVetWgJqtckpI+93iuEXNDR
         DXyRPqEC0xGOA==
Received: from johan by xi.lan with local (Exim 4.93.0.4)
        (envelope-from <johan@kernel.org>)
        id 1lAVKs-0002VJ-Ec; Fri, 12 Feb 2021 11:06:02 +0100
Date:   Fri, 12 Feb 2021 11:06:02 +0100
From:   Johan Hovold <johan@kernel.org>
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Greg KH <gregkh@linuxfoundation.org>,
        Pritthijit Nath <pritthijit.nath@icloud.com>,
        devel@driverdev.osuosl.org, elder@kernel.org, vireshk@kernel.org,
        linux-kernel@vger.kernel.org, greybus-dev@lists.linaro.org
Subject: Re: [PATCH 1/2] staging: greybus: Fixed alignment issue in hid.c
Message-ID: <YCZTCs7MU2J4F2/r@hovoldconsulting.com>
References: <20210212081835.9497-1-pritthijit.nath@icloud.com>
 <20210212090926.ox763j3btrqfzzzj@vireshk-i7>
 <YCZHsMPgyqtRMTII@kroah.com>
 <20210212092130.cxo6tuess6msf4kb@vireshk-i7>
 <YCZPzV7KiT/y//m2@hovoldconsulting.com>
 <20210212095529.2nsjc5wacegnd757@vireshk-i7>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210212095529.2nsjc5wacegnd757@vireshk-i7>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 12, 2021 at 03:25:29PM +0530, Viresh Kumar wrote:
> On 12-02-21, 10:52, Johan Hovold wrote:
> > But what will the checkpatch crew then work on?
> 
> Lol..
> 
> > Better staging than the rest of the kernel.
> 
> [ /me wondering on who stops them from sending patches for rest of the
> kernel ? ]

Ideally maintainers should at least push back when they do.

Johan
