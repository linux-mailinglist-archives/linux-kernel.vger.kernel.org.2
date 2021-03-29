Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D55B34D252
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Mar 2021 16:26:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230258AbhC2O0X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Mar 2021 10:26:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229628AbhC2O0Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Mar 2021 10:26:16 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4442C061574
        for <linux-kernel@vger.kernel.org>; Mon, 29 Mar 2021 07:26:15 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id x7-20020a17090a2b07b02900c0ea793940so7777597pjc.2
        for <linux-kernel@vger.kernel.org>; Mon, 29 Mar 2021 07:26:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=QV59/fiS2yP0s5JWg1m+9DlEqIZWuxBJw/rjxo4h+jA=;
        b=rx07gMMTqAnumj6rBQ4L0aEOVasRrYIvjCBZ+MVDfmmbZrpCf7DR7YOKCvrcQESc04
         ox9heJwHbZWPE/loNAQJAigfjly5qEx3H7Ms/9H0CCDXKtmHr7RXqrjwiFrVuAb3eXY3
         MHiF4150SOoQgS8ZnkXvsfDg2XH/wFpPERTYClyghwulJ6GAWsKjwJDXx/TLomRvSzgo
         eNEBQQmagGeHshSlwW15986PK3+BAuj/KflFe+9qdXKqKwSkzJZRpQRt3RUNRHNQNq4i
         pLFvH7uhQ7mzOaoAZwhXSBz0bMxUmKI5Ddaqy+RCHQN3nVv1G32o/yiMDzdeCNPLtnig
         jdog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=QV59/fiS2yP0s5JWg1m+9DlEqIZWuxBJw/rjxo4h+jA=;
        b=fv4MGtPxU3tUU7FJvSZSPHJ8HFmmQs9XMeBsX/XFiWjtEHk1sd2KNLfij7FOwzT05q
         rncPV3Y2GH1mo+7coNqXHZxnCLakNyb8x/eSapPNVpmUHUFz1a88IQ7B3ydTDIe9pTvQ
         acgJ1ZqC/5yR0/H/j1KAwdSIGQRE7K7dSMoV0LS3zJQcWoWzqcvnLWp4NS33+Bnf26Rl
         6Pn9ARqtUb3fhYfnTVmDxalnRKYaMtm0gcRroFCyJTtspeDVMvKTURQ20KUBZKLbTSuB
         3VOaKgdKP1hZnh1boW0r49z9xTRgwTQ7PgJjSOfDSCNoDbeM/cdWC+qRSDYS+MjUl7v/
         fqIg==
X-Gm-Message-State: AOAM531fG1Eq1I3Yciedm95T2zHpGYNTYeuSeDMAKc6sj3SbGUouyQVj
        1e7vuk9p0VQWlLJan2BKWFw=
X-Google-Smtp-Source: ABdhPJz7UciRM+ljYAwSzX2KumjKVrxUMdRlHQkXymCNgKTTYw820qaprydGe9wqei5T6PEp+2EKaA==
X-Received: by 2002:a17:90a:516:: with SMTP id h22mr25714967pjh.222.1617027975001;
        Mon, 29 Mar 2021 07:26:15 -0700 (PDT)
Received: from hoboy.vegasvil.org ([2601:645:c000:3c:e2d5:5eff:fea5:802f])
        by smtp.gmail.com with ESMTPSA id b3sm15782009pjg.41.2021.03.29.07.26.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Mar 2021 07:26:14 -0700 (PDT)
Date:   Mon, 29 Mar 2021 07:26:12 -0700
From:   Richard Cochran <richardcochran@gmail.com>
To:     Miroslav Lichvar <mlichvar@redhat.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Daphne Preston-Kendall <dpk@nonceword.org>,
        LKML <linux-kernel@vger.kernel.org>,
        John Stultz <john.stultz@linaro.org>,
        "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com>
Subject: Re: [Bug 212265] New: clock_gettime(CLOCK_TAI, ...) should return an
 error when TAI has not been configured
Message-ID: <20210329142612.GC20909@hoboy.vegasvil.org>
References: <87sg4iupzs.fsf@nanos.tec.linutronix.de>
 <20210327032859.GA3168@hoboy.vegasvil.org>
 <YGGbAIoCKDbZLQQ0@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YGGbAIoCKDbZLQQ0@localhost>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 29, 2021 at 11:16:48AM +0200, Miroslav Lichvar wrote:
> There are at least two issues with handling a zero offset as a special
> value. One is that zero could potentially be a valid value in distant
> future.

I not losing sleep over that, but

> The other is that the kernel updates the offset when a leap
> second is inserted/deleted even if the original offset is zero, so
> checking for zero (in the kernel or an application) works only until
> the first leap second after boot.

oh, I didn't think of that.  I hate leap seconds.  Good thing Earth is
picking up the pace again!
 
> The kernel would need to set a flag that the offset was set. Returning
> an error in clock_gettime() until the offset is set sounds reasonable
> to me, but I have no idea how many of the existing applications it
> would break.

I think it wiser to provide another way, sysfs or something else.

Thanks,
Richard
