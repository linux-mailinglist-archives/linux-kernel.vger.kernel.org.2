Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 22991357586
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Apr 2021 22:08:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349123AbhDGUIS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Apr 2021 16:08:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355924AbhDGUIQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Apr 2021 16:08:16 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD553C06175F
        for <linux-kernel@vger.kernel.org>; Wed,  7 Apr 2021 13:08:06 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id e10so5547511pls.6
        for <linux-kernel@vger.kernel.org>; Wed, 07 Apr 2021 13:08:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mSd/S+8tc7IcQcSS/RpGMSx73CsARnvQdtoCEBJh4RE=;
        b=kdegvuLLfLm5o78sb3liPn/fXrlCsdbIKwWtIdW5f+cxv+zThPjVXprrQ7NbmPmOi3
         cFRU83hgkL/FLRMjgr6eNLao39YBnyr35OHA2RE1zjohqTdUvbV2bsDduBEOf4VxShM+
         TPgYbzkjuEIcQlKz1S+TiOv2wFamsk4RE38gpSUces43Jr7q3/36LXlRXcErMVVhm6Ri
         6Sz5rfJkdtQEBjOOhxhekCVRiYdg8GIHClJsDP1BzDgMRXjl2WVLhb8qA57M03dYZbBq
         vfqG+7CRlsaA2MuHX6hy0z1xUV/GNi1sB6GazNRRc592zKl1PzykqXHlcE0ZDcWGYk4+
         3K2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mSd/S+8tc7IcQcSS/RpGMSx73CsARnvQdtoCEBJh4RE=;
        b=RGM2pi+0BfuNQ96pU3MocG0oVYPIgiOBN3W+P0UGHwkssMQtuVrTVJ0eQ4JCK6Oria
         hMS+T61Um35ZHutYZiMK0YUmGd1M8uAgK8tcnUEeddH0JlTTmXC2mD0TIhjStds/E4My
         LdhrF+l/Htpi4FNEuN7nzx3CEMj2CkSDqdX6MWzp25xlYo72DeeJIAhesp01uRakMrAg
         AoQD5lcm7mQv/Wf7ACuom3abxM+4eMHuqs764V6ZLCyTPpcLZKKRqKtf/ZkZTEQCu5Vl
         ejsprX82iXgOHEBGQLbHLbkgJOiwDg/mlQKHr3tcwGQKwKHPtTXEP1DZifFxyY2m3ziJ
         p8Nw==
X-Gm-Message-State: AOAM531GK9LKqWbz6STPiyvnA6YyuyrDkGKf/kymdcExgRQgHb/wgkwK
        ZrIBfUgcAgYs6EkMiDJU0MJcXdLQ3Ssg09V088fnqQ==
X-Google-Smtp-Source: ABdhPJyyoL7VJ+OqLRPUux+V1NXnU4wvbvky0xki0Lfi2+ZBdBzpwZ+xJbPVPFD/Wd8/DCQHt2XFgpqgMrubjtjKf3c=
X-Received: by 2002:a17:902:b482:b029:e8:c21a:6ad2 with SMTP id
 y2-20020a170902b482b02900e8c21a6ad2mr4490815plr.51.1617826086092; Wed, 07 Apr
 2021 13:08:06 -0700 (PDT)
MIME-Version: 1.0
References: <20210406225100.1883967-1-dlatypov@google.com>
In-Reply-To: <20210406225100.1883967-1-dlatypov@google.com>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Wed, 7 Apr 2021 13:07:54 -0700
Message-ID: <CAFd5g47EE3J5V9ofZ4r3H+3+16u41-yqa+uwFYVgpVCg4CKOwg@mail.gmail.com>
Subject: Re: [PATCH] Documentation: kunit: add tips for using current->kunit_test
To:     Daniel Latypov <dlatypov@google.com>
Cc:     David Gow <davidgow@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        KUnit Development <kunit-dev@googlegroups.com>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 6, 2021 at 3:51 PM Daniel Latypov <dlatypov@google.com> wrote:
>
> As of commit 359a376081d4 ("kunit: support failure from dynamic analysis
> tools"), we can use current->kunit_test to find the current kunit test.
>
> Mention this in tips.rst and give an example of how this can be used in
> conjunction with `test->priv` to pass around state and specifically
> implement something like mocking.
> There's a lot more we could go into on that topic, but given that
> example is already longer than every other "tip" on this page, we just
> point to the API docs and leave filling in the blanks as an exercise to
> the reader.
>
> Also give an example of kunit_fail_current_test().
>
> Signed-off-by: Daniel Latypov <dlatypov@google.com>

Reviewed-by: Brendan Higgins <brendanhiggins@google.com>
