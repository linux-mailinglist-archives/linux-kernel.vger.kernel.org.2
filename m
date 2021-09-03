Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1437A4004F9
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Sep 2021 20:40:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347420AbhICSlX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Sep 2021 14:41:23 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:46189 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232927AbhICSlW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Sep 2021 14:41:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1630694421;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=aWtF9jf2Zkp/EIHUVbxUvuUljulDqbFLTLzbdRX5bvg=;
        b=I8B31O8eeLnxKdukWOFfP+Zv0qyRjBODHk4R5Ia1y88Yazh2xMdANy2eHGmX78OeR7K7Q5
        d8tE0kB9LH8oWfgdFQdc2rLqvOCWBA79K7GxLKMJMBtzS/a/RCSss+1DeWQTCVXhM54IMX
        Dmq/3fR8Le4wzCFpXDfAQRfEM1Oweno=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-457-LMTl23UkNz2fj6q0sV54hw-1; Fri, 03 Sep 2021 14:40:19 -0400
X-MC-Unique: LMTl23UkNz2fj6q0sV54hw-1
Received: by mail-qk1-f198.google.com with SMTP id k9-20020a05620a138900b003d59b580010so6662308qki.18
        for <linux-kernel@vger.kernel.org>; Fri, 03 Sep 2021 11:40:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:organization:user-agent:mime-version
         :content-transfer-encoding;
        bh=aWtF9jf2Zkp/EIHUVbxUvuUljulDqbFLTLzbdRX5bvg=;
        b=O+83je0TEaon4B8RinS/tQb7K2SNHdacLwW8M4K17RW0LjQD098FfF5LnlpjI52505
         xFs5cMSLcVNcCRUnLv813lB3mZC5vB5Gykhvbkqfh65L/1/pkDT8rtqbOX2cLzKnlGkS
         MVdblXcPyYIEmsJ0u1mGFMZfG6KWSpothzW7SNB6Vgt/fkpxWSb8h/NjaJZdqIZ7xpyq
         TZ2TY92zZfsZiTRKaOhyXU0Rc3kcbChTDYA/LnCfKT5Kx/uZG2N7tgCClPDk2Cd9d664
         zE4KitqopDoIqSZWFl7V0um8bnhIoc80eCEgFT5nqerebAF0xaLIsdVaUQJfOqZ6Ce6C
         ot0Q==
X-Gm-Message-State: AOAM5325Q7ubgrOGK+ljFqRdEmagQlVZapU9FY0otrul3XnVQGEZEbpa
        loCjXpypc5YvbMe0s8yx4EUfXu7zYKI6AZqfPbpKePVKmZAqIXpzXSas+JaVxAe6U8uhIzaNdEF
        medvf7LeWA5GxKTyohBx95OYS
X-Received: by 2002:a05:620a:2e4:: with SMTP id a4mr241537qko.288.1630694419449;
        Fri, 03 Sep 2021 11:40:19 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwqVC1TcFhJm7LcUohfzVUt093xlPQkNtnzfm7+W7zSXklTGCQY6X98oT4Qb3UWtx1UAb1ngA==
X-Received: by 2002:a05:620a:2e4:: with SMTP id a4mr241518qko.288.1630694419233;
        Fri, 03 Sep 2021 11:40:19 -0700 (PDT)
Received: from [192.168.8.104] (pool-108-49-102-102.bstnma.fios.verizon.net. [108.49.102.102])
        by smtp.gmail.com with ESMTPSA id a189sm4443447qkf.114.2021.09.03.11.40.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Sep 2021 11:40:18 -0700 (PDT)
Message-ID: <ca29cfea709f54f74899900068bddcd838d5ab2c.camel@redhat.com>
Subject: Re: [PATCH] drm/msm: remove unneeded variable
From:   Lyude Paul <lyude@redhat.com>
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, cgel.zte@gmail.com,
        robdclark@gmail.com
Cc:     sean@poorly.run, airlied@linux.ie, daniel@ffwll.ch,
        airlied@redhat.com, laurent.pinchart@ideasonboard.com,
        chi.minghao@zte.com.cn, treding@nvidia.com,
        linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Zeal Robot <zealci@zte.com.cn>
Date:   Fri, 03 Sep 2021 14:40:17 -0400
In-Reply-To: <52a6c92d-fe59-cdb8-23de-6fcda6ca2c68@linaro.org>
References: <20210831115127.18236-1-chi.minghao@zte.com.cn>
         <2d6784e3327cab7bfdc88ca1ef7c9c4c9cca113a.camel@redhat.com>
         <52a6c92d-fe59-cdb8-23de-6fcda6ca2c68@linaro.org>
Organization: Red Hat
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.40.4 (3.40.4-1.fc34) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2021-09-03 at 21:31 +0300, Dmitry Baryshkov wrote:
> On 02/09/2021 21:40, Lyude Paul wrote:
> > Reviewed-by: Lyude Paul <lyude@redhat.com>
> > 
> > Do you need me to push this?
> 
> We'd pick this up through the msm tree.

ah-totally forgot msm had their own tree and didn't go through drm-misc-next.
Thanks!

> 
> > 
> > On Tue, 2021-08-31 at 04:51 -0700, cgel.zte@gmail.com wrote:
> > > From: Chi Minghao <chi.minghao@zte.com.cn>
> > > 
> > > Fix the following coccicheck REVIEW:
> > > ./drivers/gpu/drm/msm/edp/edp_ctrl.c:1245:5-8 Unneeded variable
> > > 
> > > Reported-by: Zeal Robot <zealci@zte.com.cn>
> > > Signed-off-by: Chi Minghao <chi.minghao@zte.com.cn>
> > > ---
> > >   drivers/gpu/drm/msm/edp/edp_ctrl.c | 4 +---
> > >   1 file changed, 1 insertion(+), 3 deletions(-)
> > > 
> > > diff --git a/drivers/gpu/drm/msm/edp/edp_ctrl.c
> > > b/drivers/gpu/drm/msm/edp/edp_ctrl.c
> > > index 4fb397ee7c84..3610e26e62fa 100644
> > > --- a/drivers/gpu/drm/msm/edp/edp_ctrl.c
> > > +++ b/drivers/gpu/drm/msm/edp/edp_ctrl.c
> > > @@ -1242,8 +1242,6 @@ bool msm_edp_ctrl_panel_connected(struct edp_ctrl
> > > *ctrl)
> > >   int msm_edp_ctrl_get_panel_info(struct edp_ctrl *ctrl,
> > >                  struct drm_connector *connector, struct edid **edid)
> > >   {
> > > -       int ret = 0;
> > > -
> > >          mutex_lock(&ctrl->dev_mutex);
> > >   
> > >          if (ctrl->edid) {
> > > @@ -1278,7 +1276,7 @@ int msm_edp_ctrl_get_panel_info(struct edp_ctrl
> > > *ctrl,
> > >          }
> > >   unlock_ret:
> > >          mutex_unlock(&ctrl->dev_mutex);
> > > -       return ret;
> > > +       return 0;
> > >   }
> > >   
> > >   int msm_edp_ctrl_timing_cfg(struct edp_ctrl *ctrl,
> > 
> 
> 

-- 
Cheers,
 Lyude Paul (she/her)
 Software Engineer at Red Hat

