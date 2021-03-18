Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 79D44340DA5
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Mar 2021 19:59:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232583AbhCRS64 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Mar 2021 14:58:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232770AbhCRS6c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Mar 2021 14:58:32 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DC26C06174A
        for <linux-kernel@vger.kernel.org>; Thu, 18 Mar 2021 11:58:32 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id bf3so8009129edb.6
        for <linux-kernel@vger.kernel.org>; Thu, 18 Mar 2021 11:58:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NZz+9PL2+4ggb2FDfCTE47vu4z52fy7y4q4DXh0GF0c=;
        b=pnqzhgbNgDAVvPY6Jc6U/nlAgp6X+jmTG/bXqH2Yh75gmOsSLS15vc+4huaABZRf7J
         Hw/M5PGHxk1r1zxKURlNFlhe5dcB3D1Vxn5LSew/CBJggb3I4M5dNJy5QfbkmQWQljWT
         5aAkup3znYN+mVorH0pOopAwRjreYI9J54s6uxBLzGtG7UzYQBYj8H6YyTRW0f4xjmKB
         1sWY8FdH7JmDf9DBVJh6nyJvr6jiCTib49CrHf2h/fNmDm346S5+n3Wu2GK5TdQManQ5
         KIbX2FFxQ0eD2MhyqGSod8vyIntxR6rDlqweSkGu1rt9X0+hQY5jdz062d/fqUevQd47
         Dseg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NZz+9PL2+4ggb2FDfCTE47vu4z52fy7y4q4DXh0GF0c=;
        b=uVWfUBzC7RaxeykKfTF0VN6Smm2RmxrkUgvBk4wG2VR7LC7sfsV2PFA6lk84Vz7BXj
         FQ6Ou07B+hytU8HigK0SZ7P6bsMq+jkeUez5BDnIhVR7nXDx612k5ofj7T0Caxc/SeGt
         /cL0+XPSdjDhWp/vNokBADr5clVAr6NPjQ5Ddg6OpbOVyKsZ3VdY0gi4AlsYPa/qBNlI
         FF+imrjYQ6F8js3jGHkBAkqWiK34auaaL3xLNtQKj8v59mYh3eUn2Yd4Ov5Lbt0Vduwu
         Rtqf3SlH4h/bMboeoolOZh7l9PUGjj2NF5SRC7AtQ2WBFs0TI4UDKgZjVe2aRaOAq+zn
         C0qA==
X-Gm-Message-State: AOAM531Sget8n5zWcD1EyZMIDM/0FTtF0mGKaJOtL1gQprXRqIuzaAzC
        pLDGStY/GaxloOUZvG+x0e14dLbgdgsGCxGC9nvL
X-Google-Smtp-Source: ABdhPJx3u588s0L1/ngd8c9D+YMUhkS+1ADz8/IcxI9xUGo4pKqvCcsHdzghoieTnRBly5BAiL+hBueuF06zJMKg/Yk=
X-Received: by 2002:aa7:c7c5:: with SMTP id o5mr5423501eds.31.1616093909537;
 Thu, 18 Mar 2021 11:58:29 -0700 (PDT)
MIME-Version: 1.0
References: <0a26adc249e782ad9de04e047af7c2f65c2bc7c7.1615946851.git.rgb@redhat.com>
In-Reply-To: <0a26adc249e782ad9de04e047af7c2f65c2bc7c7.1615946851.git.rgb@redhat.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Thu, 18 Mar 2021 14:58:18 -0400
Message-ID: <CAHC9VhS0FNJo-K+XEh+tOrOd5g_QpbSEFt2a8_6Hw7hufMgLGg@mail.gmail.com>
Subject: Re: [PATCH v2] MAINTAINERS: update audit files
To:     Richard Guy Briggs <rgb@redhat.com>
Cc:     Linux-Audit Mailing List <linux-audit@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Eric Paris <eparis@parisplace.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 17, 2021 at 9:49 PM Richard Guy Briggs <rgb@redhat.com> wrote:
>
> Add files maintaned by the audit subsystem.
>
> Files from arch/*/*/*audit*.[ch] and arch/x86/include/asm/audit.h were not
> added due to concern of the list not holding up over time.  There exist
> already exceptions that caused the need for this specificity.
>
> Signed-off-by: Richard Guy Briggs <rgb@redhat.com>
> ---
>  MAINTAINERS | 2 ++
>  1 file changed, 2 insertions(+)

Merged into audit/next, thanks.

-- 
paul moore
www.paul-moore.com
