Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D67C3ACAB6
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jun 2021 14:19:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233999AbhFRMVy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Jun 2021 08:21:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232143AbhFRMVx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jun 2021 08:21:53 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57EDDC061574
        for <linux-kernel@vger.kernel.org>; Fri, 18 Jun 2021 05:19:44 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id i94so10547630wri.4
        for <linux-kernel@vger.kernel.org>; Fri, 18 Jun 2021 05:19:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chrisdown.name; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=xdCHZhSy57YOUgKugNg4c5W4B2rkiDfydX3AjZHrH6I=;
        b=vQ08gXej/VytlE6hy7Q3Q+l2RFvTO6G6ulYn9snmLPXb8AA8SJOVnBRK7mcHzsaYvj
         G42t8cwV+uG8vLWDqUZV7GfpdWWndVq7qebs+VhslgUolC/lfxN2+3BbdQwtwXhKTKjA
         2bdJKFqkM7J4RtBEwO2CApW0cO02zgnJ5Fvlw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=xdCHZhSy57YOUgKugNg4c5W4B2rkiDfydX3AjZHrH6I=;
        b=Wi98zqJyHdTjX2Zn1kLtzy5rr4LYNlHCpXtvVcmUE75eY+gd/EyQx8dmdLdGAjcwUV
         DZ098e81pyO4pptktGfMw9NB1qGjmRoSBLtMkVejFv7KOkSNkf8k9dWd52MeeKdST5E/
         np7SXR0NlGjVrbjXh25Epb6WIMNRAW6yC3ONVDNqlCl+MoGrRnQQ+MjJMu87nVtowtIP
         BOeQzP021xkno5SRj1Pu8r7Swl67coy3/M2DwgD34DBQLbD1ZGZU3urTumO4/f4+bIKO
         Og/JKxaYeaMcO5wA1OW5/Ds1B7Ns4xtEle4/SJhFFAn6LpHABHcG0tXTWFoww9VjdzYy
         pvPA==
X-Gm-Message-State: AOAM531zOfj6W7bJXEvswm5HkdFY8Ai2OyR42IC9WSj0dQNKoLDQdRsP
        Enq3LfoagLkSn7ev5qOcDmUk0A==
X-Google-Smtp-Source: ABdhPJwqGN5bJ2QEV94Y5ngg/DoWEX1VkbXUUAwCWnQRvC0z/5yIaeqQYRbVGEld4Sl5rfvPSkmISg==
X-Received: by 2002:a5d:6d8c:: with SMTP id l12mr12368220wrs.189.1624018782790;
        Fri, 18 Jun 2021 05:19:42 -0700 (PDT)
Received: from localhost ([2620:10d:c093:400::5:7326])
        by smtp.gmail.com with ESMTPSA id u20sm7417052wmq.24.2021.06.18.05.19.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Jun 2021 05:19:42 -0700 (PDT)
Date:   Fri, 18 Jun 2021 13:19:41 +0100
From:   Chris Down <chris@chrisdown.name>
To:     kernel test robot <lkp@intel.com>
Cc:     linux-kernel@vger.kernel.org, kbuild-all@lists.01.org,
        Petr Mladek <pmladek@suse.com>, Jessica Yu <jeyu@kernel.org>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        John Ogness <john.ogness@linutronix.de>,
        Steven Rostedt <rostedt@goodmis.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Kees Cook <keescook@chromium.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v7 4/5] printk: Userspace format indexing support
Message-ID: <YMyPXXnDCZNC7Bp+@chrisdown.name>
References: <e42070983637ac5e384f17fbdbe86d19c7b212a5.1623775748.git.chris@chrisdown.name>
 <202106181930.0rU3pZgm-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <202106181930.0rU3pZgm-lkp@intel.com>
User-Agent: Mutt/2.1 (4b100969) (2021-06-12)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

kernel test robot writes:
>>> include/linux/printk.h:219:5: error: static declaration of '_printk' follows non-static declaration

This issue already exists before this patch and has done for a very long time, 
just the error message changed. Let's fix it in a different series.
