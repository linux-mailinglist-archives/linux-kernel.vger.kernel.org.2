Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0235038163A
	for <lists+linux-kernel@lfdr.de>; Sat, 15 May 2021 07:58:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234406AbhEOF7z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 15 May 2021 01:59:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234371AbhEOF7z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 May 2021 01:59:55 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC30CC06174A
        for <linux-kernel@vger.kernel.org>; Fri, 14 May 2021 22:58:41 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id v191so1240895pfc.8
        for <linux-kernel@vger.kernel.org>; Fri, 14 May 2021 22:58:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=quQuju5BxZq7ggpYY/T9Kt5b+6CSVPIxgVITVpTO9KE=;
        b=dmczgfn23HkMnD/1xckytRmAxOEBCMjhQol0JKvon7mdsbADKsibwKa5LdREdNxIMz
         UfXbyix4s5gKro/VyECzHGwpKfyG61q4jlmwunoSaRm7BoieCKo4hXGntOI1/KAKntKb
         iK5FV4YscaerZZG7FOqsNs9A74r0/OMwG3QLOWC8OE2k3H5gD2p+ObQi353s+I3bm0UR
         5A6QxPH53jcTi6+c92wsOdEahmKFEfKxt1qHRBXZkG5lv9/JRfFdv42bk0/vJB5pZx5s
         5xOgDJtZ0iiyO9nNnKowPc6xjSUTPxw/OBqMUz1jKmh9BHJwZ5xGX/yTS8vqJkXyDqed
         6vLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=quQuju5BxZq7ggpYY/T9Kt5b+6CSVPIxgVITVpTO9KE=;
        b=JMfcSU3wiryrALZddGsK/KpeiCI2byBCFjv/0iUavzGmF0dr2cfjFbVGMlZ1Bzkhjj
         OoMfCtJHHc7cOcHnLmWvjDdRa7JT4OzDw2kw1XRUu7hN/EV7DstgGJtfI8NC2wmD2Z9Y
         L1btmtbc5Q/fhB/oXA8tVRO00pW5zOCDtNEs/brAqY6xPRihQAm7bX00REV/m6pceckX
         HwOO+KgWLx6YzQK+BuLGf21M759Y3kLDQRXhwN/6S8vfyRTKrYKsez1laU433aHikWJ8
         Z4BvvZLPsUd3hIT2jEcjsmim7tl/smUooUXD8B3DTNkQ+q6M6R/oxjGoIYlBcDSwSTEE
         X1hQ==
X-Gm-Message-State: AOAM531mAdFzOM9lupuZFidwvWU8diUpyAGZbeAFTWILwGhHK3itKzRn
        Hm9Uf1ZY/JpYzAUHKFesT6Q=
X-Google-Smtp-Source: ABdhPJx8Caznyp43VzJam8uwjnUsmT5GcJV648F6RKyUhtq6e6ZR5fRzb9XJhVzQTYjyBE2FcxJ0Vw==
X-Received: by 2002:aa7:8692:0:b029:28e:7bfd:655c with SMTP id d18-20020aa786920000b029028e7bfd655cmr49841220pfo.81.1621058321063;
        Fri, 14 May 2021 22:58:41 -0700 (PDT)
Received: from fedora ([2405:201:6008:61b4:4e16:5348:d963:c66d])
        by smtp.gmail.com with ESMTPSA id a10sm1082534pjs.39.2021.05.14.22.58.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 May 2021 22:58:40 -0700 (PDT)
Date:   Sat, 15 May 2021 11:28:17 +0530
From:   Shreyansh Chouhan <chouhan.shreyansh630@gmail.com>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     pure.logic@nexus-software.ie, johan@kernel.org, elder@kernel.org,
        greybus-dev@lists.linaro.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: greybus: add declare_ to declaring macros
Message-ID: <YJ9i+T5IfaDwdaBX@fedora>
References: <20210515034116.660895-1-chouhan.shreyansh630@gmail.com>
 <YJ9dDwKMKkifeICJ@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YJ9dDwKMKkifeICJ@kroah.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 15, 2021 at 07:33:03AM +0200, Greg KH wrote:
> On Sat, May 15, 2021 at 09:11:16AM +0530, Shreyansh Chouhan wrote:
> > Prefixed the names of all the macros that were used for declaring things
> > with 'declare_'. This should help with clarifying about what these
> > macros do.
> 
> Thanks, but I think I will leave the code as-is.  It's a good "test" for
> people who try to modify the code without actually building it :)
> 

Oh. Okay, I will try fixing something that might actually be a coding
style issue this time then. :)

> greg k-h

Regards,
Shreyansh Chouhan.
