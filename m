Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BFB8F39CBF4
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Jun 2021 02:55:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230126AbhFFA4a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Jun 2021 20:56:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230022AbhFFA4a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Jun 2021 20:56:30 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 275FCC061767
        for <linux-kernel@vger.kernel.org>; Sat,  5 Jun 2021 17:54:26 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id h22-20020a05600c3516b02901a826f84095so2785484wmq.5
        for <linux-kernel@vger.kernel.org>; Sat, 05 Jun 2021 17:54:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=3DxaiNSkw+eA+wXHpN2KP+oFrvWPJdQHdeQTKj9QQeM=;
        b=lUQyRaiq4AaXZaYWlH94S6Gn12mM38lNqlot8GXQItBQd53hfwyniIc3wxruyGl52c
         qPJLxMg+MoWiZ5jxmbF5hdBJ0Wvgggv/tFbZ+2Fn4ANbufSO58IbuYYcDgbbe4vDDX2P
         kbnBXtL3XwrbRdOHZJ8gHyqoVnMFfhcrCBGcPNdw/n8FjfvikX4oKWGwKskfOUwe8WBe
         eY4ffJ10mJ1mC6rgIn2BQTY+jdFPgpnyGZQWMUXuIdqBH1ZwekIsaGPm6I/c2ARSmmIZ
         4dV9ZkZ4E37cKxXXaN+tJdcdKMDDzKGC8Qadioa+J6X17wG7PJv+GhknTR8sHhSoIzcO
         GPRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=3DxaiNSkw+eA+wXHpN2KP+oFrvWPJdQHdeQTKj9QQeM=;
        b=CsJeceZ5cVOQSYOK0d6wHqZ+vNZjHhdJDAeudZIwsSZONq6Zh7ft4vhr/60iz0w85c
         7yRUOl/jXAEoytwNBSRVyK4yHkz5SkqW4WYdNP90MmaR95sERVz9f0KSRvHNcy1ihG51
         5ySrcvRgOSzgpr3COZHnq874NIYJo3e/e2Gv1Pam3Z1z9qqmJeu8QI2QrayG3Nqk9it2
         LH2uIQy0zLrcP9yMaUXI7IZ2JMNN/7Csz0sPjonl3rfL1KG+TIaC6c784sdqUr6t6tw+
         ZBdaU1rghEHdQZCeYlAVsaKnqorFDu0xdAxZYUYBVkIGpylmyvRqNoLjwKVlHrnz5Mam
         YQKA==
X-Gm-Message-State: AOAM5318du+Lv3JA2b4CyHcB3XXC8/jWJlS4Bol2vEKKBjJ71P4Qgza+
        hDg+RyoP2dQ3qDOVSAkoAx0Xd3iJi5/eEu7ZUBj24g==
X-Google-Smtp-Source: ABdhPJxW3B5oI9ev63JTOffeqEWrYZWrYU5sFyNrebXusVFcqbrVZAViyfqSDs3CtmbFkC5ZdBVCMuWtumEoQzrBCjQ=
X-Received: by 2002:a7b:c44f:: with SMTP id l15mr10268090wmi.151.1622940864731;
 Sat, 05 Jun 2021 17:54:24 -0700 (PDT)
MIME-Version: 1.0
References: <20210605215215.171165-1-andrealmeid@collabora.com>
In-Reply-To: <20210605215215.171165-1-andrealmeid@collabora.com>
From:   David Gow <davidgow@google.com>
Date:   Sun, 6 Jun 2021 08:54:13 +0800
Message-ID: <CABVgOS=QMTjFEPqgBab27sTRdnW6PLG_bcD20ui_nC2wK_GAPA@mail.gmail.com>
Subject: Re: [PATCH] lib: Convert UUID runtime test to KUnit
To:     =?UTF-8?Q?Andr=C3=A9_Almeida?= <andrealmeid@collabora.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Brendan Higgins <brendanhiggins@google.com>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        KUnit Development <kunit-dev@googlegroups.com>,
        Shuah Khan <shuah@kernel.org>, ~lkcamp/patches@lists.sr.ht,
        nfraprado@collabora.com, leandro.ribeiro@collabora.com,
        Vitor Massaru Iha <vitor@massaru.org>, lucmaga@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 6, 2021 at 5:52 AM Andr=C3=A9 Almeida <andrealmeid@collabora.co=
m> wrote:
>
> Remove custom functions for testing and use KUnit framework. Test cases
> and test data remains the same.
>
> Signed-off-by: Andr=C3=A9 Almeida <andrealmeid@collabora.com>
> ---

Thanks! It's always exciting to see more tests using KUnit.

Note that the names here (filename, suite name, and Kconfig entry
name) don't match what we usually recommend for KUnit tests:
https://www.kernel.org/doc/html/latest/dev-tools/kunit/style.html

Given that this is an existing test, it is definitely okay to keep the
old names if you think it'd break something, but if there's no issue
it may be worth renaming them. The test suite name (which is new
anyway) ideally shouldn't end in "-test": just "uuid" is best.

I know there are quite a few existing tests which don't adhere to
these perfectly yet, but ideally new ones will if it's convenient.

Otherwise, this looks great. I've run it here, and it worked well and
picked up on any deliberate errors I introduced.

So this is
Tested-by: David Gow <davidgow@google.com>

Cheers,
-- David
