Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 586C230D229
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Feb 2021 04:26:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232695AbhBCDYe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Feb 2021 22:24:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232650AbhBCDYF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Feb 2021 22:24:05 -0500
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAAAEC061573
        for <linux-kernel@vger.kernel.org>; Tue,  2 Feb 2021 19:24:07 -0800 (PST)
Received: by mail-pg1-x52c.google.com with SMTP id t25so16352291pga.2
        for <linux-kernel@vger.kernel.org>; Tue, 02 Feb 2021 19:24:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=On1zDet5C5XO5uxDYXjZhRdQHaYy68DxRjrTnKl1J+8=;
        b=gWdMhXQvU+4rZPqUFlIJKG1u2ulxygerTLAzdlx6SniUImn7YSdz1o1Fs1h72T42Yp
         WwLRLYfGW2vYo5LrkR0k1XrBao3m1n/zjqCXY7U3P27TenqKQw0k1vVUim314CvC+XHn
         KuioxWeVZGcvg4mUNLikbkdj1KUOA49ni5DlmDY2/gaWa1SBKoWilsn7vWvIkxwTKqp4
         d6wTIwqIFJBY4QhTp4Vg6jQreJRy4Mq81og+DcuxTl32eM9lKiHWIIPAE2o+D8PQtYO3
         JpB2W34Dlsp4nnzRS5R7KI5cGCvBS7dCjij+sTRouK3RXa4dzEA+cTXCwLe9AJmf+1Oy
         RAxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=On1zDet5C5XO5uxDYXjZhRdQHaYy68DxRjrTnKl1J+8=;
        b=U7mCz5kXnpFkXgRjwW76urZ4m/qstiZHDft/JyPditsesWmSgV0QbJEyGff0TYIj0x
         GKnNz6p0wHHjJAimSFK/jvhGJHyOoorP45lrQ/ORcT5dPIvUW6bkke2M8z6xj8qcGkkW
         f88QwiSQxfaEHK6X2Rx7Wur0+FHBmRwG6rRBVgI9GsaB3ac1YRASva6sGC2LnRzyHf1a
         UUBcle6H8W3VcuqFqvgVCazihpHupA3Fnx0dmLGXIlUXuiPNAIdvPWSu2tBZCKyigOeZ
         yyu19G3WhRKgza57kTykLp9DbortdwFRgJdA5pWt6KR8G3kUObL1VNVU9RR/cmrKaar5
         NgYA==
X-Gm-Message-State: AOAM532u7iCNjdhZR45WMTBkIwzuYnJ7DxkccSIJ4tLBF4l/HhZy1oDg
        syFMeJyNeNH3a4E8XW3W8jk=
X-Google-Smtp-Source: ABdhPJz1WweBzMVSagrzApnCMbZkw4r3FuWd+T1DZaxXuxPBXErzM27FPqLHgtsz4p0Uj+mtrSEulw==
X-Received: by 2002:a65:488d:: with SMTP id n13mr1281012pgs.315.1612322647113;
        Tue, 02 Feb 2021 19:24:07 -0800 (PST)
Received: from localhost ([2409:10:2e40:5100:6e29:95ff:fe2d:8f34])
        by smtp.gmail.com with ESMTPSA id s21sm350802pga.12.2021.02.02.19.24.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Feb 2021 19:24:05 -0800 (PST)
Date:   Wed, 3 Feb 2021 12:24:03 +0900
From:   Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
To:     Timur Tabi <timur@kernel.org>
Cc:     Petr Mladek <pmladek@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        linux-kernel@vger.kernel.org, vbabka@suse.cz, linux-mm@kvack.org,
        willy@infradead.org, akpm@linux-foundation.org,
        torvalds@linux-foundation.org, roman.fietze@magna.com,
        keescook@chromium.org, john.ogness@linutronix.de,
        akinobu.mita@gmail.com
Subject: Re: [PATCH][RESEND] lib/vsprintf: make-printk-non-secret printks all
 addresses as unhashed
Message-ID: <YBoXUxGBcG97BvML@jagdpanzerIV.localdomain>
References: <20210202213633.755469-1-timur@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210202213633.755469-1-timur@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (21/02/02 15:36), Timur Tabi wrote:
> If the make-printk-non-secret command-line parameter is set, then
> printk("%p") will print addresses as unhashed.  This is useful for
> debugging purposes.
> 
> A large warning message is displayed if this option is enabled,
> because unhashed addresses, while useful for debugging, exposes
> kernel addresses which can be a security risk.
> 
> Signed-off-by: Timur Tabi <timur@kernel.org>

Looks good to me.

Acked-by: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>

	-ss
