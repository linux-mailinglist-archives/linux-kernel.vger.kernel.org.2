Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DDAE0460579
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Nov 2021 10:39:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238766AbhK1Jm5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 28 Nov 2021 04:42:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232449AbhK1Jk4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Nov 2021 04:40:56 -0500
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 947D8C061574;
        Sun, 28 Nov 2021 01:37:40 -0800 (PST)
Received: by mail-wr1-x42f.google.com with SMTP id i5so29585935wrb.2;
        Sun, 28 Nov 2021 01:37:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=yS8bp9p4OwbBcDXZwjKduN0ErmvAIr72SeQf1xhGQqA=;
        b=UoLCJ211PuMXgLgOHMXTlOMJQOtUGt+mwX1mOKYjSfUH1AfLHF+UmkiHWcUS5UF4AE
         ilwrZXuqrh3dTmCh5ZAqJdgbzLFK1QTjTpQGhjwzbhnwZXiN8hHE9zlt4gLVGpymLpTW
         b+hCTsRz5ZYjDHJsh3XBnCm5tu/XAI51E3A+ICn3jAqhgK4vMssfe77NHPntUTN66QkN
         KcOFfDJiIIYoUK8KBmkFZVbZB7xRAkVl4TU1X6Po+qXjL8kmCANov4PoeCedx4kmdMzE
         S9/tEr8L8CO0vTuo48oi18DyiX6UvDDXSSTNj46f4MJvVHloYyPyjm4+XUIZkVMdJZ/0
         wSbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=yS8bp9p4OwbBcDXZwjKduN0ErmvAIr72SeQf1xhGQqA=;
        b=Q7WrmpCuX5vLsUGlQRXFGWci+7Eu0yFBFiCUxyDGEjZs38DtbEYu6XL8ptWDCZumlz
         0v/zo3TdmOGQ6lIOyYg94i7JTbu5h6162anCfvs9BHybzl35T2mW+oZ6+IY35xwknX+3
         GkvhFMpVNTxRn4+GKWPaHav1wYZGd1aVKWAhp2/Gwg5LSklA3Rb1bftE/Jf/sKo4aUMX
         vVShDdGBWBsdcXcYrfKevk4mvkxkhPrrP+h3Wz93U6ag8dNWfNz1duyHrDfKMpbjyhNB
         Tu074tUX0AyBp8pcG2cpjAA/SZn52dDMdl6zSjXiXx99PdhdJa1GAPGHthkUUpSqBH3x
         9Icw==
X-Gm-Message-State: AOAM533d+eUPmhyp5/dpWVIklRjfZCui8LOOjyr3E2i0i+6mQD5jhHW/
        71LfN6d4K4ZohQBuQnC6Q6c=
X-Google-Smtp-Source: ABdhPJwDPlBHu0ZPZo7nnrznGM1T0IOJ2mdNfzw9v4BO817dl5OZQrlSy0VbGE6/+AYX1FxdwinhWA==
X-Received: by 2002:adf:fb4f:: with SMTP id c15mr26530815wrs.507.1638092258891;
        Sun, 28 Nov 2021 01:37:38 -0800 (PST)
Received: from [127.0.0.1] (static.235.156.203.116.clients.your-server.de. [116.203.156.235])
        by smtp.gmail.com with ESMTPSA id j17sm15530918wmq.41.2021.11.28.01.37.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 28 Nov 2021 01:37:38 -0800 (PST)
Date:   Sun, 28 Nov 2021 09:37:23 +0000 (UTC)
From:   Fusion <qydwhotmail@gmail.com>
To:     Pasha Tatashin <pasha.tatashin@soleen.com>
Cc:     LKML <linux-kernel@vger.kernel.org>, linux-mm <linux-mm@kvack.org>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Rientjes <rientjes@google.com>,
        Paul Turner <pjt@google.com>, weixugc@google.com,
        Greg Thelen <gthelen@google.com>,
        Ingo Molnar <mingo@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Will Deacon <will@kernel.org>, Mike Rapoport <rppt@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>, masahiroy@kernel.org,
        Sami Tolvanen <samitolvanen@google.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "maintainer:X86 ARCHITECTURE " <x86@kernel.org>,
        frederic@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
Message-ID: <7d339956-27fb-4eb6-bd73-791807ddef56@gmail.com>
In-Reply-To: <CA+CK2bAX2XmMrt9RBGiUV7LG_sbpB7ov6bxMVjr5FSBVirE1CA@mail.gmail.com>
References: <20211123214814.3756047-1-pasha.tatashin@soleen.com> <20211123214814.3756047-3-pasha.tatashin@soleen.com> <6d82e674-76dc-f3b0-2e53-a92eeb249eff@gmail.com> <CA+CK2bAX2XmMrt9RBGiUV7LG_sbpB7ov6bxMVjr5FSBVirE1CA@mail.gmail.com>
Subject: Re: [PATCH 2/3] mm: page table check
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Correlation-ID: <7d339956-27fb-4eb6-bd73-791807ddef56@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I ran journalctl -kf to see what happened when my system freezed.

There are "IPV6 table full" error messages and khugepaged constantly reporting RIPs.

So it could be when memory consumption is over a certain percent, the bug will be triggered.
