Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 09DFD36C5A2
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Apr 2021 13:53:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235952AbhD0Lyd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Apr 2021 07:54:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:58240 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230365AbhD0Lyc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Apr 2021 07:54:32 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id F37AA600D1;
        Tue, 27 Apr 2021 11:53:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1619524429;
        bh=zOdZ8wsIcX3Guq2MFUQ/w40b2my/1WULT2eP1PNk4Bg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=A7c/hbXp8yGMKstemc0QqvdbEhnzJ9mGyE6fvOBDQxryclaFChFbrXPdxSbXmfgnm
         02Z9mcTprm+IU46UcRHOkzIpNw+N72o3XD35BZdqh88xHpHbOmqXPWEIvcq/X0pPkX
         xZMi05zCse6QPmyQ+TGxtVUFCu32xrx2f5kXKMeU=
Date:   Tue, 27 Apr 2021 13:53:46 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     linux-kernel@vger.kernel.org, Aditya Pakki <pakki001@umn.edu>,
        Mukesh Ojha <mojha@codeaurora.org>
Subject: Re: [PATCH 114/190] Revert "staging: rtl8188eu: Fix potential NULL
 pointer dereference of kcalloc"
Message-ID: <YIf7Sn6fGsrM6p2v@kroah.com>
References: <20210421130105.1226686-1-gregkh@linuxfoundation.org>
 <20210421130105.1226686-115-gregkh@linuxfoundation.org>
 <cf31b48e-25b5-bd8a-113e-64dbc96a063b@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cf31b48e-25b5-bd8a-113e-64dbc96a063b@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 21, 2021 at 06:55:59PM +0200, Hans de Goede wrote:
> Hi,
> 
> On 4/21/21 2:59 PM, Greg Kroah-Hartman wrote:
> > This reverts commit 7671ce0d92933762f469266daf43bd34d422d58c.
> > 
> > Commits from @umn.edu addresses have been found to be submitted in "bad
> > faith" to try to test the kernel community's ability to review "known
> > malicious" changes.  The result of these submissions can be found in a
> > paper published at the 42nd IEEE Symposium on Security and Privacy
> > entitled, "Open Source Insecurity: Stealthily Introducing
> > Vulnerabilities via Hypocrite Commits" written by Qiushi Wu (University
> > of Minnesota) and Kangjie Lu (University of Minnesota).
> > 
> > Because of this, all submissions from this group must be reverted from
> > the kernel tree and will need to be re-reviewed again to determine if
> > they actually are a valid fix.  Until that work is complete, remove this
> > change to ensure that no problems are being introduced into the
> > codebase.
> > 
> > Cc: Aditya Pakki <pakki001@umn.edu>
> > Cc: Mukesh Ojha <mojha@codeaurora.org>
> > Cc: Hans de Goede <hdegoede@redhat.com>
> > Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> 
> FWIW the original commit seems fine here. So if that is an option please
> drop this revert from the set.

Revert is now dropped, thanks for looking at it.

greg k-h
