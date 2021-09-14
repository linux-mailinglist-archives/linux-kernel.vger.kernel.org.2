Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A52BC40B7FF
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Sep 2021 21:30:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232986AbhINTbr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Sep 2021 15:31:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232909AbhINTbq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Sep 2021 15:31:46 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05661C061574
        for <linux-kernel@vger.kernel.org>; Tue, 14 Sep 2021 12:30:29 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id c13-20020a17090a558d00b00198e6497a4fso3058218pji.4
        for <linux-kernel@vger.kernel.org>; Tue, 14 Sep 2021 12:30:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=vrjLDI3rk3n/iE7R3MDi8dHAYy5wuiJVn0w/n/EsYnA=;
        b=eE3ivPTpv/AGUvvkvem+4BezTjlWB3LRwXtHtijRSpJTfq9lv0x5uV/h7BWRSAhuQK
         9+FOmrRELlQYIuBiz1kFK23lOXIOF+J4MNqXsHmU2GCgTum7uH1m4EeXygGkJsU93nJI
         9SUXjo03R/RbBR/hF90ZY6JVNrPRvJcNrnShk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=vrjLDI3rk3n/iE7R3MDi8dHAYy5wuiJVn0w/n/EsYnA=;
        b=ecyLYHLQe/GqsOw87n+PyOIlbg2pBMUsezLNlmoEXx6Ct9K7dt39iVH7xBZPOr7Rxe
         60u/4MchO4l3E9U6GysGDTWgey2Hpgv64PG119VnMAvEfjPwuwljsXfQyFQ5/VFGpbVl
         BujwuPPAzNdygx5KKdcGqaLE9FRloRjaNfa+1+gBD5t1aYzsyLMCXma8lq1ODdL9frWa
         XIBGi9Ph0vvvXQFMQUN6jxio7TU9wFbPgHAC4I5NSuBHXMJiXatldFP+iq8qLLjQeOTB
         yySJ6aFOlfsegLcf7qu8e5cu3SodsGTpQld2/FiSB9Z7F7JHqU8n6H6csZbVGIl4GHc0
         oGsQ==
X-Gm-Message-State: AOAM530m1qbSJYXXmpke3Z4hFouaOp2WGwUwAMccREoB02UB3aulu/Ch
        LutBUqoW2TOqlP0Q0p0z/nVcVA==
X-Google-Smtp-Source: ABdhPJzX3GhfqYzv0s5WHJWHkFG36qgWwQqhOl130l2VJDgrtTrXppJ5+WcAXUMMbHlrTw7AqYonbw==
X-Received: by 2002:a17:902:7c8d:b0:13a:768b:d6c0 with SMTP id y13-20020a1709027c8d00b0013a768bd6c0mr16583479pll.83.1631647828551;
        Tue, 14 Sep 2021 12:30:28 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id cl16sm2411732pjb.23.2021.09.14.12.30.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Sep 2021 12:30:28 -0700 (PDT)
Date:   Tue, 14 Sep 2021 12:30:26 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Sami Tolvanen <samitolvanen@google.com>
Cc:     x86@kernel.org, Josh Poimboeuf <jpoimboe@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Sedat Dilek <sedat.dilek@gmail.com>,
        linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org,
        clang-built-linux@googlegroups.com
Subject: Re: [PATCH v3 07/16] lkdtm: Disable UNSET_SMEP with CFI
Message-ID: <202109141229.F1710D3A@keescook>
References: <20210914191045.2234020-1-samitolvanen@google.com>
 <20210914191045.2234020-8-samitolvanen@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210914191045.2234020-8-samitolvanen@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 14, 2021 at 12:10:36PM -0700, Sami Tolvanen wrote:
> Disable the UNSET_SMEP test when CONFIG_CFI_CLANG is enabled as
> jumping to a call gadget would always trip CFI instead.
> 
> Signed-off-by: Sami Tolvanen <samitolvanen@google.com>

Yeah, (thankfully) this test can't work sanely under CFI.

Acked-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
