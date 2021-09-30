Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C2E1641E14E
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Sep 2021 20:36:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344143AbhI3SiQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Sep 2021 14:38:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344049AbhI3SiL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Sep 2021 14:38:11 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CED9C06176C
        for <linux-kernel@vger.kernel.org>; Thu, 30 Sep 2021 11:36:28 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id k17so5776010pff.8
        for <linux-kernel@vger.kernel.org>; Thu, 30 Sep 2021 11:36:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=/gsG+dDfg+OEmiWFR9f128A++n69MzAw+gEWwpvDIp8=;
        b=VNu/trbhf4rcGgiRp4aVF6Dbtrkt79akhd6yrEfkZfun1GP5HxZ0L6MkNb3GGdZzqD
         D5qqS5NprqVDLe0eu1PukY8wmYjZcN5LiSA5bCPShIME6izBkbl72ztJ9Kh79ZmmwOw1
         aDflBwa5WWuEn0hC8XbqsTIRC7nfRnQMNAJGo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=/gsG+dDfg+OEmiWFR9f128A++n69MzAw+gEWwpvDIp8=;
        b=IN4iAD/dCVrdYdB1rFAPrhAPPux/Gv9zx9YGC+5BBwK/eGA0L5gMunj9LoqcuntBUZ
         YC1IcNetH+CfwgOCKqhPIrv8LIf/+iE0Kfr/z4Qk7EMDmYd65W7YCA+Yt6WGBperQfch
         LY+w9fQRD9co1up4kdUTLzeMCU3ZlNU6Irr5vMBamdOfKhplNbQMb2DHfJyBUYzMIDfg
         oEqMZ2QmADJm6VnxKChw4flRhHFfsi0Qj5eJVSDWk/KPl1LrHI0g/6XWDS605xnSYX2r
         c/G53wngh9wmpU2KhWLMkQfw4ObJVHe7ZUo1T3dmMMBKkh6PdQcYVapSzUY9Z2p1n7gs
         +Kxg==
X-Gm-Message-State: AOAM5322GBKIozrDX++a6xvg+G8xw0nXVgaUn9Qgb0EgSEnS+IQCsT4v
        S6EpTMmuZOaMNZ+a5HqiT932+Q==
X-Google-Smtp-Source: ABdhPJy/VN7qqOla/6qjAbLdd2x2NzBnIjBETF+KYtliEJ0+Bw6n+RPnkokM4Wyn7Uc4E+RacBpj2A==
X-Received: by 2002:a62:3893:0:b0:44b:9369:5de5 with SMTP id f141-20020a623893000000b0044b93695de5mr5707789pfa.40.1633026987872;
        Thu, 30 Sep 2021 11:36:27 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id o14sm3781682pfh.145.2021.09.30.11.36.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Sep 2021 11:36:27 -0700 (PDT)
Date:   Thu, 30 Sep 2021 11:36:26 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Alexander Popov <alex.popov@linux.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Paul McKenney <paulmck@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Joerg Roedel <jroedel@suse.de>,
        Maciej Rozycki <macro@orcam.me.uk>,
        Muchun Song <songmuchun@bytedance.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Petr Mladek <pmladek@suse.com>,
        Luis Chamberlain <mcgrof@kernel.org>, Wei Liu <wl@xen.org>,
        John Ogness <john.ogness@linutronix.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Alexey Kardashevskiy <aik@ozlabs.ru>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Jann Horn <jannh@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Will Deacon <will.deacon@arm.com>,
        David S Miller <davem@davemloft.net>,
        Borislav Petkov <bp@alien8.de>,
        kernel-hardening@lists.openwall.com,
        linux-hardening@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, notify@kernel.org
Subject: Re: [PATCH] Introduce the pkill_on_warn boot parameter
Message-ID: <202109301132.E29DB764E8@keescook>
References: <20210929185823.499268-1-alex.popov@linux.com>
 <d290202d-a72d-0821-9edf-efbecf6f6cef@linux.com>
 <20210929163143.aa8b70ac9d5cf0b628823370@linux-foundation.org>
 <de96ffec-bbd8-2724-9285-0867cd9a08a0@linux.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <de96ffec-bbd8-2724-9285-0867cd9a08a0@linux.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 30, 2021 at 09:27:43PM +0300, Alexander Popov wrote:
> On 30.09.2021 02:31, Andrew Morton wrote:
> > On Wed, 29 Sep 2021 22:01:33 +0300 Alexander Popov <alex.popov@linux.com> wrote:
> > 
> >> On 29.09.2021 21:58, Alexander Popov wrote:
> >> [...]
> >> If you are fine with this approach, I will prepare a patch adding the
> >> pkill_on_warn sysctl.
> > 
> > Why do we need a boot parameter?  Isn't a sysctl all we need for this
> > feature? 
> 
> I would say we need both sysctl and boot parameter for pkill_on_warn.
> That would be consistent with panic_on_warn, ftrace_dump_on_oops and
> oops/panic_on_oops.

If you want to change it at runtime, just make a sysctl: it will
be available as a bootparam since v5.8. See commit 3db978d480e2
("kernel/sysctl: support setting sysctl parameters from kernel command
line")

-- 
Kees Cook
