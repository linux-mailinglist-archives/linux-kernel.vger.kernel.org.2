Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 54674381E61
	for <lists+linux-kernel@lfdr.de>; Sun, 16 May 2021 12:59:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230443AbhEPLAz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 May 2021 07:00:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229586AbhEPLAw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 May 2021 07:00:52 -0400
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EECEC061573
        for <linux-kernel@vger.kernel.org>; Sun, 16 May 2021 03:59:37 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id x188so3049901pfd.7
        for <linux-kernel@vger.kernel.org>; Sun, 16 May 2021 03:59:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=4GxSFPpWStKHjj7EXT1jNvKcDZSOJF70aqfxoCB02kY=;
        b=Cpy1ZhzNx1aXXw3LdrNWLhQV74sEFSo4yuPbZKep5yiUfJ7jFrzsL2A7fwWfhE6lWS
         /KSnKu0QTHLxD3kyOFX9a2EalkBpWDdhslf7K6x7qt3tcIXgOqFK4uChKM+J4xhZrLnS
         bYcuqmCK/DTMUUwmoOFvd80zHMnPJlCBJp5jw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=4GxSFPpWStKHjj7EXT1jNvKcDZSOJF70aqfxoCB02kY=;
        b=A4pft2LTIzEEa4SpBYrjJ+wcoP6uBEkqteJ9KcVfmIcO0E8WGB1tR4PIg5nHZNKFHN
         4XE1Rgk7i8TyJcDEV0KlWJziwMeJXgN9o0yaFGqstRXWKlwt4A0ZZGcm+2R6GvYCr8FQ
         anKl1SgOiTCUzdiMk6aIyZDV4f2DIa28iP7TSRp4Inv0eygXRR9pzeQaf79tQ8CiANlW
         5Yk7k4iJNeg31QZ7Q9VEXhYF4z8ka8ofUQOars8G9LyRXX82u+bWmj2UnYc2NKjvfosd
         IYoKUo4zxVYfrZny79ey202QOV6X3cgs8AhTodQJte14bfcb+B/bsdnc6T46FFnX466c
         AZ3A==
X-Gm-Message-State: AOAM531OqUL3y1YsbAFK9TRkeGWxP1YUXST2Y+W42Jl56NynqzxwQqC8
        Lk9g7mm5TWRgPvFJOX3ko5c0LA==
X-Google-Smtp-Source: ABdhPJzQJp5Q3my2xZ7H1eLd22WRM8iYd4u+a0Zh7oLI6yZH3geaz4ojkhR6TlZ63R3BXwn99le9yA==
X-Received: by 2002:aa7:88c9:0:b029:2ab:aea7:e761 with SMTP id k9-20020aa788c90000b02902abaea7e761mr45338082pff.71.1621162776789;
        Sun, 16 May 2021 03:59:36 -0700 (PDT)
Received: from google.com ([2409:10:2e40:5100:4596:acad:c782:2f52])
        by smtp.gmail.com with ESMTPSA id z5sm5077648pfa.172.2021.05.16.03.59.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 May 2021 03:59:36 -0700 (PDT)
Date:   Sun, 16 May 2021 19:59:31 +0900
From:   Sergey Senozhatsky <senozhatsky@chromium.org>
To:     Takashi Iwai <tiwai@suse.de>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Leon Romanovsky <leon@kernel.org>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
Subject: Re: ALSA: intel8x0: div by zero in snd_intel8x0_update()
Message-ID: <YKD7E/VEwE7Dmx3s@google.com>
References: <YJ4yBmIV6RJCo42U@google.com>
 <s5hk0o18tio.wl-tiwai@suse.de>
 <YJ5cHdv6MVmAKD3b@google.com>
 <YKDYQfDf7GiMfGCN@google.com>
 <YKDYbaprE3K2QpCe@google.com>
 <s5hbl9b6mah.wl-tiwai@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <s5hbl9b6mah.wl-tiwai@suse.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (21/05/16 11:49), Takashi Iwai wrote:
> Subject: [PATCH] ALSA: intel8x0: Don't update period unless prepared
> 
> The interrupt handler of intel8x0 calls snd_intel8x0_update() whenever
> the hardware sets the corresponding status bit for each stream.  This
> works fine for most cases as long as the hardware behaves properly.
> But when the hardware gives a wrong bit set, this leads to a NULL
> dereference Oops, and reportedly, this seems what happened on a VM.
> 
> For fixing the crash, this patch adds a internal flag indicating that
> the stream is ready to be updated, and check it (as well as the flag
> being in suspended) to ignore such spurious update.
> 
> Cc: <stable@vger.kernel.org>
> Reported-by: Sergey Senozhatsky <senozhatsky@chromium.org>
> Signed-off-by: Takashi Iwai <tiwai@suse.de>

I kicked the tests. Will let you know.
