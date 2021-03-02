Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 40A6E32A241
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Mar 2021 15:17:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1836891AbhCBHVb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Mar 2021 02:21:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345011AbhCBGxP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Mar 2021 01:53:15 -0500
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E2ADC061756;
        Mon,  1 Mar 2021 22:52:17 -0800 (PST)
Received: by mail-ed1-x52a.google.com with SMTP id v13so7386242edw.9;
        Mon, 01 Mar 2021 22:52:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rHHguOtq/SsmoWVv767qiYZjS1EduX+s7NH06dTB/5E=;
        b=RJv/UOK1Rl1s7110nIhpxe4b/ond/IgKPJUtMc5UpBqSdc/g7Yswb1SzFmZs4SD7tI
         igbMnrQiho1HeVqBBnZDspMXblybvDrUY0kgRGYI0BFcKamvexM8kT6hsvPxfolS1GCS
         coW5agR7+ctcm6vKT/3bVHNM0FhJN4zIgAKuzuhQLJ33mqLcUX+B8wza/jRBoUxX5Wfh
         pIoxdl8EnKCLs6mRm+Qft5XvnA6SClzlvqfAAEb5w9NmFyPTiJiwH8KgN2HnBBuuCq/y
         3YFdHzIsYT0FdYPOjPaHw4toWUXjBBVfLTzMCgCTF2m4QInHCv+j88I2zuFNKCQFwPe7
         6sag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rHHguOtq/SsmoWVv767qiYZjS1EduX+s7NH06dTB/5E=;
        b=WQs5INtpaglwazoI4ir9/rchXIcLdR+ldFDIQOV1NbEqWgw0W9rOD/zuS/3V/uUi2U
         82FK0xTJf6DEZ6vso8jzsWoFM5d4A7oKWopolBTyW+pW0z7PEITvoR0ujtAfNZ6+tiiN
         9gSOjOfsggH7X26DDpBBBtv6FQR4i7V38VZIPISwf9k+p947SEfjrbc4TujeKkCtfF2X
         4BLvU/4gWKChmrmGC2PqWQOUCLeNfI7q12bx8jZJU7s5CO+s+VmcirWhsXw5USXFHucM
         SIsxWcz3YlHT/xwCU2FiJGYGalKwCYykQePArAD9HmkQ02q52vWd7XS/QuX5DWG4VzTJ
         OnrA==
X-Gm-Message-State: AOAM5333ibFbLTpST8cYlBXXCA4K874du0HyoQC+6awMTEm04OEIzGK7
        frIMef+pCAcmGOQ802dacCn8SjliVW9kYulP+e8=
X-Google-Smtp-Source: ABdhPJzobTXq9iCvVESEdOAEuL6o/ZubpkKJZsWksmzJX34L0rWX2fSOlYOmfHgZ2Aqv1W8s49fkXRvKk98Gtiba5NU=
X-Received: by 2002:aa7:dd55:: with SMTP id o21mr32367edw.237.1614667934608;
 Mon, 01 Mar 2021 22:52:14 -0800 (PST)
MIME-Version: 1.0
References: <20210302062214.29627-1-jslaby@suse.cz> <20210302062214.29627-32-jslaby@suse.cz>
In-Reply-To: <20210302062214.29627-32-jslaby@suse.cz>
From:   Max Filippov <jcmvbkbc@gmail.com>
Date:   Mon, 1 Mar 2021 22:52:03 -0800
Message-ID: <CAMo8BfJeXxTatB74+4PLed9KZaoRgDgekHdvpWKsfFW-povZWw@mail.gmail.com>
Subject: Re: [PATCH 32/44] tty: xtensa/iss, setup the timer statically
To:     Jiri Slaby <jslaby@suse.cz>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-serial@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Chris Zankel <chris@zankel.net>,
        "open list:TENSILICA XTENSA PORT (xtensa)" 
        <linux-xtensa@linux-xtensa.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 1, 2021 at 10:22 PM Jiri Slaby <jslaby@suse.cz> wrote:
>
> Use DEFINE_TIMER and avoid runtime initialization of the serial_timer.
>
> Signed-off-by: Jiri Slaby <jslaby@suse.cz>
> Cc: Chris Zankel <chris@zankel.net>
> Cc: Max Filippov <jcmvbkbc@gmail.com>
> Cc: linux-xtensa@linux-xtensa.org
> ---
>  arch/xtensa/platforms/iss/console.c | 11 ++++-------
>  1 file changed, 4 insertions(+), 7 deletions(-)

Acked-by: Max Filippov <jcmvbkbc@gmail.com>

-- 
Thanks.
-- Max
