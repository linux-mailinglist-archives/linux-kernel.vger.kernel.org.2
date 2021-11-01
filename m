Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B66BA442440
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Nov 2021 00:41:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231423AbhKAXnp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Nov 2021 19:43:45 -0400
Received: from gw2.atmark-techno.com ([35.74.137.57]:33300 "EHLO
        gw2.atmark-techno.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229523AbhKAXnm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Nov 2021 19:43:42 -0400
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com [209.85.210.199])
        by gw2.atmark-techno.com (Postfix) with ESMTPS id 6097B2003C
        for <linux-kernel@vger.kernel.org>; Tue,  2 Nov 2021 08:41:06 +0900 (JST)
Received: by mail-pf1-f199.google.com with SMTP id c140-20020a624e92000000b0044d3de98438so10178184pfb.14
        for <linux-kernel@vger.kernel.org>; Mon, 01 Nov 2021 16:41:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=By2nrQuCIKQf3NwzY9ElfQ1+ViWJvdE8NoIkqa/IBjs=;
        b=bozSMuxUQnOUSGHBYuIAlJ2bNYu8R7u9tH3rdHTxDa2hYam1hxUJLMpCsObPCjlrLu
         sbPTdLuSmKbMZcIUEjXHAdSZii67wF9Ieqxkoswv47QplR8bMnDD1KJoMDVU/6iVunwY
         Xnjoi7mN5V8WO7rTuPHLdz2QnIlQUAc0zFfPSvobiQvTgx5BslE72osheS4qJkdpZu31
         A1UVMMFchsjkQ7lkefUQ07w10lYC+V/yep90RpSAC0kXrURi9T1+tyciMNJHfwLCTK5y
         2VxkMi7y/TJlrMheG31KH3+nLm71DB0ne1vxwJ0aQm+pwgVLQTMzzFaBMDg3vsgBORrY
         2IjQ==
X-Gm-Message-State: AOAM530up7KLmF5wqHRyI0syKMBLE0U9JiY4g9iEkVtFq6xnqUVlRWP9
        d1k24Y4BqhGmNpdYiaNVrLmOR9vGtcew3n3v2TRaWjmmp9tAe+csLsekrxbMic2HQAWh6T9QV9V
        nZ+AesPcyq3JRu0O+X6jgWOSIpw==
X-Received: by 2002:a17:90a:4fa1:: with SMTP id q30mr2368105pjh.12.1635810065466;
        Mon, 01 Nov 2021 16:41:05 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwKq07jW36bYZxVDX5xVHL1vEAzZYjXVifD+GkKzqnt6PSGYkqOLdf8EWVUYOJvICQ7EySleQ==
X-Received: by 2002:a17:90a:4fa1:: with SMTP id q30mr2368072pjh.12.1635810065211;
        Mon, 01 Nov 2021 16:41:05 -0700 (PDT)
Received: from pc-0115 (103.131.189.35.bc.googleusercontent.com. [35.189.131.103])
        by smtp.gmail.com with ESMTPSA id w21sm17737559pfu.68.2021.11.01.16.41.04
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 01 Nov 2021 16:41:04 -0700 (PDT)
Received: from martinet by pc-0115 with local (Exim 4.94.2)
        (envelope-from <martinet@pc-0115>)
        id 1mhgvH-002dX5-LD; Tue, 02 Nov 2021 08:41:03 +0900
Date:   Tue, 2 Nov 2021 08:40:53 +0900
From:   Dominique Martinet <dominique.martinet@atmark-techno.com>
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     Alessandro Zummo <a.zummo@towertech.it>, linux-rtc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Marek Vasut <marex@denx.de>,
        Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH 2/2] rv8803: add irq-gpio optional dts attribute
Message-ID: <YYB7BXuLXWuiWGw6@atmark-techno.com>
References: <20211101013400.325855-1-dominique.martinet@atmark-techno.com>
 <20211101013400.325855-2-dominique.martinet@atmark-techno.com>
 <YYBuzqZD8/uK3d6Z@piout.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YYBuzqZD8/uK3d6Z@piout.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Alexandre Belloni wrote on Mon, Nov 01, 2021 at 11:48:46PM +0100:
> On 01/11/2021 10:34:00+0900, Dominique Martinet wrote:
> > Some device cannot be woken up from i2c signal.
> > Add a new irq-gpio attribute for devices which have a gpio connected to
> > the rv8803 INT line so the rtc can be used for suspend to mem
> 
> I don't think this is right, the interrupts property of the rtc node can
> point to a gpio and this is expected to be the one connected on INT. You
> don't need another property.

Oh, why didn't I know about such a useful property.

I thought I'd have a problem with the device wakeup part but there also
is another 'wakeup-source' property, so there is really nothing left to
do for this patch.
Thank you for the pointer, no code is the best code!


Rob Herring wrote on Mon, Nov 01, 2021 at 07:53:52AM -0500:
> Please send DT patches to the DT list.
> 
> Binding changes should be a separate patch.

Ack, I'll do that for new patches onwards. It looks like a DT change
will not be required here but I will remember this.


Thanks,
-- 
Dominique
