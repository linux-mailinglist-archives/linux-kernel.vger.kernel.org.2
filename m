Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CED55357089
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Apr 2021 17:39:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236545AbhDGPjE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Apr 2021 11:39:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231366AbhDGPjB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Apr 2021 11:39:01 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46F8CC061756
        for <linux-kernel@vger.kernel.org>; Wed,  7 Apr 2021 08:38:50 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id a6so12454907wrw.8
        for <linux-kernel@vger.kernel.org>; Wed, 07 Apr 2021 08:38:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=PgfSSgWWGnJrITlLJ0K+KPTYMGpFHqdgXbRVjqTXauE=;
        b=kDhTBq1m4FakBwFLKFIwVcGHcH0AqtLggFGnTPKPAgyLWmSb6Qkhj/u4hh/cHK4oei
         tO7ZoP41t6AF+dyQ0kZlul8ZxKo6xDtBewUP+2hZL0QvA7gHAkPCkcQ6pXZOiceANA79
         AMt/CAmZ7Qco8RQ+rkFCbumUWVrkKvthomWnDLc8vpYw+JA0hmiR1tenlsVzVEx/nw5Z
         WTpJ+tJzX/r0xR5tTPHo16hvjB8nNaCGpEIo+RPtp6ssTgEiiCgC6S+mzuHQ4HeNi9sL
         AXSfnpw6bBkovdH1gTpdv1cIAEpNDZzl8tMKYuK2rZ6v1TELt0p1w3DzFOvaLPSgCC/A
         6SSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=PgfSSgWWGnJrITlLJ0K+KPTYMGpFHqdgXbRVjqTXauE=;
        b=eCGdoYNsohL/YWQhEvTuqNXp+xIucHtrXX22gmNdt+VafXG/pmD9XHycozzbb/0yE+
         GdIbUXr0zmir/pcSl+KkDGHw7J+4LevCjCVUQSJsoepCjw4OkGT+VrWupZzK1GuwBh47
         LQlEUIo157rgsghxh9t8R5ze++nmwemfuZqgcEfVOH6AhKFmxmmIrcyipnedF08DlTvw
         f8Zl6p1sU2ECdKby4xZ8GzW434pJAdcpJ0tctsbqUq0qH/DcEjSNPlFQL3AMI5jO1pP7
         oLQcEsiBSckvn0pPq+2bbIJBIO613cC/hc/uy9/8SGn6sGf1JJC7bAqo0fxX8Ox+gfqd
         P0TQ==
X-Gm-Message-State: AOAM531yQ8p7j3eRvOx6So5vSXR+kCbgGHf2UGWwGhPbnk14fw1p3ce3
        Ut7Kgc5/TRvB/fbXCsFiJ8yR9H/Ua8o=
X-Google-Smtp-Source: ABdhPJy34RCn31VLSLxNkvRukDu5fZtzbNJcl+BYjRDAeKer83hnHvTVrU+Z0ars+LB2pgKbk9RBcQ==
X-Received: by 2002:a5d:4ac7:: with SMTP id y7mr5166844wrs.395.1617809929055;
        Wed, 07 Apr 2021 08:38:49 -0700 (PDT)
Received: from agape.jhs ([5.171.72.217])
        by smtp.gmail.com with ESMTPSA id y4sm9642472wmc.2.2021.04.07.08.38.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Apr 2021 08:38:48 -0700 (PDT)
Date:   Wed, 7 Apr 2021 17:38:46 +0200
From:   Fabio Aiuto <fabioaiuto83@gmail.com>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 07/19] drivers: rtl8723bs: rewrite comparison to null
Message-ID: <20210407153845.GB1590@agape.jhs>
References: <cover.1617802415.git.fabioaiuto83@gmail.com>
 <0c6d53c851d1b07eb0183108e0bad7b4f273f04b.1617802415.git.fabioaiuto83@gmail.com>
 <YG3MOCQHu3o/qHTg@kroah.com>
 <20210407152533.GA1590@agape.jhs>
 <YG3QGq0T/cO2kdFN@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YG3QGq0T/cO2kdFN@kroah.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 07, 2021 at 05:30:34PM +0200, Greg KH wrote:
> On Wed, Apr 07, 2021 at 05:25:34PM +0200, Fabio Aiuto wrote:
> > On Wed, Apr 07, 2021 at 05:14:00PM +0200, Greg KH wrote:
> > > On Wed, Apr 07, 2021 at 03:49:31PM +0200, Fabio Aiuto wrote:
> > > > fix following post-commit hook checkpatch warnings:
> > > > 
> > > > CHECK: Comparison to NULL could be written "!psta"
> > > > 97: FILE: drivers/staging/rtl8723bs/core/rtw_ap.c:2115:
> > > > +		if (psta == NULL)
> > > > 
> > > > Signed-off-by: Fabio Aiuto <fabioaiuto83@gmail.com>
> > > > ---
> > > >  drivers/staging/rtl8723bs/core/rtw_ap.c | 2 +-
> > > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > 
> > > Nit, your subject line has "drivers:" not "staging:" here.  Be a bit
> > > more careful next time please.
> > > 
> > > thanks,
> > > 
> > > greg k-h
> > 
> > sorry, you can drop them off the staging-testing branch and I will resend you all if you want,
> 
> Nah, it's not worth it, I'll keep them for now :)

:-D
