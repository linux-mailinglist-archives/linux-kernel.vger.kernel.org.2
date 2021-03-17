Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3222F33FB6E
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Mar 2021 23:44:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229884AbhCQWn4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Mar 2021 18:43:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229707AbhCQWnn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Mar 2021 18:43:43 -0400
Received: from mail-io1-xd2f.google.com (mail-io1-xd2f.google.com [IPv6:2607:f8b0:4864:20::d2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7256C06174A
        for <linux-kernel@vger.kernel.org>; Wed, 17 Mar 2021 15:43:42 -0700 (PDT)
Received: by mail-io1-xd2f.google.com with SMTP id v3so265923ioq.2
        for <linux-kernel@vger.kernel.org>; Wed, 17 Mar 2021 15:43:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=T0M/PAXOO+j50lu6FBt2S8BVrDklBt3ZPhpsA7h6VIU=;
        b=FKbO9bkDIfk4bo8Mwm9dhYNZnlXFhXCK21RKldVdDI4L+kMlRS5xPSKmuNHAUax8Db
         PRd1eAjboV2nsqiFgeSCE0XPufR1igedDokyoi6kHnVwWk6doVXi0A43+MJlIl1S6VV0
         snon6E85q8Y8w5NfXGHghllT0MOiUgb2eliWMB00L+1cUiT+kU1SoJBeCxI2hVzXHWAz
         j4JMDFoVEcU3awEb51IVZqkNfKxFtbgGQJA76mPlLpO5/jqb3bj0cA4goDGG/i4yDYqZ
         +T+/FzQRwZQZHsFlhEKbkTSHOnA6xXgSxNBgadC40sG8ydSHuIKeVPobF/5PJkvlRWRp
         mZDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=T0M/PAXOO+j50lu6FBt2S8BVrDklBt3ZPhpsA7h6VIU=;
        b=LuULtOauRjTZ0zugNLMMzUJK0GZ2q6/TMdrQSAo12frBqgnO1vnZvVXhNrW5fJENrd
         QeB+TKSbz72zL1/lLQlYNWiPKC8nzkfZ6tRkbt7fxzAQB67vVLmZtXerXGC/hrS00TeX
         I4jq8eGdUl8iiueMfznYHq8Bf7M2MCDUh67bGtRuW+Z8wjlQTOG1LFK9srUkmDyr8OhL
         7gC+yDu7pPYtSjYYQhbpxKYvHS5s1Nz5N1VqshT+I6bvFa9Kpe3ehtbO38N9P+bYJQlI
         AlqKuKYTrNCQgW3w/RgxTrckambKT845fbcnkShGVAOiJbBjauwChwjZBp1p0W0AGSLl
         vO6A==
X-Gm-Message-State: AOAM532DyhMuWq/enR8OxttifpQrFctq9lOa7XE5oZpwSOZxP16ZBNoh
        7t92Ku7g+wXPD+uVSX+D80XJTzpIkt7KlLtIF8LL4eZ8DJc=
X-Google-Smtp-Source: ABdhPJz38+d4Us1reJyPt6zL7aG4QPIRGUPfM29fcCQMyQAZUympsEEUx7yKTm6LbfHap1SnllbQM0pahRbQdCZkx4o=
X-Received: by 2002:a5d:9e09:: with SMTP id h9mr8686152ioh.178.1616021022347;
 Wed, 17 Mar 2021 15:43:42 -0700 (PDT)
MIME-Version: 1.0
References: <92b7c57b-b645-9965-8157-4ca76a803cba@mev.co.uk>
 <20210316224227.348310-1-ztong0001@gmail.com> <20210317051426.GX2087@kadam>
 <CAA5qM4BcQ6+aa1C3_28zLVojwLduK-WZwsEftuasJgo8z0t0ew@mail.gmail.com> <20210317065248.GW21246@kadam>
In-Reply-To: <20210317065248.GW21246@kadam>
From:   Tong Zhang <ztong0001@gmail.com>
Date:   Wed, 17 Mar 2021 18:43:31 -0400
Message-ID: <CAA5qM4Bc5tW9QmeC7MKCO7yivxQrSfgVBwgyFLhipK9w=q7Scg@mail.gmail.com>
Subject: Re: [PATCH] staging: comedi: das800: fix request_irq() warn
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     "Alexander A. Klimov" <grandmaster@al2klimov.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        H Hartley Sweeten <hsweeten@visionengravers.com>,
        Ian Abbott <abbotti@mev.co.uk>, devel@driverdev.osuosl.org,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks for sharing those best practices, Dan.
I was wondering if there is a spelling checker for git.
