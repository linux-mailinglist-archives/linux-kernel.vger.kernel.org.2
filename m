Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5BEDA4258BA
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Oct 2021 19:00:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242957AbhJGRCJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Oct 2021 13:02:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243133AbhJGRCB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Oct 2021 13:02:01 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA276C061762
        for <linux-kernel@vger.kernel.org>; Thu,  7 Oct 2021 09:59:40 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id c4so4340191pls.6
        for <linux-kernel@vger.kernel.org>; Thu, 07 Oct 2021 09:59:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=yERRP/h2WFq/6psT+T3rd8+HBUqGjcweMJ5gK787JbE=;
        b=f0HjZkODIerWfA73piKz8wgMPXWjeyrXnfEBoSHUMtJhl6B7D6VdnaZbcdjTjXwzAx
         NrQzen9rYkAlNYkhUi1Nz/gqTXQATpWBr2G6dy0VCm9mZmmmJKUVwKv2spS+4RTx/bF1
         5TL4FTQXYQxhjoGx5TRXScjJRyl/V1syHb21k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=yERRP/h2WFq/6psT+T3rd8+HBUqGjcweMJ5gK787JbE=;
        b=g+ncxJwtyOKnqRoWM6kFFqXC2U367131lcbJ5hj0no408GiI9uXqq9FkOtIoItuIZz
         FwhQD9rQ8eVcBy/ipr+OiQsO3gkc8dSYkG6rKN9bNi7VWrJ9ceenJzRUx5SfQ0d9G820
         tlQnJBLOE0QmCenL4m1TkTh2nvKWEV1zcCPyqAR4JZBlahluQJwDbfxr2YjXZeF3fuWj
         KUZlRHbNc8EVbIB3jgytbQduZsx3txKmnsNpG79zrkaXb6u0HcINlQJsn8a+piqteLtO
         fOBpDwd1wc2/A6XPUW2qvzYCzZNhHFVwzjbHtjgwF+yRF05HF2khbDq+45K+VZGRKCKW
         AA+g==
X-Gm-Message-State: AOAM530wMhyXYprs+VYZYgN/l6ZFVLEFZvijS5eeQX3JiWOG5MMKAw/R
        qHm+fZQGxKe47M6xoo4Glzqvag==
X-Google-Smtp-Source: ABdhPJyabiwLZ6Eai1H60q/0WMMp1G5b+0BUr+c1q8Sxwh/GZ2x23HKy6i2K4QZFKHeAU3BG0Qf8iQ==
X-Received: by 2002:a17:90a:7348:: with SMTP id j8mr6065704pjs.104.1633625980235;
        Thu, 07 Oct 2021 09:59:40 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id k6sm15383pfg.18.2021.10.07.09.59.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Oct 2021 09:59:39 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     linux-kernel@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>
Cc:     Kees Cook <keescook@chromium.org>
Subject: Re: [PATCH] lkdtm: avoid printk() in recursive_loop()
Date:   Thu,  7 Oct 2021 09:59:27 -0700
Message-Id: <163362596339.2313433.1892710945535449841.b4-ty@chromium.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211007081235.382697-1-ardb@kernel.org>
References: <20211007081235.382697-1-ardb@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 7 Oct 2021 10:12:35 +0200, Ard Biesheuvel wrote:
> The recursive_loop() function is intended as a diagnostic to ensure that
> exhausting the stack is caught and mitigated. Currently, it uses
> pr_info() to ensure that the function has side effects that the compiler
> cannot simply optimize away, so that the stack footprint does not get
> reduced inadvertently.
> 
> The typical mitigation for stack overflow is to kill the task, and this
> overflow may occur inside the call to pr_info(), which means it could be
> holding the console lock when this happens. This means that the console
> lock is never going to be released again, preventing the diagnostic
> prints related to the stack overflow handling from being visible on the
> console.
> 
> [...]

Applied to for-next/lkdtm, thanks!

[1/1] lkdtm: avoid printk() in recursive_loop()
      https://git.kernel.org/kees/c/700fa7d22233

-- 
Kees Cook

