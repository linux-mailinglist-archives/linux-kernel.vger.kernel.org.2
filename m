Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7DC1A372A3D
	for <lists+linux-kernel@lfdr.de>; Tue,  4 May 2021 14:40:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230362AbhEDMlo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 May 2021 08:41:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230187AbhEDMlm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 May 2021 08:41:42 -0400
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 068ABC061574;
        Tue,  4 May 2021 05:40:48 -0700 (PDT)
Received: by mail-pg1-x52d.google.com with SMTP id y32so6736980pga.11;
        Tue, 04 May 2021 05:40:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=roKO29UVA0Lf0cubkW9RrYVCEIl05nvoubEygbvLBJI=;
        b=Xjl0gjoQi8TzHarIZiOsP1a38IMDwFftTo0xYPGSp3lYiabxv572jd9Qw4BP2G5dkM
         AnsQpv2aDf/PqhpTbaGQG3XnqEhHo/Ul6+YPWKUq9VbUR+Ga1sAwWlGqerFI3E3fT7Cv
         I6CUW7HAIe+crFEJx/1zNIago2GqfwlmrrPfQBSHkphN0SEunPCKtoHcFLwKSmScl2lE
         DuyPDF/bpfZ2Z3seWbAnzpXISQzi3ey/G0dE8LD5TBAqxtZm+f2xaxp1LP7MiajMstim
         ItGTFB/OXfQN5sJFbAoajYQQvLd40g4QlONlq0FRnpy2NwrLvXNg+krQW1W/RtysRb5f
         3MRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=roKO29UVA0Lf0cubkW9RrYVCEIl05nvoubEygbvLBJI=;
        b=Z4StLv9RKEqjL5jD7/+0V2qjYUAsLoVOgfttwT6cBSEfZIdEU9Lo/S1F1julMT9R7s
         R4ye9BVW+m7wd92DmkU79JunpC9YpiCTeKEJUzr1TFyKze6pT2zNUIAByVwfDSgYTkrD
         SYyGr8kCoXjOkPa5QhhVmIL8ggbM9XajOCLCNYzTlDKwuEzUT+jtLqX4ajVfYbjRGH10
         6XYrEzSlXC+jGSEbb+aHnJ3B9La+glB3jdsTFkOUOPLqde/q0LlEL7hYeO9RBY5zT3uw
         +NRjch8F7jjto2mdjmoxw7prD03MX8lmLDLj23sSJR1zvinUwukMwscuihin84nXi7fq
         gqmw==
X-Gm-Message-State: AOAM532yiGE5fvzcO/T29M5QdUQSOatt2IBBgEBZR1POWxM3Cyv6dQvm
        g150WS3vLUyh2G93vzLUa3m0kTxNJS3iir6Yxbw=
X-Google-Smtp-Source: ABdhPJzPy7lVs0YfbAiMESPOX4xM5ymonACvKJmy8w18poKQ4d2IMuEF79PoncLf22hufUeP6np7EyQxYJQ+aurj/bU=
X-Received: by 2002:a65:5a4d:: with SMTP id z13mr23132896pgs.4.1620132047585;
 Tue, 04 May 2021 05:40:47 -0700 (PDT)
MIME-Version: 1.0
References: <20210504123139.45101-1-wsa+renesas@sang-engineering.com>
In-Reply-To: <20210504123139.45101-1-wsa+renesas@sang-engineering.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Tue, 4 May 2021 15:40:31 +0300
Message-ID: <CAHp75VdqEa+mRDzwUVix7bY=2R=O0WOwXuLjv=mE4MGGOobYBw@mail.gmail.com>
Subject: Re: [PATCH] platform/x86: samsung-laptop: set debugfs blobs to read only
To:     Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Corentin Chary <corentin.chary@gmail.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <mgross@linux.intel.com>,
        Platform Driver <platform-driver-x86@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 4, 2021 at 3:32 PM Wolfram Sang
<wsa+renesas@sang-engineering.com> wrote:
>
> Those blobs can only be read. So, don't confuse users with 'writable'
> flags.

Wouldn't it make sense at the same time to convert ugly namings to
octal permissions?

-- 
With Best Regards,
Andy Shevchenko
