Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 446CD352C26
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Apr 2021 18:09:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235384AbhDBPJP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Apr 2021 11:09:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235327AbhDBPJO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Apr 2021 11:09:14 -0400
Received: from mail-vs1-xe30.google.com (mail-vs1-xe30.google.com [IPv6:2607:f8b0:4864:20::e30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1388C06178A
        for <linux-kernel@vger.kernel.org>; Fri,  2 Apr 2021 08:09:12 -0700 (PDT)
Received: by mail-vs1-xe30.google.com with SMTP id l8so2879738vsj.13
        for <linux-kernel@vger.kernel.org>; Fri, 02 Apr 2021 08:09:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YgtLUE8tLw2Zk1N7ATFrtV7j3dv262lk75CYdDYHcbQ=;
        b=kd9SvTxYOWxn37TZiIkBotQfbjom6BmDGK0QVftHGDvVKbWOFqt4n8MYddo3K4uEPz
         GN/98Lwen7yHTB62wzUNAQz1jXtxtm1hMrk8ea95f9lVhuj6DLC0U+0fpRnyjZi/OVRe
         Dc7pnlam/2yWvqj/HepMcxqxki9N5cJoV/mXsLrGUlG0j2rwfDuJ9p6uuGK5erg4WmS7
         1GU5d7RE3sOtUkXxb6wpu9srfEvaZovXTqu3jIu1G3Jo26tk6ubAobk1V4hwM+GsJSm1
         Z/eMDJLpSTQW8Ihc+u/t9FXiP583UEEdRdmZD6kem8ORj6oIdrLSzqWc+RGmPhl7i6Fx
         psPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YgtLUE8tLw2Zk1N7ATFrtV7j3dv262lk75CYdDYHcbQ=;
        b=N9qGeEsO1r1DF2UtZKcXPibPZOisFJBpLRXAp5E2RuVSnzZdQzDOCT8fXBgDKMujSk
         q37dHJHed4EqwIC646ZbFQQ2X+ZZJozUPdhL/TOPm7OqSEfDtzmwOQiVotIi46Q5pNof
         lUDRIrVA+lnsPgSI8JlYCosJUqPYGkgaVGHsB0FvcvITefHfkusUrF8pC0l9jI3R9GCS
         RWnQP0IuFN26zcAJmU3JNbcpYBIcf0vSvPptjao1RA23iaELpGeyZ9yQCsEWc0PpNw/Y
         lsaxCc2oQ2TXngfcLPrLq8g4W1ON3RftWOTcssPQ01/x+gYUBQoy8Ka/luG+8xcl/gB+
         cylA==
X-Gm-Message-State: AOAM533JuJosgUPfmjcu1gzPeFLJx0JdB/S0zTgXiFljJ+DAzocozn5/
        GHQo4q5hUhFJJpNK5qKVXb7sDWsZnMZ2WtDdpYFwaw==
X-Google-Smtp-Source: ABdhPJyt+vRGIldfMsc/6SAnW/nT0tZKLkIVaHdFuQ9H9NOultOR42/DlIuLdW9oxY84oBB0Iuz0jwbWHMBtVzSTD74=
X-Received: by 2002:a67:3043:: with SMTP id w64mr9076775vsw.36.1617376151718;
 Fri, 02 Apr 2021 08:09:11 -0700 (PDT)
MIME-Version: 1.0
References: <20210402123959.5143-1-alobakin@pm.me>
In-Reply-To: <20210402123959.5143-1-alobakin@pm.me>
From:   Sami Tolvanen <samitolvanen@google.com>
Date:   Fri, 2 Apr 2021 08:09:00 -0700
Message-ID: <CABCJKufH262ki4FCQJxSO-v+gQzPBsVntQWnNZY7h-cvt1KYTA@mail.gmail.com>
Subject: Re: [PATCH] kbuild: merge module sections under CONFIG_LD_DEAD_CODE_DATA_ELIMINATION
 too
To:     Alexander Lobakin <alobakin@pm.me>
Cc:     Kees Cook <keescook@chromium.org>, Jessica Yu <jeyu@kernel.org>,
        Miroslav Benes <mbenes@suse.cz>,
        Emil Velikov <emil.l.velikov@gmail.com>,
        Sean Christopherson <seanjc@google.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        linux-hardening@vger.kernel.org,
        linux-kbuild <linux-kbuild@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 2, 2021 at 5:40 AM Alexander Lobakin <alobakin@pm.me> wrote:
>
> When building with CONFIG_LD_DEAD_CODE_DATA_ELIMINATION,
> -fdata-sections and -ffunction-sections are being enabled by the
> top-level Makefile, and module section merging is also needed.
> Expand the ifdef (and the comment block) to cover that case too.
>
> Fixes: 6a3193cdd5e5 ("kbuild: lto: Merge module sections if and only if CONFIG_LTO_CLANG is enabled")

Wouldn't this trigger the ld.bfd bug described in the commit message
when LD_DEAD_CODE_DATA_ELIMINATION is enabled? LTO_CLANG always uses
LLD, so it won't have this issue.

Sami
