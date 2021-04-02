Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AEFC6352552
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Apr 2021 04:03:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234065AbhDBCDZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Apr 2021 22:03:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231179AbhDBCDV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Apr 2021 22:03:21 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 503FBC0613E6
        for <linux-kernel@vger.kernel.org>; Thu,  1 Apr 2021 19:03:21 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id l1so1879864plg.12
        for <linux-kernel@vger.kernel.org>; Thu, 01 Apr 2021 19:03:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=x631UBvWaQTFZbKdIzadU0ErJ3cT01T22cqI9MuO2ds=;
        b=YO0aeR2KAm4oHl65dBrcj2pu0x3laL2j5HstXUb41ZaefCjtm1pFNRCfmljeOCjnzv
         ij3V8y69i+Rn/H9NeOMyQXT9esL741PS73VSiHWnpJEJvCAJwtM8h40azNeq0yO6kDaM
         XXLj0ouNPze6C98I4WtTDhLeY3k/Hssvjqfto=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=x631UBvWaQTFZbKdIzadU0ErJ3cT01T22cqI9MuO2ds=;
        b=U6gKXFQPjHOysFUifE6gG/YkAZmhbHvTelPCx2tI3DIzSTawRplZvpZ5AvE/Gn4h0B
         zL/f2wUHXWeYxLe2CImxFVIjrp3KgjM1p8YzJuclgKCMrkwdwSv8ql3rElz02Kh9Tu/A
         0+rtLIfTVD5XjBAsIVpnmBa5yvEL0qEVMtyZ4HFpY/ZSQ0i2RX70GX2LJv2ec/K5THK4
         Lj1RJImFkMna1IKpfwMCreE50Giy1rpUBrixOdgNCljIoAtGKUASNQaymTUYL+QddG34
         52xTBBUH766gs10wZCBiEvMOsDVM1dNAjOOs6hkw1icB3DKlfsNThjYEOLAX7j/prdqx
         nhuA==
X-Gm-Message-State: AOAM530tHmR7skmkVdPFTSSZviREbBeMv/1hmT7GlofXNqEDr6oiiPzU
        2JKiBv7DUjU8Ysqf0hOH3HKY/FI89yxj6A==
X-Google-Smtp-Source: ABdhPJwa/GL+/ds6BKU/X2WpORGxblOyJ1FDWuJaGlV60QcydBwiZrUigrTPAOohvsieL65ZG7My3Q==
X-Received: by 2002:a17:902:c48d:b029:e6:f7d:a76d with SMTP id n13-20020a170902c48db02900e60f7da76dmr10561993plx.66.1617329000741;
        Thu, 01 Apr 2021 19:03:20 -0700 (PDT)
Received: from google.com ([2409:10:2e40:5100:918a:96e1:2fd5:8e77])
        by smtp.gmail.com with ESMTPSA id e6sm6338000pfc.159.2021.04.01.19.03.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Apr 2021 19:03:20 -0700 (PDT)
Date:   Fri, 2 Apr 2021 11:03:15 +0900
From:   Sergey Senozhatsky <senozhatsky@chromium.org>
To:     Petr Mladek <pmladek@suse.com>
Cc:     John Ogness <john.ogness@linutronix.de>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH printk v2 1/5] printk: track/limit recursion
Message-ID: <YGZ7YyLXMh1HFTs2@google.com>
References: <20210330153512.1182-1-john.ogness@linutronix.de>
 <20210330153512.1182-2-john.ogness@linutronix.de>
 <YGWZpYE5diVLVzju@alley>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YGWZpYE5diVLVzju@alley>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (21/04/01 12:00), Petr Mladek wrote:
> On Tue 2021-03-30 17:35:08, John Ogness wrote:
> > Currently the printk safe buffers provide a form of recursion
> > protection by redirecting to the safe buffers whenever printk() is
> > recursively called.
> > 
> > In preparation for removal of the safe buffers, provide an alternate
> > explicit recursion protection. Recursion is limited to 3 levels
> > per-CPU and per-context.
> > 
> > Signed-off-by: John Ogness <john.ogness@linutronix.de>
> 
> Reviewed-by: Petr Mladek <pmladek@suse.com>

Reviewed-by: Sergey Senozhatsky <senozhatsky@chromium.org>
