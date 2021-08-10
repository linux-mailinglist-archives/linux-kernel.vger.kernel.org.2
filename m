Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B6AD03DB0B3
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jul 2021 03:39:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234583AbhG3Bja (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Jul 2021 21:39:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233918AbhG3Bj3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jul 2021 21:39:29 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87E82C0613C1
        for <linux-kernel@vger.kernel.org>; Thu, 29 Jul 2021 18:39:24 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id b6so12830480pji.4
        for <linux-kernel@vger.kernel.org>; Thu, 29 Jul 2021 18:39:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=vPAHzrcSpfKuQzB1lrV/ttkpcnRRhB/aWzazYKPR4LA=;
        b=Nkis4e8105uAbCge9aO+StXNkXelrJqOpF7xNsIBtcoe+D0iGfGrhXWOijeKDfFQS8
         tcGIefv5L6ODB7FGlHuoK3nhQNiRzvNAcTkGvlhjpZKPls5MD5zfBf1pJ7Ll8rA8iZ5f
         LTaEoFLk38qAHkDnPefiooUaNHcHv32+03LBo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=vPAHzrcSpfKuQzB1lrV/ttkpcnRRhB/aWzazYKPR4LA=;
        b=HMDqnEsdcZNbXISwV3MdERt6EZdj8oppVJ4SUdjFKkW3dvd/pFvEcQG73SgisgaZH1
         SPcGopkB/3YbNwyMFpLMYpwlv6aNvmytAzjSuj3HADFfcGMN2zvBVovH4rgYwJvckahN
         MnPWpTxt4gGwR+frZueZ5ZBuiOO648v9NeEyY7mF/wyfyHvqX490prQtGWzkaHlk2ZfE
         izURZqsnL9uUYaqvmjRWtCuObSXl7Kv6Ul6ulgxv4Y2CurJdlAn6X4Dsco48N0LtU4nV
         couNlmgj9/l194hIdJ6BY4XOd7SGvQyNQZZT+3xoqGO/L+it2YQ5/016/77lKOtmtbUo
         Zmpw==
X-Gm-Message-State: AOAM533O8sbe+G8nJv4uFYhLl0WqsWGYJR9SSocRaS1G/nl5v+TOUiYD
        leFImtm294ypaWcwbmoG2qfPDg==
X-Google-Smtp-Source: ABdhPJzbwo1FmDrFDbiWZ8BWT3TYMS+pXDsYeTk5gfATiaIbAKAeZ3H6gw+DeJERV+7PZzePv9GaaQ==
X-Received: by 2002:a63:1053:: with SMTP id 19mr5768pgq.395.1627609164105;
        Thu, 29 Jul 2021 18:39:24 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id z5sm97349pgz.77.2021.07.29.18.39.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Jul 2021 18:39:23 -0700 (PDT)
Date:   Thu, 29 Jul 2021 18:39:22 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-hardening@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Keith Packard <keithpac@amazon.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org,
        netdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-staging@lists.linux.dev, linux-block@vger.kernel.org,
        linux-kbuild@vger.kernel.org, clang-built-linux@googlegroups.com
Subject: Re: [PATCH 62/64] netlink: Avoid false-positive memcpy() warning
Message-ID: <202107291838.25D1F118C@keescook>
References: <20210727205855.411487-1-keescook@chromium.org>
 <20210727205855.411487-63-keescook@chromium.org>
 <YQDv+oG7ok0T1L+r@kroah.com>
 <d7251d92-150b-5346-6237-52afc154bb00@rasmusvillemoes.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d7251d92-150b-5346-6237-52afc154bb00@rasmusvillemoes.dk>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 28, 2021 at 01:24:01PM +0200, Rasmus Villemoes wrote:
> On 28/07/2021 07.49, Greg Kroah-Hartman wrote:
> > On Tue, Jul 27, 2021 at 01:58:53PM -0700, Kees Cook wrote:
> >> In preparation for FORTIFY_SOURCE performing compile-time and run-time
> >> field bounds checking for memcpy(), memmove(), and memset(), avoid
> >> intentionally writing across neighboring fields.
> >>
> >> Add a flexible array member to mark the end of struct nlmsghdr, and
> >> split the memcpy() to avoid false positive memcpy() warning:
> >>
> >> memcpy: detected field-spanning write (size 32) of single field (size 16)
> >>
> >> Signed-off-by: Kees Cook <keescook@chromium.org>
> >> ---
> >>  include/uapi/linux/netlink.h | 1 +
> >>  net/netlink/af_netlink.c     | 4 +++-
> >>  2 files changed, 4 insertions(+), 1 deletion(-)
> >>
> >> diff --git a/include/uapi/linux/netlink.h b/include/uapi/linux/netlink.h
> >> index 4c0cde075c27..ddeaa748df5e 100644
> >> --- a/include/uapi/linux/netlink.h
> >> +++ b/include/uapi/linux/netlink.h
> >> @@ -47,6 +47,7 @@ struct nlmsghdr {
> >>  	__u16		nlmsg_flags;	/* Additional flags */
> >>  	__u32		nlmsg_seq;	/* Sequence number */
> >>  	__u32		nlmsg_pid;	/* Sending process port ID */
> >> +	__u8		contents[];
> > 
> > Is this ok to change a public, userspace visable, structure?
> 
> At least it should keep using a nlmsg_ prefix for consistency and reduce
> risk of collision with somebody having defined an object-like contents
> macro. But there's no guarantees in any case, of course.

Ah, good call. I've adjusted this and added a comment.

Thanks!

-Kees

-- 
Kees Cook
