Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 337C9428444
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Oct 2021 02:18:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233295AbhJKAUg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Oct 2021 20:20:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232933AbhJKAUf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Oct 2021 20:20:35 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66EA7C06161C
        for <linux-kernel@vger.kernel.org>; Sun, 10 Oct 2021 17:18:36 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id t2so50226215wrb.8
        for <linux-kernel@vger.kernel.org>; Sun, 10 Oct 2021 17:18:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=philpotter-co-uk.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=+ertAYRuBrO4o1phVoXpE4ROiBPxr5B4o34tTZaBB8A=;
        b=DPfU03D3DqsL+CkdbZ/BDchAbEN5TtBMbdvFV9GkUeSTuTTgA/INSnQlJdCMxC5cQI
         ybD0bKSGMABhPCrWhW7opF0hAycAKHYKGQbNVBRc3BJ7ls05pGAl6mLWfdu9b36B46/N
         v10OImb6nVtP5wrgqKce/WtzXxAGHx5J1Zli7xFEBtx+D/5rjv9fNVux7EcEqqyMdYOs
         xrlmUfrxBVHye0urgF/RzoZRqtuVfIN4Jlaj/QMA+AIqvaqLgAdjSgEFFNL9znvjDQpV
         2wp5dSDTPpMu9QatmmmptpJgYSK/pwe9YC2GD9i6YukCjMK04OcaIs5ypDP6Up5mWO1U
         qj4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=+ertAYRuBrO4o1phVoXpE4ROiBPxr5B4o34tTZaBB8A=;
        b=4RogfVDecXdw0Ajkt5NBt8M10QBLajKaazCOpTYWyorLXavwnzshu5aB+ECuSkd6CX
         2s5BIEkLKwCosG0CJqx5IJEZ1GgOGBgDjDrdJsC5bSNXsWn/oz+Y4e09yY/qBGev2lX+
         MVI04DgzfIWZLbv7A73iPrEpZhQizllWvtvhE6fZjhl835pehQ9UbLie4LpWREs9ZrNy
         EkrlBNiB6chPPsyOY4ERc0z2lYlC+16xChnlA5+7vddGgodu//iaeZ2m9xw4xAKBZCgf
         fQaLoh67/mxayC4yFoOaNTrgZe7S+KoTjG5Rk/2rTINhym6ojbxp8eYGkv3pFeHk8VqO
         o9Mw==
X-Gm-Message-State: AOAM53128YzFugzwpUIhst702HfXewrnwj6zz4eSlhnOr+oE146tS5UE
        4v2w+YU6XFP798oVs+VDduS4mA==
X-Google-Smtp-Source: ABdhPJzLmNrhjQpndv3iPH0ThAst4NK4h72w8khYnDOD3zReF83j4toL6PQbN/Ipmxjv69D5fNHlSQ==
X-Received: by 2002:adf:e101:: with SMTP id t1mr21586690wrz.395.1633911514884;
        Sun, 10 Oct 2021 17:18:34 -0700 (PDT)
Received: from equinox (2.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.a.1.e.e.d.f.d.0.b.8.0.1.0.0.2.ip6.arpa. [2001:8b0:dfde:e1a0::2])
        by smtp.gmail.com with ESMTPSA id d8sm6190613wrz.84.2021.10.10.17.18.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Oct 2021 17:18:34 -0700 (PDT)
Date:   Mon, 11 Oct 2021 01:18:32 +0100
From:   Phillip Potter <phil@philpotter.co.uk>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     axboe@kernel.dk, hch@infradead.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, lumip@lumip.de
Subject: Re: [PATCH] cdrom: docs: reformat table in
 Documentation/userspace-api/ioctl/cdrom.rst
Message-ID: <YWOC2Iyszh7WAgzf@equinox>
References: <20211007231720.31997-1-phil@philpotter.co.uk>
 <464a0b2f-c556-ccda-aa3c-26733fba4617@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <464a0b2f-c556-ccda-aa3c-26733fba4617@infradead.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 07, 2021 at 04:34:13PM -0700, Randy Dunlap wrote:
> On 10/7/21 4:17 PM, Phillip Potter wrote:
> > Add extra space to the first column of ioctl values table, and also realign
> > the text in the second column, to fix a documentation build warning
> > introduced by: commit 67f1e027c270 ("drivers/cdrom: improved ioctl for
> > media change detection")
> > 
> > Suggested-by: Randy Dunlap <rdunlap@infradead.org>
> > Fixes: 67f1e027c270 ("drivers/cdrom: improved ioctl for media change detection")
> > Signed-off-by: Phillip Potter <phil@philpotter.co.uk>
> 
> Looks good. Thanks.
> 
> Reviewed-by: Randy Dunlap <rdunlap@infradead.org>
> 
> 
> > ---
> >   Documentation/userspace-api/ioctl/cdrom.rst | 116 ++++++++++----------
> >   1 file changed, 58 insertions(+), 58 deletions(-)
> > 
> > diff --git a/Documentation/userspace-api/ioctl/cdrom.rst b/Documentation/userspace-api/ioctl/cdrom.rst
> > index bac5bbf93ca0..682948fc88a3 100644
> > --- a/Documentation/userspace-api/ioctl/cdrom.rst
> > +++ b/Documentation/userspace-api/ioctl/cdrom.rst
> 
> 
> 
> -- 
> ~Randy

Thank you for the review Randy.

Regards,
Phil
