Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A6D33C9D0D
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jul 2021 12:45:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241611AbhGOKsj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jul 2021 06:48:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:57286 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229973AbhGOKsi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jul 2021 06:48:38 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2E45561396;
        Thu, 15 Jul 2021 10:45:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1626345945;
        bh=T66R0OB1WXAKcVmohUgrzKvoFRy8UzPsQdIv3/R01Us=;
        h=Date:From:To:Subject:References:In-Reply-To:From;
        b=zsKDmfVaRnBLTqmH+C9TmK9YpBm0AS+3xlYbdujhO4Wq4EI1fv8b743ncUKvbuJVl
         mq43SQuH3NIFbLyUXmRWuNrMNETvNzPgFm2YKn34AKJeAQtWbDc5crgNzyJZ52EERz
         /E5AM+L8JfDncfZ7fShxQt5reE/tidimn0HjfpVw=
Date:   Thu, 15 Jul 2021 12:45:38 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org, Hui Wang <hui.wang@canonical.com>
Subject: Re: [PATCH 5.10 187/593] ACPI: resources: Add checks for ACPI IRQ
 override
Message-ID: <YPAR0qVkTCTgCOJl@kroah.com>
References: <20210712060903.591188609@linuxfoundation.org>
 <YO/2oiphnFdacyIN@audible.transient.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YO/2oiphnFdacyIN@audible.transient.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 15, 2021 at 08:49:38AM +0000, Jamie Heilman wrote:
> Greg Kroah-Hartman wrote:
> > From: Hui Wang <hui.wang@canonical.com>
> > 
> > [ Upstream commit 0ec4e55e9f571f08970ed115ec0addc691eda613 ]
> > 
> > The laptop keyboard doesn't work on many MEDION notebooks, but the
> > keyboard works well under Windows and Unix.
> 
> This patch makes my EPIA VIA Esther system stop booting correctly.
> Reverting it returns things to normal operation.  The symptoms are
> pretty strange.  When the kernel hands off to init I get none of the
> usual output from userspace, but I still get the occasional message
> from the kernel as modules load.  Despite some processes continuing on
> in the background, I'm never able to ssh into the host, and it never
> displays a getty on serial console like it should.  Sending a break
> and a command key over serial doesn't work like it should either.
> I've found I was able to somewhat get a little bit of IO if I plugged
> in a keyboard or unplugged it, like just jiggling the handle of the
> usb hot plug routines was enough to get my system to reboot so I only
> had to resort to hard resets a few times.  At any rate, maybe this
> patch wasn't really ready for stable.

Do you also have the same problem with 5.14-rc1?

thanks,

greg k-h
