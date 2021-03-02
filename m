Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A382032AE39
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Mar 2021 03:51:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1384548AbhCBWld (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Mar 2021 17:41:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2359807AbhCBWDh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Mar 2021 17:03:37 -0500
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D34BC061756
        for <linux-kernel@vger.kernel.org>; Tue,  2 Mar 2021 14:02:57 -0800 (PST)
Received: by mail-pl1-x62c.google.com with SMTP id c16so3363200ply.0
        for <linux-kernel@vger.kernel.org>; Tue, 02 Mar 2021 14:02:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=VSzmNjYTy01rJCfITYLeDvSot7XkofY2f8pmB6oIiPU=;
        b=v37pp5Ker1zCTvHH+3OnIxFtYbk5M3rLpiFL+FTfZJ5mpMChJzIUg9M320fc4moIzs
         kpSj8bAmqKmbeth9zC67P+0SqwGAGippvQLKIN/fDhxY35Q8lrdxFABYWGXoEV+xYQ+1
         O2n6FbBHXRNDPKlU8icEXpQCYVy3TRjdB4TBG23vdkYWIC2v7q8BsvG5ExlX97G6dupj
         jXJKfhRpFJwJCzwg5qz/P/vLfr18awjf14gftsfr0VB7iUL+RsnggfP3mBd6SvQYFQse
         9YHaBYt3wiFgZpxsEnsFjddP0V8ydTQ/MKvW3+Nb4tQlir7nYoouuRhW6MtmYnrs48Sp
         u2fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=VSzmNjYTy01rJCfITYLeDvSot7XkofY2f8pmB6oIiPU=;
        b=AxiOn2DVpjU0J20eBQrQ7KsnDA9lC2Qf4KCYUZstYKUSPcEIfVWBKf35ZDKtADJDnM
         Le0SeRFEHTXv76stDJ1SnTMApo/eAo3l20AJubD1BlO0vmEkiGIza69EX993yr/YW5W0
         rBToS6d+C28LUlHfEhO92bUwPjbi4neh6vsx2RbPhAzYOvszyMIqH/wp1f0E/RglqMZR
         hBrhat38A26rdFf1ed+K66vgNyAvptM7R3PPguwpeXYcMhFHDrHFlQy2W/gmwjUQiDAy
         r9E8qxoUYZ5YFLCFAGrcP2x314l0fILRMMTZKqTN3EXr6Wkv6fzjRgNnjlUIoX7KrK71
         udAg==
X-Gm-Message-State: AOAM531uEDtQR6coMl8+jbEnZlqqhGR5hwl1doaNLjxglwCwLRHckggE
        FydgpNX5swTeSlT4LSJIOU3hZA==
X-Google-Smtp-Source: ABdhPJxMg9Kt2BsfPvGs37KwCN5uyARf6e9xc254ZYaXK+YgVGe/tpRqN/nhDso36qmUE3trvvwX5A==
X-Received: by 2002:a17:90a:1b08:: with SMTP id q8mr6229310pjq.203.1614722576641;
        Tue, 02 Mar 2021 14:02:56 -0800 (PST)
Received: from google.com ([2620:15c:2ce:0:fce5:88bc:1857:36b4])
        by smtp.gmail.com with ESMTPSA id g6sm22462672pfi.15.2021.03.02.14.02.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Mar 2021 14:02:56 -0800 (PST)
Date:   Tue, 2 Mar 2021 14:02:52 -0800
From:   Fangrui Song <maskray@google.com>
To:     Nathan Chancellor <nathan@kernel.org>
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Nick Desaulniers <ndesaulniers@google.com>,
        linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
        clang-built-linux@googlegroups.com
Subject: Re: [PATCH 2/2] Makefile: Only specify '--prefix=' when building
 with clang + GNU as
Message-ID: <20210302220252.ulvlsfyp4ordwrky@google.com>
References: <20210302210646.3044738-1-nathan@kernel.org>
 <20210302210646.3044738-2-nathan@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20210302210646.3044738-2-nathan@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021-03-02, Nathan Chancellor wrote:
>When building with LLVM_IAS=1, there is no point to specifying
>'--prefix=' because that flag is only used to find the cross assembler,
>which is clang itself when building with LLVM_IAS=1. All of the other
>tools are invoked directly from PATH or a full path specified via the
>command line, which does not depend on the value of '--prefix='.
>
>Sharing commands to reproduce issues becomes a little bit easier without
>a '--prefix=' value because that '--prefix=' value is specific to a
>user's machine due to it being an absolute path.
>
>Signed-off-by: Nathan Chancellor <nathan@kernel.org>

Reviewed-by: Fangrui Song <maskray@google.com>

clang can spawn GNU as (if -f?no-integrated-as is specified) and GNU
objcopy (-f?no-integrated-as and -gsplit-dwarf and -g[123]).

With LLVM_IAS=1, these cases are ruled out.
