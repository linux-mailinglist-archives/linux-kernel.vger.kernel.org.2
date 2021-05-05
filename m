Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C759F373C63
	for <lists+linux-kernel@lfdr.de>; Wed,  5 May 2021 15:28:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233589AbhEEN3Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 May 2021 09:29:16 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:50735 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233661AbhEEN3N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 May 2021 09:29:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1620221296;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=MUmZrpGT6OxCV5nAhpibrhOp+RbEkcdwQ+thqkA6VLU=;
        b=D3LCYFRMTEplVQxx+uodTHoPWhiMv7N8WDaDSOHeOiSbTlMw9rNw2kuRopxraynYQOHanJ
        DWWDroXJuxUUYzYymc4Gj4MTeQGDUT8M+qTfx6e4Coh/gHAlz2i4CXSxJsaskLAoIuRRs7
        rz6YfqM5vGKctayBHyqk/Fi1jxdJxak=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-426-N46OA7JnPeyrNYUAOQMD_g-1; Wed, 05 May 2021 09:28:15 -0400
X-MC-Unique: N46OA7JnPeyrNYUAOQMD_g-1
Received: by mail-pj1-f69.google.com with SMTP id u13-20020a17090a3fcdb0290155c6507e67so865643pjm.6
        for <linux-kernel@vger.kernel.org>; Wed, 05 May 2021 06:28:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MUmZrpGT6OxCV5nAhpibrhOp+RbEkcdwQ+thqkA6VLU=;
        b=C9OKcuMcsM1wqG/A4pXzF6/HonQ9NflFecSSESadP4y2kbl05z7RJY5Zdlu44Nrgms
         o6/VcqYUyHjt+/0bfmoJGUND0umHhw+vkujiieqsWFuI0RJoKD5ELcGQdZl43fR15SHU
         ILbXF5ik/02a3Mfdkp+GovqfZLWefAQYZs5Jfqso6RmFslhT9Ev5aT103469NkIOogX1
         bNgz0pSlHMltFzPiKKToSYEw1nvNhufuj69K/mH6D/cjhGipveDt9HWc0B1uvZg6SFXP
         a3aT5qY0PX1jXOFuWmro/5lCcjW0BUPHIWHvUI5tuTKMKvKxwy/sqQP6e62QXlsGxTjm
         8eHw==
X-Gm-Message-State: AOAM530oB/98JVb1cnwErGB9vIlFnkHUI4z6fcMKySoQI2r3CLJRyQgL
        Na4mBL8DKWKDL261NWnNhihw5PZuKEIAdA2BqhmiNwGFZWpJnK4DVZgnpXTOacp+ErbjUZwviRs
        RrJPYDb29cFG2wRLO7GN1tOCtMcmvW0w4f1zAMWCd
X-Received: by 2002:a62:bd13:0:b029:25c:5ec4:c2f3 with SMTP id a19-20020a62bd130000b029025c5ec4c2f3mr28257270pff.35.1620221294312;
        Wed, 05 May 2021 06:28:14 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzmaTszpJd+BjoubicAkSbsiwpgvFJHCmYcIq2p+UjwLzcdCaRjQQ1vUD6i4gSX9XshlboW+HAC8aeOsYA+wIE=
X-Received: by 2002:a62:bd13:0:b029:25c:5ec4:c2f3 with SMTP id
 a19-20020a62bd130000b029025c5ec4c2f3mr28257243pff.35.1620221294078; Wed, 05
 May 2021 06:28:14 -0700 (PDT)
MIME-Version: 1.0
References: <20210415185232.2617398-1-srinivas.pandruvada@linux.intel.com>
 <20210415185232.2617398-2-srinivas.pandruvada@linux.intel.com> <nycvar.YFH.7.76.2105051437420.28378@cbobk.fhfr.pm>
In-Reply-To: <nycvar.YFH.7.76.2105051437420.28378@cbobk.fhfr.pm>
From:   Benjamin Tissoires <benjamin.tissoires@redhat.com>
Date:   Wed, 5 May 2021 15:28:03 +0200
Message-ID: <CAO-hwJJM5F-1PAh62JSW+GAivMRpgjBiPT2Jvf7+vNcL=HRhGw@mail.gmail.com>
Subject: Re: [PATCH 2/2] HID: hid-sensor-custom: Process failure of sensor_hub_set_feature()
To:     Jiri Kosina <jikos@kernel.org>
Cc:     Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Jonathan Cameron <jic23@kernel.org>,
        jiapeng.chong@linux.alibaba.com,
        "open list:HID CORE LAYER" <linux-input@vger.kernel.org>,
        linux-iio <linux-iio@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Abaci Robot <abaci@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 5, 2021 at 2:38 PM Jiri Kosina <jikos@kernel.org> wrote:
>
> On Thu, 15 Apr 2021, Srinivas Pandruvada wrote:
>
> > When user modifies a custom feature value and sensor_hub_set_feature()
> > fails, return error.
> >
> > Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> > Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
> > ---
> > Replaces patch: HID: hid-sensor-custom: remove useless variable
> > by Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
> >
> >  drivers/hid/hid-sensor-custom.c | 2 ++
> >  1 file changed, 2 insertions(+)
> >
> > diff --git a/drivers/hid/hid-sensor-custom.c b/drivers/hid/hid-sensor-custom.c
> > index 2628bc53ed80..58b54b127cdf 100644
> > --- a/drivers/hid/hid-sensor-custom.c
> > +++ b/drivers/hid/hid-sensor-custom.c
> > @@ -406,6 +406,8 @@ static ssize_t store_value(struct device *dev, struct device_attribute *attr,
> >                                                               report_id;
> >               ret = sensor_hub_set_feature(sensor_inst->hsdev, report_id,
> >                                            index, sizeof(value), &value);
> > +             if (ret)
> > +                     return ret;
>
> What tree is this patch against? In my tree, we're not even assigning
> sensor_hub_set_feature() return value to anything.
>

I guess there was a "collision". At roughly the same time I merged
https://patchwork.kernel.org/project/linux-input/list/?series=456269
people were starting to send various patches for the same thing.

Srinivas, either the change in for-next (and probably Linus' master
now) is fine, or could you rebase on top of hid.git?

Cheers,
Benjamin

