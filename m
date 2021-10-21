Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C3DF7436472
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Oct 2021 16:37:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231220AbhJUOjv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Oct 2021 10:39:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230072AbhJUOju (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Oct 2021 10:39:50 -0400
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56034C0613B9
        for <linux-kernel@vger.kernel.org>; Thu, 21 Oct 2021 07:37:34 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id f11so798671pfc.12
        for <linux-kernel@vger.kernel.org>; Thu, 21 Oct 2021 07:37:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=hWMulavHguDBRCrVKyFBVx7gMZcaLDBqhj8CvP80Q7E=;
        b=iAmCvh52C6lmCYBo5ZiN5hHCAu2fAkWo/EasINRykyHBmAETWy8beZzvcus5tEkwRm
         7Ljfn0XrTNszaIj6pRrjgqoTow7+xQL2Qqd2li6ADiIk1ZH+53YX4Rrje9ReuzejsKQt
         WZ5qd6woEpPksRm5JkUKkrpCIpuTDlAtVAIgjBOlULlq2ksuCSswqzryjON+C7/l44Pl
         ABVgQ0AwVNxXh9ZFicLf4H+a8gTtvOaMIxXM7UFNKbFngZl3mfE/eHHeeRYRFraAgP3k
         w7fIedfNV4u5amqVkV8ZPpz8vHcKblaYRrLiZENkAqVHEy5qLh5a2/a/L6R9sBdWYWcF
         j++Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=hWMulavHguDBRCrVKyFBVx7gMZcaLDBqhj8CvP80Q7E=;
        b=zMaW8MbwFAimxkqiToG/sQ7E6soSyMQIVg0Ss3A3LS8Cz5cWSHn8u6JvvEAv9yx2qJ
         0FOKbGLsDoFLWv0QbtUCOekwZmxDLMKeb4Mk+Ttv+8KiW/KqivN6NtfFtlOHXj2NCTSY
         kZaov2ZBj8+IrQ8IM+ky3t4qTnkn8rkqyt9m0onMI/EzEXiN4BNDoFA3xL81/Vl6XZ54
         7v4aXwPIWItpm42PFD1QpX4HG1zU38P+q2RmHFch8lafG6Fxihmx9yecxTcchUFL3jBA
         L2MidyGeTDqltQ6KXvgLah0Q/nMKy7uoBUtphkuxSeJW6FhWQjojmXeIAUf+F+N8Pxc3
         A0xg==
X-Gm-Message-State: AOAM533G0KcamIw+1NXOLejmuiOL8k/sZoZEKUaT/yh30xiz1DK0/h4C
        EO2fGYXoroLb5tHDRbMpLWir6Q==
X-Google-Smtp-Source: ABdhPJyjDdV/DmdDuhG8h5Y8UWuU/WoJYOGcrVrT73FmJenSSbHocJoQBYDDbyDIZYNHHR5dMzTsOA==
X-Received: by 2002:a62:6543:0:b0:44c:61a0:555a with SMTP id z64-20020a626543000000b0044c61a0555amr5748532pfb.14.1634827053748;
        Thu, 21 Oct 2021 07:37:33 -0700 (PDT)
Received: from leoy-ThinkPad-X240s ([148.163.172.147])
        by smtp.gmail.com with ESMTPSA id z19sm6182867pfj.156.2021.10.21.07.37.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Oct 2021 07:37:33 -0700 (PDT)
Date:   Thu, 21 Oct 2021 22:37:26 +0800
From:   Leo Yan <leo.yan@linaro.org>
To:     James Clark <james.clark@arm.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Kees Cook <keescook@chromium.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        Sami Tolvanen <samitolvanen@google.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        James Morse <james.morse@arm.com>,
        Marc Zyngier <maz@kernel.org>, Joey Gouly <joey.gouly@arm.com>,
        Peter Collingbourne <pcc@google.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Stephane Eranian <eranian@google.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [RFCv1 1/4] arm64: Use static key for tracing PID in CONTEXTIDR
Message-ID: <20211021143726.GA213960@leoy-ThinkPad-X240s>
References: <20211021134530.206216-1-leo.yan@linaro.org>
 <20211021134530.206216-2-leo.yan@linaro.org>
 <53962765-53b9-dfdc-a5b2-a3133a924c12@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <53962765-53b9-dfdc-a5b2-a3133a924c12@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi James,

On Thu, Oct 21, 2021 at 03:33:01PM +0100, James Clark wrote:

[...]

> > +static int __init contextidr_init(void)
> > +{
> > +	if (IS_ENABLED(CONFIG_PID_IN_CONTEXTIDR))
> > +		static_branch_inc(&contextidr_in_use);
> > +	return 0;
> > +}
> > +early_initcall(contextidr_init);
> 
> Hi Leo,
> 
> Can you skip this early_initcall() part if you do something like this:
> 
>     DECLARE_STATIC_KEY_MAYBE(CONFIG_PID_IN_CONTEXTIDR, contextidr_in_use)
> 
> It seems like there is a way to conditionally initialise it to true.

Thanks for good point!  Will test this way in next spin.

Leo
