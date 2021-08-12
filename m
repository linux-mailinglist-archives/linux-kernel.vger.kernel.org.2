Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B39E83EAB46
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Aug 2021 21:48:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229649AbhHLTrw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Aug 2021 15:47:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233827AbhHLTrs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Aug 2021 15:47:48 -0400
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB4DAC061756
        for <linux-kernel@vger.kernel.org>; Thu, 12 Aug 2021 12:47:22 -0700 (PDT)
Received: by mail-lj1-x232.google.com with SMTP id n6so12139368ljp.9
        for <linux-kernel@vger.kernel.org>; Thu, 12 Aug 2021 12:47:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=qvJKGlWHYO3//41xezQGyYw8UJPBhP9SV/wrzkVnfUg=;
        b=AUs/6E5pat8I1fJyokuzJ4JusHDOSzN8l8aLgcRKdeX9KtFEnjzIHVGQdcH063XmfT
         L8DrUiW6+JuEMuQC+wAGDiPlauZ+ZGgfEZy6Hrg3UFXrhpqsYhRXtJQHLBh5XGNbgpX7
         83yl7MPZl9r+GoQJo4BF9ZBIUxpzEhatDUq+k4EAwg+NIgBIRuyAW10g+IizHwKpxIHb
         847iKykQwPT5omTEY2WlTF1HgzWUmeOaC19PYgZ2wDBnaIyoEdyh3RD6Aih510c3+Vnm
         DRXzLzeWm6eHwzLx5H9Hv5lza0imbE9IoOK69rZN1IyLr3wzEN2CKTy1VUXXn5SIw4xu
         G1zQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=qvJKGlWHYO3//41xezQGyYw8UJPBhP9SV/wrzkVnfUg=;
        b=ZGDACKievVXp2pLDY/vRda+5B9ZEv7bZrFauGDJitTG2iTOM35AVbsuTTC7T/i7gIw
         n9Y8/qHKmQClUWh/j+yV3cYJJ/KxIOe7DrL5lBBXqDDOYXvVFIlLa8cfuLRofboYxA8g
         Y1+Zgn5KdENrn9pGFAJpgNxlB0rnpYoiQzWmIuRyLFECgiGWPsSAnUe+PzIArv9jcPYc
         wB8se3+j9c4DU4Vrr45zI1vI9AQ9GJ15Ez3taZOW7JqriOpzv2gmSjVZipLY0/hL2qpc
         7t4TFYnl0Xx9MjIOJMkgALlIu74Z8D9Jfjv/ra9bhQ6BhF7RPBoRF4BD1x6h0yhYwiN2
         RkgQ==
X-Gm-Message-State: AOAM533tYBs43+HjdtAoUvxSmerP2Frbx+nt9VMpW3XibLUzx/jsT7QI
        gZ7fgCTcB0mc5mnjDthsQbw=
X-Google-Smtp-Source: ABdhPJwIhlxh4ESyiW4L2//MiwHAba42FQDaW0aluqa0AZC1HcLLHgT146f/MNqVD6oSzGONYjOJ1A==
X-Received: by 2002:a2e:9b44:: with SMTP id o4mr3981428ljj.421.1628797641352;
        Thu, 12 Aug 2021 12:47:21 -0700 (PDT)
Received: from localhost.localdomain (ip-194-187-74-233.konfederacka.maverick.com.pl. [194.187.74.233])
        by smtp.googlemail.com with ESMTPSA id j17sm411739ljq.136.2021.08.12.12.47.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Aug 2021 12:47:20 -0700 (PDT)
Subject: Re: [PATCH 3/5] arm64: Detect disabled HVC early
To:     Marc Zyngier <maz@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        bcm-kernel-feedback-list@broadcom.com, kernel-team@android.com
References: <20210812190213.2601506-1-maz@kernel.org>
 <20210812190213.2601506-4-maz@kernel.org>
From:   =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>
Message-ID: <11c7b042-885f-ad48-7c5f-ad3dbd8f0340@gmail.com>
Date:   Thu, 12 Aug 2021 21:47:18 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <20210812190213.2601506-4-maz@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12.08.2021 21:02, Marc Zyngier wrote:
> Having HVC disabled from EL3 while the kernel is entered at EL2
> is a complete nightmare.
> 
> We end-up taking an UNDEF at the worse possible moment (checking
> for VHE) and even if we didn't, having KVM enabled would signify
> the premature end of the kernel.
> 
> Instead, try and detect this stupid case by issuing a HVC
> for HVC_RESET_VECTORS, which does nothing when the stubs
> are live. If we get HVC_STUB_ERR back, that's because the
> UNDEF handler has kicked in.
> 
> In this situation, close your eyes, block your nose, and gracefully
> pretend we have booted at EL1.
> 
> Reported-by: Rafał Miłecki <zajec5@gmail.com>
> Signed-off-by: Marc Zyngier <maz@kernel.org>

This does the trick.

Tested-by: Rafał Miłecki <rafal@milecki.pl>
