Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 99A4B4009F3
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Sep 2021 08:01:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232460AbhIDGBv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Sep 2021 02:01:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229741AbhIDGBt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Sep 2021 02:01:49 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6B9FC061575
        for <linux-kernel@vger.kernel.org>; Fri,  3 Sep 2021 23:00:48 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id m26so1178602pff.3
        for <linux-kernel@vger.kernel.org>; Fri, 03 Sep 2021 23:00:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=GLxi1KGYaaCg8emjrRkzTYjlBtdFmy8JJ+fONfTMYMk=;
        b=POZs3N8qT6UI7DZbwpnV0sc/3NARUOAReXFHzonB+GX9rNmQ7l955DIzy1uy+AXR8Z
         IH9nxOQLoeVrSCxexagkriQst3XUt6p7XimvWWFBn7WFip5saZWLWo/WlLrLjxXDXqNn
         /3QoqZx3bMTpta2u/I5yCl7jVruF/DnkaILd8FNjlrbQSW0AbIKQJT0XNgONReqK4fiZ
         7b2bB2fX0flwJNNNQCa3hj3o3wdGJPbGd5wnnyDi/rj0NKRoOOp0QBEkdO93IG0w2XnP
         YjjGxdWFvPpmj2BFzdM+8wNAC20k2qtT+NTRK8hFIQYKJjKi2WOx2MSrWwGRoz3P6F93
         +9SA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=GLxi1KGYaaCg8emjrRkzTYjlBtdFmy8JJ+fONfTMYMk=;
        b=WVVbfrQwQ+mlFsFPtXkftQXYjw8UFstSb/Sec0+szNDsV5V4iXpgPEOoPuplJcWXxB
         24yPbF6KMWrFNDWmpf7LEdLmlzhSddaDXWacIoK6fTRmXbQxiFdapJqAVEMQJmkbaSvq
         XawzM0c6mWOlGfPx5NuQd7yiQvitdgLCKuC42S3RGe5zEe26sppnyaqy0hL8ygo6vD+a
         wh4EQJkdVzxkn0/JJ7ptmCYtCBUEl6ict9gm00AduVIC9KR+VhSoOYMzyo+nhu5EIYr3
         XG0Vo81wRpMA6wKgDtOb8e+IV0H8IcttRBeS+t5onlxnnhs3f8Mez8+dHqE8b6lNoKmi
         HLVw==
X-Gm-Message-State: AOAM530xt7jTAn9tP/jjU76Fp/ibQMg8IGpCmKKYKYsxaqY5fnsRqUVS
        8Wlctb3puBjHS8c7gjOJYB+LDu4N0COCFDXs
X-Google-Smtp-Source: ABdhPJyzqacZiVI7G+RQhrtXXy6lLEy/d1RtI8lj8UEgqeJEuu0XhkbqC/r/0nvTJSrO8uQOT2mm9Q==
X-Received: by 2002:a63:da14:: with SMTP id c20mr2287060pgh.155.1630735248245;
        Fri, 03 Sep 2021 23:00:48 -0700 (PDT)
Received: from user ([117.98.200.228])
        by smtp.gmail.com with ESMTPSA id w186sm1129029pfw.78.2021.09.03.23.00.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Sep 2021 23:00:47 -0700 (PDT)
Date:   Sat, 4 Sep 2021 11:30:42 +0530
From:   SAURAV GIREPUNJE <saurav.girepunje@gmail.com>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        gregkh@linuxfoundation.org, fabioaiuto83@gmail.com,
        straube.linux@gmail.com, ross.schm.dev@gmail.com,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        saurav.girepunje@hotmail.com
Subject: Re: [PATCH v4] staging: r8188eu: core: remove null check before vfree
Message-ID: <YTMLilFWdGopMdtl@user>
References: <YSu9GQa1A3s6FYQx@user>
 <20210830112525.GG12231@kadam>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210830112525.GG12231@kadam>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30 Aug 2021 14:25, Dan Carpenter wrote:
> On Sun, Aug 29, 2021 at 10:30:09PM +0530, Saurav Girepunje wrote:
> > Remove NULL check. NULL check before freeing function is not needed.
> > Correct the indentation.
> >
> > Signed-off-by: Saurav Girepunje <saurav.girepunje@gmail.com>
> > ---
>
> Looks good.  Thanks!
>
> Reviewed-by: Dan Carpenter <dan.carpenter@oracle.com>
>
> regards,
> dan carpenter
>

Thanks for review Dan,


Saurav
