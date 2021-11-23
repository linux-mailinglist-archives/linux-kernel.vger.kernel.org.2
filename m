Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 80E1B45A6D0
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Nov 2021 16:50:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236345AbhKWPxw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Nov 2021 10:53:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232147AbhKWPxv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Nov 2021 10:53:51 -0500
Received: from mail-ot1-x334.google.com (mail-ot1-x334.google.com [IPv6:2607:f8b0:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46BDAC061574;
        Tue, 23 Nov 2021 07:50:43 -0800 (PST)
Received: by mail-ot1-x334.google.com with SMTP id x19-20020a9d7053000000b0055c8b39420bso34428004otj.1;
        Tue, 23 Nov 2021 07:50:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=4hIzh/yH7twyHCgqG/Qpcvvbzjw8p7UTAPXaSEcQbuY=;
        b=BYsFLg4ZuSznGm+fVSngbOtutw4wt2pIMFeNqOcJnDQQ+kyk+htspNcsyLAMymOS/T
         tScYg7OyC7qgBPEJ32zIKNNkvsVg8/hDdL3i7om6o5W8+SqG8eyHZAKPHhlBs/Ff0vec
         mPUOmT8M+x2YQGSgK5vPj+qwyKLkHMMpJjxny9pds3HVk48YmNGMVGiq1GLidz6MSZUa
         Bu0iGwS9H5FMnNa2PAxunIfdFb0SadkuxMxyvusOCcw3hNe10wbFe6FKHfbdaxN1s7k6
         HNHbHJ8vMJBB1iqaZ82173FJhiGj20HDCn2z35gFV3fxG3g2PIpObi0dgdrfdIjDgKdD
         kD9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=4hIzh/yH7twyHCgqG/Qpcvvbzjw8p7UTAPXaSEcQbuY=;
        b=OS38JH/7yLQ49zltYJMV/b5zfrmY868Y7SAcC4R1HPV6kGZMqRs/+maxV9wCHLmC0D
         GQegdkWgFO61m0/WXKTHC1ErZLIVarJOy/6V8OCnIV4454K7yZCnfMQT3aPV8kdDw9X+
         jVHjyAYSQM11HOKL6Lhnj1XSCYpdUIEP/gh4ttVu1fB+o2GNZNWdElrufB9g5A1TDqnG
         H8LaVINdiEA2lE8BS1U/nmzTrjsYEoDdfohv5kYtsOOzSR0XqzSywcmI0crCiyppwofe
         CazHvrA1xqh9gSIcF5jD5tZE7EBMC8pAcfdmbKyCKvZuAuIBlz6Ean6CHLGL3yXWsyVK
         kcxw==
X-Gm-Message-State: AOAM532VTjcSF/JRq1cu9k0DwOupd9Q8XR0/g4okWvhomiteMSgbPkRl
        NHoo/sKFhOZy0DeqP4XjFAk=
X-Google-Smtp-Source: ABdhPJxKZp/qWH8tknhZHGj0FM76Yb4ZXcCbSD8Bm3uQZFpzGA2/8oUDhNGLOaJueTuscmZ2u35Qtg==
X-Received: by 2002:a05:6830:264d:: with SMTP id f13mr5415353otu.43.1637682642641;
        Tue, 23 Nov 2021 07:50:42 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id w17sm550237oth.17.2021.11.23.07.50.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Nov 2021 07:50:42 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Tue, 23 Nov 2021 07:50:40 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Denis Pauk <pauk.denis@gmail.com>,
        Eugene Shalygin <eugene.shalygin@gmail.com>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        thomas@weissschuh.net, Ed Brindley <kernel@maidavale.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Jean Delvare <jdelvare@suse.com>,
        Jonathan Corbet <corbet@lwn.net>, linux-hwmon@vger.kernel.org,
        Linux Documentation List <linux-doc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v12 0/2] Update ASUS WMI supported boards
Message-ID: <20211123155040.GA2184678@roeck-us.net>
References: <20211116205744.381790-1-pauk.denis@gmail.com>
 <f0bf01fa-ccd8-3a6a-8fd2-4c785fa212ef@roeck-us.net>
 <CAHp75Vfbh+O39C_k9zQqSqsoSro7_gv6QmsxgmdO=woA32Q0HQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHp75Vfbh+O39C_k9zQqSqsoSro7_gv6QmsxgmdO=woA32Q0HQ@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 23, 2021 at 12:22:46PM +0200, Andy Shevchenko wrote:
> >
> > Series applied to hwmon-next.
> 
> What is the repository it has been applied to? I don't see it in
> neither Linux Next nor [1]. It might be that I am missing the
> workflow.
> 

I had not pushed the branch out. Done now.

Guenter
