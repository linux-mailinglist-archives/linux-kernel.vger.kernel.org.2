Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 380EF4098C1
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Sep 2021 18:17:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346143AbhIMQSQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Sep 2021 12:18:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346129AbhIMQSO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Sep 2021 12:18:14 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 244B7C061760
        for <linux-kernel@vger.kernel.org>; Mon, 13 Sep 2021 09:16:59 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id g13-20020a17090a3c8d00b00196286963b9so6959264pjc.3
        for <linux-kernel@vger.kernel.org>; Mon, 13 Sep 2021 09:16:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=IDZIxlJ99gLdFkYdOSMzYolkAWVQKBtzOhQTZ1gDmSw=;
        b=Xe77udHSg1RQKT3n2dzL86D+5A6b6RwlPTuOttOqXmLHwGuI4yHdyam7xuO9y2Nx4l
         Rnn39mkf6qBKwDkVtnD0NelaokpRhFdbrJMH2N6qjJuLWHmteAopctN5/88j5ZMhxMcp
         dkA8UmdRwlj885/53PXQ9mhH5whyWMn062qVQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=IDZIxlJ99gLdFkYdOSMzYolkAWVQKBtzOhQTZ1gDmSw=;
        b=FsC2iQ0qAMbVR1xK3Bg7hTdONlDXQnwoy5fMXgY5xfmX29//C+gswR0gm08bZG4Sbo
         Hv2cTDDEP8ghwTlUQO+QW7l34+05S+n0femfEulOfWIUWY9A64i4CtpEREjFDeLNhFan
         9i5hxzBnd4o9fJFc9dHtD660k70rE4hz6t3Hz3YfhjWtTIyzeOsonhM7u1MupM71rmDb
         rEaHfJRWtSr6N0HZN/rwosx+ICJfYLHcIonU4AOoywK1ML6g1zvlj+srh8Xj5MjLF5sQ
         x8sjKLyONE+NO9k2ebOKXDZ/IOXrxl63cplLkzPZio3lcbj2QrjdDF2fh26masEA6A3j
         bClg==
X-Gm-Message-State: AOAM53391+62MAE3vwDOci3hXexHBNSu9ojVVyMQF1W302o9nfpdKO7+
        Y5bnA4CkAJ8hWY77w3bIFHMHUA==
X-Google-Smtp-Source: ABdhPJzxadjqW2LJU4GyD2BIzxgOGOyVfpRbJb916IoUdjLS/cdFgxKDZaq0XT9SbyZ/m9uvG3JARA==
X-Received: by 2002:a17:90b:3a8c:: with SMTP id om12mr348392pjb.137.1631549818658;
        Mon, 13 Sep 2021 09:16:58 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id p9sm9403659pgn.36.2021.09.13.09.16.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Sep 2021 09:16:58 -0700 (PDT)
Date:   Mon, 13 Sep 2021 09:16:57 -0700
From:   Kees Cook <keescook@chromium.org>
To:     =?iso-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@digikod.net>
Cc:     James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH] landlock: Drop "const" argument qualifier to avoid GCC
 4.9 warnings
Message-ID: <202109130912.F061D2E1@keescook>
References: <20210910223613.3225685-1-keescook@chromium.org>
 <b269cdc1-a4f0-d614-f026-dc0f7c455da0@digikod.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <b269cdc1-a4f0-d614-f026-dc0f7c455da0@digikod.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 13, 2021 at 01:19:19PM +0200, Mickaël Salaün wrote:
> 
> On 11/09/2021 00:36, Kees Cook wrote:
> > When building under GCC 4.9, the compiler warns about const mismatches:
> > 
> > security/landlock/ruleset.c: In function 'insert_rule':
> > security/landlock/ruleset.c:196:34: error: passing argument 2 of 'create_rule' from incompatible pointer type [-Werror]
> >    new_rule = create_rule(object, &this->layers, this->num_layers,
> >                                   ^
> > security/landlock/ruleset.c:69:30: note: expected 'const struct landlock_layer ** const' but argument is of type 'struct landlock_layer (*)[]'
> >  static struct landlock_rule *create_rule(
> >                               ^
> > security/landlock/ruleset.c: In function 'landlock_insert_rule':
> > security/landlock/ruleset.c:240:38: error: passing argument 3 of 'insert_rule' from incompatible pointer type [-Werror]
> >   return insert_rule(ruleset, object, &layers, ARRAY_SIZE(layers));
> >                                       ^
> > security/landlock/ruleset.c:144:12: note: expected 'const struct landlock_layer ** const' but argument is of type 'struct landlock_layer (*)[1]'
> >  static int insert_rule(struct landlock_ruleset *const ruleset,
> 
> I guess this is a bug in GCC 4.9 (i.e. missing automatic const upgrade).
> Couldn't we backport a fix to GCC 4.9 instead?

I don't disagree, but I'm just trying to deal with the fall-out of
-Werror. Perhaps speak up on this thread in support of deprecating
GCC 4.9?

https://lore.kernel.org/lkml/20210910234047.1019925-1-ndesaulniers@google.com/

-Kees

-- 
Kees Cook
