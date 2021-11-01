Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 484CF441D6C
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Nov 2021 16:28:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232584AbhKAPbT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Nov 2021 11:31:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231362AbhKAPbS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Nov 2021 11:31:18 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3B8AC061714
        for <linux-kernel@vger.kernel.org>; Mon,  1 Nov 2021 08:28:44 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id nh10-20020a17090b364a00b001a69adad5ebso238339pjb.2
        for <linux-kernel@vger.kernel.org>; Mon, 01 Nov 2021 08:28:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=4nczZzPOROr/Kyy51BrycrxkeBsFlmOfWA3LpP384+8=;
        b=B8Z2fR33FZt++MnFctR1qPORvENn/ikeBgkvySxKjGFAVBKRckfbvj8w/pwET/S81l
         FKz8AYS5aaLNspjsDgpypoKbUE2O5wJ4B8nQ6dYUimjg/947Es3W7bLdQ4LycVaHOQLK
         rTFpdV04JIR48pIW4m+EIPcXZ45vNgVIjtROynE5Tp7yFOic/rygPsuLxqS0pwW+VeuB
         7PkllgMKOp9vrY8rf9SOu5SY3XSHktDgJVusBF/LV4cL/Bs7uZ/f8Z0jTACUaVPRkIwm
         M0FzXZBtNB3uTP08iUGuiz63TtwDcgEfHuGNPsr6cLS3sTiWRDj3lItmUfQbe35aN8eB
         3QLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=4nczZzPOROr/Kyy51BrycrxkeBsFlmOfWA3LpP384+8=;
        b=xgMl3Fo6tKxOe2cylNUiZLxrR8UIF3QluTBaex2glQS/ertCgf7lhWr1WMB5KjplcB
         PwAVlhn+eyrYgl5edyLNYm3wu9Qhw40DumqKSj/4WvZBgg27xKTdklG5Xct14oM+fFq4
         8JpeKsH/4zPEkRVp9haRvrwEJmcBphxMII9hoy8bj/8ANpAkxeBHrUKd9YwvcBBPRCVs
         3oZ+4SDvTEM3Vdm6w+8NafXbu1V58845P6YMZvysPKmtiy+qRawLfO2oIeXVaKCYlElO
         nuE8HchnKdSl01gVrx3Ejl7hslpTFYtDHAuKeemtOZutxI9rI3GAU7YCNM6xn+rs/ACa
         4XVg==
X-Gm-Message-State: AOAM533xpjl1dlrnwfhAo6YIktKyEDexIvnQaJvKJgu/dwHbXT5/6Iko
        dGiIFnYw04AtPAG6V4rffGrPxg==
X-Google-Smtp-Source: ABdhPJw/46wh7WVg32S3b5SUGL+jz4NvUZ1xwsb2hzAEG92vkUqDXT5Ic1JNg+rvBW7cERoss/7a1w==
X-Received: by 2002:a17:902:6b86:b0:13f:8d7a:397c with SMTP id p6-20020a1709026b8600b0013f8d7a397cmr26145198plk.50.1635780524336;
        Mon, 01 Nov 2021 08:28:44 -0700 (PDT)
Received: from leoy-ThinkPad-X240s ([103.136.124.227])
        by smtp.gmail.com with ESMTPSA id c21sm2974143pfv.119.2021.11.01.08.28.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Nov 2021 08:28:43 -0700 (PDT)
Date:   Mon, 1 Nov 2021 23:28:35 +0800
From:   Leo Yan <leo.yan@linaro.org>
To:     Kees Cook <keescook@chromium.org>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Sami Tolvanen <samitolvanen@google.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        James Morse <james.morse@arm.com>,
        Marc Zyngier <maz@kernel.org>, Joey Gouly <joey.gouly@arm.com>,
        Peter Collingbourne <pcc@google.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Stephane Eranian <eranian@google.com>,
        James Clark <james.clark@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [RFCv1 4/4] perf: arm_spe: Dynamically switch PID tracing to
 contextidr
Message-ID: <20211101152835.GB375622@leoy-ThinkPad-X240s>
References: <20211021134530.206216-1-leo.yan@linaro.org>
 <20211021134530.206216-5-leo.yan@linaro.org>
 <202110210848.35971643C6@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202110210848.35971643C6@keescook>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Catalin, Will,

On Thu, Oct 21, 2021 at 08:49:46AM -0700, Kees Cook wrote:
> On Thu, Oct 21, 2021 at 09:45:30PM +0800, Leo Yan wrote:
> > Now Arm64 provides API for enabling and disable PID tracing, Arm SPE
> > driver invokes these functions to dynamically enable it during
> > profiling when the program runs in root PID name space, and disable PID
> > tracing when the perf event is stopped.
> > 
> > Device drivers should not depend on CONFIG_PID_IN_CONTEXTIDR for PID
> > tracing, so this patch uses the consistent condition for setting bit
> > EL1_CX for PMSCR.
> 
> My own preference here would be to not bother with the new
> enable/disable helpers, but just open code it right here. (Save a patch
> and is the only user.) But I defer to the taste of arm64 maintainers. :)

Before I send out a new version for this patch set (for support
dynamic PID tracing on Arm64), I'd like to get your opinions for two
things:

- Firstly, as Kees suggested to directly use variable
  'contextidr_in_use' in drivers, which is exported as GPL symbol,
  it's not necessarily to add two helpers contextidr_{enable|disable}().
  What's your preference for this?

- Secondly, now this patch set only support dynamic PID tracing for
  Arm64; and there would be two customers to use dynamic PID tracing:
  Arm SPE and Coresight ETMv4.x.  So this patch set doesn't support
  dynamic PID tracing for Arm32 (under arch/arm).

  Do you accept this patch set for enabling PID tracing on Arm64 and we
  can defer to support Arm32 when really need PID tracing on Arm32?
  Or we should enable PID dynamic tracing for Arm64 and Arm32 in one
  go?


Thanks,
Leo
