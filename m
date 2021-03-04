Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D5D432DADA
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Mar 2021 21:09:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238364AbhCDUIU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Mar 2021 15:08:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232049AbhCDUHz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Mar 2021 15:07:55 -0500
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30F78C061574
        for <linux-kernel@vger.kernel.org>; Thu,  4 Mar 2021 12:07:15 -0800 (PST)
Received: by mail-pl1-x629.google.com with SMTP id z5so3935591plg.3
        for <linux-kernel@vger.kernel.org>; Thu, 04 Mar 2021 12:07:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=CdhEZrwSuOVhldsfNLdTiXC9JhrXAlkTpu/9CV7h/XM=;
        b=FOhy2RHXyNmaiynRJ6OJVOsr6iGV+sH35EWTdC/Rd72R4e+WYLOiNFxWEf+oz2j3jN
         fdWh0q2Jpr+DeeM4cTJKvzS7nEsoBE2vuLJ3sFS2nz6IbrfEREw8DNOOZrVmZuWaJ3GX
         GYu8SofSwg7r1/DcZfl0C3S4H17G6NO+daIxU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=CdhEZrwSuOVhldsfNLdTiXC9JhrXAlkTpu/9CV7h/XM=;
        b=tIlxZZRMBy+ynHrcp9WM8EQqKn1H/FyP/9us9OJJbV8wn2+aksT6l6BSdJWpSc7NgY
         Lem860IRfZ9SyvtqMVuD3nd48sltON+vEJGuE6wYk3r+5YwNbbyqsFNIJwJvhR4hfPYz
         Lqk31yCa0dD9WyI+qr5lQTC+JLrmw6gmWVpUfQvhF7uBz/OHje1knSPz/XwpuznAQZgF
         OsRBy84Wdx5JjlWzg+cgadka0HQKG2s8jP/88vqay2rn/eyetC3Rszv/MQHiMbgFDwJg
         IgVQKp9vUiKRJwB64bIjwXo1yi2aeLtiGf/JNQhhjOp9jzGyEHvlNkLtcc4hyGnlQiY5
         d5gw==
X-Gm-Message-State: AOAM532XZ0Mdwhd3JnWe6VdNJO7zBV/31lXpCKra/wlyK9RFUeiAWCIw
        ZgshSRrytdTkeFrb+nzBOUA/QQ==
X-Google-Smtp-Source: ABdhPJz2+mOvPRX4zGlgCIgXYYSdslem4rOP3anxwM/w/fm3B9IfKX42PYes3WpJTXBNnQuvN9kI1g==
X-Received: by 2002:a17:90a:6385:: with SMTP id f5mr6370751pjj.91.1614888434755;
        Thu, 04 Mar 2021 12:07:14 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id k64sm241882pga.52.2021.03.04.12.07.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Mar 2021 12:07:13 -0800 (PST)
Date:   Thu, 4 Mar 2021 12:07:12 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Drew Fustini <drew@beagleboard.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Colin Ian King <colin.king@canonical.com>,
        WenZhang <zhangwen@yulong.com>, zuoqilin <zuoqilin@yulong.com>,
        Joe Perches <joe@perches.com>,
        Naoki Hayama <naoki.hayama@lineo.co.jp>,
        Wang Qing <wangqing@vivo.com>,
        Jonathan =?iso-8859-1?Q?Neusch=E4fer?= <j.neuschaefer@gmx.net>,
        dingsenjie <dingsenjie@yulong.com>,
        SeongJae Park <sjpark@amazon.de>,
        Eric Biggers <ebiggers@google.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] scripts/spelling.txt: add "overlfow"
Message-ID: <202103041207.D8B1059@keescook>
References: <20210304072657.64577-1-drew@beagleboard.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210304072657.64577-1-drew@beagleboard.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 03, 2021 at 11:26:58PM -0800, Drew Fustini wrote:
> Add typo "overlfow" for "overflow". This typo was found and fixed in
> net/sctp/tsnmap.c.
> 
> Link: https://lore.kernel.org/netdev/20210304055548.56829-1-drew@beagleboard.org/
> Suggested-by: Kees Cook <keescook@chromium.org>
> Signed-off-by: Drew Fustini <drew@beagleboard.org>

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
