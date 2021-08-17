Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2F8DC3EF280
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Aug 2021 21:10:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232635AbhHQTKv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Aug 2021 15:10:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229821AbhHQTKv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Aug 2021 15:10:51 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6737CC061764;
        Tue, 17 Aug 2021 12:10:17 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id b15so40615492ejg.10;
        Tue, 17 Aug 2021 12:10:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=fNUaLXFLG+wj8ldkbcj9saful+qUbCDw4Gvu3Os7KHs=;
        b=YI7NXvjZMH4TmhuZwgf/UDCpfz/Zca+kKznHDC0IsShNfYxrHqsUK8Iz8GN/Mme9w0
         Tabu+e9WPR0OjtBO4fWZuijvNhTLTwLLrL4c8hwIf9YMNcWctNfXijMSdpnKW0KhnSC1
         +vyu7u6dEar1waRjtKUFMw7XHB1oPGHQ8ZIzoegoZwEWVLri9pzlsupBk6KV0h5mnpRb
         R5KLGSH66tIhPqkisYToLByYK/6nEYOwlLnBjI8jL7ofdXT4dF1APB17+APuoUJdzSbA
         PnsKJth93amwB2VVZbH789X699NHgpAi9Tb6ajCkD7vO199h1l21PcTMx/VPRtXz6zOJ
         NAGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=fNUaLXFLG+wj8ldkbcj9saful+qUbCDw4Gvu3Os7KHs=;
        b=RhjUMtxRKpLehWxshTdbFlJKU1YiFSh91buya1dMUy6I8QP4RoyXa0sLmiF8g2/tXn
         rndhzDNWnUynQPZ/UilrGvbBPY8v+tyBzoCNl4nxhh5fEhs2VKHUTBmJdV2nkVCnriK7
         XCmg84w17mJXFnA8SOT5kq/GPH0sTwiPfcBZiUx6mijkPf3KlDri6jUW4/P7B0nSApXA
         pBhvBhDNeywOcoX43p2zmx4cMW+I/9ah+/UW0APDkrWB8nky1opb0vaK8Cl5JzmHcB+e
         f23vC0vZ2ebmg0Q/19Va3G0kfyu/NRTrgh42Z5eUZ+VNen/Pcvs2eVGO5MEOZt/jmdR0
         /JfQ==
X-Gm-Message-State: AOAM532OivzLGes/oaDKR7QWnhIJtWL34xRXxF/8PWfCC30PVvXYD230
        r3UjWVFKGRm8LjgW6H37MYI=
X-Google-Smtp-Source: ABdhPJzK7D5cY1IJsYPhrypljlWbZ2z3JKJ6wLkuo7S7DyYlewC3hSjrRbjhLWYhm7qQIDNzOO6iLA==
X-Received: by 2002:a17:907:c11:: with SMTP id ga17mr5448780ejc.298.1629227416030;
        Tue, 17 Aug 2021 12:10:16 -0700 (PDT)
Received: from localhost.localdomain (host-79-22-109-211.retail.telecomitalia.it. [79.22.109.211])
        by smtp.gmail.com with ESMTPSA id j29sm1130687ejo.10.2021.08.17.12.10.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Aug 2021 12:10:15 -0700 (PDT)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     Aakash Hemadri <aakashhemadri123@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Shuah Khan <skhan@linuxfoundation.org>,
        Bjorn Helgaas <bjorn@helgaas.com>,
        linux-staging@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] staging: rtl8732bs: Fix sparse warnings
Date:   Tue, 17 Aug 2021 21:10:14 +0200
Message-ID: <1648303.FNMM0ZEVYy@localhost.localdomain>
In-Reply-To: <YRv3w4y3r84mBjrU@kroah.com>
References: <cover.1629134725.git.aakashhemadri123@gmail.com> <YRv3w4y3r84mBjrU@kroah.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday, August 17, 2021 7:54:11 PM CEST Greg Kroah-Hartman wrote:
> On Mon, Aug 16, 2021 at 11:00:41PM +0530, Aakash Hemadri wrote:
> > This patchset fixes the below sparse warnings
> > 
> > rtw_security.c:72:50: warning: incorrect type in assignment (different base types)
> > rtw_security.c:72:50:    expected restricted __le32 [usertype]
> > rtw_security.c:72:50:    got unsigned int
> >
> > [...]
> 
> This series does not apply to my tree at all.  Please fix up and rebase
> and resubmit, after reading the mailing list archives for others that
> have attempted do do this type of work in the past for this issue.
> 
> It is not a trivial change that is needed...

Dear Greg,

As I've already pointed out in another message of this thread, your tree has 
already these sparse warnings fixed by me with commit aef1c966a364 (that 
you applied with a "much nicer!" comment).

So, when Aakash rebases against your current tree, he will not anymore see
those sparse warnings.

Thanks,

Fabio


> 
> thanks,
> 
> greg k-h
> 




