Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 931DA417AC7
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Sep 2021 20:16:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348016AbhIXSSV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Sep 2021 14:18:21 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:42936 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230479AbhIXSSU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Sep 2021 14:18:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1632507406;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/XZTO3hQwEUw1n5k6UDpdYw7oKmrhKHOCU0IGHqWWG0=;
        b=Q/donNFbF5j55ft1sBW0Ggd4ZeidXuvdrOrqtoKLtHq19ZqRjaAkuPUcDKtEWUaxQbvGF/
        H/cu1G0SVUCD1owlvefNfMMtTIqQ6qQuqlVsH9uIZ3SL3EltDDYKvA5qxWwJWnunzKbFpU
        x7nws+gaqVriG9f2ngqbBL0+yaalgsg=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-427-AnhPpDhuNc27L3nkjyXTuA-1; Fri, 24 Sep 2021 14:16:45 -0400
X-MC-Unique: AnhPpDhuNc27L3nkjyXTuA-1
Received: by mail-qv1-f69.google.com with SMTP id h25-20020a0cab19000000b0037a49d15c93so35745303qvb.22
        for <linux-kernel@vger.kernel.org>; Fri, 24 Sep 2021 11:16:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:organization:user-agent:mime-version
         :content-transfer-encoding;
        bh=/XZTO3hQwEUw1n5k6UDpdYw7oKmrhKHOCU0IGHqWWG0=;
        b=SDk+UUrCiSWPnIB6nJDdrzUv0Ka4/86R9wxE2G3MKTBx6blVpWiBMXrC9tu20h8H79
         ArHom9XU+qd1nHf22Y9Hjh/wZ4djUkE0/7qJWgG/AiF/BGg0aW72QmdA5kSLei7imbIV
         Ds8ZsuVv7AQdo8Rsl92tPT0TPwCL75GryNGNhAp2F8TgyV5E/Xyb5L06jkE1QFgAlFK8
         Iv2iYlH0KcrVEg0RcdNDtfChhvmj4HOnOqFZGEWVUxWS3f3Ic+vvKCpsulAvDyzxTEJK
         bkyoURVt2NLpofv/tF31m3gKkpEKKhbMKdg9di6yAiM9BlwjlRUtH0kMYnZ8Z+Q3z7k5
         c2wA==
X-Gm-Message-State: AOAM530heQ21ItZk2nKCLtCppXZ/3uBaWIjNLghsHPvg5AjofffqFwNs
        dDw9gjncVW7hEOnbC54Hmh/vqxX0kXDa+JI1I5vGUwdhJIZF6u7jKk8AfaCdQ2kByPQn1xH8gU4
        AH6Jk8bACD9ypGB6umwjxNL5x
X-Received: by 2002:a05:622a:1a9f:: with SMTP id s31mr5659451qtc.381.1632507404613;
        Fri, 24 Sep 2021 11:16:44 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzlyHyj1JScPlhqV3UkuuS2rTtoAfyZvwyso8AYDYCQEtFhSw4UVAZGBacOTk5lMLbtnXHfhA==
X-Received: by 2002:a05:622a:1a9f:: with SMTP id s31mr5659421qtc.381.1632507404374;
        Fri, 24 Sep 2021 11:16:44 -0700 (PDT)
Received: from [192.168.8.206] (pool-108-49-102-102.bstnma.fios.verizon.net. [108.49.102.102])
        by smtp.gmail.com with ESMTPSA id l7sm6250919qtr.87.2021.09.24.11.16.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Sep 2021 11:16:43 -0700 (PDT)
Message-ID: <7d19a626299fcc23e10678faea95b76d71c26b23.camel@redhat.com>
Subject: Re: [RFC PATCH] drm/print: Add deprecation notes to DRM_...()
 functions
From:   Lyude Paul <lyude@redhat.com>
To:     Thomas Zimmermann <tzimmermann@suse.de>,
        Douglas Anderson <dianders@chromium.org>,
        dri-devel@lists.freedesktop.org
Cc:     sam@ravnborg.org, daniel.vetter@ffwll.ch, jani.nikula@intel.com,
        swboyd@chromium.org, airlied@redhat.com,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        linux-kernel@vger.kernel.org
Date:   Fri, 24 Sep 2021 14:16:42 -0400
In-Reply-To: <2b957783-aa5c-33a5-7fe3-475d5a80bacc@suse.de>
References: <20210921082757.RFC.1.Ibd82d98145615fa55f604947dc6a696cc82e8e43@changeid>
         <2b957783-aa5c-33a5-7fe3-475d5a80bacc@suse.de>
Organization: Red Hat
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.40.4 (3.40.4-1.fc34) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Acked-by: Lyude Paul <lyude@redhat.com>

On Wed, 2021-09-22 at 09:12 +0200, Thomas Zimmermann wrote:
> Hi
> 
> Am 21.09.21 um 17:28 schrieb Douglas Anderson:
> > It's hard for someone (like me) who's not following closely to know
> > what the suggested best practices are for error printing in DRM
> > drivers. Add some hints to the header file.
> > 
> > In general, my understanding is that:
> > * When possible we should be using a `struct drm_device` for logging
> >    and recent patches have tried to make it more possible to access a
> >    relevant `struct drm_device` in more places.
> > * For most cases when we don't have a `struct drm_device`, we no
> >    longer bother with DRM-specific wrappers on the dev_...() functions
> >    or pr_...() functions and just encourage drivers to use the normal
> >    functions.
> > * For debug-level functions where we might want filtering based on a
> >    category we'll still have DRM-specific wrappers, but we'll only
> >    support passing a `struct drm_device`, not a `struct
> >    device`. Presumably most of the cases where we want the filtering
> >    are messages that happen while the system is in a normal running
> >    state (AKA not during probe time) and we should have a `struct
> >    drm_device` then. If we absolutely can't get a `struct drm_device`
> >    then these functions begrudgingly accept NULL for the `struct
> >    drm_device` and hopefully the awkwardness of having to manually pass
> >    NULL will keep people from doing this unless absolutely necessary.
> > 
> > Signed-off-by: Douglas Anderson <dianders@chromium.org>
> 
> Acked-by: Thomas Zimmermann <tzimmermann@suse.de>
> 
> Thanks a lot.
> 
> > ---
> > 
> >   include/drm/drm_print.h | 30 ++++++++++++++++++++++++++++++
> >   1 file changed, 30 insertions(+)
> > 
> > diff --git a/include/drm/drm_print.h b/include/drm/drm_print.h
> > index 15a089a87c22..22fabdeed297 100644
> > --- a/include/drm/drm_print.h
> > +++ b/include/drm/drm_print.h
> > @@ -340,6 +340,8 @@ void drm_dev_dbg(const struct device *dev, enum
> > drm_debug_category category,
> >   /**
> >    * DRM_DEV_ERROR() - Error output.
> >    *
> > + * NOTE: this is deprecated in favor of drm_err() or dev_err().
> > + *
> >    * @dev: device pointer
> >    * @fmt: printf() like format string.
> >    */
> > @@ -349,6 +351,9 @@ void drm_dev_dbg(const struct device *dev, enum
> > drm_debug_category category,
> >   /**
> >    * DRM_DEV_ERROR_RATELIMITED() - Rate limited error output.
> >    *
> > + * NOTE: this is deprecated in favor of drm_err_ratelimited() or
> > + * dev_err_ratelimited().
> > + *
> >    * @dev: device pointer
> >    * @fmt: printf() like format string.
> >    *
> > @@ -364,9 +369,11 @@ void drm_dev_dbg(const struct device *dev, enum
> > drm_debug_category category,
> >                 DRM_DEV_ERROR(dev, fmt, ##__VA_ARGS__);                 \
> >   })
> >   
> > +/* NOTE: this is deprecated in favor of drm_info() or dev_info(). */
> >   #define DRM_DEV_INFO(dev, fmt, ...)                           \
> >         drm_dev_printk(dev, KERN_INFO, fmt, ##__VA_ARGS__)
> >   
> > +/* NOTE: this is deprecated in favor of drm_info_once() or
> > dev_info_once(). */
> >   #define DRM_DEV_INFO_ONCE(dev, fmt, ...)                              \
> >   ({                                                                    \
> >         static bool __print_once __read_mostly;                         \
> > @@ -379,6 +386,8 @@ void drm_dev_dbg(const struct device *dev, enum
> > drm_debug_category category,
> >   /**
> >    * DRM_DEV_DEBUG() - Debug output for generic drm code
> >    *
> > + * NOTE: this is deprecated in favor of drm_dbg_core().
> > + *
> >    * @dev: device pointer
> >    * @fmt: printf() like format string.
> >    */
> > @@ -387,6 +396,8 @@ void drm_dev_dbg(const struct device *dev, enum
> > drm_debug_category category,
> >   /**
> >    * DRM_DEV_DEBUG_DRIVER() - Debug output for vendor specific part of the
> > driver
> >    *
> > + * NOTE: this is deprecated in favor of drm_dbg() or dev_dbg().
> > + *
> >    * @dev: device pointer
> >    * @fmt: printf() like format string.
> >    */
> > @@ -395,6 +406,8 @@ void drm_dev_dbg(const struct device *dev, enum
> > drm_debug_category category,
> >   /**
> >    * DRM_DEV_DEBUG_KMS() - Debug output for modesetting code
> >    *
> > + * NOTE: this is deprecated in favor of drm_dbg_kms().
> > + *
> >    * @dev: device pointer
> >    * @fmt: printf() like format string.
> >    */
> > @@ -480,47 +493,63 @@ void __drm_err(const char *format, ...);
> >   #define _DRM_PRINTK(once, level, fmt, ...)                            \
> >         printk##once(KERN_##level "[" DRM_NAME "] " fmt, ##__VA_ARGS__)
> >   
> > +/* NOTE: this is deprecated in favor of pr_info(). */
> >   #define DRM_INFO(fmt, ...)                                            \
> >         _DRM_PRINTK(, INFO, fmt, ##__VA_ARGS__)
> > +/* NOTE: this is deprecated in favor of pr_notice(). */
> >   #define DRM_NOTE(fmt, ...)                                            \
> >         _DRM_PRINTK(, NOTICE, fmt, ##__VA_ARGS__)
> > +/* NOTE: this is deprecated in favor of pr_warn(). */
> >   #define DRM_WARN(fmt, ...)                                            \
> >         _DRM_PRINTK(, WARNING, fmt, ##__VA_ARGS__)
> >   
> > +/* NOTE: this is deprecated in favor of pr_info_once(). */
> >   #define DRM_INFO_ONCE(fmt,
> > ...)                                               \
> >         _DRM_PRINTK(_once, INFO, fmt, ##__VA_ARGS__)
> > +/* NOTE: this is deprecated in favor of pr_notice_once(). */
> >   #define DRM_NOTE_ONCE(fmt,
> > ...)                                               \
> >         _DRM_PRINTK(_once, NOTICE, fmt, ##__VA_ARGS__)
> > +/* NOTE: this is deprecated in favor of pr_warn_once(). */
> >   #define DRM_WARN_ONCE(fmt,
> > ...)                                               \
> >         _DRM_PRINTK(_once, WARNING, fmt, ##__VA_ARGS__)
> >   
> > +/* NOTE: this is deprecated in favor of pr_err(). */
> >   #define DRM_ERROR(fmt, ...)                                           \
> >         __drm_err(fmt, ##__VA_ARGS__)
> >   
> > +/* NOTE: this is deprecated in favor of pr_err_ratelimited(). */
> >   #define DRM_ERROR_RATELIMITED(fmt,
> > ...)                                       \
> >         DRM_DEV_ERROR_RATELIMITED(NULL, fmt, ##__VA_ARGS__)
> >   
> > +/* NOTE: this is deprecated in favor of drm_dbg_core(NULL, ...). */
> >   #define DRM_DEBUG(fmt, ...)                                           \
> >         __drm_dbg(DRM_UT_CORE, fmt, ##__VA_ARGS__)
> >   
> > +/* NOTE: this is deprecated in favor of drm_dbg(NULL, ...). */
> >   #define DRM_DEBUG_DRIVER(fmt, ...)                                    \
> >         __drm_dbg(DRM_UT_DRIVER, fmt, ##__VA_ARGS__)
> >   
> > +/* NOTE: this is deprecated in favor of drm_dbg_kms(NULL, ...). */
> >   #define DRM_DEBUG_KMS(fmt,
> > ...)                                               \
> >         __drm_dbg(DRM_UT_KMS, fmt, ##__VA_ARGS__)
> >   
> > +/* NOTE: this is deprecated in favor of drm_dbg_prime(NULL, ...). */
> >   #define DRM_DEBUG_PRIME(fmt, ...)                                     \
> >         __drm_dbg(DRM_UT_PRIME, fmt, ##__VA_ARGS__)
> >   
> > +/* NOTE: this is deprecated in favor of drm_dbg_atomic(NULL, ...). */
> >   #define DRM_DEBUG_ATOMIC(fmt, ...)                                    \
> >         __drm_dbg(DRM_UT_ATOMIC, fmt, ##__VA_ARGS__)
> >   
> > +/* NOTE: this is deprecated in favor of drm_dbg_vbl(NULL, ...). */
> >   #define DRM_DEBUG_VBL(fmt,
> > ...)                                               \
> >         __drm_dbg(DRM_UT_VBL, fmt, ##__VA_ARGS__)
> >   
> > +/* NOTE: this is deprecated in favor of drm_dbg_lease(NULL, ...). */
> >   #define DRM_DEBUG_LEASE(fmt, ...)                                     \
> >         __drm_dbg(DRM_UT_LEASE, fmt, ##__VA_ARGS__)
> >   
> > +/* NOTE: this is deprecated in favor of drm_dbg_dp(NULL, ...). */
> >   #define DRM_DEBUG_DP(fmt,
> > ...)                                                \
> >         __drm_dbg(DRM_UT_DP, fmt, ## __VA_ARGS__)
> >   
> > @@ -536,6 +565,7 @@ void __drm_err(const char *format, ...);
> >   #define drm_dbg_kms_ratelimited(drm, fmt, ...) \
> >         __DRM_DEFINE_DBG_RATELIMITED(KMS, drm, fmt, ## __VA_ARGS__)
> >   
> > +/* NOTE: this is deprecated in favor of drm_dbg_kms_ratelimited(NULL,
> > ...). */
> >   #define DRM_DEBUG_KMS_RATELIMITED(fmt, ...)
> > drm_dbg_kms_ratelimited(NULL, fmt, ## __VA_ARGS__)
> >   
> >   /*
> > 
> 
> -- 
> Thomas Zimmermann
> Graphics Driver Developer
> SUSE Software Solutions Germany GmbH
> Maxfeldstr. 5, 90409 Nürnberg, Germany
> (HRB 36809, AG Nürnberg)
> Geschäftsführer: Felix Imendörffer

-- 
Cheers,
 Lyude Paul (she/her)
 Software Engineer at Red Hat

