Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 58A9130C387
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Feb 2021 16:21:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235498AbhBBPVQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Feb 2021 10:21:16 -0500
Received: from mail.kernel.org ([198.145.29.99]:39414 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235362AbhBBPQz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Feb 2021 10:16:55 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id E058A64E92;
        Tue,  2 Feb 2021 15:12:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1612278730;
        bh=VRH2C0TY3lxQuEhgXygRxDPh4HvH/WNv/bFZptFtF3Q=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=JzPHEWLj8euF7GFM34LeaQylk8IkT7ug59aHh6+3N4c1MzkYtIZLVmz6b0aI1g92w
         hqCz8Gv2uD0ocKjF2qMwmfGJaNku4vkzeapUPHfKK6mvGaLpV+uHcEHHqgEFIvrES8
         JrYpJDWBN5cN3D/20zMAxZh2QR3uM6TGM8mZQ3dg=
Date:   Tue, 2 Feb 2021 16:11:50 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Benson Leung <bleung@google.com>
Cc:     enric.balletbo@collabora.com, bleung@chromium.org,
        bleung@kernel.org, linux-usb@vger.kernel.org, pmalani@chromium.org,
        linux-kernel@vger.kernel.org
Subject: Re: [GIT PULL] Immutable Branch between platform/chrome and USB for
 v5.12 merge window
Message-ID: <YBlrtkhqrV5ZkETP@kroah.com>
References: <YBkH6wO07sxRDBDo@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YBkH6wO07sxRDBDo@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 02, 2021 at 12:06:03AM -0800, Benson Leung wrote:
> Hi Greg,
> 
> The following changes since commit 29b01295a829fba7399ee84afff4e64660e49f04:
> 
>   usb: typec: Add typec_partner_set_pd_revision (2021-02-01 15:31:34 +0100)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/chrome-platform/linux.git tags/tag-ib-usb-typec-chrome-platform-cros-ec-typec-changes-for-5.12

Now pulled into my tree, thanks!

greg k-h
