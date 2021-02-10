Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A2D7C315FDA
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Feb 2021 08:05:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232180AbhBJHFD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Feb 2021 02:05:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232029AbhBJHEu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Feb 2021 02:04:50 -0500
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7686FC061574
        for <linux-kernel@vger.kernel.org>; Tue,  9 Feb 2021 23:04:10 -0800 (PST)
Received: by mail-pj1-x102d.google.com with SMTP id fa16so599979pjb.1
        for <linux-kernel@vger.kernel.org>; Tue, 09 Feb 2021 23:04:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=3zUr/+qMC5bsRpolC7Tar6hDzpnTG6W9B19KPc6CDiM=;
        b=ZayYKHvfPLpTyptQU8GAOaY734JPrWAiyiGff3I1b1oqxRyWvJDpoSEjGcK8EJ3e8O
         LjuKr9Kb0ngPao7HWZaX3a4laIN/yO/tL1REiKAGtxPDLYcRQBn+oAdt7jm4KR1utmUV
         iNH2ukykxSstAarL1Gb0qCBKD984UABrnWT9k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=3zUr/+qMC5bsRpolC7Tar6hDzpnTG6W9B19KPc6CDiM=;
        b=AHrm3buJcW9Wo/P//NKDeNTVEdhgGxnhKyzVSyMzwihrjPTIVQbvjEEYfawqQnLPKm
         z13eZo9PHGnA2KdF0D/XzlZWnIS6o5UYb15y6RhN8MRIO/iGMDuzNRY4q3xRSwRlhgoS
         pXaeLJ6bU78nBsJv3C7jQ+v2/u0r5VkD4Zamp9gRxqFVQeETwNqukc/Ult3OADcsh7oQ
         dWaQqePISLkUkjlDGaOWWhvj7yN/zI0XmKO+AU7n06DEzDZPbOD6gedCsfp2DbLBowwb
         2/9kOHirn8xDeebJXG5DSRn7AxXeCKweA8Zhsrd/OUeZsLGoRzJboqofLgIQduylI/qd
         1dZQ==
X-Gm-Message-State: AOAM532jzQn+UEWUhLo73nehDUYU9ePcYbHOdVoUUEluh2aI424tYSZz
        CwVYBEaAIv/wrmoD++ON/BstyQ==
X-Google-Smtp-Source: ABdhPJy+bYwz/XhXz24T0FA5QXPp7s+EpXpIhBQ4E6a1C/GO6IJV1Bl6B6chHZ6lbGOJZkAhQ7Baqg==
X-Received: by 2002:a17:90a:d145:: with SMTP id t5mr1846899pjw.104.1612940649991;
        Tue, 09 Feb 2021 23:04:09 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id y26sm1075263pgk.42.2021.02.09.23.04.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Feb 2021 23:04:09 -0800 (PST)
Date:   Tue, 9 Feb 2021 23:04:08 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Helge Deller <deller@gmx.de>,
        "David S. Miller" <davem@davemloft.net>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Rich Felker <dalias@libc.org>,
        Heiko Carstens <hca@linux.ibm.com>,
        Lai Jiangshan <jiangshanlai+lkml@gmail.com>
Subject: Re: [patch V2 12/13] softirq: Move do_softirq_own_stack() to generic
 asm header
Message-ID: <202102092304.6A75C62@keescook>
References: <20210209234041.127454039@linutronix.de>
 <20210210002513.289960691@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210210002513.289960691@linutronix.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 10, 2021 at 12:40:53AM +0100, Thomas Gleixner wrote:
> To avoid include recursion hell move the do_softirq_own_stack() related
> content into a generic asm header and include it from all places in arch/
> which need the prototype.
> 
> This allows architectures to provide an inline implementation of
> do_softirq_own_stack() without introducing a lot of #ifdeffery all over the
> place.
> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
