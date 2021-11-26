Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9BB0645E88E
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Nov 2021 08:39:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359281AbhKZHmb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Nov 2021 02:42:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359344AbhKZHka (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Nov 2021 02:40:30 -0500
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 414F1C0613FA
        for <linux-kernel@vger.kernel.org>; Thu, 25 Nov 2021 23:36:09 -0800 (PST)
Received: by mail-ed1-x52d.google.com with SMTP id r25so35043671edq.7
        for <linux-kernel@vger.kernel.org>; Thu, 25 Nov 2021 23:36:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=elJioYNUbOzp4AX6n16wfmeroXlPwEb1AcJcD/HfIlo=;
        b=cuYI5lX/w13XGoVbijkOcO0Df4iXXCO1KO1DxzVauzOtOpZ0r0mFw6GSEMYZO/MhCk
         C+fYevTdEUz6ikNlEUUntAM1UVhHtIRY7L9oQpVQd0vSsa1uVTnJTnoKX6zjd2q1Vjhb
         6qQx+JTKIEl/UW7oDydJaJ+S2NWWVFnbuTVDyLaEZBH2YTP9P3SG6bFp1r2k0QsEQUl8
         jgIRKNdHqIXML1bZP0VzKqxE9tUWPZcNyD1lv6LWBCjcAjUDloHEA86g5QrPKgtKrpLD
         M8/G+zxvjWHcHUUQ30sg6gJdilMsshmSs/p6DCcKC+XBJB4s/OX+uZ/a0gjzJtyJ6Dz5
         Yj2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=elJioYNUbOzp4AX6n16wfmeroXlPwEb1AcJcD/HfIlo=;
        b=eezwJZ2uI9lToGlG6ts0nQ9EChcKiNY5/7H4noncJt4lZ5o5bZhZ+VDpu70GgmWc+0
         0ywpN2OZwe710dn++Z2pSxTAZcTjMvyigCQAYqZejO9jYbuPayCa3BM7bhJuyNT6h5aL
         afo3dh3uNOpQyV7kXrNr2MixGlAPx6Ht0qKAZnn6wGYi+LJiWYqJdN+2W8ymbpNOSHYL
         wdQx+9pIglT1gNzxM1SWxwEYQMxjaQpzEg7hj3xUVOeJAWAbTimjspfW3/9lFhofCKad
         yBVQ4PX2OmarZkphQYvZtQZdSQ2w0nGINKKmCkh0W8qJspMDSElGopwM2MrDL4JdyaaE
         Y67A==
X-Gm-Message-State: AOAM533dbtiCAOwpfowChJVQ7gGmYNiTpf2RF1fZrxy3xP/mXwkUi4OV
        M4CrnY1P9uvf31L2VGpV1E4=
X-Google-Smtp-Source: ABdhPJziieAYsblkX51ypxlNpIpLASnQWiqy4Ol2QSm24dq/SP/qvVTPJVxq7n6D39x3WcD7zizgOw==
X-Received: by 2002:a17:907:608f:: with SMTP id ht15mr1635858ejc.300.1637912167916;
        Thu, 25 Nov 2021 23:36:07 -0800 (PST)
Received: from alb3rt0-VirtualBox ([151.22.100.250])
        by smtp.gmail.com with ESMTPSA id k21sm3169110edo.87.2021.11.25.23.36.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Nov 2021 23:36:07 -0800 (PST)
Date:   Fri, 26 Nov 2021 08:36:05 +0100
From:   Alberto Merciai <alb3rt0.m3rciai@gmail.com>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     joe@perches.com, forest@alittletooquiet.net,
        karolinadrobnik@gmail.com, lucas.henneman@linaro.org,
        dan.carpenter@oracle.com, tomm.merciai@gmail.com,
        eantoranz@gmail.com, linux-kernel@vger.kernel.org,
        linux-staging@lists.linux.dev
Subject: Re: [PATCH v5] staging: vt6655: refactor camelcase uCurrRSSI to
 current_rssi
Message-ID: <20211126073605.GA4537@alb3rt0-VirtualBox>
References: <20211118211128.GA156436@t470p>
 <YZ+9yDiG1SoWrWED@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YZ+9yDiG1SoWrWED@kroah.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> I'm totally lost, sorry.
I did a bit confusion, I'm lost too... :P

> Please resend this again and properly set the version number.
Sure, I will.

Thanks,
Alberto


