Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2043D43F236
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Oct 2021 00:00:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231417AbhJ1WCb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Oct 2021 18:02:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231290AbhJ1WC3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Oct 2021 18:02:29 -0400
Received: from mail-oi1-x231.google.com (mail-oi1-x231.google.com [IPv6:2607:f8b0:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C259C061745
        for <linux-kernel@vger.kernel.org>; Thu, 28 Oct 2021 15:00:02 -0700 (PDT)
Received: by mail-oi1-x231.google.com with SMTP id q129so10455688oib.0
        for <linux-kernel@vger.kernel.org>; Thu, 28 Oct 2021 15:00:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:user-agent:date:message-id
         :subject:to:cc;
        bh=U2bgkV8Gtb2EmNLb26ipZ27ur2cBfDdyGT9XXIWvRFI=;
        b=FIILcbmcidsvGBa1mmR8ApK/rZnLfd6pZL8+1FyAmUmh+HNZlMniJBUTIVBToT9fwP
         q2PNJ33WhLPhjgFHRgDFXWwqWEWlF12BN3dgT2DDRcML1XtHUh6YeiSnQWzrSKqDHiq/
         PVKxDFJT/hA4oEIsKoVbeDS03zW3G9HGvsXd4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:in-reply-to:references:from
         :user-agent:date:message-id:subject:to:cc;
        bh=U2bgkV8Gtb2EmNLb26ipZ27ur2cBfDdyGT9XXIWvRFI=;
        b=ePZDhwGj98F/iq7EToWOezHebH470NTiE2I6j04sQO3Au9xZA7or6HHAMg7eCKmrcD
         KSyAesv8BMK8vICNUfNlHnotALO/QOK0VM4eKgrsInKE143S8eYcmQDBpYNvSwnDC3xS
         NdUL3yFbFZX7cZMJskhkuxxD5javceczl6LBxg9+/b/2bNb7g/s9WaNB+v6jJJ0ihpHH
         DD2w3oq7cUIbrc4FAPTdCw0cXEqiGixPB6ZW9siIqO2Cp9PK7YG+EqDxsvDTjWmM15Oa
         xQRB0uArhdH3JtjZvrsgK9Y485UZHLhOFgZVbBXxXZLiwmVzUqaE7iS486KE64vmSd7W
         j/TQ==
X-Gm-Message-State: AOAM532ULzXQagfinGmi9x6y0YBcQfJ8pAhOkvvqdOaIu4UcJzTS5QhB
        UH+Vtt+rlDU6HQnlZpc2p7b6fxkUX8sDnowAJAgmIClGT5c=
X-Google-Smtp-Source: ABdhPJz9stvo4+dI77pYLNPWmeg60D2k77UKJxlcXuv1FAxd5zBLiIv2Wzd16jDMATPNYkKW9UADWAXFwYzhR3T9p20=
X-Received: by 2002:a05:6808:23c2:: with SMTP id bq2mr10977262oib.32.1635458401993;
 Thu, 28 Oct 2021 15:00:01 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 28 Oct 2021 15:00:01 -0700
MIME-Version: 1.0
In-Reply-To: <20211028140833.1.Ie6bd5a232f770acd8c9ffae487a02170bad3e963@changeid>
References: <20211028140833.1.Ie6bd5a232f770acd8c9ffae487a02170bad3e963@changeid>
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.9.1
Date:   Thu, 28 Oct 2021 15:00:01 -0700
Message-ID: <CAE-0n521q5uLms+qWO=ibQVRyTwsCRwPSPRvpncq_mgTVd0Bpg@mail.gmail.com>
Subject: Re: [PATCH] scripts/gdb: Handle split debug for vmlinux
To:     Douglas Anderson <dianders@chromium.org>,
        Jan Kiszka <jan.kiszka@siemens.com>,
        Kieran Bingham <kbingham@kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Johannes Berg <johannes.berg@intel.com>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Douglas Anderson (2021-10-28 14:08:49)
> This is related to two previous changes. Commit dfe4529ee4d3
> ("scripts/gdb: find vmlinux where it was before") and commit
> da036ae14762 ("scripts/gdb: handle split debug").
>
> Although Chrome OS has been using the debug suffix for modules for a
> while, it has just recently started using it for vmlinux as well. That
> means we've now got to improve the detection of "vmlinux" to also
> handle that it might end with ".debug".
>
> Cc: Stephen Boyd <swboyd@chromium.org>
> Signed-off-by: Douglas Anderson <dianders@chromium.org>
> ---
>
>  scripts/gdb/linux/symbols.py | 3 ++-
>  scripts/gdb/vmlinux-gdb.py   | 0
>  2 files changed, 2 insertions(+), 1 deletion(-)
>  mode change 100644 => 100755 scripts/gdb/vmlinux-gdb.py
>
> diff --git a/scripts/gdb/linux/symbols.py b/scripts/gdb/linux/symbols.py
> index 08d264ac328b..46f7542db08c 100644
> --- a/scripts/gdb/linux/symbols.py
> +++ b/scripts/gdb/linux/symbols.py
> @@ -148,7 +148,8 @@ lx-symbols command."""
>          # drop all current symbols and reload vmlinux
>          orig_vmlinux = 'vmlinux'
>          for obj in gdb.objfiles():
> -            if obj.filename.endswith('vmlinux'):
> +            if (obj.filename.endswith('vmlinux') or
> +                obj.filename.endswith('vmlinux.debug')):

Looks good.

>                  orig_vmlinux = obj.filename
>          gdb.execute("symbol-file", to_string=True)
>          gdb.execute("symbol-file {0}".format(orig_vmlinux))
> diff --git a/scripts/gdb/vmlinux-gdb.py b/scripts/gdb/vmlinux-gdb.py
> old mode 100644
> new mode 100755

Is this mode change important?
