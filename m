Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9488042A847
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Oct 2021 17:30:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237437AbhJLPcn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Oct 2021 11:32:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230195AbhJLPcl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Oct 2021 11:32:41 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0913BC061570
        for <linux-kernel@vger.kernel.org>; Tue, 12 Oct 2021 08:30:40 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id nn3-20020a17090b38c300b001a03bb6c4ebso2865267pjb.1
        for <linux-kernel@vger.kernel.org>; Tue, 12 Oct 2021 08:30:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=TfDE9ZUAcmOATfjLktcMPKqJ6doc4gXzdjz4TB6YrkY=;
        b=XQ714SCa05nbl3Kx5Iv5bOJ9Z22hs4OfoU4JyXsreke2yyTYXseWtDKp2fPOustZQP
         VsgVb6M+C8zpnPMAEf4aRwFUtViwSic3UiCwZbZq/qziBdc2L3aMnWfmv7HYPxLBDhJV
         5xwF1SwVmGUwsHtESqh7FTZ+z9j8pIVDd2ibWkdrn4ZsxBleIGXp/hJeZiRCRX022zBP
         oUETEl/u+noeY4+1RxiU2mdx4eBsla7TJAJh79S6bN1IYPKvy69ByW5BpNpAxmMGLs6H
         uOosLnyM5CGf3CN9Blxd6fcA7g3kp3RYTYrpSr6MJ9fiUM/dyEIxSjAfWiqdI18EReL/
         q5mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=TfDE9ZUAcmOATfjLktcMPKqJ6doc4gXzdjz4TB6YrkY=;
        b=ASoNfR1wi+E2HCsK6583CPDvHVLZMr/5xrAB6phEynoh8H5tckG9CvlDQZ9RWagQnD
         +IIoKgFN2xV2zcFUOZaj3DFppeHq4f6sx0hl0qJ8a5kg8Ts9F3RBJrAKFUTm5hnEpa+K
         ftyIAqmxprDoLi6kQOgv7Eh/n2fC/dgcbJvrlXM2JETcB1Y1ZQMEJhlcLY0cthWoH146
         ZgaG8dcfNmt98Mgpr99ea9eYRKUhwRqCvcFhXpcBAzZA5VI5LnUMFox+7U3NPp3gsnbK
         Y5J79HIyAInkYTGnQbnWu98slfiD4zWNhhOGqr3RFm6sTMGhUGpP+IlyvjsBEBuOil2O
         frQw==
X-Gm-Message-State: AOAM53132Xed2jacty18K8YCwUwBMv+mAWCVMNViOzbksIHr/t4ouppJ
        nJSF8QvgvQDbNmnssGuZfBLi4w==
X-Google-Smtp-Source: ABdhPJxXWkKjnW2UnbeWYwxHXFRxUbaX6Kw8+nLSEyxkzFbkjUZJ10najaHRGdsL/8H+IMC8T0aU0w==
X-Received: by 2002:a17:902:8648:b0:13e:dc2c:a594 with SMTP id y8-20020a170902864800b0013edc2ca594mr31093417plt.23.1634052639326;
        Tue, 12 Oct 2021 08:30:39 -0700 (PDT)
Received: from google.com (157.214.185.35.bc.googleusercontent.com. [35.185.214.157])
        by smtp.gmail.com with ESMTPSA id i124sm11739472pfc.153.2021.10.12.08.30.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Oct 2021 08:30:38 -0700 (PDT)
Date:   Tue, 12 Oct 2021 15:30:35 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc:     Reiji Watanabe <reijiw@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        syzkaller-bugs@googlegroups.com, linux-kernel@vger.kernel.org,
        syzbot <syzbot+9fc046ab2b0cf295a063@syzkaller.appspotmail.com>
Subject: Re: [syzbot] WARNING in static_key_slow_try_dec (2)
Message-ID: <YWWqG3xF6KAHBU2O@google.com>
References: <00000000000029c95905c9742a31@google.com>
 <611efcc8-76f7-34fc-306d-412957f81093@I-love.SAKURA.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <611efcc8-76f7-34fc-306d-412957f81093@I-love.SAKURA.ne.jp>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 10, 2021, Tetsuo Handa wrote:
> Hello.
> 
> Commit 4547700a4d190ac4 ("KVM: x86: Consolidate APIC base RESET initialization code")

That's definitely where the error was made visible, but commit 421221234ada ("KVM:
x86: Open code necessary bits of kvm_lapic_set_base() at vCPU RESET") is the real
culprit.  I'll send a patch later today.  I'm leaning toward a partial revert with
some extra comments.

Thanks for the debug!  I was having trouble reproducing the syzbot report.
