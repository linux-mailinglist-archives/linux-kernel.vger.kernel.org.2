Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2FDB93BE64B
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jul 2021 12:19:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231283AbhGGKWF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jul 2021 06:22:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231194AbhGGKWE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jul 2021 06:22:04 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32D95C061762
        for <linux-kernel@vger.kernel.org>; Wed,  7 Jul 2021 03:19:23 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id f17so2416115wrt.6
        for <linux-kernel@vger.kernel.org>; Wed, 07 Jul 2021 03:19:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=5/41QsdtJR+pnNTqK6DmTCH5qChei4s6l1r+fcxa5os=;
        b=m6Prb02gepak06rbGn1SOrXDszjWMsxxbLOuQ1T6C+rzgmxTzsqqEQkeZE4kusgddO
         SGCxMk0aV+EwydOfmYm3fU7Po9TzMU8N7feUairqdef9ja/9b4wUZE5XyuLGHqSVDFbE
         5uQpdqFIsY0AeIOTObvhB6t5ezeyTOwPs3igLCx0dKLf8Fh63Y4JrldkXKCea+Di2Bdq
         RC8h9B/KV9jhodxWABOSR+1NGb0bp7rbEsoj9xW9Bvrrqt7WPodxMa+shw1yrTAqmqfU
         k01SEnk5bdBE3FBTBDpc0tZwzjD4ZoM0bJ9IS40mZ77XZZZPI79GAnodT1lDIfFpLmSd
         sHGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=5/41QsdtJR+pnNTqK6DmTCH5qChei4s6l1r+fcxa5os=;
        b=mR7Lgwu2hvX1dYaaqf59RPev3fJnYC5n45++7KPsjKWXsVhxEItYUJLpPpQzCoNXo+
         BeXrS0yiNAL+YtR/YA80L7WYy8GREozU3P1HEMUfvUrUGQg5Cla3UYZUKP8ohY9+JT1j
         jAyTjrqKmhAjVvkLgf0pyvV1hEr+4gFYP8/Z2XgAb2wQhT1Iz4tkLEc96nWV2iFqUWzo
         1DBWQR/qeJDSdeS7RXbCzn4vE8wW4yw65RyyeLnqQ2imxGrRqoKhFHR4B1urfApt2c2L
         NxYZkJVDWaSdcaUWTxCApivpPXeUcXaHTlJaGaIhX56nwh/FD+nZvLcmZq7xyW/qtcxq
         csxQ==
X-Gm-Message-State: AOAM533pUg/p9b/3KDDlAswVMG4V9YOlV9fYvuFHlRrFuScvDYaH21qu
        sFVUYXNEI9XEu+0fHuRHPbOLSw==
X-Google-Smtp-Source: ABdhPJxi44xOdVggHQ7xvzV/UDlXK4xISLN+bIyKXNcKKYKwMkN8sY23lSG5BmRl84eNr3fQUnEecA==
X-Received: by 2002:a5d:680b:: with SMTP id w11mr14879170wru.426.1625653161522;
        Wed, 07 Jul 2021 03:19:21 -0700 (PDT)
Received: from elver.google.com ([2a00:79e0:15:13:396a:6bf2:9c33:26ce])
        by smtp.gmail.com with ESMTPSA id c125sm2543281wme.36.2021.07.07.03.19.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Jul 2021 03:19:20 -0700 (PDT)
Date:   Wed, 7 Jul 2021 12:19:14 +0200
From:   Marco Elver <elver@google.com>
To:     ojeda@kernel.org
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        rust-for-linux@vger.kernel.org, linux-kbuild@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Geoffrey Thomas <geofft@ldpreload.com>,
        Finn Behrens <me@kloenk.de>,
        Adam Bratschi-Kaye <ark.email@gmail.com>,
        Wedson Almeida Filho <wedsonaf@google.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Sumera Priyadarsini <sylphrenadin@gmail.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Sven Van Asbroeck <thesven73@gmail.com>,
        Gary Guo <gary@garyguo.net>,
        Boris-Chengbiao Zhou <bobo1239@web.de>,
        Fox Chen <foxhlchen@gmail.com>,
        Ayaan Zaidi <zaidi.ayaan@gmail.com>,
        Douglas Su <d0u9.su@outlook.com>,
        Yuki Okushi <jtitor@2k36.org>,
        clang-built-linux@googlegroups.com
Subject: Re: [PATCH 05/17] rust: add C helpers
Message-ID: <YOV/oj0rjHhzluH2@elver.google.com>
References: <20210704202756.29107-1-ojeda@kernel.org>
 <20210704202756.29107-6-ojeda@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210704202756.29107-6-ojeda@kernel.org>
User-Agent: Mutt/2.0.5 (2021-01-21)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 04, 2021 at 10:27PM +0200, ojeda@kernel.org wrote:
> From: Miguel Ojeda <ojeda@kernel.org>
> 
> This source file contains forwarders to C macros and inlined
> functions.

What is the story with Rust and LTO? Intuitively, I would expect Rust
code to only perform optimally if the kernel is built with LTO
(currently only supported via Clang).

Because if calls to every one of these helpers are real calls, I would
expect performance to be pretty poor. There's probably a reason these
are macros or inlinable functions.

I would almost go so far and suggest that CONFIG_RUST be modified as
follows:

--- a/init/Kconfig
+++ b/init/Kconfig
@@ -2028,6 +2028,7 @@ config RUST
 	depends on HAS_RUST
 	depends on !COMPILE_TEST
 	depends on !MODVERSIONS
+	depends on LTO || EXPERT
 	default n
 	help
 	  Enables Rust support in the kernel.

[ I'm sure there are configs that don't yet work with LTO, but could be
  useful to enable for debugging or testing purposes, and therefore would
  make it conditional on CONFIG_EXPERT as well. ]

[...]
> +unsigned long rust_helper_copy_from_user(void *to, const void __user *from, unsigned long n)
> +{
> +	return copy_from_user(to, from, n);
> +}
> +
[...]

From some local tests, it looks like simply attaching
__attribute__((always_inline)) will do what one would expect when
compiling with Clang LTO (I checked -flto=thin).

If you confirm this also works across C and Rust TUs when enabling LTO,
I would then suggested adding __attribute__((always_inline)) to all
these helpers.

Thanks,
-- Marco
