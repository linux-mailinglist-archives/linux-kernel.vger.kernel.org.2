Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 22FB03ABAF2
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jun 2021 19:55:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232767AbhFQR5z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Jun 2021 13:57:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231243AbhFQR5y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jun 2021 13:57:54 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25866C061574
        for <linux-kernel@vger.kernel.org>; Thu, 17 Jun 2021 10:55:46 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id ji1so5193531ejc.4
        for <linux-kernel@vger.kernel.org>; Thu, 17 Jun 2021 10:55:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kHu5Ahvm2uB8SGRZwVpZNQgeW8VrebWqIEGoVFu7Q1M=;
        b=OVLgJXxUYJSrzHC9qdffaG5ci3Y5z5DGNfdrMuVRW54CDY7mQKOU62hMMiZWKVxOiP
         3ZDIdwQdNB90jvwPCxldI3KiSFWXg2vAHlwo7q7zlNwGElN5HHqG5U4iM7b8+j9vlrJo
         xQDLRLj1VhLMxIBx5H6Br38QDQk7wN+PEoD69InlDgIhW53TorL4pd900woA6ENeGQUC
         yNd5A8tBGxa/0BOJzLAzSz2gdZhRVea7CkAGvM38Ydxe7hS3phPBrmDqbxQarHOqR2Fz
         1c9fCcUHm//WZbtr8ZtqUYrXL9xtPJmXOCWaq9EcGATLGFlamz7YOezT1DjSEbriMiWl
         KIVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kHu5Ahvm2uB8SGRZwVpZNQgeW8VrebWqIEGoVFu7Q1M=;
        b=A8wuo2asP/UB9Wr41IQbyzocjP/asDx5gBvPOnzeeQyU3+TPQO6ZHPR6+PHzf0jfub
         RIwd4HLUStfykR9Xqej+lasvH3bKNvLs8MKgOmAg5bnPd9ldEor/7dkNBmKwHGQUeGIW
         zEu0gu969cNqQDMNZ7CiapFktlZBub/VibGIRKE1Mh+7x57Ydop/LRP+FGoWihwQZOlE
         3CY5hfaSATOxzO8YFajXmAegWzOlLJO5Xlido/nMJ6DrhxwTWE7h7y5s+4yzYUN+iB65
         qPrrux38ShdziTjUM/4+ncpW0dLJ2BF7NvZ8XVkg/9ow2DaVXiMPUh/F7wqbMXqy4Ioa
         arxA==
X-Gm-Message-State: AOAM533Hi3B0eYM7EbSjShmDw8euKR8h66q+yll2VtHnUIX9nVyI9f2L
        jnw5C9n2X01emGFKqLcKYROZTiaOZyEdN5rMFCaSjw==
X-Google-Smtp-Source: ABdhPJwE7H3RXK6EO2DKCbwxfygjufL5WjIME92jT5JermGYHiYsNDCKgk/9PyjNHwMW5xOTwNkcsFPFmaUhx8PEESo=
X-Received: by 2002:a17:907:270c:: with SMTP id w12mr6647326ejk.175.1623952544562;
 Thu, 17 Jun 2021 10:55:44 -0700 (PDT)
MIME-Version: 1.0
References: <20210617125023.7288-1-shijie@os.amperecomputing.com> <20210617175211.GE24813@willie-the-truck>
In-Reply-To: <20210617175211.GE24813@willie-the-truck>
From:   Pavel Tatashin <pasha.tatashin@soleen.com>
Date:   Thu, 17 Jun 2021 13:55:08 -0400
Message-ID: <CA+CK2bC5XW_AjnieWZ-ro8iqr0Jb7cz5Ss5549tJTq3Zm4GYiQ@mail.gmail.com>
Subject: Re: [PATCH] arm64: kexec: flush log to console in nmi_panic()
To:     Will Deacon <will@kernel.org>
Cc:     Huang Shijie <shijie@os.amperecomputing.com>,
        Catalin Marinas <catalin.marinas@arm.com>, tabba@google.com,
        Ard Biesheuvel <ardb@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>, patches@amperecomputing.com,
        zwang@amperecomputing.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 17, 2021 at 1:52 PM Will Deacon <will@kernel.org> wrote:
>
> On Thu, Jun 17, 2021 at 12:50:23PM +0000, Huang Shijie wrote:
> > If kdump is configured, nmi_panic() may run to machine_kexec().
> >
> > But in NMI context, the log is put in PER-CPU nmi_print_seq.
> > So we can not see any log on the console since we entered the NMI context,
> > such as the "Bye!" in previous line.
> >
> > This patch fixes this issue by two steps:
> >       1) Uses printk_safe_flush_on_panic() to flush the log from
> >              nmi_print_seq to global printk ring buffer,
> >         2) Then uses console_flush_on_panic() to flush to console.
> >
> > After this patch, we can see the "Bye!" log in the panic console.
>
> Does it matter? I'd be more inclined to remove the print altogether...

I agree, the print could be removed entirely. But, my assumption was
that this patch meant to flush other buffered prints beside this last
"Bye" one.

>
> Will
