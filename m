Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4688B41384B
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Sep 2021 19:29:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230362AbhIURbN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Sep 2021 13:31:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230304AbhIURbJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Sep 2021 13:31:09 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C791C061574
        for <linux-kernel@vger.kernel.org>; Tue, 21 Sep 2021 10:29:40 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id c1so115458pfp.10
        for <linux-kernel@vger.kernel.org>; Tue, 21 Sep 2021 10:29:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=5ZFM1bQnaH/hG4GJ4maCnY9fQIG/xvcbH7xbA8DdtAQ=;
        b=cpO7F6RAkOtaaLBcj/D3DM7VI/2e/b/xyV3wDFZdrUpNiEFuAIlU1SodYu5Zno/nbf
         1x0pE9IsqoL1QBKcQrB3W4u3yZyoSCikwwVPPNfn0KDs2qpY8bd8ChJCxsFE43Y6pgZF
         1xZheyyTm+8iXJPt0DQpiti9WZDI6kX4JrsBo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=5ZFM1bQnaH/hG4GJ4maCnY9fQIG/xvcbH7xbA8DdtAQ=;
        b=rWv6zua2F9P+tzY2JNlBTUnk8+ywfrp1UD60qeqvCGG4nj+jjXkjFo69W0swhvpZFW
         AXb6jkLW5igLSylMCyZf5DFkecDtE46xxoX199sD6PXePigOwOGIiY4n1bh0GisuzwDR
         Yifb43hqG2w2cKoItQKW4COh7fKaZUN016WijePYYfXtItogiqTr+flEr2f0Ef9u9smp
         jjKAmkiQXPOXkkIusETswDg1bvMWW9BDB+5CA3apEPvJf6HYYQPvAnW4NQaL8/rO3y1f
         M5gGGXeuemsrJbpYhvl7SWB6YTaI3kBfgQ/Ok92ZlpJcGIO1v1ZlaC0Py0oZgJYF6Ixc
         xrqw==
X-Gm-Message-State: AOAM533JX3fhar2Vq92KB6u+Glnz1GoclkTbj/xNrUeqBQnV+dH6ZjOP
        8HwrpAVmqCn19o8J1zZc4VLT4g==
X-Google-Smtp-Source: ABdhPJy6pwemYJZ1l6AHRGdhbx+ZMUwdZjE/MpGjsPySrqqQ+fbF3dditzqpGTO8xtrNqpUc9F9ewg==
X-Received: by 2002:a62:51c6:0:b0:43d:e849:c69d with SMTP id f189-20020a6251c6000000b0043de849c69dmr31646639pfb.31.1632245379599;
        Tue, 21 Sep 2021 10:29:39 -0700 (PDT)
Received: from google.com ([2620:15c:202:201:c67e:1969:6d2c:d531])
        by smtp.gmail.com with ESMTPSA id 207sm17910671pfu.56.2021.09.21.10.29.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Sep 2021 10:29:38 -0700 (PDT)
Date:   Tue, 21 Sep 2021 10:29:37 -0700
From:   Prashant Malani <pmalani@chromium.org>
To:     Enric Balletbo i Serra <enric.balletbo@collabora.com>
Cc:     linux-kernel@vger.kernel.org, Benson Leung <bleung@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>
Subject: Re: [PATCH] platform/chrome: cros_ec_proto: Fix check_features ret
 val
Message-ID: <YUoWgdK2+t8d11oq@google.com>
References: <20210916014632.2662612-1-pmalani@chromium.org>
 <f6860aa6-b541-b03d-da8d-333661a8322f@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f6860aa6-b541-b03d-da8d-333661a8322f@collabora.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Enric,

Thanks for reviewing the patch.

On Tue, Sep 21, 2021 at 01:42:04PM +0200, Enric Balletbo i Serra wrote:
> Hi Prashant,
> 
> Thank you for the patch. Just one comment below ...
> 
> On 16/9/21 3:46, Prashant Malani wrote:
> > The kerneldoc for cros_ec_check_features() states that it returns 1 or 0
> > depedending on whether a feature is supported or not, but it instead
> > returns a negative error number in one case, and a non-1 bitmask in
> > other cases.
> > 
> > Since all call-sites only check for a 1 or 0 return value, update
> > the function to return boolean values.
> > 
> > Signed-off-by: Prashant Malani <pmalani@chromium.org>
> > ---
> >  drivers/platform/chrome/cros_ec_proto.c     | 12 +++++++-----
> >  include/linux/platform_data/cros_ec_proto.h |  2 +-
> >  2 files changed, 8 insertions(+), 6 deletions(-)
> > 
> > diff --git a/drivers/platform/chrome/cros_ec_proto.c b/drivers/platform/chrome/cros_ec_proto.c
> > index a7404d69b2d3..a34cf58c5ef7 100644
> > --- a/drivers/platform/chrome/cros_ec_proto.c
> > +++ b/drivers/platform/chrome/cros_ec_proto.c
> > @@ -808,9 +808,9 @@ EXPORT_SYMBOL(cros_ec_get_host_event);
> >   *
> >   * Call this function to test whether the ChromeOS EC supports a feature.
> >   *
> > - * Return: 1 if supported, 0 if not
> > + * Return: true if supported, false if not (or if an error was encountered).
> >   */
> > -int cros_ec_check_features(struct cros_ec_dev *ec, int feature)
> > +bool cros_ec_check_features(struct cros_ec_dev *ec, int feature)
> >  {
> >  	struct cros_ec_command *msg;
> >  	int ret;
> > @@ -818,8 +818,10 @@ int cros_ec_check_features(struct cros_ec_dev *ec, int feature)
> >  	if (ec->features[0] == -1U && ec->features[1] == -1U) {
> >  		/* features bitmap not read yet */
> >  		msg = kzalloc(sizeof(*msg) + sizeof(ec->features), GFP_KERNEL);
> > -		if (!msg)
> > -			return -ENOMEM;
> > +		if (!msg) {
> > +			dev_err(ec->dev, "failed to allocate memory to get EC features\n");
> 
> In case of failure you will be noticed by the allocator, prints after
> [k|v][m|z|c]alloc() functions are not needed, so I think you can just return
> false here.
> > 

Makes sense; I can make the change, but I had one question:

If we solely return false, how will we tell from the logs that the
allocation error message was associated with this driver? Only returning
false means the driver probe (e.g cros-ec-typec) will continue (just assuming a certain feature
is not present). Wouldn't having this error message make this clear?

Best regards,

-Prashant
