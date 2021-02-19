Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B444331F930
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Feb 2021 13:14:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230337AbhBSMNl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Feb 2021 07:13:41 -0500
Received: from mail.kernel.org ([198.145.29.99]:41504 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230283AbhBSMNc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Feb 2021 07:13:32 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id A737E64EB4;
        Fri, 19 Feb 2021 12:12:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1613736772;
        bh=27G0mHrkiKn+ATMAMSd0f3I4UspBzL+n7VxlYry3kvc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=H8UHaXPmNDmP5agVP8Pxg2g4m3sNrh0Yo8Xie4eBlDCkmIU1is8yb/xaeS4wpk4CS
         0irBoIgccAVvLo1wzZT645BAQDXfF4uZCt4Zkz9cDyb0X4mZgzSwAXgHfZFE3Q3Vdo
         uM9ju6uKVQwaWDAefC53Qd6qmP1mMEE1eglrCtaU=
Date:   Fri, 19 Feb 2021 13:12:49 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Amrit Khera <amritkhera98@gmail.com>
Cc:     arve@android.com, tkjos@android.com, maco@android.com,
        joel@joelfernandes.org, christian@brauner.io, hridya@google.com,
        surenb@google.com, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] staging: android: Fix const keyword style issue in
 ashmem.c
Message-ID: <YC+rQZoFaT+mPxVL@kroah.com>
References: <20210219114237.5720-1-amritkhera98@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210219114237.5720-1-amritkhera98@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 19, 2021 at 05:12:38PM +0530, Amrit Khera wrote:
> This change fixes a checkpatch warning for "struct file_operations
> should normally be const".
> 
> Signed-off-by: Amrit Khera <amritkhera98@gmail.com>
> ---
> Changes in v2:
>  - Wrapped the commit description
>  - Build tested

If you tested it, what changed in the diff itself?  Looks the same to
me...

