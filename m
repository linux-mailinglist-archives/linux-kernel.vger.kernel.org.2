Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4FC9E40D69A
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Sep 2021 11:49:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235613AbhIPJu5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Sep 2021 05:50:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:55728 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235287AbhIPJuw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Sep 2021 05:50:52 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8E2D960F6C;
        Thu, 16 Sep 2021 09:49:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1631785771;
        bh=ZL36CtfQPIByWCEdkXe9MMBPrn88jj47xHWZOqeo/aM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=agYldPhVUM/jkq3nabLH8doK7az+QbhwSa1QkRsJsw+f+dF43Hf0YU9y42UFHK3UR
         sNErnc61PHJPtXU9CC8uk4wII9C3RFyKa0lgj+WKjYaZhpeDk79+S6IVjAjeZbIBQf
         cexgQlGNri9PJHAwQ6vrSnPyKG8ekyV6TYw9mkC72DFA5MpFWnbxKE8nVvFn+FHn17
         nhzYbPln0d8lXf+M2759LVkEjSxewL0E8BASK1cG4Y29l+RMsob6BborKwIk5eJSsN
         4VMMQeSHRmllg7YkuGrU4O0s5C/7ZTt3zMRq6n0vAUxmvQfreqJ6SxDtNcvFxYcCmO
         yJCH4qRaoINxg==
Date:   Thu, 16 Sep 2021 11:49:26 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Sudeep Holla <sudeep.holla@arm.com>
Cc:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 12/24] MAINTAINERS: update arm,vic.yaml reference
Message-ID: <20210916114926.71c789fd@coco.lan>
In-Reply-To: <20210916091836.oevsk4eui6wa7xkt@bogus>
References: <cover.1631783482.git.mchehab+huawei@kernel.org>
        <61989ac6bc0bece7078c32320049c74443bbb5ba.1631783482.git.mchehab+huawei@kernel.org>
        <20210916091836.oevsk4eui6wa7xkt@bogus>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.30; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Thu, 16 Sep 2021 10:18:36 +0100
Sudeep Holla <sudeep.holla@arm.com> escreveu:

> On Thu, Sep 16, 2021 at 11:14:05AM +0200, Mauro Carvalho Chehab wrote:
> > Changeset b7705ba6d0c4 ("dt-bindings: interrupt-controller: Convert ARM VIC to json-schema")
> > renamed: Documentation/devicetree/bindings/interrupt-controller/arm,vic.txt
> > to: Documentation/devicetree/bindings/interrupt-controller/arm,vic.yaml.
> > 
> > Update its cross-reference accordingly.
> > 
> > Fixes: b7705ba6d0c4 ("dt-bindings: interrupt-controller: Convert ARM VIC to json-schema")
> > Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> > ---
> >  MAINTAINERS | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index 0ea4cd772a0c..f02d1c94a219 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -1550,7 +1550,7 @@ ARM PRIMECELL VIC PL190/PL192 DRIVER
> >  M:	Linus Walleij <linus.walleij@linaro.org>
> >  L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
> >  S:	Maintained
> > -F:	Documentation/devicetree/bindings/interrupt-controller/arm,vic.txt
> > +F:	Documentation/devicetree/bindings/interrupt-controller/arm,vic.yaml
> >  F:	drivers/irqchip/irq-vic.c  
> 
> You seem to have dropped the tags already provided here [1]

Gah, true :-(

I forgot I submitted part of those patches already. Will send a v2
with the missing reviewed-by/acked-by.

Thanks,
Mauro
