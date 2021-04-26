Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8FC3D36BAAD
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Apr 2021 22:25:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241653AbhDZU0V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Apr 2021 16:26:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241079AbhDZU0V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Apr 2021 16:26:21 -0400
Received: from smtp.domeneshop.no (smtp.domeneshop.no [IPv6:2a01:5b40:0:3005::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58AFEC061574
        for <linux-kernel@vger.kernel.org>; Mon, 26 Apr 2021 13:25:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=skogtun.org
        ; s=ds202012; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
        MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=yWg+kSjcAZTMjwJzfE57VJKzYLPC2o6ukoeprW/SSYA=; b=F3k7+wVIISF1u8Ia71RKDs4F3X
        zcrKgVfIkMVxinEUX3dVvDocP1ZbbtwyCnqQ9WOlhnry139d2c+Xsm4VeyucZMQbLbV1Hd/T3kepr
        SucSeEVY5vv28Au4l6miuAkwJIxDWHIuRqiciEPeKonXUKtsnXfMvCgxiVme7nMC3Qd/cmKmJDxf9
        Ccz96jTrtmS17jBnGNFpfACC9OyVcWSTJzJFWrNOI1vxGLIqTzBeHeyn28DBjh5r3sfc6QTpIkFaO
        04wxLOaiPLWEwI9pkjPWP8JoVXhKpuTokYu7MYthY8yxFHllIA+fI8ulL6V6UfoMnWSfHN1F3Ughe
        J1uJe8Jg==;
Received: from [2a01:79c:cebf:7fb0::17] (port=39836)
        by smtp.domeneshop.no with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.92)
        (envelope-from <harald@skogtun.org>)
        id 1lb7nV-0003BE-Eu; Mon, 26 Apr 2021 22:25:37 +0200
Subject: Re: [BISECTED] 5.12 hangs at reboot
To:     Johannes Berg <johannes@sipsolutions.net>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <09464e67-f3de-ac09-28a3-e27b7914ee7d@skogtun.org>
 <CAHk-=wgA1Ma6e5qZO1EP9oMveLPJFbj=SC1R0ZewCmC-u0_r=A@mail.gmail.com>
 <34d778fa-343f-912f-2fd7-a8ba49bd1b95@skogtun.org>
 <54debab9a79df628cff86a637dde13c281001578.camel@sipsolutions.net>
 <CAHk-=wjvVMucgoAQKfi-x=jvYgKW1_LRmvnAfk3JGMkOSg9CQQ@mail.gmail.com>
 <2cafd6d0c6378b36644d04fe263a53a866354574.camel@sipsolutions.net>
 <CAHk-=wiwByiEUuO-NN=xHb4sxwCmP=tjB_vUHEebj8+-JGu8zg@mail.gmail.com>
 <bca302812cece1972bed7efe34a9d554b9e912ed.camel@sipsolutions.net>
From:   Harald Arnesen <harald@skogtun.org>
Message-ID: <f02ad718-654e-6e60-f199-4512b1afd1f4@skogtun.org>
Date:   Mon, 26 Apr 2021 22:25:36 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
MIME-Version: 1.0
In-Reply-To: <bca302812cece1972bed7efe34a9d554b9e912ed.camel@sipsolutions.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Johannes Berg [26.04.2021 22:11]:

> Oh, I have another idea - maybe void linux is using iwd instead of
> wpa_supplicant, and that insists on doing the netlink owner stuff so
> everything is deleted in case it crashes. But I've been looking at the
> code pretty much assuming that we get actual calls down, so ...

It is indeed using iwd:

$ ps ax | grep wpa
$
$ ps ax | grep iwd
  996 ?        Ss     0:00 runsv iwd
 1395 ?        S      0:00 /usr/libexec/iwd
$
-- 
Hilsen Harald
