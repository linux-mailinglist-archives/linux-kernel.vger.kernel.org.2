Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E8A3449F19
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Nov 2021 00:42:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239202AbhKHXom (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Nov 2021 18:44:42 -0500
Received: from gw2.atmark-techno.com ([35.74.137.57]:52456 "EHLO
        gw2.atmark-techno.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231401AbhKHXok (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Nov 2021 18:44:40 -0500
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
        by gw2.atmark-techno.com (Postfix) with ESMTPS id 0B4E220D08
        for <linux-kernel@vger.kernel.org>; Tue,  9 Nov 2021 08:41:54 +0900 (JST)
Received: by mail-pl1-f199.google.com with SMTP id r11-20020a170902be0b00b0013f4f30d71cso7334886pls.21
        for <linux-kernel@vger.kernel.org>; Mon, 08 Nov 2021 15:41:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=9JYAOHc5Bzc8zfpQ0inqY9Jus/ttd4RsPfwt3JJBGgs=;
        b=iXGSD+3V9SWgrNQBEzQeTolfUROofNp0DW6CtA3S88DFr4C+YjhC3LbS2fFDhc7CJU
         T2w4yrIR4PTrGcqqyvEN1UP30qHGqg32RwNLUsBYqUGzmQH2M4b2jfqmQOnfVqfoQYfL
         UcnNSl58IXgZn732VL7Rs2TqQoY5ykAl8f1j8fZBg6G8yEiK2IPmHGBWKnUl5pNUU9gF
         mo5T6wx+vgPGX1bcI1OhGszPfME3/lNtRenMbUN/r8PX1WHJioApi3yr9edmu/qlX4GV
         EhzhaJxW9rQpzVaddr8VBrgnzO6Rp1jKF9+Ftxa+I0IJ61ci/ExFn2siNubz3tis5AZN
         MyRA==
X-Gm-Message-State: AOAM533CAJOwnl6s9gVaP6cwna76z3wIdXUnSX0PixxYKr9HPqxSCekw
        kPXa3HnZ9f46uFJuwBUunQn/tBqc3cDPLYhbBHfGVtZhY1/cnu4ZCsds1fLmkwgSuZWrms31uBc
        qdP5XI+GY74vW8YQFs18BRoOo7w==
X-Received: by 2002:a63:b54a:: with SMTP id u10mr2498356pgo.69.1636414913169;
        Mon, 08 Nov 2021 15:41:53 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwGtJSPNlUIj77nNviXLhyTvTLyu/pChs/rPD9a5gR5EudQZYF25eTXL+L5gjHwbBFkWtMLew==
X-Received: by 2002:a63:b54a:: with SMTP id u10mr2498335pgo.69.1636414912929;
        Mon, 08 Nov 2021 15:41:52 -0800 (PST)
Received: from pc-0115 (162.198.187.35.bc.googleusercontent.com. [35.187.198.162])
        by smtp.gmail.com with ESMTPSA id e14sm13407047pga.76.2021.11.08.15.41.52
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 08 Nov 2021 15:41:52 -0800 (PST)
Received: from martinet by pc-0115 with local (Exim 4.94.2)
        (envelope-from <martinet@pc-0115>)
        id 1mkEGt-0065Az-2P; Tue, 09 Nov 2021 08:41:51 +0900
Date:   Tue, 9 Nov 2021 08:41:41 +0900
From:   Dominique Martinet <dominique.martinet@atmark-techno.com>
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     Alessandro Zummo <a.zummo@towertech.it>, linux-rtc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] rtc-rv8803: fix writing back ctrl in flag register
Message-ID: <YYm1tb304Thqqjjj@atmark-techno.com>
References: <20211101013400.325855-1-dominique.martinet@atmark-techno.com>
 <YYiWq564QzQgTsqV@atmark-techno.com>
 <YYjjDW6WhBJqUGJD@piout.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YYjjDW6WhBJqUGJD@piout.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Alexandre Belloni wrote on Mon, Nov 08, 2021 at 09:42:53AM +0100:
> On 08/11/2021 12:16:59+0900, Dominique Martinet wrote:
> > Hi Alexandre, Alessandro,
> > 
> > the other patch was proved to be unneeded, but this one is still a valid
> > fix as far as I can understand the code (reusing RV8803_CTRL value to
> > write into RV8803_FLAG does not look correct)
> > 
> > (I'm also convinced either mostly work because the original values are
> > usually close enough, but that's not a reason to keep using the wrong
> > one)
> > 
> > 
> > Would you have time to take a look?
> 
> I did check with the initial review and I'm going to apply it, I just
> didn't have the time to do that yet.

Sorry, it wasn't clear to me whether this was dropped with the other or
not.

There's no hurry on my end, please apply when you can!


Thanks,
-- 
Dominique
