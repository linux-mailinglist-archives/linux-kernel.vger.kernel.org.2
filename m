Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF7EB4025E3
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Sep 2021 11:04:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244325AbhIGJFc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Sep 2021 05:05:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245489AbhIGJFP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Sep 2021 05:05:15 -0400
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89CDBC06175F
        for <linux-kernel@vger.kernel.org>; Tue,  7 Sep 2021 02:04:09 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id g14so7644894pfm.1
        for <linux-kernel@vger.kernel.org>; Tue, 07 Sep 2021 02:04:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=JT40h1sqFKOXqQynjb32P0gwjUjlNSTVOulfaGgY9SY=;
        b=e+/yuG0NefU01Sn/0N6reRSzg64hFOX0e2EOZgQwHA/fJX9drVd8IEnz0/6hZ6TSUY
         iyZgb5WGpFSrKlJdxUwLChOZgef4Er8kh7A8HlrsCud6emMcaZZZAZC0BaV6489eCW73
         BtnctBXpzDC8Y186iUxsEuvAt03Sq+R8Xa/YQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=JT40h1sqFKOXqQynjb32P0gwjUjlNSTVOulfaGgY9SY=;
        b=UbuJKSI8tpLa+smhv7fn6nYWr3hyjpNpPiLiVA8r9scpPhijihn/kPROlgmQYEVZJ/
         3iNxbj8jnqfwpu4UZvns6PQyGvQId90Vr1PqMSOseugDuycZ1iN5f2SfT5pGUKSh05lJ
         5hzWNpbi+gs7rqlPGqVQIdzsv9b57PHTx+4kYbpTwky9KBfW0NQvh9eTOkWNl6i1cxsn
         +K7gPUtRua86t5Rc8m73ZrYD+WoGz89Q/bBaAPmTIVvqDdEVeFA6nngXs2XXK77GZ9hJ
         S4jaGBaBqD8RdOFIz8qFHUjnLsKGQ498xNzXS/a/R4C1aAB0Ykb4AoKOQamsfwueMqPD
         PrVg==
X-Gm-Message-State: AOAM531K1JQHjOZzHLXEJcinxTPI1kvfEePJ/PsjqQLLHqQfZicaQ9pJ
        rwQDxy+1qmrYFAGDw8R+oBnksQ==
X-Google-Smtp-Source: ABdhPJwm31KByBnVlIs7w8AhfNmb0SVtrFTViZTx/Z2vDwUsInRHv7kDRMPZxQRCnuti15RgLOsTmQ==
X-Received: by 2002:a63:1b60:: with SMTP id b32mr16009500pgm.422.1631005449064;
        Tue, 07 Sep 2021 02:04:09 -0700 (PDT)
Received: from google.com ([2409:10:2e40:5100:4040:44a5:1453:e72c])
        by smtp.gmail.com with ESMTPSA id f10sm143297pfd.53.2021.09.07.02.04.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Sep 2021 02:04:08 -0700 (PDT)
Date:   Tue, 7 Sep 2021 18:04:03 +0900
From:   Sergey Senozhatsky <senozhatsky@chromium.org>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Namjae Jeon <linkinjeon@kernel.org>,
        Steve French <sfrench@samba.org>,
        Hyunchul Lee <hyc.lee@gmail.com>, linux-cifs@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] ksmbd: remove unnecessary conditions
Message-ID: <YTcrA2U2n5QAUkt5@google.com>
References: <20210907073428.GD18254@kili>
 <YTcdbOgmB7758K+/@google.com>
 <20210907085430.GM1957@kadam>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210907085430.GM1957@kadam>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (21/09/07 11:54), Dan Carpenter wrote:
> On Tue, Sep 07, 2021 at 05:06:04PM +0900, Sergey Senozhatsky wrote:
> > On (21/09/07 10:34), Dan Carpenter wrote:
> > >  
> > >  		id = le32_to_cpu(psid->sub_auth[psid->num_subauth - 1]);
> > > -		if (id >= 0) {
> > > -			/*
> > > -			 * Translate raw sid into kuid in the server's user
> > > -			 * namespace.
> > > -			 */
> > > -			uid = make_kuid(&init_user_ns, id);
> > > -
> > > -			/* If this is an idmapped mount, apply the idmapping. */
> > > -			uid = kuid_from_mnt(user_ns, uid);
> > > -			if (uid_valid(uid)) {
> > > -				fattr->cf_uid = uid;
> > > -				rc = 0;
> > > -			}
> > > +		/*
> > > +		 * Translate raw sid into kuid in the server's user
> > > +		 * namespace.
> > > +		 */
> > > +		uid = make_kuid(&init_user_ns, id);
> > 
> > Can make_kuid() return INVALID_UID? IOW, uid_valid(uid) here as well?
> 
> No need to check twice.  We're going to check at the end.
> 
> > 
> > > +
> > > +		/* If this is an idmapped mount, apply the idmapping. */
> > > +		uid = kuid_from_mnt(user_ns, uid);
> > > +		if (uid_valid(uid)) {
>                     ^^^^^^^^^^^^^^
> The check here is sufficient.

My point was more that a potentially invalid UID is passed to kuid_from_mnt()
and kgid_from_mnt(). I don't see map_id_up(), for example, checking that
passed UID is valid. So decided to double check.
