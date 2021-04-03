Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 62454353350
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Apr 2021 11:43:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236037AbhDCJm4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 3 Apr 2021 05:42:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232178AbhDCJmy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Apr 2021 05:42:54 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA3A6C0613E6
        for <linux-kernel@vger.kernel.org>; Sat,  3 Apr 2021 02:42:51 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id 12so3471747wmf.5
        for <linux-kernel@vger.kernel.org>; Sat, 03 Apr 2021 02:42:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=manp5WyYRzbgV7XgwB1/gokIu0V9Lu5KMjavj/C4ckc=;
        b=hJWUrzJhx6M+X7GDYaopIwPDuDKw0dmRqDXfY2338Repp9jCvo96MoaxsCkVoiwOK7
         3sMCpFxjNSHvRCfXZ2roJnUymm3q2KflGxgswnDs5wHMSbNlFEO9AxFmiLc76olzLVb6
         dDCDEQ8ejlbTO57JHH4UNKogGDJqZDBWAnAuUXjUNUJhv1SbvSjuAIYc6PpPJqAMbsUm
         E5m6o3QYBgCFTf0G4PoauRqss7044jx1sUp0VqWQzD0EgU5uenckgTdEG2xsNMoglKfw
         GsiY1fD++IFoDmJc6AC+VaYFvitounvhAVSaD1h19qqDIn7hOzSb4i+rwpo7oziqG0jg
         wSDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=manp5WyYRzbgV7XgwB1/gokIu0V9Lu5KMjavj/C4ckc=;
        b=VfbFVq5bkWmw+Ld+uwK/lAA7xNr4qmTr0oqELKyOf2wOFbrrEfrGzD3ttXPsZHWEmf
         c9lKbLuwPCQk1iWFtWI1mnOGi7xYohCUghsEhgycaoZqnwGuKvl1EQZck8PfsTQ3BCxc
         nK62w8HbVxaOiEmzzIOmjtwuW9GXidh7d6iBi6kYdBB8D5zfXxIF7mPZ3q4C+uBSeF4s
         zvgJLMkrVFD2uF2GWpeQ+G5lO9sAOuGda1jLmyx1koBHbXTkfFPA2L9wvi3AfzZdWCLv
         K7OF0vgGjN4SA15KyxSJAKmt3nfScqbuXYEd45B17uJ/uHZ2PFfGmoNKYNdOzr4d3Hcj
         o76Q==
X-Gm-Message-State: AOAM530rElEwW263IPSpH1K5npptD4zJuZPouxu4I+GAuYisZYHWpCLv
        g/mIGAuw7dbXgnZ4TAlyMMw=
X-Google-Smtp-Source: ABdhPJynMj+T3YGzHJlD68A+g2yJx6TTX69kgc56uCkOrvrPBj/ui/93zw2CGdvgD3+FSrUhLnBFsA==
X-Received: by 2002:a05:600c:259:: with SMTP id 25mr16959940wmj.5.1617442970643;
        Sat, 03 Apr 2021 02:42:50 -0700 (PDT)
Received: from agape.jhs ([5.171.72.64])
        by smtp.gmail.com with ESMTPSA id m3sm18083541wme.40.2021.04.03.02.42.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 03 Apr 2021 02:42:50 -0700 (PDT)
Date:   Sat, 3 Apr 2021 11:42:47 +0200
From:   Fabio Aiuto <fabioaiuto83@gmail.com>
To:     dan.carpenter@oracle.com
Cc:     gregkh@linuxfoundation.org, joe@perches.com,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 16/30] staging: rtl8723bs: tidy up some error handling
 in core/rtw_mlme.c
Message-ID: <20210403094247.GC1563@agape.jhs>
References: <cover.1617440833.git.fabioaiuto83@gmail.com>
 <d8ad88bef77430107f8593091770b6a514b6f0e2.1617440834.git.fabioaiuto83@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d8ad88bef77430107f8593091770b6a514b6f0e2.1617440834.git.fabioaiuto83@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 03, 2021 at 11:13:38AM +0200, Fabio Aiuto wrote:
> the RT_TRACE() output is not useful so we want to delete it. In this case
> there is no cleanup for rtw_cleanbss_cmd() required or even possible. I've
> deleted the RT_TRACE() output and added a goto unlock to show
> that we can't continue if rtw_createbss_cmd() fails.
> 
> Suggested-by: David Carpenter <dan.carpenter@oracle.org>
> Signed-off-by: Fabio Aiuto <fabioaiuto83@gmail.com>
> ---
>  drivers/staging/rtl8723bs/core/rtw_mlme.c | 17 +++++++++++------
>  1 file changed, 11 insertions(+), 6 deletions(-)

Hi Dan,

I put a Suggested-by tag on one patch in v3 patchset. But reading the docs
on submitting patches I relaized later that maybe it requires your permission before.

It' written about Reviewed-by but not about Suggested-by, should I have asked you before, should I?

I'm sorry if I should have.

thank you,

fabio
