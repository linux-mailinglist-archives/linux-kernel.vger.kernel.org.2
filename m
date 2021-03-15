Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 213DB33C76D
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Mar 2021 21:07:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231698AbhCOUHW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Mar 2021 16:07:22 -0400
Received: from mail-pg1-f178.google.com ([209.85.215.178]:34067 "EHLO
        mail-pg1-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229808AbhCOUG6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Mar 2021 16:06:58 -0400
Received: by mail-pg1-f178.google.com with SMTP id l2so21128640pgb.1
        for <linux-kernel@vger.kernel.org>; Mon, 15 Mar 2021 13:06:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=OOVcujQsXQLxPa5Y1WXIcDvGuW02nNmnNAEglQlFDyU=;
        b=SBALJyM8aFf4OzjMTlo/EHscjRC/91xoHznnodJtx4eIk2i+73V250Z492m5geCb9b
         XJOwZbHiCVH2FATuY5EMjpWTwfTkT5GmzEQqnKTQjbimaIwsL8T5T5bC2IByR/3EeIDz
         zTk/bDP9mlgbh+WJ9pKkUk2Ttz8qOXvB9XvFvIBod2p2bM5VRPRVTt73KbrD5kM1v/gL
         m2XHpn+Eny7M1CrWoma51k8bLuAl4diwVGxjyu/hN5Nw9CoQGfqMfFmFME7SUOmToBUi
         Vib4lcZEvJ/DKTGTbAniKIvKCtdgpUrNTXPbaboFPIWtRmDVRp6bOtIdL2xvjgMWvkVt
         penA==
X-Gm-Message-State: AOAM532rJKYGqvymzshJ1Q980s9xqnK8+QGB0Dcp4Sbf7uR1z9KWF6H+
        f9IDqm7Sb8sObsJSFkpD6/I=
X-Google-Smtp-Source: ABdhPJz6XTIHU70leFou7rkSzJV/UsJaZKb7fQhQeHNU9vcyrWdwjL8KJeZxNuOxCFlGeNslUp8muQ==
X-Received: by 2002:a62:92cc:0:b029:1fa:515d:808f with SMTP id o195-20020a6292cc0000b02901fa515d808fmr25548284pfd.43.1615838817895;
        Mon, 15 Mar 2021 13:06:57 -0700 (PDT)
Received: from 42.do-not-panic.com (42.do-not-panic.com. [157.230.128.187])
        by smtp.gmail.com with ESMTPSA id ge16sm450600pjb.43.2021.03.15.13.06.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Mar 2021 13:06:56 -0700 (PDT)
Received: by 42.do-not-panic.com (Postfix, from userid 1000)
        id 905FC40106; Mon, 15 Mar 2021 20:06:55 +0000 (UTC)
Date:   Mon, 15 Mar 2021 20:06:55 +0000
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jessica Yu <jeyu@kernel.org>, Borislav Petkov <bp@alien8.de>,
        Jonathan Corbet <corbet@lwn.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org,
        Nick Desaulniers <ndesaulniers@google.com>
Subject: Re: [PATCH v3 2/2] modules: add CONFIG_MODPROBE_PATH
Message-ID: <20210315200655.GX4332@42.do-not-panic.com>
References: <20210313212528.2956377-1-linux@rasmusvillemoes.dk>
 <20210313212528.2956377-3-linux@rasmusvillemoes.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210313212528.2956377-3-linux@rasmusvillemoes.dk>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 13, 2021 at 10:25:28PM +0100, Rasmus Villemoes wrote:
> Allow the developer to specifiy the initial value of the
> modprobe_path[] string. This can be used to set it to the empty string
> initially, thus effectively disabling request_module() during early
> boot until userspace writes a new value via the
> /proc/sys/kernel/modprobe interface. [1]
> 
> When building a custom kernel (often for an embedded target), it's
> normal to build everything into the kernel that is needed for booting,
> and indeed the initramfs often contains no modules at all, so every
> such request_module() done before userspace init has mounted the real
> rootfs is a waste of time.
> 
> This is particularly useful when combined with the previous patch,
> which made the initramfs unpacking asynchronous - for that to work, it
> had to make any usermodehelper call wait for the unpacking to finish
> before attempting to invoke the userspace helper. By eliminating all
> such (known-to-be-futile) calls of usermodehelper, the initramfs
> unpacking and the {device,late}_initcalls can proceed in parallel for
> much longer.
> 
> For a relatively slow ppc board I'm working on, the two patches
> combined lead to 0.2s faster boot - but more importantly, the fact
> that the initramfs unpacking proceeds completely in the background
> while devices get probed means I get to handle the gpio watchdog in
> time without getting reset.
> 
> [1] __request_module() already has an early -ENOENT return when
> modprobe_path is the empty string.
> 
> Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Acked-by: Jessica Yu <jeyu@kernel.org>
> Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>

Acked-by: Luis Chamberlain <mcgrof@kernel.org>

  Luis
