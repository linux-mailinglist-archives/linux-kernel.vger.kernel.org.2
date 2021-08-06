Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 83BB03E2FD6
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Aug 2021 21:47:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244036AbhHFTr5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Aug 2021 15:47:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229748AbhHFTr4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Aug 2021 15:47:56 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C78ACC0613CF
        for <linux-kernel@vger.kernel.org>; Fri,  6 Aug 2021 12:47:39 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id x14so14558087edr.12
        for <linux-kernel@vger.kernel.org>; Fri, 06 Aug 2021 12:47:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=toHxIua/lk0v08yVRpWnpey0pvRc7xo1YP9i2GKXi2c=;
        b=hVhYsNvoOjd5kPWwEgINJORpLENaolPrbhuBWjUkaczt5SJTQkNYV4htyE26YuXy0M
         zoCH77uEU22n0GAyZvCOhTqYdbQKDdINgi3GKzOU297Js1qkZITYrkdijmj+KIPlg7wv
         WF56sARSe2A42axm6J/4x2HkQkAiXkxySgWA3upyb5G6pEtoiX6hn1YCD5tfWKeBVYFW
         T5r9rHOMHGlYnTdjZuXqO2f0re5cHMswVjFg6Uyjvi6Vq51KPWf8TXP9pQtFn4WnCoXo
         05Ng0fjuCvjRnK2cjM/c8nreYBgBnFlGurUiLy7kMacSt455JqTOr+c3NQFJwFbHOcER
         ULmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=toHxIua/lk0v08yVRpWnpey0pvRc7xo1YP9i2GKXi2c=;
        b=nP/xgsF5FBqx7F3av8dACS1eD3CT7oIb0a1QT3WPvk/1nHLU/fGLc/bWrlNuOtk2oa
         D4CGwpWa0MsOTib5GqMcnBk0dBwxbeRlaK8/s5CI5nvtkdsRIIBGfJP6HMR190f1EiiS
         moRumzi9AJ+tnEsfJXR1/qmW/qB37dsMZMjp3dmiPHnL3cu5nSavG9dnQ/vOGM/c/Zze
         0YQmoaC7aallc4dSe/PVNC45EMkpNpkD/6pDZcRoT2XciqbWePC4laXBPiLqVxRJGwbB
         NMB47Uyy3/1tSmfcqeZl8GfhWM/zipuPe7F/Cqrss0fGp2Uz3ONPwPwO0jqkL4Z98/R2
         2MaQ==
X-Gm-Message-State: AOAM532VaqOjDyolYmFbkKUje22/2ewUG/3SwYiBVN/1yX3qL5UzMwQv
        QLY88u2OB5RL8B3iag5uttrq2lbX+Y6vcllggjs=
X-Google-Smtp-Source: ABdhPJyvv67vc4LKgb5kksxbU27q5L29eg5ncmJG2h1reJwDbr9rzB+zuvM1tXmyah5xCUAshtxkTX0wCrc38RUVis8=
X-Received: by 2002:a50:f113:: with SMTP id w19mr14607343edl.107.1628279258402;
 Fri, 06 Aug 2021 12:47:38 -0700 (PDT)
MIME-Version: 1.0
References: <20210806110251.560-3-song.bao.hua@hisilicon.com>
 <202108070109.TQClJ7dP-lkp@intel.com> <YQ15mVkwmeUCIZL0@smile.fi.intel.com>
In-Reply-To: <YQ15mVkwmeUCIZL0@smile.fi.intel.com>
From:   Max Filippov <jcmvbkbc@gmail.com>
Date:   Fri, 6 Aug 2021 12:47:27 -0700
Message-ID: <CAMo8Bf+18dQEwPpQ8QX-t_P65Lx7V6OhD3DVRw2G3yfsD=wKig@mail.gmail.com>
Subject: Re: [PATCH v9 2/5] lib: test_bitmap: add bitmap_print_bitmask/list_to_buf
 test cases
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     kernel test robot <lkp@intel.com>, Chris Zankel <chris@zankel.net>,
        Barry Song <song.bao.hua@hisilicon.com>, yury.norov@gmail.com,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        LKML <linux-kernel@vger.kernel.org>, kbuild-all@lists.01.org,
        Andrew Morton <akpm@linux-foundation.org>,
        dave.hansen@intel.com, Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        rafael@kernel.org, Randy Dunlap <rdunlap@infradead.org>,
        agordeev@linux.ibm.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 6, 2021 at 11:04 AM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
> On Sat, Aug 07, 2021 at 01:51:36AM +0800, kernel test robot wrote:
> > Hi Barry,
> >
> > I love your patch! Perhaps something to improve:
>
> I recall that I saw it ~1 year ago and informed Max about it.
> Don't remember what was the outcome, though.

There's a gcc bug report: https://gcc.gnu.org/bugzilla/show_bug.cgi?id=92938
There's an opinion that it's not a gcc bug and there's been no further progress
on that side.

-- 
Thanks.
-- Max
