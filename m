Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A1B3732307D
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Feb 2021 19:19:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233932AbhBWSSN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Feb 2021 13:18:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233925AbhBWSR5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Feb 2021 13:17:57 -0500
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43559C061786
        for <linux-kernel@vger.kernel.org>; Tue, 23 Feb 2021 10:17:16 -0800 (PST)
Received: by mail-pj1-x102a.google.com with SMTP id e9so2528855pjj.0
        for <linux-kernel@vger.kernel.org>; Tue, 23 Feb 2021 10:17:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Y+dGVUVowl982SXOXFEzMTklpUA2xojQW2q8oSyCS6I=;
        b=hLlvm2pVK0Tz7gEpiQShUAvdZF/IEHfPu0Kiyd+yuYnxHe+j3lKQ6Hce/7/XunIp3A
         q++MGoX5hbc/X8vmJr5bAihBTazw7Lk276BfU6lFRHFOumUJ/OlX1TtWXUN+VNN5tKBX
         MaSB9/1KfbC1h4lcYuyqBfJ/CdYELcxsbBmVI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Y+dGVUVowl982SXOXFEzMTklpUA2xojQW2q8oSyCS6I=;
        b=Ph2StxTxpYOEjJrHyx0LAOoLI2CVFDSghbPNaHs1dAGdhPCCTyhUaPnmiakN2jvq9e
         K0d1qRudRfCL46+ozYA99K7UDUYa4jmeHHtkewqOUe1gGvHJTOBy0l3MQcsOMFWasYip
         OpG+5TQKgLL6wTK9mknu31c4e1kwKZZvxm28XsRMSMKo0/n0RY87Rp25xzHxx1AT2e1v
         XtXBbodq/SYV2FUNP7yMcR6uoLYeDVrCsCB10VjK7vgevRZGyUnpQdkDL+4ssm69Y9gk
         JjaRHmZJuljPUIqcup2O1+dN6k/aKrAGvROTu4cDX4DhvCiIu3oABtXxPL4OFuT9+Y53
         0Pqg==
X-Gm-Message-State: AOAM531MuA+tx7VMJw04XpBL7btCrMCqu0RDanzMmOS1zUctHferXWfn
        wuqpAnqD39lfB5dttsVmY9RzwA==
X-Google-Smtp-Source: ABdhPJz8B/KxyGd7uKaiNrrvu7+6j8zBuQCllq2oJBJ+c5r7iIP18af71apeteJfXqcChixTyEc6ig==
X-Received: by 2002:a17:90a:4882:: with SMTP id b2mr63805pjh.78.1614104235871;
        Tue, 23 Feb 2021 10:17:15 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id v26sm22964666pff.195.2021.02.23.10.17.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Feb 2021 10:17:15 -0800 (PST)
Date:   Tue, 23 Feb 2021 10:17:14 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Heiko Carstens <hca@linux.ibm.com>
Cc:     Guenter Roeck <linux@roeck-us.net>,
        Masahiro Yamada <masahiroy@kernel.org>,
        linux-hardening@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Arnd Bergmann <arnd@kernel.org>
Subject: Re: [PATCH] gcc-plugins: Disable GCC_PLUGIN_CYC_COMPLEXITY for s390
Message-ID: <202102231016.F212B396@keescook>
References: <20210221225650.33134-1-linux@roeck-us.net>
 <YDOeI5+1H3T1ocmQ@osiris>
 <f35196cc-969f-21ef-0c38-dc6e13831fb0@roeck-us.net>
 <CAK7LNASdfvJsqq8ubpBZJ5yWPMimt=pF_GFBLTJbFytbtw8jxg@mail.gmail.com>
 <8d3de6fc-0991-9cef-d5fd-032fdbe2e85e@roeck-us.net>
 <YDTs4vfjezu3j7rX@osiris>
 <20210223174140.GA159796@roeck-us.net>
 <YDVDg/EZWjCZQn2v@osiris>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YDVDg/EZWjCZQn2v@osiris>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 23, 2021 at 07:03:47PM +0100, Heiko Carstens wrote:
> Well, if we would have e.g. RANDCONFIG, then we could probably revert
> 334ef6ed06fa ("init/Kconfig: make COMPILE_TEST depend on !S390") and
> instead let COMPILE_TEST depend on !RANDCONFIG.
> I think this _could_ solve all common problems we currently see.
> 
> And it would also do what you suggested.

I've wanted similar (e.g. for some UBSAN options that would go weird
under RANDCONFIG). :)

-- 
Kees Cook
