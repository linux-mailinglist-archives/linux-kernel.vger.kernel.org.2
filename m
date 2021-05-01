Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3763F370775
	for <lists+linux-kernel@lfdr.de>; Sat,  1 May 2021 15:56:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232192AbhEANzg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 1 May 2021 09:55:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232107AbhEANzb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 May 2021 09:55:31 -0400
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C35A7C06174A
        for <linux-kernel@vger.kernel.org>; Sat,  1 May 2021 06:54:40 -0700 (PDT)
Received: by mail-pg1-x532.google.com with SMTP id m12so538393pgr.9
        for <linux-kernel@vger.kernel.org>; Sat, 01 May 2021 06:54:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=P4/PB+MgwhpZsD33KnvGfrSSkSWrWWTMYh1p5TuaVTA=;
        b=OrdyFym5r6zsR5nsU2yAr7bvOBNS9J1nJJEeN2l+E3aUIpc8or4Bqv3Pl0Oq6yRoFl
         p8qFtYxVL3oFFCudi6Ba/um5527tr4VugP4lv1rj9a8N7ppNcb/PNesk52LHdQgz58OY
         eSGL4kC4Y87sCPZyTm0gqIxhR3DhF1cCAFHU/s/Hml+Z+cXyVwFktZdQk7U+fO/sZDJy
         4yND8Gcj/C7CostvlbxlfqLPxbAO129LydeP09iyZ1DpplVGhMmLDG/c3T6mxeiMWlmZ
         sUcYHGOwptj648ciA4VehvobY6LwlkalMIew61r5MkGyN2lZEZLVXNbN4UVurrdd7PxK
         Orbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=P4/PB+MgwhpZsD33KnvGfrSSkSWrWWTMYh1p5TuaVTA=;
        b=kSi+WEDQ39puH0ceJo6e8DdfRVThFq+vmjqX9MYYMuwb18UYQP4M4kYanecU7qPHEN
         dtIwD4SPl+QHeziDHQcpb9lpBWAF5UdGLlOIDqaCrDmxdlgnF3qU77c2BthZdHJQvov7
         GfikfvSX3B6vTEgYFzmbGWRZL8XqN3uYEz0p+FRLXb3A0tDZ5p1/3iFxMm6+uImB5aSk
         O5kxTsdeLXouKt/JYcvzPfLOBUHznCZPLxBFqsax0zXAF+uJvcxYy1ET377EpwEZ09ix
         /RQCdhUUkPa2UMqiWjopXnyqoOZyfEsZ8/Zm/0JoRyzwrR1XWkKKXGK3Hp1FI3MpCf/R
         sgig==
X-Gm-Message-State: AOAM531CFmZbIVqO9s8FSJHmTE0mt1obC4NKE4Ct4USMdmSHqquF0NbH
        2d2pURrJBDimp/+rGFINngM=
X-Google-Smtp-Source: ABdhPJxB3RvO7ssVkKkP/x5VI661W9AuwTSl0sxEiilEPRKJ04i304i6K1vxncAuwc7ntAX/9Z+SFQ==
X-Received: by 2002:a62:de01:0:b029:28d:572f:45c8 with SMTP id h1-20020a62de010000b029028d572f45c8mr5791023pfg.67.1619877280195;
        Sat, 01 May 2021 06:54:40 -0700 (PDT)
Received: from ashish-NUC8i5BEH ([122.177.225.134])
        by smtp.gmail.com with ESMTPSA id u13sm5512465pgm.41.2021.05.01.06.54.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 May 2021 06:54:39 -0700 (PDT)
From:   Ashish <eashishkalra@gmail.com>
X-Google-Original-From: Ashish <ashish@ashish-nuc8i5beh>
Date:   Sat, 1 May 2021 19:24:32 +0530
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Ashish Kalra <eashishkalra@gmail.com>,
        Ivan Safonov <insafonov@gmail.com>,
        Abheek Dhawan <adawesomeguy222@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Waiman Long <longman@redhat.com>,
        Pritthijit Nath <pritthijit.nath@icloud.com>,
        Allen Pais <apais@linux.microsoft.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] staging: wlan-ng: silence incorrect type in argument
 1 (different address spaces)
Message-ID: <YI1dmF0vDfH6lZHu@ashish-NUC8i5BEH>
References: <YI098DQNtK3i2Fge@ashish-NUC8i5BEH>
 <YI1IMG8tCvvRMq3i@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YI1IMG8tCvvRMq3i@kroah.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 01, 2021 at 02:23:12PM +0200, Greg Kroah-Hartman wrote:
> On Sat, May 01, 2021 at 05:09:28PM +0530, Ashish Kalra wrote:
> > Currently p80211knetdev_do_ioctl use type casting to req->data to prevent sparse warning while calling memdup_user, instead of type casting it here, its better to change data type for data inside p80211ioctl_req to include __user.
> 
> Please properly line-wrap your changelog comments.
> 
> Can you fix it up and resend it as v3?
> 
> thanks,
> 
> greg k-h
Thanks Greg for your feedback
Kindly ignore v3 and review v4, i have modified it as pe your feedback
