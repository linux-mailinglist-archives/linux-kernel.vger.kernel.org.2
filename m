Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 316513B1EBB
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jun 2021 18:32:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230019AbhFWQei (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Jun 2021 12:34:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229660AbhFWQef (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jun 2021 12:34:35 -0400
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8988DC061574
        for <linux-kernel@vger.kernel.org>; Wed, 23 Jun 2021 09:32:17 -0700 (PDT)
Received: by mail-pg1-x529.google.com with SMTP id y14so2193125pgs.12
        for <linux-kernel@vger.kernel.org>; Wed, 23 Jun 2021 09:32:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=YLifFSZi/+bGptXglQ0Y5rGhT/pS0AbjzsR58j9fOLM=;
        b=P+rFTJW/zmzSqUJ1hSNr6H2ARNIaejgo0K0y/d9v4USJ4jFCOQRIeL2AE1Ksg1XT3Y
         SEf5ewosYZ8ckiFrjVZNAuWOYBq33toT0rmgGoaskzk/3ImZZNBtKAqB30slDizxA08t
         Cjv6eB324n4QXg8JLNfJup0uIqxDk0qIPAb+0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=YLifFSZi/+bGptXglQ0Y5rGhT/pS0AbjzsR58j9fOLM=;
        b=Yw7YiqB6RQ6qEazT99//4pRPSus01g2zyWgW64yY7TeJ9G2tHdbgjg3jtGEul9xbuV
         +JY58PMaR3XmNzIwC+2AqYBOlQKRZ9e5N7IwqbvVFUQxFJE1gjEcxD991VoliO5EWSKv
         3yg79rZQWDXoeANwkGTh3DM75e156FDtYSQFuSXiNjmSXzmXpKappjACz+O0mTNC2HmT
         Z4r/E+0mEuyCygeyBoVwSbOdpBoJkoTBWlgO/gngev+CWg3P5G/0XMysirmF47PyDt4m
         l9PZmECsIePeQge8u+ZBmAod13Qe6dyeFJgu/Q0wxRHSiKWIAE4FRPnK/ejYvwNNbLYf
         zSkA==
X-Gm-Message-State: AOAM533/5C5dU5ONkdggQ0JtIH5nBh3+SY6G8yetWm2TYncVPlct4SFd
        VckmE9OSVbJP4EH9rU5BL0YWgQ==
X-Google-Smtp-Source: ABdhPJxM6mZ4LoEBla31eRVcezoQntUSNvys2irfkl2e5xZvvklWUKpLZeDrkVx/2PaoMv7bFYg+Yw==
X-Received: by 2002:a05:6a00:1481:b029:304:87ea:8dcc with SMTP id v1-20020a056a001481b029030487ea8dccmr593663pfu.46.1624465937110;
        Wed, 23 Jun 2021 09:32:17 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id x5sm370399pfu.116.2021.06.23.09.32.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Jun 2021 09:32:16 -0700 (PDT)
Date:   Wed, 23 Jun 2021 09:32:15 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Nathan Chancellor <nathan@kernel.org>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Nick Desaulniers <ndesaulniers@google.com>,
        Sami Tolvanen <samitolvanen@google.com>,
        clang-built-linux@googlegroups.com
Subject: Re: [PATCH 1/2] ACPI: bgrt: Fix CFI violation
Message-ID: <202106230932.198A54C1B8@keescook>
References: <20210623013802.1904951-1-nathan@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210623013802.1904951-1-nathan@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 22, 2021 at 06:38:01PM -0700, Nathan Chancellor wrote:
> clang's Control Flow Integrity requires that every indirect call has a
> valid target, which is based on the type of the function pointer. The
> *_show() functions in this file are written as if they will be called
> from dev_attr_show(); however, they will be called from
> sysfs_kf_seq_show() because the files were created by
> sysfs_create_group() and the sysfs ops are based on kobj_sysfs_ops
> because of kobject_add_and_create(). Because the *_show() functions do
> not match the type of the show() member in struct kobj_attribute, there
> is a CFI violation.
> 
> $ cat /sys/firmware/acpi/bgrt/{status,type,version,{x,y}offset}}
> 1
> 0
> 1
> 522
> 307
> 
> $ dmesg | grep "CFI failure"
> [  267.761825] CFI failure (target: type_show.d5e1ad21498a5fd14edbc5c320906598.cfi_jt+0x0/0x8):
> [  267.762246] CFI failure (target: xoffset_show.d5e1ad21498a5fd14edbc5c320906598.cfi_jt+0x0/0x8):
> [  267.762584] CFI failure (target: status_show.d5e1ad21498a5fd14edbc5c320906598.cfi_jt+0x0/0x8):
> [  267.762973] CFI failure (target: yoffset_show.d5e1ad21498a5fd14edbc5c320906598.cfi_jt+0x0/0x8):
> [  267.763330] CFI failure (target: version_show.d5e1ad21498a5fd14edbc5c320906598.cfi_jt+0x0/0x8):
> 
> Convert these functions to the type of the show() member in struct
> kobj_attribute so that there is no more CFI violation. Because these
> functions are all so similar, combine them into a macro.
> 
> Fixes: d1ff4b1cdbab ("ACPI: Add support for exposing BGRT data")
> Link: https://github.com/ClangBuiltLinux/linux/issues/1406
> Signed-off-by: Nathan Chancellor <nathan@kernel.org>

Thanks for solving this!

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
