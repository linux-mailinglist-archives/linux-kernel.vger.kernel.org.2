Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D2D5835660C
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Apr 2021 10:06:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236607AbhDGIGu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Apr 2021 04:06:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:40858 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233970AbhDGIGm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Apr 2021 04:06:42 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8F3F961222;
        Wed,  7 Apr 2021 08:06:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1617782793;
        bh=Saui7R6VgfinD0aYuADSUqh2OGbSYGStZdRURn73p8Q=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=CaQS81BmyDfetD8FswzLLV7h6/zoDjIyjLT15jD5RY5SFKpj834sHX1cqTmUxj7HF
         tdLn2UaFdycx2uLhSLTyzP+chLrpEN7uIC+nGL9LDhG9tJU+ue7zleKV753cnW6Wfg
         nppLNQ/JyeS633dDWM0YC3HBygcPZ1TSSlJRPfSJktIpQRAqJDfTWnha+kCMAS+8bS
         ne9wpH4kn9Wx6Is5UMWw9aL/7zxpgohjtxYOWY6iSUI38HS56YMYIxrzi2h+pp+UWw
         1Y2UhGFZIdfap22sxk+s9m/KkDZoMcKPsksDKEMY4t35lQl2HBguzAeWeeTavOgrd9
         fqSeTNLU4bblA==
Date:   Wed, 7 Apr 2021 10:06:27 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Rob Herring <robh+dt@kernel.org>
Cc:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Andy Whitcroft <apw@canonical.com>,
        Dwaipayan Ray <dwaipayanray1@gmail.com>,
        Joe Perches <joe@perches.com>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 29/32] docs: dt: update writing-schema.rst references
Message-ID: <20210407100627.13071b72@coco.lan>
In-Reply-To: <CAL_Jsq+3kqzQi+7emMWkuhyh2aj8qLy6nLS--J2P57Bw_jOCvw@mail.gmail.com>
References: <cover.1617279355.git.mchehab+huawei@kernel.org>
        <7cfddf303f1508d26f90d87546d3812faebfc5ba.1617279356.git.mchehab+huawei@kernel.org>
        <CAL_Jsq+3kqzQi+7emMWkuhyh2aj8qLy6nLS--J2P57Bw_jOCvw@mail.gmail.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Tue, 6 Apr 2021 10:04:57 -0500
Rob Herring <robh+dt@kernel.org> escreveu:

> On Thu, Apr 1, 2021 at 7:17 AM Mauro Carvalho Chehab
> <mchehab+huawei@kernel.org> wrote:
> >
> > Changeset b83db5b84900 ("docs: dt: Group DT docs into relevant sub-sections")
> > renamed: Documentation/devicetree/writing-schema.rst
> > to: Documentation/devicetree/bindings/writing-schema.rst.
> >
> > Update the cross-references accordingly.
> >
> > Fixes: b83db5b84900 ("docs: dt: Group DT docs into relevant sub-sections")
> > Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> > ---
> >  Documentation/devicetree/bindings/submitting-patches.rst | 2 +-
> >  scripts/checkpatch.pl                                    | 2 +-
> >  2 files changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/Documentation/devicetree/bindings/submitting-patches.rst b/Documentation/devicetree/bindings/submitting-patches.rst
> > index ee4feb53f8d0..104fa8fb2c17 100644
> > --- a/Documentation/devicetree/bindings/submitting-patches.rst
> > +++ b/Documentation/devicetree/bindings/submitting-patches.rst
> > @@ -25,7 +25,7 @@ I. For patch submitters
> >
> >         make dt_binding_check
> >
> > -     See Documentation/devicetree/writing-schema.rst for more details about
> > +     See Documentation/devicetree/bindings/writing-schema.rst for more details about  
> 
> We should make this a rSt link instead.

It shouldn't be needed, as Documentation/sphinx/automarkup.py has a rule
which converts Documentation/* into a cross reference using this
regex:

	RE_doc = re.compile(r'(\bDocumentation/)?((\.\./)*[\w\-/]+)\.(rst|txt)')


Thanks,
Mauro
