Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB418312ADC
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Feb 2021 07:46:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229849AbhBHGpE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Feb 2021 01:45:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229587AbhBHGo7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Feb 2021 01:44:59 -0500
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC898C06174A
        for <linux-kernel@vger.kernel.org>; Sun,  7 Feb 2021 22:44:19 -0800 (PST)
Received: by mail-pg1-x534.google.com with SMTP id e7so626212pge.0
        for <linux-kernel@vger.kernel.org>; Sun, 07 Feb 2021 22:44:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=+803h1HDJSZ65Cad0OUtvZ9NiqoyELYv2f6+XgldWy0=;
        b=Um6hny/zYIiUx7IHlv7srN/EmCf0qR9Q61d+qDDzb5pbG65J3oHz3hyBmNV0sbRsqZ
         5UnrtIO+HdeX0bIVslqbY16aVo+7tqU+dzJx5vLWPksxrjVUeuZ8w3xl7ZDcPV55+Al3
         MOP9U0f/0WPIcubNQmezZzO6kP8OlqmgWzZ9j21iM8xIJ49h+y+f523ExHyJwBEGkxhu
         Fn6vbrpOS03WGVrdmvdeqWC2Plf3yLlYBbCGupDL3tnqWr9WnZ2sPEic0pjT+Mpqbp9/
         TYBWNj92YGPr9IFTJP+BsQ/gviDYfeEMkk6PakVOK5LAHkEN9Zt2iYmUSzMC4cGCy+bU
         YyNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=+803h1HDJSZ65Cad0OUtvZ9NiqoyELYv2f6+XgldWy0=;
        b=Js2935pMUkIzKKPr/220bk1XKsdsgCxTFMop+EvXaSHMkqKOfxvGhLGcx9TbCuGH83
         Ob+uEdnt+dPuWL+CnMMioiK5q5YTzI+069pRKLOAUDFbB9nCXpwqWKOr2pO+SkLadLXx
         3HQxU1bXbzV8+t3fr8c06JRPwr76zZILw1zgIJeTiXq2piR6jJQx1vp7OZxAvwdNq1km
         eK7y7Kw3jh9hBsMkWhwh/dDTJmnDlEHzMWj848Ozf1ZVXaqr16eg+r3Munyt08RFY/oQ
         L+JPNN/4S5W3/fRdfScz98Yu/kaFDSUm3fBIzmkVnsl5tTU/Jg/taBXHDJUXkHehCRwJ
         jK5w==
X-Gm-Message-State: AOAM533DPlAvMtJcfGppsk/YuLaQik1kFimSWq9Of10byDVSZgXGvxCU
        0CB4Oqwo/QHL68/KjwbixIs=
X-Google-Smtp-Source: ABdhPJy2NfZC1+rP/NfaWXD7FJ9hniCmFmc2R1tbAJ3PZPp//pppVi3bQ21qidfsth+RK3WNLKVXSQ==
X-Received: by 2002:a65:60d1:: with SMTP id r17mr16273336pgv.210.1612766659149;
        Sun, 07 Feb 2021 22:44:19 -0800 (PST)
Received: from localhost ([2409:10:2e40:5100:6e29:95ff:fe2d:8f34])
        by smtp.gmail.com with ESMTPSA id y14sm8814965pjg.52.2021.02.07.22.44.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Feb 2021 22:44:18 -0800 (PST)
Date:   Mon, 8 Feb 2021 15:44:17 +0900
From:   Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
To:     John Ogness <john.ogness@linutronix.de>
Cc:     Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-kernel@vger.kernel.org, "J. Avila" <elavila@google.com>
Subject: Re: [PATCH] printk: avoid prb_first_valid_seq() where possible
Message-ID: <YCDdwY8mMb9JZkXn@jagdpanzerIV.localdomain>
References: <20210205141728.18117-1-john.ogness@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210205141728.18117-1-john.ogness@linutronix.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (21/02/05 15:23), John Ogness wrote:
> If message sizes average larger than expected (more than 32
> characters), the data_ring will wrap before the desc_ring. Once the
> data_ring wraps, it will start invalidating descriptors. These
> invalid descriptors hang around until they are eventually recycled
> when the desc_ring wraps. Readers do not care about invalid
> descriptors, but they still need to iterate past them. If the
> average message size is much larger than 32 characters, then there
> will be many invalid descriptors preceding the valid descriptors.
> 
> The function prb_first_valid_seq() always begins at the oldest
> descriptor and searches for the first valid descriptor. This can
> be rather expensive for the above scenario. And, in fact, because
> of its heavy usage in /dev/kmsg, there have been reports of long
> delays and even RCU stalls.
> 
> For code that does not need to search from the oldest record,
> replace prb_first_valid_seq() usage with prb_read_valid_*()
> functions, which provide a start sequence number to search from.
> 
> Fixes: 896fbe20b4e2333fb55 ("printk: use the lockless ringbuffer")
> Reported-by: kernel test robot <oliver.sang@intel.com>

Can we please also ask the kernel test robot to test this patch?

	-ss
