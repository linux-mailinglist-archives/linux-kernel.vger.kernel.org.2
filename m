Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9341D30F700
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Feb 2021 17:00:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237679AbhBDP6y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Feb 2021 10:58:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237619AbhBDP5U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Feb 2021 10:57:20 -0500
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEA1DC0613D6
        for <linux-kernel@vger.kernel.org>; Thu,  4 Feb 2021 07:56:39 -0800 (PST)
Received: by mail-wm1-x32b.google.com with SMTP id c127so3406713wmf.5
        for <linux-kernel@vger.kernel.org>; Thu, 04 Feb 2021 07:56:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ly7xf8TFh+llh9NACNqhD5htNQtraLXImu4H9QbnzgY=;
        b=h3SnCz2c5AYiddvzj7eISFAmhxovkdx9bJtYJXIf4aUqwRik4cRClZ74xY+VP6udj1
         ojiwmEqV7FwFZa4MjLIU3z1M3VW9zuuA7CS/tpn0rf1062dDXk2iSsSXznrir7mfzyz7
         oTbPdf3lFNYdEl3AjY4A/din9WSh22GD9NqaZo64T7s2MROkThDOuJ5OiIOcLSkMrj2+
         zKnID5doDlYPOr6uhx48dBHresMroL8MOaL5G2Z03UObFdBYuDBD9YA1FXY5VX/g89No
         fLY4zaMXUo6HoWshPxcJHndy0aMbeWS+Mu9VUYjuLGSJnikIvJHw0ioznYbJBxB2NnRs
         C4vA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ly7xf8TFh+llh9NACNqhD5htNQtraLXImu4H9QbnzgY=;
        b=L/uxKglLL45n/aY5TpO2QCKG4TzosNn5fR7DftN0ArPluFu4upCN9dCpn1ggtczTeV
         DaP334+FV/0rXJL5UKXqTUj/TzYES4plstuuujkZ0/Qv/J67UpcHQYFhe7V5GJsPPF+a
         EwY3GlzYSzRC7UYZeukfAbA3Xi8BzpfKV24agSsqSwqN1D2rTvQxpUtN22GK/FhASPHR
         WaIBaDV7FWJWCn1exoKl1/lpsoXS//eLd7sf57wz+3sgmwwJurKSfQulAcqbM9M14PwZ
         uCdf3BU0rqdsNPC/SZv+CPYfikIoe6JlYYYb8skJ+xZ12QB67hHVJ++9SPFzaDrvt9S3
         P63Q==
X-Gm-Message-State: AOAM531UBqubNin4gOL52bhkJv2hY8JFoJNS85abm0kFJsm72mbOL1GN
        R1FkCX0TPzs+YVMvFnuBWd58jbtTJphNnw==
X-Google-Smtp-Source: ABdhPJwT9Hv/gJ3vYpfNnuCmyBPsmF4rxBfKUFOgGOoGMPhrZaggCXVIOs0HDxVijPgYG4Y09+DI9Q==
X-Received: by 2002:a7b:c304:: with SMTP id k4mr146207wmj.11.1612454198541;
        Thu, 04 Feb 2021 07:56:38 -0800 (PST)
Received: from maple.lan (cpc141216-aztw34-2-0-cust174.18-1.cable.virginm.net. [80.7.220.175])
        by smtp.gmail.com with ESMTPSA id e11sm8734325wrt.35.2021.02.04.07.56.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Feb 2021 07:56:37 -0800 (PST)
Date:   Thu, 4 Feb 2021 15:56:35 +0000
From:   Daniel Thompson <daniel.thompson@linaro.org>
To:     Stephen Zhang <stephenzhangzsd@gmail.com>
Cc:     jason.wessel@windriver.com, dianders@chromium.org,
        gustavoars@kernel.org, kgdb-bugreport@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4] kdb: kdb_support: Fix debugging information problem
Message-ID: <20210204155635.ibvnyzo7qqgysfhl@maple.lan>
References: <1612440429-6391-1-git-send-email-stephenzhangzsd@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1612440429-6391-1-git-send-email-stephenzhangzsd@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 04, 2021 at 08:07:09PM +0800, Stephen Zhang wrote:
> There are several common patterns.
> 
> 0:
>         kdb_printf("...",...);
> 
> which is the normal one.
> 
> 1:
>         kdb_printf("%s: "...,__func__,...)
> 
> We could improve '1' to this :
> 
>         #define kdb_func_printf(format, args...) \
>                    kdb_printf("%s: " format, __func__, ## args)
> 
> 2:
>         if(KDB_DEBUG(AR))
>                 kdb_printf("%s "...,__func__,...);
> 
> We could improve '2' to this :
>         #define kdb_dbg_printf(mask, format, args...) \
>                            do { \
>                                         if (KDB_DEBUG(mask)) \
>                                                 kdb_func_printf(format, ## args); \

This line is picked up by checkpatch as being overlong.

>                            } while (0)
> 
> In additon, we changed the format code of size_t to %zu.

Should be `addition`.



> Signed-off-by: Stephen Zhang <stephenzhangzsd@gmail.com>

It is arguable that there should be a Reviewed-by: from Doug here...
although given the big changes in v3 I don't think you were wrong
to drop it.

Nevertheless... given the implicit R-b ("when Daniel merges") in Doug's
comments on v3 I decided to reinstate it.

No action needed from you on this. I have fixed up all these issues
when I applied the patch. Thanks!


Daniel.
