Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA6BC30D964
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Feb 2021 13:01:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234442AbhBCMAi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Feb 2021 07:00:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234162AbhBCMAf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Feb 2021 07:00:35 -0500
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 595ACC061573
        for <linux-kernel@vger.kernel.org>; Wed,  3 Feb 2021 03:59:55 -0800 (PST)
Received: by mail-pf1-x42d.google.com with SMTP id y142so8510175pfb.3
        for <linux-kernel@vger.kernel.org>; Wed, 03 Feb 2021 03:59:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=axtens.net; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=4uA7JS93JPw+++xZutM775VMPEwshLnvxHWwIlWPugU=;
        b=d2+USt6GcAhvlOc8tGw3hsChBNWfxsSnLznhf7fC6VHAyqS/x37U9wf21RzuKaqpEc
         Gu0rihcnDrxrnxt7uXUJl7jBPFQtpBns9Hw96l3h5hWQzQWSyLODxP1tOdU1uv+uslnQ
         P5cHSHV0uzntCFocPks3q0MkcoC4SwzEGPyBo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=4uA7JS93JPw+++xZutM775VMPEwshLnvxHWwIlWPugU=;
        b=oYBV2fTrqy8MrtfNSz7gQ0wrSnXjqiBxxlgM0lsEPJ9+srLvAe+4jt1arrCwsF5CiK
         D8Q5hJPxXgYg/292n93R+CeI4lVNqEoeRN77Vlv/DvIlkPC4m+5eirKHTC1yqJuOqu0t
         k8sdNY9ZPleuv//NUVnyEc5Bhc18t1Rkoux1rlxghwRkm3v40Dxpx9WfEbRAAQwcyqgZ
         HKLxRWoL9NkGc2jgR4TAQodD+Ye1W2p8O3gvRv8BuX3xe6zukhldaNdtwW1n3vP0V4up
         l8j8bjmMzz0DuJZ7pi2l/VIzsH5lc5plZLBu02CJC6natsAObv9wVDTP5yT8PpYPiu6A
         FcLw==
X-Gm-Message-State: AOAM533zOswoejlKs6Bk+os/8C48n4KxyxdQKIK0i3Dbic9wPJPgxlsc
        1ozfJb0IWnD+w2pxviB7IW+3R85/h2dTaA==
X-Google-Smtp-Source: ABdhPJytDZ4HM1r1NSCsMK44ojj+trhGOJ6I1kDuMv1LN3tUVACngwIVni/g2RNcS/9H77+1iU6anA==
X-Received: by 2002:a63:ca51:: with SMTP id o17mr3244885pgi.314.1612353594659;
        Wed, 03 Feb 2021 03:59:54 -0800 (PST)
Received: from localhost (2001-44b8-1113-6700-1c59-4eca-f876-fd51.static.ipv6.internode.on.net. [2001:44b8:1113:6700:1c59:4eca:f876:fd51])
        by smtp.gmail.com with ESMTPSA id h190sm2196512pfe.158.2021.02.03.03.59.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Feb 2021 03:59:54 -0800 (PST)
From:   Daniel Axtens <dja@axtens.net>
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linuxppc-dev@lists.ozlabs.org, kasan-dev@googlegroups.com,
        christophe.leroy@csgroup.eu, aneesh.kumar@linux.ibm.com,
        bsingharora@gmail.com
Cc:     Daniel Axtens <dja@axtens.net>
Subject: [PATCH v10 0/6] KASAN for powerpc64 radix
Date:   Wed,  3 Feb 2021 22:59:40 +1100
Message-Id: <20210203115946.663273-1-dja@axtens.net>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Building on the work of Christophe, Aneesh and Balbir, I've ported
KASAN to 64-bit Book3S kernels running on the Radix MMU.

v10 rebases on top of next-20210125, fixing things up to work on top
of the latest changes, and fixing some review comments from
Christophe. I have tested host and guest with 64k pages for this spin.

It does not apply to powerpc/next, sorry: there are conflicting kasan
changes staged in next.

There is now only 1 failing KUnit test: kasan_global_oob - gcc puts
the ASAN init code in a section called '.init_array'. Powerpc64 module
loading code goes through and _renames_ any section beginning with
'.init' to begin with '_init' in order to avoid some complexities
around our 24-bit indirect jumps. This means it renames '.init_array'
to '_init_array', and the generic module loading code then fails to
recognise the section as a constructor and thus doesn't run it. This
hack dates back to 2003 and so I'm not going to try to unpick it in
this series. (I suspect this may have previously worked if the code
ended up in .ctors rather than .init_array but I don't keep my old
binaries around so I have no real way of checking.)

(The previously failing stack tests are now skipped due to more
accurate configuration settings.)

Details from v9: This is a significant reworking of the previous
versions. Instead of the previous approach which supported inline
instrumentation, this series provides only outline instrumentation.

To get around the problem of accessing the shadow region inside code we run
with translations off (in 'real mode'), we we restrict checking to when
translations are enabled. This is done via a new hook in the kasan core and
by excluding larger quantites of arch code from instrumentation. The upside
is that we no longer require that you be able to specify the amount of
physically contiguous memory on the system at compile time. Hopefully this
is a better trade-off. More details in patch 6.

kexec works. Both 64k and 4k pages work. Running as a KVM host works, but
nothing in arch/powerpc/kvm is instrumented. It's also potentially a bit
fragile - if any real mode code paths call out to instrumented code, things
will go boom.

Kind regards,
Daniel
