Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A5B13DEAF8
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Aug 2021 12:34:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235229AbhHCKeL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Aug 2021 06:34:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234674AbhHCKeH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Aug 2021 06:34:07 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 775EAC06175F
        for <linux-kernel@vger.kernel.org>; Tue,  3 Aug 2021 03:33:55 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id pj14-20020a17090b4f4eb029017786cf98f9so4062854pjb.2
        for <linux-kernel@vger.kernel.org>; Tue, 03 Aug 2021 03:33:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=M+P09UYsgBUeZcTU8h1JnZ3LSSnMLTRIwZzJkf+vohM=;
        b=aYiS8O6yfH4RXLh5tsW0rUzfNmOf85niYQL8XSJr6R+tGFje/QeWK6zhSNG2RIzmks
         9Rozjsh2h+s/sTo4APqNHzLhnUbSKFKupmoTIqSi3pZu9GhMBFOU4Ykxj6VKzGuMJ/7d
         qLOla3h3ZswF/uHIM7eVNH3If6KctvKTPrwfgGk6eROEm6zY008X/7Xe86q2ZHPSjqA7
         doMW1AofGD+8P8BgqLZCsCDALihzXGtvyJi6lbzSROXMhL9DWeo7mSR5keU5XFav+B6u
         0z+yzT6W4aPpm/71b1gkIb3V1oo9nz2vtpTRkGEgBcptT7LyvRF+LmS3Vtd0z43uf1XC
         hxzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=M+P09UYsgBUeZcTU8h1JnZ3LSSnMLTRIwZzJkf+vohM=;
        b=S/eE/CLkSwZdGX7tEeHUjnE4+Velu2W7Ycm0WkHt67IFS/lbMnsK4a2xreJr31o/LM
         /3WL2WFRCcAhkGR0H4zU+QJ5XgQS2NuMgb2eUQImOkuTWmjgDS5aT098wTNMwrtTRXpt
         i67XOLPavraF6G24GfW8ISfCIdjMcfJotb62ZspKmKUK0p+RePh1oFNapC1s/9WSOXcn
         QLBiE8UD5nSLc2S1gL4X6dooNtdd5BGn2LDt/n76PkQfV6t05KDE7LqNsae7w2K1w8A1
         ylN+wbHQeVfZTpwfHuxdRH4vzEuM0QQqGAcqxbRbsAA8PQJXLoCkdSlvxQNx/Nl/kjWZ
         txSA==
X-Gm-Message-State: AOAM533LN4S6KvV0CBtaj7A2LHyKFseYnF/o2OipHtDY7BAfocYZ9cb7
        v2Ed1VZ1cHVcq52hIeuJd0Q=
X-Google-Smtp-Source: ABdhPJy/JgmcuTd4eI4S5cnSAlTKT3aOyEsqpOjGOd04rNnpA1AwiY26x48eOHuxs5+aerv2oD9CxA==
X-Received: by 2002:a17:903:1203:b029:12b:599b:524c with SMTP id l3-20020a1709031203b029012b599b524cmr18090633plh.10.1627986835078;
        Tue, 03 Aug 2021 03:33:55 -0700 (PDT)
Received: from localhost ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id n7sm10364089pjh.8.2021.08.03.03.33.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Aug 2021 03:33:54 -0700 (PDT)
Date:   Tue, 3 Aug 2021 03:34:45 -0700
From:   CGEL <cgel.zte@gmail.com>
To:     Davidlohr Bueso <dbueso@suse.de>
Cc:     keescook@chromium.org, christian.brauner@ubuntu.com,
        ktkhai@virtuozzo.com, jamorris@linux.microsoft.com,
        varad.gautam@suse.com, legion@kernel.org,
        linux-kernel@vger.kernel.org, Ran Xiaokai <ran.xiaokai@zte.com.cn>
Subject: Re: [PATCH] ipc: add set_ownership() and permissions() callbacks for
 posix mqueue sysctl
Message-ID: <20210803103445.GB607784@www>
References: <20210729030651.536326-1-ran.xiaokai@zte.com.cn>
 <4b67a8df7823cc14ffb69657c82562b2@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4b67a8df7823cc14ffb69657c82562b2@suse.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

O Fri, Jul 30, 2021 at 08:09:32AM -0700, Davidlohr Bueso wrote:
> On 2021-07-28 20:06, cgel.zte@gmail.com wrote:
> > This patch adds a ctl_table_set per ipc namespace, and also the
> > set_ownership() and permissions() callbacks for the new ctl_table_root
> > for ipc mqueue syscgtls.
>                   ^^ sysctls
> 
> This makes sense to me, just some nits below.
> 
> Acked-by: Davidlohr Bueso <dbueso@suse.de>
> 
> > 
> > Signed-off-by: Ran Xiaokai <ran.xiaokai@zte.com.cn>
> > ---
> ...
> > +static int set_permissions(struct ctl_table_header *head,
> > +				struct ctl_table *table)
> > +{
> 
> Please use curly braces for the else.
> 
> > +	return (mode << 6) | (mode << 3) | mode;
> > +}
> > +
> > +static void set_ownership(struct ctl_table_header *head,
> > +				struct ctl_table *table,
> > +				kuid_t *uid, kgid_t *gid)
> > +{
> > +	struct ipc_namespace *ipc_ns =
> > +		container_of(head->set, struct ipc_namespace, mq_set);
> > +	struct user_namespace *user_ns = ipc_ns->user_ns;
> > +	kuid_t ns_root_uid;
> > +	kgid_t ns_root_gid;
> > +
> > +	ns_root_uid = make_kuid(user_ns, 0);
> > +	if (uid_valid(ns_root_uid))
> > +		*uid = ns_root_uid;
> > +
> > +	ns_root_gid = make_kgid(user_ns, 0);
> > +	if (gid_valid(ns_root_gid))
> > +		*gid = ns_root_gid;
> > +}
> 
> Could set_permissions() and set_ownership() be factored such that we can
> avoid duplicated code between ipc and net ns? Something like:
> 
> void set_permissions(struct ctl_table_header *head, struct ctl_table *table)
> {
>     struct ipc_namespace *ipc_ns = container_of(head->set, struct
> ipc_namespace, mq_set);
>     set_permissions_common(ipc_ns->user_ns);
> }
> 
> Thanks,
> Davidlohr

Hi Davidlohr

Thanks for your comments.
I will sent a v2 patch together with Christian's comments.

