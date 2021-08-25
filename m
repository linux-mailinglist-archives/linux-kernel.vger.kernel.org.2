Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D6FB53F73B3
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Aug 2021 12:52:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240087AbhHYKwo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Aug 2021 06:52:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240050AbhHYKwk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Aug 2021 06:52:40 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B9E7C0613C1
        for <linux-kernel@vger.kernel.org>; Wed, 25 Aug 2021 03:51:54 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id q17so14396933edv.2
        for <linux-kernel@vger.kernel.org>; Wed, 25 Aug 2021 03:51:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=g9BYEuaw0HQh1Q4p4jwQ2eW3l9i+Sl5e+iTjwSb8o+g=;
        b=DTNwE1S4mRY2/tDI2bJPh0LYpRfE6JyOLqfuTYS6NfrEOLO5gKoML43QTUS/vDHMd6
         bOsBse60Zj9rxZ75Q600L8HXT6cqlJyLGe1YgqUMcOEe79rDfrk2YAD95C3chGwWDEI7
         658v6tbFB3bNa/Z2I768UmIxKAIbhF1f8FuS/gOLs4ISpw7fzw112xdT1Uq2wu0E91Ff
         AN/xJSL5xsm6rFgUngirDD55X+Y8EJX264iq/ckE3owg6o/KJvoTDTAnDE3IQSXOsyIa
         8mot25JoPZSzo8kS5CWi1gjkP+ySCjzROiNDfENkjF7tYqp/594GCXSEipCFJ+IIrP3+
         SuvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=g9BYEuaw0HQh1Q4p4jwQ2eW3l9i+Sl5e+iTjwSb8o+g=;
        b=QmubykEzo4/4jSvnRyAkajIbcsvR88GE1STfPiGOcWZzawIfZZMs0pQHD5ilRCCf3R
         15AleuX0wYnQab1Rb4jCkUtxnY0o5O3RQAZE/S+BrfBQADKpivSMV9Lm/hN0713BgX8i
         BWB6fdQHen2U92pDXdxItNdRUJjlyv/CzADdnm1RMelYXtirIOK6WyOHzoWNv+6oJ4rX
         cSF3Tf3rNvvD29N8voVTtOJJTVYO00P48q2pdomsx7Y7S149DFtdwwQMbyz7mU19cSFq
         giQiH2Yp0Pecq6b692QwktEZe3uib48t7NoZOOIcM2uZCTf1oiTJXYsSUgwbDnUnRaRA
         +e6g==
X-Gm-Message-State: AOAM530wmMz25XkgPZnOeCkL9pjNf65tcKxeLAunP0YUyCxm4jcr0CZT
        UdAge5S6+Bfg7ctizA+NeNM=
X-Google-Smtp-Source: ABdhPJys+z6foroDuXRyJILU4DeHMxM+LXO5r3NQlhyLL5/evDF5NRyH0PI4HGFqvnsvhuqjWY22iA==
X-Received: by 2002:aa7:c311:: with SMTP id l17mr1659544edq.320.1629888713236;
        Wed, 25 Aug 2021 03:51:53 -0700 (PDT)
Received: from localhost.localdomain (host-79-22-100-164.retail.telecomitalia.it. [79.22.100.164])
        by smtp.gmail.com with ESMTPSA id w5sm10972012ejz.25.2021.08.25.03.51.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Aug 2021 03:51:52 -0700 (PDT)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        gregkh@linuxfoundation.org, straube.linux@gmail.com,
        Pavel Skripkin <paskripkin@gmail.com>
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 4/6] staging: r8188eu: add error handling of rtw_read16
Date:   Wed, 25 Aug 2021 12:51:51 +0200
Message-ID: <10877752.rW0qT3HDr3@localhost.localdomain>
In-Reply-To: <794dfd94-fe88-43ac-c4ec-9ff7df9db6de@gmail.com>
References: <cover.1629789580.git.paskripkin@gmail.com> <2227654.mbYB7oqmoa@localhost.localdomain> <794dfd94-fe88-43ac-c4ec-9ff7df9db6de@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday, August 25, 2021 11:55:37 AM CEST Pavel Skripkin wrote:
> On 8/25/21 12:48 PM, Fabio M. De Francesco wrote:
> > On Wednesday, August 25, 2021 10:22:16 AM CEST Pavel Skripkin wrote:
> >> On 8/25/21 7:35 AM, Fabio M. De Francesco wrote:
> >> > Dear Pavel,
> >> > 
> >> > Please note that if and when my patch "Use usb_control_msg_recv / send () in
> >> > usbctrl_vendorreq ()" will be merged, "if (res! = len)" will always evaluate 'true'
> >> > and usb_read16 () will always return -EIO even if usbctrl_vendorreq () succeeds.
> >> > 
> >> 
> >> Yep, thank you, but it depends on which series will go in first :)
> >> 
> >> There is a chance, that you will need to clean up this part, if mine 
> >> will be merged before yours
> >> 
> > 
> > Ha-ha ... I know that beautiful rule: whoever breaks must fix!
> > However there should be another rule which says that
> > the old (me) takes precedence over the young (you) :-)
> > 
> 
> The main problem, that no one knows who is the "old". Greg can take 
> patches in any order he wants, because they are naturally independent :)
> 
> 
> We only can say smth like "this one depends on this one" as reply to 
> patch to inform Greg about the situation.
> 
> > Seriously, thank you so much for your help and the "Reviewed by"
> > tag on my work.
> > 
> 
> You too :) We are doing same job here for the good of community and 
> kernel itself
> 
Pavel, Dan,

Did you really take my "old" vs. "young" precedence rule seriously?

I was just kidding, ahead of thanking Pavel for his "Reviewed-by" tag
to my patch.

That statement deserved no comment. I thought it was
clear it was just a joke :)

Thanks,

Fabio
> 
> 
> With regards,
> Pavel Skripkin
> 




