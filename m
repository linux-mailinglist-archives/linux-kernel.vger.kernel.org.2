Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C8D843659F
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Oct 2021 17:14:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231983AbhJUPRH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Oct 2021 11:17:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231903AbhJUPQv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Oct 2021 11:16:51 -0400
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71FBFC061236
        for <linux-kernel@vger.kernel.org>; Thu, 21 Oct 2021 08:13:55 -0700 (PDT)
Received: by mail-pg1-x530.google.com with SMTP id s136so608048pgs.4
        for <linux-kernel@vger.kernel.org>; Thu, 21 Oct 2021 08:13:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=qjXozcQMnfIM3dicc9zvKHeODcG75SZtpg7ouGfbVfc=;
        b=jW5xpB2J0jyBp0RMEG/3YYkcELH1lqtEi8p3PzBVZaCRXUwWGFl5S8lc0OQ1W+yXkY
         Kw9ibn+h0mQAgGlNZRFVKMkk16XhLc4gaP59pxuphw+6EXB5oWBmrAVn7sDsfEmlHGL+
         9gvFRczrVhn40swm9MdzYwnX7/xnLUEL2xq8s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qjXozcQMnfIM3dicc9zvKHeODcG75SZtpg7ouGfbVfc=;
        b=6rTVS8SvDhLDuBVoQ9q4/BfhCU6lRVuFPrz+0NpLCFUL5AIVoBhy0mz2blwyLEfPlN
         6S/C4SjLNV7Sha2OuwFrvfcBvc3NyGX2o1cQSwSoXv8k9PzYmMoA00Zukx3hfs8w1nG/
         DAMs+jYhLZqlYy4M5lXcrAlalaZToxn4SUwPOnXUlz5Hxrm4BYryVemBJWbGrqVviKXi
         lq8Y/eg4eNinzsqSU5256VRrQeuZORwaNvcuayXxAluqmBFqPqE7UISGzq4iVullvQNK
         1iTEX86ty2uPJbFlVQAwFEygWQ4NKaOvT1Gla3y9CwehcoZ6s5rNmv7Eimz4YBo2qupv
         zXSA==
X-Gm-Message-State: AOAM532Hhc6ELQuipthDde/oDKNXKTn4S0LmUaLxB6cJhd+3ChFgye01
        +yXOTQ7NrN5AjDf97gn1bdVO/g==
X-Google-Smtp-Source: ABdhPJx6LGNRT2TP1IaZ8cHA4ospDpLYy/j0F8k1ITp2zTOjd5jCu7IB3rsKv1TLJrGf/O1HRIfG5g==
X-Received: by 2002:a05:6a00:c8c:b0:44d:c583:9b45 with SMTP id a12-20020a056a000c8c00b0044dc5839b45mr6024548pfv.28.1634829234930;
        Thu, 21 Oct 2021 08:13:54 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id s30sm5574234pgn.38.2021.10.21.08.13.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Oct 2021 08:13:54 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     cgel.zte@gmail.com
Cc:     Kees Cook <keescook@chromium.org>, linux-hardening@vger.kernel.org,
        Zeal Robot <zealci@zte.com.cn>, linux-kernel@vger.kernel.org,
        Ye Guojin <ye.guojin@zte.com.cn>
Subject: Re: [PATCH V1] gcc-plugins: remove duplicate include in gcc-common.h
Date:   Thu, 21 Oct 2021 08:13:42 -0700
Message-Id: <163482921914.879721.5643296134310047857.b4-ty@chromium.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211019082910.998257-1-ye.guojin@zte.com.cn>
References: <20211019082910.998257-1-ye.guojin@zte.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 19 Oct 2021 08:29:10 +0000, cgel.zte@gmail.com wrote:
> From: Ye Guojin <ye.guojin@zte.com.cn>
> 
> 'tree-ssa-operands.h' included in 'gcc-common.h' is duplicated.
> it's also included at line 56.
> 
> 

Applied to for-next/hardening, thanks!

[1/1] gcc-plugins: remove duplicate include in gcc-common.h
      https://git.kernel.org/kees/c/872268237551

-- 
Kees Cook

