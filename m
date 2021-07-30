Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3447D3DB336
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jul 2021 08:08:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237035AbhG3GIs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Jul 2021 02:08:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236430AbhG3GIr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jul 2021 02:08:47 -0400
Received: from mail-io1-xd31.google.com (mail-io1-xd31.google.com [IPv6:2607:f8b0:4864:20::d31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21D1EC0613C1
        for <linux-kernel@vger.kernel.org>; Thu, 29 Jul 2021 23:08:43 -0700 (PDT)
Received: by mail-io1-xd31.google.com with SMTP id z7so9246899iog.13
        for <linux-kernel@vger.kernel.org>; Thu, 29 Jul 2021 23:08:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=1Ri7dUSHGhZY2tYqQt9WHv9mXFUqQVec2u9T6YNhEc0=;
        b=Hk2KvJDgF8BJlfdnAPgnRP/64Cvj3rjXJWTFLSCoZY/ulCK5cfAHu+GC9R4s7dLjv1
         SXHgg2P9e0oNTWauzALeEwhhgk7/ggHIrfoPq5Hc4GLwG5+674MQaxWTTLZfh8kQYH3u
         wRzKOWzkcViy4HqhhNIDX9GvLhBCGlyUuB3pFZll1Jq/g9fA0sRFvyxYUmn0ysfs+k7e
         kiBLhsEaBtULrp0PPxxD26BqJnbn2pIG1idgl1mwnIqecv6rweC1oMXKtpafQ5lK2wKC
         uc2X/BH7V5R++ZQlwxav7Hgkd044IyHr5yyySjtzMem0IwpJtbVOj6Zi0KOoxJ0vA7uE
         NvFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=1Ri7dUSHGhZY2tYqQt9WHv9mXFUqQVec2u9T6YNhEc0=;
        b=KGNfWaLWLmXTXt5X7Xrmo0vNydzMxiMj+IfcreAwmMv+Sj3qUCA/5QM1bcSfAR5ji1
         FK8jJrjWuYqBtnmYAWzpDGYttc4yfxCrTefEGoO3TocwVbWD2dLG65G3yRoq5l+jIGd2
         haWJJ6n1bhIS5BZeoqSKoJqnu9DB3GV/NE6N9WtaC5Khlz7aIgttDBESpLARkMaVGh1S
         kX8e1wAEpEyHDegWdTqaM43nVMd0xTGCDbQESllxWn3liVpbTckQQFL9P39+uWMaYZKA
         gJJkPZc1pJirBcRCMcxJrwBc09Bgn0FO+Uom3wNlCz10h1VicsoiW+T7CykEw3p+ySEv
         kTWA==
X-Gm-Message-State: AOAM530lxqZIMutVSy+4ZfUsfkchc6XBvNK82SMQva8im3h7Vs3zBRma
        rumSaP1M94RDsgwWbhqFjeeYcEa8JuXaKg==
X-Google-Smtp-Source: ABdhPJyvbk1qFvusNWnTRZMt8D4ZQbtWZ8pYKwuXWyNI5nEsznwSugT2hpZqY56lkSflsl9dw+S/zg==
X-Received: by 2002:a05:6602:218c:: with SMTP id b12mr1100588iob.82.1627625322651;
        Thu, 29 Jul 2021 23:08:42 -0700 (PDT)
Received: from auth2-smtp.messagingengine.com (auth2-smtp.messagingengine.com. [66.111.4.228])
        by smtp.gmail.com with ESMTPSA id k4sm452212ior.55.2021.07.29.23.08.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Jul 2021 23:08:42 -0700 (PDT)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailauth.nyi.internal (Postfix) with ESMTP id 395E327C0054;
        Fri, 30 Jul 2021 02:08:41 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Fri, 30 Jul 2021 02:08:41 -0400
X-ME-Sender: <xms:ZpcDYX-C7wr8cjhSKq4JR-P_97ZSNgD9_wQWx6irRJ39x5GtIfQimg>
    <xme:ZpcDYTvGQo53XeLl4sr-xdEbcbXcZZUO7TO55mP7md2OYlU3JAf6fWah8FqSJly1E
    xqbqyItL8J1wp8AWQ>
X-ME-Received: <xmr:ZpcDYVDBS3A5BU2_dYrIbuMClFiKw-Dyp6Mb--rkumQHs1OOIvgD6vt1tkG0mA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvtddrheeggdekgecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhepfffhvffukfhfgggtuggjsehttdertd
    dttddvnecuhfhrohhmpeeuohhquhhnucfhvghnghcuoegsohhquhhnrdhfvghnghesghhm
    rghilhdrtghomheqnecuggftrfgrthhtvghrnhepvdelieegudfggeevjefhjeevueevie
    etjeeikedvgfejfeduheefhffggedvgeejnecuvehluhhsthgvrhfuihiivgeptdenucfr
    rghrrghmpehmrghilhhfrhhomhepsghoqhhunhdomhgvshhmthhprghuthhhphgvrhhsoh
    hnrghlihhthidqieelvdeghedtieegqddujeejkeehheehvddqsghoqhhunhdrfhgvnhhg
    peepghhmrghilhdrtghomhesfhhigihmvgdrnhgrmhgv
X-ME-Proxy: <xmx:ZpcDYTebkroJ3dzWUOIvs0XyWbp942eAM9EjIsoS9rpxtiqaXlDIPw>
    <xmx:ZpcDYcNE1ywBbw5FlGyFO4BC19vzjqFp3Li20lmyV41WCoGERWuisw>
    <xmx:ZpcDYVkVGn4knw8H1fwjffd7ezjZ8UkP6P4x7Dvms5zWQg5zMiwdDQ>
    <xmx:aZcDYTmd_Kq16_ZsH3d7aQFuM0nmosDdUZiKtxtqfzNuEvMiP7lmXFNzKM0>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 30 Jul 2021 02:08:38 -0400 (EDT)
Date:   Fri, 30 Jul 2021 14:08:13 +0800
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
Message-ID: <YQOXTW8kSHdNjhiY@boqun-archlinux>
References: <20210730041515.1430237-1-desmondcheongzx@gmail.com>
 <20210730041515.1430237-3-desmondcheongzx@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210730041515.1430237-3-desmondcheongzx@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 30, 2021 at 12:15:15PM +0800, Desmond Cheong Zhi Xi wrote:
> In drm_is_current_master_locked, accessing drm_file.master should be
> protected by either drm_file.master_lookup_lock or
> drm_device.master_mutex. This was previously awkward to assert with
> lockdep.
> 
> Following patch ("locking/lockdep: Provide lockdep_assert{,_once}()
> helpers"), this assertion is now convenient so we add it in.
> 
> Signed-off-by: Desmond Cheong Zhi Xi <desmondcheongzx@gmail.com>
> ---
>  drivers/gpu/drm/drm_auth.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/gpu/drm/drm_auth.c b/drivers/gpu/drm/drm_auth.c
> index 9c24b8cc8e36..6f4d7ff23c80 100644
> --- a/drivers/gpu/drm/drm_auth.c
> +++ b/drivers/gpu/drm/drm_auth.c
> @@ -63,9 +63,9 @@
>  
>  static bool drm_is_current_master_locked(struct drm_file *fpriv)
>  {
> -	/* Either drm_device.master_mutex or drm_file.master_lookup_lock
> -	 * should be held here.
> -	 */
> +	lockdep_assert_once(lockdep_is_held(&fpriv->master_lookup_lock) ||
> +			    lockdep_is_held(&fpriv->minor->dev->master_mutex));
> +

I think it's better to also add the lockdep_assert() of & (i.e. both
held) in the updater side, and have comments pointing to each other.

Is it convenient to do in this patchset? If the updater side doesn't
need to put the lockdep_assert() (maybe the lock acquire code and the
update code are in the same function), it's still better to add some
comments like:

	/*
	 * To update drm_file.master, both drm_file.master_lookup_lock
	 * and drm_device.master_mutex are needed, therefore holding
	 * either of them is safe and enough for the read side.
	 */

Just feel it's better to explain the lock design either in the
lockdep_assert() or comments.

Regards,
Boqun

>  	return fpriv->is_master && drm_lease_owner(fpriv->master) == fpriv->minor->dev->master;
>  }
>  
> -- 
> 2.25.1
> 
