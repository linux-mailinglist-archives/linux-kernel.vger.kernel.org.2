Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 341EF377E8D
	for <lists+linux-kernel@lfdr.de>; Mon, 10 May 2021 10:48:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230167AbhEJIto (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 May 2021 04:49:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230098AbhEJIto (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 May 2021 04:49:44 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDE3BC061573
        for <linux-kernel@vger.kernel.org>; Mon, 10 May 2021 01:48:39 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id gq14-20020a17090b104eb029015be008ab0fso9653242pjb.1
        for <linux-kernel@vger.kernel.org>; Mon, 10 May 2021 01:48:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=+UcqOe4LhkyGzOZfB3XomBHQSeGqf3Yt+3h243pzOtU=;
        b=SkBJRHZsD9rIMqfx5UwbwNKDHjA8/TZOTocf6Yog28p+962M6IzOLorlfQOuXdZWPs
         Zr00rlok2VjQsKD8Q3y2zx9Ci22jwIPy0qpjGQw4wQ9bHl0PPJWvh/G+ptEwov6aQOox
         XhUmBgdr2EvZqjKcMQKPmceDDwqVuRCEbKMSGh8B0KAYXEk3Ur9++mdq3eUOSAP8iIXy
         HOVZTKfaMYHXA4CrmerdrYdgT47kC3ZD8nj/tiGA3dSqzC/rCZx588KaqdkpqhBkX6eF
         G1jETc0bl/YmtOaW6uMC6gnUl10h6vCAECrDJbpisJV8JIlKJpnL/ndYJPU6n+hhy5cF
         5ENw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=+UcqOe4LhkyGzOZfB3XomBHQSeGqf3Yt+3h243pzOtU=;
        b=FAJ2Bj2AYQklyhr5e2d9ihqU2GIUjaNyQdIfc1s7HN/jprcBsGzY60K/uBBzn2UjV5
         rseN830uf8JIzOiJWoCMstgGdCJ0d2jbfu/usCHFp0XKSkW9mMdCm6CMK37wTOD/M+ef
         BtKqvQFaSX+quJ7s6BTksdU0aJOwIa9h8nc5F+63XghfD27XDO8yyiZi5XHXvp7vl3lj
         Q8l7YMusY+Lw4LNrisESTmjo5hH35s3wmJa1bx8DsY9jj4AYOmeOEGiwDbt1JRFt48Q+
         C2EWnPSbiC2nUlWnpsyzoS/ay/6f8SbNdX0/dg0B8ftdo2zsZyW7Abj3m3gH4X+kpRd4
         Ozxg==
X-Gm-Message-State: AOAM530kG0ZOmIE/hOC1nnd7PvbBh8pMMnM7AMtDnGXEajJRbKk4VR5+
        V1KEDgsl3wwJAaFVDRSO7M4=
X-Google-Smtp-Source: ABdhPJxv8LKOS78i5TlawtIOw8QbKd9iV771RXqAK8qpLAp7w6bZsh5gyB5xOEweT9E+L+pVkaWOWg==
X-Received: by 2002:a17:902:7888:b029:ee:cea7:6ff0 with SMTP id q8-20020a1709027888b02900eecea76ff0mr23746205pll.16.1620636519503;
        Mon, 10 May 2021 01:48:39 -0700 (PDT)
Received: from localhost ([203.87.99.126])
        by smtp.gmail.com with ESMTPSA id bx12sm18984691pjb.1.2021.05.10.01.48.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 May 2021 01:48:38 -0700 (PDT)
Date:   Mon, 10 May 2021 18:48:35 +1000
From:   Balbir Singh <bsingharora@gmail.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     brookxu <brookxu.cn@gmail.com>, adobriyan@gmail.com,
        ebiederm@xmission.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] delayacct: add a proc file to dump the delay info
Message-ID: <20210510084835.GG4236@balbir-desktop>
References: <8ac9f35074326cb36e3cdbf0ad70b36dc3412e86.1618841970.git.brookxu@tencent.com>
 <3da76d1d565c423c6cbf92b02cbae9f86cd5accd.1618841970.git.brookxu@tencent.com>
 <20210509205853.42a3a06f9c5b70b52bdf8509@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210509205853.42a3a06f9c5b70b52bdf8509@linux-foundation.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 09, 2021 at 08:58:53PM -0700, Andrew Morton wrote:
> On Mon, 19 Apr 2021 22:37:07 +0800 brookxu <brookxu.cn@gmail.com> wrote:
> 
> > Many distributions do not install the getdelay tool by
> > default, similar to task_io_accounting, adding a proc
> > file to make access easier.
> 
> Well, we developed and maintain getdelays.c for a reason.  Why should
> we add (and maintain) kernel code because some people are too
> lame to install the tool we provided?

+1

I think we should find a way to repackage the tool into distributions again.

Balbir Singh
