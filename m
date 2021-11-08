Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B8645449B63
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Nov 2021 19:05:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234729AbhKHSI0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Nov 2021 13:08:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234728AbhKHSIM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Nov 2021 13:08:12 -0500
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87C3FC061570
        for <linux-kernel@vger.kernel.org>; Mon,  8 Nov 2021 10:05:27 -0800 (PST)
Received: by mail-pj1-x1029.google.com with SMTP id f20-20020a17090a639400b001a772f524d1so510771pjj.5
        for <linux-kernel@vger.kernel.org>; Mon, 08 Nov 2021 10:05:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=1bvQfGtg1qY0mnkya9WogPfleiDdsq2oQqr6nYpuOh0=;
        b=m8C1XRcb6PUBPexiCgx9dWcYzX2TKZ2/TBttt0gFFtStZsWw94l1fMXF7z7p+iIxk8
         KEjPUSvTPM4X0Z+8l4Y7Eu7M89YIWGo8knRYjMcuBK1H4gE1rJKUR6Dde2QMLcg16BNV
         1j+mYRynIs8lzo5QhH3iHG1GzDhswYsUj5ROQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=1bvQfGtg1qY0mnkya9WogPfleiDdsq2oQqr6nYpuOh0=;
        b=GG5l0Qe6G00DLe/I3m/LxULg/Kt5GBIf0Wmf3s21jzlqMqLgZYgbij6/ewCaljfe0k
         vIsBg9VY3N/6urJrUbqHfeqMTsCe2GZ/vgyfE5cfp5p+tLhiMkSMa3c6fG8QKWs66CZp
         R1chv9uahdt1qT0qYqIDrg3PCk/ssnYu831QXPTgcuA4wN2rtAdo+uBkXoRcbAHpbMf1
         k1NhNKtNbTX/aFdjcQU6DRdNvLVqSigc4rSwK2ENNkHb5/UhFx+ZNYsuGw1c+EnwH/GX
         kJivmQAY8OPpU+F1580mH3ayZnqUi7EMfmhknvSUIqKbN8PzbYW6pi+aov2LRUtNnQ9W
         HSNw==
X-Gm-Message-State: AOAM530lceF5XljBfbHrpRx1x9f6rdEljTYZ176nBmVilWikbT8kp/7D
        mtX4SDsLuncWnnm6EfJLzbGZeQ==
X-Google-Smtp-Source: ABdhPJwiKlR9fvqKcWuZhoDW1mL+j9NDCOH2CZmyAOA7hRqzIijkEbY3J7qkkOwoGdgIeXa2AFmFFQ==
X-Received: by 2002:a17:903:286:b0:142:4abc:88b8 with SMTP id j6-20020a170903028600b001424abc88b8mr1071389plr.25.1636394726902;
        Mon, 08 Nov 2021 10:05:26 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id i2sm8411877pfe.70.2021.11.08.10.05.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Nov 2021 10:05:26 -0800 (PST)
Date:   Mon, 8 Nov 2021 10:05:25 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Ajay Garg <ajaygargnsit@gmail.com>
Cc:     Greg KH <gregkh@linuxfoundation.org>, andy@kernel.org,
        akpm@linux-foundation.org, adobriyan@gmail.com,
        Nick Desaulniers <ndesaulniers@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-hardening@vger.kernel.org
Subject: Re: RFC for a new string-copy function, using mixtures of strlcpy
 and strscpy
Message-ID: <202111080954.B97F7B4C@keescook>
References: <CAHP4M8X1ABEhu8kGtRSJHeqQ_m627hNT_N3Q_GGdcr3W_Rfspw@mail.gmail.com>
 <YYkWb4GQAAtZJNsT@kroah.com>
 <CAHP4M8W2H4V=qgAeVp76GwfVUBzR3erZxJiuhm6jnyMo+gvknQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHP4M8W2H4V=qgAeVp76GwfVUBzR3erZxJiuhm6jnyMo+gvknQ@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 08, 2021 at 06:15:54PM +0530, Ajay Garg wrote:
> Hi Greg,
> 
> Thanks for your time.
> 
> >
> > Wait, why?  We have recently added new string copy functions to resolve
> > the type of issues you have pointed out.  The kernel is not yet
> > converted to use them, so why add yet-another-function that also is not
> > used?
> 
> Greg, would request your couple of minutes more, in suggesting a
> concrete way forward, by working through an example as below.
> 
> 
> In the file fs/kernfs/dir.c, there is a statement
> 
>         return strlcpy(buf, kn->parent ? kn->name : "/", buflen);
> 
> Here, there is no information of how long kn->name might be, so there
> is a definite chance of overflow happening. Thus, accordingly, strlcpy
> is used, to bound copying of upto buflen bytes. Of course, buf
> (destination-buffer) is safe from any overflow now.
> 
> However, iffff strlen(kn->name) is greater than (buflen - 1), then
> strlcpy would return a different value than the number of bytes
> actually copied. Since there is no check, this (wrong) return value
> will be propagated to the clients down the stack.

The propagation issues are the real problem here, IMO. strlcpy returns
strlen(src), which is bound to cause problems if the result in used to
adjust string index, and strscpy returns -E2BIG on overflow, which can
cause different problems if the result in used to adjust string indexes.

strlcpy has the added problem of potentially performing OOB reads when
src is unterminated, so it needs to be entirely removed from the kernel
in favor of strscpy[1]. But yes, as you say, it isn't a drop-in
replacement, but that's because it shouldn't be -- the return values
need to be checked in both cases.

> Now, in the current situation, following is the remedy :
> 
> ########################################
>         int ret = strlcpy(buf, kn->parent ? kn->name : "/", buflen);
>         if(ret >= buflen)
>             ret = buflen - 1;
> 
>         return ret;
> ########################################

We do have other functions that "hide" the overflow (e.g. scnprintf),
but those are usually more common in large string constructions, or
chains of copies. When doing a single string copy, I think it's
important that the caller decide explicitly what to do in the overflow
case.

For the specific fs/kerfs/dir.c case, I don't see any problems --
nothing uses the result (cgroup_name() is the only caller of
kernfs_name() that I see).

-- 
Kees Cook
