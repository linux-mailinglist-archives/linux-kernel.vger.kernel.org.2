Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4A7FF3243CF
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Feb 2021 19:34:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234641AbhBXSdM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Feb 2021 13:33:12 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:42894 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232767AbhBXSdE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Feb 2021 13:33:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1614191496;
        h=from:from:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+/gCQg/tEM71zxcoR7zjR5gmsskJ0eZ/dRc7gd53l/g=;
        b=YUUMsE4/zk59pfUiom4zfPmPMdS6qturAC7MzZrIL3Jq8gvFDQBvrvJluOF9eaJeDts40W
        PPO2rxEfnk2OReTll1McgopPauLoz1hNLMtXsdenpfvW4YjXyLICac8lVZeLXiRv47XXqM
        U0UOWt7UQvwJgkWODqYxplkOeS8FJdw=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-470-FaypFFVrNtiMmwqTgIqM8A-1; Wed, 24 Feb 2021 13:31:34 -0500
X-MC-Unique: FaypFFVrNtiMmwqTgIqM8A-1
Received: by mail-qk1-f198.google.com with SMTP id u14so2468240qke.14
        for <linux-kernel@vger.kernel.org>; Wed, 24 Feb 2021 10:31:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:reply-to:to:cc:date
         :in-reply-to:references:organization:user-agent:mime-version
         :content-transfer-encoding;
        bh=+/gCQg/tEM71zxcoR7zjR5gmsskJ0eZ/dRc7gd53l/g=;
        b=bNMqpYdV1MKRKsHVaHglr4f/xMwKb/CusEK9CHodlIV+dM3GMGm591poYvrpZBlA9f
         vklGZP5e3v6BqFh3qi5Ty5CXq5kvgQZkdUMSY3tGhDIraovRCMXrzAnQ0Yt8Cm5EpkEO
         CxYTmCNsfDGMxjEbLrWCPjbuCajOAuXCLktCe14HxlewSS+CklU9CVZ+XzZbi6o3VgXr
         e/RPPUIYgr7hr/HUoRo8hWdfml8sbY4/Nt9X6AB4drbS1sa5M0t+kNP1pWzUc/SI6ZY5
         CZlvCcy/yg6F2P8J66Yiacz4320iZJJJwmmNlggkATEOjToAiOd6ZCSIfpL33t6+wq/t
         pQDA==
X-Gm-Message-State: AOAM5339IH4a9nWU7HNH/wm37Nhz6r/ifQViLvFutjB+MY+EsduO8uix
        A8Ic73Y4Gc4FBkAIqBj6a91EsLLTEzJ2KrOfmsDVgr/sR0EkUCvMr8S1t3xoT63Y6w/hPxy6KG0
        P0V2P+8EFVnu5KRcBRjixwv5C
X-Received: by 2002:a37:4e04:: with SMTP id c4mr33312008qkb.340.1614191493637;
        Wed, 24 Feb 2021 10:31:33 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwW9RlbVM9pqZTZ8CABHHXQBMB2R40gfT6GhFa2haWyMC4079fPiV1sq4fr+b91tAm6uQeTbA==
X-Received: by 2002:a37:4e04:: with SMTP id c4mr33311985qkb.340.1614191493402;
        Wed, 24 Feb 2021 10:31:33 -0800 (PST)
Received: from Whitewolf.lyude.net (pool-108-49-102-102.bstnma.fios.verizon.net. [108.49.102.102])
        by smtp.gmail.com with ESMTPSA id r3sm2123793qkm.129.2021.02.24.10.31.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Feb 2021 10:31:32 -0800 (PST)
Message-ID: <aea7945a0a481046b3ab73950e71b11a39ad7a81.camel@redhat.com>
Subject: Re: [PATCH 01/30] drm/dp: Rewrap kdocs for struct drm_dp_aux
From:   Lyude Paul <lyude@redhat.com>
Reply-To: lyude@redhat.com
To:     Randy Dunlap <rdunlap@infradead.org>,
        intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        amd-gfx@lists.freedesktop.org, nouveau@lists.freedesktop.org,
        Ville =?ISO-8859-1?Q?Syrj=E4l=E4?= 
        <ville.syrjala@linux.intel.com>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Thomas Zimmermann <tzimmermann@suse.de>
Cc:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        open list <linux-kernel@vger.kernel.org>
Date:   Wed, 24 Feb 2021 13:31:31 -0500
In-Reply-To: <712dc0c3-8ef3-ae3a-8838-93276529dff7@infradead.org>
References: <20210219215326.2227596-1-lyude@redhat.com>
         <20210219215326.2227596-2-lyude@redhat.com>
         <712dc0c3-8ef3-ae3a-8838-93276529dff7@infradead.org>
Organization: Red Hat
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.4 (3.38.4-1.fc33) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2021-02-19 at 15:42 -0800, Randy Dunlap wrote:
> On 2/19/21 1:52 PM, Lyude Paul wrote:
> > Since we're about to be adding some more fields and update this
> > documentation, let's rewrap it to the new column limit of 100 beforehand.
> > No actual doc or functional changes are made here.
> > 
> 
> The preferred column limit is still 80.
> For some (exceptional) cases, going up to 100 is OK,
> but I don't see any reason here to go beyond 80.

Found some posts online that discussed this in detail:

https://linux.slashdot.org/story/20/05/31/211211/linus-torvalds-argues-against-80-column-line-length-coding-style-as-linux-kernel-deprecates-it

so I guess I'm fine with rewrapping these to 80 cols (although honestly, it'd be
really nice to just have a single col limit to make things easier on text
editors :) in the next respin.


> Signed-off-by: Lyude Paul <lyude@redhat.com>
> ---
>  include/drm/drm_dp_helper.h | 42 ++++++++++++++++---------------------
>  1 file changed, 18 insertions(+), 24 deletions(-)
> 
> diff --git a/include/drm/drm_dp_helper.h b/include/drm/drm_dp_helper.h
> index edffd1dcca3e..2891a98eebc8 100644
> --- a/include/drm/drm_dp_helper.h
> +++ b/include/drm/drm_dp_helper.h
> @@ -1839,34 +1839,28 @@ struct drm_dp_aux_cec {
>   * @crc_count: counter of captured frame CRCs
>   * @transfer: transfers a message representing a single AUX transaction
>   *
> - * The .dev field should be set to a pointer to the device that implements
> - * the AUX channel.
> + * The .dev field should be set to a pointer to the device that implements
> the AUX channel.
>   *
> - * The .name field may be used to specify the name of the I2C adapter. If set
> to
> - * NULL, dev_name() of .dev will be used.
> + * The .name field may be used to specify the name of the I2C adapter. If set
> to NULL, dev_name() of
> + * .dev will be used.
>   *
> - * Drivers provide a hardware-specific implementation of how transactions
> - * are executed via the .transfer() function. A pointer to a drm_dp_aux_msg
> - * structure describing the transaction is passed into this function. Upon
> - * success, the implementation should return the number of payload bytes
> - * that were transferred, or a negative error-code on failure. Helpers
> - * propagate errors from the .transfer() function, with the exception of
> - * the -EBUSY error, which causes a transaction to be retried. On a short,
> - * helpers will return -EPROTO to make it simpler to check for failure.
> + * Drivers provide a hardware-specific implementation of how transactions are
> executed via the
> + * .transfer() function. A pointer to a drm_dp_aux_msg structure describing
> the transaction is
> + * passed into this function. Upon success, the implementation should return
> the number of payload
> + * bytes that were transferred, or a negative error-code on failure. Helpers
> propagate errors from
> + * the .transfer() function, with the exception of the -EBUSY error, which
> causes a transaction to
> + * be retried. On a short, helpers will return -EPROTO to make it simpler to
> check for failure.
>   *
> - * An AUX channel can also be used to transport I2C messages to a sink. A
> - * typical application of that is to access an EDID that's present in the
> - * sink device. The .transfer() function can also be used to execute such
> - * transactions. The drm_dp_aux_register() function registers an I2C
> - * adapter that can be passed to drm_probe_ddc(). Upon removal, drivers
> - * should call drm_dp_aux_unregister() to remove the I2C adapter.
> - * The I2C adapter uses long transfers by default; if a partial response is
> - * received, the adapter will drop down to the size given by the partial
> - * response for this transaction only.
> + * An AUX channel can also be used to transport I2C messages to a sink. A
> typical application of
> + * that is to access an EDID that's present in the sink device. The
> .transfer() function can also be
> + * used to execute such transactions. The drm_dp_aux_register() function
> registers an I2C adapter
> + * that can be passed to drm_probe_ddc(). Upon removal, drivers should call
> drm_dp_aux_unregister()
> + * to remove the I2C adapter. The I2C adapter uses long transfers by default;
> if a partial response
> + * is received, the adapter will drop down to the size given by the partial
> response for this
> + * transaction only.
>   *
> - * Note that the aux helper code assumes that the .transfer() function
> - * only modifies the reply field of the drm_dp_aux_msg structure.  The
> - * retry logic and i2c helpers assume this is the case.
> + * Note that the aux helper code assumes that the .transfer() function only
> modifies the reply field
> + * of the drm_dp_aux_msg structure. The retry logic and i2c helpers assume
> this is the case.
>   */
>  struct drm_dp_aux {
>         const char *name;
> 




-- 
Sincerely,
   Lyude Paul (she/her)
   Software Engineer at Red Hat
   
Note: I deal with a lot of emails and have a lot of bugs on my plate. If you've
asked me a question, are waiting for a review/merge on a patch, etc. and I
haven't responded in a while, please feel free to send me another email to check
on my status. I don't bite!

