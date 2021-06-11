Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F3FB23A3E56
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jun 2021 10:52:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231287AbhFKIyb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Jun 2021 04:54:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:58936 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229598AbhFKIya (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jun 2021 04:54:30 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id ADEFD611CD;
        Fri, 11 Jun 2021 08:52:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1623401553;
        bh=tSRJjIwG/QgBb7GxFKFKOXgGB5RabO7dt8t53VmIwuU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ugtD9XdJvUejv5DjP+gkkwpltqHWkAuhMFb5WbAg9Svax66UnFFesGmXXbisTluVC
         l5pzMoe1pAx8G+j1cUiFToprGNMjA8GmHoZnuJme6xujF9HM6vpwsnRp6XIpRtHpkq
         Xqw9d0T3siJkUTO7xntbEe6Q0duHxoxcRus7N52M=
Date:   Fri, 11 Jun 2021 10:52:30 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Jiri Prchal <jiri.prchal@aksignal.cz>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Christian Eggers <ceggers@arri.de>,
        Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v9 4/5] nvmem: eeprom: at25: export FRAM serial num
Message-ID: <YMMkTj5V14P70vWE@kroah.com>
References: <20210611052652.7894-1-jiri.prchal@aksignal.cz>
 <20210611052652.7894-5-jiri.prchal@aksignal.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210611052652.7894-5-jiri.prchal@aksignal.cz>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 11, 2021 at 07:26:51AM +0200, Jiri Prchal wrote:
> This exports serial number of FRAM in sysfs file named "sernum".
> Formatted in hex, each byte separated by space.
> Example:
> $ cat /sys/class/spi_master/spi0/spi0.0/sernum
> ef cd ab 89 67 45 23 01

Again, add the Documentation update to this commit so it can be reviewed
easier.

thanks,

greg k-h
