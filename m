Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A9ACC3D2EBC
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jul 2021 23:08:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231486AbhGVU17 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jul 2021 16:27:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230455AbhGVU16 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jul 2021 16:27:58 -0400
Received: from mail-qt1-x830.google.com (mail-qt1-x830.google.com [IPv6:2607:f8b0:4864:20::830])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E49C9C061575
        for <linux-kernel@vger.kernel.org>; Thu, 22 Jul 2021 14:08:31 -0700 (PDT)
Received: by mail-qt1-x830.google.com with SMTP id a12so337269qtb.2
        for <linux-kernel@vger.kernel.org>; Thu, 22 Jul 2021 14:08:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:to:reply-to:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=dwdE0V05hSlBc59EbhROwdrAQNEFzlHr4chzh9v97tw=;
        b=BjiLKwS5E1N2X2j1p1aB2fTEbDG8ypOBEli6LBHjpyjz2fWYD7NAk62jfybxYQdsmm
         SK9Qf6XVmxStpTmxrTNbe8YxK72rUAhctuYtDyBm7ppJBC43lQAJb6BjKRAT2cGPYe0l
         idrZTaj6HoitDv0O+YgTHT/KMYrhkim0jo24fw7AADbAsfUky1tvwxhgSTJk2cLTZMNB
         DcmwSpSCIiOF6A5NWCIUD8lzyzYV0KtFoUAMMfEOS3wvd3ZeoaQYrAzibtwGFynvBAQ9
         RSvfKnVPD7bJQKJonKsVstUlMHuZqnfxCUG/lsqSC4bgg8Hd1Av/iCFIzP2CkJI0XfAO
         0LPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:reply-to:references:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=dwdE0V05hSlBc59EbhROwdrAQNEFzlHr4chzh9v97tw=;
        b=CNTjtIltXQMTKJx3iBfR9qIQMdLLBeMRhFHXmIw8nMBT4lIndhY2nep+lAiHmRRqMX
         nNUbTMrtdXyCGdy5pfGlraeKUk/CYkX2Xx1IiYo3grRQETNYDsDDXomM07QLA+7aEVa2
         W3TyIVBChfVtanYUIIzVa5wBXjPmmbO8LxMUr4e/VIMniKCFFCykvqqQGjaa48Fw6Viw
         tzkqBs2h/gzU0Fm+kvuBRfXyJK5pYCJjHZY+zG/HfD9msBAFAAVlhQdEVgM9zw68ZpOR
         GyyCxSq49SpKwxGbHQrKKBixVPI801UDmP5DOr3fNpQGYq49tNJITj9QGphf2fDt0S2h
         7Qxw==
X-Gm-Message-State: AOAM532wKYGYVTS1Re579e30qgL8RogytGSLcbdjtcCFY4vjncnpcUVv
        4OcfrN5q21seoH9w359z+Gi8F7sUCq4=
X-Google-Smtp-Source: ABdhPJx8BZrwNgGD2D6lZraoqaDfG5sCekurdFoFpC8Gtdg6Oto1413jH0i5bkqNf5RiTqtMHm0lYg==
X-Received: by 2002:ac8:7d44:: with SMTP id h4mr1457537qtb.101.1626988110951;
        Thu, 22 Jul 2021 14:08:30 -0700 (PDT)
Received: from mua.localhost ([2600:1700:e380:2c20::47])
        by smtp.gmail.com with ESMTPSA id g4sm9695922qkk.104.2021.07.22.14.08.30
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 Jul 2021 14:08:30 -0700 (PDT)
Subject: Re: boot of J1900 (quad-core Celeron) mobo: kernel <= 5.12.15, OK;
 kernel >= 5.12.17, 5.13.4, slow boot (>> 660 secs) + hang/FAIL
From:   PGNet Dev <pgnet.dev@gmail.com>
To:     linux-kernel@vger.kernel.org
Reply-To: pgnet.dev@gmail.com
References: <eee39f4a-b929-3284-fa4b-a7174dd01321@gmail.com>
Message-ID: <971955a0-15d1-91ad-ae27-3bbaaf867bdb@gmail.com>
Date:   Thu, 22 Jul 2021 17:10:38 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <eee39f4a-b929-3284-fa4b-a7174dd01321@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

found/read: https://www.kernel.org/doc/html/latest/admin-guide/reporting-issues.html
mv'ing to:stable@vger.kernel.org + cc:regressions@lists.linux.dev
