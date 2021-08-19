Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E90843F16DD
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Aug 2021 11:58:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237848AbhHSJ70 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Aug 2021 05:59:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232750AbhHSJ7Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Aug 2021 05:59:25 -0400
Received: from mail-qk1-x72f.google.com (mail-qk1-x72f.google.com [IPv6:2607:f8b0:4864:20::72f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EED4C061575;
        Thu, 19 Aug 2021 02:58:49 -0700 (PDT)
Received: by mail-qk1-x72f.google.com with SMTP id bj38so6482403qkb.9;
        Thu, 19 Aug 2021 02:58:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to;
        bh=+KYO/tl/8pjTbXDZMi8bl0uqpdKd7fCd6x/jY/iHmW8=;
        b=i6+T8F0dZrxNpSDAXoV2tspVASREEk5+WFMRG9f+e5TxFJLf3D7WBTtz/VjVqMfj5Y
         zivPuRJ027hPPyEW3H2KTSa1eSxq4+CtI0O9pQmul85025txB/wJC7hd92erzYjot15u
         cwDETCNMGJhX3hGfuV/ZTn+27XlrLwxRnUsvK1Vgp55lvfHlB12Ll01k4lR4vnCpDCY6
         3yLz8L20VSvpG+PteKS4ZvrUHsjhYqc4S89jQuohV4eDXxeNlmnyxW26qdIEwvLt3FIh
         hji6vmmL0FHD+huvMseG+aHwEWr3XZfrRr/AQCnJiSTcx4S4QIzAMCVjqN5STHFzUNVQ
         IY/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to;
        bh=+KYO/tl/8pjTbXDZMi8bl0uqpdKd7fCd6x/jY/iHmW8=;
        b=m0QSD0S3iOioCbEbYYP5kyRVhNpMpKHFHE2KJWSMutLJ6icnKVRl/DWKcJUOAi+w1U
         DcLoPeGD6xi3bsGLihnb8JVvrpRdfatnavl00ttcHBNij96FErdbdlFvl9CMkgoaXzOF
         2Ym7BSPkqcBTvo9ZuhBdOVDb66y7jwr4DaoWkSisqEV8QH5hbtj9Mtz3pnXW26Xa7iPA
         ZoLbPyh1TGHe7oLZMyqCPNSNivxB8Oztt5A6s/RPOaOHIn6wQ00zcGTQtzgEzJssGZoG
         7zJ9npmDAAz4sjjBSU64Nq5bFhaRpApOHOQZVpxcvNNOM5g7FY+vkiMLAwZ2VysHSIrY
         93nQ==
X-Gm-Message-State: AOAM532a89EyQacbbAam8jXQceUcuyVPSCiN3D+Iu+j1vA6vUwbRP+NO
        mudNRC4ts202iq7gjyimZE8=
X-Google-Smtp-Source: ABdhPJydwp9lo5mTwqG2knDAlsfvVDkMTT63oYQU4znuc0nkVfHFgMvopR4kd/EpO7Ur4bzJSfhccg==
X-Received: by 2002:a37:a302:: with SMTP id m2mr2758270qke.155.1629367128661;
        Thu, 19 Aug 2021 02:58:48 -0700 (PDT)
Received: from localhost.localdomain (ec2-35-169-212-159.compute-1.amazonaws.com. [35.169.212.159])
        by smtp.gmail.com with ESMTPSA id i18sm1353864qkk.115.2021.08.19.02.58.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Aug 2021 02:58:48 -0700 (PDT)
From:   SeongJae Park <sj38.park@gmail.com>
X-Google-Original-From: SeongJae Park <sjpark@amazon.de>
To:     SeongJae Park <sj38.park@gmail.com>
Cc:     corbet@lwn.net, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, SeongJae Park <sjpark@amazon.de>
Subject: Re: [PATCH 1/2] Documentation/process/applying-patches: Activate linux-next man hyperlink
Date:   Thu, 19 Aug 2021 09:58:36 +0000
Message-Id: <20210819095836.1475-1-sjpark@amazon.de>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210812095030.4704-1-sj38.park@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: SeongJae Park <sjpark@amazon.de>

Hello Jon,


I'm wondering if you had a chance to review this patchset.  Could you please
give me some comments?


Thanks,
SJ

On Thu, 12 Aug 2021 09:50:29 +0000 SeongJae Park <sj38.park@gmail.com> wrote:

> From: SeongJae Park <sjpark@amazon.de>
> 
> There is a url for linux-next in the 'applying-patches.rst', but it's
> surrounded by backquotes.  So the url doesn't have a hyperlink in the
> built document.  To let readers easily move to the page, this commit
> puts the url outside of the backquotes so that a hyperlink to the url
> can be automatically made.
> 
> Signed-off-by: SeongJae Park <sjpark@amazon.de>
> ---
>  Documentation/process/applying-patches.rst | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/Documentation/process/applying-patches.rst b/Documentation/process/applying-patches.rst
> index 2e7017bef4b8..c2121c1e55d7 100644
> --- a/Documentation/process/applying-patches.rst
> +++ b/Documentation/process/applying-patches.rst
> @@ -389,7 +389,7 @@ The -mm patches are experimental patches released by Andrew Morton.
>  
>  In the past, -mm tree were used to also test subsystem patches, but this
>  function is now done via the
> -`linux-next <https://www.kernel.org/doc/man-pages/linux-next.html>`
> +`linux-next` (https://www.kernel.org/doc/man-pages/linux-next.html)
>  tree. The Subsystem maintainers push their patches first to linux-next,
>  and, during the merge window, sends them directly to Linus.
>  
> -- 
> 2.17.1
