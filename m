Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E8DE834D245
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Mar 2021 16:19:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230271AbhC2OSn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Mar 2021 10:18:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229910AbhC2OSN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Mar 2021 10:18:13 -0400
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E197C061574
        for <linux-kernel@vger.kernel.org>; Mon, 29 Mar 2021 07:18:13 -0700 (PDT)
Received: by mail-pg1-x52d.google.com with SMTP id k8so341510pgf.4
        for <linux-kernel@vger.kernel.org>; Mon, 29 Mar 2021 07:18:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=D4ufLomD7FzzswLsbSlB2m6zdVHd1EjhBRWYbflvHJU=;
        b=fA0GZQPdCoAQ+NZLQjuduXSvG/v3opWwXuX4wZ64u4W+Ornd5zaqSzNt5MfEjJEAiE
         qBADzcmlpK7Fy/puXL7LwkXnYDugVbtOFVr5klXK5H+/ZCrIdjcAmHoKSzgODZKuOVbe
         Nswg1fJ5dOf4XM37Q3BFAQzOLMFrQuxbPz/7Gy7dz3sSDWBF+rrIkdclKifWjn9jh7vP
         uB8dHgo3RCnpe02dJPZjGrVda6wNE0yM+KfT1zN9NLMmsM/BFVldJiWamz+/JvlHv47l
         p+zFTIrwZX0UbCgBj4D21OajnZ/DavHks/eu1MI7ZseJJLiMfFy7H1sluFZJ+7cyOwZE
         4WjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=D4ufLomD7FzzswLsbSlB2m6zdVHd1EjhBRWYbflvHJU=;
        b=ePrBbxkHuMneyi5z8xXu65zK4fboffWS0YAgdw9VNSLfXPIK4mPWuo9afNqL7ZEBRx
         wmT5d8MWigLGiKdVGsZHlCGBmqMOxgc0geWmpRqS+5VPZCfmZjFJ9LiPwvcAaO1BJ6cO
         marDRhxPqc+qVej4Lagl42upSbx5o7i2D/8htJYstVuHYCfnVHmOADBuHSoJi9p87fky
         dGx97fV5eDeuJ7H66DSX98QXaR+Lch0NhAkWD5/4B+0fBxhwSDxg0rwb3Z2vG7kQxKpY
         VvOvAwmROWdVlH/cSFxU6cM27fQMpMQXjY18008MksVib+L0FZEC8IcTBP1j+qnjWPL4
         rrag==
X-Gm-Message-State: AOAM533TCHTzGv7TF/epPQV01p2xRc865rM3oNJTSXRmeGEo0y6p0KjF
        xqtp5xkCnn+2iinF9OmGEaI=
X-Google-Smtp-Source: ABdhPJyFTXcpNeDvsQhLA7PnQS1wRDEG/DZtGmR3dLxNReHR18QCu30WeycftWbZg7jmD77wd0FHwA==
X-Received: by 2002:aa7:8498:0:b029:1f6:8a25:7ade with SMTP id u24-20020aa784980000b02901f68a257ademr25406975pfn.76.1617027492647;
        Mon, 29 Mar 2021 07:18:12 -0700 (PDT)
Received: from hoboy.vegasvil.org ([2601:645:c000:3c:e2d5:5eff:fea5:802f])
        by smtp.gmail.com with ESMTPSA id l25sm17598543pgu.72.2021.03.29.07.18.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Mar 2021 07:18:12 -0700 (PDT)
Date:   Mon, 29 Mar 2021 07:18:09 -0700
From:   Richard Cochran <richardcochran@gmail.com>
To:     Daphne Preston-Kendal <dpk@nonceword.org>
Cc:     Miroslav Lichvar <mlichvar@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>,
        John Stultz <john.stultz@linaro.org>,
        "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com>
Subject: Re: [Bug 212265] New: clock_gettime(CLOCK_TAI, ...) should return an
 error when TAI has not been configured
Message-ID: <20210329141809.GA20909@hoboy.vegasvil.org>
References: <YGGbAIoCKDbZLQQ0@localhost>
 <2505F20D-ED84-4B36-9504-8A8C756C992E@nonceword.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2505F20D-ED84-4B36-9504-8A8C756C992E@nonceword.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 29, 2021 at 11:56:31AM +0200, Daphne Preston-Kendal wrote:
> > The other is that the kernel updates the offset when a leap
> > second is inserted/deleted even if the original offset is zero, so
> > checking for zero (in the kernel or an application) works only until
> > the first leap second after boot.
> 
> This is a problem and definitely speaks for having a way to tell whether CLOCK_TAI has been set up at all.

+1

Thanks,
Richard

