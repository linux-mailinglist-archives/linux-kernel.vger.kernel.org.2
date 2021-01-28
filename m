Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 797EE308209
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Jan 2021 00:43:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231192AbhA1XnL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jan 2021 18:43:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229692AbhA1XnI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jan 2021 18:43:08 -0500
Received: from mail-qv1-xf2d.google.com (mail-qv1-xf2d.google.com [IPv6:2607:f8b0:4864:20::f2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F4C8C061573
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jan 2021 15:42:28 -0800 (PST)
Received: by mail-qv1-xf2d.google.com with SMTP id n3so3678798qvf.11
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jan 2021 15:42:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=88m+q95nUn6HzzgeiCXX4W5ncIMh64ZtHe7euOuMD0k=;
        b=WQnn3c0jSE0t2Cb5s3R24Sa0z+5ZqJnzkHpWW7AOTXOt2rs8glv1Nwpj2pMj3KygFY
         ER9kHZHS2Er+6m4D0YppDAbD6GckxAaauLfprzky6NEPx4HS9thT2bL3L4/MsDBMMXeY
         gqP2a7zz8nLkzuZkaHLtkmZREsrZnkRMtlX9xLwz7itp5gewQRM5UmYwGyUdKNLWIZ+u
         bnjZmYrUT8I3adYP9GjByuDOReAvKlSsgW6pvEChinJ3BQurF/vXBSjcvhz3NKtFlPbU
         2CWDX7Kzlk13wGO6V1AMPp741pe4t68pxR6QawNMDpBABEXWlGlWOY13R4T6O3nTqBKP
         xMYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=88m+q95nUn6HzzgeiCXX4W5ncIMh64ZtHe7euOuMD0k=;
        b=rXUeU71q+EQIzkWy6h5wH2YJlC3w3vM2U9j4wKgBZqfvLC038G4E9CBFO8tvhB03Mj
         s2e3z26Ibjbg532rUld6Di2xcMAT1YMDbG5fmJhvgScdMfhpgkDaRn7E7vQQYSQ45M/T
         oLhtECsFKCa8J6aLeOJjwfdOcAWaxyhEnCj1NLTBv3JSYLf8dooH0YsQVasYanwjhWqx
         xCrCDaL2/vLR/UoK5DX8mLd5rJrrIno/coePucJsWCKnYAoWKT30rjXzdtrHD+pSwX6+
         N3aVUUdYMuozCJa13JVMzdmePgpbWGo6xbIJH5fxLxvmwTiA0bFWzT4qWnOiktzu+Bgs
         EeCg==
X-Gm-Message-State: AOAM533SnTluy7LXINlhLQW0WdagT3fvq0Stb0v5OpkWx6fSJBE7XIRu
        yyxaJ7MCGTVqY0APJD1tMR6678iFbLg=
X-Google-Smtp-Source: ABdhPJx+YPrFP4QWmDosZNRQSw/GsbcFXYZ4lHrBU3+7m+vb7tSoCdHfpp8GIxJnDwI4VWs4FpvwUg==
X-Received: by 2002:a0c:9ccb:: with SMTP id j11mr1715339qvf.44.1611877347303;
        Thu, 28 Jan 2021 15:42:27 -0800 (PST)
Received: from localhost ([2620:10d:c091:480::1:86fa])
        by smtp.gmail.com with ESMTPSA id w28sm4394354qtv.93.2021.01.28.15.42.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Jan 2021 15:42:26 -0800 (PST)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Thu, 28 Jan 2021 18:41:34 -0500
From:   Tejun Heo <tj@kernel.org>
To:     Saravanan D <saravanand@fb.com>
Cc:     x86@kernel.org, dave.hansen@linux.intel.com, luto@kernel.org,
        peterz@infradead.org, willy@infradead.org,
        linux-kernel@vger.kernel.org, kernel-team@fb.com,
        linux-mm@kvack.org, songliubraving@fb.com, hannes@cmpxchg.org
Subject: Re: [PATCH V6] x86/mm: Tracking linear mapping split events
Message-ID: <YBNLrg1CI4yGBOyB@mtj.duckdns.org>
References: <20210128212048.oopcyfdf4j2lc663@devvm1945.atn0.facebook.com>
 <20210128233430.1460964-1-saravanand@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210128233430.1460964-1-saravanand@fb.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 28, 2021 at 03:34:30PM -0800, Saravanan D wrote:
> To help with debugging the sluggishness caused by TLB miss/reload,
> we introduce monotonic hugepage [direct mapped] split event counts since
> system state: SYSTEM_RUNNING to be displayed as part of
> /proc/vmstat in x86 servers
...
> Signed-off-by: Saravanan D <saravanand@fb.com>

Acked-by: Tejun Heo <tj@kernel.org>

Thanks.

-- 
tejun
