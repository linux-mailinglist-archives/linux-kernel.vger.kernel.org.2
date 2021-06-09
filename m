Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 26DD43A09EC
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jun 2021 04:20:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234113AbhFICWH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Jun 2021 22:22:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233698AbhFICWG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jun 2021 22:22:06 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F4C1C061574
        for <linux-kernel@vger.kernel.org>; Tue,  8 Jun 2021 19:20:03 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id i13so26871360edb.9
        for <linux-kernel@vger.kernel.org>; Tue, 08 Jun 2021 19:20:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0Y1FSEobOe8xalX9xjuNlZS8PBOfMBLSbk/7QTP+PmY=;
        b=iz2geq+gCBJR3+ViNyaPYvhILn4edEjWx7CTSYlzvWUeIO1YMal+71yIGRGidjTN7q
         GJB1qOWVvO6oZyI40Hmq5EoKqtmvMMfjF2YNoSHfT24XOn+IbR7A1G70dp6/+kIXUfBe
         nxvSi+o/peNnCCOSo2hgo6s9u6n6/b1FJJwM+ba16m5heHFW/1S7xcjFTHo6brGsP3y/
         lni6vJKXCa6YLNaQcAyaxBkpQr5ZTGjRmI0p/A4VrjW6FRomgaOJvk1tv2JT27HwcW02
         S/RHKpAYZUQFhpauBKN1DfbJSEvp3RWOtX229+cRzPlES72QBq2FVSnCled77EW8C8rX
         hlKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0Y1FSEobOe8xalX9xjuNlZS8PBOfMBLSbk/7QTP+PmY=;
        b=FVNQaOOW9dYdUJcpGW4B7PfJfyfXnb+u7xsmzZGHqaBDwPD8GBBisBbQp9TMw8LqcC
         auypH7qFwqXqUXeZJxJx1lPJ8IT845GTZc77bHGPlpXK6tjbRfAjuCp8+bYYYcbA+bl8
         C8vK8Q61cpnQbzdPCIyMSDBT/BOGMBqp6W+RAe6xVfe/SV1WSpMgP5DgCg9bbrLiCrv+
         kVH0+iZ4MF82q4Sbo86EeOMyv5VH1hgzcAf0DpsIaJRY5E07syDtunudSNudw+ehJ9zk
         9OlR3PjsN0Toic50y3XHxqWvAmAsFqI9BPMw6JA4ayGb9vZOxo+QRSHLPsz3NnSWtOkq
         Bzhw==
X-Gm-Message-State: AOAM531QJYI+vX9gtuMB53OzrDvixy9BddwmSSKFdd5eBLYJVMyGdCWh
        j2//7pkOm7SbdrhlDqESmcEVnil41ZCQjzAdPARB
X-Google-Smtp-Source: ABdhPJwvgyH7PZtXzJ1DdgVwdgA0sHZzXneK81NkEzOR+ec3Iiw+5MfM1yjqs6r5lfCPLmJTFqYK2Ouz89eiw9lKPJU=
X-Received: by 2002:a05:6402:348f:: with SMTP id v15mr16558137edc.135.1623205201671;
 Tue, 08 Jun 2021 19:20:01 -0700 (PDT)
MIME-Version: 1.0
References: <20210608031150.2821712-1-libaokun1@huawei.com>
In-Reply-To: <20210608031150.2821712-1-libaokun1@huawei.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Tue, 8 Jun 2021 22:19:50 -0400
Message-ID: <CAHC9VhRF-tvaye00Ck-i6OqjmxCUnn8HfdwMTYAm316i=kGd3A@mail.gmail.com>
Subject: Re: [PATCH -next] audit: Use list_move instead of list_del/list_add
To:     Baokun Li <libaokun1@huawei.com>
Cc:     linux-kernel@vger.kernel.org, Eric Paris <eparis@redhat.com>,
        weiyongjun1@huawei.com, yuehaibing@huawei.com,
        yangjihong1@huawei.com, yukuai3@huawei.com, linux-audit@redhat.com,
        kernel-janitors@vger.kernel.org, Hulk Robot <hulkci@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 7, 2021 at 11:03 PM Baokun Li <libaokun1@huawei.com> wrote:
>
> Using list_move() instead of list_del() + list_add().
>
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: Baokun Li <libaokun1@huawei.com>
> ---
>  kernel/audit_tree.c | 12 ++++--------
>  1 file changed, 4 insertions(+), 8 deletions(-)

Merged into audit/next, thank you.

-- 
paul moore
www.paul-moore.com
