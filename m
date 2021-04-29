Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B681B36EEE3
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Apr 2021 19:28:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240894AbhD2R2w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Apr 2021 13:28:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:45640 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233333AbhD2R2t (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Apr 2021 13:28:49 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id AD5DC608FE;
        Thu, 29 Apr 2021 17:28:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1619717282;
        bh=OoQJKB83HnzbY/eN0bI2lGRzA4q7AjhTvKfTORo9j7Q=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=01bV59mrRF/mdiIFh8jMUQdvUk5/dVVKEC3g6QmpTPS/Ww/PlglhQnCxLcHHiMh+f
         BM8snqxoFAa2YVX5lbK6A/INJSVMHkTLYlGGk+gKloX+pfSynjw9aUvuG3lxqSwhch
         cowyS3UF9BXQ1OnVqhypV+kWH2cn/ZFvr1pzmxjo=
Date:   Thu, 29 Apr 2021 19:27:59 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Phillip Susi <phill@thesusis.net>
Cc:     rafael@kernel.org, jeyu@kernel.org, linux-kernel@vger.kernel.org,
        msekleta@redhat.com, Peter Rajnoha <prajnoha@redhat.com>
Subject: Re: [PATCH 1/2] kobject: return error code if writing
 /sys/.../uevent fails
Message-ID: <YIrsn98AFX3y6SDT@kroah.com>
References: <20181205112745.12276-2-prajnoha@redhat.com>
 <878s515hbp.fsf@vps.thesusis.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <878s515hbp.fsf@vps.thesusis.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 29, 2021 at 09:40:08AM -0400, Phillip Susi wrote:
> Just an FYI, I've been tracking down a bug that was causing the debian
> bullseye installer to immediately crash and reboot the xen domU and
> bisected it to this commit.  It appears that the Xen Virtual Keyboard
> driver ( and at least one other, probably more ) were always broken and
> failed to trigger the udev event, but this was never noticed.  When this
> patch returned the error code, it caused the d-i init scripts triggering
> coldplug events to fail, which caused init to bail out, causing a kernel
> panic.
> 
> In the future, when fixing error returns like this, could you please add
> a big fat printk so that hopefully things that always should have failed
> but didn't and now do can get noticed and fixed more quickly.
> 
> https://bugzilla.kernel.org/show_bug.cgi?id=207695
> https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=983357
> 

Spaming kernel logs with things that userspace can trigger is generally
a bad idea.  But I understand the pain here, sorry to hear it.

Was the offending drivers ever fixed?

thanks,

greg k-h
