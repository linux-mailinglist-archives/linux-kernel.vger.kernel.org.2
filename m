Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF1723AB682
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jun 2021 16:52:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232135AbhFQOyx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Jun 2021 10:54:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230151AbhFQOyq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jun 2021 10:54:46 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 402EBC061574
        for <linux-kernel@vger.kernel.org>; Thu, 17 Jun 2021 07:52:36 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id a11so7114127wrt.13
        for <linux-kernel@vger.kernel.org>; Thu, 17 Jun 2021 07:52:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chrisdown.name; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Rby9j9K4NaUhFeIkDrYFFjZiQs3LgRf88jqDwrxZNps=;
        b=gYjkcLEgyofFJtGmuej/IfP2+KXAagoiesHeSu1OrVdQT9WkF64X/WnjeyYyxtJYvs
         9ZOP8VZxnX315cjg0pl/r217nD0YLOa+VfLKg8gcjvnRSyJi/XeFc7OSym+5y5/WW/F2
         +jk5oEiKmCyDJuSS06AwlJDrLBchkm91sbJc0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Rby9j9K4NaUhFeIkDrYFFjZiQs3LgRf88jqDwrxZNps=;
        b=JYVEBK33/DSsW1C7jnCg7RW5OUnsQiU2sbjOmXLi6fXAacN2t34fx4yDBl6TOKl9ks
         nwvSdADB4L/wFbKUxrD957fdPxnw5Dsc0OBhP0uYPtjheJCubfdYCBwqmej4sl0q2pQr
         J9fXvtnxxdsuoNp2cZ+Gvq6umTO9IIfIG3bN+9AAyEz2HDNu+TYPBRnr90rAiW7Wk1Jz
         IhdtxnX1u+tzoXGqc/y3Xgskvx+l+eVil+ocjDX6/5VQkytK2Eru8yS03ZK22S3x7DOl
         XqOIHyoh47o4Xb98cfl9bmlVblA/eY3BU8WlpvuwFVqpf46irhBq8k7sgk+wmMBprXYV
         8QHQ==
X-Gm-Message-State: AOAM532sjeFgfZJCwntg7ydsPEG4gxw3KYffYkSEG2Mw1fCHrmz2j3L3
        qP7P3Vlp7PleJpY1bm5tKAT3iQ==
X-Google-Smtp-Source: ABdhPJy3388ROJWcIRy6Ec70/8PJly8lwD4ggtNL1mcbcpGH3dm8KqE8czjd+dwMhNMSLKEfPklqsQ==
X-Received: by 2002:a5d:4cd1:: with SMTP id c17mr6310340wrt.295.1623941554569;
        Thu, 17 Jun 2021 07:52:34 -0700 (PDT)
Received: from localhost ([2620:10d:c093:400::5:7326])
        by smtp.gmail.com with ESMTPSA id l10sm5720719wrv.82.2021.06.17.07.52.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Jun 2021 07:52:34 -0700 (PDT)
Date:   Thu, 17 Jun 2021 15:52:33 +0100
From:   Chris Down <chris@chrisdown.name>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Petr Mladek <pmladek@suse.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jessica Yu <jeyu@kernel.org>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        John Ogness <john.ogness@linutronix.de>,
        Steven Rostedt <rostedt@goodmis.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Kees Cook <keescook@chromium.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>, kernel-team@fb.com
Subject: Re: [PATCH v7 0/5] printk: Userspace format indexing support
Message-ID: <YMthsVDzM2B4URy/@chrisdown.name>
References: <cover.1623775748.git.chris@chrisdown.name>
 <YMsfo3/b1LvOoiM0@alley>
 <CAHp75VchoFoso54i1XHom_Wt49MtMEnjxZ-vq_C+OXCCK2=8sA@mail.gmail.com>
 <YMthNX8uHwLo4i/y@chrisdown.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <YMthNX8uHwLo4i/y@chrisdown.name>
User-Agent: Mutt/2.1 (4b100969) (2021-06-12)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

(And forgot to mention I did the same for ESCAPE_SPECIAL explicit users and 
those using masks including it, feel free to let me know if you want those as 
well.)
