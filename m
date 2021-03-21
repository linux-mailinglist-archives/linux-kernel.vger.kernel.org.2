Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 05F82343594
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Mar 2021 23:57:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231268AbhCUW4b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 21 Mar 2021 18:56:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230163AbhCUW4A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Mar 2021 18:56:00 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D4B6C061574
        for <linux-kernel@vger.kernel.org>; Sun, 21 Mar 2021 15:55:59 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id w3so18279308ejc.4
        for <linux-kernel@vger.kernel.org>; Sun, 21 Mar 2021 15:55:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Zto8VdUgaZuA83/Nj1XMpXZ345LhOzbQqdylL7lJ9pA=;
        b=kp86doJC92ku5OgfWtjlZ1fFmv6PNkpioGrzWXJJbehUp4y80sCMu6b/l+gq0O6ENt
         AhowBDbezlP3R1mRcocH9jpbvUWvW0o1HVd11xrtf5axTtoU/RSpAtpN85jj/4DKwiQ5
         d/maOHtExoRuPXzwJUB++vBNPd5ver+jxDU6MNBu+f+HM/C3wabINfy6lFAHdnagOdpm
         D48U1iLlEm/nXIuQMzFUeNtso7nEaSpPVQzuseah3z3IgLzmmEpUuLXg++mlvwsvKeop
         qBgAvfCIJ2u+lcVwW8I4TwZ0uMVVrUlTGxHPtwvjNaNVJbdZRVpKqLmmYPF9iKtxgtKo
         MsSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=Zto8VdUgaZuA83/Nj1XMpXZ345LhOzbQqdylL7lJ9pA=;
        b=AK5CvOu7uLfYtqr4uRWu4oVW5mPaMVzjDpIm6tMhb74cf4Q8yMaWB/Kgxb7Kdmp/CJ
         OocAwx20Yw5tXAnyZmiM3AdmfeqAwrBVR0uckOAQk5EhGqwDOUunAcHsZlaBEtCP4nsp
         nNrJXYTiWP08EOM2nxVQijXArg+zKT/LxzaJ1dAPohkld4Aguzj6oAoboxyhkKGUPanG
         sz4cSSbtkLI1J41wKz8O4SapVukkpyrKnVEkeodgNW6J+U/fWZJZrLqSjVTcf7dOXkD0
         Q567Ow9yLiW3ZHKPgXu06xMNPardtkug1lwx8VgA0D05MBvVTeJY3Xc0z00CXrVK0dk4
         hzTQ==
X-Gm-Message-State: AOAM532192zMJTt3+CFX1/CERaG2lyTqGWxdEJSan5azXV+pBwPfhTsf
        0kxNlAeyn47MgHlS203Q4BMCyIscKwk=
X-Google-Smtp-Source: ABdhPJzeY4U9+AQ7v4lhtXO/gXVIXigi7oqn7w04Q1GdPjSts3BN/h5CvC+SwRL8ywXuEgp+9dMolQ==
X-Received: by 2002:a17:906:1986:: with SMTP id g6mr16243275ejd.533.1616367357960;
        Sun, 21 Mar 2021 15:55:57 -0700 (PDT)
Received: from gmail.com (54033286.catv.pool.telekom.hu. [84.3.50.134])
        by smtp.gmail.com with ESMTPSA id t6sm9254275edq.48.2021.03.21.15.55.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Mar 2021 15:55:57 -0700 (PDT)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date:   Sun, 21 Mar 2021 23:55:55 +0100
From:   Ingo Molnar <mingo@kernel.org>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     Bhaskar Chowdhury <unixbhaskar@gmail.com>, luto@kernel.org,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, x86@kernel.org,
        hpa@zytor.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] x86/entry: Fix a typo
Message-ID: <20210321225555.GB1885130@gmail.com>
References: <20210321201345.994577-1-unixbhaskar@gmail.com>
 <cdbd84e4-6099-3ab1-aa44-1f78ab93de1@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cdbd84e4-6099-3ab1-aa44-1f78ab93de1@infradead.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Randy Dunlap <rdunlap@infradead.org> wrote:

> 
> 
> On Mon, 22 Mar 2021, Bhaskar Chowdhury wrote:
> 
> > 
> > s/swishes/switch/
> 
> should be 'switches'

Correct - this patch exchanged a typo for a grammar mistake...

Thanks,

	Ingo
