Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DEC6D3628FD
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Apr 2021 21:57:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244523AbhDPT6H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Apr 2021 15:58:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243879AbhDPT6F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Apr 2021 15:58:05 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83CFDC061574
        for <linux-kernel@vger.kernel.org>; Fri, 16 Apr 2021 12:57:40 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id u15so6001378plf.10
        for <linux-kernel@vger.kernel.org>; Fri, 16 Apr 2021 12:57:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:from:in-reply-to:to:cc:subject
         :content-transfer-encoding;
        bh=1ie6hM/smrfhCEhy832cA4m2Ud/Z60E44UvGH/esV8w=;
        b=fhahKhOIEWDZ8APHmM+SL4Alq/XzPbT4dyx0KU63rxFazMFKr0MoZN3jDefqPagC34
         YvwAXBG0FBcNLJnm6W0W83f8zgwlB6S/EXD24snDOJjTgDoDxEKUB33L/17e89OqWT0p
         XYtEfrmOCYySiuPWpd9hFMTKDTPUwcPGHGGHzEXB0bJ5wzsFFA7Oz9v+IzqJxdnaPEQz
         2wXkG7QQ94CPipMzhEIHf2QrHDdxIYw16sWI7NqMvktePou/ktAPV4a44BLMzZjVKq4Z
         1n4NYPBMJo2fqI8yWg0RtLdMxYQXBPKu5E5+zLHQRGxHouYdQQZ9VTdLGwgWG60hBRLG
         2yxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:from:in-reply-to:to:cc:subject
         :content-transfer-encoding;
        bh=1ie6hM/smrfhCEhy832cA4m2Ud/Z60E44UvGH/esV8w=;
        b=VSmOS2IQr2IMhLAJq7TurA+LZNjkLR5fSkIDSBZIUYVT2W1mBQRK2Bfk2X/dYHSLQJ
         Ym8829gKEjAa1VTYMLGYUbeSiZZf7Pj9lbFuFegcbeX9r8gSFc4u+JpSlaVLdAeQp057
         pasi+1zIImLzN/DqCQa8o6j2+Q+cGoaIU0wRsnNXHuGXoCsqZ78HpBN0OErK6oFzEVfV
         pqjQoRyhURXhAbzM0Ph9Gtbem79rJb3gue75Bu6iHRF1T/QTKx6IiFJtN9COpRnfenZY
         pPWJVEOpaFMVvnAUl28xpCzLgM/nYg1KGbsawsq6ojQgHrjrPKHYiGbgXzyKlEWBnNNr
         5Ibg==
X-Gm-Message-State: AOAM532x0e6ErsCS1AoJpw6x9yskARIafcEa1cx/xokaqfnnVgrO8Srs
        1xoV8+4Yrhj0/1pLAjTCb9vX+SfrrmdBWiOjqAU=
X-Google-Smtp-Source: ABdhPJzbrhVBeY+5/yDLivuPKPdbRmaabRQjIDQzzswp62ZB5GSi8pTKY/fWiBM80+JAWvqt51jzHg==
X-Received: by 2002:a17:90a:3f08:: with SMTP id l8mr11318647pjc.136.1618603059739;
        Fri, 16 Apr 2021 12:57:39 -0700 (PDT)
Received: from cl-arch-kdev (cl-arch-kdev.xen.prgmr.com. [2605:2700:0:2:a800:ff:fed6:fc0d])
        by smtp.gmail.com with ESMTPSA id m11sm6109528pgs.4.2021.04.16.12.57.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Apr 2021 12:57:39 -0700 (PDT)
Message-ID: <6079ec33.1c69fb81.c2d4e.1d09@mx.google.com>
Date:   Fri, 16 Apr 2021 12:57:39 -0700 (PDT)
X-Google-Original-Date: Fri, 16 Apr 2021 19:57:38 GMT
From:   Fox Chen <foxhlchen@gmail.com>
In-Reply-To: <20210415144413.165663182@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: RE: [PATCH 5.10 00/25] 5.10.31-rc1 review
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 15 Apr 2021 16:47:54 +0200, Greg Kroah-Hartman <gregkh@linuxfoundation.org> wrote:
> This is the start of the stable review cycle for the 5.10.31 release.
> There are 25 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sat, 17 Apr 2021 14:44:01 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.10.31-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.10.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h
> 

5.10.31-rc1 Successfully Compiled and booted on my Raspberry PI 4b (8g) (bcm2711)
                
Tested-by: Fox Chen <foxhlchen@gmail.com>

