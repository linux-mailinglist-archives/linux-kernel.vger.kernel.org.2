Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C230842EE3D
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Oct 2021 11:59:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234793AbhJOKBZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Oct 2021 06:01:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232995AbhJOKBY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Oct 2021 06:01:24 -0400
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5955DC061570
        for <linux-kernel@vger.kernel.org>; Fri, 15 Oct 2021 02:59:14 -0700 (PDT)
Received: by mail-pg1-x52f.google.com with SMTP id s136so4885997pgs.4
        for <linux-kernel@vger.kernel.org>; Fri, 15 Oct 2021 02:59:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amikom.ac.id; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/DC7Rq1fFrlfrYv5t8fcJ70LswSguGl1a9h5omIZjFg=;
        b=HatCpaOic/i4oT6J/grf5xzXW9B4JZituWL3+ZK7s4ndFNyqFJ+Mz9q/+t0wMZ+Pl3
         WJh1JuPNEmI5Bh/Ly04tDGgKKv8D1i3mTUrk4El0QoAbj37VEyGKXS06hGcI/Y2ehhl4
         q5vh+/8U31yZSpr5zvuMhnMufT8tBQLvu+YHY/1aplyO+0dFW3bVAm/IhCWiwI2Sz6Nk
         gq/KNlNmF44ij9EdNo5+BiN2zvYuwPgO2GPe+EfFf1InHxObb2UULvXpqNMdLxOov8aa
         fC+ScopIVOM3ZGYupUCByCwKJU7zFTcjG4QkHLgxH6zrpeRKrzNCROQ6uJ+bGpGbgZ1N
         peLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/DC7Rq1fFrlfrYv5t8fcJ70LswSguGl1a9h5omIZjFg=;
        b=1rQ4pKiPg9aPgZ0k9qhG7KDKZ+78SKFinTFw1e/GyPYZAUaL8iI74d7IY4J32FZIp+
         wX1JQKtczWgUlI6L0CWGquMtOiU8AmRmtzzMEVBMt+7HhZbxeQkcYd8hpChplmm/b2xP
         ofrFHI8UAqKe/HFmwPvOOGPoPzqx9T5OFk2OAHQHfjgeGNSD0ECVxKfInbsZW9fbQi1V
         3HyHBC1JjcPc/mAEDNAnNyY3E0K/0i4L71tOkk2KnvhZwJIEIjYlqq07p/8Jpl/sxfF8
         +o9gzrjoVTn+FkvpqCBxB8MgpzrpCWw0SU9kwQMLPvff3UhMzOuDE3uXT6b1jvJLzJYp
         pY+g==
X-Gm-Message-State: AOAM531tCDeyFK6C3srld/73JPedBk4eWmBIjaaGjUwxcbkwqUiyhzRP
        lOQlfXTYv4t1SiECkdQj+Fpknw==
X-Google-Smtp-Source: ABdhPJwtFU5HeLv9LTCoJkDqaAw4RaQEdxWQFfNExO6k5mbi1vIJ74+xWDBNQQJx4y8bowNBbOoPXw==
X-Received: by 2002:a65:6392:: with SMTP id h18mr8327763pgv.397.1634291953811;
        Fri, 15 Oct 2021 02:59:13 -0700 (PDT)
Received: from integral.. ([182.2.71.75])
        by smtp.gmail.com with ESMTPSA id l207sm4772917pfd.199.2021.10.15.02.59.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Oct 2021 02:59:13 -0700 (PDT)
From:   Ammar Faizi <ammar.faizi@students.amikom.ac.id>
To:     Bedirhan KURT <windowz414@gnuweeb.org>
Cc:     Willy Tarreau <w@1wt.eu>,
        Ammar Faizi <ammar.faizi@students.amikom.ac.id>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        David Laight <David.Laight@ACULAB.COM>,
        Peter Cordes <peter@cordes.ca>,
        Louvian Lyndal <louvianlyndal@gmail.com>
Subject: Re: [PATCH 2/2] tools/nolibc: x86-64: Fix startup code bug
Date:   Fri, 15 Oct 2021 16:58:19 +0700
Message-Id: <Z0HPX3gxjjYhZnksAQfP6g-ammarfaizi2@gnuweeb.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <a6a31152-69db-73c6-5083-cf9f9af8ca41@gnuweeb.org>
References: <a6a31152-69db-73c6-5083-cf9f9af8ca41@gnuweeb.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 15, 2021 at 4:26 PM Bedirhan KURT <windowz414@gnuweeb.org> wrote:
>
> (Sending again as previous email had my Ubuntu username as sender and
> Thunderbird attached my GPG key on it. Hope I cancelled on time.)
>
> Hi Ammar,
>
> I've tested your patchset on my local clone of Linux kernel with up to
> date fetch of master branch and this is the output I've gotten after
> executing the test binary compiled;
>
[...]
>
> I hope these are helpful and I could help throughout this patchset. I
> didn't get any SegFaults compared to my tests with same code on pure
> state either so I think everything works just fine. You can append me in
> Tested-by tag if you want.
>

Thanks for testing!

Tested-by: Bedirhan KURT <windowz414@gnuweeb.org>

-- 
Ammar Faizi
