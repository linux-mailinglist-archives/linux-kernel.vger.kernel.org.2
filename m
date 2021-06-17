Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9BE263AA9DF
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jun 2021 06:22:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229716AbhFQEYg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Jun 2021 00:24:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbhFQEYe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jun 2021 00:24:34 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9BCDC06175F
        for <linux-kernel@vger.kernel.org>; Wed, 16 Jun 2021 21:22:26 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id p4-20020a17090a9304b029016f3020d867so993429pjo.3
        for <linux-kernel@vger.kernel.org>; Wed, 16 Jun 2021 21:22:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=CrPkgLjFYI9pDTXOpVz36tZTA4Car3owMc7e2HcyHUQ=;
        b=NGJ6Z9DZYKBavzR5sMWG+s5v7qSPUy+DtykG+R89TvWJH2BJy0oFL2qh0eQgdOwWXh
         slSJrXvOj5r3QM/TGoL72kN/AMl7ioI17/LZxSWmJD9cm7NZnobNc/EfTsd79pp+pN19
         2QY2mAdun4w4dhDEjUa+qXtGIrMHvKA7SaX3Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=CrPkgLjFYI9pDTXOpVz36tZTA4Car3owMc7e2HcyHUQ=;
        b=K9aMgb3iobFYfeS4NNgezoViBtGKOfSTNqkKoTpmS/KRFKeLzZ9zB+y1ED4ZoUCF6F
         xov/rvN5DvaYMGb5BaHtSi1dgIiV3jCBqtEAVQeOeXTsw5zeix8iL4vQcYyEiCFci+tz
         AIGtIW9CF6OFmFHj2tmjxSWkCVRWL72HWgWy0tlTv25G5JryLdiIrz7HFqWjlGWH0P3N
         tpSIp4t/UPAlggkFcsb4VFiaExOLyAnG0JN7XBZGs4xIs39kQRCKFua7n7WmxuG3+d0g
         RiIpalX3PpyFBx7yp2jw//oX/v/fAAe5N3u7Hk4A0ueHeQZfO0nU9A9deS+k2Mc//6CT
         rupA==
X-Gm-Message-State: AOAM530WVnGn97w0AIBwUkuILdyY9wyu3FHZm9wJU8pcJb6Sfv1A7Dq/
        vtUieT/5Z0XtseqzI+/XX635Ng==
X-Google-Smtp-Source: ABdhPJxdU10c5lMpAx+co146/isyntZhB47mLDloLf9t234l5Xv+hDh7rnTntKGdDkT+bcXmlFzisg==
X-Received: by 2002:a17:90a:e541:: with SMTP id ei1mr3444120pjb.189.1623903746021;
        Wed, 16 Jun 2021 21:22:26 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id q2sm6988159pje.50.2021.06.16.21.22.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Jun 2021 21:22:24 -0700 (PDT)
Date:   Wed, 16 Jun 2021 21:22:23 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        linux-kernel@vger.kernel.org, linux-media@vger.kernel.org
Subject: Re: [PATCH] media: omap3isp: Extract struct group for memcpy() region
Message-ID: <202106162119.859E9A80B@keescook>
References: <20210616185938.1225218-1-keescook@chromium.org>
 <YMpUR34kFSbiyi+q@pendragon.ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YMpUR34kFSbiyi+q@pendragon.ideasonboard.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 16, 2021 at 10:43:03PM +0300, Laurent Pinchart wrote:
> Hi Kees,
> 
> Thank you for the patch.
> 
> On Wed, Jun 16, 2021 at 11:59:38AM -0700, Kees Cook wrote:
> > Avoid writing past the end of a structure member by wrapping the target
> > region in a common named structure. This additionally fixes a
> > misalignment of the copy (since the size of "buf" changes between 64-bit
> > and 32-bit).
> 
> Could you have been mislead by the data64 name ? The difference between
> omap3isp_stat_data_time and omap3isp_stat_data_time32 is the size of the
> ts field, using 32-bit timestamps with legacy userspace, and 64-bit
> timestamps with more recent userspace. In both cases we're dealing with
> a 32-bit platform, as the omap3isp is not used in any 64-bit ARM SoC.
> The size of void __user *buf is thus 4 bytes in all cases, as is __u32
> buf.

Ah, yes, that's true. I was hitting this on arm64 builds
(CONFIG_COMPILE_TEST) where __user *buf is 64-bit. So, the "additionally
fixes" bit above is misleading in the sense that nothing was ever built
in the real world like that.

The patch still fixes the compile-time warnings, though.

However, I don't think anything actually uses any of this code
regardless. ;)

-Kees

> 
> > I actually think this code is completely unused in the real world:
> > I don't think it could have ever worked, as it would either always
> > fail (with an uninitialized data->buf_size) or would cause corruption
> > in userspace due to the copy_to_user() in the call path against an
> > uninitialized data->buf value:
> > 
> > omap3isp_stat_request_statistics_time32(...)
> >     struct omap3isp_stat_data data64;
> >     ...
> >     omap3isp_stat_request_statistics(stat, &data64);
> > 
> > int omap3isp_stat_request_statistics(struct ispstat *stat,
> >                                      struct omap3isp_stat_data *data)
> >     ...
> >     buf = isp_stat_buf_get(stat, data);
> > 
> > static struct ispstat_buffer *isp_stat_buf_get(struct ispstat *stat,
> >                                                struct omap3isp_stat_data *data)
> > ...
> >     if (buf->buf_size > data->buf_size) {
> >             ...
> >             return ERR_PTR(-EINVAL);
> >     }
> >     ...
> >     rval = copy_to_user(data->buf,
> >                         buf->virt_addr,
> >                         buf->buf_size);
> > 
> > Regardless, additionally initialize data64 to be zero-filled to avoid
> > undefined behavior.
> > 
> > Fixes: 378e3f81cb56 ("media: omap3isp: support 64-bit version of omap3isp_stat_data")
> > Signed-off-by: Kees Cook <keescook@chromium.org>
> > ---
> >  drivers/media/platform/omap3isp/ispstat.c |  5 +--
> >  include/uapi/linux/omap3isp.h             | 44 +++++++++++++++++------
> >  2 files changed, 36 insertions(+), 13 deletions(-)
> > 
> > diff --git a/drivers/media/platform/omap3isp/ispstat.c b/drivers/media/platform/omap3isp/ispstat.c
> > index 5b9b57f4d9bf..ea8222fed38e 100644
> > --- a/drivers/media/platform/omap3isp/ispstat.c
> > +++ b/drivers/media/platform/omap3isp/ispstat.c
> > @@ -512,7 +512,7 @@ int omap3isp_stat_request_statistics(struct ispstat *stat,
> >  int omap3isp_stat_request_statistics_time32(struct ispstat *stat,
> >  					struct omap3isp_stat_data_time32 *data)
> >  {
> > -	struct omap3isp_stat_data data64;
> > +	struct omap3isp_stat_data data64 = { };
> >  	int ret;
> >  
> >  	ret = omap3isp_stat_request_statistics(stat, &data64);
> > @@ -521,7 +521,8 @@ int omap3isp_stat_request_statistics_time32(struct ispstat *stat,
> >  
> >  	data->ts.tv_sec = data64.ts.tv_sec;
> >  	data->ts.tv_usec = data64.ts.tv_usec;
> > -	memcpy(&data->buf, &data64.buf, sizeof(*data) - sizeof(data->ts));
> > +	data->buf = (uintptr_t)data64.buf;
> > +	memcpy(&data->frame, &data64.buf, sizeof(data->frame));
> >  
> >  	return 0;
> >  }
> > diff --git a/include/uapi/linux/omap3isp.h b/include/uapi/linux/omap3isp.h
> > index 87b55755f4ff..0a16af91621f 100644
> > --- a/include/uapi/linux/omap3isp.h
> > +++ b/include/uapi/linux/omap3isp.h
> > @@ -159,13 +159,25 @@ struct omap3isp_h3a_aewb_config {
> >  };
> >  
> >  /**
> > - * struct omap3isp_stat_data - Statistic data sent to or received from user
> > - * @ts: Timestamp of returned framestats.
> > - * @buf: Pointer to pass to user.
> > + * struct omap3isp_stat_frame - Statistic data without timestamp nor pointer.
> > + * @buf_size: Size of buffer.
> >   * @frame_number: Frame number of requested stats.
> >   * @cur_frame: Current frame number being processed.
> >   * @config_counter: Number of the configuration associated with the data.
> >   */
> > +struct omap3isp_stat_frame {
> > +	__u32 buf_size;
> > +	__u16 frame_number;
> > +	__u16 cur_frame;
> > +	__u16 config_counter;
> > +};
> > +
> > +/**
> > + * struct omap3isp_stat_data - Statistic data sent to or received from user
> > + * @ts: Timestamp of returned framestats.
> > + * @buf: Pointer to pass to user.
> > + * @frame: Statistic data for frame.
> > + */
> >  struct omap3isp_stat_data {
> >  #ifdef __KERNEL__
> >  	struct {
> > @@ -176,10 +188,15 @@ struct omap3isp_stat_data {
> >  	struct timeval ts;
> >  #endif
> >  	void __user *buf;
> > -	__u32 buf_size;
> > -	__u16 frame_number;
> > -	__u16 cur_frame;
> > -	__u16 config_counter;
> > +	union {
> > +		struct {
> > +			__u32 buf_size;
> > +			__u16 frame_number;
> > +			__u16 cur_frame;
> > +			__u16 config_counter;
> > +		};
> > +		struct omap3isp_stat_frame frame;
> > +	};
> >  };
> >  
> >  #ifdef __KERNEL__
> > @@ -189,10 +206,15 @@ struct omap3isp_stat_data_time32 {
> >  		__s32	tv_usec;
> >  	} ts;
> >  	__u32 buf;
> > -	__u32 buf_size;
> > -	__u16 frame_number;
> > -	__u16 cur_frame;
> > -	__u16 config_counter;
> > +	union {
> > +		struct {
> > +			__u32 buf_size;
> > +			__u16 frame_number;
> > +			__u16 cur_frame;
> > +			__u16 config_counter;
> > +		};
> > +		struct omap3isp_stat_frame frame;
> > +	};
> >  };
> >  #endif
> >  
> 
> -- 
> Regards,
> 
> Laurent Pinchart

-- 
Kees Cook
