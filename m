Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 18A3D36E846
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Apr 2021 11:58:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237918AbhD2J7P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Apr 2021 05:59:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231543AbhD2J7N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Apr 2021 05:59:13 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24C53C06138B;
        Thu, 29 Apr 2021 02:58:26 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id f24so406391ejc.6;
        Thu, 29 Apr 2021 02:58:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=tklYk81FT4qSaxNV95BozP+5M6DhAHA9kR1UVw8mEcs=;
        b=tzTByYoPRU+PdqHlaVQF1iGEUjxA9p0h9i8QJN5G4NdqlarF4UQ5hsXtT+Pc9Gy7Mk
         eyVlLXxrDDqzW4G7FFwaacKbmcf8TwXpmsGrV7XwqCXBz6O45gm9whiduPoSIqORstLl
         07UGhnYK5yZYDlwSQTZQmomeNgfbIG0+5lJby/6CXWiFbybKv2y6LqUZ+lqaZqMngDqJ
         s4u9tFNQWrZMO4+V36NNVzgVnUs78NYorIY3qt36JE8FwZM7O8CgEWACZwKCVIDsDW8e
         J63htF6+2hksKU18TkfZdtNDYd8laf5QrwoCzmF4bsCBapguURA2K1+jIqq9stulsY/v
         HqwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=tklYk81FT4qSaxNV95BozP+5M6DhAHA9kR1UVw8mEcs=;
        b=LGBmxEzVOExmzxHGGlpJWA3jHUitN+UcuVBMD400pWVNM48vJPzX6+bEtKPX8k0gYQ
         74f35M09NzXUbp4YabE1MTwORp8GIodbSGPog5bvIoa9FS75CjQ0WXnu4txPYV/m3o9m
         fPoxCP+z80570MZ2FF2/qshpRyb+5zfEUCDmpcWe5PDMVUefdh4/10MYvz/jTyWW8NhV
         eYbLI0ragKwpqDnqBUZhNkkEs2vfhRyZfKPxDxSCcLUacnBuzEsUXObe0ReW7JTjchJb
         iGlgPd7uS+s4o43hBV5aTmv/TiMbsTYz8LzhYjsaI6r93mNYxlr9Ui8KZ3dFV9EAXNpQ
         cr0w==
X-Gm-Message-State: AOAM531yUZ0HVnKO9ObtlBUAiJllHkipLIccXdlj6gupSlpSF9E0Sj0G
        xNq0IEF0yvD3yB2ZLRckyvmsBh9JgruRQg==
X-Google-Smtp-Source: ABdhPJwPDhqpBec0oGafy5OUJeyvbWX4XhjWPH7lJcb1hJqCnPlRUjLvd4bNtYc1Wm+FHRNF2jyCaQ==
X-Received: by 2002:a17:906:851a:: with SMTP id i26mr11527283ejx.148.1619690304637;
        Thu, 29 Apr 2021 02:58:24 -0700 (PDT)
Received: from agape.jhs ([5.171.81.14])
        by smtp.gmail.com with ESMTPSA id l17sm1530710ejk.22.2021.04.29.02.58.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Apr 2021 02:58:24 -0700 (PDT)
Date:   Thu, 29 Apr 2021 11:58:20 +0200
From:   Fabio Aiuto <fabioaiuto83@gmail.com>
To:     rust-for-linux@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org
Subject: module parameters permission
Message-ID: <20210429095819.GE1409@agape.jhs>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

I'm trying to declare module parameters this way:


   params: {
        scull_major: i32 {
            default: 0,
            permissions: bindings::S_IRUGO as i32,
            description: b"Major number",
        },
        scull_minor: i32 {
            default: 0,
            permissions: bindings::S_IRUGO as i32,
            description: b"Minor number",
        },

i.e. using S_IRUGO macro exposed by bindgen. But I have the
following compiler error:

error: proc macro panicked
  --> samples/rust/rust_scull.rs:12:1
   |
12 | / module! {
13 | |     type: RustScull,
14 | |     name: b"rust_scull",
15 | |     author: b"Alessandro Rubini, Jonathan Corbet",
...  |
44 | |     },
45 | | }
   | |_^
   |
   = help: message: Expected Literal

the same if I remove as i32 casts.

if I write permissions as in samples/rust/rust_module_parameters.rs

    params: {
        my_bool: bool {
            default: true,
            permissions: 0,
            description: b"Example of bool",
        },
        my_i32: i32 {
            default: 42,
            permissions: 0o644, <-------
            description: b"Example of i32",
        },

I get no error.

What's the right way to use S_I*UGO macros?

my includes are:

// SPDX-License-Identifier: GPL-2.0

//! Scull driver sample

#![no_std]
#![feature(allocator_api, global_asm)]

use kernel::prelude::*;
use kernel::{chrdev, cstr};
use crate::bindings;

thank you,

fabio


