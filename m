Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BFF863592B4
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Apr 2021 05:12:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233130AbhDIDMf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Apr 2021 23:12:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232858AbhDIDMe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Apr 2021 23:12:34 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58DD5C061761
        for <linux-kernel@vger.kernel.org>; Thu,  8 Apr 2021 20:12:22 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id g15so3307175pfq.3
        for <linux-kernel@vger.kernel.org>; Thu, 08 Apr 2021 20:12:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=98rLvZCmnQ/zeXNU0bVp1eGzsTNFjth6OQkgD5+zTmc=;
        b=QC7uiE5g3WqVuzOP3qDsLFIeonLQW1s63M1BMhEBg7i4VdbDgmqxKAv2nHXkDqqSrm
         jR9J8IV2vWtwI9N+rW4OUTVI/k5tZJH0ydjt/IWoT21JKiXAQXYC6hI7mOssoloIHGdW
         yYg7aNNaqV4ONGdbtilHlk0VGcpH/r6bnDpfM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=98rLvZCmnQ/zeXNU0bVp1eGzsTNFjth6OQkgD5+zTmc=;
        b=VkDY64ZcB2bnPeigfzbl2axHUr7cOiosnzyPT4GPk5Ledv7qNDEJi9wS57emKShVdt
         RLqcznMP31chZRDzu4LN2AJjxee5g0//oekqYaj4QnAPFVmCelAmylGlb5H7JYDa3OqK
         wayrSKoRpAmqWs1faAiFFdy1011PXg2uBbht8ZZ9GQhqYZdXYVlh9F3QVckckbhD7gxk
         MecHMCpzyCL0ABICIBf8NTYKeA3+e0W5ovoFmFYxbI3hKZnWfrfeH1u64tYTvKknffc7
         pUT1UE2V0EbspnH9xXy+IFdgmai9dHJ/ijhdmmFb385HZUrueJqpSmWF1n3dP3EFSgpv
         Twnw==
X-Gm-Message-State: AOAM532rs2Z5AshmM1vkr9cAPIfcogUwqHAN7RBaLv4X0qu35EiVEg4S
        I9o35/PO/sz/ozOb+XyEeYQDCw==
X-Google-Smtp-Source: ABdhPJz+J00qa6z+jE+gcgcSORj/Wu/iET67E1kp3PW4H6L7XI74dOeTF7MO4INTtfo9n3zhpIWwpw==
X-Received: by 2002:aa7:9533:0:b029:241:9d92:92e1 with SMTP id c19-20020aa795330000b02902419d9292e1mr10590961pfp.14.1617937941935;
        Thu, 08 Apr 2021 20:12:21 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id b7sm684889pfd.55.2021.04.08.20.12.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Apr 2021 20:12:21 -0700 (PDT)
Date:   Thu, 8 Apr 2021 20:12:20 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        linux-kbuild@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        "David S. Miller" <davem@davemloft.net>,
        "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Borislav Petkov <bp@alien8.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Greentime Hu <green.hu@gmail.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Helge Deller <deller@gmx.de>, Ingo Molnar <mingo@redhat.com>,
        Ley Foon Tan <ley.foon.tan@intel.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nick Hu <nickhu@andestech.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Rich Felker <dalias@libc.org>,
        Russell King <linux@armlinux.org.uk>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Vincent Chen <deanbo422@gmail.com>,
        Will Deacon <will@kernel.org>,
        Yoshinori Sato <ysato@users.sourceforge.jp>, x86@kernel.org
Subject: Re: [PATCH 00/20] kbuild: unify the install.sh script usage
Message-ID: <202104082011.AEC1B6CEB@keescook>
References: <20210407053419.449796-1-gregkh@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210407053419.449796-1-gregkh@linuxfoundation.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 07, 2021 at 07:33:59AM +0200, Greg Kroah-Hartman wrote:
> Almost every architecture has copied the "install.sh" script that
> originally came with i386, and modified it in very tiny ways.  This
> patch series unifies all of these scripts into one single script to
> allow people to understand how to correctly install a kernel, and fixes
> up some issues regarding trying to install a kernel to a path with
> spaces in it.

Yay consolidation! Thanks for digging into this.

I sent Reviewed-by:s for a bunch of these, and agree with the things
Masahiro has suggested with regard to quoting, etc. I look forward to
v2.

-Kees

-- 
Kees Cook
