Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B47D337A8C
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Mar 2021 18:13:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229825AbhCKRNX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Mar 2021 12:13:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229809AbhCKRMy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Mar 2021 12:12:54 -0500
Received: from mail-qt1-x82c.google.com (mail-qt1-x82c.google.com [IPv6:2607:f8b0:4864:20::82c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CD87C061574
        for <linux-kernel@vger.kernel.org>; Thu, 11 Mar 2021 09:12:54 -0800 (PST)
Received: by mail-qt1-x82c.google.com with SMTP id m7so1682563qtq.11
        for <linux-kernel@vger.kernel.org>; Thu, 11 Mar 2021 09:12:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6rCxc3cHCoDd5YPWN4pdDt+yoQYGWR6uIdzRq1ahqGE=;
        b=HV5bjVcmi15S35Lbj514kbB9hfz75yA1KuMuBsQlKgkmq5CF7pInZmlb4c6KRY5aAD
         ovgWVL9N9d7rpfw9jcITyVR9dzAxwWcMA7FSYY/5FO24wnNBze2YEk/alhaeMpcuzRDq
         64L7vqz+gsF+1aguapVzhRc3XOgJT56QIQ72E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6rCxc3cHCoDd5YPWN4pdDt+yoQYGWR6uIdzRq1ahqGE=;
        b=oFORVBFRdL8GiJdHu7mdTFE6ACIoWZeA9k41eetpmc1C5dqdGH+WeiqRKJ+7CUt+UR
         N/FZE6zvcT19MekIw6zub+j6Pk0o9Kk2rQ2KBOuSyG62oJOWe7nu+pM2ZsQJ57Jy4AJj
         4o903gLGgSC3V8KXkmcT1/LUhFNToWjXN5Iw+UgW+b9Y8tn1gAkWjLkADiJ1onRYt+6i
         +IJpOdg/t+8T77OFjHh3/M2+xBpM5uOFiVwa+hMzYqsdedvSp2BiWfMPu6mVWuC03Dz4
         63sNBol1u7hFszffPQx4RPIW/S8x5ZhZ6M5LYAGo00BVGN0walOGfnC7Fe0xdxn8XgQu
         ynsA==
X-Gm-Message-State: AOAM532/GzVSDOPDXOaPxTFBlJ/T2d37YfaDMVmaQTqnmEjPvi5yHa1z
        KkKEzkgjCKgEXiFGwnHaePs4vKPBJQyGsw==
X-Google-Smtp-Source: ABdhPJwomb6/to/ExNEq9jmE9rHMsRfP4QLixArIzUSArKw5TgyMQTTn4FvvtSP0uLzcjPoXfMTb6g==
X-Received: by 2002:ac8:5912:: with SMTP id 18mr8529441qty.18.1615482773145;
        Thu, 11 Mar 2021 09:12:53 -0800 (PST)
Received: from mail-yb1-f181.google.com (mail-yb1-f181.google.com. [209.85.219.181])
        by smtp.gmail.com with ESMTPSA id 73sm2270147qkk.131.2021.03.11.09.12.52
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 Mar 2021 09:12:52 -0800 (PST)
Received: by mail-yb1-f181.google.com with SMTP id l8so22416560ybe.12
        for <linux-kernel@vger.kernel.org>; Thu, 11 Mar 2021 09:12:52 -0800 (PST)
X-Received: by 2002:a25:cf88:: with SMTP id f130mr12858170ybg.476.1615482772142;
 Thu, 11 Mar 2021 09:12:52 -0800 (PST)
MIME-Version: 1.0
References: <20210311095316.6480-1-colin.king@canonical.com>
In-Reply-To: <20210311095316.6480-1-colin.king@canonical.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Thu, 11 Mar 2021 09:12:40 -0800
X-Gmail-Original-Message-ID: <CAD=FV=V5+GvMpD1FdX0-TJ=BFyyvST+oLR08pO7jL+h38G8PCw@mail.gmail.com>
Message-ID: <CAD=FV=V5+GvMpD1FdX0-TJ=BFyyvST+oLR08pO7jL+h38G8PCw@mail.gmail.com>
Subject: Re: [PATCH][next] nvmem: core: Fix unintentional sign extension issue
To:     Colin King <colin.king@canonical.com>
Cc:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        LKML <linux-kernel@vger.kernel.org>,
        kernel-janitors@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, Mar 11, 2021 at 1:53 AM Colin King <colin.king@canonical.com> wrote:
>
> From: Colin Ian King <colin.king@canonical.com>
>
> The shifting of the u8 integer buf[3] by 24 bits to the left will
> be promoted to a 32 bit signed int and then sign-extended to a
> u64. In the event that the top bit of buf[3] is set then all
> then all the upper 32 bits of the u64 end up as also being set
> because of the sign-extension. Fix this by casting buf[i] to
> a u64 before the shift.
>
> Addresses-Coverity: ("Unintended sign extension")
> Fixes: 097eb1136ebb ("nvmem: core: Add functions to make number reading easy")
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> ---
>  drivers/nvmem/core.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Thanks! I had only tested the "u64" version to read smaller data and
store it in a u64. From my understanding of C rules, without your
patch it would have been even worse than just a sign extension though,
right? Shifting "buf[i]" by more than 32 bits would just not have
worked right.

In any case:

Reviewed-by: Douglas Anderson <dianders@chromium.org>
