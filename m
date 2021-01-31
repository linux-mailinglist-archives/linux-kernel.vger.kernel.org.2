Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 91F22309E5D
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Jan 2021 20:47:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231491AbhAaTrq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 31 Jan 2021 14:47:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229834AbhAaTmV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 Jan 2021 14:42:21 -0500
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BF8BC061788
        for <linux-kernel@vger.kernel.org>; Sun, 31 Jan 2021 11:40:58 -0800 (PST)
Received: by mail-lf1-x134.google.com with SMTP id f1so19886356lfu.3
        for <linux-kernel@vger.kernel.org>; Sun, 31 Jan 2021 11:40:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XO71KmqQlZo86kY5HHYvPSLe2Q3yS6mAOzDiCRkKBow=;
        b=hHeOV2BeJBSNjf0ef3bPV3BxBnqFrF7ALM6nqqW85IeCfWRyMHNeknDMNUpwPF8iox
         AlJV5HbzkIApMzhJ42OhWl46pEcFer6/vUIO9SZ05ixVY13Ep37rk0PzkdIGhgdSaWKb
         jrosVt24yfnH+fcAW+piAT9bVmLEf6X9cqCtg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XO71KmqQlZo86kY5HHYvPSLe2Q3yS6mAOzDiCRkKBow=;
        b=rPBsN/cL6osf9tzN8NpI+vr52Mi9p8ijvFGqyHjB0MXQtux25sLCU+tspw8kZcIKvw
         qZhM7SuVdPrs4sad9s5VlvmHunzXucThAdZngj8BcMUPhwRnEZB1N3qHA04xeOsWWgG8
         iaoch2HsjarSKrkLlxCHthl0U1U+gVnVwbysyrsO+XlOAoo4KhaUIffpeFyd1Z77tmrx
         kP3PuH9X4j2KmDNBwGqnfHEKSSVF9uoseFNqkeQOXFpOEmVp094jU8u891O87b0iDodT
         YxxdWq1qU4BrmT0NyFoKUzfg4tEuk7a3iReMoO741fB3UgWtbAZkg7ugahsLkcrX3aC4
         +JCw==
X-Gm-Message-State: AOAM532sSAYkhNYNAEKJB+P6OBwXyT9azTDs/zZGwypg5SJZomC9NQHn
        FCiI0gEe/kcW63Aib+FXxermGmB4m3VB1w==
X-Google-Smtp-Source: ABdhPJxhsITohqeZqp2ZGJBBoMs1OId03jY2NSod5gWkP19rVYy1nn6V848FeaMKJsV1kgfreHxW/w==
X-Received: by 2002:a05:6512:3094:: with SMTP id z20mr7155789lfd.441.1612122057111;
        Sun, 31 Jan 2021 11:40:57 -0800 (PST)
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com. [209.85.208.179])
        by smtp.gmail.com with ESMTPSA id y15sm1149455ljn.97.2021.01.31.11.40.56
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 31 Jan 2021 11:40:56 -0800 (PST)
Received: by mail-lj1-f179.google.com with SMTP id b20so9092813ljo.1
        for <linux-kernel@vger.kernel.org>; Sun, 31 Jan 2021 11:40:56 -0800 (PST)
X-Received: by 2002:a2e:8750:: with SMTP id q16mr8261768ljj.465.1612122055956;
 Sun, 31 Jan 2021 11:40:55 -0800 (PST)
MIME-Version: 1.0
References: <161208961675.22671.12893376547737348246.tglx@nanos>
In-Reply-To: <161208961675.22671.12893376547737348246.tglx@nanos>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 31 Jan 2021 11:40:40 -0800
X-Gmail-Original-Message-ID: <CAHk-=wieF9z=qzQo1ZQtkji--0KSCKVzAUTCitkbLAfXk-AAxQ@mail.gmail.com>
Message-ID: <CAHk-=wieF9z=qzQo1ZQtkji--0KSCKVzAUTCitkbLAfXk-AAxQ@mail.gmail.com>
Subject: Re: [GIT pull] core/urgent for v5.11-rc6
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "the arch/x86 maintainers" <x86@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 31, 2021 at 2:40 AM Thomas Gleixner <tglx@linutronix.de> wrote:
>
> A single fix for the single step reporting regression caused by getting the
> condition wrong when moving SYSCALL_EMU away from TIF flags.

Manual pr-tracker-bot says thanks,

          Linus
