Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A4D10421805
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Oct 2021 21:55:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235172AbhJDT5b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Oct 2021 15:57:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234948AbhJDT5a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Oct 2021 15:57:30 -0400
Received: from mail-vk1-xa2c.google.com (mail-vk1-xa2c.google.com [IPv6:2607:f8b0:4864:20::a2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B75EC061745
        for <linux-kernel@vger.kernel.org>; Mon,  4 Oct 2021 12:55:41 -0700 (PDT)
Received: by mail-vk1-xa2c.google.com with SMTP id n85so1750250vkf.10
        for <linux-kernel@vger.kernel.org>; Mon, 04 Oct 2021 12:55:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=1cjW8j5qiFKWJTLZksv9J4aCIUECPaF+CluJ5OjAoO4=;
        b=BCMocplaoN34MWnOC9nIj6WfSV3dZcA3yccvdaPUSi8I/M46gKsAaGeKg+/KXNWClo
         umo83kURwYXemruins5LXTs5Xh4+JD7CQdVuIOj467QWs94PjvANEj9ReVGm7JUeY9F+
         kuoG7YU7WrIVlnr2cQk0ckmj3MeuAB5F2Gb5Vn7eVC/stVyb3xmyfr9bkSlvg9+Bf+uB
         UsHfMrpnolvQIOp4h1RmoU8Z2q9Ii1Nkd7IPIfnmZWPi1SwgaNleHPgWUcnBheRnpES4
         aUz2wCF1ySTJxvtl+512zX9hIiRj/gXDiKPqT2EJywMEn6qVILLjxVVwNuXBpYfJhgBF
         8t7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=1cjW8j5qiFKWJTLZksv9J4aCIUECPaF+CluJ5OjAoO4=;
        b=4W3ZiFslmY93fj4dgXFC/Ouc+jii1aJaXzWWexmb3QgT9+Wr5diKk8zNdPbgIQU+w4
         9yrOmNc+qN9Tq2puzs6F/glq2jTd3C/cgqG9QBpd4iym2QFdKfHJoHZ4tCtycCkWJOQ3
         qKrl2AS4MD8iS30wtLIDLUINSZr2uoxMezVq2whirTWbcRDryQlFS6aWvE9Rwui3hlVx
         ulYHdTnHUZdnZS1UHzQCzSbQmtwbfqpv/g0/hrSJHrqrnO4gTJEy5w1o2S6ufrhjZHxi
         y1VkFegAM7GvkoSIi/k/PJvWXMvKh5kIHVqj8VR0GrFsVqeesWBnUuDRq1+5y6PalqYT
         vGmw==
X-Gm-Message-State: AOAM5320o99nHoWBLueqOZ5pjxlzRXuzGMWu5s+seDbcVK2Guh6O4QaU
        HSUAGXz4nhdROkU+rdcD0+Q=
X-Google-Smtp-Source: ABdhPJz2klPrPO+0amQazno69BogkeOH6HwuIBxJ6Sad4/cSUyBUFKEKAi0EqQDPYgi/4UHeeaRU2g==
X-Received: by 2002:a05:6122:658:: with SMTP id h24mr6894381vkp.15.1633377340222;
        Mon, 04 Oct 2021 12:55:40 -0700 (PDT)
Received: from localhost.localdomain ([181.166.206.110])
        by smtp.gmail.com with ESMTPSA id w186sm6416147vkd.51.2021.10.04.12.55.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Oct 2021 12:55:39 -0700 (PDT)
Date:   Mon, 4 Oct 2021 16:55:17 -0300
From:   Gaston Gonzalez <gascoar@gmail.com>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     linux-staging@lists.linux.dev, gregkh@linuxfoundation.org,
        nsaenz@kernel.org, stefan.wahren@i2se.com, arnd@arndb.de,
        ojaswin98@gmail.com, amarjargal16@gmail.com,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        bcm-kernel-feedback-list@broadcom.com,
        linux-kernel@vger.kernel.org, gascoar@gmail.com
Subject: Re: [PATCH 1/9] staging: vchiq_core: cleanup blank lines
Message-ID: <YVtcJZ16FknbVp3E@localhost.localdomain>
References: <20211003195758.36572-1-gascoar@gmail.com>
 <20211003195758.36572-2-gascoar@gmail.com>
 <20211004065511.GC2083@kadam>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211004065511.GC2083@kadam>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 04, 2021 at 09:55:11AM +0300, Dan Carpenter wrote:
> On Sun, Oct 03, 2021 at 04:57:51PM -0300, Gaston Gonzalez wrote:
> > Remove unnecessary blank lines.
> > 
> > Reported by checkpatch.pl
> > 
> > Signed-off-by: Gaston Gonzalez <gascoar@gmail.com>
> > ---
> 
> [ snip ]
> 
> > @@ -3207,7 +3206,6 @@ enum vchiq_status vchiq_bulk_transfer(unsigned int handle,
> >  	}
> >  
> >  	state = service->state;
> > -
> >  	queue = (dir == VCHIQ_BULK_TRANSMIT) ?
> >  		&service->bulk_tx : &service->bulk_rx;
> >  
> 
> 
> I don't care one way or the other about the blank line, but it's
> not a checkpatch warning.
>

Thanks for the review Dan.

Of course you are right... This was not supposed to be here, I'm sorry.

Please drop the series, I'll a send a v2.

Thanks,

Gaston

> regards,
> dan carpenter
>
