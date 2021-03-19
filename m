Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C7418341E57
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Mar 2021 14:31:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230354AbhCSNay (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Mar 2021 09:30:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229978AbhCSNa3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Mar 2021 09:30:29 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21505C06174A
        for <linux-kernel@vger.kernel.org>; Fri, 19 Mar 2021 06:30:29 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id k128so3061375wmk.4
        for <linux-kernel@vger.kernel.org>; Fri, 19 Mar 2021 06:30:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=rqxxjU+wnwYGxcIxMIjRQhxf9BngsTqESHU7cWQvFn8=;
        b=hstLdqtNpgte2teshQgLp4jcH+bAmgbWUC1tt01NDEu34dQlqudsRenJKjc3dvabkk
         uE9W+PdVJ5wsu55q7PkkVzpWVJPTth//+Jv8/CIYw2rXsAVyiY/SNMnA40kb1xuOKUU0
         tuhwAZq2VMMJg6IScvK7TtCXGBIN28yf5aCd0z/YixVCT3Z5/83hg8TEj+gY6c8dQHmo
         fEj4uRxgA25iQY9bz36/erSl983strDL4wd11vc6Iht1qz3XAXYqijHCa3LSR36XiHFm
         A+/ZzfcroSa/1vuzqSxnUXwPW3M4MZ8X8/Z2HiVegSeGZB7h5JUMwcyr+DzODbfHR9VI
         MJRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=rqxxjU+wnwYGxcIxMIjRQhxf9BngsTqESHU7cWQvFn8=;
        b=mZPsNlTQ+NIBHbUvsiMfR/BJxP7L5OuK2Lrt9rv8tp2Y9iqXB4ulMHE00P4cIIc3BL
         CMzDNxqrFTkl2UzV8AXAckDhE571oYxZ3Hi0A93iZbCJPQ/jhFYDFSm3M7vjQr1hYLlu
         dt4Ag+EV6hgzLZm1xWA6FxFsFoP19DVmVtSjt2IN6QiRKWXDFR5hQYOtdBMQ7RMF0Ysh
         57NnmPTLTUS/VZwp4anMzIcmmrIcclIz9nxX4LEGSGiBIhjlhVely/Nit1iqIl362gTR
         UIXXW3tMmhFKFYpCXIemSXYqiRjsM70k2c1RV1wf5r8V+WsC7YFnQawFZ3rq0zh/c5Vv
         9fUA==
X-Gm-Message-State: AOAM531z3IsR3N8IMjlyvj3qWCGfoPPjk+TbnEz2CVwsWZ4OMyH/KIyi
        rBGG8WLtz14NdS9DxBrZrFjB9w==
X-Google-Smtp-Source: ABdhPJzYvk8uCKPJKGOQFMvJG0I07hajcvaqheb9rFcjVgyB2PxJHrRQCRGH+Q0cFo4RWSKNO9F2Tg==
X-Received: by 2002:a1c:e084:: with SMTP id x126mr3765734wmg.37.1616160627793;
        Fri, 19 Mar 2021 06:30:27 -0700 (PDT)
Received: from google.com (216.131.76.34.bc.googleusercontent.com. [34.76.131.216])
        by smtp.gmail.com with ESMTPSA id j13sm7731425wrt.29.2021.03.19.06.30.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Mar 2021 06:30:27 -0700 (PDT)
Date:   Fri, 19 Mar 2021 13:30:23 +0000
From:   David Brazdil <dbrazdil@google.com>
To:     selinux@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        Paul Moore <paul@paul-moore.com>,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        Eric Paris <eparis@parisplace.org>,
        Jeff Vander Stoep <jeffv@google.com>,
        Alistair Delva <adelva@google.com>, stable@vger.kernel.org
Subject: Re: [PATCH v2] selinux: vsock: Set SID for socket returned by
 accept()
Message-ID: <YFSnb/kGpn7xPPR8@google.com>
References: <20210319130541.2188184-1-dbrazdil@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210319130541.2188184-1-dbrazdil@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 19, 2021 at 01:05:41PM +0000, David Brazdil wrote:
> For AF_VSOCK, accept() currently returns sockets that are unlabelled.
> Other socket families derive the child's SID from the SID of the parent
> and the SID of the incoming packet. This is typically done as the
> connected socket is placed in the queue that accept() removes from.
> 
> Reuse the existing 'security_sk_clone' hook to copy the SID from the
> parent (server) socket to the child. There is no packet SID in this
> case.
> 
> Fixes: d021c344051a ("VSOCK: Introduce VM Sockets")
Cc: <stable@vger.kernel.org>
> Signed-off-by: David Brazdil <dbrazdil@google.com>
> ---
> Tested on Android AOSP and Fedora 33 with v5.12-rc3.
> Unit test is available here:
>   https://github.com/SELinuxProject/selinux-testsuite/pull/75
> 
> Changes since v1:
>   * reuse security_sk_clone instead of adding a new hook
> 
>  net/vmw_vsock/af_vsock.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/net/vmw_vsock/af_vsock.c b/net/vmw_vsock/af_vsock.c
> index 5546710d8ac1..bc7fb9bf3351 100644
> --- a/net/vmw_vsock/af_vsock.c
> +++ b/net/vmw_vsock/af_vsock.c
> @@ -755,6 +755,7 @@ static struct sock *__vsock_create(struct net *net,
>  		vsk->buffer_size = psk->buffer_size;
>  		vsk->buffer_min_size = psk->buffer_min_size;
>  		vsk->buffer_max_size = psk->buffer_max_size;
> +		security_sk_clone(parent, sk);
>  	} else {
>  		vsk->trusted = ns_capable_noaudit(&init_user_ns, CAP_NET_ADMIN);
>  		vsk->owner = get_current_cred();
> -- 
> 2.31.0.rc2.261.g7f71774620-goog
> 
