Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 08DBE40D299
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Sep 2021 06:37:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234176AbhIPEjB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Sep 2021 00:39:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229521AbhIPEiz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Sep 2021 00:38:55 -0400
Received: from mail-qt1-x836.google.com (mail-qt1-x836.google.com [IPv6:2607:f8b0:4864:20::836])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB730C061574
        for <linux-kernel@vger.kernel.org>; Wed, 15 Sep 2021 21:37:34 -0700 (PDT)
Received: by mail-qt1-x836.google.com with SMTP id w17so4465657qta.9
        for <linux-kernel@vger.kernel.org>; Wed, 15 Sep 2021 21:37:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:mime-version;
        bh=46Znz0XYZqV75w6izLj//kO1BgimfrMuJbKT3BGaj6M=;
        b=lKin/00yJ3QV0ZPXNwy0wElLK3yLuJpYoEjOujEyU1KsneBgGbJgJzYHLQKXrB0r+n
         lz5ZTJlLijJTcFcmv+RCY7Q2WsNE5GTqSXqyOmp7HrAvulxf8PYU+caay/tqSAZZ60yY
         uCzsbTna3kBhInt8rFGS8lyZszClChtuCbFb1nUJg7FF175gvBRTv+w0jTQNeQ7goPLo
         wrQNWGYkogttGJWZqQ1q+mIXbxhT368OWYYpqfOFMKfD/Thz2kNU9PulOdYNyLNLHBnj
         FGc2wJDMnMk4D7XsJS7E71l42Cr9Qen/URnvSYbKqWyhaLqzdfpG5u5KI3N2EsmDdVHk
         TrCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version;
        bh=46Znz0XYZqV75w6izLj//kO1BgimfrMuJbKT3BGaj6M=;
        b=42LbOJ8C2S+OD5xR9RVE1nAQme9o6mJO1C0j4xpZvqCb4Wt9yK/I/PiE2s73LxyylM
         VbteaAILs1QDgEbJSshwy21RTI0I+HH4jwbRyz255zHiwTBubNUd6Qs/2JiGJqUtHXXq
         RdoK3boX1M9E48EDFXlMPDrd9GjUrJi8E6GAhOAxkdfZZjVhT4sV+MP2XJPGJaFRpdtc
         x1F18B0UHDVHFd671cT1o2O4+swey+M9atR/vFCT/UtcBkhv9wXw1WDLpzg45q/8QHwI
         ZxkPdl7OxTTI+J+xLIZ9B2RTvjnz6xlVBtljQs1dtATdF2RjdMVkZAEaDHu0E4LfP0SZ
         b8lA==
X-Gm-Message-State: AOAM530GbY5PdCIPmYPnx0aBhf379D/woi4Kln/Gh7kdVNbigvmQ+uen
        txY5mqTDtCkU8QVJxqzQZAtOrg==
X-Google-Smtp-Source: ABdhPJwCnZ9kYelEcmVP7g0WbPZijLkhPLxFnVmVGe0ZF9gGUSDFygD14I26aGzJXJMekr5ZI3r7Dg==
X-Received: by 2002:a05:622a:c1:: with SMTP id p1mr3268033qtw.365.1631767053681;
        Wed, 15 Sep 2021 21:37:33 -0700 (PDT)
Received: from ripple.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id w19sm1622926qki.21.2021.09.15.21.37.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Sep 2021 21:37:33 -0700 (PDT)
Date:   Wed, 15 Sep 2021 21:37:08 -0700 (PDT)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@ripple.anvils
To:     intel-gfx@lists.freedesktop.org
cc:     Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Vinay Belgaumkar <vinay.belgaumkar@intel.com>,
        Michal Wajdeczko <michal.wajdeczko@intel.com>,
        Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
        Sujaritha Sundaresan <sujaritha.sundaresan@intel.com>,
        John Harrison <John.C.Harrison@Intel.com>,
        Daniele Ceraolo Spurio <daniele.ceraolospurio@intel.com>,
        Matt Roper <matthew.d.roper@intel.com>,
        Lucas De Marchi <lucas.demarchi@intel.com>,
        Matthew Brost <matthew.brost@intel.com>,
        Dave Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Pavel Machek <pavel@denx.de>, Hugh Dickins <hughd@google.com>,
        linux-kernel@vger.kernel.org
Subject: 5.15-rc1 i915 blank screen booting on ThinkPads
Message-ID: <9e1a6f3b-5e64-be91-ba54-9b5d135ef638@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Two Lenovo ThinkPads, old T420s (2011), newer X1 Carbon 5th gen (2017):
i915 working fine on both up to 5.14, but blank screens booting 5.15-rc1,
kernel crashed in some way.

I wanted to say what i915 generations these are, but don't know where
to look - I don't see it in dmesg, even when DRM_I915_DEBUG enabled.

Possibly relevant: builtin kernels, CONFIG_MODULES off, no initrd.

On the older laptop:

First bisection showed first bad commit
41e5c17ebfc2 "drm/i915/guc/slpc: Sysfs hooks for SLPC"

But reverting that still crashed boot with blank screen (and
reverting the two related commits after it made no difference).

Second bisection, starting from 5.15-rc1 bad and 41e5c17ebfc2 "good",
but patching it out each time before building, showed first bad commit
3ffe82d701a4 "drm/i915/xehp: handle new steering options"

That one did not revert cleanly from 5.15-rc1, but reverting
927dfdd09d8c "drm/i915/dg2: Add SQIDI steering" then
1705f22c86fb "drm/i915/dg2: Update steering tables" then
768fe28dd3dc "drm/i915/xehpsdv: Define steering tables" then
3ffe82d701a4 "drm/i915/xehp: handle new steering options"
worked (there was one very easy fixup needed somewhere).

And 5.15-rc1 with those five reversions boots and runs fine...
on that older laptop.  But reverting those from the kernel on the
newer laptop did not help at all, still booting with blank screen
(or no more lines shown after the switch from VGA).  Put them back.

On the newer laptop, bisection showed first bad commit
62eaf0ae217d "drm/i915/guc: Support request cancellation"

And 5.15-rc1 with that reverted boots and runs fine on the newer.

I am hoping that there will be some i915 fixups to come in a later rc!
May be nothing more than uninitialized variables or NULL pointers.
You'll probably want more info from me: please ask, but I'm slow.

Thanks,
Hugh
