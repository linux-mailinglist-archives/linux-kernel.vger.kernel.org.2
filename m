Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 352E23BE6A4
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jul 2021 12:51:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231406AbhGGKyB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jul 2021 06:54:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231371AbhGGKyA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jul 2021 06:54:00 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39220C06175F
        for <linux-kernel@vger.kernel.org>; Wed,  7 Jul 2021 03:51:20 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id q17so2541869wrv.2
        for <linux-kernel@vger.kernel.org>; Wed, 07 Jul 2021 03:51:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=/aoTDXlXnALJMl9Wxd7xok1/Pwgg+4ujvLSoM7V+DME=;
        b=Mf4Rc4fSaIhy7Eb7pDQ7YGLzqNkfmoralCbm7Zj2Azo8hiYiZE6FuOpz79xUx991ss
         tFhmgWuP5R4VCalxaY8czCxgSE6mosNbW+b4fPjNUCY7jY7ILgAtzAJgQS11IXC3ndlz
         3mDUbW1IRvu3GVUIVPk077DLMLOX/x+udOCmRi00Eq9lTB88tNC6q6Wk/q+qRw4oCwQW
         MCm50XprqalFbKMZQTNlm9yDy+wDjHUn4SLPFZTHsdBD3vIvAWKUvM2Sep06DVYowuLK
         xyqfBPN3EAhwegTVObXFr2Z/51eaeSjMJRKFzyUCxaD0sxgxIHBMD+YFQPKeE5lgnrZk
         0LWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=/aoTDXlXnALJMl9Wxd7xok1/Pwgg+4ujvLSoM7V+DME=;
        b=GFz5FcrHACDQyGN5JcCVijxLKtVXqUQL49/dQZnZCuLrUHBkzutd6A2Ssc9sPS57ez
         P/qU2WdPBuoXvcT9fLVFOcPj7dc1UKQQLSEUqDE91tMr4eFe1iqs7Ea3LRfn4na2x6t0
         F/seAugiDQReqhrFHshjXI5sxBN2zH32NznTLYeqI2WK4yzecqukHj1dZ6Hhu55pCV99
         MBdGsEOZEQ+4HWflfJ/ESfX8kvXCnSx3KbgUDwP823dxcCs9TkbY7LpgNq3inepS/zB0
         QlrtC+6gB2Ieb/wRfshSI5eoXv55V0tylZV0/KGxq5+tmsLPlUGlAEjlhAEi3Y/y+8Ig
         SQ6w==
X-Gm-Message-State: AOAM5325PV+1J3ZGYgngedeRcPt4rzyunldEORa1s0ALaxCeFHFAtp/9
        9B5NXb8jQ9TjH8+LECiqCSPRmA==
X-Google-Smtp-Source: ABdhPJw+vX2jEX6fI6DaJdUd0kdnpZdFibOW5bG0fWz9BRXFsHJ7OuCBi0RFXanBw4KcvNhXi9jVrw==
X-Received: by 2002:a5d:6dd1:: with SMTP id d17mr27175199wrz.344.1625655078685;
        Wed, 07 Jul 2021 03:51:18 -0700 (PDT)
Received: from elver.google.com ([2a00:79e0:15:13:396a:6bf2:9c33:26ce])
        by smtp.gmail.com with ESMTPSA id s17sm19500078wrt.58.2021.07.07.03.51.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Jul 2021 03:51:17 -0700 (PDT)
Date:   Wed, 7 Jul 2021 12:51:12 +0200
From:   Marco Elver <elver@google.com>
To:     ojeda@kernel.org
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        rust-for-linux@vger.kernel.org, linux-kbuild@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 00/17] Rust support
Message-ID: <YOWHIHcs5/sYr/Vr@elver.google.com>
References: <20210704202756.29107-1-ojeda@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210704202756.29107-1-ojeda@kernel.org>
User-Agent: Mutt/2.0.5 (2021-01-21)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 04, 2021 at 10:27PM +0200, ojeda@kernel.org wrote:
[...]
>   rust: add `alloc` crate
[...]

I think this patch never made it to the mailing list. b4 also doesn't
find it:

	ERROR: missing [7/17]
