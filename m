Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8BC7A33ED5B
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Mar 2021 10:47:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229506AbhCQJqs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Mar 2021 05:46:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229884AbhCQJqW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Mar 2021 05:46:22 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCCD9C06174A
        for <linux-kernel@vger.kernel.org>; Wed, 17 Mar 2021 02:46:21 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id j4-20020a05600c4104b029010c62bc1e20so893001wmi.3
        for <linux-kernel@vger.kernel.org>; Wed, 17 Mar 2021 02:46:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=/dqJHapOI3bjlCJlze7gTCCUkWNP2k4Q72mCnMzvwE8=;
        b=UJ/7N6+jJNol2V0H/4pa7zu7d1qi+iE+s3nQTaVzHGJ6y3aBPk1Bd9Id7JKkAZRXS/
         zUMtByAj6EV0qT+2hseUCOeCSx7HrsTWbINtcUQuJoB0sHHnJyL19n2HqCNqeYNiMGSC
         zcxlpUzEHQ/kvBoGC69xWkSwdW7eYkEyV+JiKRb2Zpfbbv38WBp+9dm3JBqeaEYgVzpQ
         B56tHw8jhUrByUeU/XyM2Agth6ZEGNGeTUBwUFs5CdZqRjJyjNj1X/TmhKBbw+zckMEp
         ocfxzKyrF4QPk50EGj8h2W/nGLQ9X+o4kFthDL0SAoWHFINBoKLvNmmZNm5C/P61G6Z1
         YWsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=/dqJHapOI3bjlCJlze7gTCCUkWNP2k4Q72mCnMzvwE8=;
        b=sH6+VSf65JDHb8afYTJWfinOV3YX3X4j7Wd9ygD2Zg1Zp7z91E1MnJ+RiSB47oGX93
         +r3UkhHZ4jNZlHuCkTYTpU3Za+5w0lGeZlASOzUIJZjf8xABNJCMPc+EchnIFal8AJ3p
         cwGRPUvCYVNP2rNEG7PMTp8oLxtgsH0N5Py59eQZs+QGQAso1lWzRIGO/90JxIB2ukf9
         0rXfOOROhCDN6lknRHWA5FYScgGuJjMlcMp4AHlJQ5i7xzscuC1S1YH+tRFqBaMJ1HEd
         P2og4ChvEohVSXOyn0+TNxkgCecn+qeYQXWZw106O+43MQtYBBNSltdp7d4EeYlQWSFd
         OFKg==
X-Gm-Message-State: AOAM532uK3zZIEsxSZ06YA3anw9paB/6g22UfxeUFDtWCsxI/2kVSZE1
        NcLByxBHwJ+2OZsz1kFlZaM=
X-Google-Smtp-Source: ABdhPJxJKhNHbQUSc5H4PrI5HhjjA1x7tOt3Isfqemcsun8y7Vud90W3Baqh5dkM9tVGyCJ0Q6PtAw==
X-Received: by 2002:a7b:cc84:: with SMTP id p4mr2901117wma.10.1615974380596;
        Wed, 17 Mar 2021 02:46:20 -0700 (PDT)
Received: from gmail.com (54033286.catv.pool.telekom.hu. [84.3.50.134])
        by smtp.gmail.com with ESMTPSA id e1sm26215961wrd.44.2021.03.17.02.46.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Mar 2021 02:46:20 -0700 (PDT)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date:   Wed, 17 Mar 2021 10:46:18 +0100
From:   Ingo Molnar <mingo@kernel.org>
To:     Mike Galbraith <efault@gmx.de>
Cc:     Wang Qing <wangqing@vivo.com>, Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sched: swait: use wake_up_process() instead of
 wake_up_state()
Message-ID: <20210317094618.GA1724119@gmail.com>
References: <1615893602-22260-1-git-send-email-wangqing@vivo.com>
 <4cb1a9ae15c414435020630cf6362163ddda1550.camel@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4cb1a9ae15c414435020630cf6362163ddda1550.camel@gmx.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Mike Galbraith <efault@gmx.de> wrote:

> On Tue, 2021-03-16 at 19:20 +0800, Wang Qing wrote:
> > Why not just use wake_up_process().
> 
> IMO this is not an improvement.  There are other places where explicit
> TASK_NORMAL is used as well, and they're all perfectly clear as is.

Arguably those could all be converted to wake_up_process() as well. 
It's a very small kernel code size optimization. There's about 3 such 
places, could be converted in a single patch.

Thanks,

	Ingo
