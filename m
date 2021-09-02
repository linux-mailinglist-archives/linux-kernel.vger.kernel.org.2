Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AFADF3FF745
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Sep 2021 00:38:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347743AbhIBWjU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Sep 2021 18:39:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347701AbhIBWjT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Sep 2021 18:39:19 -0400
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0933BC061757
        for <linux-kernel@vger.kernel.org>; Thu,  2 Sep 2021 15:38:20 -0700 (PDT)
Received: by mail-lj1-x22c.google.com with SMTP id g14so6434071ljk.5
        for <linux-kernel@vger.kernel.org>; Thu, 02 Sep 2021 15:38:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=E3bDRRGamHQKrcPLswNiJqifcyyJaRoHVapcNrMpIBg=;
        b=TELzSBJxOmBC5S0WOFI/aa7wb9vGW6scfdZvQuva6oYyVCKQ9V28bh0Yh46K/1iriY
         jxEb4rGfTI2L+rMplSI20e3MqbSX5Nj4Zv7iqAEY+rgAClrR2yQh/5ziz4oTTAhaM0m7
         BhsJqOd30mNyZlbDS8SH2qhM4TlbGsU7l3f/w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=E3bDRRGamHQKrcPLswNiJqifcyyJaRoHVapcNrMpIBg=;
        b=JAthHwEMqn62443QwerIAOMCjwazD0x36+Xt4O7XJmLmRDPgnp0BS9NEvcqrSWQomM
         pMNe4IH3H7IOtURhV/7/+u4tN5dE1OG/23V+7jtifI8ddRahZBeAOQ2VP/T9sZMhZ1G2
         jMOsDE/i14hBzoScsNqlLep6HmHQTZNHCa/Qh1J6PLR5pXNHh0nGPLsvti2TN+B2uyem
         74YPhBE90JyWhpNx4ICi3P5zaAZ6hFoecFO4o4xciwidD7FlTNBVTTClOTOyo2RzimHO
         rAdylArDOPOBOQFy37HSuVTPP1jC7YmCBnjrCXy+0GY8lighKORW/ehwCbKSj2S17LZg
         xIDA==
X-Gm-Message-State: AOAM531/HJSAE4x+DqhBJgDeHusAFo7qrIYfdDoPPHh1XZLVL1rO5Vm6
        HIJczm5XvAg7Wnss2wIlftII00woNBRMsdldBUI=
X-Google-Smtp-Source: ABdhPJwERsV0kh5xUgewC16gXygMKNIzMZzwSeUAguK15w0c3kSJ4Oa9uj+zezpD0/6Ds9vWmgfdsQ==
X-Received: by 2002:a2e:bd02:: with SMTP id n2mr444178ljq.141.1630622298076;
        Thu, 02 Sep 2021 15:38:18 -0700 (PDT)
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com. [209.85.208.172])
        by smtp.gmail.com with ESMTPSA id bi7sm313398lfb.86.2021.09.02.15.38.17
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Sep 2021 15:38:17 -0700 (PDT)
Received: by mail-lj1-f172.google.com with SMTP id w4so6392489ljh.13
        for <linux-kernel@vger.kernel.org>; Thu, 02 Sep 2021 15:38:17 -0700 (PDT)
X-Received: by 2002:a2e:7d0e:: with SMTP id y14mr438741ljc.251.1630622297342;
 Thu, 02 Sep 2021 15:38:17 -0700 (PDT)
MIME-Version: 1.0
References: <fc14fbbf0d7c27b7356bc6271ba2a5599d46af58.camel@HansenPartnership.com>
In-Reply-To: <fc14fbbf0d7c27b7356bc6271ba2a5599d46af58.camel@HansenPartnership.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 2 Sep 2021 15:38:01 -0700
X-Gmail-Original-Message-ID: <CAHk-=wi99u+xj93-pLG0Na7SZmjvWg6n60Pq9Wt9PgO6=exdUA@mail.gmail.com>
Message-ID: <CAHk-=wi99u+xj93-pLG0Na7SZmjvWg6n60Pq9Wt9PgO6=exdUA@mail.gmail.com>
Subject: Re: [GIT PULL] first round of SCSI updates for the 5.14+ merge window
To:     James Bottomley <James.Bottomley@hansenpartnership.com>,
        Jens Axboe <axboe@kernel.dk>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-scsi <linux-scsi@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 2, 2021 at 9:50 AM James Bottomley
<James.Bottomley@hansenpartnership.com> wrote:
>
> We also picked up a non trivial conflict with the already upstream
> block tree in st.c

Hmm. Resolving that conflict, I just reacted to how the st.c code
passes in a NULL gendisk to scsi_ioctl() and then on to
blk_execute_rq().

Just checking that was fine, and I notice how *many* places do that.

Should the blk_execute_rq() function even take that "struct gendisk
*bd_disk" argument at all?

Maybe the right thing to do would be for the people who care to just
set rq->rq_disk before starting the request..

But I guess it's traditional, and nobody cares.

            Linus
