Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D22513DF3F0
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Aug 2021 19:29:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238228AbhHCR36 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Aug 2021 13:29:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238204AbhHCR35 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Aug 2021 13:29:57 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AB66C061757
        for <linux-kernel@vger.kernel.org>; Tue,  3 Aug 2021 10:29:45 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id k4-20020a17090a5144b02901731c776526so4855643pjm.4
        for <linux-kernel@vger.kernel.org>; Tue, 03 Aug 2021 10:29:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Pm6SXOly+uNnAByxJnoAewZoxTAQStsO1EpbLNKxcWA=;
        b=E7bH5OpRyrGcvLDuarlwVod9a4qZK971yFXYN3jywsvL3bwfys8jQJdhfliJeOod1a
         nf8z/EYuc6xGtfGonTxoN7abw3WzVS+2pkUCRg1dr8L9CUTY5rMU7YE6o7MLbS5nhFWb
         aZv6+QB+5H8PFGCqMHVCI4DlxaWA8QpYN0faM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Pm6SXOly+uNnAByxJnoAewZoxTAQStsO1EpbLNKxcWA=;
        b=M15ENp9+huha9X1JuPN5bZz3IRDokZWbgkSUZobvoIY15NwOvs8fG6rHPWmCO3jnjQ
         lxFfNUHVa5V8qVmRKaaiTqI5OV4Xc6LDj3qpUbmrG24s5fxOAc/8z6tw4wPlf6utPlIE
         TNPmP+wPOY1ISh1Wj8OuWo78vQN0qg9W8GOjRTqEX22AVepEmzt7Tk4SIEoDokCOOKSd
         FuiQLHFqrZLo0WVQpUSJ9X0aep64RUH/uKyNgAA7SFDu86g4uCKb82lVG84/md1UkJWN
         skRwDXMkg9Swuq9jSIuICTMro/fp94uuQ55nMPy4yAPmfVou9zYnuUnOL2LfrJSyW3TD
         wCbA==
X-Gm-Message-State: AOAM532OKzjh99RsYw7vQMP8DFmjKkE8UArrCIIk9GAsAA18bsST4iV7
        YVLyJx/DFlXMzvISX/pzvF/hNg==
X-Google-Smtp-Source: ABdhPJxbn/yOiPbJAb/r7lTVk1pSFtqRW0v2kpPoxNyyjUyTZIn2w8eH5FzN/HLuFp3pjn71dfQylQ==
X-Received: by 2002:a17:90a:784e:: with SMTP id y14mr7567732pjl.185.1628011784627;
        Tue, 03 Aug 2021 10:29:44 -0700 (PDT)
Received: from google.com ([2620:15c:202:201:8875:fb28:686e:1c31])
        by smtp.gmail.com with ESMTPSA id 98sm14736030pjo.26.2021.08.03.10.29.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Aug 2021 10:29:44 -0700 (PDT)
Date:   Tue, 3 Aug 2021 10:29:43 -0700
From:   Prashant Malani <pmalani@chromium.org>
To:     Enric Balletbo i Serra <enric.balletbo@collabora.com>
Cc:     linux-kernel@vger.kernel.org, Benson Leung <bleung@chromium.org>,
        Guenter Roeck <groeck@chromium.org>
Subject: Re: [PATCH 2/2] platform/chrome: cros_ec_typec: Use existing feature
 check
Message-ID: <YQl9B2FKb6rKHq3Z@google.com>
References: <20210802184711.3872372-1-pmalani@chromium.org>
 <20210802184711.3872372-2-pmalani@chromium.org>
 <81610a2b-aa3f-f8d7-5214-e59a7ce839d6@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <81610a2b-aa3f-f8d7-5214-e59a7ce839d6@collabora.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Enric,

Thanks for reviewing the patch.

On Tue, Aug 03, 2021 at 12:09:47PM +0200, Enric Balletbo i Serra wrote:
> Hi Prashant,
> 
> Thank you for your patch.
> 
> On 2/8/21 20:47, Prashant Malani wrote:
> > Replace the cros_typec_feature_supported() function with the
> > pre-existing cros_ec_check_features() function which does the same
> > thing.
> > 
> > Signed-off-by: Prashant Malani <pmalani@chromium.org>
> > ---
> >  drivers/platform/chrome/cros_ec_typec.c | 33 +++++++++----------------
> >  1 file changed, 11 insertions(+), 22 deletions(-)
> > 
> > diff --git a/drivers/platform/chrome/cros_ec_typec.c b/drivers/platform/chrome/cros_ec_typec.c
> > index 27c068c4c38d..f96af8aa31b5 100644
> > --- a/drivers/platform/chrome/cros_ec_typec.c
> > +++ b/drivers/platform/chrome/cros_ec_typec.c
> > @@ -1054,24 +1054,6 @@ static int cros_typec_get_cmd_version(struct cros_typec_data *typec)
> >  	return 0;
> >  }
> >  
> > -/* Check the EC feature flags to see if TYPEC_* features are supported. */
> > -static int cros_typec_feature_supported(struct cros_typec_data *typec, enum ec_feature_code feature)
> > -{
> > -	struct ec_response_get_features resp = {};
> > -	int ret;
> > -
> > -	ret = cros_typec_ec_command(typec, 0, EC_CMD_GET_FEATURES, NULL, 0,
> > -				    &resp, sizeof(resp));
> > -	if (ret < 0) {
> > -		dev_warn(typec->dev,
> > -			 "Failed to get features, assuming typec feature=%d unsupported.\n",
> > -			 feature);
> > -		return 0;
> > -	}
> > -
> > -	return resp.flags[feature / 32] & EC_FEATURE_MASK_1(feature);
> > -}
> > -
> >  static void cros_typec_port_work(struct work_struct *work)
> >  {
> >  	struct cros_typec_data *typec = container_of(work, struct cros_typec_data, port_work);
> > @@ -1113,6 +1095,7 @@ MODULE_DEVICE_TABLE(of, cros_typec_of_match);
> >  
> >  static int cros_typec_probe(struct platform_device *pdev)
> >  {
> > +	struct cros_ec_dev *ec_dev = NULL;
> >  	struct device *dev = &pdev->dev;
> >  	struct cros_typec_data *typec;
> >  	struct ec_response_usb_pd_ports resp;
> > @@ -1132,10 +1115,16 @@ static int cros_typec_probe(struct platform_device *pdev)
> >  		return ret;
> >  	}
> >  
> > -	typec->typec_cmd_supported = !!cros_typec_feature_supported(typec,
> > -					EC_FEATURE_TYPEC_CMD);
> > -	typec->needs_mux_ack = !!cros_typec_feature_supported(typec,
> > -					EC_FEATURE_TYPEC_MUX_REQUIRE_AP_ACK);
> > +	if (typec->ec->ec)
> 
> Is this check really needed. Can typec->ec->ec be NULL at this point?

Looking at it closely, it looks like it can't be NULL
(cros_ec_register() fails if the platform device registration fails).

> 
> > +		ec_dev = dev_get_drvdata(&typec->ec->ec->dev);
> > +
> > +	if (ec_dev) {
> 
> and this?

I haven't been able to prove this solely by looking at the code, hence
wanted to be defensive here. That said, in the ARM and x86 platforms I
tested this change on, it wasn't NULL.

> 
> > +		typec->typec_cmd_supported = !!cros_ec_check_features(ec_dev, EC_FEATURE_TYPEC_CMD);
> > +		typec->needs_mux_ack = !!cros_ec_check_features(ec_dev,
> > +							EC_FEATURE_TYPEC_MUX_REQUIRE_AP_ACK);
> > +	} else {
> 
> and this?
> 
> > +		dev_warn(dev, "Invalid cros_ec_dev pointer; feature flags not checked.\n");
> 
> Can't just be
> 
> 		typec->typec_cmd_supported = !!cros_ec_check_features(ec_dev,
> EC_FEATURE_TYPEC_CMD);
> 		typec->needs_mux_ack = !!cros_ec_check_features(ec_dev,
> EC_FEATURE_TYPEC_MUX_REQUIRE_AP_ACK);

Sure; I'll push another version with the NULL checks dropped.

Thanks,

-Prashant
