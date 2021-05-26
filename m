Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7415C3922A4
	for <lists+linux-kernel@lfdr.de>; Thu, 27 May 2021 00:21:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234118AbhEZWWm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 May 2021 18:22:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233983AbhEZWW1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 May 2021 18:22:27 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D86D6C061574
        for <linux-kernel@vger.kernel.org>; Wed, 26 May 2021 15:20:52 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id jt22so4886746ejb.7
        for <linux-kernel@vger.kernel.org>; Wed, 26 May 2021 15:20:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=iIpBLIMzGRYvskHBSahQGRziaVdJQLwsrKUZiZHBGVk=;
        b=sJxFyrkXldH5SDQNfUiH3m80MZZYTYScL+8UQVlYN92NY+S2dLSv/m5JlEYjjr+Oon
         gUak3e0jxOXERLqev5c149Djka1Hz3R+JLCpc1kXbqUtoBHlCSU3RVUSrAT7xZejuh5L
         CuhIO86R2EYoaMduis1UissveAXkNi32/Q7OJOrtaTdrOErRmS3RsE6Ibp3ZD4zs0Y5p
         8WFIu+E0xyLi0mWugdIm/R3uSzeJIh1F/wxXA9MVg39UU19ZglB0WgQ66V79q6fOEdRn
         6uTNRG2lSuh0tLBMzdYVUUacnAaCADGsUzgOHLyZRs9XvS35PRB0Ua7V+GKLmqi5Ek1v
         gcQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=iIpBLIMzGRYvskHBSahQGRziaVdJQLwsrKUZiZHBGVk=;
        b=E1D4zs9rkL1CyLv4idr+6Dd5Z4EjdC2Kgdmue1wOU9w4bKQl9/kVhhYBRfd7LQf/HI
         MXyDpQ1tHaIHw3yyuVsDCtvO4Yu62LtIOaRDWnHOWzKzL1y/dmK7FBx1KCt4fXOTZ06p
         vSMV/j5CH5dFUm793o/pMaXjkB3oZvEmzAlijMBfctdftpRZNX4QitGT4g4LrUiRB2UZ
         wu4ETeliQiEwE6L3xSU/e+KRYU+VHHf1b2fugZrprJbTU5cprV/yzN4zaoAryQ/HbQzM
         mBvi9NBqpxXseE1pdg7MYVtfBOQ0YJL9fsFrvIVgZ7ZOW0O8Gfw+R48sZ6pG09Nn7xoq
         IwDQ==
X-Gm-Message-State: AOAM531NxyZcl40wSOSRx9XzsGILiZPp1jQ9h2us9dTbO+3AV5knxHgp
        TTEsTBSFS3+gfQaHhguVokGktmzlyJU4A5roY8Jp+JeN
X-Google-Smtp-Source: ABdhPJx2Sn/rqiuYPzYo2n3PVEm7ktU/RhgCvCnZ3syyFNw9yyA2/11QenPl2PtDbZx3f34Ft1v+g5xmanRJlGqiOGQ=
X-Received: by 2002:a17:906:7c9:: with SMTP id m9mr493331ejc.98.1622067651563;
 Wed, 26 May 2021 15:20:51 -0700 (PDT)
MIME-Version: 1.0
References: <20210526070337.28130-1-rdunlap@infradead.org>
In-Reply-To: <20210526070337.28130-1-rdunlap@infradead.org>
From:   Max Filippov <jcmvbkbc@gmail.com>
Date:   Wed, 26 May 2021 15:20:40 -0700
Message-ID: <CAMo8Bf+2GMnsaxKCKKWHDNDGA9MpyTcKzf9LTLhEXPtT9CBCxg@mail.gmail.com>
Subject: Re: [PATCH] xtensa: fix kconfig unmet dependency warning for HAVE_FUTEX_CMPXCHG
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Chris Zankel <chris@zankel.net>,
        "open list:TENSILICA XTENSA PORT (xtensa)" 
        <linux-xtensa@linux-xtensa.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 26, 2021 at 12:03 AM Randy Dunlap <rdunlap@infradead.org> wrote:
>
> XTENSA should only select HAVE_FUTEX_CMPXCHG when FUTEX is
> set/enabled. This prevents a kconfig warning.
>
> WARNING: unmet direct dependencies detected for HAVE_FUTEX_CMPXCHG
>   Depends on [n]: FUTEX [=n]
>   Selected by [y]:
>   - XTENSA [=y] && !MMU [=n]
>
> Fixes: d951ba21b959 ("xtensa: nommu: select HAVE_FUTEX_CMPXCHG")
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Cc: Max Filippov <jcmvbkbc@gmail.com>
> Cc: Chris Zankel <chris@zankel.net>
> Cc: linux-xtensa@linux-xtensa.org
> ---
>  arch/xtensa/Kconfig |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Thanks, applied to my xtensa tree.

-- Max
