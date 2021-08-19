Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D3ADF3F190A
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Aug 2021 14:17:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239526AbhHSMRj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Aug 2021 08:17:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238357AbhHSMRe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Aug 2021 08:17:34 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEFAFC061575
        for <linux-kernel@vger.kernel.org>; Thu, 19 Aug 2021 05:16:57 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id g138so3711137wmg.4
        for <linux-kernel@vger.kernel.org>; Thu, 19 Aug 2021 05:16:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=DmbBtI0MX4mV37QEOZBpQz0wZwSuwbEC/Ht/mZompdc=;
        b=A5gwbJdH3uT5t4EOhCRlMSs/iQIxqrVkJGXSsN3oPtDOIaN5ipSwN9FW3AHLOsWI99
         wRL03l5LtKAdGOGoOEbQ/SyVR0nm4yUdWA8J5ztcuRFQaIng0FcxSEXYXMfxw07+NFad
         TPMLC0pla/bOzO8w9FpnaPggSxEHaAJ+l1zxjxV8JPjTw9PJXYIk6fewZKSESKw+KXak
         coDOvdKWKUyUN6pvMkgGsN9yF9s8J4TEKu2uF/xpk1AyruTSUQOSVGYS4ESAlP2etMEG
         mn+/0cYp+7pO41sielejmm3vkuPE5zzQBvMfM5Y6InlTn1a1KA2qPZ8LioEmRRJSBlw7
         4xmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=DmbBtI0MX4mV37QEOZBpQz0wZwSuwbEC/Ht/mZompdc=;
        b=E61k8AKhZ63nb01JN2N39QtVdDgm+o55iYv+HkDgitKBL6xVHxuX2FPp46VshcX/Yt
         fHmMvVmwDqHhTRNQ4yCqLpTbbhghdHxgAKuebcvxYaLo1fm9MJBqf3C2m6k2LRJwYq9Q
         1c9BMue6lvWBO2EkCcARPsiiUZmP0JerbZEjmmIuDKIfm/iZhhSQgH0cZiN8BJn4bwgr
         bLzqLGYAH9fd9rvcfDQi8xsOX81thOlWGd0sEzxEvSNP1IYl8kmRCItx2ZHRIU71l768
         iqhxqRd3t4Ecd2no9JDX1uoLGrg0xv/+NSIvMBYjsKCI5y3u7z6Qm8vIXPlzm6mrPGKk
         2dXw==
X-Gm-Message-State: AOAM531XyriJCU3PJXbB46F/svbtM9nE/5ua/iZ1AUI1g/Kx6Tnt5tuc
        cCeZL9mUbbNqSPFYks9hchg=
X-Google-Smtp-Source: ABdhPJxfHph4gy6MG9PcL15FNXwk18CdQ04DbHJx5QMwlX14aibTZ7Xy/Y66hwBcSPO6hQC5SoKZAw==
X-Received: by 2002:a1c:1d13:: with SMTP id d19mr11658195wmd.135.1629375416625;
        Thu, 19 Aug 2021 05:16:56 -0700 (PDT)
Received: from agape.jhs ([5.171.80.222])
        by smtp.gmail.com with ESMTPSA id m7sm7284052wmq.29.2021.08.19.05.16.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Aug 2021 05:16:56 -0700 (PDT)
Date:   Thu, 19 Aug 2021 14:16:53 +0200
From:   Fabio Aiuto <fabioaiuto83@gmail.com>
To:     Borislav Petkov <bp@alien8.de>
Cc:     Joerg Roedel <jroedel@suse.de>, Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Hans de Goede <hdegoede@redhat.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: x86/boot/compressed/64: Lenovo Ideapad Miix300 bug report
Message-ID: <20210819121653.GB28768@agape.jhs>
References: <20210819100230.GA28768@agape.jhs>
 <YR4uffjFuqvrz1Tp@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YR4uffjFuqvrz1Tp@zn.tnic>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Borislav,

On Thu, Aug 19, 2021 at 12:12:13PM +0200, Borislav Petkov wrote:
> On Thu, Aug 19, 2021 at 12:02:31PM +0200, Fabio Aiuto wrote:
> > CONFIG_AMD_MEM_ENCRYPT=y
> 
> Lemme see if I understand it correctly: you have this enabled on an
> Intel-based tablet?

Yes I have, as Hans replied I use for rebuild the configuration
provided by Fedora 34 distribution.

> 
> Does it boot plain 5.13.x (without any reverts) fine with that config
> item disabled?

I rebuilt a plain v5.13 kernel (no reverts) with that config
disabled and everything goes fine.

> 
> -- 
> Regards/Gruss,
>     Boris.
> 
> https://people.kernel.org/tglx/notes-about-netiquette

thank you,

fabio
