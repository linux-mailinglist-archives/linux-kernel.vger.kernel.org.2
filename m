Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 99816363C08
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Apr 2021 09:01:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237437AbhDSHBo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Apr 2021 03:01:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229671AbhDSHBm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Apr 2021 03:01:42 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 117E3C06174A
        for <linux-kernel@vger.kernel.org>; Mon, 19 Apr 2021 00:01:12 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id e9so186932plj.2
        for <linux-kernel@vger.kernel.org>; Mon, 19 Apr 2021 00:01:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=RCCJG4HojmN/Dn1wT4Um30b53vmw38xaYfuMBCrfLAo=;
        b=EKeoPgTHMyy0fx0lp+APzZr26AnOM7vLtzlkdsp4X3i3Ku0gw8ERTZpZbnMjue9s50
         wJXVb/v/7Cm9n1IlIUad3e41FHmAx27Ir1ZrwYvkXOA4aSUErRQRbmr8IQDso81OS29H
         sqs0KEH7m6ZYpTluW9idrtCl0GNlXrqFh6s+lDcoFlY3ohfamlkhnUfTe8fQhsVBD4pb
         1whaHRBNDH9GYq5V60TNBJOG32gynjY+FXqAboUahDjetFhF2Seao/wNtEYL1cCQdmUP
         viNS5/mq7GRwuDQyq15ixfS2/i55V5W1KHdPnaUHw0aSLMK+NvoUFPqYC8nbbgFvrWWK
         NoZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=RCCJG4HojmN/Dn1wT4Um30b53vmw38xaYfuMBCrfLAo=;
        b=e3YYngqo+9SPZmK/48KjoOrqiZelD5a4mVhmjlIqP9EsPMaXN/d781s5g4qKc7PlI9
         5JoQH+TaAvXTxga70T4e8gavKT2D3DZeGRf3OTAimDYoF2hSfeds57kL3beFJPzRGVi2
         cxaGGpa6ZDf5P2V0PYFmf/y+1XV90zG2p5uGqwMYHnkpstnpUnG+SPZohn+3jd9VJMjq
         CMG4c+0dnRcadxirTF9YrYQcHkzbWrHZry5U7SG1bSJtueE29DmNG3/pz219148EsGS7
         hFsFjTtZ5Smpkk7J/JzHljP79IugCp8+2zQ+KmoWmb9cWGqcWRFidSLZ6R3l+4AOK8ar
         tOxw==
X-Gm-Message-State: AOAM5308BnZGhbnqGZ9LxI5Ihfny0UP5hVFhNT+SiixJ4IrQnii1oRga
        OXDqmjQ8nIlK3jsl6PlYjfurzPk6Q3J7vw==
X-Google-Smtp-Source: ABdhPJybBBxN9e0uVIERgi5j+aYsbbQZZpo4g3a42ubCE+EMGuTbwQqBNY5EZh39mUqxwSp2NbQc1Q==
X-Received: by 2002:a17:90b:4a86:: with SMTP id lp6mr14301846pjb.160.1618815671557;
        Mon, 19 Apr 2021 00:01:11 -0700 (PDT)
Received: from localhost (121-45-173-48.tpgi.com.au. [121.45.173.48])
        by smtp.gmail.com with ESMTPSA id b17sm11100117pft.170.2021.04.19.00.01.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Apr 2021 00:01:09 -0700 (PDT)
Date:   Mon, 19 Apr 2021 17:01:06 +1000
From:   Balbir Singh <bsingharora@gmail.com>
To:     brookxu <brookxu.cn@gmail.com>
Cc:     adobriyan@gmail.com, akpm@linux-foundation.org,
        ebiederm@xmission.com, linux-kernel@vger.kernel.org
Subject: Re: [RESEND PATCH 1/2] delayacct: refactor the code to simplify the
 implementation
Message-ID: <20210419070106.GC8178@balbir-desktop>
References: <1b0063b922ba18e36a55286a6c23fd74d71b21b0.1618275619.git.brookxu@tencent.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1b0063b922ba18e36a55286a6c23fd74d71b21b0.1618275619.git.brookxu@tencent.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 13, 2021 at 09:37:26AM +0800, brookxu wrote:
> From: Chunguang Xu <brookxu@tencent.com>
> 
> The existing data structure is not very convenient for
> expansion, and part of the code can be saved. Here, try
> to optimize, which can make the code more concise and
> easy to expand.
> 
> Signed-off-by: Chunguang Xu <brookxu@tencent.com>

The approach seems to make sense, but the test robot has found
a few issues, can you correct those as applicable please?

Balbir Singh.
