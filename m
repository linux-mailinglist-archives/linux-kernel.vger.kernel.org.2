Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F13603FA4F9
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Aug 2021 12:18:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233741AbhH1KTY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 28 Aug 2021 06:19:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233652AbhH1KTX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Aug 2021 06:19:23 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63205C061756
        for <linux-kernel@vger.kernel.org>; Sat, 28 Aug 2021 03:18:33 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id a25so19479588ejv.6
        for <linux-kernel@vger.kernel.org>; Sat, 28 Aug 2021 03:18:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=ufnHtNbrqJITLW1O1XY2r37rNsuwUTovBEX/kbd4pw8=;
        b=JIQdNctE7m3CdWbbAXZNEThDl3hx2mmwVhfwPFIVcoFFXmiW08dFS4G+T+5f/v7etV
         fKf0biP29eXfRr7/kz98g6IJoJpbbduuYDyTsvzDaRBnoTq0BfU3Hi6QLCG6QGgAYL/x
         6Wiln33YawD0ge2Em2bfUJBDb2Yx31LURtkvV/yV1t79mjUAxf9EbfjOeFPjInTuXJup
         Xnxf21np+s01uPrDK/+9OCF2KQNPd5RtkL7AHtlWGF/M6tAvfGnBwEYrTIiUQlshn9hM
         7VFkEjJa05s/RsCgFXn/P37yn+4I0qEUnvpOCdqHHBkbw/iA+VvyY8dwwkKXFnr34K78
         sb7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ufnHtNbrqJITLW1O1XY2r37rNsuwUTovBEX/kbd4pw8=;
        b=AT9vx0Fg8MuXtP0YST0de2jsK70ksHwOr1H+YBjKm03swzUNGosmWBm6E3a1bDlBJc
         zSjSlZ2XrkgKSSvDZb+o8eaK2rYsSqbVroyBRC2aLZ3hAazwBXuBjxs0gkh7D/q3tuop
         1wkXcmjNNYEWbG71veMA7wO5KZc1xU5r9Ol1Dcis6zJL7/U0jVbM4dnVhRVZOHVVh0HN
         zivR+TRSlpsc5uCaTmG4c8Ie3+RlRGxdqXlEza6pv1VtQcOnCMCxeEhS1p9lXeP4RTuy
         oaODt8iJ0OxadXqofPVnNM9Gx0gS6hloNOpq0cCp4mrAxprm1Xgp/s5VQFtT6WJU/1uR
         uyQg==
X-Gm-Message-State: AOAM532L6GnU6u5S78CoWwGNBjQ8aJ6SJfbRfzNngN9wyQ1zjAjO1BC8
        AkPAtmCyKuBAIDYHuVrWtpo=
X-Google-Smtp-Source: ABdhPJx39cs05Co7SsOUxUHwlyG/4dLqxxVdTtPN0XVTrF3a4l9uq6Ac7U+BrGKDylg9YK11mRV9sQ==
X-Received: by 2002:a17:906:f15:: with SMTP id z21mr14832346eji.177.1630145911893;
        Sat, 28 Aug 2021 03:18:31 -0700 (PDT)
Received: from localhost.localdomain (host-79-22-100-164.retail.telecomitalia.it. [79.22.100.164])
        by smtp.gmail.com with ESMTPSA id y10sm4579786eda.47.2021.08.28.03.18.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Aug 2021 03:18:31 -0700 (PDT)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Martin Kaiser <martin@kaiser.cx>,
        Michael Straube <straube.linux@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Pavel Skripkin <paskripkin@gmail.com>
Subject: Re: [PATCH v3] staging: r8188eu: Remove _enter/_exit_critical_mutex()
Date:   Sat, 28 Aug 2021 12:18:29 +0200
Message-ID: <3027220.c38WcS0Ceb@localhost.localdomain>
In-Reply-To: <03d5fd25-7694-18ee-9e2f-7b4057117197@gmail.com>
References: <20210819221241.31987-1-fmdefrancesco@gmail.com> <03d5fd25-7694-18ee-9e2f-7b4057117197@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday, August 27, 2021 4:32:22 PM CEST Pavel Skripkin wrote:
> On 8/20/21 1:12 AM, Fabio M. De Francesco wrote:
> > Remove _enter_critical_mutex() and _exit_critical_mutex(). They are
> > unnecessary wrappers, respectively to mutex_lock_interruptible() and
> > to mutex_unlock(). They also have an odd interface that takes an unused
> > argument named pirqL of type unsigned long.
> > The original code enters the critical section if the mutex API is
> > interrupted while waiting to acquire the lock; therefore it could lead
> > to a race condition. Use mutex_lock() because it is uninterruptible and
> > so avoid that above-mentioned potential race condition.
> > 
> > Signed-off-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>
> 
> Tested-by: Pavel Skripkin <paskripkin@gmail.com>
> Reviewed-by: Pavel Skripkin <paskripkin@gmail.com>
> 
> Thanks!
> 
> 
> With regards,
> Pavel Skripkin
> 
Hi Pavel,

Thanks very much for testing and reviewing my patch. As you know, Greg wanted
it tested but I couldn't do that. I'll add your tags and send a v4 and I guess that now
Greg will easily apply.

Great help from you, thanks again :)

Regards,

Fabio




