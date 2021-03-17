Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5791333F888
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Mar 2021 19:55:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233077AbhCQSyv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Mar 2021 14:54:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233039AbhCQSyg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Mar 2021 14:54:36 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2953C06174A
        for <linux-kernel@vger.kernel.org>; Wed, 17 Mar 2021 11:54:36 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id g15so1776908pfq.3
        for <linux-kernel@vger.kernel.org>; Wed, 17 Mar 2021 11:54:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :mime-version;
        bh=yv6zPM7pUlq8ZRYfu9+Rm67Low/6QrEMjW8OfG4+8cQ=;
        b=YFzn3VVUJSbVDNgya8SNZeD4soOBKyMydCL4WfX9JLgKAGcfPgt/aIcDTUWB/DMmc6
         hindDnCjjTtYgkCfZ+KXo5diSGJxleE1YtRJK+/7Q23nr0XIbd9Ni1v0vgcZNTyrQU3y
         Enay3gzr5WWE51j1Nrs205Yv4P7XzGjaZICkqoRnu/iw/hceqlXYlj5K23nBd/U3slHf
         vy7zlUno14BwZIxHXhAiknnJlSOc1pdsdXh2y+glgXN+xx5yqKF0hUPqVwp+o05jGcig
         DCWgUYoH/778U6gfZE03F9doo8KuTyeJc3W5sRSaITbezPXILJilLk1A8PfLLY0xwQ53
         JohQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:mime-version;
        bh=yv6zPM7pUlq8ZRYfu9+Rm67Low/6QrEMjW8OfG4+8cQ=;
        b=nWaShjQV0DaXL2O+kVJ3cPstm1XbpGXb5cXyU3yCu08iwKBdlmXiBwiZIjq0mZmoHG
         UvQuFR9DQtrkCVb6TinXpfCPHfODcbk2276Leym1J4inSThOOhxIu/Au36NCHGUnL1rO
         eRX8k+crRZTs8J+0EJ6m8dCW3wItYlsiD1AH+A5HuLFwBiAbWkkHee7YKrL7JqgcIU3y
         OqXhAjqu9SRypdg/qyyGWkk9pBKY5xwHOdtFeRHoclDmkcnNd+Akytt9BierTA5pl3+l
         0ZffQp4/9ar7YpXP41LFgfqc23tZJn00rtoouLMkILL0NxkpPT06cbS9Tmueb/bLMt0H
         oO9A==
X-Gm-Message-State: AOAM530t5eIRL3ExLDU2oqYC7ekD9hEc9e7vRXyDKYzo62XEpdKUc2z5
        37cXnrpNeG/HxJnphsEWLWjeMw==
X-Google-Smtp-Source: ABdhPJwtjoKr8p+TtaWdwcd66x+jRrRVFgK2czmTEOtkzs9BcIrzlnTGp10l6glE3lYClcQfSDKoNw==
X-Received: by 2002:a62:1c8f:0:b029:209:7eb2:748f with SMTP id c137-20020a621c8f0000b02902097eb2748fmr477175pfc.79.1616007276167;
        Wed, 17 Mar 2021 11:54:36 -0700 (PDT)
Received: from [2620:15c:17:3:b56a:51db:a0a1:259f] ([2620:15c:17:3:b56a:51db:a0a1:259f])
        by smtp.gmail.com with ESMTPSA id t80sm2834084pgb.78.2021.03.17.11.54.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Mar 2021 11:54:35 -0700 (PDT)
Date:   Wed, 17 Mar 2021 11:54:34 -0700 (PDT)
From:   David Rientjes <rientjes@google.com>
To:     Oliver Glitta <glittao@gmail.com>
cc:     cl@linux.com, penberg@kernel.org, iamjoonsoo.kim@lge.com,
        akpm@linux-foundation.org, vbabka@suse.cz, shuah@kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-kselftest@vger.kernel.org
Subject: Re: [PATCH 2/2] slub: remove resiliency_test() function
In-Reply-To: <20210316124118.6874-2-glittao@gmail.com>
Message-ID: <398a728-dc1c-5089-5578-7af596d616ac@google.com>
References: <20210316124118.6874-1-glittao@gmail.com> <20210316124118.6874-2-glittao@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 16 Mar 2021, glittao@gmail.com wrote:

> From: Oliver Glitta <glittao@gmail.com>
> 
> Function resiliency_test() is hidden behind #ifdef
> SLUB_RESILIENCY_TEST that is not part of Kconfig, so nobody
> runs it.
> 
> This function is replaced with kselftest for SLUB added
> by the previous patch "selftests: add a kselftest for SLUB
> debugging functionality".
> 
> Signed-off-by: Oliver Glitta <glittao@gmail.com>

Very nice!

Acked-by: David Rientjes <rientjes@google.com>
