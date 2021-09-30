Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1648241D314
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Sep 2021 08:11:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348240AbhI3GMN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Sep 2021 02:12:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:47620 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1347847AbhI3GML (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Sep 2021 02:12:11 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id BFA986136A;
        Thu, 30 Sep 2021 06:10:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1632982229;
        bh=77IvhJAzAOrloB5dP5qR4yYlyKDgaGo9TQFvWQS0YNA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=YW9q/rOLWdcAsTWUW+sgBFXKHlIpbfFGknMqT3jXucVqBGpEf0bXFnTF4IXnq3ImS
         SjAMHYkTkyyrKhsZ4TFzsL4YqsrSWmDGdUEvivXjcqGuPfGSUVUZIqonyOkfWs0ypV
         SrLAsww0bvsEL6g8wuHCvEHYyfcx+etk/g+4mwF0=
Date:   Thu, 30 Sep 2021 08:10:25 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Jim Cromie <jim.cromie@gmail.com>
Cc:     jbaron@akamai.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/6] dyndbg: rationalize verbosity
Message-ID: <YVVU0ZixMFzAtEMf@kroah.com>
References: <20210929183735.6630-1-jim.cromie@gmail.com>
 <20210929183735.6630-4-jim.cromie@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210929183735.6630-4-jim.cromie@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 29, 2021 at 12:37:32PM -0600, Jim Cromie wrote:
> change current v*pr_info() calls to fit this new scheme:
> 
> -1 module level activity: add/remove, etc
> -2 command ingest, splitting
>    per >control write
> -3 command parsing - many v1s here now
> -4 per-site changes - was v2
> 
> -2 is new, to isolate a problem where a stress-test script (which
> feeds large multi-command strings) would produce short writes,
> truncating last command and causing parsing errors, which confused
> test results.  The 1st fix was to use syswrite in the script, to
> deliver full proper commands.
> 
> -4 gets per-callsite "changed:" pr-infos, which are very noisy during
> stress tests, and obscure v1-3 messages.
> 
> Update docs verbose example to 3 per its comment (potential conflict here)
> 
> Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
> ---
>  .../admin-guide/dynamic-debug-howto.rst       |  2 +-
>  lib/dynamic_debug.c                           | 22 ++++++++++---------
>  2 files changed, 13 insertions(+), 11 deletions(-)
> 
> diff --git a/Documentation/admin-guide/dynamic-debug-howto.rst b/Documentation/admin-guide/dynamic-debug-howto.rst
> index b119b8277b3e..ab28d200f016 100644
> --- a/Documentation/admin-guide/dynamic-debug-howto.rst
> +++ b/Documentation/admin-guide/dynamic-debug-howto.rst
> @@ -358,7 +358,7 @@ Examples
>    // boot-args example, with newlines and comments for readability
>    Kernel command line: ...
>      // see whats going on in dyndbg=value processing
> -    dynamic_debug.verbose=1
> +    dynamic_debug.verbose=3

Did you just change the user/kernel interface here?  What happens to the
systems that were using '1' as a value?  Do they have to be changed?

Why is this needed?

thanks,

greg k-h
