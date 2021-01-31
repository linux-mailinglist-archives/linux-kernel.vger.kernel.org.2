Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E572F309995
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Jan 2021 02:15:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232323AbhAaBNt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 30 Jan 2021 20:13:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232139AbhAaBNq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Jan 2021 20:13:46 -0500
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AED13C061573
        for <linux-kernel@vger.kernel.org>; Sat, 30 Jan 2021 17:13:06 -0800 (PST)
Received: by mail-pj1-x102f.google.com with SMTP id s23so1936697pjz.4
        for <linux-kernel@vger.kernel.org>; Sat, 30 Jan 2021 17:13:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :mime-version;
        bh=geHys1mPXra3Yjh1rUTJswUB8dwEHtto7sexm9cJop8=;
        b=oa4XDks5ZEWDue2tuy+ydKzLj4eCw0JDjZI8Y/Bto+XEVhC8nXvKhESjWFCsOJmg/q
         n0HQT25vjq3VLP1/5BN5vxzmWJ+YAFihYVKkQaRIkDknf+h4w/zhbSAR/mlvWie5FrOW
         ogaEEXg55w04EIip+suKm9/ujQO3QqxRmeiu0aztDiVdO0fM2Ntc0vYtiWMngiWeuCik
         Nw6aKRdm3f++Yyd96eyILIKspK1TPjarprCsnE5l0JJ+AlKfsnp8zd/ZqFUKnkgJ66On
         oMzQuod1iZHB4/yigykBcLVh7hp9f90w5BYep7tFr0WhovHGu4tHhiOYOx7L66E/p50m
         2ewg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:mime-version;
        bh=geHys1mPXra3Yjh1rUTJswUB8dwEHtto7sexm9cJop8=;
        b=PbuF+Lnkyf9XmjzGn6qNUhOed6WyKsnOAqwRy6bz3mNjqIxk1x9EyXwV/K0AhmxxIa
         1ZeEomYctuwvNzHDRXHKgU4UmCo+QbVv4LxDNz63S85AGPWqpj2FD/x9x517quNEx6nK
         IGeHBGEbFvVClXky/pwfFj6oAaDxVp+oa6M8to2PiYpKYDTYdvGUjksLTfCnNx8D59Gv
         XF+9LDgtgEja4VkCn5fupu+7CRimP2TuTF8S+F+N1bERvSzoIBUotnMnJBRiuW95TrI3
         Nz67uR6h7olmDYz2QitnDoeZf3kGjYirzNW2XfvOHVLNVDD/m0qu9Qp/1+H/Rg0R08ww
         oWxg==
X-Gm-Message-State: AOAM5331rwsZo9ExyVuJdVW3tO5WVB1YMkKeDAfwT7nyNbX7X6mpuJsj
        r7/fAdEHhiYlsOoz3PgHLxE3rsoXbVx7rA==
X-Google-Smtp-Source: ABdhPJzA9+eFue+jWm7hJ732dkfFT3xS7wH7A7MZlcxmBeIJSy2jfFfZlWJSbA6khIZxN3NWPXBWfA==
X-Received: by 2002:a17:902:b411:b029:e0:8f0:5ba with SMTP id x17-20020a170902b411b02900e008f005bamr11920016plr.19.1612055586148;
        Sat, 30 Jan 2021 17:13:06 -0800 (PST)
Received: from [2620:15c:17:3:4a0f:cfff:fe51:6667] ([2620:15c:17:3:4a0f:cfff:fe51:6667])
        by smtp.gmail.com with ESMTPSA id c11sm11251186pjv.3.2021.01.30.17.13.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 Jan 2021 17:13:05 -0800 (PST)
Date:   Sat, 30 Jan 2021 17:13:04 -0800 (PST)
From:   David Rientjes <rientjes@google.com>
To:     Dave Hansen <dave.hansen@linux.intel.com>,
        Andrew Morton <akpm@linux-foundation.org>
cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        yang.shi@linux.alibaba.com, ying.huang@intel.com,
        dan.j.williams@intel.com, david@redhat.com, osalvador@suse.de
Subject: Re: [RFC][PATCH 00/13] [v5] Migrate Pages in lieu of discard
In-Reply-To: <20210126003411.2AC51464@viggo.jf.intel.com>
Message-ID: <52675770-74e1-a78e-8d80-b56d57bb31f3@google.com>
References: <20210126003411.2AC51464@viggo.jf.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 25 Jan 2021, Dave Hansen wrote:

> This also contains a few prerequisite patches that fix up an issue
> with the vm.zone_reclaim_mode sysctl ABI.
> 

I think these patches (patches 1-3) can be staged in -mm now since they 
fix vm.zone_reclaim_mode correctness and consistency.

Andrew, would it be possible to take patches 1-3 now since they are fix an 
existing issue?
