Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 66C873FAED9
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Aug 2021 00:12:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236057AbhH2WM3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 Aug 2021 18:12:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235659AbhH2WM1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Aug 2021 18:12:27 -0400
Received: from mail-il1-x12a.google.com (mail-il1-x12a.google.com [IPv6:2607:f8b0:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15DD4C061575
        for <linux-kernel@vger.kernel.org>; Sun, 29 Aug 2021 15:11:35 -0700 (PDT)
Received: by mail-il1-x12a.google.com with SMTP id i13so13734553ilm.4
        for <linux-kernel@vger.kernel.org>; Sun, 29 Aug 2021 15:11:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=gtoYl7kiNjX3TbLNo3eXXB5Snple9cEEruGWOWNoSu0=;
        b=U98asr0mRpi1ANWcBZWBGLpmqWSU6HUFP431VThGIIx2Dhe0uJjIKFODAZaT7sRfEV
         Vw+3XL3mwkCIC1vy6vesHRAFGI4ourUW3faDpgr3azgkBkpoyfVgD/iWDhORFwkURSJz
         w5kX9CpqckkymE11CPjeMo55wFEzHfapGeleJZbP7Vi9CTLTwwfuvk+X8ED5fNTuFgAa
         B2ggxSsNRilaOuQze1MqTLthM2FlWd8HfxutU2gJtir1C1hm8bBdbubnssTdNPlbeDCE
         BY24Gueqzm98+gLXW9wvPyMy84NB2+AttperenmX8fQsrP9QDWmSLcG6UsLHx8Me7ASx
         xBRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=gtoYl7kiNjX3TbLNo3eXXB5Snple9cEEruGWOWNoSu0=;
        b=D9b/8wOF+DIP9FSOFfbFUlndpSR/61DWJakPS7GELJdklzG+DvkVEfJJDH1fz3i/mu
         QSmczoG7Ea9ns6IqE6Y6RqrJsCKplwolMvZQ4FzETS21hIIl+0UdBjlDvSyDYUofgVuN
         avNuCy0uIqyz9SElZIz6k2L/Rvh35PQrPtqBX/BQG+oUzIDsslocoTFYNCMd8JUM1W4C
         drHhct//kjpsQM0hcVJ81xrQ97YKMlasML4ryJ/KTs7a9e9+Mv+eDF2+MgO4EB24mkjd
         CtlXktOVqyuWv/YJketkzUhjSlUi80JwycnXrXRzRY3IvwV05UPTDVkaBRVccMkNlann
         E7bA==
X-Gm-Message-State: AOAM533PnEO7841wHTFxiueDa5U375pCXaxZWvbMl8VmsS/JGcKV0E+q
        oKOYZBlFDExXmjyOo0J3cRXdA18va4a1gw==
X-Google-Smtp-Source: ABdhPJwQ1ZgoVSLy8sGEWoc30jIrKltpYXFP7WCPG03ooDuF0J5ydYAo6XUDkzAX1OVakNG8aR7xPg==
X-Received: by 2002:a05:6e02:1888:: with SMTP id o8mr14221155ilu.124.1630275094416;
        Sun, 29 Aug 2021 15:11:34 -0700 (PDT)
Received: from [192.168.1.116] ([66.219.217.159])
        by smtp.gmail.com with ESMTPSA id k5sm7144836iob.45.2021.08.29.15.11.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 29 Aug 2021 15:11:33 -0700 (PDT)
Subject: Re: linux-next: Signed-off-by missing for commits in the block tree
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
References: <20210830075224.0f234b14@canb.auug.org.au>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <a9af10c7-a597-f323-638f-3ee28492786c@kernel.dk>
Date:   Sun, 29 Aug 2021 16:11:32 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210830075224.0f234b14@canb.auug.org.au>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/29/21 3:52 PM, Stephen Rothwell wrote:
> Hi all,
> 
> Commits
> 
>   2f7eff262585 ("io_uring: allow updating linked timeouts")
>   132bf9af1d0f ("io_uring: keep ltimeouts in a list")
> 
> are missing a Signed-off-by from their committer.

Oops, will fix.

-- 
Jens Axboe

