Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA1C53A4026
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jun 2021 12:25:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231260AbhFKK1e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Jun 2021 06:27:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:54186 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229480AbhFKK1d (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jun 2021 06:27:33 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4656F61249;
        Fri, 11 Jun 2021 10:25:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1623407135;
        bh=6q3mUFSKDFTDFR++ZUsA24vSxxL0h3fhNdhjHWkD25E=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=0N37AJPlE8K6/xB5WUh4BhhQI95pMW96tGDVXm3lticGueXkKPzhH0QsBhmqh7PA2
         cF7dnisUmSUK/djCWYa1xQHb+u7Lpji57H2o9orZE+80lBvPlrZVEjqqdwX7hgqen6
         wfSFZoUcW/G3lLYn6Y/3M+U3xDlFS9t/laFjl9Zc=
Date:   Fri, 11 Jun 2021 12:25:33 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Jiri Prchal <jiri.prchal@aksignal.cz>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Christian Eggers <ceggers@arri.de>,
        Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v10 0/4] add support for FRAM
Message-ID: <YMM6Hdw5mdK8LXQe@kroah.com>
References: <20210611094601.95131-1-jiri.prchal@aksignal.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210611094601.95131-1-jiri.prchal@aksignal.cz>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 11, 2021 at 11:45:57AM +0200, Jiri Prchal wrote:
> Adds support for Cypress FRAMs.
> 
> Jiri Prchal (4):
>   nvmem: prepare basics for FRAM support
>   nvmem: eeprom: at25: add support for FRAM
>   dt-bindings: nvmem: at25: add for FRAM support
>   nvmem: eeprom: at25: export FRAM serial num
> 
>  .../ABI/testing/sysfs-class-spi-eeprom        |  19 +++
>  .../devicetree/bindings/eeprom/at25.yaml      |  31 +++-
>  drivers/misc/eeprom/Kconfig                   |   5 +-
>  drivers/misc/eeprom/at25.c                    | 161 ++++++++++++++----
>  drivers/nvmem/core.c                          |   4 +
>  include/linux/nvmem-provider.h                |   1 +
>  6 files changed, 183 insertions(+), 38 deletions(-)
>  create mode 100644 Documentation/ABI/testing/sysfs-class-spi-eeprom
> 
> -- 
> 2.25.1
> 

Looks good to me, now queued up.  Thanks for sticking with this!

greg k-h
