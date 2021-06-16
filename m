Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 51C1B3A909E
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jun 2021 06:26:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230392AbhFPE2w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Jun 2021 00:28:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229716AbhFPE2v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jun 2021 00:28:51 -0400
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2BDEC061574
        for <linux-kernel@vger.kernel.org>; Tue, 15 Jun 2021 21:26:45 -0700 (PDT)
Received: by mail-pg1-x535.google.com with SMTP id t9so920540pgn.4
        for <linux-kernel@vger.kernel.org>; Tue, 15 Jun 2021 21:26:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:subject:to:cc:references:in-reply-to:mime-version
         :message-id:content-transfer-encoding;
        bh=5pDUiEFBky1MOzTrHUgdXkybB+3H0cU9q8egqLbnkdo=;
        b=diujc4RQ7DcRN33e+LAbtqI2aTDoDClTpy4S+vyH/7Ymj38JLPRJGvOYkS7EzciskJ
         GGd4xP6Bj1ahZCIsaj/FlCSK05jmsUfc6UrbueGnoXQNC2l45P7MdSHTEv3ewVbEYgIL
         fRV6IVVqCQZ6lKpw1shjfggujbVzonp1ar7509rAxaFgSPTTNGFHapRtcoHSYcsyIYSz
         reEHHtyOyiE/8u2jOxy8xd3IQw1YTO1Y/X3xhMixbyM1wsRyvsscrmyIWEcVvpDgiPna
         HTl8bQ9dH02c4E8WPxOSXZ4IDrvWM1BReJUhJ+453Z9D4XYogeU9sRnH+AleBysYVo3k
         Yk9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:subject:to:cc:references:in-reply-to
         :mime-version:message-id:content-transfer-encoding;
        bh=5pDUiEFBky1MOzTrHUgdXkybB+3H0cU9q8egqLbnkdo=;
        b=fbsFR5dKYBpTbMijbKvHztlFmgG6H6oD4GsBk8BXTtT4RX9YWe5lSZ341Y18ke1K4s
         gwJvjYM9eRPMC/JVJ0kjXoC1UcCcO94Y376xG1Y3chMF9ZHf2okE2J2mqB7H8xDfEhio
         QCrbEYHECeLbo6G14158PyGVIdcZ8xLLrynSds0hHUXGxWjaKkl93rk9WbHShJC5DIF/
         R7tfR8pfCD39ax8FbFC9cIPTRuYnKQfECYd4a1VaNCBhI9+ix0chekaXycOZboeEY5n/
         A5A/ars1d3J6ILcmNvhpu19KehndikFqV6m2jSVfNVh7e3QKL18emSqHqwnPgbGSfepd
         cDDw==
X-Gm-Message-State: AOAM531px4xywYIi8C1/ZrSLyQwMnvNglzrKbmRP8085nBavS+Hj2+yN
        ua9VvqGFgRxthLIVF2E5OJs=
X-Google-Smtp-Source: ABdhPJy+Y8/UYpHLI1NKubpDNG1U/QNWEVMSOB/fmA6HEHcRqNk3fIkPROuPsEEdCBf3nd1yxG7FMQ==
X-Received: by 2002:a63:f13:: with SMTP id e19mr2986629pgl.112.1623817605334;
        Tue, 15 Jun 2021 21:26:45 -0700 (PDT)
Received: from localhost (60-242-147-73.tpgi.com.au. [60.242.147.73])
        by smtp.gmail.com with ESMTPSA id b10sm642263pff.14.2021.06.15.21.26.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Jun 2021 21:26:45 -0700 (PDT)
Date:   Wed, 16 Jun 2021 14:26:39 +1000
From:   Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [PATCH 3/8] membarrier: Remove membarrier_arch_switch_mm()
 prototype in core code
To:     Andy Lutomirski <luto@kernel.org>, x86@kernel.org
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Dave Hansen <dave.hansen@intel.com>,
        LKML <linux-kernel@vger.kernel.org>, linux-mm@kvack.org,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Peter Zijlstra <peterz@infradead.org>
References: <cover.1623813516.git.luto@kernel.org>
        <2d45c55c4fbbe38317ff625e2a2158b6fbe0dc2d.1623813516.git.luto@kernel.org>
In-Reply-To: <2d45c55c4fbbe38317ff625e2a2158b6fbe0dc2d.1623813516.git.luto@kernel.org>
MIME-Version: 1.0
Message-Id: <1623817538.r80z7qt0vv.astroid@bobo.none>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Excerpts from Andy Lutomirski's message of June 16, 2021 1:21 pm:
> membarrier_arch_switch_mm()'s sole implementation and caller are in
> arch/powerpc.  Having a fallback implementation in include/linux is
> confusing -- remove it.
>=20
> It's still mentioned in a comment, but a subsequent patch will remove
> it.
>=20
> Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> Cc: Nicholas Piggin <npiggin@gmail.com>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Signed-off-by: Andy Lutomirski <luto@kernel.org>

Acked-by: Nicholas Piggin <npiggin@gmail.com>

> ---
>  include/linux/sched/mm.h | 7 -------
>  1 file changed, 7 deletions(-)
>=20
> diff --git a/include/linux/sched/mm.h b/include/linux/sched/mm.h
> index 24d97d1b6252..10aace21d25e 100644
> --- a/include/linux/sched/mm.h
> +++ b/include/linux/sched/mm.h
> @@ -350,13 +350,6 @@ extern void membarrier_exec_mmap(struct mm_struct *m=
m);
>  extern void membarrier_update_current_mm(struct mm_struct *next_mm);
> =20
>  #else
> -#ifdef CONFIG_ARCH_HAS_MEMBARRIER_CALLBACKS
> -static inline void membarrier_arch_switch_mm(struct mm_struct *prev,
> -					     struct mm_struct *next,
> -					     struct task_struct *tsk)
> -{
> -}
> -#endif
>  static inline void membarrier_exec_mmap(struct mm_struct *mm)
>  {
>  }
> --=20
> 2.31.1
>=20
>=20
