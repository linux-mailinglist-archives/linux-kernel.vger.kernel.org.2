Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BDD6138BFAC
	for <lists+linux-kernel@lfdr.de>; Fri, 21 May 2021 08:41:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233233AbhEUGm1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 May 2021 02:42:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232894AbhEUGhn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 May 2021 02:37:43 -0400
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2E00C061763
        for <linux-kernel@vger.kernel.org>; Thu, 20 May 2021 23:36:06 -0700 (PDT)
Received: by mail-pg1-x52f.google.com with SMTP id f22so12532306pgb.9
        for <linux-kernel@vger.kernel.org>; Thu, 20 May 2021 23:36:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=UVoSQt4bLtT7Ix7kL6FeuZytha01b8oiry7YrK+fTN8=;
        b=O0Tsv2NgoSNJGN/n8RA+0/CnX4A0Q+hDHD0wxiW/VI31W/rDazcCKXlaprXTzDBn5i
         d/gn078PqPAxCSkmROFzkR7FIZBHhYQC0cuSgOcFmNkM/SmFwZS3d5MAMomafuSOLkmI
         /r8LttGy68w6xwwN+AH6eOZ/f04tT8Wzn8X08=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=UVoSQt4bLtT7Ix7kL6FeuZytha01b8oiry7YrK+fTN8=;
        b=OISpvprdz3x43L83eGWBvSHE0BdKmfFYoNcct7jZplOlGmsOoL7nQSXpt0l/VRPrF6
         TI6k2EXr3/oQHbzHeE7eGT8UwytFiAho79IL6/nBADXv7KJLZ0UnaoI3TFuIEU+Cz8+H
         xbeGPxndVgMZnAMEwBw3ugHRksARWmCSXICCa7QMMMgBrJfz2bpwSf8TJwQ87yb9yjzl
         zT3Z5GmH0P/2jOQNFQhxNsh2zcHW0QQWHHGDUJ3FSe45oNdcQrKOFLo1dIpkaMAvOYKG
         6MQEZSrDFLnd2N+TptEZ1wndcWNjh9O7TZOys3z0Xuwl6Hnu+Dgc5LHzwFX4jKYMDovg
         mnMw==
X-Gm-Message-State: AOAM5317mXekcPLp+YhHZFQZUGd4oE6mFXBA8vlflVMnYFSYaTQX6fvQ
        fjwBHT7m07mqTZjb68kMhkrwLw==
X-Google-Smtp-Source: ABdhPJwe5ro/3a3QCBjQ+lr2f3q8xPap4d4GhZdjf9urA1CJtx3xfDAv/fTqpX47WGZFPyZd7FzvZA==
X-Received: by 2002:a63:5a43:: with SMTP id k3mr8391295pgm.308.1621578966210;
        Thu, 20 May 2021 23:36:06 -0700 (PDT)
Received: from google.com ([2409:10:2e40:5100:245d:3890:fa95:996e])
        by smtp.gmail.com with ESMTPSA id d12sm3456808pfv.190.2021.05.20.23.36.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 May 2021 23:36:05 -0700 (PDT)
Date:   Fri, 21 May 2021 15:36:01 +0900
From:   Sergey Senozhatsky <senozhatsky@chromium.org>
To:     Sergey Senozhatsky <senozhatsky@chromium.org>
Cc:     "Paul E. McKenney" <paulmck@kernel.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>, rcu@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] rcu/tree: consider time a VM was suspended
Message-ID: <YKdU0U0aHKm2x3Y7@google.com>
References: <20210516102716.689596-1-senozhatsky@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210516102716.689596-1-senozhatsky@chromium.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (21/05/16 19:27), Sergey Senozhatsky wrote:
>  kernel/rcu/tree_stall.h | 18 ++++++++++++++++++
>  1 file changed, 18 insertions(+)
> 
> diff --git a/kernel/rcu/tree_stall.h b/kernel/rcu/tree_stall.h
> index 59b95cc5cbdf..cb233c79f0bc 100644
> --- a/kernel/rcu/tree_stall.h
> +++ b/kernel/rcu/tree_stall.h
> @@ -7,6 +7,8 @@
>   * Author: Paul E. McKenney <paulmck@linux.ibm.com>
>   */
>  
> +#include <asm/kvm_para.h>
> +

D'oh, why did I do this...

Paul, I've a trivial fixup. How do you want to handle it?

---

diff --git a/kernel/rcu/tree_stall.h b/kernel/rcu/tree_stall.h
index cd815b19740a..b9b52f91e5b8 100644
--- a/kernel/rcu/tree_stall.h
+++ b/kernel/rcu/tree_stall.h
@@ -7,7 +7,7 @@
  * Author: Paul E. McKenney <paulmck@linux.ibm.com>
  */
 
-#include <asm/kvm_para.h>
+#include <linux/kvm_para.h>
 
 //////////////////////////////////////////////////////////////////////////////
 //
