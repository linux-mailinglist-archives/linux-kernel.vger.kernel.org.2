Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1FDFE43CB35
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Oct 2021 15:53:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242299AbhJ0N4H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Oct 2021 09:56:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:35688 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S242231AbhJ0N4F (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Oct 2021 09:56:05 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1C48860E76;
        Wed, 27 Oct 2021 13:53:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1635342820;
        bh=WcTWoIETV1iaGQ87vMGpi+M2gROpn+QI6SzeN4yX51M=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=CQC8MHLQlHyW8J9VF8RNPJ3CEMu5ZjcpX+nw78YTENKe7CTJ1Yy7O2KSsEYHYJmZl
         S9UJ/CLLSbBfKsyNhZzIUWoniJ3bkBs50RXV6WpaN0u0TFpldraZbtj1RwCVo7fxK+
         9z96o8/+da2WS26pJYNM0+dJ1j+7TThlqChP7qpkB7gQs8LT3YttdUaAz5fppnIjVH
         BbA7E92ZQzRUtuWQxQuEXR0LXxJ/vqTnbFSlP8i1Cuk1Bek/lX7hSmZn8y8CEEZAM+
         KXsTJsFumiTXfJReS8bQta+/aQqhUXUD0XS26JuBbH8fVw5l5PmsWAywPkkCjwBTUq
         o6qHrNej8jefg==
Received: by mail-ed1-f49.google.com with SMTP id h7so10942025ede.8;
        Wed, 27 Oct 2021 06:53:40 -0700 (PDT)
X-Gm-Message-State: AOAM532mDR6H1bLbusyLSvFvRWCuWNENOWlTOa+IqlzexTe37wqgWULm
        k1YHhZlskthqRLU0D91KpcCbKLT0s16Mo+DEiA==
X-Google-Smtp-Source: ABdhPJyBc66XjEE0O70ctptyabEsF5XFNtrEsfDyd7SbbEV4N6yCakylb3Qot6DyTYWsMARkFxooUSGTVf/8ZHj2Wd4=
X-Received: by 2002:a17:907:608a:: with SMTP id ht10mr16852290ejc.147.1635342815491;
 Wed, 27 Oct 2021 06:53:35 -0700 (PDT)
MIME-Version: 1.0
References: <20211026171804.2867369-1-robh@kernel.org> <8c6d5a97-14f7-9155-6f90-17e6e33d77c2@lucaceresoli.net>
In-Reply-To: <8c6d5a97-14f7-9155-6f90-17e6e33d77c2@lucaceresoli.net>
From:   Rob Herring <robh@kernel.org>
Date:   Wed, 27 Oct 2021 08:53:23 -0500
X-Gmail-Original-Message-ID: <CAL_JsqLij-yhUJ1+rKODzs2rSKepUDgWUxBwvEu8f_mvKqm5xQ@mail.gmail.com>
Message-ID: <CAL_JsqLij-yhUJ1+rKODzs2rSKepUDgWUxBwvEu8f_mvKqm5xQ@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: Add a help message when dtschema tools are missing
To:     Luca Ceresoli <luca@lucaceresoli.net>
Cc:     devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Masahiro Yamada <masahiroy@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 27, 2021 at 2:30 AM Luca Ceresoli <luca@lucaceresoli.net> wrote:
>
> Hi Rob,
>
> thanks for this patch!
>
> On 26/10/21 19:18, Rob Herring wrote:
> > The dtschema version check works, but is not that clear when dtschema is
> > neither installed nor in the PATH. Add a separate check and message if
>
> Nit: I think it should say "either not installed or not in the PATH".

Right.

>
> > dt-doc-validate is not found.
> >
> > Cc: Luca Ceresoli <luca@lucaceresoli.net>
> > Cc: Masahiro Yamada <masahiroy@kernel.org>
> > Signed-off-by: Rob Herring <robh@kernel.org>
> > ---
> >  Documentation/devicetree/bindings/Makefile | 4 ++++
> >  1 file changed, 4 insertions(+)
> >
> > diff --git a/Documentation/devicetree/bindings/Makefile b/Documentation/devicetree/bindings/Makefile
> > index 8d6d912c6a6a..001b4f62b741 100644
> > --- a/Documentation/devicetree/bindings/Makefile
> > +++ b/Documentation/devicetree/bindings/Makefile
> > @@ -9,6 +9,10 @@ DT_SCHEMA_MIN_VERSION = 2021.2.1
> >
> >  PHONY += check_dtschema_version
> >  check_dtschema_version:
> > +     @which $(DT_DOC_CHECKER) >/dev/null || \
> > +             { echo "Error: '$(DT_DOC_CHECKER)' not found!" \
> > +             "\nEnsure dtschema python package is installed and in your PATH." \
> > +             "\nCurrent PATH is:\n$$PATH\n" >&2; false; }
>
> You need 'echo -e' for the '\n'.

Except dash will just print '-e' and interpret the newlines...

I changed it like this:

@which $(DT_DOC_CHECKER) >/dev/null || \
{ echo "Error: '$(DT_DOC_CHECKER)' not found!" >&2; \
  echo "Ensure dtschema python package is installed and in your PATH." >&2; \
  echo "Current PATH is:" >&2; \
  echo "$$PATH" >&2; false; }

Rob
