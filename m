Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB07E393EC1
	for <lists+linux-kernel@lfdr.de>; Fri, 28 May 2021 10:28:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232310AbhE1I3z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 May 2021 04:29:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229774AbhE1I3w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 May 2021 04:29:52 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 166DAC061574
        for <linux-kernel@vger.kernel.org>; Fri, 28 May 2021 01:28:18 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id e17so4181756lfb.2
        for <linux-kernel@vger.kernel.org>; Fri, 28 May 2021 01:28:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tuKdr3clPQFY4vFcSd6QvBJfUu3c3Jilu+2Bfl+rzoM=;
        b=MhoBQJh+m696S6cQCrg981+kwGFIxIKNRDrZ8mAuAvNcNnF8/XY0ZAFBBmFtL8T1SS
         KdwfGp5/a1WkGI5fiSaq/nM4nLFx5a5FqtCnsDF7sXIQRRTxTrxQPKI5Fw32hyW0V9up
         i4NY3fkh/uD5SCrfufxUE01gCH0N4N7UKviJKqH2TBABMRM4qoAUDApARYPqsQsVIN+Y
         kzh2K3jvMlQx+t6fiJMCeEKkErvz7OrvVcrmjqDvmxG/X3hIWiG5DtvUHFit4zg4+h0P
         +I4FmP6JeF1kmW7cy1cJGhNYfanFQYNCmNIE9VvK8qmLDrbXKGqLtJ2LsaHUmWHacLQu
         1MPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tuKdr3clPQFY4vFcSd6QvBJfUu3c3Jilu+2Bfl+rzoM=;
        b=hN75U5RFCh5FexBuiQM1otynZwO1+OxxgTzZgyzyhN+Kfun0GqNRw4TEtRVmnrlqPr
         QhqrO2kZNvkgAJd20NwR9xNnKykd84DK4TiRjQtKDMJPQu6F19VMJY1LP+97sG2ujEEy
         ip82JMFXLz5XUaIJ32usHEMyiNAtP8V8ycilAAEdwN/oi93mXmKVGDQPhULtDIOR1FMW
         tc0PnFj7s9aUbc4KrQOo/bicthRJc5wdO1gt+Rrv3j3WV1bvPQtInpNH9XEDQrFM1Nyx
         Mr352OD0wuHyzzDb4N+vsCbdSeqRm3ETG8Dw5CH3wMIijqUFZacOuGhGVk8W6+lanF61
         scjQ==
X-Gm-Message-State: AOAM530YbZ/E9LTQH2UQsGSkvjL235nGC1SsGIx2AR89TdPZoXRFGwej
        sCd7mwlSW7Hk3Ikmps/GxAkMCZVgOol+1aa0EIYW7A==
X-Google-Smtp-Source: ABdhPJy8I+Z3LL7pF49eMUMgfEMrgyTz4OYJFg2iSNiTJ1cu24hMiUC9Qfwo0rVc93R+bLY9UXkyg2vh6oyTSeCOzgQ=
X-Received: by 2002:a05:6512:49b:: with SMTP id v27mr5382880lfq.29.1622190496436;
 Fri, 28 May 2021 01:28:16 -0700 (PDT)
MIME-Version: 1.0
References: <20210528040542.2161208-1-masahiroy@kernel.org>
In-Reply-To: <20210528040542.2161208-1-masahiroy@kernel.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 28 May 2021 10:28:05 +0200
Message-ID: <CACRpkdaSZuqziQUScVQGNdA54rnrHEW96LZtPjkcnk7Tbn2-YQ@mail.gmail.com>
Subject: Re: [PATCH] ARM: syscalls: use pattern rules to generate syscall headers
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     patches@arm.linux.org.uk,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 28, 2021 at 6:06 AM Masahiro Yamada <masahiroy@kernel.org> wrote:

> Use pattern rules to unify similar build rules between OABI and EABI.
>
> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>

Looks correct to me.
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
