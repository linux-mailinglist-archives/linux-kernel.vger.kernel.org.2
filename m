Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E691830E18B
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Feb 2021 18:57:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232163AbhBCRzs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Feb 2021 12:55:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231145AbhBCRzg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Feb 2021 12:55:36 -0500
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA46FC0613ED
        for <linux-kernel@vger.kernel.org>; Wed,  3 Feb 2021 09:54:55 -0800 (PST)
Received: by mail-pl1-x634.google.com with SMTP id e12so290931pls.4
        for <linux-kernel@vger.kernel.org>; Wed, 03 Feb 2021 09:54:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=WLPpmuoMnntjkG/fIUbWX3oVqD2wo7PLGg0ygE+p8qQ=;
        b=wMWCpb1OCsMUwMThFJU2HENyKWAnxoazDitFa1VcrahK/ipAxejl9JMO3av09MtLzP
         Du6gF7odkfIozdqXvE4KO6hon5kV5AT4a+rmwNjt32+PBs0wr35wu9gmteRBpECTdl1g
         EpmYVzpQyaoANoSPiKlbgC1AT9Ykhk2vB1YolUExrStWrZDQ9sAICBqkIGzRD313AXk9
         Vk/QyZT8YTazoTns28KhCYs3xbtmTcEo48Zb5ZIO5uqkP5dXaHl25McfJn4iRUbfpYnO
         zmq4yUW39LSxrZMh97pnIsgiLt2u13zSEEld3U8kjswdDqdL6FJlv8l1BIPV60ty9POO
         0zTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=WLPpmuoMnntjkG/fIUbWX3oVqD2wo7PLGg0ygE+p8qQ=;
        b=WUGwEpCTPqdlIzchU201SvGDSBKlxXZxAtLIRAp5AbOEflTwvYoXYk0bnTFsmE+DWX
         7TPWsBzRGhJgpRGtq07KIhJSyBBQsSkQF2qmGcAYQcNll0c0CC4+UEDzAGTRU/nhqus6
         g/z0OMS1zT7EylwJXyKwHGxGremMqKiEvxfyjp+u/hye3yzl+euosN5+l9QY8CQx9JiV
         bRGewBtgrlFqTzDTRpyMkiYFXAw9gdaoJz7LRZIZmzLZHuesEbZB678ueKZOtpFNDSaZ
         XO8gQhjSxTm6oXYexLAlXJ9CnrxPYwYWmXBKgPhRImeFFGoIilxoBi5ExY/2/IGGqYQY
         CrBg==
X-Gm-Message-State: AOAM531OxPchrLQbeK7wecEt7fvnfb7+trXpxOjy9Dx8RDq5v3/BwYCt
        4MdlMaTMpTfbUhj6SZELXPZ7mQ==
X-Google-Smtp-Source: ABdhPJzuao3RhAbtQt222HYu0p+Q/piZgOBtiyBCfae1XCn2dcKGdo6Go7mDGWqi/WrR4GK2+OpEtA==
X-Received: by 2002:a17:902:a581:b029:e1:8d90:2810 with SMTP id az1-20020a170902a581b02900e18d902810mr4063101plb.85.1612374894962;
        Wed, 03 Feb 2021 09:54:54 -0800 (PST)
Received: from google.com ([2620:15c:f:10:a9a0:e924:d161:b6cb])
        by smtp.gmail.com with ESMTPSA id l1sm3237279pgt.26.2021.02.03.09.54.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Feb 2021 09:54:54 -0800 (PST)
Date:   Wed, 3 Feb 2021 09:54:47 -0800
From:   Sean Christopherson <seanjc@google.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     Ben Gardon <bgardon@google.com>, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org, Peter Xu <peterx@redhat.com>,
        Peter Shier <pshier@google.com>,
        Peter Feiner <pfeiner@google.com>,
        Junaid Shahid <junaids@google.com>,
        Jim Mattson <jmattson@google.com>,
        Yulei Zhang <yulei.kernel@gmail.com>,
        Wanpeng Li <kernellwp@gmail.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Xiao Guangrong <xiaoguangrong.eric@gmail.com>
Subject: Re: [PATCH v2 00/28] Allow parallel MMU operations with TDP MMU
Message-ID: <YBrjZ775SImFPGWV@google.com>
References: <20210202185734.1680553-1-bgardon@google.com>
 <298548e9-ead2-5770-7ae8-e501c9c17263@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <298548e9-ead2-5770-7ae8-e501c9c17263@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 03, 2021, Paolo Bonzini wrote:
> Looks good!  I'll wait for a few days of reviews,

I guess I know what I'm doing this afternoon :-)

> but I'd like to queue this for 5.12 and I plan to make it the default in 5.13
> or 5.12-rc (depending on when I can ask Red Hat QE to give it a shake).

Hmm, given that kvm/queue doesn't seem to get widespread testing, I think it
should be enabled by default in rc1 for whatever kernel it targets.

Would it be too heinous to enable it by default in 5.12-rc1, knowing full well
that there's a good possibility it would get reverted?
