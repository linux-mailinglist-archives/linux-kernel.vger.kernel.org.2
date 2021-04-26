Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA34936AA33
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Apr 2021 03:10:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231567AbhDZBKy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Apr 2021 21:10:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231403AbhDZBKu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Apr 2021 21:10:50 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00A65C061574
        for <linux-kernel@vger.kernel.org>; Sun, 25 Apr 2021 18:10:10 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id kb13-20020a17090ae7cdb02901503d67f0beso6853842pjb.0
        for <linux-kernel@vger.kernel.org>; Sun, 25 Apr 2021 18:10:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :mime-version;
        bh=pTKzBHp5j0vCgxSh4c7wshNFuD9LEJ9YRB/12kbwjnM=;
        b=T+oBdu+wmEg5aKOemx/tinBpUPPzwyvupn4p2rlKf2qpdonjPewcz4t7qRn9D3FtbT
         5ndwvc/f/kQ3+5+5nu1WDGdnoyWuR+slQ9yF4UFlQ2CyPlfbDIHBePZc+ot6VDYftXHc
         Uc/YwAvXc+vTliKH91KpJotokdDciNI2rIAE6JIlhwlL8i5z6uJqYVxn3+ylhUFcxG15
         YTaULgFULEQQteoxvPa/Av4Bb/2CHBh+dNFzphrM1GNI+9s4cVVTnd/D4DZjAnL85n8/
         F6t59KGA87z1cZQ14gogFvPNy+ni3BflKrzstuPrtvT/yvCZLaay0ZoHGKbcNO7Gk//2
         oOLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:mime-version;
        bh=pTKzBHp5j0vCgxSh4c7wshNFuD9LEJ9YRB/12kbwjnM=;
        b=U4z8IMbyhNWzpDcEFPDwqr2Lgp9HfHpvr86ol7GGAFWxmH0omKt4mAuhOPWK9qJ9gA
         ksuIByrtUxfMvitZClqOjkVFROqX3gr9GnYC80nB4wSaT822hksmWXm+/HA8bHd9ZxSq
         n3kqUZk1qP0dmtu79V9W4EvofvM/Ri6vTELNmutnqo8Lj+BRg0g3Yo28/HvZpqykmRGO
         MdbU+JcyAX6DuXf2OMaLtNnXQ4LD/epg8SlqjqQK6aR1N14TCv1MD7tVsZT5juliGuuT
         oyLi+rNE5Ls5ARoATqpMPVdNGcGREaGEEuG+sZcEXeIZxBKVp2K5YPZTHpSVu/H71VbP
         +bpg==
X-Gm-Message-State: AOAM533NlH8cV6JIw8YmR+L2TGKtKMrMtIrQNiyOMQ+sK8Be3QXmDJD6
        OC84EUA+7XNW7AksVvNup5l/BQ==
X-Google-Smtp-Source: ABdhPJzbbtMa5X50t8cJdluFStqkvCSKNnlki6qQdnTAcBXLg2hkN/nNxgDELvuQ8+Oz2PLjmVhY3Q==
X-Received: by 2002:a17:902:b703:b029:eb:59c3:a9b0 with SMTP id d3-20020a170902b703b02900eb59c3a9b0mr15462567pls.45.1619399409395;
        Sun, 25 Apr 2021 18:10:09 -0700 (PDT)
Received: from [2620:15c:17:3:f93a:1c09:9070:93a7] ([2620:15c:17:3:f93a:1c09:9070:93a7])
        by smtp.gmail.com with ESMTPSA id ga21sm10649060pjb.5.2021.04.25.18.10.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Apr 2021 18:10:08 -0700 (PDT)
Date:   Sun, 25 Apr 2021 18:10:07 -0700 (PDT)
From:   David Rientjes <rientjes@google.com>
To:     Oliver Glitta <glittao@gmail.com>
cc:     cl@linux.com, penberg@kernel.org, iamjoonsoo.kim@lge.com,
        akpm@linux-foundation.org, vbabka@suse.cz,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH] mm/slub: use stackdepot to save stack trace in objects
In-Reply-To: <20210414163434.4376-1-glittao@gmail.com>
Message-ID: <3558629b-2ae3-7c8a-f121-c3413aa8fb30@google.com>
References: <20210414163434.4376-1-glittao@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 14 Apr 2021, glittao@gmail.com wrote:

> From: Oliver Glitta <glittao@gmail.com>
> 
> Many stack traces are similar so there are many similar arrays.
> Stackdepot saves each unique stack only once.
> 
> Replace field addrs in struct track with depot_stack_handle_t handle.
> Use stackdepot to save stack trace.
> 
> The benefits are smaller memory overhead and possibility to aggregate
> per-cache statistics in the future using the stackdepot handle
> instead of matching stacks manually.
> 
> Signed-off-by: Oliver Glitta <glittao@gmail.com>

Acked-by: David Rientjes <rientjes@google.com>
