Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 57D653DB645
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jul 2021 11:48:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238226AbhG3Jst (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Jul 2021 05:48:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238193AbhG3Jss (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jul 2021 05:48:48 -0400
Received: from mail-il1-x12d.google.com (mail-il1-x12d.google.com [IPv6:2607:f8b0:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BF05C061765
        for <linux-kernel@vger.kernel.org>; Fri, 30 Jul 2021 02:48:44 -0700 (PDT)
Received: by mail-il1-x12d.google.com with SMTP id j18so5759431ile.8
        for <linux-kernel@vger.kernel.org>; Fri, 30 Jul 2021 02:48:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=/dHQgNBIhi4HkTxU3CwTUDPWzDD5PbqhD37IQU0N6H0=;
        b=PCyiKhrtP+4bA2hNBY9xB73NTn4teEkICoCNu5nT/QCwpVOrtM7l1yIlmGKdsrKJt4
         ljr0DJcOINJT+ha+bh4TManrgpsElkrCFaDTxE/JPu3lTQ/ki/aUOz+ZpwSd22qRkyVD
         QoyNfxh4BzyR7whcuWIW20o/iRgMSViXwu0zQO72RmeHqnGU0oD+pvhcxujHjRlo9BW/
         Y4xA5d7YRLcjOftxMgsgQyq1BvYF5rgorcHDH0dIWq/ZApTnaJji6wcAqLKMqZ5tOEsD
         Syb+C+7VXW5GOtz556zV3XXYRXwN+WFn8H82S8PsKLfrAvK/BDxs1chmuNVEcFJ9ZxLY
         NcRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=/dHQgNBIhi4HkTxU3CwTUDPWzDD5PbqhD37IQU0N6H0=;
        b=XvqPh7JSHOmLenqWhlr2NoMuvB9RpCeutIih4a9HVRRDOCv8i2gIIcxRy9pBgb/yOZ
         qy+WJFSI0KvTNmJvAmbqXmRe6QCGm2l3P0Nqd5i7P9VYDBawLTpqchYAhcxRxD2Mc2u+
         6mPLE7rN5l/wRqhqyUABqS7xjsmK8xeBDRxQZQqEOEuCZ4kJIt6tN+NvUWD3WYg0flrv
         /QibJLJgvOFQaPARTYwnzUdj8kJBkFxmG8W5nuvduAA6bFD/JqF0bch2HIZ76dFm4TKv
         FgEy9/rCoIJgZl03NPvV0LTNutisa2vbhbnkxeEDNUUFFM1B0wbGe9osGP0PGnvapKE7
         j/VQ==
X-Gm-Message-State: AOAM5327WdTuoRZf7ZoMYUZsBug+I51Jz55r9bjV9UBIAe6aSwGU+mqV
        K+/d0MVqBkmCXx54u0M7sTM=
X-Google-Smtp-Source: ABdhPJxgmmMdDZOoGx56IPSJxwzZXhR4Xvhtmib4YqV6Npt1VDzjIiJYxCogffB9awxvQrNQyPGjOQ==
X-Received: by 2002:a92:6d07:: with SMTP id i7mr1304876ilc.104.1627638523996;
        Fri, 30 Jul 2021 02:48:43 -0700 (PDT)
Received: from auth1-smtp.messagingengine.com (auth1-smtp.messagingengine.com. [66.111.4.227])
        by smtp.gmail.com with ESMTPSA id h24sm798321ioj.32.2021.07.30.02.48.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Jul 2021 02:48:43 -0700 (PDT)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailauth.nyi.internal (Postfix) with ESMTP id 97DF027C005B;
        Fri, 30 Jul 2021 05:48:41 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Fri, 30 Jul 2021 05:48:42 -0400
X-ME-Sender: <xms:98oDYfw4AIGZbkS-15cy227JnO3H-m6lbq6sXeZza_9OXFO16dM7Uw>
    <xme:98oDYXTHkHiKDEEwMOxRPwCBZHz2q64175IadKG0h4ZWmgDDo8dS2Br6r9Gbd0zSM
    Hsw70UoclqQaWCm_w>
X-ME-Received: <xmr:98oDYZV8J9c4xAT4ACTVFtzlN9WawQW2kiHbgf_4bt14T7MnMZL8ZBnv7lQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvtddrheehgdduiecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhepfffhvffukfhfgggtuggjsehttdertd
    dttddvnecuhfhrohhmpeeuohhquhhnucfhvghnghcuoegsohhquhhnrdhfvghnghesghhm
    rghilhdrtghomheqnecuggftrfgrthhtvghrnhepvdelieegudfggeevjefhjeevueevie
    etjeeikedvgfejfeduheefhffggedvgeejnecuvehluhhsthgvrhfuihiivgeptdenucfr
    rghrrghmpehmrghilhhfrhhomhepsghoqhhunhdomhgvshhmthhprghuthhhphgvrhhsoh
    hnrghlihhthidqieelvdeghedtieegqddujeejkeehheehvddqsghoqhhunhdrfhgvnhhg
    peepghhmrghilhdrtghomhesfhhigihmvgdrnhgrmhgv
X-ME-Proxy: <xmx:98oDYZhV_Wnjolu2Qy95wo79oqSS5lE3XQTM8Ol2m8bMVaqOts9Z8A>
    <xmx:98oDYRDGJ7Cum_44BwPjI6WevrZxs0rqIRNbEkt3BJJZT0leahDYuA>
    <xmx:98oDYSJRiLRSNPa1TkG5WLMkG_GQfkbsW3Sdq89uTtppJ3QC-JqxVg>
    <xmx:-coDYZZHDQ2qHuklUAYcrdl0qGUPXzbafW6xSCHzefYmpGT8u95JXTlgOCQ>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 30 Jul 2021 05:48:39 -0400 (EDT)
Date:   Fri, 30 Jul 2021 17:48:14 +0800
From:   Boqun Feng <boqun.feng@gmail.com>
To:     Desmond Cheong Zhi Xi <desmondcheongzx@gmail.com>
Cc:     maarten.lankhorst@linux.intel.com, mripard@kernel.org,
        tzimmermann@suse.de, airlied@linux.ie, daniel@ffwll.ch,
        peterz@infradead.org, mingo@redhat.com, will@kernel.org,
        longman@redhat.com, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, skhan@linuxfoundation.org,
        gregkh@linuxfoundation.org,
        linux-kernel-mentees@lists.linuxfoundation.org
Subject: Re: [PATCH 2/2] drm: add lockdep assert to
 drm_is_current_master_locked
Message-ID: <YQPK3jMU69WMsCjT@boqun-archlinux>
References: <20210730041515.1430237-1-desmondcheongzx@gmail.com>
 <20210730041515.1430237-3-desmondcheongzx@gmail.com>
 <YQOXTW8kSHdNjhiY@boqun-archlinux>
 <35518f4b-5e4a-b284-1f86-5cba64941211@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <35518f4b-5e4a-b284-1f86-5cba64941211@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 30, 2021 at 04:06:44PM +0800, Desmond Cheong Zhi Xi wrote:
> On 30/7/21 2:08 pm, Boqun Feng wrote:
> > On Fri, Jul 30, 2021 at 12:15:15PM +0800, Desmond Cheong Zhi Xi wrote:
> > > In drm_is_current_master_locked, accessing drm_file.master should be
> > > protected by either drm_file.master_lookup_lock or
> > > drm_device.master_mutex. This was previously awkward to assert with
> > > lockdep.
> > > 
> > > Following patch ("locking/lockdep: Provide lockdep_assert{,_once}()
> > > helpers"), this assertion is now convenient so we add it in.
> > > 
> > > Signed-off-by: Desmond Cheong Zhi Xi <desmondcheongzx@gmail.com>
> > > ---
> > >   drivers/gpu/drm/drm_auth.c | 6 +++---
> > >   1 file changed, 3 insertions(+), 3 deletions(-)
> > > 
> > > diff --git a/drivers/gpu/drm/drm_auth.c b/drivers/gpu/drm/drm_auth.c
> > > index 9c24b8cc8e36..6f4d7ff23c80 100644
> > > --- a/drivers/gpu/drm/drm_auth.c
> > > +++ b/drivers/gpu/drm/drm_auth.c
> > > @@ -63,9 +63,9 @@
> > >   static bool drm_is_current_master_locked(struct drm_file *fpriv)
> > >   {
> > > -	/* Either drm_device.master_mutex or drm_file.master_lookup_lock
> > > -	 * should be held here.
> > > -	 */
> > > +	lockdep_assert_once(lockdep_is_held(&fpriv->master_lookup_lock) ||
> > > +			    lockdep_is_held(&fpriv->minor->dev->master_mutex));
> > > +
> > 
> > I think it's better to also add the lockdep_assert() of & (i.e. both
> > held) in the updater side, and have comments pointing to each other.
> > 
> > Is it convenient to do in this patchset? If the updater side doesn't
> > need to put the lockdep_assert() (maybe the lock acquire code and the
> > update code are in the same function), it's still better to add some
> 
> Thanks for the feedback, Boqun.
> 
> Yeah, I think the updater side maybe doesn't need new lockdep_assert()
> because what currently happens is either
> 
> 	lockdep_assert_held_once(&dev->master_mutex);
> 	/* 6 lines of prep */
> 	spin_lock(&fpriv->master_lookup_lock);
> 	fpriv->master = new_value;
> or
> 	mutex_lock(&dev->master_mutex);
> 	/* 3 lines of checks */
> 		spin_lock(&file_priv->master_lookup_lock);
> 		file_priv->master = new_value;
> 
> > comments like:
> > 
> > 	/*
> > 	 * To update drm_file.master, both drm_file.master_lookup_lock
> > 	 * and drm_device.master_mutex are needed, therefore holding
> > 	 * either of them is safe and enough for the read side.
> > 	 */
> > 
> > Just feel it's better to explain the lock design either in the
> > lockdep_assert() or comments.
> > 
> 
> But clarifying the lock design in the documentation sounds like a really
> good idea.
> 
> Probably a good place for this would be in the kerneldoc where we also
> explain the lifetime rules and usage of the pointer outside drm_auth.c:
> 
> diff --git a/include/drm/drm_file.h b/include/drm/drm_file.h
> index 726cfe0ff5f5..a3acb7ac3550 100644
> --- a/include/drm/drm_file.h
> +++ b/include/drm/drm_file.h
> @@ -233,6 +233,10 @@ struct drm_file {
>  	 * this only matches &drm_device.master if the master is the currently
>  	 * active one.
>  	 *
> +	 * To update @master, both &drm_device.master_mutex and
> +	 * @master_lookup_lock need to be held, therefore holding either of
> +	 * them is safe and enough for the read side.
> +	 *
>  	 * When dereferencing this pointer, either hold struct
>  	 * &drm_device.master_mutex for the duration of the pointer's use, or
>  	 * use drm_file_get_master() if struct &drm_device.master_mutex is not

Works for me ;-)

For the whole series, feel free to add:

Acked-by: Boqun Feng <boqun.feng@gmail.com>

Regards,
Boqun

> 
> Best wishes,
> Desmond
> 
> > Regards,
> > Boqun
> > 
> > >   	return fpriv->is_master && drm_lease_owner(fpriv->master) == fpriv->minor->dev->master;
> > >   }
> > > -- 
> > > 2.25.1
> > > 
> 
