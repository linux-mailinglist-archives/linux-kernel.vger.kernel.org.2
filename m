Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 92DFB45B63B
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Nov 2021 09:08:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241098AbhKXILl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Nov 2021 03:11:41 -0500
Received: from mail.kernel.org ([198.145.29.99]:59668 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240729AbhKXILl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Nov 2021 03:11:41 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 791C960F5B;
        Wed, 24 Nov 2021 08:08:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1637741312;
        bh=1NSSGZakyFSkH/5hGZkPw4LSekwBgb1VQXJhO1JRewU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=uRIx1CVZS07maXXavDK/97Meex4EaYeyCRXYDdJEh0Yw6LAhfDp6iYFo02Fgrlhor
         82vmxXbqCycZmwlzLkFPuddR9pICsi7x72XLdLdbA3j3/I89gH7ZYAyvkkpZBimW6W
         MFILnRiTjiKfp/PsQCGQGo8xCHApiciSfCXcnOTw=
Date:   Wed, 24 Nov 2021 09:08:29 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Todd Kjos <tkjos@google.com>
Cc:     christian@brauner.io, arve@android.com, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, maco@google.com,
        joel@joelfernandes.org, kernel-team@android.com
Subject: Re: [PATCH 0/3] binder: Prevent untranslated sender data from being
 copied to target
Message-ID: <YZ3y/aYUeC5HSXk0@kroah.com>
References: <20211123191737.1296541-1-tkjos@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211123191737.1296541-1-tkjos@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 23, 2021 at 11:17:34AM -0800, Todd Kjos wrote:
> Binder copies transactions directly from the sender buffer
> to the target buffer and then fixes up BINDER_TYPE_PTR and
> BINDER_TYPE_FDA objects. This means there is a brief time
> when sender pointers and fds are visible to the target
> process.
> 
> This series reworks the the sender to target copy to
> avoid leaking any untranslated sender data from being
> visible in the target.
> 
> Todd Kjos (3):
>   binder: defer copies of pre-patched txn data
>   binder: read pre-translated fds from sender buffer
>   binder: avoid potential data leakage when copying txn
> 
>  drivers/android/binder.c | 442 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++----------------
>  1 file changed, 387 insertions(+), 55 deletions(-)

Are these changes needed now in 5.16-final and also in stable kernels?

Or can they wait until 5.17-rc1?

thanks,

greg k-h
