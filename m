Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DCF3142B859
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Oct 2021 09:02:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238277AbhJMHEt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Oct 2021 03:04:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232006AbhJMHEq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Oct 2021 03:04:46 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EAECC061746
        for <linux-kernel@vger.kernel.org>; Wed, 13 Oct 2021 00:02:43 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id qe4-20020a17090b4f8400b0019f663cfcd1so3699087pjb.1
        for <linux-kernel@vger.kernel.org>; Wed, 13 Oct 2021 00:02:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=efB3Lcg8IS6RzUiO27f4O4XhGBeoDlQrvifyp9iElT0=;
        b=Yu/d1w7scx0araRrouwcPv6x4zAyT5UDwg8br0GJKxvpbtbYX8o2X/sT0DZJj85xPu
         GeOG1cedBC9ir+WJzzTn0DlJjTcSrRwmj6JY0uqPzF+FpwjUp67IJwMyMJy7Xmdg24ud
         6JNdT8Dwc4xpSiQj6cf4wp2M/y/7wOCbdXf/M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=efB3Lcg8IS6RzUiO27f4O4XhGBeoDlQrvifyp9iElT0=;
        b=5durFaSqqPiup0+lrQOeONEBAtNZOVivGc63CEqW9unuTM3LpqhdHWHGPK7N29imic
         pe5LSMSmtrHWZrsoiN+yNKkftNAGdM95sBD353cJv2/r6Wpuvw97HPYqKxRekujCeE4q
         nePWW1nA9wT12eKuH5QK9ySy3O3gnzLGfIEGSZz5QuF40tvGaw223CXyigQV6gN7IW1z
         S9ouiIyaFLFnaxOBMiY5dSt/uR3avrC08M6Vvwwv4wQsedVfJC/CxmbA0hDGO3J/MSC7
         waAO24+Xr+y2nqfXsRt410M2ll2sGqxETxJw57zBq96MP0nBKsdW52mC6GCVLyTVhVwh
         c0jA==
X-Gm-Message-State: AOAM530mYZVL6wULHbqqFclHMXggNOgKzEouFMwrPCuKWXkMTtLBsroj
        I/hBdUJ7qTQr1t+zhFMTUCuclA==
X-Google-Smtp-Source: ABdhPJx2yhgK3ntHhywGbHAC8jYO6ehQsn+GhjQrHT7BjbF3OFKwU6TjoJG8lD6XMAvpgbQCPNEisw==
X-Received: by 2002:a17:90b:17cc:: with SMTP id me12mr11443156pjb.147.1634108562933;
        Wed, 13 Oct 2021 00:02:42 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id u19sm3124045pgo.73.2021.10.13.00.02.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Oct 2021 00:02:42 -0700 (PDT)
Date:   Wed, 13 Oct 2021 00:02:41 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Christophe Leroy <christophe.leroy@csgroup.eu>
Cc:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Andrew Morton <akpm@linux-foundation.org>,
        "James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>,
        Helge Deller <deller@gmx.de>, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-ia64@vger.kernel.org, linux-parisc@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v1 07/10] lkdtm: Force do_nothing() out of line
Message-ID: <202110130002.0FC7878252@keescook>
References: <cover.1633964380.git.christophe.leroy@csgroup.eu>
 <b353a85e50ac336c385b46459a5fc43f4a6171ac.1633964380.git.christophe.leroy@csgroup.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b353a85e50ac336c385b46459a5fc43f4a6171ac.1633964380.git.christophe.leroy@csgroup.eu>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 11, 2021 at 05:25:34PM +0200, Christophe Leroy wrote:
> LKDTM tests display that the run do_nothing() at a given
> address, but in reality do_nothing() is inlined into the
> caller.
> 
> Force it out of line so that it really runs text at the
> displayed address.
> 
> Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>

Acked-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
