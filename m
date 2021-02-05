Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 33C40310E6F
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Feb 2021 18:17:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233310AbhBEPck (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Feb 2021 10:32:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233162AbhBEP1h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Feb 2021 10:27:37 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BF96C0617AB
        for <linux-kernel@vger.kernel.org>; Fri,  5 Feb 2021 09:09:18 -0800 (PST)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1612544856;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=gQFB7dmw4+3vdRIHDm/XbDrP844LNmQuHfHCy0vCXm8=;
        b=ceEePKsGTssihu7M/4TE++AHEHeVu24gYxGrOsl0LMMhMcWiYpR7h0BGBGO0klDyWqvJdI
        Lhx/JZBnz91zgqE3C3Ce50beu1VwlAnL8Bv8DZA0Q8geShvgMDWdgVulTGL2N9oH2S8Ph8
        RAopcdemQNhU/NRlCMCEJBZ0xD0FHCltp4KtH/yIvZ0lp9BqVYUoFn7SWq4XC2ViTJJODZ
        XyhGFczUAACH34sY/bo1jSbl+rv2aart7CqbEyguMAE7JrSdZ6QaJFacBxh6YJlZ+bU3v3
        l2btkjgpEQWuPMwf5TrTEgCOBHaJhkDzavYy78MWbNsI8M4RzUrT8C/4nRaaTA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1612544856;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=gQFB7dmw4+3vdRIHDm/XbDrP844LNmQuHfHCy0vCXm8=;
        b=wM0sajUxZgHRLiJtsFCMwL/CxlynMJNfle78OWeSxk1mPb0j/5XzSyUJ/saZdlwgZoyoW/
        yJT4Zhw4MFC8ZvDg==
To:     Li RongQing <lirongqing@baidu.com>, linux-kernel@vger.kernel.org,
        john.stultz@linaro.org
Subject: Re: [PATCH] alarmtimer: Do not mess with an enqueued hrtimer
In-Reply-To: <1609997600-13503-1-git-send-email-lirongqing@baidu.com>
References: <1609997600-13503-1-git-send-email-lirongqing@baidu.com>
Date:   Fri, 05 Feb 2021 18:07:35 +0100
Message-ID: <87o8gy8mug.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 07 2021 at 13:33, Li RongQing wrote:
> when an hrtimer is enqueued already, its expires should be not
> changed, otherwise, this will corrupts the ordering of the
> timerqueue RB tree, if other hrtimer is enqueued before this
> hrtimer is restarted, whole RB tree is completely hosed
>
> Fixes: 6cffe00f7d4e ("alarmtimer: Add functions for timerfd support")

I can't see what this fixes. alarm_restart() is only invoked when the
alarm has expired which means that the timer _cannot_ be queued.

Thanks,

        tglx
