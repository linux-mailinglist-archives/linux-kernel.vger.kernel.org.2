Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D63A9419517
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Sep 2021 15:30:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234510AbhI0NcI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Sep 2021 09:32:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234103AbhI0NcH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Sep 2021 09:32:07 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B57DDC061575
        for <linux-kernel@vger.kernel.org>; Mon, 27 Sep 2021 06:30:29 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id y28so77079724lfb.0
        for <linux-kernel@vger.kernel.org>; Mon, 27 Sep 2021 06:30:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to;
        bh=FkhQ6gqFJjzDNdIWz0kRoR/uK1k7q5+qk6RD2h5xBiY=;
        b=pmuw6Bhvo4w3VnbJcPy8tIGpcPeJeW0bWg9tuUjcHh9ZXsNFQHSs+N0BosjuyCN0KC
         YpClSvfyH5IEgcGqVONDpLuGqBxrBJHrh8NvhLk8m4SmpD9ZVdNcOdp7DUDoE9fqISoJ
         NyVw9BJtUsxrUA1GeUyQesoDoJ7qBKDoXg+eXjQ1alyMsA+IHlA+N8+g90fzw3m/S6wg
         vWwaI7LJHyRc2L5WcY+F59gOuxAntCVFefyYcGXPDvu1IL+7aqT7pYcKRl1tlXBSzgZs
         6suPtRH5SiMWmQEmB1Quqd7eH/zS8oM3gyAO2S5apf13qrldInKTfjGSqKJwlBOjY9UR
         KaFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:subject:message-id:mail-followup-to
         :references:mime-version:content-disposition:in-reply-to;
        bh=FkhQ6gqFJjzDNdIWz0kRoR/uK1k7q5+qk6RD2h5xBiY=;
        b=cCSLajDCZbZBJ0uc1Kio1FsNObTs4cahABQHh828Nk+ksbAYpNipl1QgZwKdC3LyxU
         epg1caiu5ZJn2wHTnSFS2xlkflHBJqvDgIfQRQZEXBVl7AmvSgspgAo070OXw/Yt+v+5
         2pBCJvLX2x/BAUDzhZ348uIOgUIkE/dOUSe6Jv2Fq1iTcXmMXuImb65gIYgCEBduUy3l
         tSYVRrEtTEwmdSj5VW8M9uyUl2T1bxP/P7VMkL+JEf795KC/8bZHimEUrS7Zn8GO676D
         qI76biLxG4S4/MPrptg9tdWUhm9VPhPt+EWRxa7OL+2hi8/ZGbjeabRlhtOqaKLw+ju0
         rHdQ==
X-Gm-Message-State: AOAM530Tls2/kBBkDp772JeX691mu8XEvQUWdAloN1Y9cOdSnX92MFBQ
        9tNTf6ciK424BVVNg8sWXiuPGiOU6fqzwg==
X-Google-Smtp-Source: ABdhPJxVeD8djMqe2fE0BJ+J6ZLqKntPQet4ReFfRiEOwzNqcylaJAaPkiBgYFRftrCWGKiVB/jr6Q==
X-Received: by 2002:a2e:a591:: with SMTP id m17mr14740123ljp.5.1632749426269;
        Mon, 27 Sep 2021 06:30:26 -0700 (PDT)
Received: from dj3ntoo (54.sub-72-106-71.myvzw.com. [72.106.71.54])
        by smtp.gmail.com with ESMTPSA id v199sm1595954lfa.234.2021.09.27.06.30.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Sep 2021 06:30:25 -0700 (PDT)
Date:   Mon, 27 Sep 2021 08:32:17 -0500
From:   Oskari Pirhonen <xxc3ncoredxx@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] tty/sysrq: More intuitive Shift handling
Message-ID: <YVHH4XqUYjvGZ+Ic@dj3ntoo>
Mail-Followup-To: Oskari Pirhonen <xxc3ncoredxx@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>, linux-kernel@vger.kernel.org
References: <YU/6SCmUr9qGkqBu@dj3ntoo>
 <YVFLo/aLbMWrmLtP@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YVFLo/aLbMWrmLtP@kroah.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 27, 2021 at 06:42:11AM +0200, Greg Kroah-Hartman wrote:
> On Sat, Sep 25, 2021 at 11:42:48PM -0500, Oskari Pirhonen wrote:
> > Make Alt-SysRq-Shift-<key> behave like Alt-Shift-SysRq-<key>.
> 
> Does some documentation also need to be updated here?

There wasn't any documentation about it to begin with which lead to the
patch in the first place. Documentation/admin-guide/sysrq.rst only says
this about it:

> How do I use the magic SysRq key?
> ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> 
> On x86
> 	You press the key combo :kbd:`ALT-SysRq-<command key>`.
>
> ... snip ...
>
> The :kbd:`<command key>` is case sensitive.

I couldn't figure out why an event I had registered onto a capital key
wasn't being triggered until a friend told me that I needed to press
Alt-Shift-SysRq-<key>. AFAICT, the only place that the proper keystroke
is even mentioned is in the commit message for a27eb0cb4b21:

> For already existing SysRq operations the user presses Alt-SysRq-<key>, and
> for the newly added ones Alt-Shift-SysRq-<key>.

If you think adding to the documentation is useful then I can submit a
v2. Although I believe that this patch makes it redundant since "case
sensitive" implies Shift, and for many people, the natural place to hit
the Shift key is likely to be right before the relevant <key>.

- Oskari
