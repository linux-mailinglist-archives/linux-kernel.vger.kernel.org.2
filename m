Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A5D44333D3
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Oct 2021 12:47:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235207AbhJSKt5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Oct 2021 06:49:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:42380 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234955AbhJSKtz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Oct 2021 06:49:55 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 666F3610E5;
        Tue, 19 Oct 2021 10:47:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1634640462;
        bh=9m4ltT8/a7DGvFsHOhAr5758XNq5QXgulWAqKkntxyk=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=C5Mqu4CSOi37dyr+6iBk1CzNn42VSOhFPmfwzyyyii2GAHuorIZh983cVog1Zzxyj
         nSovcj0iExVa8LkUp6jv6liJjZor9eKAzHm9kJoV+0gCBre0ab6mk2oZDJbCHPa9Vb
         0TLDsoYBvD7Gnqyg6HUBHVhxwwiSVegBgVg5sNTM5/bNmX6xbnFIlzYtbl5KwCvxb1
         7ZWQpu8uMxu3ePFLmWHO7RobTsdwtLEqJgQ8vJkVHdcboHcqLWvpHc7i6MMcoNzeql
         0gs97eo8dMYYKW2qicxHXhYLlXceC2Kd08LTMtT0unySkhSGrCm7Ghwd+9hscahHjM
         W7hBZuvshNc0Q==
Message-ID: <9c339a7eb3861ebc40929f02a967ba3dd40ca19a.camel@kernel.org>
Subject: Re: [PATCH v3 17/23] docs: fs: locks.rst: update comment about
 mandatory file locking
From:   Jeff Layton <jlayton@kernel.org>
To:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>
Cc:     linux-kernel@vger.kernel.org
Date:   Tue, 19 Oct 2021 06:47:41 -0400
In-Reply-To: <1dfcade1692df5435d4f0fd8e439a6e55cf44fa6.1634630486.git.mchehab+huawei@kernel.org>
References: <cover.1634630485.git.mchehab+huawei@kernel.org>
         <1dfcade1692df5435d4f0fd8e439a6e55cf44fa6.1634630486.git.mchehab+huawei@kernel.org>
Content-Type: text/plain; charset="ISO-8859-15"
User-Agent: Evolution 3.40.4 (3.40.4-2.fc34) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2021-10-19 at 09:04 +0100, Mauro Carvalho Chehab wrote:
> The mandatory file locking got removed due to its problems, but
> the fs locks documentation still points to it.
> 
> Update the text there, informing that it was removed on Kernel
> 5.14.
> 
> Fixes: f7e33bdbd6d1 ("fs: remove mandatory file locking support")
> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> ---
> 
> To mailbombing on a large number of people, only mailing lists were C/C on the cover.
> See [PATCH v3 00/23] at: https://lore.kernel.org/all/cover.1634630485.git.mchehab+huawei@kernel.org/
> 
>  Documentation/filesystems/locks.rst | 17 +++++------------
>  1 file changed, 5 insertions(+), 12 deletions(-)
> 
> diff --git a/Documentation/filesystems/locks.rst b/Documentation/filesystems/locks.rst
> index c5ae858b1aac..26429317dbbc 100644
> --- a/Documentation/filesystems/locks.rst
> +++ b/Documentation/filesystems/locks.rst
> @@ -57,16 +57,9 @@ fcntl(), with all the problems that implies.
>  1.3 Mandatory Locking As A Mount Option
>  ---------------------------------------
>  
> -Mandatory locking, as described in
> -'Documentation/filesystems/mandatory-locking.rst' was prior to this release a
> -general configuration option that was valid for all mounted filesystems.  This
> -had a number of inherent dangers, not the least of which was the ability to
> -freeze an NFS server by asking it to read a file for which a mandatory lock
> -existed.
> -
> -From this release of the kernel, mandatory locking can be turned on and off
> -on a per-filesystem basis, using the mount options 'mand' and 'nomand'.
> -The default is to disallow mandatory locking. The intention is that
> -mandatory locking only be enabled on a local filesystem as the specific need
> -arises.
> +Mandatory locking was prior to this release a general configuration option
> +that was valid for all mounted filesystems.  This had a number of inherent
> +dangers, not the least of which was the ability to freeze an NFS server by
> +asking it to read a file for which a mandatory lock existed.
>  
> +Such option was dropped in Kernel v5.14.

Looks good. I'll plan to pick this up and (add a Reported-by for Jon,
who noted this a few days ago).

-- 
Jeff Layton <jlayton@kernel.org>

