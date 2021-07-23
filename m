Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CBFD53D33CE
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jul 2021 06:38:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233716AbhGWD6L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jul 2021 23:58:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231760AbhGWD6J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jul 2021 23:58:09 -0400
Received: from mail-il1-x12f.google.com (mail-il1-x12f.google.com [IPv6:2607:f8b0:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D622EC061575
        for <linux-kernel@vger.kernel.org>; Thu, 22 Jul 2021 21:38:42 -0700 (PDT)
Received: by mail-il1-x12f.google.com with SMTP id a14so477906ila.1
        for <linux-kernel@vger.kernel.org>; Thu, 22 Jul 2021 21:38:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/qj6oCF0Bps6laCKnB2SnDxbkiRn81ATixkUpo80E10=;
        b=tTj7788fq7UyumVl+0XhQdDXTaMDEbeKbtVh/w/cutbEiKDoVaLSnLq3z7sBPoV4UB
         t5AAod9e9SIzKwa7A0xbZlPMXlZmD6OjfmZpV9EYj6zWMuw89zY4T1S/uNauPgIRkTkB
         JprwM84orX5EsY9ziXQ9fUCoQAXXMbAoas000=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/qj6oCF0Bps6laCKnB2SnDxbkiRn81ATixkUpo80E10=;
        b=ERGXfFdhgkHGuYvRaUWIRgEFrT3fnna+p2JmRD/ktqubwf3M6V7FqrXNal8bUpHY/H
         ZxI9Jq9IR4JDjWebrQ68HoR5NPwOUlZrmLF/nAO1xKcc3Mw2F+SLxle2gt13S9C0bwje
         epzc5KyGd6+gvEWBUmRQCB9uDrPfyJWzfFbF0uvqo0Mxt/I0StPCL7gaHtHTQz5KWaVc
         kyUaFzEnH5WaJm5DaqVc/xnFLNEgIvwZ4q4TGuc32VjhJHcZqwfSYVbTVpducHYTlAMP
         CHbNxQm8LJ45/Fwyh1hCIplBrYbRaIQ0mH7/FbhkJbtB0tJ8hPgJp7MLshueC1sFSBJZ
         oMsQ==
X-Gm-Message-State: AOAM5336YFrUBW6TVQ7wDyrK74tbT0Cy3vCixE4KuqiFhZ/+LiE+sylO
        zqaSGkOL4whcMVgHjEbBTcF+p2scEm5w/akHHL/i4Q==
X-Google-Smtp-Source: ABdhPJyeZytLsYaaTOa1oaXp434ValU+WY5NmjR5hrtXliHxapTaTmIPjUFN+Ht8pS6Y+CO9UVjZINiVoikkXDX/fWI=
X-Received: by 2002:a92:b74d:: with SMTP id c13mr2278206ilm.176.1627015121239;
 Thu, 22 Jul 2021 21:38:41 -0700 (PDT)
MIME-Version: 1.0
References: <20210721190250.26095-1-fmdefrancesco@gmail.com>
In-Reply-To: <20210721190250.26095-1-fmdefrancesco@gmail.com>
From:   Joel Fernandes <joel@joelfernandes.org>
Date:   Fri, 23 Jul 2021 00:38:30 -0400
Message-ID: <CAEXW_YR4bgaLHMDd_e83bQANqfvk=4a_7H3NJUHzG4K7sRetiw@mail.gmail.com>
Subject: Re: [PATCH] admin-guide/hw-vuln: Rephrase a section of core-scheduling.rst
To:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Vineeth Pillai <Vineeth.Pillai@microsoft.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 21, 2021 at 3:02 PM Fabio M. De Francesco
<fmdefrancesco@gmail.com> wrote:
>
> Rephrase the "For MDS" section in core-scheduling.rst for the purpose of
> making it clearer what is meant by "kernel memory is still considered
> untrusted".
>
> Suggested-by: Vineeth Pillai <Vineeth.Pillai@microsoft.com>
> Signed-off-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>

Reviewed-by: Joel Fernandes (Google) <joelaf@google.com>

thanks,

 - Joel


> ---
>  Documentation/admin-guide/hw-vuln/core-scheduling.rst | 9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)
>
> diff --git a/Documentation/admin-guide/hw-vuln/core-scheduling.rst b/Documentation/admin-guide/hw-vuln/core-scheduling.rst
> index 7b410aef9c5c..e6b5ceb219ec 100644
> --- a/Documentation/admin-guide/hw-vuln/core-scheduling.rst
> +++ b/Documentation/admin-guide/hw-vuln/core-scheduling.rst
> @@ -181,10 +181,11 @@ Open cross-HT issues that core scheduling does not solve
>  --------------------------------------------------------
>  1. For MDS
>  ~~~~~~~~~~
> -Core scheduling cannot protect against MDS attacks between an HT running in
> -user mode and another running in kernel mode. Even though both HTs run tasks
> -which trust each other, kernel memory is still considered untrusted. Such
> -attacks are possible for any combination of sibling CPU modes (host or guest mode).
> +Core scheduling cannot protect against MDS attacks between the siblings running in
> +user mode and the others running in kernel mode. Even though all siblings run tasks
> +which trust each other, when the kernel is executing code on behalf of a task, it
> +cannot trust the code running in the sibling. Such attacks are possible for any
> +combination of sibling CPU modes (host or guest mode).
>
>  2. For L1TF
>  ~~~~~~~~~~~
> --
> 2.32.0
>
