Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A3E404329DE
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Oct 2021 00:49:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232045AbhJRWwG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Oct 2021 18:52:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230284AbhJRWwF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Oct 2021 18:52:05 -0400
Received: from mail-qk1-x736.google.com (mail-qk1-x736.google.com [IPv6:2607:f8b0:4864:20::736])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45E3AC06161C
        for <linux-kernel@vger.kernel.org>; Mon, 18 Oct 2021 15:49:53 -0700 (PDT)
Received: by mail-qk1-x736.google.com with SMTP id bj31so14118361qkb.2
        for <linux-kernel@vger.kernel.org>; Mon, 18 Oct 2021 15:49:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=bvrWgKEuwxW/WqAiRLeWwR9Aac9SzlLC9F/yKT1u3P8=;
        b=qheCn2692fQk1Ju79VEFKjyPaH84HNFqjt0IFzpussCnIwIw51p+GKC2SlaV8uLdb5
         gw7/avrIM3wOpHkz2tkTVXbXO65/8S/7enguvIYbh9xeLP2FOwmA4jXM5KsXyyl6qQFF
         I/CUeNAL7eFqeMktnhkb22CRUhkfBfdZMLKVYOERweyQTRW+jXuz0DOClqK8Nf84IFXD
         YXsxvHDz8xM3nFWFF7CBFFLiS5YYyPU2L6h9mZO/BClZ6c6nCby6GaHFC1o1tBEDWaZZ
         nc0LQt7lB0SUwvV7EBh96xAtUF3lzzvXZmOsXdrV54Vl348qxySuT8/KXIFpTKsBdvfU
         mr3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=bvrWgKEuwxW/WqAiRLeWwR9Aac9SzlLC9F/yKT1u3P8=;
        b=k+quRysOVeyNIQuvhmnGl7d3AqOpqTBZ2DXrpxaiFkYR0QwaV9lGNrQC9EkwVqvfIw
         MovcglnmhU8+vc/DOShy0+M5hl3a+QoGGhZENanlg/6Jdjce3bgYeUsXNafmjU+kj4Bp
         3lDXcdGfOUD5j8Ij7SJyXHBQ5oQYUHcRDzHVlHN2y61gTEMpl08ON6Li+Q2Z4lqU434p
         qJds70nJNlYM1mMQi+xzeDhZMz6brMH18epV46uhuoPln/YuQrYWLP4O5L42+X2fwWGQ
         mpGZz4ryIn3Yki+E41q7PXNrT3Dav9FgEcbWzSh2Rqtgph4Ou75Vgh9nmK8neXNjXpZ0
         kCEg==
X-Gm-Message-State: AOAM532bswEKssfg/QaHREUe+hgINihkY8tZ1C1bes6U35g0B8APpNKn
        xrX7HYSup3YRbiM2pJgD0/E=
X-Google-Smtp-Source: ABdhPJz7zu6maU2w/MTtsq3vEKLpGQey9DAKwNEZkDN1u5XmzybmcAi4aVhRhJxW8S2RCteq+XXHQA==
X-Received: by 2002:a37:b06:: with SMTP id 6mr24625526qkl.352.1634597392453;
        Mon, 18 Oct 2021 15:49:52 -0700 (PDT)
Received: from ubuntu-mate-laptop.localnet ([67.8.38.84])
        by smtp.gmail.com with ESMTPSA id j23sm6682864qtr.23.2021.10.18.15.49.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Oct 2021 15:49:51 -0700 (PDT)
Sender: Julian Braha <julian.braha@gmail.com>
From:   Julian Braha <julianbraha@gmail.com>
To:     Sam Ravnborg <sam@ravnborg.org>
Cc:     thierry.reding@gmail.com, airlied@linux.ie, daniel@ffwll.ch,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
Subject: Re: [PATCH v2] drm/panel/tianma-tl057fvxp01: add panel for Motorola Moto G6
Date:   Mon, 18 Oct 2021 18:49:50 -0400
Message-ID: <4000775.iezT5iszD9@ubuntu-mate-laptop>
In-Reply-To: <YWxeUd6PALatP7z/@ravnborg.org>
References: <20210808200854.187648-1-julianbraha@gmail.com> <YWxeUd6PALatP7z/@ravnborg.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday, October 17, 2021 1:33:05 PM EDT Sam Ravnborg wrote:
> Hi Julian,
> 
> On Sun, Aug 08, 2021 at 04:08:54PM -0400, Julian Braha wrote:
> > This is a 5.7" 2160x1080 panel found on the Motorola Moto G6.
> > There may be other smartphones using it, as well.
> > 
> > Signed-off-by: Julian Braha <julianbraha@gmail.com>
> 
> Sorry for coming back so late. Driver looks good and is almost
> ready to apply. One detail you need to fix, see below.
> 
> 	Sam
> 
> > ---
> > +
> > +static const struct of_device_id tianma_tl057fvxp01_of_match[] = {
> > +	{ .compatible = "tianma,tl057fvxp01" },
> > +	{ /* sentinel */ }
> > +};
> The compatible needs to be documented before I can include the driver in
> the kernel. Please add a patch that document the compatible - maybe as a
> new binding file but preferably as part of one of the existing binding
> files.
> 
> 	Sam
> 

Hi Sam,

Thanks for your feedback! I've submitted a second patch for the bindings.

- Julian Braha


