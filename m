Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 815E6420E5B
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Oct 2021 15:23:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234481AbhJDNYc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Oct 2021 09:24:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234809AbhJDNWg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Oct 2021 09:22:36 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41E6EC02C30C
        for <linux-kernel@vger.kernel.org>; Mon,  4 Oct 2021 05:58:19 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id bd28so64349421edb.9
        for <linux-kernel@vger.kernel.org>; Mon, 04 Oct 2021 05:58:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=zk3O9TQK1//WOIi/ON/RZazwkSzy3/FmBE6nDyw0bjA=;
        b=NwMfp26g1X7dGKbFyR8xTBwpDjzyWstmGs+tQh3LZk7hidJW862ga3YGOUvg765+gv
         +pvPXaZppmPgZ6W9E69h+w4St+RK0aGbD4Ks2UcUDbBAanw76vOfQD5A8ezniQovc9pl
         0e+qWB47IjGuAQ9Xi7fz+x4CEaMeu4O/ezN5flF8p6yVbcvuqgMCkpspzKfBG8jiS486
         JSzFkn7CCWJcS2HAEtTPDiT39A/aCq1l3FHA0NqZ8gX+A87YK19G5wy4sEax9p3HTKJq
         tDqsOw+NPgfnn/EfRG+tqEO7Ix4Z0dlIxwbMqze8owUBxAXc697U3OrmDf/hC9MvZ0+w
         HpaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=zk3O9TQK1//WOIi/ON/RZazwkSzy3/FmBE6nDyw0bjA=;
        b=EFF5vZyl2FMBhMC4WofRSudN72IUkcDZdus8F8C1ES25avdNfB6pQrSgHOCoMcZ0xo
         nxHDo3o82P3+H5YI3JaiWk9Ai7mXHXYWim5DttE3W6wDNRnsMvbroopZGgKtQAas58yV
         Rump4TQLMHS/wsEmUm53OsFda2ddYQl4ZWg8YdLLOsu3ouDbxyNeTxXhPIJX+UAJ7cDt
         xxD/U3YWTIH3crr2g++s2LXgEiv6nx+x15ogY5qwInBPdNZ8nPMWWg/3uJQg6U8UuQr3
         3t41yV+AymXKCDnOqOJt+5wNgYUBIc51VF/HZHipAgx4RuIAwols02QqNbDEN+C/s+fC
         K4ug==
X-Gm-Message-State: AOAM533S8BLvjYp2YNRMAfYweUdm2qCCqgGXj5/lillw4KcFCCIypntk
        kratVjWCZntpAqbiyZzJNNE=
X-Google-Smtp-Source: ABdhPJwgyb7vTCgDaVtSlZQiQwlz2Ek5XxE8H4ZXmw1WqRDb1MAQZKF5KfNvzbXMMwQa2Q5yQPa99w==
X-Received: by 2002:a17:906:7016:: with SMTP id n22mr4649614ejj.567.1633352289790;
        Mon, 04 Oct 2021 05:58:09 -0700 (PDT)
Received: from tom-ThinkBook-14-G2-ARE (net-5-94-68-71.cust.vodafonedsl.it. [5.94.68.71])
        by smtp.gmail.com with ESMTPSA id r1sm1386256edp.56.2021.10.04.05.58.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Oct 2021 05:58:08 -0700 (PDT)
Date:   Mon, 4 Oct 2021 14:58:06 +0200
From:   Tommaso Merciai <tomm.merciai@gmail.com>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Forest Bond <forest@alittletooquiet.net>,
        Lucas Henneman <lucas.henneman@linaro.org>,
        Yujia Qiao <rapiz@foxmail.com>,
        Madhumitha Prabakaran <madhumithabiw@gmail.com>,
        Marcos Antonio de Jesus Filho <mdejesusfilho@gmail.com>,
        Aldas =?utf-8?B?VGFyYcWha2V2acSNaXVz?= <aldas60@gmail.com>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Deepak R Varma <mh12gx2825@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 1/3] staging: vt6655: fix camelcase in bShortSlotTime
Message-ID: <20211004125806.GA140797@tom-ThinkBook-14-G2-ARE>
References: <20210926162527.21462-1-tomm.merciai@gmail.com>
 <20210926162527.21462-2-tomm.merciai@gmail.com>
 <YVHilhCk3cgGhXrZ@kroah.com>
 <20210927213515.GA6953@tom-desktop>
 <YVKdVCaVwmPG7DVx@kroah.com>
 <20210930214929.GB45822@tom-desktop>
 <20211004102632.GT2048@kadam>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211004102632.GT2048@kadam>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 04, 2021 at 01:26:32PM +0300, Dan Carpenter wrote:
> On Thu, Sep 30, 2021 at 11:49:29PM +0200, Tommaso Merciai wrote:
> > On Tue, Sep 28, 2021 at 06:43:00AM +0200, Greg Kroah-Hartman wrote:
> > > On Mon, Sep 27, 2021 at 11:35:15PM +0200, Tommaso Merciai wrote:
> > > > On Mon, Sep 27, 2021 at 05:26:14PM +0200, Greg Kroah-Hartman wrote:
> > > > > On Sun, Sep 26, 2021 at 06:25:18PM +0200, Tommaso Merciai wrote:
> > > > > > Replace camel case variable bShortSlotTime with snake case
> > > > > > variable b_short_slot_time.
> > > > > 
> > > > > That is a very odd variable name.  Why did you pick that one?
> > > > > 
> > > > > What deos it mean?
> > > > > 
> > > > > You do understand where the original naming format came from here, and
> > > > > what it was trying to represent, right?  If not, please go read up on
> > > > > it:
> > > > > 	https://en.wikipedia.org/wiki/Hungarian_notation
> > > > > 
> > > > > That style is not used in Linux, and so, when converting from it, do not
> > > > > attempt to keep the same style present here, that is kind of pointless,
> > > > > don't you agree?
> > > > 
> > > >   You are definitely right. What do you think about "short_slot_time"?
> > > 
> > > "time" implies that this will hold a value of time, right?
> > > 
> > > What exactly does this variable do?  That might help in naming it
> > > better.
> > 
> >   Is a boolean variable, if true short slot time mode is enabled, false 
> >   not right?
> >   A good solution could be: "short_slot_mode"? What do you think about?
> 
> No.  That's a confusing name.  What is a short slot mode anyway?
> 
> regards,
> dan carpenter

  Hi Dan,
  My bad sorry, "short_slot_time_en".

  "Use the short-slot-time configuration interface command to enable short slot
  time on the 802.11g, 2.4-GHz radio. Short slot time reduces the slot time
  from 20 microseconds to 9 microseconds, thereby increasing throughput."

  Reference:
  http://cciew.blogspot.com/2011/02/short-slot-time.html

  Let me know.

  Thanks,
  Tommaso
> 
