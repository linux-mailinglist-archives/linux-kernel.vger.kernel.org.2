Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F6CE32A244
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Mar 2021 15:17:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1836917AbhCBHVi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Mar 2021 02:21:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345799AbhCBG5D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Mar 2021 01:57:03 -0500
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21955C061788;
        Mon,  1 Mar 2021 22:55:51 -0800 (PST)
Received: by mail-ed1-x532.google.com with SMTP id l12so23818128edt.3;
        Mon, 01 Mar 2021 22:55:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FkQlyQkx4YlaiWtPjbjtcm8QF/fjSftYDKk5kkfUey0=;
        b=PFlj/AbLsGqPbk3apdT1uKeW7cFiUGggPb7txtL2cKFfBRSbsjVq7tDgupMkQPci6d
         /5Dfpsl3vX9oWzTRVuabWzMsmgWHDjBzvWmqsHV8XprenQE/dvM7mFPa/NOnP/ihT08z
         autad4M91CAFPFT68Iz8XNgOS6s2O2A3oxw/r0QeN+S0ZcMsa2fKXWYmyGt/GpxR4AcV
         V1bFbBANndmxqnxiJheuZbykHCfz+OCKdxvdfXdGKsdGVMZojiY0Hnq1djYlXz32jwW3
         AJDi60j6zN59bgJhyp1zd8Ywv73MhRPiWhHcrIMs4mv1hRfAQUP2FnRotdda5+Qekj5u
         8CvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FkQlyQkx4YlaiWtPjbjtcm8QF/fjSftYDKk5kkfUey0=;
        b=R0MRviwapnKABnTt+JoBQM43VFN0HCx7eaZn7aFctNZwEXFJboNhxl6M9Tp5BZqm2T
         NNjTgpe+nPzzoYPSlQ0T1u0+NBQ3/RXGPLmrBGaiFEJUVAzVf2OyY1ZJ/swjiXJmyIhU
         FLuKMPqWDI0d3gfSUD7Me/0XFnK0nvDN+rDvfc2G6+5Qt+DaL9TWrwm95l5eSM3LByOE
         eAy4vF3K+KbNDLinT1EzbcqagYbIoMqdfjbZOTwUJadrIV6s9dRNLQoYp1eSCCRhohUG
         0ODZex7qBpt31P2kW+KyAGY7Fe/GwJWMaYgJysxvEqI5rROl/cOqf0oPZZ5B5KLK7Rxx
         rqew==
X-Gm-Message-State: AOAM531vCjvvGCH/bXYS5/luYrlJwZGUZuFHqWU0obpXNVZ5+dr3/6xP
        8JlmxTkWzj46FQ+R6mTjmYBJsUmZYopt4inpQqM=
X-Google-Smtp-Source: ABdhPJybh6pmK5GtQmq/c3vvZGuCHaTR3ln7l9rsmzuuQ7BXZx12cEyOKZV8gpU8repWmjDUKkUnlpWFKdYgBsD+7XA=
X-Received: by 2002:a50:d987:: with SMTP id w7mr19419656edj.350.1614668149868;
 Mon, 01 Mar 2021 22:55:49 -0800 (PST)
MIME-Version: 1.0
References: <20210302062214.29627-1-jslaby@suse.cz> <20210302062214.29627-33-jslaby@suse.cz>
In-Reply-To: <20210302062214.29627-33-jslaby@suse.cz>
From:   Max Filippov <jcmvbkbc@gmail.com>
Date:   Mon, 1 Mar 2021 22:55:38 -0800
Message-ID: <CAMo8BfJ=-ORUowT4aUrQsYyZC+Kvpa6Xk-v5u7ah_GAkcAVpCA@mail.gmail.com>
Subject: Re: [PATCH 33/44] tty: xtensa/iss, make rs_init static
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
> To fix the warning:
> warning: no previous prototype for 'rs_init'
>
> Signed-off-by: Jiri Slaby <jslaby@suse.cz>
> Cc: Chris Zankel <chris@zankel.net>
> Cc: Max Filippov <jcmvbkbc@gmail.com>
> Cc: linux-xtensa@linux-xtensa.org
> ---
>  arch/xtensa/platforms/iss/console.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Acked-by: Max Filippov <jcmvbkbc@gmail.com>

-- 
Thanks.
-- Max
