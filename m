Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7968F340ADC
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Mar 2021 18:04:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232202AbhCRRDf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Mar 2021 13:03:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232088AbhCRRDX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Mar 2021 13:03:23 -0400
Received: from mail-il1-x130.google.com (mail-il1-x130.google.com [IPv6:2607:f8b0:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF9A4C06174A
        for <linux-kernel@vger.kernel.org>; Thu, 18 Mar 2021 10:03:22 -0700 (PDT)
Received: by mail-il1-x130.google.com with SMTP id v3so5529855ilj.12
        for <linux-kernel@vger.kernel.org>; Thu, 18 Mar 2021 10:03:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KHHiM/ItqAn4rSR71ej22kWQ0vY81ks2qnnMGgdZ67E=;
        b=SsbfvpLur2SdEW0nlOiPXuPgRifew2eISC8RDFKN47D7zXzxRgbpNMiAWDsarrK11+
         t5lv0CARkL1RlCpjnmHjOY1YVcKxOrzAxu3kSmk4gR8STWyv9TGmt2zp+w9RFWIIa2DA
         k3UacE8MNIkI7qflBda6h2KNqP0MX7GmLj7L1zFSsXJtrFyXwTn4tRh4bJHFrRgm9Kqp
         t8y5yOnP79oL/OL4iIFHnBi5Aqh9JZeQGSkc4KF4Ywr+kivfGozx4ataO8IltvcIawnH
         rpyvzPQ4CPS4crthLILToDwri8P8HElKTO4Em+GHHWL37fo2HvgTTzy3aII5SDLz+7a4
         pUVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KHHiM/ItqAn4rSR71ej22kWQ0vY81ks2qnnMGgdZ67E=;
        b=gw+WD3LVpuLWUa+7kRWIk9E7N8DCBNFV96HkCZ8FgKaClian1Wg1MV2MffOyZ1oFdk
         Hgk7jg9COU67GUB+maGtkQ7QSHwkjujcdLEcOEt8zpgRMQEsFxuyG3z8Fg6HmYYodaly
         h9XULKOMjKB+K6jCe8uq+L4Zih7Hl6MYhvuW/CcDpU/voDYrYnHVKhrPfuRpqEgKqq8f
         e8HbkZSZvbWeYtx5+s7perMkCDtkMmlmBhI3NU4iJzws9Kg/t0NeQSWKc8NoV0JN3Nny
         ZknVPh8gpkqbPVRtK30JZknj5eA1UynLewml52VKUtHag70WhPRYmqpvUX+UgePC3t9o
         t/3w==
X-Gm-Message-State: AOAM5322sFAqWlhSkUTvjlCL9Lihb/BVUJ3rWL3xxvTq3/vLRlNXnrLK
        kIR5HcpsyVRHBIIIAHSHiyRuaPjq+8WamYn0i7Q=
X-Google-Smtp-Source: ABdhPJxQ9Lo/ry32fvcKgQngZDlZn+Y272b0LjPJU8+71Om6KXLWhClx5bZXn7uPwE7Tdc2ZoxnqhQflJcTgako6YCw=
X-Received: by 2002:a05:6e02:1563:: with SMTP id k3mr11861004ilu.64.1616087002402;
 Thu, 18 Mar 2021 10:03:22 -0700 (PDT)
MIME-Version: 1.0
References: <CABJPP5AjUJ+OWqUy7cR1Ar2zcs6QuLizciGf64WVQ-027rS=bA@mail.gmail.com>
In-Reply-To: <CABJPP5AjUJ+OWqUy7cR1Ar2zcs6QuLizciGf64WVQ-027rS=bA@mail.gmail.com>
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
Date:   Thu, 18 Mar 2021 18:03:11 +0100
Message-ID: <CAKXUXMx-4p361gFewN61NEbrwTjVY9wZFg2i13VMZTUxiDJB=Q@mail.gmail.com>
Subject: Re: Checkpatch still worries about include/asm/ ?
To:     Dwaipayan Ray <dwaipayanray1@gmail.com>
Cc:     Joe Perches <joe@perches.com>,
        linux-kernel-mentees@lists.linuxfoundation.org,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 18, 2021 at 5:47 PM Dwaipayan Ray <dwaipayanray1@gmail.com> wrote:
>
> Hello,
> include/asm/ got removed a long time back (probably v1.1.45).
> Checkpatch still worries about that:
>
> if ($realfile =~ m@^include/asm/@) {
> ERROR("MODIFIED_INCLUDE_ASM",
> "do not modify files in include/asm, change architecture specific
> files in include/asm-<architecture>\n" . "$here$rawline\n");
> }
>
> Can we remove this check?
>

Wow, v1.1.45... that must have been taking quite some digging in the
ancient dirt to find that out.

I agree, let us remove that rule.

Thanks for the documentation effort on checkpatch.pl and cleaning up
obsolete rules while documenting.

Lukas
