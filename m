Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D3F63545DF
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Apr 2021 19:14:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237098AbhDERO7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Apr 2021 13:14:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231748AbhDERO7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Apr 2021 13:14:59 -0400
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4686AC061756
        for <linux-kernel@vger.kernel.org>; Mon,  5 Apr 2021 10:14:51 -0700 (PDT)
Received: by mail-lj1-x234.google.com with SMTP id z8so13360562ljm.12
        for <linux-kernel@vger.kernel.org>; Mon, 05 Apr 2021 10:14:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=I9FfvG3409ycXXyz71eYEApeTgNKqdI5gf7K7u2lFME=;
        b=SpRmYjhyz63yQy1GcARMvnWKQASimfiszwptSukBaFu6vA8b86KL3T/OfsemSlFN31
         OEtJhECZxGI0Kge5lXPeMZer+3/vAg7uo3ms04bVQYKqui7L3aHIeE0kJTNMGSN4PVC7
         7ABNyloR7jYjw8GojaKA6zYBfmJT5EkYkaGnQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=I9FfvG3409ycXXyz71eYEApeTgNKqdI5gf7K7u2lFME=;
        b=Dk1IdhhNuSQsXZ6p7yoTbKx9JuCpdieVSooyqKipIfMy/ObRSFLTOkP+9oE3TEXZJj
         JOidwLyi9iighsErLPhIqvOtlXMJ4N4GniKxJuoCv3gCpOd3DHkoX13v3DQFwmDra/6U
         wh6xqwlY265zdUiD3vI7HT1S9JerVI4uE1AMr88j/bTUmFqo0S4TbaYAHb1S1scbnriz
         92u4sndO53itx4NsRPlKFPDV/dn4aGYgTCFXNIKPvarFpUGFc83FazCxVP2V3MH4Pnr0
         5usgHd6DK9TA95c4AoRrubNIoRz9LF3d8oAYWa9zAUd6jtKiEUk2F/4hkBM7AthzCJjw
         tVHA==
X-Gm-Message-State: AOAM5334pzCWu3msQolbzNx2/pbYq+W2qhmgp0RHUDi+nqjSl2IFcyFp
        NqnZo6ykA8w9aA7iEZB9NtEl/mnyAL1JzA==
X-Google-Smtp-Source: ABdhPJxCNDPHeeTGqX1c8jeR5uHb+7UMl6ooPIJBbo7ZgFShp95dCcW+EC3RjMbrzf7AG2Njiw94cw==
X-Received: by 2002:a05:651c:28b:: with SMTP id b11mr16563749ljo.219.1617642889669;
        Mon, 05 Apr 2021 10:14:49 -0700 (PDT)
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com. [209.85.167.52])
        by smtp.gmail.com with ESMTPSA id q8sm1849268lfn.286.2021.04.05.10.14.48
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 05 Apr 2021 10:14:49 -0700 (PDT)
Received: by mail-lf1-f52.google.com with SMTP id b14so18397173lfv.8
        for <linux-kernel@vger.kernel.org>; Mon, 05 Apr 2021 10:14:48 -0700 (PDT)
X-Received: by 2002:a05:6512:308b:: with SMTP id z11mr17738984lfd.487.1617642888740;
 Mon, 05 Apr 2021 10:14:48 -0700 (PDT)
MIME-Version: 1.0
References: <CAHk-=whK9=wafv+cSLCGqFGPBbgp67Dut3jKCnWB--8y7Lxonw@mail.gmail.com>
 <20210405171011.GA72391@roeck-us.net>
In-Reply-To: <20210405171011.GA72391@roeck-us.net>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 5 Apr 2021 10:14:32 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjG=y+sXAaW=L5369Sd0pjZ_iJEKiuUGCuR6QqQQYk0ug@mail.gmail.com>
Message-ID: <CAHk-=wjG=y+sXAaW=L5369Sd0pjZ_iJEKiuUGCuR6QqQQYk0ug@mail.gmail.com>
Subject: Re: Linux 5.12-rc6
To:     Guenter Roeck <linux@roeck-us.net>,
        Frank Rowand <frowand.list@gmail.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 5, 2021 at 10:10 AM Guenter Roeck <linux@roeck-us.net> wrote:
>
> No change in test results since last week [..]

Let's ping Frank for the alignment issue.  If that promised patch
isn't timely (and trivial), I really think that removing the alignment
check is by now the way forward for that libftd failure.

          Linus
